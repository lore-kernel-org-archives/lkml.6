Return-Path: <chunfeng.yun@mediatek.com>
X-Google-Smtp-Source: AB8JxZq5vhdW+s5116L5TZVjvdlJkeN1aizsK17PezcdUtwEaZlBU8Najb38uBrxJYon/ZLP5yL5
ARC-Seal: i=1; a=rsa-sha256; t=1527065638; cv=none;
        d=google.com; s=arc-20160816;
        b=PO2MW1E8i4PeSOP9H2EGKQE2zgcrjHS3Q+6XMwNIvlFGqh2aA7NB+l8TM0R2RUSX2w
         sB4oNVfiR9L6AzMXT1mPvcYSWeJZMfs+691nMvV8AylQc3eQz18VJajCEu9go8kVP67b
         IVEe/kI4H6JrTVQjcWOm4n1hQ3gu2zafFGmO8LymETNVrYPwJDfv8oGhetlDMqXM2C3N
         n+JFsBZugJQh+z0kPeA2atjE3I8/a3XsH79ErADYneMkyTH3RiwcIrNbEzqW9dAbCR6D
         2bWERcjfy1DJoV7871nPqOdXoK0YESe8wNQtUA9h4ot0gxEv5M36jxAbmLvYPmj/qUDi
         tqxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=je/h++EzoZGjEdlRWpUHZ1KifGm9E3rPJOqOXRzYDvQ=;
        b=jG4ihyhqPWOu1MxRjhrqcUE1V1NS0EzeGDOAiTy7XCbGRFEu6eIltB7UnwxvaLkXaO
         6VjnU/Bu/ZIDpTMI0MhnXWAjKdgjgiTFrnMz2uvKpVWgyrksxVWaIuz0gkh/o12keRu9
         aGggRSteM2SE1A6fqp4XmJOH8HJjXv+PmCGoBUlHRMuhM0PbKfgJffhxDtIPsYeisN19
         FaNyn/7G4npO3o0HHS7FPE3eFKVBZAIVEYPzzEEPC/E/pcpMgLgBjqAmD55TL6aJnlko
         xc44B7F2QyoNoXvEKzpwRFMPI6FF1Dl0e6v0vcKcnbqUZGMaSv1CnZYuuQvjenS2q6Vs
         9wug==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of chunfeng.yun@mediatek.com designates 1.203.163.78 as permitted sender) smtp.mailfrom=chunfeng.yun@mediatek.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of chunfeng.yun@mediatek.com designates 1.203.163.78 as permitted sender) smtp.mailfrom=chunfeng.yun@mediatek.com
X-UUID: e5cee852ca4543feb5db63c95b5b0af9-20180523
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi
	<felipe.balbi@linux.intel.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>, Chunfeng Yun
	<chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [next, PATCH 1/6] usb: mtu3: re-enable controller to accept LPM request after LPM resume
Date: Wed, 23 May 2018 16:53:15 +0800
Message-ID: <1291b13a362eaa0cccd30cb8dd4f56d33e1d172d.1527065109.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601244378966734632?=
X-GMAIL-MSGID: =?utf-8?q?1601244378966734632?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

After the controller receives a LPM request, it will reject the LPM
request, and need software to re-enable it after LPM resume if the
controller doesn't remote wakeup from L1 automatically

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index b1b99a8..65ff53a 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -176,7 +176,7 @@ static void mtu3_intr_enable(struct mtu3 *mtu)
 	mtu3_writel(mbase, U3D_LV1IESR, value);
 
 	/* Enable U2 common USB interrupts */
-	value = SUSPEND_INTR | RESUME_INTR | RESET_INTR;
+	value = SUSPEND_INTR | RESUME_INTR | RESET_INTR | LPM_RESUME_INTR;
 	mtu3_writel(mbase, U3D_COMMON_USB_INTR_ENABLE, value);
 
 	if (mtu->is_u3_ip) {
@@ -692,6 +692,12 @@ static irqreturn_t mtu3_u2_common_isr(struct mtu3 *mtu)
 	if (u2comm & RESET_INTR)
 		mtu3_gadget_reset(mtu);
 
+	if (u2comm & LPM_RESUME_INTR) {
+		if (!(mtu3_readl(mbase, U3D_POWER_MANAGEMENT) & LPM_HRWE))
+			mtu3_setbits(mbase, U3D_USB20_MISC_CONTROL,
+				     LPM_U3_ACK_EN);
+	}
+
 	return IRQ_HANDLED;
 }
 
-- 
1.9.1
