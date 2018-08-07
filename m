Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E24C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81EA2151D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81EA2151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390874AbeHGVOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:14:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34792 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389756AbeHGVOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:14:01 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DF565BAF;
        Tue,  7 Aug 2018 18:58:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Richter <tmricht@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 47/85] s390/cpum_sf: Add data entry sizes to sampling trailer entry
Date:   Tue,  7 Aug 2018 20:51:49 +0200
Message-Id: <20180807172359.093457159@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172357.357252052@linuxfoundation.org>
References: <20180807172357.357252052@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit 77715b7ddb446bd39a06f3376e85f4bb95b29bb8 ]

The CPU Measurement sampling facility creates a trailer entry for each
Sample-Data-Block of stored samples. The trailer entry contains the sizes
(in bytes) of the stored sampling types:
 - basic-sampling data entry size
 - diagnostic-sampling data entry size
Both sizes are 2 bytes long.

This patch changes the trailer entry definition to reflect this.

Fixes: fcc77f507333 ("s390/cpum_sf: Atomically reset trailer entry fields of sample-data-blocks")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/include/asm/cpu_mf.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/s390/include/asm/cpu_mf.h
+++ b/arch/s390/include/asm/cpu_mf.h
@@ -134,7 +134,9 @@ struct hws_trailer_entry {
 			unsigned int f:1;	/* 0 - Block Full Indicator   */
 			unsigned int a:1;	/* 1 - Alert request control  */
 			unsigned int t:1;	/* 2 - Timestamp format	      */
-			unsigned long long:61;	/* 3 - 63: Reserved	      */
+			unsigned int :29;	/* 3 - 31: Reserved	      */
+			unsigned int bsdes:16;	/* 32-47: size of basic SDE   */
+			unsigned int dsdes:16;	/* 48-63: size of diagnostic SDE */
 		};
 		unsigned long long flags;	/* 0 - 63: All indicators     */
 	};


