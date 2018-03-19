Return-Path: <mika.westerberg@linux.intel.com>
X-Google-Smtp-Source: AG47ELtIpwCtzGG2EIqkf5zSU4Q/BhTlTip0VoWgufXqGeaO7JqDuIbMWK5B/baFS5qtLp2fuHEb
ARC-Seal: i=1; a=rsa-sha256; t=1521476830; cv=none;
        d=google.com; s=arc-20160816;
        b=TX4uO5uf6WQ4bvgb6Ixr+DD4nDnZmnNwaysCOeypT3DfWOzZyLX8HEaT/XtVFpqGIn
         MdR22b3fVkQ/R76hHERrHhqplwxJl4PCGmqfn2Xmoj9jICwHaZCE9H5nombMaNUROWuu
         WF7Xw46YgJWzUaqgScy9wTpo8WUkE0loTKz3tKOxzTnAcot+/fmRS6qYaaqiuHUZdglL
         +uEeEPVqcri/wBIsiuvYnwe+ALVVPZQC2vdiR1IZGmtDslh0TwsN2j+Of3ujOdlqZ82F
         +NgADIvqCHeP3FkY03Bi7ySGNdq+UbxCyzm3O+EMT4olP7UE8KO8UDRwV6AF6CAzMwVE
         gzKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=GevcRRd46oJTx8vGocCcdBYAFgr/oc89DhlSLFlCl/0=;
        b=DccDqKoKgCNq1EatFtXxoF0ig0oyIa002YMb5Tu2yZHj4gcO+19nJ8yTJQbkclXxDi
         Wv4iyLcXe8QfHO3RZJd4cgxuf/qWtmk5Uv4gHLyJC2TMryZt82xNOmTEzCcQKBy+FYRg
         HJe1CvcTbTPLlmCHqL1O5sCi44YDpUlrXciYQQInDFe/ay2QDtrK6kmw+BPb9I/yQiR3
         w0BCKeDhsXifJ3lc10hbb7niFZ+2VcoFTQBEwkfX4IeduiAhmPdgN3noYZOuX2sLrjt5
         8nZvfaujDlbcLV6jR2FIrWF4QCoU83Bb1UioSkX3GsQeKF7ztF6CHyNkrwRCmKtglzvw
         /arA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,331,1517904000";
   d="scan'208";a="212938676"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <yehezkel.bernat@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/19] thunderbolt: Factor common ICM add and update operations out
Date: Mon, 19 Mar 2018 19:26:52 +0300
Message-Id: <20180319162703.5331-9-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319162703.5331-1-mika.westerberg@linux.intel.com>
References: <20180319162703.5331-1-mika.westerberg@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595384089779162503?=
X-GMAIL-MSGID: =?utf-8?q?1595384089779162503?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The newer ICM will not use link and depth to address devices. Instead it
uses route strings. In order to take advantage of the existing code
factor out common operations so that we can use the same functions with
the new ICM as well.

No functional changes intended.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/thunderbolt/icm.c | 136 +++++++++++++++++++++++++++++-----------------
 1 file changed, 87 insertions(+), 49 deletions(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 6d7f8262f864..6798516d6474 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -374,6 +374,57 @@ static int icm_fr_disconnect_xdomain_paths(struct tb *tb, struct tb_xdomain *xd)
 	return 0;
 }
 
+static void add_switch(struct tb_switch *parent_sw, u64 route,
+		       const uuid_t *uuid, u8 connection_id, u8 connection_key,
+		       u8 link, u8 depth, enum tb_security_level security_level,
+		       bool authorized)
+{
+	struct tb_switch *sw;
+
+	sw = tb_switch_alloc(parent_sw->tb, &parent_sw->dev, route);
+	if (!sw)
+		return;
+
+	sw->uuid = kmemdup(uuid, sizeof(*uuid), GFP_KERNEL);
+	sw->connection_id = connection_id;
+	sw->connection_key = connection_key;
+	sw->link = link;
+	sw->depth = depth;
+	sw->authorized = authorized;
+	sw->security_level = security_level;
+
+	/* Link the two switches now */
+	tb_port_at(route, parent_sw)->remote = tb_upstream_port(sw);
+	tb_upstream_port(sw)->remote = tb_port_at(route, parent_sw);
+
+	if (tb_switch_add(sw)) {
+		tb_port_at(tb_route(sw), parent_sw)->remote = NULL;
+		tb_switch_put(sw);
+		return;
+	}
+}
+
+static void update_switch(struct tb_switch *parent_sw, struct tb_switch *sw,
+			  u64 route, u8 connection_id, u8 connection_key,
+			  u8 link, u8 depth)
+{
+	/* Disconnect from parent */
+	tb_port_at(tb_route(sw), parent_sw)->remote = NULL;
+	/* Re-connect via updated port*/
+	tb_port_at(route, parent_sw)->remote = tb_upstream_port(sw);
+
+	/* Update with the new addressing information */
+	sw->config.route_hi = upper_32_bits(route);
+	sw->config.route_lo = lower_32_bits(route);
+	sw->connection_id = connection_id;
+	sw->connection_key = connection_key;
+	sw->link = link;
+	sw->depth = depth;
+
+	/* This switch still exists */
+	sw->is_unplugged = false;
+}
+
 static void remove_switch(struct tb_switch *sw)
 {
 	struct tb_switch *parent_sw;
@@ -383,6 +434,31 @@ static void remove_switch(struct tb_switch *sw)
 	tb_switch_remove(sw);
 }
 
+static void add_xdomain(struct tb_switch *sw, u64 route,
+			const uuid_t *local_uuid, const uuid_t *remote_uuid,
+			u8 link, u8 depth)
+{
+	struct tb_xdomain *xd;
+
+	xd = tb_xdomain_alloc(sw->tb, &sw->dev, route, local_uuid, remote_uuid);
+	if (!xd)
+		return;
+
+	xd->link = link;
+	xd->depth = depth;
+
+	tb_port_at(route, sw)->xdomain = xd;
+
+	tb_xdomain_add(xd);
+}
+
+static void update_xdomain(struct tb_xdomain *xd, u64 route, u8 link)
+{
+	xd->link = link;
+	xd->route = route;
+	xd->is_unplugged = false;
+}
+
 static void remove_xdomain(struct tb_xdomain *xd)
 {
 	struct tb_switch *sw;
@@ -397,6 +473,7 @@ icm_fr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 {
 	const struct icm_fr_event_device_connected *pkg =
 		(const struct icm_fr_event_device_connected *)hdr;
+	enum tb_security_level security_level;
 	struct tb_switch *sw, *parent_sw;
 	struct icm *icm = tb_priv(tb);
 	bool authorized = false;
@@ -409,6 +486,8 @@ icm_fr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 	depth = (pkg->link_info & ICM_LINK_INFO_DEPTH_MASK) >>
 		ICM_LINK_INFO_DEPTH_SHIFT;
 	authorized = pkg->link_info & ICM_LINK_INFO_APPROVED;
+	security_level = (pkg->hdr.flags & ICM_FLAGS_SLEVEL_MASK) >>
+			 ICM_FLAGS_SLEVEL_SHIFT;
 
 	if (pkg->link_info & ICM_LINK_INFO_REJECTED) {
 		tb_info(tb, "switch at %u.%u was rejected by ICM firmware because topology limit exceeded\n",
@@ -441,16 +520,8 @@ icm_fr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 		 */
 		if (sw->depth == depth && sw_phy_port == phy_port &&
 		    !!sw->authorized == authorized) {
-			tb_port_at(tb_route(sw), parent_sw)->remote = NULL;
-			tb_port_at(route, parent_sw)->remote =
-				   tb_upstream_port(sw);
-			sw->config.route_hi = upper_32_bits(route);
-			sw->config.route_lo = lower_32_bits(route);
-			sw->connection_id = pkg->connection_id;
-			sw->connection_key = pkg->connection_key;
-			sw->link = link;
-			sw->depth = depth;
-			sw->is_unplugged = false;
+			update_switch(parent_sw, sw, route, pkg->connection_id,
+				      pkg->connection_key, link, depth);
 			tb_switch_put(sw);
 			return;
 		}
@@ -497,30 +568,10 @@ icm_fr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 		return;
 	}
 
-	sw = tb_switch_alloc(tb, &parent_sw->dev, route);
-	if (!sw) {
-		tb_switch_put(parent_sw);
-		return;
-	}
+	add_switch(parent_sw, route, &pkg->ep_uuid, pkg->connection_id,
+		   pkg->connection_key, link, depth, security_level,
+		   authorized);
 
-	sw->uuid = kmemdup(&pkg->ep_uuid, sizeof(pkg->ep_uuid), GFP_KERNEL);
-	sw->connection_id = pkg->connection_id;
-	sw->connection_key = pkg->connection_key;
-	sw->link = link;
-	sw->depth = depth;
-	sw->authorized = authorized;
-	sw->security_level = (pkg->hdr.flags & ICM_FLAGS_SLEVEL_MASK) >>
-				ICM_FLAGS_SLEVEL_SHIFT;
-
-	/* Link the two switches now */
-	tb_port_at(route, parent_sw)->remote = tb_upstream_port(sw);
-	tb_upstream_port(sw)->remote = tb_port_at(route, parent_sw);
-
-	ret = tb_switch_add(sw);
-	if (ret) {
-		tb_port_at(tb_route(sw), parent_sw)->remote = NULL;
-		tb_switch_put(sw);
-	}
 	tb_switch_put(parent_sw);
 }
 
@@ -591,9 +642,7 @@ icm_fr_xdomain_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 		phy_port = phy_port_from_route(route, depth);
 
 		if (xd->depth == depth && xd_phy_port == phy_port) {
-			xd->link = link;
-			xd->route = route;
-			xd->is_unplugged = false;
+			update_xdomain(xd, route, link);
 			tb_xdomain_put(xd);
 			return;
 		}
@@ -643,19 +692,8 @@ icm_fr_xdomain_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 		return;
 	}
 
-	xd = tb_xdomain_alloc(sw->tb, &sw->dev, route,
-			      &pkg->local_uuid, &pkg->remote_uuid);
-	if (!xd) {
-		tb_switch_put(sw);
-		return;
-	}
-
-	xd->link = link;
-	xd->depth = depth;
-
-	tb_port_at(route, sw)->xdomain = xd;
-
-	tb_xdomain_add(xd);
+	add_xdomain(sw, route, &pkg->local_uuid, &pkg->remote_uuid, link,
+		    depth);
 	tb_switch_put(sw);
 }
 
-- 
2.16.2
