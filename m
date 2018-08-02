Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E669C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209E02152F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3yApwL2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 209E02152F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbeHBSKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 14:10:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbeHBSKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 14:10:01 -0400
Received: from linux-8ccs (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BCBE2152D;
        Thu,  2 Aug 2018 16:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533226690;
        bh=hEEVQNCYTHou5mp4bqLBRUS1ADJ6KN0ganI0MzA92PE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S3yApwL2EglCG5WlCJrQwdnqXrnkdCCJFYUFrBzuTwU50DR3wBS0vDasyEJm/mGaR
         TviUym9hVHJlrCf5IUU3zQRkT4UpdFy9qmkeYMUTLuMlD3+ozriLkteQChkReig0L9
         A9guU3GBpqG+ODCi+fVyPlzJ5QIza5rxyGD1uKQM=
Date:   Thu, 2 Aug 2018 18:17:58 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/module: Use kmemdup to replace kmalloc+memcpy
Message-ID: <20180802161758.meijhtmvdhz4qfup@linux-8ccs>
References: <1533056177-37255-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1533056177-37255-1-git-send-email-zhongjiang@huawei.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.11-default x86_64
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ zhong jiang [01/08/18 00:56 +0800]:
>we prefer to the kmemdup rather than kmalloc+memcpy. so just
>replace them.
>
>Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Applied, thanks.

Jessica

>---
> kernel/module.c | 6 ++----
> 1 file changed, 2 insertions(+), 4 deletions(-)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index 20344e4..6746c85 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -2057,21 +2057,19 @@ static int copy_module_elf(struct module *mod, struct load_info *info)
>
> 	/* Elf section header table */
> 	size = sizeof(*info->sechdrs) * info->hdr->e_shnum;
>-	mod->klp_info->sechdrs = kmalloc(size, GFP_KERNEL);
>+	mod->klp_info->sechdrs = kmemdup(info->sechdrs, size, GFP_KERNEL);
> 	if (mod->klp_info->sechdrs == NULL) {
> 		ret = -ENOMEM;
> 		goto free_info;
> 	}
>-	memcpy(mod->klp_info->sechdrs, info->sechdrs, size);
>
> 	/* Elf section name string table */
> 	size = info->sechdrs[info->hdr->e_shstrndx].sh_size;
>-	mod->klp_info->secstrings = kmalloc(size, GFP_KERNEL);
>+	mod->klp_info->secstrings = kmemdup(info->secstrings, size, GFP_KERNEL);
> 	if (mod->klp_info->secstrings == NULL) {
> 		ret = -ENOMEM;
> 		goto free_sechdrs;
> 	}
>-	memcpy(mod->klp_info->secstrings, info->secstrings, size);
>
> 	/* Elf symbol section index */
> 	symndx = info->index.sym;
>-- 
>1.7.12.4
>
