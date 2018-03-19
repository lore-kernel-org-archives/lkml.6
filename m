Return-Path: <mika.westerberg@linux.intel.com>
X-Google-Smtp-Source: AG47ELs7ZrtSAGJDU2ATiswuS1twef98RUKU8YzqCXjr4pZTLES7ysUcZessWmZ8cpwwUotTrltv
ARC-Seal: i=1; a=rsa-sha256; t=1521476829; cv=none;
        d=google.com; s=arc-20160816;
        b=KBwHwnboWhJ4N00p9MD4knCMrb6bj//vvb36zDi+E/799wIWSzMtLfboDEEMoRAE3j
         SmYeCrsmNENFH8Oycy6Lhb0km5keq+JJPpo0QlWS2HRfskiSewRFHHG1adG/MkvwVDti
         IuPkS4imhfDHo5OzgOTummdc3UjU1AYyUaBqTDfWjsd9SrJ1hRld/UOXOgbpRzhME54j
         gImFcvwtZFCskCRal3mFk9ENpeCoS+842dKevxNXzI9vhTocy1p1OFKjfnYnMLwVMlwW
         7rlplUpxA/wuZBOkbqQE2qr5Qh5T9oqcJi3fsb+XmMiX2opRoLiXIZxaeFzqXrdLPn/l
         yP2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=DI5uBS5qEJneZflNRiz6fb4l13170k/Pqa+B+wNnpOo=;
        b=GyRlA/jaODoJHpcImpjAOZFUeV8GAJ75NubuwgoOwqTptSsznV4IBwQLDjEriOJgtg
         rjNqqd+vV374lQ9xiMVfMVB319k+ujrF7HXLHJeZHqo5JQ6GlDCHhoSiXvyc+TEGkLsO
         Fn0ZMMe2KgOMrI8RNHXEX7/OwICffp6J2l4E58sHQ3D5l1VC8GV7S1ibwOa5BUNFtk2t
         fTWKHzy/9dNTc0w47f4VLm6v5bOBgAko6JXEHuWdwR1SZUMXqkCVwkdBrYYVkMyL3uP/
         i1fADTOM7JB7SQ57WTYIUhJXcL5FDuRkb+S4aJCbrMIjcc3aOysRaHaJ287gVJaQS1Ly
         2Reg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,331,1517904000";
   d="scan'208";a="36279897"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <yehezkel.bernat@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/19] thunderbolt: Handle rejected Thunderbolt devices
Date: Mon, 19 Mar 2018 19:26:51 +0300
Message-Id: <20180319162703.5331-8-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319162703.5331-1-mika.westerberg@linux.intel.com>
References: <20180319162703.5331-1-mika.westerberg@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595384088674305125?=
X-GMAIL-MSGID: =?utf-8?q?1595384088674305125?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The ICM firmware rejects devices if the maximum topology limit is
exceeded (more than 6 devices are connected). If that happens just log a
message to the kernel message buffer and bail out.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/thunderbolt/icm.c     | 6 ++++++
 drivers/thunderbolt/tb_msgs.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 611d28e8e5f2..6d7f8262f864 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -410,6 +410,12 @@ icm_fr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 		ICM_LINK_INFO_DEPTH_SHIFT;
 	authorized = pkg->link_info & ICM_LINK_INFO_APPROVED;
 
+	if (pkg->link_info & ICM_LINK_INFO_REJECTED) {
+		tb_info(tb, "switch at %u.%u was rejected by ICM firmware because topology limit exceeded\n",
+			link, depth);
+		return;
+	}
+
 	ret = icm->get_route(tb, link, depth, &route);
 	if (ret) {
 		tb_err(tb, "failed to find route string for switch at %u.%u\n",
diff --git a/drivers/thunderbolt/tb_msgs.h b/drivers/thunderbolt/tb_msgs.h
index b0a092baa605..476bc04cac6c 100644
--- a/drivers/thunderbolt/tb_msgs.h
+++ b/drivers/thunderbolt/tb_msgs.h
@@ -176,6 +176,7 @@ struct icm_fr_event_device_connected {
 #define ICM_LINK_INFO_DEPTH_SHIFT	4
 #define ICM_LINK_INFO_DEPTH_MASK	GENMASK(7, 4)
 #define ICM_LINK_INFO_APPROVED		BIT(8)
+#define ICM_LINK_INFO_REJECTED		BIT(9)
 
 struct icm_fr_pkg_approve_device {
 	struct icm_pkg_header hdr;
-- 
2.16.2
