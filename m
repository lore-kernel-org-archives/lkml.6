Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751333AbeCLLfo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 07:35:44 -0400
Received: from mout.web.de ([212.227.15.4]:52659 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750752AbeCLLfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 07:35:43 -0400
Subject: [PATCH 5/5] Bluetooth: btmrvl: Use common error handling code in
 btmrvl_sdio_download_fw_w_helper()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <8d050f76-aed1-7b6b-8778-a78aef34d4ea@users.sourceforge.net>
Message-ID: <a3f4f205-dbda-c1dc-6ca6-506d44e20615@users.sourceforge.net>
Date: Mon, 12 Mar 2018 12:35:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <8d050f76-aed1-7b6b-8778-a78aef34d4ea@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:wnFjPi1ir689Oqgy2H7548VvT/XyP0aLPnzyS7w2pvy6FNvxl2c
 t8ozPoV0iLern9UntEDrTtl5CHBXfnTaSMpvfk5UsPn05GwKbikIku9rFvT/137J+XUAPVw
 wHH0roqduaSfbiPCRdl/bGROsIGeWwJfdz4C/bmZp/Nr4GpcBIxiTlARadEAuvIU09Xcgvp
 TRmA3x1mrexS3WPwAWvGA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5fFzDX0hkIQ=:27lCuHYkLpc4m5AKnyctgb
 xA596gT1Jo3hYGXvTlQOC2eruiDwGkyTi53bsAJw7HhIhEZu3jsItlO3KOTQJSDZMkN4qYIln
 j7DKpv0RByrn0j2GFcaIqnuU5TXXW9bgbWfkRoyjF6+oFBMcMYopD0ZiVk2guzcBBS/uu2v94
 P/olYYWotBaI2lTtoXjs4Y2/yC9B96Rw+Br1Hnx8fYnpkwOEoOGpty/s89Fde1ytY1G+H0unD
 FsxhKfCo+NcR87bLjQ4kGy6CRA1X5pRDQhQ/WEe8ha9jYsMJdAHrLeAjpSh1CQ/AZyQCD82Nj
 DqKW3b+UcuKIz8efLuN7pzE8eYZAdv6k+L+DcGjpi1bPchlnPGRV3p/9hwusJksPRYmtIYJWL
 auETJJn/U5wU3mhdxyzBJvNcOB9jEg5tGMyQ5LlfUXaCzh0+rOMRUNVIZNliU0UK++aYIIl4A
 UYLJeDDyCpVy7GUTI2xh/IWMr5O3+gq/igj6vzkWHlcw0Irb2XQj86/yGNismwvcf00F5j0ql
 ojwrVSMjmtz6WCCGWeXrSlswI7AJDKZHj3xuTOmZYS2uV1eS/sQQRMXKBG/3IyztNkGpgPA2F
 3yBQ1+upzCQeXeDKpOaYhwERUXA9MFwgwubmz2s2s2M/t92QfEMN8khCwhCNeGACS1tShWIUU
 oZoGHdFklj7dlsPDrePeIFZKKnPLDdllB7qOGIcsaFo/ItWIFPHtHjlAhx4y7pUf+QtcHWMmI
 rPfV0oNaWtq3oFxjEkIq4wqIIEugyj4vNL16cH1ZCJ1SHIfgXGwoxILX5ErWAM+P775GXi6D7
 gIIXFQjDMsIPpczc31kKlfjBMnGsGUzdw0haVsfFGGOE+kNKSU=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 12 Mar 2018 11:30:28 +0100

Add a jump target so that the setting of a specific error code is stored
only once at the end of this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/bluetooth/btmrvl_sdio.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 05c78fcc13ff..24ed62fe2aeb 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -601,8 +601,7 @@ static int btmrvl_sdio_download_fw_w_helper(struct btmrvl_sdio_card *card)
 					" base0 = 0x%04X(%d)."
 					" Terminating download",
 					base0, base0);
-				ret = -EIO;
-				goto done;
+				goto e_io;
 			}
 			base1 = sdio_readb(card->func,
 					card->reg->sq_read_base_addr_a1, &ret);
@@ -611,8 +610,7 @@ static int btmrvl_sdio_download_fw_w_helper(struct btmrvl_sdio_card *card)
 					" base1 = 0x%04X(%d)."
 					" Terminating download",
 					base1, base1);
-				ret = -EIO;
-				goto done;
+				goto e_io;
 			}
 
 			len = (((u16) base1) << 8) | base0;
@@ -638,8 +636,7 @@ static int btmrvl_sdio_download_fw_w_helper(struct btmrvl_sdio_card *card)
 			if (count > MAX_WRITE_IOMEM_RETRY) {
 				BT_ERR("FW download failure @%d, "
 					"over max retry count", offset);
-				ret = -EIO;
-				goto done;
+				goto e_io;
 			}
 			BT_ERR("FW CRC error indicated by the helper: "
 				"len = 0x%04X, txlen = %d", len, txlen);
@@ -681,6 +678,10 @@ static int btmrvl_sdio_download_fw_w_helper(struct btmrvl_sdio_card *card)
 	kfree(tmpfwbuf);
 	release_firmware(fw_firmware);
 	return ret;
+
+e_io:
+	ret = -EIO;
+	goto done;
 }
 
 static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
-- 
2.16.2
