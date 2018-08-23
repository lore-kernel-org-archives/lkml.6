Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DBDC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9716F20A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9716F20A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbeHWLsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:48:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46508 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbeHWLsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:48:11 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 36735C74;
        Thu, 23 Aug 2018 08:19:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hoan Tran <hoan.tran@amperecomputing.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 039/217] drivers/perf: xgene_pmu: Fix IOB SLOW PMU parser error
Date:   Thu, 23 Aug 2018 09:52:32 +0200
Message-Id: <20180823075507.278403930@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
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

From: Hoan Tran <hoan.tran@amperecomputing.com>

[ Upstream commit a45fc268db20ecd859bb61e25045912b3194b5e6 ]

This patch fixes the below parser error of the IOB SLOW PMU.

        # perf stat -a -e iob-slow0/cycle-count/ sleep 1
        evenf syntax error: 'iob-slow0/cycle-count/'
                                 \___ parser error

It replaces the "-" character by "_" character inside the PMU name.

Signed-off-by: Hoan Tran <hoan.tran@amperecomputing.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/perf/xgene_pmu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -1463,7 +1463,7 @@ static char *xgene_pmu_dev_name(struct d
 	case PMU_TYPE_IOB:
 		return devm_kasprintf(dev, GFP_KERNEL, "iob%d", id);
 	case PMU_TYPE_IOB_SLOW:
-		return devm_kasprintf(dev, GFP_KERNEL, "iob-slow%d", id);
+		return devm_kasprintf(dev, GFP_KERNEL, "iob_slow%d", id);
 	case PMU_TYPE_MCB:
 		return devm_kasprintf(dev, GFP_KERNEL, "mcb%d", id);
 	case PMU_TYPE_MC:


