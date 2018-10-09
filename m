Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211F4C43441
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 23:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE438214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 23:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE438214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeJJGcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 02:32:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45870 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725750AbeJJGcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 02:32:54 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CCF4A7AA;
        Tue,  9 Oct 2018 23:13:37 +0000 (UTC)
Date:   Tue, 9 Oct 2018 16:13:36 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jack Wang <xjtuwjp@gmail.com>
Cc:     gregkh@linuxfoundation.org, florian-ewald.mueller@profitbricks.com,
        linux-kernel@vger.kernel.org,
        Jack Wang <jinpu.wang@profitbricks.com>
Subject: Re: [PATCH] lib: memcmp optimization
Message-Id: <20181009161336.1abf11d48a9adf40486c30eb@linux-foundation.org>
In-Reply-To: <1539095291-9926-1-git-send-email-jinpuwang@gmail.com>
References: <1539095291-9926-1-git-send-email-jinpuwang@gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  9 Oct 2018 16:28:11 +0200 Jack Wang <xjtuwjp@gmail.com> wrote:

> From: Florian-Ewald Mueller <florian-ewald.mueller@profitbricks.com>
> 
> During testing, I have configured 128 md/raid1's and, while under
> heavy IO, I started a check on each of them
> (echo check > /sys/block/mdx/md/sync_action).
> 
> The CPU utilization went through the ceiling and when looking for
> the cause (with 'perf top'). I've discovered that ~50% of the time
> was spend in memcmp() called from process_checks().
> 
> With this patch applied, it drops to 4% - 10%.

Which CPU architecture?  Most important architectures appear to define
__HAVE_ARCH_MEMCMP.

> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -852,7 +852,7 @@ EXPORT_SYMBOL(memmove);
>   * @count: The size of the area.
>   */
>  #undef memcmp
> -__visible int memcmp(const void *cs, const void *ct, size_t count)
> +static inline int __memcmp(const void *cs, const void *ct, size_t count)

What the heck does __visible do?

>  {
>  	const unsigned char *su1, *su2;
>  	int res = 0;
> @@ -862,6 +862,20 @@ __visible int memcmp(const void *cs, const void *ct, size_t count)
>  			break;
>  	return res;
>  }
> +__visible int memcmp(const void *cs, const void *ct, size_t count)
> +{
> +	const uint64_t *l1p = cs;
> +	const uint64_t *l2p = ct;
> +
> +	while (count >= sizeof(*l1p)) {
> +		if (*l1p != *l2p)
> +			return __memcmp(l1p, l2p, sizeof(*l1p));
> +		count -= sizeof(*l1p);
> +		++l1p;
> +		++l2p;
> +	}
> +	return __memcmp(l1p, l2p, count);
> +}

This is going to do bad things if the incoming addresses aren't
suitably aligned.

Certainly, byte-at-a-time is a pretty lame implementation when the
addresses are suitably aligned.  A fallback to the lame version when
there is misalignment will be simple to do.  And presumably there will
be decent benefits to whoever is actually using this code.  But I'm
wondering who is actually using this code!

