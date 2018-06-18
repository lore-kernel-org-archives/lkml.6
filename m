Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77880C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8DF20852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8DF20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936912AbeFRJLS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:11:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33650 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966694AbeFRIaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:30:18 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 20C84C75;
        Mon, 18 Jun 2018 08:30:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wakko Warner <wakko@animx.eu.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 032/189] scsi: target: fix crash with iscsi target and dvd
Date:   Mon, 18 Jun 2018 10:12:08 +0200
Message-Id: <20180618081210.570362465@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 8e1ceafe50ec4d1bcfae154dd70e7cb6946a6177 ]

When the current page can't be added to bio, one new bio should be
created for adding this page again, instead of ignoring this page.

This patch fixes kernel crash with iscsi target and dvd, as reported by
Wakko.

Cc: Wakko Warner <wakko@animx.eu.org>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: target-devel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Cc: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Cc: Christoph Hellwig <hch@lst.de>
Fixes: 84c8590646d5b35804 ("target: avoid accessing .bi_vcnt directly")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/target/target_core_pscsi.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -890,6 +890,7 @@ pscsi_map_sg(struct se_cmd *cmd, struct
 			bytes = min(bytes, data_len);
 
 			if (!bio) {
+new_bio:
 				nr_vecs = min_t(int, BIO_MAX_PAGES, nr_pages);
 				nr_pages -= nr_vecs;
 				/*
@@ -931,6 +932,7 @@ pscsi_map_sg(struct se_cmd *cmd, struct
 				 * be allocated with pscsi_get_bio() above.
 				 */
 				bio = NULL;
+				goto new_bio;
 			}
 
 			data_len -= bytes;


