Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801B1C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44372219EA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44372219EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752755AbeGDRaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 13:30:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50632 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752165AbeGDRaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 13:30:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C082668801;
        Wed,  4 Jul 2018 17:30:08 +0000 (UTC)
Received: from krava (unknown [10.43.17.196])
        by smtp.corp.redhat.com (Postfix) with SMTP id 20F9F2026D76;
        Wed,  4 Jul 2018 17:30:06 +0000 (UTC)
Date:   Wed, 4 Jul 2018 19:30:05 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Yury Norov <ynorov@caviumnetworks.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        David Ahern <dsahern@gmail.com>,
        David Carrillo-Cisneros <davidcc@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH 2/2] bitmap: sync tools with new bitmap allocation API
Message-ID: <20180704173005.GF19164@krava>
References: <20180623073502.16321-1-ynorov@caviumnetworks.com>
 <20180623073502.16321-2-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180623073502.16321-2-ynorov@caviumnetworks.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 04 Jul 2018 17:30:08 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 04 Jul 2018 17:30:08 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 10:35:02AM +0300, Yury Norov wrote:
> On top of next-20180622 and Andy Shevchenko series:
> https://lkml.org/lkml/2018/6/18/841
> 
> The series mentioned above introduces helpers for bitmap allocation.
> tools/ has its own bitmap_alloc() which differs from bitmap_alloc()
> proposed in new kernel API, and is equivalent to bitmap_zalloc().
> In this series tools is switched to new API.
> 
> This is RFC because I didn't find counterpart free() call to some
> bitmap_zalloc()'s. So I didn't convert them to bitmap_free(). Could
> someone point me out? The functions are:
> setup_nodes();
> do_read_bitmap(); // Free is called, but only in fail path.
> memory_node__read();
> 
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> ---
>  tools/include/linux/bitmap.h | 19 +++++++++++++++----
>  tools/perf/builtin-c2c.c     | 10 +++++-----
>  tools/perf/tests/bitmap.c    |  4 ++--
>  tools/perf/tests/mem2node.c  |  4 ++--
>  tools/perf/util/header.c     |  6 +++---
>  5 files changed, 27 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
> index 48c208437bbd..b9b85b94c937 100644
> --- a/tools/include/linux/bitmap.h
> +++ b/tools/include/linux/bitmap.h
> @@ -98,12 +98,23 @@ static inline int test_and_set_bit(int nr, unsigned long *addr)
>  }
>  
>  /**
> - * bitmap_alloc - Allocate bitmap
> - * @nbits: Number of bits
> + * Allocation and deallocation of bitmap.
>   */
> -static inline unsigned long *bitmap_alloc(int nbits)
> +static inline unsigned long *bitmap_alloc(unsigned int nbits, gfp_t flags)
>  {
> -	return calloc(1, BITS_TO_LONGS(nbits) * sizeof(unsigned long));
> +	(void) flags;
> +	return malloc(BITS_TO_LONGS(nbits) * sizeof(unsigned long));
> +}

hum I don't see any tools/ user fo bitmap_alloc now,
but I guess we don't mind ;-)

jirka
