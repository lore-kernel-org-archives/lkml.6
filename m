Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8DAECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 23:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DEB12156B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 23:34:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DEB12156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391659AbeIVFZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 01:25:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55148 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeIVFZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 01:25:21 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AFC378D7;
        Fri, 21 Sep 2018 23:34:13 +0000 (UTC)
Date:   Fri, 21 Sep 2018 16:34:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] slub: extend slub debug to handle multiple slabs
Message-Id: <20180921163412.de1b331a639a8031aaf85d4f@linux-foundation.org>
In-Reply-To: <20180920200016.11003-1-atomlin@redhat.com>
References: <20180920200016.11003-1-atomlin@redhat.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2018 21:00:16 +0100 Aaron Tomlin <atomlin@redhat.com> wrote:

> Extend the slub_debug syntax to "slub_debug=<flags>[,<slub>]*", where <slub>
> may contain an asterisk at the end.  For example, the following would poison
> all kmalloc slabs:
> 
> 	slub_debug=P,kmalloc*
> 
> and the following would apply the default flags to all kmalloc and all block IO
> slabs:
> 
> 	slub_debug=,bio*,kmalloc*
> 
> Please note that a similar patch was posted by Iliyan Malchev some time ago but
> was never merged:
> 
> 	https://marc.info/?l=linux-mm&m=131283905330474&w=2

Fair enough, I guess.

> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1283,9 +1283,37 @@ slab_flags_t kmem_cache_flags(unsigned int object_size,
>  	/*
>  	 * Enable debugging if selected on the kernel commandline.
>  	 */

The above comment is in a strange place.  Can we please move it to
above the function definition in the usual fashion?  And make it
better, if anything seems to be missing.

> -	if (slub_debug && (!slub_debug_slabs || (name &&
> -		!strncmp(slub_debug_slabs, name, strlen(slub_debug_slabs)))))
> -		flags |= slub_debug;
> +
> +	char *end, *n, *glob;

`end' and `glob' could be local to the loop which uses them, which I
find a bit nicer.

`n' is a rotten identifier.  Can't we think of something which
communicates meaning?

> +	int len = strlen(name);
> +
> +	/* If slub_debug = 0, it folds into the if conditional. */
> +	if (!slub_debug_slabs)
> +		return flags | slub_debug;

If we take the above return, the call to strlen() was wasted cycles. 
Presumably gcc is smart enough to prevent that, but why risk it.

> +	n = slub_debug_slabs;
> +	while (*n) {
> +		int cmplen;
> +
> +		end = strchr(n, ',');
> +		if (!end)
> +			end = n + strlen(n);
> +
> +		glob = strnchr(n, end - n, '*');
> +		if (glob)
> +			cmplen = glob - n;
> +		else
> +			cmplen = max(len, (int)(end - n));

max_t() exists for this.  Or maybe make `len' size_t, but I expect that
will still warn - that subtraction returns a ptrdiff_t, yes?

> +
> +		if (!strncmp(name, n, cmplen)) {
> +			flags |= slub_debug;
> +			break;
> +		}
> +
> +		if (!*end)
> +			break;
> +		n = end + 1;
> +	}

The code in this loop hurts my brain a bit. I hope it's correct ;)
