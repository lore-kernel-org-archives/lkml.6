Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C041FECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8042F2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8042F2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732006AbeIREjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:39:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50198 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730295AbeIREjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:39:22 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7E097707;
        Mon, 17 Sep 2018 23:09:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quinn Tran <quinn.tran@cavium.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 060/158] scsi: qla2xxx: Silent erroneous message
Date:   Tue, 18 Sep 2018 00:41:30 +0200
Message-Id: <20180917211714.017167073@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
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

From: Quinn Tran <quinn.tran@cavium.com>

[ Upstream commit 3f915271b12e11183c606bed1c3dfff0983662d3 ]

Driver uses shadow pointer instead of Mirror pointer for firmware dump
collection. Skip those entries for Mirror pointers for Request/Response
queue from firmware dump template reading.

Following messages are printed in log messages:

 qla27xx_fwdt_entry_t268: unknown buffer 4
 qla27xx_fwdt_entry_t268: unknown buffer 5

This patch fixes these error messages by adding skip_entry() to not read
them from template.

Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_tmpl.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/scsi/qla2xxx/qla_tmpl.c
+++ b/drivers/scsi/qla2xxx/qla_tmpl.c
@@ -571,6 +571,15 @@ qla27xx_fwdt_entry_t268(struct scsi_qla_
 		}
 		break;
 
+	case T268_BUF_TYPE_REQ_MIRROR:
+	case T268_BUF_TYPE_RSP_MIRROR:
+		/*
+		 * Mirror pointers are not implemented in the
+		 * driver, instead shadow pointers are used by
+		 * the drier. Skip these entries.
+		 */
+		qla27xx_skip_entry(ent, buf);
+		break;
 	default:
 		ql_dbg(ql_dbg_async, vha, 0xd02b,
 		    "%s: unknown buffer %x\n", __func__, ent->t268.buf_type);


