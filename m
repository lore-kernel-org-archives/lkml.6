Return-Path: <chunfeng.yun@mediatek.com>
X-Google-Smtp-Source: ADUXVKIA0mMMhiPG0Gpa37AR7v6vrorUjPb+kq/sgR7Y4y8h5yVIAvotEpQebpkwsbJeg3Iyn7D/
ARC-Seal: i=1; a=rsa-sha256; t=1527065649; cv=none;
        d=google.com; s=arc-20160816;
        b=gB1Jcgo9HwFK2yo8xfUx3A2tOjvjOXwih+gtXgLGBMnn8eoq1J78KCDv8ktEh+XyRj
         +WMN4nK4ePJSOeiycI61i4jYF7nH5kEQ9Xd4merDFhrH7KkWs1KgDTPRkI8D4EWYnnBb
         CPzkfzeQBaSpn0ezo0NGz1cfKCRPNmmRvR15TToYJ7bRndEfDLTzALj+wviz/n7wRdXE
         pUog3/WdIxje7yz9oxvek2M8vaF70NzjNI4zm6enHFWfJ7py9fK1VyNCa+SfSE+t95wp
         ATm47tSoA+B5azTjvVJMWBD7jeSm7nOhSdicDFMRlvrzRyLf/7pLR8RAWmcLuMvmJulh
         yhNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=PvtT7WHXOQgA3chubpD84rYUp5l7fgOpZLwMBHnMTQ4=;
        b=oyrCWD5R9vVspuYCjbbEulRswFamCCHQcdXfwFsX+PIeR/t3mLv8YiTX7eMb3fenVT
         O55uFEliWvbYbG0pDINOgirEGKdf6zYhyEfPokzClvzl7x2lg7GwuTbG8aDj33dyngxt
         61mb3VULciCPFiMsPkbhDJ9Y95ou6/lUgQF495/r7H69p7iGbSrS3ljdqTVg44UJ9xY/
         uDNMpqq5f0qx6o5gAH2W8ZpNglcuz5NV4c5AKNR5IdSwNz0FniRiphPHWz7qpfo2j1Zj
         BATgVZKuIUxzJCbGfIW2SRAaUMbrFJX/tbbZ2ELCAizedgNEbHuMDlXyBAGSnIaHG8lj
         x6Eg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of chunfeng.yun@mediatek.com designates 1.203.163.78 as permitted sender) smtp.mailfrom=chunfeng.yun@mediatek.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of chunfeng.yun@mediatek.com designates 1.203.163.78 as permitted sender) smtp.mailfrom=chunfeng.yun@mediatek.com
X-UUID: 9071aead24b94873a88fe09b13929596-20180523
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi
	<felipe.balbi@linux.intel.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>, Chunfeng Yun
	<chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [next, PATCH 4/6] usb: mtu3: avoid sleep in atomic context when enter test mode
Date: Wed, 23 May 2018 16:53:18 +0800
Message-ID: <5c3f53fa72d8a4293051a3fc4f8ea9bc080d1c49.1527065109.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1291b13a362eaa0cccd30cb8dd4f56d33e1d172d.1527065109.git.chunfeng.yun@mediatek.com>
References: <1291b13a362eaa0cccd30cb8dd4f56d33e1d172d.1527065109.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601244390633296395?=
X-GMAIL-MSGID: =?utf-8?q?1601244390633296395?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use readl_poll_timeout_atomic() instead of readl_poll_timeout()
in atomic context

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_gadget_ep0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/mtu3/mtu3_gadget_ep0.c b/drivers/usb/mtu3/mtu3_gadget_ep0.c
index 0d2b1cf..25216e7 100644
--- a/drivers/usb/mtu3/mtu3_gadget_ep0.c
+++ b/drivers/usb/mtu3/mtu3_gadget_ep0.c
@@ -299,7 +299,7 @@ static int handle_test_mode(struct mtu3 *mtu, struct usb_ctrlrequest *setup)
 	mtu3_writel(mbase, U3D_EP0CSR, value | EP0_SETUPPKTRDY | EP0_DATAEND);
 
 	/* wait for ACK status sent by host */
-	readl_poll_timeout(mbase + U3D_EP0CSR, value,
+	readl_poll_timeout_atomic(mbase + U3D_EP0CSR, value,
 			!(value & EP0_DATAEND), 100, 5000);
 
 	mtu3_writel(mbase, U3D_USB2_TEST_MODE, mtu->test_mode_nr);
-- 
1.9.1
