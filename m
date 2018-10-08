Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E628C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6802E21479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRuphAll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6802E21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731255AbeJIB7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:59:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728570AbeJIB7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:59:42 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B3AE2087D;
        Mon,  8 Oct 2018 18:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024395;
        bh=xl+BD76bEKFrSKrp/pACi8Zf6zKvVpnus7iAdjOdLC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KRuphAllPu1TtgKaT2mycpALKsx02syZBXb1L/QZF2lwN8lFMn/IPFk5NDgiDe1W6
         9lA2m8aFigMxuVErM7px+R7VREos1zepSc95PS0uFUpmLNfNN28JeGUJH+zVWwHRTn
         I/+TnAI2K+xskQrZIh86aLBjpd/lqH3QPj1esNek=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Varun Prakash <varun@chelsio.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 009/168] scsi: csiostor: fix incorrect port capabilities
Date:   Mon,  8 Oct 2018 20:29:49 +0200
Message-Id: <20181008175620.393512236@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Varun Prakash <varun@chelsio.com>

[ Upstream commit 68bdc630721c40e908d22cffe07b5ca225a69f6e ]

 - use be32_to_cpu() instead of ntohs() for 32 bit port capabilities.

 - add a new function fwcaps32_to_caps16() to convert 32 bit port
   capabilities to 16 bit port capabilities.

Signed-off-by: Varun Prakash <varun@chelsio.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/csiostor/csio_hw.c |   55 ++++++++++++++++++++++++++++++++--------
 drivers/scsi/csiostor/csio_hw.h |    1 
 drivers/scsi/csiostor/csio_mb.c |    6 ++--
 3 files changed, 48 insertions(+), 14 deletions(-)

--- a/drivers/scsi/csiostor/csio_hw.c
+++ b/drivers/scsi/csiostor/csio_hw.c
@@ -1513,6 +1513,46 @@ fw_port_cap32_t fwcaps16_to_caps32(fw_po
 }
 
 /**
+ *	fwcaps32_to_caps16 - convert 32-bit Port Capabilities to 16-bits
+ *	@caps32: a 32-bit Port Capabilities value
+ *
+ *	Returns the equivalent 16-bit Port Capabilities value.  Note that
+ *	not all 32-bit Port Capabilities can be represented in the 16-bit
+ *	Port Capabilities and some fields/values may not make it.
+ */
+fw_port_cap16_t fwcaps32_to_caps16(fw_port_cap32_t caps32)
+{
+	fw_port_cap16_t caps16 = 0;
+
+	#define CAP32_TO_CAP16(__cap) \
+		do { \
+			if (caps32 & FW_PORT_CAP32_##__cap) \
+				caps16 |= FW_PORT_CAP_##__cap; \
+		} while (0)
+
+	CAP32_TO_CAP16(SPEED_100M);
+	CAP32_TO_CAP16(SPEED_1G);
+	CAP32_TO_CAP16(SPEED_10G);
+	CAP32_TO_CAP16(SPEED_25G);
+	CAP32_TO_CAP16(SPEED_40G);
+	CAP32_TO_CAP16(SPEED_100G);
+	CAP32_TO_CAP16(FC_RX);
+	CAP32_TO_CAP16(FC_TX);
+	CAP32_TO_CAP16(802_3_PAUSE);
+	CAP32_TO_CAP16(802_3_ASM_DIR);
+	CAP32_TO_CAP16(ANEG);
+	CAP32_TO_CAP16(FORCE_PAUSE);
+	CAP32_TO_CAP16(MDIAUTO);
+	CAP32_TO_CAP16(MDISTRAIGHT);
+	CAP32_TO_CAP16(FEC_RS);
+	CAP32_TO_CAP16(FEC_BASER_RS);
+
+	#undef CAP32_TO_CAP16
+
+	return caps16;
+}
+
+/**
  *      lstatus_to_fwcap - translate old lstatus to 32-bit Port Capabilities
  *      @lstatus: old FW_PORT_ACTION_GET_PORT_INFO lstatus value
  *
@@ -1670,7 +1710,7 @@ csio_enable_ports(struct csio_hw *hw)
 			val = 1;
 
 			csio_mb_params(hw, mbp, CSIO_MB_DEFAULT_TMO,
-				       hw->pfn, 0, 1, &param, &val, false,
+				       hw->pfn, 0, 1, &param, &val, true,
 				       NULL);
 
 			if (csio_mb_issue(hw, mbp)) {
@@ -1680,16 +1720,9 @@ csio_enable_ports(struct csio_hw *hw)
 				return -EINVAL;
 			}
 
-			csio_mb_process_read_params_rsp(hw, mbp, &retval, 1,
-							&val);
-			if (retval != FW_SUCCESS) {
-				csio_err(hw, "FW_PARAMS_CMD(r) port:%d failed: 0x%x\n",
-					 portid, retval);
-				mempool_free(mbp, hw->mb_mempool);
-				return -EINVAL;
-			}
-
-			fw_caps = val;
+			csio_mb_process_read_params_rsp(hw, mbp, &retval,
+							0, NULL);
+			fw_caps = retval ? FW_CAPS16 : FW_CAPS32;
 		}
 
 		/* Read PORT information */
--- a/drivers/scsi/csiostor/csio_hw.h
+++ b/drivers/scsi/csiostor/csio_hw.h
@@ -639,6 +639,7 @@ int csio_handle_intr_status(struct csio_
 
 fw_port_cap32_t fwcap_to_fwspeed(fw_port_cap32_t acaps);
 fw_port_cap32_t fwcaps16_to_caps32(fw_port_cap16_t caps16);
+fw_port_cap16_t fwcaps32_to_caps16(fw_port_cap32_t caps32);
 fw_port_cap32_t lstatus_to_fwcap(u32 lstatus);
 
 int csio_hw_start(struct csio_hw *);
--- a/drivers/scsi/csiostor/csio_mb.c
+++ b/drivers/scsi/csiostor/csio_mb.c
@@ -368,7 +368,7 @@ csio_mb_port(struct csio_hw *hw, struct
 			FW_CMD_LEN16_V(sizeof(*cmdp) / 16));
 
 	if (fw_caps == FW_CAPS16)
-		cmdp->u.l1cfg.rcap = cpu_to_be32(fc);
+		cmdp->u.l1cfg.rcap = cpu_to_be32(fwcaps32_to_caps16(fc));
 	else
 		cmdp->u.l1cfg32.rcap32 = cpu_to_be32(fc);
 }
@@ -395,8 +395,8 @@ csio_mb_process_read_port_rsp(struct csi
 			*pcaps = fwcaps16_to_caps32(ntohs(rsp->u.info.pcap));
 			*acaps = fwcaps16_to_caps32(ntohs(rsp->u.info.acap));
 		} else {
-			*pcaps = ntohs(rsp->u.info32.pcaps32);
-			*acaps = ntohs(rsp->u.info32.acaps32);
+			*pcaps = be32_to_cpu(rsp->u.info32.pcaps32);
+			*acaps = be32_to_cpu(rsp->u.info32.acaps32);
 		}
 	}
 }


