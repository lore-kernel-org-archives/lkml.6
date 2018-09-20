Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59D4C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD302150F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="niQcFyMd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD302150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387647AbeITXsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:48:09 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39741 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731592AbeITXsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:48:08 -0400
Received: by mail-pl1-f195.google.com with SMTP id w14-v6so4705770plp.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 11:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vlmg6TOvVWKcQtBRRE7ziSBiTYlrof+G8TlpUsVBf9I=;
        b=niQcFyMdSAQSFDEvfIFDbQpDLTnRPvKVlIDEdnfo8b95235O9VX9myrtx/+NenaGV3
         L852WVTMbmjyqt1qACVs3vAuJjdb220y1nlCsvRRTyhfsGj1dFiyw84DJv7rjhx09ua6
         9k9chpZ4ouTGHQuyTol5/Ua9Qm73kYj5aQUcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vlmg6TOvVWKcQtBRRE7ziSBiTYlrof+G8TlpUsVBf9I=;
        b=cCIIT3kn5PhybRNYX1FsZAV1ZU7GDswZSLWJ1cD7COYJD2MkJQugZwn0vWtnNEP2tA
         FJGNbpk/DDhv66eSlut62e8BYj8F2480tl0+aqKdPc6XOofcHW9Gy3GdfnICuMZi9x8x
         3qEbL/mgU0R9YwZamSYNh/yHKaWkKt8ylf1xJ7pANCelmQOZLgu/FgabvpbcKR1zWoQd
         avr7iiRlukQBDNUOc4B1vkGKBW+jqCj+9dfhTKExfcQvbPK3ef6t752FUD2uICvnyZeT
         kRG7QurW5N9B+Zuj9U6uw/sroOND7+2p+BJT1Mhrct91gJ5Us8RXLArIEbhANJhsLwrb
         eZ2A==
X-Gm-Message-State: APzg51B30DNA+jetHhm6W5n5nz8WCbDXexj0bLj6Di5exKWd5CJN5Yh6
        qRocIc3/P+6U2K7uoqN9bnmwpw==
X-Google-Smtp-Source: ANB0VdaWryE5/xquhYpmLoPSH0UCs4aQ8r60nJm9b/OyPtT/o8zGIeRm0G/GSc0wpt+VOKung3aiyg==
X-Received: by 2002:a17:902:b58a:: with SMTP id a10-v6mr41108885pls.306.1537466607585;
        Thu, 20 Sep 2018 11:03:27 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id h124-v6sm2941874pfg.112.2018.09.20.11.03.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 11:03:26 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>
Subject: [PATCH v2 1/2] i2c: i2c-qcom-geni: Properly handle DMA safe buffers
Date:   Thu, 20 Sep 2018 11:03:22 -0700
Message-Id: <20180920180323.217377-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
In-Reply-To: <20180920180323.217377-1-swboyd@chromium.org>
References: <20180920180323.217377-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We shouldn't attempt to DMA map the message buffers passed into this
driver from the i2c core unless the message we're mapping have been
properly setup for DMA. The i2c core indicates such a situation by
setting the I2C_M_DMA_SAFE flag, so check for that flag before using DMA
mode. We can also bounce the buffer if it isn't already mapped properly
by using the i2c_get_dma_safe_msg_buf() APIs, so do that when we
want to use DMA for a message.

This fixes a problem where the kernel oopses cleaning pages for a buffer
that's mapped into the vmalloc space. The pages are returned from
request_firmware() and passed down directly to the i2c master to write
to the i2c touchscreen device. Mapping vmalloc buffers with
dma_map_single() won't work reliably, causing an oops like below:

 Unable to handle kernel paging request at virtual address ffffffc01391d000
 Mem abort info:
   Exception class = DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
 Data abort info:
   ISV = 0, ISS = 0x00000146
   CM = 1, WnR = 1
 swapper pgtable: 4k pages, 39-bit VAs, pgd = ffffff8009ecf000
 [ffffffc01391d000] *pgd=000000017fffa803, *pud=000000017fffa803, *pmd=0000000000000000
 Internal error: Oops: 96000146 [#1] PREEMPT SMP
 Modules linked in: i2c_dev rfcomm uinput lzo lzo_compress hci_uart zram btqca qcom_q6v5_pil bluetooth ecdh_generic qcom_common bridge qcom_q6v5 stp llc ipt_MASQUERADE nf_nat_masquerade_ipv4 xt_mark fuse snd_seq_dummy snd_seq snd_seq_device cfg80211 rmtfs_mem smsc95xx usbnet mii joydev
 CPU: 0 PID: 1269 Comm: bash Not tainted 4.14.68 #1
 task: ffffffc0dc2a0080 task.stack: ffffff800f978000
 PC is at __clean_dcache_area_poc+0x20/0x38
 LR is at __swiotlb_map_page+0x80/0x98
 pc : [<ffffff800809bfb4>] lr : [<ffffff800809a150>] pstate: 80400149
 sp : ffffff800f97ba20
 x29: ffffff800f97ba50 x28: 0000000000000001
 x27: ffffff8008a04000 x26: ffffffc0f79a7a28
 x25: 0000000000000000 x24: ffffffbf004e4740
 x23: 0000000000000000 x22: ffffffc0f94eb290
 x21: 000000009391d000 x20: 0000000000000084
 x19: 0000000000000001 x18: 0000000000000000
 x17: 0000000000000000 x16: ffffffc0dc2a0080
 x15: 0000000000000000 x14: 0000000000000001
 x13: 00000000000c00b1 x12: 0000000000000000
 x11: 0000000002000000 x10: 0000000000000000
 x9 : 0000000080000000 x8 : 000000001391d000
 x7 : ffffff80085649dc x6 : 0000000000000000
 x5 : 0000000000000000 x4 : 0000000000000001
 x3 : 000000000000003f x2 : 0000000000000040
 x1 : ffffffc01391d084 x0 : ffffffc01391d000
 Process bash (pid: 1269, stack limit = 0xffffff800f978000)
 Call trace:
 Exception stack(0xffffff800f97b8e0 to 0xffffff800f97ba20)
 b8e0: ffffffc01391d000 ffffffc01391d084 0000000000000040 000000000000003f
 b900: 0000000000000001 0000000000000000 0000000000000000 ffffff80085649dc
 b920: 000000001391d000 0000000080000000 0000000000000000 0000000002000000
 b940: 0000000000000000 00000000000c00b1 0000000000000001 0000000000000000
 cros-ec-spi spi10.0: SPI transfer timed out
 b960: ffffffc0dc2a0080 0000000000000000 0000000000000000 0000000000000001
 b980: 0000000000000084 000000009391d000 ffffffc0f94eb290 0000000000000000
 b9a0: ffffffbf004e4740 0000000000000000 ffffffc0f79a7a28 ffffff8008a04000
 b9c0: 0000000000000001 ffffff800f97ba50 ffffff800809a150 ffffff800f97ba20
 b9e0: ffffff800809bfb4 0000000080400149 ffffffc0f94eb290 0000000000000000
 ba00: 0000007fffffffff 0000000000000001 ffffff800f97ba50 ffffff800809bfb4
 [<ffffff800809bfb4>] __clean_dcache_area_poc+0x20/0x38
 [<ffffff8008448154>] geni_se_tx_dma_prep+0x80/0x154
 [<ffffff800867eb2c>] geni_i2c_xfer+0x14c/0x3dc
 [<ffffff80086793bc>] __i2c_transfer+0x428/0x83c
 [<ffffff8008679850>] i2c_transfer+0x80/0xbc
 [<ffffff80086798e8>] i2c_master_send+0x5c/0x90
 [<ffffff8008671cc0>] elants_i2c_send+0x30/0x84
 [<ffffff8008672460>] write_update_fw+0x324/0x484
 [<ffffff80085559e4>] dev_attr_store+0x40/0x58
 [<ffffff80082c4ca4>] sysfs_kf_write+0x4c/0x64
 [<ffffff80082c36fc>] kernfs_fop_write+0x124/0x1bc
 [<ffffff8008234f04>] __vfs_write+0x54/0x14c
 [<ffffff80082352b0>] vfs_write+0xcc/0x188
 [<ffffff800823548c>] SyS_write+0x60/0xc0
 Exception stack(0xffffff800f97bec0 to 0xffffff800f97c000)
 bec0: 0000000000000001 000000000e7ede70 0000000000000002 0000000000000000
 bee0: 0000000000000002 000000000e7ede70 00000000ec049bc8 0000000000000004
 bf00: 0000000000000002 0000000000000000 000000000e7f0f10 000000000ca2bcd8
 bf20: 0000000000000000 00000000ff9df69c 00000000ebfaf229 0000000000000000
 bf40: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
 bf60: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
 bf80: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
 bfa0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
 bfc0: 00000000ebfec978 00000000400e0030 0000000000000001 0000000000000004
 bfe0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
 [<ffffff80080832c4>] el0_svc_naked+0x34/0x38
 Code: 9ac32042 8b010001 d1000443 8a230000 (d50b7a20)

Reported-by: Philip Chen <philipchen@chromium.org>
Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Cc: Sagar Dharia <sdharia@codeaurora.org>
Cc: Girish Mahadevan <girishm@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 36732eb688a4..9f2eb02481d3 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -367,20 +367,26 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 	dma_addr_t rx_dma;
 	enum geni_se_xfer_mode mode;
 	unsigned long time_left = XFER_TIMEOUT;
+	void *dma_buf;
 
 	gi2c->cur = msg;
-	mode = msg->len > 32 ? GENI_SE_DMA : GENI_SE_FIFO;
+	mode = GENI_SE_FIFO;
+	dma_buf = i2c_get_dma_safe_msg_buf(msg, 32);
+	if (dma_buf)
+		mode = GENI_SE_DMA;
+
 	geni_se_select_mode(&gi2c->se, mode);
 	writel_relaxed(msg->len, gi2c->se.base + SE_I2C_RX_TRANS_LEN);
 	geni_se_setup_m_cmd(&gi2c->se, I2C_READ, m_param);
 	if (mode == GENI_SE_DMA) {
 		int ret;
 
-		ret = geni_se_rx_dma_prep(&gi2c->se, msg->buf, msg->len,
+		ret = geni_se_rx_dma_prep(&gi2c->se, dma_buf, msg->len,
 								&rx_dma);
 		if (ret) {
 			mode = GENI_SE_FIFO;
 			geni_se_select_mode(&gi2c->se, mode);
+			i2c_put_dma_safe_msg_buf(dma_buf, msg, false);
 		}
 	}
 
@@ -393,6 +399,7 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 		if (gi2c->err)
 			geni_i2c_rx_fsm_rst(gi2c);
 		geni_se_rx_dma_unprep(&gi2c->se, rx_dma, msg->len);
+		i2c_put_dma_safe_msg_buf(dma_buf, msg, !gi2c->err);
 	}
 	return gi2c->err;
 }
@@ -403,20 +410,26 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 	dma_addr_t tx_dma;
 	enum geni_se_xfer_mode mode;
 	unsigned long time_left;
+	void *dma_buf;
 
 	gi2c->cur = msg;
-	mode = msg->len > 32 ? GENI_SE_DMA : GENI_SE_FIFO;
+	mode = GENI_SE_FIFO;
+	dma_buf = i2c_get_dma_safe_msg_buf(msg, 32);
+	if (dma_buf)
+		mode = GENI_SE_DMA;
+
 	geni_se_select_mode(&gi2c->se, mode);
 	writel_relaxed(msg->len, gi2c->se.base + SE_I2C_TX_TRANS_LEN);
 	geni_se_setup_m_cmd(&gi2c->se, I2C_WRITE, m_param);
 	if (mode == GENI_SE_DMA) {
 		int ret;
 
-		ret = geni_se_tx_dma_prep(&gi2c->se, msg->buf, msg->len,
+		ret = geni_se_tx_dma_prep(&gi2c->se, dma_buf, msg->len,
 								&tx_dma);
 		if (ret) {
 			mode = GENI_SE_FIFO;
 			geni_se_select_mode(&gi2c->se, mode);
+			i2c_put_dma_safe_msg_buf(dma_buf, msg, false);
 		}
 	}
 
@@ -432,6 +445,7 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 		if (gi2c->err)
 			geni_i2c_tx_fsm_rst(gi2c);
 		geni_se_tx_dma_unprep(&gi2c->se, tx_dma, msg->len);
+		i2c_put_dma_safe_msg_buf(dma_buf, msg, !gi2c->err);
 	}
 	return gi2c->err;
 }
-- 
Sent by a computer through tubes

