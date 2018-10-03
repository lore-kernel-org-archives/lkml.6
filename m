Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75910C64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453772082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 453772082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeJCWUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:20:37 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45742 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbeJCWUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:20:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id a23-v6so1844663pfi.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 08:31:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=js62U15/LuGH3LSaXd+WaC8tDRKZzmtaBadXD40y9Ow=;
        b=PNjgX5xRjhn+KEgqi+ArlriKCX7ZHBjHfxHzvCcU6SdkaTt3HO4Vg6NcwcjEFA3g8W
         CJARmLqSaVZQzb5WRIZ3U1KBOVaSxeCHK+wheASHoEzqij09r2OYUu+Dlv63xRszGWks
         60gkGXCAimzAwtsHoFHnix011U0QjgF5Gesscx0sdFrLIXpc4WIMx56S9Sa84QjsJp47
         cqtRBQdmVrStD+MB1twinDgzUJxh21Ev6bOZXh30B985DgvJU5lOX/AE8TQ3Nx2Dq9ii
         O1UgXTZds7l+A1IQ62+dLc6vBsoqKYkdvRL7xnud3F1kieqjWQiiUu07jkLvup3PQW5A
         XXKg==
X-Gm-Message-State: ABuFfohUIofBg6EEakDNcE2PE3ZClVSheOqWcZe9flheo5pcwf4ntulB
        odXMKcS/jVA5HaL7NzQDr9zc2M4yx7lFLA==
X-Google-Smtp-Source: ACcGV620VghUZkvtHD0Ltbr0msS46XL795AQMIi0m5F85dFHxEfyyztmz4N91xobhy/v0yfMf8eFvA==
X-Received: by 2002:a62:5044:: with SMTP id e65-v6mr2131349pfb.157.1538580701819;
        Wed, 03 Oct 2018 08:31:41 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id j5-v6sm1990111pgm.79.2018.10.03.08.31.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 08:31:41 -0700 (PDT)
Message-ID: <1538580700.205649.10.camel@acm.org>
Subject: Re: [PATCH 4/6] lib/scatterlist: Do not leak pages when high-order
 allocation fails
From:   Bart Van Assche <bvanassche@acm.org>
To:     Tvrtko Ursulin <tursulin@ursulin.net>, linux-kernel@vger.kernel.org
Cc:     tvrtko.ursulin@linux.intel.com,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Jens Axboe <axboe@kernel.dk>
Date:   Wed, 03 Oct 2018 08:31:40 -0700
In-Reply-To: <20180926141625.17727-5-tvrtko.ursulin@linux.intel.com>
References: <20180926141625.17727-1-tvrtko.ursulin@linux.intel.com>
         <20180926141625.17727-5-tvrtko.ursulin@linux.intel.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-09-26 at 15:16 +-0100, Tvrtko Ursulin wrote:
+AD4 From: Tvrtko Ursulin +ADw-tvrtko.ursulin+AEA-intel.com+AD4
+AD4 
+AD4 If a higher-order allocation fails, the existing abort and cleanup path
+AD4 would consider all segments allocated so far as 0-order page allocations
+AD4 and would therefore leak memory.
+AD4 
+AD4 Fix this by cleaning up using sgl+AF8-free+AF8-n+AF8-order which allows the correct
+AD4 page order to be passed in.
+AD4 
+AD4 Signed-off-by: Tvrtko Ursulin +ADw-tvrtko.ursulin+AEA-intel.com+AD4
+AD4 Cc: Bart Van Assche +ADw-bart.vanassche+AEA-wdc.com+AD4
+AD4 Cc: Hannes Reinecke +ADw-hare+AEA-suse.com+AD4
+AD4 Cc: Johannes Thumshirn +ADw-jthumshirn+AEA-suse.de+AD4
+AD4 Cc: Jens Axboe +ADw-axboe+AEA-kernel.dk+AD4
+AD4 ---
+AD4  lib/scatterlist.c +AHw 6 +-+-+-+---
+AD4  1 file changed, 4 insertions(+-), 2 deletions(-)
+AD4 
+AD4 diff --git a/lib/scatterlist.c b/lib/scatterlist.c
+AD4 index 3cc01cd82242..0caed79d7291 100644
+AD4 --- a/lib/scatterlist.c
+AD4 +-+-+- b/lib/scatterlist.c
+AD4 +AEAAQA -481,7 +-481,7 +AEAAQA struct scatterlist +ACo-sgl+AF8-alloc+AF8-order(unsigned long length, unsigned int order,
+AD4  +AHs
+AD4  	struct scatterlist +ACo-sgl, +ACo-sg+ADs
+AD4  	struct page +ACo-page+ADs
+AD4 -	unsigned int nent, nalloc+ADs
+AD4 +-	unsigned int nent, nalloc, i+ADs
+AD4  	u32 elem+AF8-len+ADs
+AD4  
+AD4  	nent +AD0 round+AF8-up(length, PAGE+AF8-SIZE +ADwAPA order) +AD4APg (PAGE+AF8-SHIFT +- order)+ADs
+AD4 +AEAAQA -501,17 +-501,19 +AEAAQA struct scatterlist +ACo-sgl+AF8-alloc+AF8-order(unsigned long length, unsigned int order,
+AD4  
+AD4  	sg+AF8-init+AF8-table(sgl, nalloc)+ADs
+AD4  	sg +AD0 sgl+ADs
+AD4 +-	i +AD0 0+ADs
+AD4  	while (length) +AHs
+AD4  		elem+AF8-len +AD0 min+AF8-t(u64, length, PAGE+AF8-SIZE +ADwAPA order)+ADs
+AD4  		page +AD0 alloc+AF8-pages(gfp, order)+ADs
+AD4  		if (+ACE-page) +AHs
+AD4 -			sgl+AF8-free(sgl)+ADs
+AD4 +-			sgl+AF8-free+AF8-n+AF8-order(sgl, i, order)+ADs
+AD4  			return NULL+ADs
+AD4  		+AH0
+AD4  
+AD4  		sg+AF8-set+AF8-page(sg, page, elem+AF8-len, 0)+ADs
+AD4  		length -+AD0 elem+AF8-len+ADs
+AD4  		sg +AD0 sg+AF8-next(sg)+ADs
+AD4 +-		i+-+-+ADs
+AD4  	+AH0
+AD4  	WARN+AF8-ONCE(length, +ACI-length +AD0 +ACU-ld+AFw-n+ACI, length)+ADs
+AD4  	if (nent+AF8-p)

sg+AF8-init+AF8-table() clears all page pointers and sgl+AF8-free+AF8-n+AF8-order() can handle
elements of which the page pointer is zero. So I think if
sgl+AF8-free+AF8-n+AF8-order(sgl, i, order) would be changed into sgl+AF8-free+AF8-n+AF8-order(sgl,
UINT+AF8-MAX, order) that the variable 'i' can be left out.

Bart.

