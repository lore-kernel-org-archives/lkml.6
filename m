Return-Path: <mika.westerberg@linux.intel.com>
X-Google-Smtp-Source: AG47ELuWiqjcF3C2yy0zLGTTt6lCi5L9opJgL+XeRPZ2da7TVIJwqt44Hqxeo6A9hMsyU0Suzogg
ARC-Seal: i=1; a=rsa-sha256; t=1521476827; cv=none;
        d=google.com; s=arc-20160816;
        b=WuZUyKWcp7AGd8YyJjfRPIInhfdWRl6G5de1yPuKG1fUre1c1D/lJRIxD9rs4hvEyv
         Zlw7y++KsM83YMpbSx0coBU0DtMaBWXS93mFRc75FNJCBa+uOTBIK0sBVROzjn92X0iZ
         d0jX04VGBH9hlNSie3pb19gdwDRPpFQ9eZ4lbbzmNTKWHi1hsiV7eXn77F+y1drMw6KC
         F5p40QAiEF7eK8keBgzAYsIXp2X6tKNAL7ckWW/3tytzSvarBMLLD6GQLJXzuaz+V8MO
         /g3jxDIq0B/6BVm5jukgQtbjURSvZZUTbKPwd7UFzce0ebAlEGkZd16GF+63ZJXfjIyl
         Ly4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=iP5siBnaU20J68vJmy/egtrevdIyKC5/bS/GlWBjqbo=;
        b=LxvBazHAGvurX1v8+b7R3s/mPh5t8xtPReMageLLYipR5c4cDRgQjghWN41D77zvq9
         VCw+7MCsZVOdlgA+Y1aAHmKDdZI19pvCms9hJ44K4wWjwX/c4QsTQG8nnadmbgzUQ/3v
         /1Y3ryy8jH+vSByMRxFcA6qM8OH9Bjzif0htX7DtXmOlyk7J4l9C/r+HC9C9ymrkfSGg
         /0KqTJrEhvqSHaPRSmmJyyGKeyxcSmtvbJ+9plduXY0PhVMxacRTX9svv5bGYZ2bgG6V
         UxNY5lTulDxXHuS9A7nG+ljNqEozSzoQCRpgo45aWeaBWtbNNX2VsIbaAgAg1PQTOo1w
         dMeg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,331,1517904000";
   d="scan'208";a="35080661"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <yehezkel.bernat@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/19] thunderbolt: Handle connecting device in place of host properly
Date: Mon, 19 Mar 2018 19:26:47 +0300
Message-Id: <20180319162703.5331-4-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319162703.5331-1-mika.westerberg@linux.intel.com>
References: <20180319162703.5331-1-mika.westerberg@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595384085747857742?=
X-GMAIL-MSGID: =?utf-8?q?1595384085747857742?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If the system is suspended and user disconnects cable to another host
and connects it to a Thunderbolt device instead we get a warning from
driver core about adding duplicate sysfs attribute and adding the new
device fails.

Handle this properly so that we first remove the existing XDomain
connection before adding new devices.

Fixes: d1ff70241a27 ("thunderbolt: Add support for XDomain discovery protocol")
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/thunderbolt/icm.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index ab02d13f40b7..182226023acb 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -383,6 +383,15 @@ static void remove_switch(struct tb_switch *sw)
 	tb_switch_remove(sw);
 }
 
+static void remove_xdomain(struct tb_xdomain *xd)
+{
+	struct tb_switch *sw;
+
+	sw = tb_to_switch(xd->dev.parent);
+	tb_port_at(xd->route, sw)->xdomain = NULL;
+	tb_xdomain_remove(xd);
+}
+
 static void
 icm_fr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 {
@@ -391,6 +400,7 @@ icm_fr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 	struct tb_switch *sw, *parent_sw;
 	struct icm *icm = tb_priv(tb);
 	bool authorized = false;
+	struct tb_xdomain *xd;
 	u8 link, depth;
 	u64 route;
 	int ret;
@@ -467,6 +477,13 @@ icm_fr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 		tb_switch_put(sw);
 	}
 
+	/* Remove existing XDomain connection if found */
+	xd = tb_xdomain_find_by_link_depth(tb, link, depth);
+	if (xd) {
+		remove_xdomain(xd);
+		tb_xdomain_put(xd);
+	}
+
 	parent_sw = tb_switch_find_by_link_depth(tb, link, depth - 1);
 	if (!parent_sw) {
 		tb_err(tb, "failed to find parent switch for %u.%u\n",
@@ -529,15 +546,6 @@ icm_fr_device_disconnected(struct tb *tb, const struct icm_pkg_header *hdr)
 	tb_switch_put(sw);
 }
 
-static void remove_xdomain(struct tb_xdomain *xd)
-{
-	struct tb_switch *sw;
-
-	sw = tb_to_switch(xd->dev.parent);
-	tb_port_at(xd->route, sw)->xdomain = NULL;
-	tb_xdomain_remove(xd);
-}
-
 static void
 icm_fr_xdomain_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 {
-- 
2.16.2
