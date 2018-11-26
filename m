Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11075C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBBD320645
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJ1zSt49"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBBD320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbeKZV6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:58:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:43010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729291AbeKZV6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:58:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B75B20672;
        Mon, 26 Nov 2018 11:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230262;
        bh=+Qox9tBpA767ESYgCFBKeuFTtLJ0gwur2ka5RgEQ6No=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iJ1zSt49SOPas6Mt0MlJAHL2BD4wEVx1TeQYbKK4JvWXxvIq/KWDgecIShDnuKakA
         AET6h8mzNlGJ/DvPmHGCF+p3DPAxJmBqNBDUze+dpVEGXWiigXbKFDeQa/qDHym4IX
         P5Czh4bD4JmdJ2BHMuYq1wN6uDuP4e83MJ2+3s20=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Richter <tmricht@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 068/118] s390/perf: Change CPUM_CF return code in event init function
Date:   Mon, 26 Nov 2018 11:51:02 +0100
Message-Id: <20181126105103.754335347@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 0bb2ae1b26e1fb7543ec7474cdd374ac4b88c4da ]

The function perf_init_event() creates a new event and
assignes it to a PMU. This a done in a loop over all existing
PMUs. For each listed PMU the event init function is called
and if this function does return any other error than -ENOENT,
the loop is terminated the creation of the event fails.

If the event is invalid, return -ENOENT to try other PMUs.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/perf_cpum_cf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index cc085e2d2ce9..74091fd3101e 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -373,7 +373,7 @@ static int __hw_perf_event_init(struct perf_event *event)
 		return -ENOENT;
 
 	if (ev > PERF_CPUM_CF_MAX_CTR)
-		return -EINVAL;
+		return -ENOENT;
 
 	/* Obtain the counter set to which the specified counter belongs */
 	set = get_counter_set(ev);
-- 
2.17.1



