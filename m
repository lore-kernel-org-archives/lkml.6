Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99342C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1F920882
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1F920882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752815AbeGDRYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 13:24:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42440 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752019AbeGDRYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 13:24:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9BE8C212D1;
        Wed,  4 Jul 2018 17:24:49 +0000 (UTC)
Received: from krava (unknown [10.43.17.196])
        by smtp.corp.redhat.com (Postfix) with SMTP id 276862026D76;
        Wed,  4 Jul 2018 17:24:46 +0000 (UTC)
Date:   Wed, 4 Jul 2018 19:24:45 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Yury Norov <ynorov@caviumnetworks.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
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
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH 2/2] bitmap: sync tools with new bitmap allocation API
Message-ID: <20180704172445.GE19164@krava>
References: <20180623073502.16321-1-ynorov@caviumnetworks.com>
 <20180623073502.16321-2-ynorov@caviumnetworks.com>
 <20180624213103.GA166241@dtor-ws>
 <20180624224522.GA23998@yury-thinkpad>
 <20180704153617.tps2asygskoym46d@penguin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704153617.tps2asygskoym46d@penguin>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 04 Jul 2018 17:24:49 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 04 Jul 2018 17:24:49 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 03:36:17PM +0000, Dmitry Torokhov wrote:

SNIP

> > > > diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
> > > > index 48c208437bbd..b9b85b94c937 100644
> > > > --- a/tools/include/linux/bitmap.h
> > > > +++ b/tools/include/linux/bitmap.h
> > > > @@ -98,12 +98,23 @@ static inline int test_and_set_bit(int nr, unsigned long *addr)
> > > >  }
> > > >
> > > >  /**
> > > > - * bitmap_alloc - Allocate bitmap
> > > > - * @nbits: Number of bits
> > > > + * Allocation and deallocation of bitmap.
> > > >   */
> > > > -static inline unsigned long *bitmap_alloc(int nbits)
> > > > +static inline unsigned long *bitmap_alloc(unsigned int nbits, gfp_t flags)
> > > 
> > > This makes absolutely no sense for userspace API. What gfp_t even means
> > > here?
> > > 
> > > If you want to introduce bitmap_zalloc and bitmap_free it is fine but
> > > adding dummy parameters to match kernel API exactly is a folly.
> > 
> > Identical API makes easier porting the code from kernel to tools.
> > Refer for example declaration of kmalloc in:
> > tools/testing/radix-tree/linux.c
> > tools/testing/scatterlist/linux/mm.h
> > tools/virtio/linux/kernel.h
> > tools/virtio/ringtest/ptr_ring.c
> 
> These are unittests for the APIs in question, of course they would have
> to match exactly.
> 
> perf tool however is not a unittest, so there is no need to match kernel
> API.

+1, please remove that flags argument

thanks,
jirka
