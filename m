Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBA0C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE5C2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE5C2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936977AbeFRVOH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 17:14:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48522 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936896AbeFRVOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 17:14:05 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0F7BAD13;
        Mon, 18 Jun 2018 21:14:05 +0000 (UTC)
Date:   Mon, 18 Jun 2018 14:14:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        Yury Norov <ynorov@caviumnetworks.com>,
        linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3 3/5] bitmap: Add bitmap_alloc(), bitmap_zalloc() and
 bitmap_free()
Message-Id: <20180618141404.68124daab97bd0f3a3051544@linux-foundation.org>
In-Reply-To: <20180618131003.88110-4-andriy.shevchenko@linux.intel.com>
References: <20180618131003.88110-1-andriy.shevchenko@linux.intel.com>
        <20180618131003.88110-4-andriy.shevchenko@linux.intel.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2018 16:10:01 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> A lot of code become ugly because of open coding allocations for bitmaps.
> 
> Introduce three helpers to allow users be more clear of intention
> and keep their code neat.
> 
> ...
>
> +unsigned long *bitmap_alloc(unsigned int nbits, gfp_t flags)
> +{
> +	return kmalloc_array(BITS_TO_LONGS(nbits), sizeof(unsigned long), flags);
> +}
> +EXPORT_SYMBOL(bitmap_alloc);
> +
> +unsigned long *bitmap_zalloc(unsigned int nbits, gfp_t flags)
> +{
> +	return bitmap_alloc(nbits, flags | __GFP_ZERO);
> +}
> +EXPORT_SYMBOL(bitmap_zalloc);
> +
> +void bitmap_free(const unsigned long *bitmap)
> +{
> +	kfree(bitmap);
> +}
> +EXPORT_SYMBOL(bitmap_free);
> +

I suggest these functions are small and simple enough to justify
inlining them.

