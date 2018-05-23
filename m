Return-Path: <chunfeng.yun@mediatek.com>
X-Google-Smtp-Source: AB8JxZqL9RPz1XtnaHLooknwvHlCOkhR5RgDFxc8zuh1cpd//mLRgMNx1pdLlcofb7ipCxVL04Wh
ARC-Seal: i=1; a=rsa-sha256; t=1527065613; cv=none;
        d=google.com; s=arc-20160816;
        b=ekMpfpmlRz6ELJ4DibKGijR9ri5xGoYQ+WJi4E3gkir5Bm+xh4TBZvQL1ikWADOuil
         5nkgnMaz2ZV0lFVvPMaqJGq4qIqNhKSFS/DhVY2tr+g2hMElboOaRoo0oIJc83awe1nn
         RrSKt4CL5/gAG4vH9MFNeMlPvpYbdGsl4i7IfwDXNjdzi17qn+SDHcD8EEHO55+/5IvI
         eNnHrNsxoRn92ee9tZKthJOJaeyIk6AcXsWf0KKuUtg0QFdpwXjClOdjEzGeF+hKE/Xz
         LD53Y1wAVYCM2pqniXxFawDQRpM9fkzNUpxgI+dVM1gn20UHJ5GptLBws+wg7glU62o1
         +c0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=rjTqVo26c/QxYW1/IDzvNG1u3GK24Qx4tkqMUF3RSLM=;
        b=wwNgLwjB6ZA7700XqNECVmh3JumNusc4C1fsIEEXTbump5tU+3YRAxexvYVKI3gJ/s
         zW9g6B+posiAqlCekhEmPfkCZxFJn6UzOYsFtkB5MK5aflIwcUkiCW/nn0mDsbo1Ax2y
         JqVzsalyUiOxU/G9Yn1FkE7hCiG4fdecp9JZf4w4BSAZ/e4G5FI9/cAyJyF6+VIMMyhV
         KY3gSG/45cEdK4G//5ro7/GwWfBnMWPmJfRZ7BQXoE/blbeE15MqvQhl+LFKu2Sk6/rn
         NVn1OIBMsm3dcIJ/qQqBvlKD/VXV+VEXKRgZiYk9pgZqAYCpJ+L4MvyHh1d/nVdQOT9E
         SyjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of chunfeng.yun@mediatek.com designates 1.203.163.81 as permitted sender) smtp.mailfrom=chunfeng.yun@mediatek.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of chunfeng.yun@mediatek.com designates 1.203.163.81 as permitted sender) smtp.mailfrom=chunfeng.yun@mediatek.com
X-UUID: 9a98ca9f137647b0adbd6e07dcb2236f-20180523
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi
	<felipe.balbi@linux.intel.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>, Chunfeng Yun
	<chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [next, PATCH 6/6] usb: mtu3: fix warning of sleep in atomic context in notifier callback
Date: Wed, 23 May 2018 16:53:20 +0800
Message-ID: <3a030435197e69eca02f3565517a1cbccc33ac57.1527065109.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1291b13a362eaa0cccd30cb8dd4f56d33e1d172d.1527065109.git.chunfeng.yun@mediatek.com>
References: <1291b13a362eaa0cccd30cb8dd4f56d33e1d172d.1527065109.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601244353164079470?=
X-GMAIL-MSGID: =?utf-8?q?1601244353164079470?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The notifier callbacks of extcon are called in atomic context, but the
callbacks will call regulator_enable()/regulator_disable() which may
sleep caused by mutex, so use work queue to call the sleep functions.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3.h    | 11 ++++++++++-
 drivers/usb/mtu3/mtu3_dr.c | 44 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
index a56fee0..87823ac 100644
--- a/drivers/usb/mtu3/mtu3.h
+++ b/drivers/usb/mtu3/mtu3.h
@@ -196,7 +196,12 @@ struct mtu3_gpd_ring {
 * @vbus: vbus 5V used by host mode
 * @edev: external connector used to detect vbus and iddig changes
 * @vbus_nb: notifier for vbus detection
-* @vbus_nb: notifier for iddig(idpin) detection
+* @vbus_work : work of vbus detection notifier, used to avoid sleep in
+*		notifier callback which is atomic context
+* @vbus_event : event of vbus detecion notifier
+* @id_nb : notifier for iddig(idpin) detection
+* @id_work : work of iddig detection notifier
+* @id_event : event of iddig detecion notifier
 * @is_u3_drd: whether port0 supports usb3.0 dual-role device or not
 * @manual_drd_enabled: it's true when supports dual-role device by debugfs
 *		to switch host/device modes depending on user input.
@@ -205,7 +210,11 @@ struct otg_switch_mtk {
 	struct regulator *vbus;
 	struct extcon_dev *edev;
 	struct notifier_block vbus_nb;
+	struct work_struct vbus_work;
+	unsigned long vbus_event;
 	struct notifier_block id_nb;
+	struct work_struct id_work;
+	unsigned long id_event;
 	bool is_u3_drd;
 	bool manual_drd_enabled;
 };
diff --git a/drivers/usb/mtu3/mtu3_dr.c b/drivers/usb/mtu3/mtu3_dr.c
index 80083e0..8c3bbf7 100644
--- a/drivers/usb/mtu3/mtu3_dr.c
+++ b/drivers/usb/mtu3/mtu3_dr.c
@@ -174,16 +174,40 @@ static void ssusb_set_mailbox(struct otg_switch_mtk *otg_sx,
 	}
 }
 
-static int ssusb_id_notifier(struct notifier_block *nb,
-	unsigned long event, void *ptr)
+static void ssusb_id_work(struct work_struct *work)
 {
 	struct otg_switch_mtk *otg_sx =
-		container_of(nb, struct otg_switch_mtk, id_nb);
+		container_of(work, struct otg_switch_mtk, id_work);
 
-	if (event)
+	if (otg_sx->id_event)
 		ssusb_set_mailbox(otg_sx, MTU3_ID_GROUND);
 	else
 		ssusb_set_mailbox(otg_sx, MTU3_ID_FLOAT);
+}
+
+static void ssusb_vbus_work(struct work_struct *work)
+{
+	struct otg_switch_mtk *otg_sx =
+		container_of(work, struct otg_switch_mtk, vbus_work);
+
+	if (otg_sx->vbus_event)
+		ssusb_set_mailbox(otg_sx, MTU3_VBUS_VALID);
+	else
+		ssusb_set_mailbox(otg_sx, MTU3_VBUS_OFF);
+}
+
+/*
+ * @ssusb_id_notifier is called in atomic context, but @ssusb_set_mailbox
+ * may sleep, so use work queue here
+ */
+static int ssusb_id_notifier(struct notifier_block *nb,
+	unsigned long event, void *ptr)
+{
+	struct otg_switch_mtk *otg_sx =
+		container_of(nb, struct otg_switch_mtk, id_nb);
+
+	otg_sx->id_event = event;
+	schedule_work(&otg_sx->id_work);
 
 	return NOTIFY_DONE;
 }
@@ -194,10 +218,8 @@ static int ssusb_vbus_notifier(struct notifier_block *nb,
 	struct otg_switch_mtk *otg_sx =
 		container_of(nb, struct otg_switch_mtk, vbus_nb);
 
-	if (event)
-		ssusb_set_mailbox(otg_sx, MTU3_VBUS_VALID);
-	else
-		ssusb_set_mailbox(otg_sx, MTU3_VBUS_OFF);
+	otg_sx->vbus_event = event;
+	schedule_work(&otg_sx->vbus_work);
 
 	return NOTIFY_DONE;
 }
@@ -398,6 +420,9 @@ int ssusb_otg_switch_init(struct ssusb_mtk *ssusb)
 {
 	struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
 
+	INIT_WORK(&otg_sx->id_work, ssusb_id_work);
+	INIT_WORK(&otg_sx->vbus_work, ssusb_vbus_work);
+
 	if (otg_sx->manual_drd_enabled)
 		ssusb_debugfs_init(ssusb);
 	else
@@ -412,4 +437,7 @@ void ssusb_otg_switch_exit(struct ssusb_mtk *ssusb)
 
 	if (otg_sx->manual_drd_enabled)
 		ssusb_debugfs_exit(ssusb);
+
+	cancel_work_sync(&otg_sx->id_work);
+	cancel_work_sync(&otg_sx->vbus_work);
 }
-- 
1.9.1
