Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96AEECE564
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6950D20883
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6950D20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbeIQU3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:29:42 -0400
Received: from smtprelay0030.hostedemail.com ([216.40.44.30]:34285 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729059AbeIQU3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:29:41 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 978BB8368EE8;
        Mon, 17 Sep 2018 15:01:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: books25_4ab8a21571408
X-Filterd-Recvd-Size: 4799
Received: from joe-laptop.perches.com (mb42736d0.tmodns.net [208.54.39.180])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Mon, 17 Sep 2018 15:01:53 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] mpt3sas: Remove KERN_WARNING from panic uses
Date:   Mon, 17 Sep 2018 08:01:12 -0700
Message-Id: <36d906ff0d22e530024eb487a3a6dbb224f6a1b0.1537183088.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1537183087.git.joe@perches.com>
References: <cover.1537183087.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the logging level as panic calls stop the machine and should
always be emitted regardless of requested logging level.

These existing panic uses are perhaps inappropriate.

Miscellanea:

o Coalesce formats and convert MPT3SAS_FMT to "%s: " to improve clarity

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/scsi/mpt3sas/mpt3sas_config.c | 41 +++++++++++++----------------------
 1 file changed, 15 insertions(+), 26 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_config.c b/drivers/scsi/mpt3sas/mpt3sas_config.c
index 38d3b163b5d1..02209447f4ef 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_config.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_config.c
@@ -421,12 +421,10 @@ _config_request(struct MPT3SAS_ADAPTER *ioc, Mpi2ConfigRequest_t
 		    (mpi_reply->Header.PageType & 0xF)) {
 			_debug_dump_mf(mpi_request, ioc->request_sz/4);
 			_debug_dump_reply(mpi_reply, ioc->request_sz/4);
-			panic(KERN_WARNING MPT3SAS_FMT "%s: Firmware BUG:" \
-			    " mpi_reply mismatch: Requested PageType(0x%02x)" \
-			    " Reply PageType(0x%02x)\n", \
-			    ioc->name, __func__,
-			    (mpi_request->Header.PageType & 0xF),
-			    (mpi_reply->Header.PageType & 0xF));
+			panic("%s: %s: Firmware BUG: mpi_reply mismatch: Requested PageType(0x%02x) Reply PageType(0x%02x)\n",
+			      ioc->name, __func__,
+			      mpi_request->Header.PageType & 0xF,
+			      mpi_reply->Header.PageType & 0xF);
 		}
 
 		if (((mpi_request->Header.PageType & 0xF) ==
@@ -434,11 +432,10 @@ _config_request(struct MPT3SAS_ADAPTER *ioc, Mpi2ConfigRequest_t
 		    mpi_request->ExtPageType != mpi_reply->ExtPageType) {
 			_debug_dump_mf(mpi_request, ioc->request_sz/4);
 			_debug_dump_reply(mpi_reply, ioc->request_sz/4);
-			panic(KERN_WARNING MPT3SAS_FMT "%s: Firmware BUG:" \
-			    " mpi_reply mismatch: Requested ExtPageType(0x%02x)"
-			    " Reply ExtPageType(0x%02x)\n",
-			    ioc->name, __func__, mpi_request->ExtPageType,
-			    mpi_reply->ExtPageType);
+			panic("%s: %s: Firmware BUG: mpi_reply mismatch: Requested ExtPageType(0x%02x) Reply ExtPageType(0x%02x)\n",
+			      ioc->name, __func__,
+			      mpi_request->ExtPageType,
+			      mpi_reply->ExtPageType);
 		}
 		ioc_status = le16_to_cpu(mpi_reply->IOCStatus)
 		    & MPI2_IOCSTATUS_MASK;
@@ -461,14 +458,10 @@ _config_request(struct MPT3SAS_ADAPTER *ioc, Mpi2ConfigRequest_t
 				_debug_dump_reply(mpi_reply, ioc->request_sz/4);
 				_debug_dump_config(p, min_t(u16, mem.sz,
 				    config_page_sz)/4);
-				panic(KERN_WARNING MPT3SAS_FMT
-					"%s: Firmware BUG:" \
-				    " config page mismatch:"
-				    " Requested PageType(0x%02x)"
-				    " Reply PageType(0x%02x)\n",
-				    ioc->name, __func__,
-				    (mpi_request->Header.PageType & 0xF),
-				    (p[3] & 0xF));
+				panic("%s: %s: Firmware BUG: config page mismatch: Requested PageType(0x%02x) Reply PageType(0x%02x)\n",
+				      ioc->name, __func__,
+				      mpi_request->Header.PageType & 0xF,
+				      p[3] & 0xF);
 			}
 
 			if (((mpi_request->Header.PageType & 0xF) ==
@@ -478,13 +471,9 @@ _config_request(struct MPT3SAS_ADAPTER *ioc, Mpi2ConfigRequest_t
 				_debug_dump_reply(mpi_reply, ioc->request_sz/4);
 				_debug_dump_config(p, min_t(u16, mem.sz,
 				    config_page_sz)/4);
-				panic(KERN_WARNING MPT3SAS_FMT
-					"%s: Firmware BUG:" \
-				    " config page mismatch:"
-				    " Requested ExtPageType(0x%02x)"
-				    " Reply ExtPageType(0x%02x)\n",
-				    ioc->name, __func__,
-				    mpi_request->ExtPageType, p[6]);
+				panic("%s: %s: Firmware BUG: config page mismatch: Requested ExtPageType(0x%02x) Reply ExtPageType(0x%02x)\n",
+				      ioc->name, __func__,
+				      mpi_request->ExtPageType, p[6]);
 			}
 		}
 		memcpy(config_page, mem.page, min_t(u16, mem.sz,
-- 
2.15.0

