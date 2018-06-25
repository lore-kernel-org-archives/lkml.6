Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81657C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C58325B23
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="z60spNcJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C58325B23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934261AbeFYOMV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 10:12:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934014AbeFYOMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 10:12:20 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5CE325B23;
        Mon, 25 Jun 2018 14:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529935940;
        bh=VfNNxvp6ThM1ZItBxPzRPhE/30unO3suc1Kge+4iWuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z60spNcJ21ph5q1DhSO6fs/fLCLIoflFQ5lOiNC/wX6i6/MGjI0IRIBRHBzWOf+8h
         CYLxM+0Q33muWbyfz4vNK4vAHRzl2Ep0ciy8RI39OBQYP8EorQvLi++e/5wPv/fUYW
         d89/t2zTxQpJJQzhq7fMeg9TCN7efdej3IDb7YUk=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 73C471401E5; Mon, 25 Jun 2018 11:12:17 -0300 (-03)
Date:   Mon, 25 Jun 2018 11:12:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Yury Norov <ynorov@caviumnetworks.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
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
Message-ID: <20180625141217.GW20477@kernel.org>
References: <20180623073502.16321-1-ynorov@caviumnetworks.com>
 <20180623073502.16321-2-ynorov@caviumnetworks.com>
 <20180624213103.GA166241@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180624213103.GA166241@dtor-ws>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jun 24, 2018 at 02:31:03PM -0700, Dmitry Torokhov escreveu:
> On Sat, Jun 23, 2018 at 10:35:02AM +0300, Yury Norov wrote:
> > On top of next-20180622 and Andy Shevchenko series:
> > https://lkml.org/lkml/2018/6/18/841
> > 
> > The series mentioned above introduces helpers for bitmap allocation.
> > tools/ has its own bitmap_alloc() which differs from bitmap_alloc()
> > proposed in new kernel API, and is equivalent to bitmap_zalloc().
> > In this series tools is switched to new API.
> > 
> > This is RFC because I didn't find counterpart free() call to some
> > bitmap_zalloc()'s. So I didn't convert them to bitmap_free(). Could
> > someone point me out? The functions are:
> > setup_nodes();
> > do_read_bitmap(); // Free is called, but only in fail path.
> 
> Yes, because if we succeed we effectively return allocated bitmap to the
> caller. You'd need to trace upwards and see how it all gets cleaned up.
> But given that this is userspace and is not expected to be long-lived,
> maybe nobody bothered freeing memory and we instead rely on the kernel
> to clean it all up when process terminates.

But neverthless these should be fixed, we can't rule out having some
long lived 'perf top' like tool, etc.

I.e. when you find missing the delete/free counterpart calls to
new/alloc operations, please send fixes.

- Arnaldo
 
> Thanks.
> 
> > memory_node__read();
> > 
> > Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> > ---
> >  tools/include/linux/bitmap.h | 19 +++++++++++++++----
> >  tools/perf/builtin-c2c.c     | 10 +++++-----
> >  tools/perf/tests/bitmap.c    |  4 ++--
> >  tools/perf/tests/mem2node.c  |  4 ++--
> >  tools/perf/util/header.c     |  6 +++---
> >  5 files changed, 27 insertions(+), 16 deletions(-)
> > 
> > diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
> > index 48c208437bbd..b9b85b94c937 100644
> > --- a/tools/include/linux/bitmap.h
> > +++ b/tools/include/linux/bitmap.h
> > @@ -98,12 +98,23 @@ static inline int test_and_set_bit(int nr, unsigned long *addr)
> >  }
> >  
> >  /**
> > - * bitmap_alloc - Allocate bitmap
> > - * @nbits: Number of bits
> > + * Allocation and deallocation of bitmap.
> >   */
> > -static inline unsigned long *bitmap_alloc(int nbits)
> > +static inline unsigned long *bitmap_alloc(unsigned int nbits, gfp_t flags)
> 
> This makes absolutely no sense for userspace API. What gfp_t even means
> here?
> 
> If you want to introduce bitmap_zalloc and bitmap_free it is fine but
> adding dummy parameters to match kernel API exactly is a folly.
> 
> Thanks.
> 
> -- 
> Dmitry
