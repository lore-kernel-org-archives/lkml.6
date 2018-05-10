Return-Path: <phil.edworthy@renesas.com>
X-Google-Smtp-Source: AB8JxZq5kPMfwKMtSeeqtONvWi9uzBtw4DC/2zd11+KibkhzefoGocteulTD77j6TO8Ld7U9+/Ud
ARC-Seal: i=1; a=rsa-sha256; t=1525957755; cv=none;
        d=google.com; s=arc-20160816;
        b=EsAEw1lBWPKCUNHkcUgaQrQjUGZRW/mzfg2U/UpN6L20Q0ezX+YXzpYBqVmxtXwD0Y
         fGKh+7qFuliDUtDnKToiF5FEFl0ZVs9fAwPo+c6wv56JYIN5TN66yJdQpqY+rvPNGePm
         pG8UELks6qomvTs74ZVrYoam4PNzv/IyYOPIOmAfcw4wzUz78QkXUeEDyY+POrjaqErf
         fw9x5VfYX8FzQGNTyx7kNuYE21++cggHL7+/TMSvgCO8w6F+aoa+EnfTiGKUj31gdfxV
         PN75nO4ktXObpvkNkzYUCr1XR/AaWJ4yKJYzN9pGQi/Q3CrN+zlq2JPgtUAgboIvJubY
         1rxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=e/vAj+55ojTz5F35GxGVTxQnJCbaR+X+hdhffEPnlDA=;
        b=w5pnikqkYFX2diJQL+iuQqO6XQyMLdcOeiasVLgQqEkvPZ8wyrDmY3VDmDdbEN1cl9
         aIz1YuP3bsNdBvEgjn4oUj8i+zr2dMkboskZI6oKbaClKvXe6U1aGSNj1BLXo68azyg2
         D50N8r4m/Pq9Mhend7MnjzEaaZX0oD/en4J82MeatDwGTJ9hNzSrBK1U3XWhKa2d37rX
         2BUkziurS7r8BpI+ZIDPyCZDLvR0d0xfg+kPh4KiTFuAVDQLgEVKlHbx/wqCSf8v5bSc
         ifNfpuZjCQ8aiDPQsfeBsFaV9QGbspiCLZ8guvYuH+nHIeH7gKECSh0IxB1bDtS5/795
         s1zQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of phil.edworthy@renesas.com designates 210.160.252.173 as permitted sender) smtp.mailfrom=phil.edworthy@renesas.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of phil.edworthy@renesas.com designates 210.160.252.173 as permitted sender) smtp.mailfrom=phil.edworthy@renesas.com
X-IronPort-AV: E=Sophos;i="5.49,385,1520866800";
   d="scan'208";a="279162566"
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Nazarewicz <mina86@mina86.com>,
	Michel Pollet <michel.pollet@bp.renesas.com>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] USB: rndis: Fix for handling garbled messages
Date: Thu, 10 May 2018 14:09:09 +0100
Message-Id: <1525957749-5391-1-git-send-email-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600082679809865193?=
X-GMAIL-MSGID: =?utf-8?q?1600082679809865193?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Michel Pollet <michel.pollet@bp.renesas.com>

A message can be forged to crash the stack; here we make sure we don't
completely break the system if this occurs

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
---
 drivers/usb/gadget/function/rndis.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/function/rndis.c b/drivers/usb/gadget/function/rndis.c
index 51dd3e9..04c142c 100644
--- a/drivers/usb/gadget/function/rndis.c
+++ b/drivers/usb/gadget/function/rndis.c
@@ -851,6 +851,9 @@ int rndis_msg_parser(struct rndis_params *params, u8 *buf)
 		 */
 		pr_warn("%s: unknown RNDIS message 0x%08X len %d\n",
 			__func__, MsgType, MsgLength);
+		/* Garbled message can be huge, so limit what we display */
+		if (MsgLength > 16)
+			MsgLength = 16;
 		print_hex_dump_bytes(__func__, DUMP_PREFIX_OFFSET,
 				     buf, MsgLength);
 		break;
-- 
2.7.4
