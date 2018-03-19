Return-Path: <mika.westerberg@linux.intel.com>
X-Google-Smtp-Source: AG47ELuSK6IFJrvnpzvdrW08/cWxhSbwP/rJWbYBHeS26l55sSQp/YvyUBddV1J4DdhBH7sHhSf0
ARC-Seal: i=1; a=rsa-sha256; t=1521476831; cv=none;
        d=google.com; s=arc-20160816;
        b=rNKv8Xip7+7t0O/3NUHxkHSDdHfVZRCOUXPxwDpkd7STRpEbFshkCAIHSm8QKYRmdz
         4kxzUqkb7t1iTvFPIg2sNUjVM3swpr/5CtyKkmNjhE0rblISK+AEbDXkTZST+mnWmqPZ
         UumWrlqMqVDwEYRY4EgXo42jteE+9VfdG7l7u2DWDtzdMpMAQLFGRN35d50x2EfIhakE
         N82tWtDIMrnc5v+ngIkPekK5rEPsrWfz5SIWyw+SwSsokUANk8QFe3Cx5eJT7AXj1Ty0
         fy4wf/hZYoQNBMSMqXUdfAbUvrZ8wwhEDh8Ua8S00st15NScvIwgK/b5vUBVb02A+j93
         xhWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Kht4ShyV0XK4WYs57pfuUKZ4JGRLSFOSXgsL03tnR1c=;
        b=V8Rw6Q/kmRHgF0MFWRVWEkyNinCHlrxgqlMKOqE7+3Gn/WacTeu+eePFD3SZHhZRQX
         7yLrQMxSxZnOZoLl8V1BewYda6P/xTl7sabORgsrjwo9mIl2loHrfEyGPwL9aGZHe4Rg
         CYaIJwQj84PYak98gvHH837isbf0CuMw3lN4nW0kB/d491ceKxztODrcGZ4P8A4KZLzB
         20wwEERMLNUiuGb28japCYvpyN1YTVGnZbG4ExHjyzd6W03OfTcN6cqTTSPB67CHNyQ2
         0iRUl4a/zh0nrTgkCiFL5hs833FglYA2TVloqcVcdKfICyENgcT++Z5/C8BnsTf57RIl
         lBCg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,331,1517904000";
   d="scan'208";a="212938679"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <yehezkel.bernat@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Radion Mirchevsky <radion.mirchevsky@intel.com>
Subject: [PATCH 12/19] thunderbolt: Add tb_xdomain_find_by_route()
Date: Mon, 19 Mar 2018 19:26:56 +0300
Message-Id: <20180319162703.5331-13-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319162703.5331-1-mika.westerberg@linux.intel.com>
References: <20180319162703.5331-1-mika.westerberg@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595384089934768410?=
X-GMAIL-MSGID: =?utf-8?q?1595384089934768410?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Radion Mirchevsky <radion.mirchevsky@intel.com>

This is needed by the new ICM interface to find xdomains by route string
instead of link and depth.

While there update existing tb_xdomain_find_* functions to use
tb_xdomain_get() instead of open-coding the same.

Signed-off-by: Radion Mirchevsky <radion.mirchevsky@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/thunderbolt/xdomain.c | 47 ++++++++++++++++++++++++++++++++-----------
 include/linux/thunderbolt.h   | 13 ++++++++++++
 2 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index f25d88d4552b..8abb4e843085 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -1255,6 +1255,7 @@ struct tb_xdomain_lookup {
 	const uuid_t *uuid;
 	u8 link;
 	u8 depth;
+	u64 route;
 };
 
 static struct tb_xdomain *switch_find_xdomain(struct tb_switch *sw,
@@ -1275,9 +1276,13 @@ static struct tb_xdomain *switch_find_xdomain(struct tb_switch *sw,
 			if (lookup->uuid) {
 				if (uuid_equal(xd->remote_uuid, lookup->uuid))
 					return xd;
-			} else if (lookup->link == xd->link &&
+			} else if (lookup->link &&
+				   lookup->link == xd->link &&
 				   lookup->depth == xd->depth) {
 				return xd;
+			} else if (lookup->route &&
+				   lookup->route == xd->route) {
+				return xd;
 			}
 		} else if (port->remote) {
 			xd = switch_find_xdomain(port->remote->sw, lookup);
@@ -1313,12 +1318,7 @@ struct tb_xdomain *tb_xdomain_find_by_uuid(struct tb *tb, const uuid_t *uuid)
 	lookup.uuid = uuid;
 
 	xd = switch_find_xdomain(tb->root_switch, &lookup);
-	if (xd) {
-		get_device(&xd->dev);
-		return xd;
-	}
-
-	return NULL;
+	return tb_xdomain_get(xd);
 }
 EXPORT_SYMBOL_GPL(tb_xdomain_find_by_uuid);
 
@@ -1349,13 +1349,36 @@ struct tb_xdomain *tb_xdomain_find_by_link_depth(struct tb *tb, u8 link,
 	lookup.depth = depth;
 
 	xd = switch_find_xdomain(tb->root_switch, &lookup);
-	if (xd) {
-		get_device(&xd->dev);
-		return xd;
-	}
+	return tb_xdomain_get(xd);
+}
 
-	return NULL;
+/**
+ * tb_xdomain_find_by_route() - Find an XDomain by route string
+ * @tb: Domain where the XDomain belongs to
+ * @route: XDomain route string
+ *
+ * Finds XDomain by walking through the Thunderbolt topology below @tb.
+ * The returned XDomain will have its reference count increased so the
+ * caller needs to call tb_xdomain_put() when it is done with the
+ * object.
+ *
+ * This will find all XDomains including the ones that are not yet added
+ * to the bus (handshake is still in progress).
+ *
+ * The caller needs to hold @tb->lock.
+ */
+struct tb_xdomain *tb_xdomain_find_by_route(struct tb *tb, u64 route)
+{
+	struct tb_xdomain_lookup lookup;
+	struct tb_xdomain *xd;
+
+	memset(&lookup, 0, sizeof(lookup));
+	lookup.route = route;
+
+	xd = switch_find_xdomain(tb->root_switch, &lookup);
+	return tb_xdomain_get(xd);
 }
+EXPORT_SYMBOL_GPL(tb_xdomain_find_by_route);
 
 bool tb_xdomain_handle_request(struct tb *tb, enum tb_cfg_pkg_type type,
 			       const void *buf, size_t size)
diff --git a/include/linux/thunderbolt.h b/include/linux/thunderbolt.h
index 7b69853188b1..27b9be34d4b9 100644
--- a/include/linux/thunderbolt.h
+++ b/include/linux/thunderbolt.h
@@ -237,6 +237,7 @@ int tb_xdomain_enable_paths(struct tb_xdomain *xd, u16 transmit_path,
 			    u16 receive_ring);
 int tb_xdomain_disable_paths(struct tb_xdomain *xd);
 struct tb_xdomain *tb_xdomain_find_by_uuid(struct tb *tb, const uuid_t *uuid);
+struct tb_xdomain *tb_xdomain_find_by_route(struct tb *tb, u64 route);
 
 static inline struct tb_xdomain *
 tb_xdomain_find_by_uuid_locked(struct tb *tb, const uuid_t *uuid)
@@ -250,6 +251,18 @@ tb_xdomain_find_by_uuid_locked(struct tb *tb, const uuid_t *uuid)
 	return xd;
 }
 
+static inline struct tb_xdomain *
+tb_xdomain_find_by_route_locked(struct tb *tb, u64 route)
+{
+	struct tb_xdomain *xd;
+
+	mutex_lock(&tb->lock);
+	xd = tb_xdomain_find_by_route(tb, route);
+	mutex_unlock(&tb->lock);
+
+	return xd;
+}
+
 static inline struct tb_xdomain *tb_xdomain_get(struct tb_xdomain *xd)
 {
 	if (xd)
-- 
2.16.2
