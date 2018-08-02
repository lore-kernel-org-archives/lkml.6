Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E1DC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A094A208DE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A094A208DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbeHBIrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 04:47:17 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:8325 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726145AbeHBIrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 04:47:17 -0400
Subject: Re: [PATCH 2/9] mm: workingset: tell cache transitions from
 workingset thrashing
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>
CC:     Tejun Heo <tj@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
        Daniel Drake <drake@endlessm.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
References: <20180801151308.32234-1-hannes@cmpxchg.org>
 <20180801151308.32234-3-hannes@cmpxchg.org>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <c0480401-fb38-0b46-6dee-a20093dff065@sony.com>
Date:   Thu, 2 Aug 2018 08:57:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180801151308.32234-3-hannes@cmpxchg.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/2018 05:13 PM, Johannes Weiner wrote:
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index e34a27727b9a..7af1c3c15d8e 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -69,13 +69,14 @@
>   */
>  enum pageflags {
>  	PG_locked,		/* Page is locked. Don't touch. */
> -	PG_error,
>  	PG_referenced,
>  	PG_uptodate,
>  	PG_dirty,
>  	PG_lru,
>  	PG_active,
> +	PG_workingset,
>  	PG_waiters,		/* Page has waiters, check its waitqueue. Must be bit #7 and in the same byte as "PG_locked" */
> +	PG_error,
>  	PG_slab,
>  	PG_owner_priv_1,	/* Owner use. If pagecache, fs may use*/
>  	PG_arch_1,
> @@ -280,6 +281,8 @@ PAGEFLAG(Dirty, dirty, PF_HEAD) TESTSCFLAG(Dirty, dirty, PF_HEAD)
Any reason why the PG_error was moved? And dont you need to do some handling of this flag in proc/fs/page.c ?
Some KFP_WORKINGSET ?


