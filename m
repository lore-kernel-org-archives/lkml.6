Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378AEC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3EBF20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3EBF20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbeKFRq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 12:46:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:58610 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729021AbeKFRq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 12:46:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 80D40B0D3;
        Tue,  6 Nov 2018 08:22:22 +0000 (UTC)
Date:   Tue, 6 Nov 2018 09:22:21 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Kees Cook <keescook@chromium.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: kstrdup_quotable_cmdline and gfp flags
Message-ID: <20181106082221.GB27423@dhcp22.suse.cz>
References: <84197642-f414-81dc-ee68-1a4c1cdea5ae@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84197642-f414-81dc-ee68-1a4c1cdea5ae@rasmusvillemoes.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-11-18 22:32:07, Rasmus Villemoes wrote:
> kstrdup_quotable_cmdline takes gfp flags and passes those on to
> kstrdup_quotable, but before that it has done a kmalloc(PAGE_SIZE) with
> a hard-coded GFP_KERNEL. There is one caller of kstrdup_quotable_cmdline
> which passes GFP_ATOMIC, and the commit introducing that (65a3c2748e)
> conveniently has this piece of history:
> 
>     v2: Use GFP_ATOMIC while holding the rcu lock per Chris Wilson
> 
> So, should the GFP_KERNEL in kstrdup_quotable_cmdline simply be changed
> to use the passed-in gfp, or is there some deeper reason for the
> GFP_KERNEL (in which case it doesn't really make sense to take gfp at
> all...)?

I would just drop the gfp argument and move comm = kstrdup(task->comm, GFP_ATOMIC);
before rcu read lock

The code in its current form is buggy.
-- 
Michal Hocko
SUSE Labs
