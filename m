Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65260C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139C621522
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9BnVYw3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 139C621522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732653AbeITADg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 20:03:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727983AbeITADf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 20:03:35 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF69E21521;
        Wed, 19 Sep 2018 18:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537381467;
        bh=m6cYht+R4X/QIWpt+V7iEF7GKsVu2UdjOrjdAUbMlgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F9BnVYw3E3JwMO0lvb3wMeVgxaEOGZSEKDlUwj792j0dbzN20uYKxv2Y9JXKQKGE1
         kuyFf85YCTeKnKFu34DLRXvBmi6bVkbrwNhzxQDQXhKofoe0GSnbO/8nYBbUmq27nB
         gUqYM0/qcqjfbk9GHnNbCAUz9cvD//hqu8agMa4Y=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id D4219140260; Wed, 19 Sep 2018 15:24:24 -0300 (-03)
Date:   Wed, 19 Sep 2018 15:24:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, kim.phillips@arm.com,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 4/9] perf, tools, script: Allow sym and dso without
 ip, addr
Message-ID: <20180919182424.GF31812@kernel.org>
References: <20180918123214.26728-1-andi@firstfloor.org>
 <20180918123214.26728-5-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918123214.26728-5-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 18, 2018 at 05:32:09AM -0700, Andi Kleen escreveu:
> This allows to remove a lot of noise in callindent output by
> dropping the numerical addresses, which are not all that useful.
> 
> Before
> 
> % perf script --itrace=cr -F +callindent
>          swapper     0 [000] 156546.354971:          1   branches: pt_config                                       0 [unknown] ([unknown]) => ffffffff81010486 pt_config ([kernel.kallsyms])
>          swapper     0 [000] 156546.354971:          1   branches:     pt_config                    ffffffff81010499 pt_config ([kernel.kallsyms]) => ffffffff8101063e pt_event_add ([kernel.kallsyms])
> 
> After
> 
> % perf script --itrace=cr -F +callindent,-ip,-sym,-symoff
>        swapper     0 [000] 156546.354971:          1   branches:  pt_config
>        swapper     0 [000] 156546.354971:          1   branches:      pt_config

Tested, seems to work as advertised,

Applied,

- Arnaldo
