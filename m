Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDB1C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0D120657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kdt0j7Pu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A0D120657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbeJaWuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 18:50:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729286AbeJaWuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 18:50:51 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F88F20657;
        Wed, 31 Oct 2018 13:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540993963;
        bh=Bc39Rz/UYwu9BdFVjz6bT3Oa+y23XxrvHvRF5ju5Ibs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kdt0j7PuHaqzRKbS6WwlwAsX6YKIpxePVAeQhcZfGm6Le7qWjBbYPDITi2T79pcG3
         NnXZwq+N+LyCwrVlDDjZxjq+7ApVmm/yZXVN2SCYvv0qFJx33D5G2OTxhHWitSQX93
         nM86f/eLshJLMmtcMPIt+e7ND/nRdB8BFaWGlXOc=
Date:   Wed, 31 Oct 2018 09:52:42 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org
Subject: Re: [PATCH 4.18] Revert "mm: slowly shrink slabs with a relatively
 small number of objects"
Message-ID: <20181031135242.GI194472@sasha-vm>
References: <20181026111859.23807-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181026111859.23807-1-sashal@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 07:18:59AM -0400, Sasha Levin wrote:
>This reverts commit 62aad93f09c1952ede86405894df1b22012fd5ab.
>
>Which was upstream commit 172b06c32b94 ("mm: slowly shrink slabs with a
>relatively small number of objects").
>
>The upstream commit was found to cause regressions. While there is a
>proposed fix upstream, revent this patch from stable trees for now as
>testing the fix will take some time.
>
>Signed-off-by: Sasha Levin <sashal@kernel.org>
>---
> mm/vmscan.c | 11 -----------
> 1 file changed, 11 deletions(-)
>
>diff --git a/mm/vmscan.c b/mm/vmscan.c
>index fc0436407471..03822f86f288 100644
>--- a/mm/vmscan.c
>+++ b/mm/vmscan.c
>@@ -386,17 +386,6 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> 	delta = freeable >> priority;
> 	delta *= 4;
> 	do_div(delta, shrinker->seeks);
>-
>-	/*
>-	 * Make sure we apply some minimal pressure on default priority
>-	 * even on small cgroups. Stale objects are not only consuming memory
>-	 * by themselves, but can also hold a reference to a dying cgroup,
>-	 * preventing it from being reclaimed. A dying cgroup with all
>-	 * corresponding structures like per-cpu stats and kmem caches
>-	 * can be really big, so it may lead to a significant waste of memory.
>-	 */
>-	delta = max_t(unsigned long long, delta, min(freeable, batch_size));
>-
> 	total_scan += delta;
> 	if (total_scan < 0) {
> 		pr_err("shrink_slab: %pF negative objects to delete nr=%ld\n",

I've queued it up for 4.18.

--
Thanks,
Sasha
