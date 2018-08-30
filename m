Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE420C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 23:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC7F20835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 23:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC7F20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbeHaDYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 23:24:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60662 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeHaDYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 23:24:11 -0400
Received: from localhost.localdomain (c-24-4-154-175.hsd1.ca.comcast.net [24.4.154.175])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C5EBBF72;
        Thu, 30 Aug 2018 23:19:32 +0000 (UTC)
Date:   Thu, 30 Aug 2018 16:19:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/parser.c: switch match_strdup() over to use
 kmemdup_nul()
Message-Id: <20180830161931.ce995be9e83fd43382f49bee@linux-foundation.org>
In-Reply-To: <20180830194436.188867-1-ebiggers@kernel.org>
References: <20180830194436.188867-1-ebiggers@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018 12:44:36 -0700 Eric Biggers <ebiggers@kernel.org> wrote:

> From: Eric Biggers <ebiggers@google.com>
> 
> This simplifies the code.  No change in behavior.
> 
> ...
>
> --- a/lib/parser.c
> +++ b/lib/parser.c
> @@ -327,10 +327,6 @@ EXPORT_SYMBOL(match_strlcpy);
>   */
>  char *match_strdup(const substring_t *s)
>  {
> -	size_t sz = s->to - s->from + 1;
> -	char *p = kmalloc(sz, GFP_KERNEL);
> -	if (p)
> -		match_strlcpy(p, s, sz);
> -	return p;
> +	return kmemdup_nul(s->from, s->to - s->from, GFP_KERNEL);
>  }
>  EXPORT_SYMBOL(match_strdup);

Huh.  I never noticed kmemdup_nul() fly past - it rather happened on
the sly.  We do have some fun goodies in there.

We could make match_strdup() an inline now.  But that will probably
produce a fatter kernel, as each callsite would then need to prepare
three args rather than one.

