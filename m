Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1A1C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0CC217D0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0CC217D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbeHDL3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:29:10 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:36530 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbeHDL3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:29:10 -0400
Received: by mail-ua0-f195.google.com with SMTP id c12-v6so7058952uan.3;
        Sat, 04 Aug 2018 02:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1W09M69y5Ysz7nMJ7EGGzp+dDUt3+tBBhUYBcJDiksY=;
        b=TOSrX5o4iR0JmK+F6F2x8/RvGrXLrsqWr/7Z6DChnBYxmG6nuVMnSEGpt/gRREAggu
         YDRIqBfMfc+VQqOXy/ObXIIhMU/o10K9ZhoVKmxd6BPsZnLkDvAl4s5BnQm/4snXpl/N
         jPUgBcMtwA4xuucF3HOGobCOG5CctNRawqABoE6Wb7inQZzbohwkGrACaeDW0xeQBRYR
         1XnphMNmJDgvt3n1I4KHpxMC2C/MWgulFCbyb3cDXI/9YnfIhq1Kn6jHj8xX2q09jJq8
         M6zoIjT220328L+g3GR6GvO2gvIMZiVhVhXojptXwDaL8OKjgJmGL0H+h+W11GYnlTql
         9Ftw==
X-Gm-Message-State: AOUpUlF3EF27N2/NNfHIezIAC0j/8fIafCnNd/iva03ngYEuUH64viZk
        og3Uq2hSXUqtNeZ7TCYTwbURy/MF3zMFbVsDB1k=
X-Google-Smtp-Source: AAOMgpfZVXdNBZiXcHrRxmVksot8p6lmT4s+en9kYQBU2hQwkOHWyiujBfWeAdjGntGTpcqEbXOTPMTMo60hhTNc430=
X-Received: by 2002:ab0:80e:: with SMTP id a14-v6mr5457002uaf.114.1533374944582;
 Sat, 04 Aug 2018 02:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180411060320.14458-1-willy@infradead.org> <20180411060320.14458-3-willy@infradead.org>
 <alpine.DEB.2.20.1804110842560.3788@nuc-kabylake> <20180411192448.GD22494@bombadil.infradead.org>
 <alpine.DEB.2.20.1804111601090.7458@nuc-kabylake> <20180411235652.GA28279@bombadil.infradead.org>
 <alpine.DEB.2.20.1804120907100.11220@nuc-kabylake> <20180412142718.GA20398@bombadil.infradead.org>
 <20180412191322.GA21205@bombadil.infradead.org> <20180803212257.GA5922@roeck-us.net>
 <20180803223357.GA23284@bombadil.infradead.org>
In-Reply-To: <20180803223357.GA23284@bombadil.infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 4 Aug 2018 11:28:52 +0200
Message-ID: <CAMuHMdXXYH_7oVJJ5sGWFj_-WbjuMdooXTqBfV+z0CzR193T3A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] slab: __GFP_ZERO is incompatible with a constructor
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Christoph Lameter <cl@linux.com>,
        Linux MM <linux-mm@kvack.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, jlayton@redhat.com,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 4, 2018 at 12:34 AM Matthew Wilcox <willy@infradead.org> wrote:
> On Fri, Aug 03, 2018 at 02:22:57PM -0700, Guenter Roeck wrote:
> > On Thu, Apr 12, 2018 at 12:13:22PM -0700, Matthew Wilcox wrote:
> > > From: Matthew Wilcox <mawilcox@microsoft.com>
> > > __GFP_ZERO requests that the object be initialised to all-zeroes,
> > > while the purpose of a constructor is to initialise an object to a
> > > particular pattern.  We cannot do both.  Add a warning to catch any
> > > users who mistakenly pass a __GFP_ZERO flag when allocating a slab with
> > > a constructor.
> > >
> > > Fixes: d07dbea46405 ("Slab allocators: support __GFP_ZERO in all allocators")
> > > Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > > Acked-by: Michal Hocko <mhocko@suse.com>
> >
> > Seen with v4.18-rc7-139-gef46808 and v4.18-rc7-178-g0b5b1f9a78b5 when
> > booting sh4 images in qemu:
>
> Thanks!  It's under discussion here:
>
> https://marc.info/?t=153301426900002&r=1&w=2

and https://www.spinics.net/lists/linux-sh/msg53298.html

> also reported here with a bogus backtrace:
>
> https://marc.info/?l=linux-sh&m=153305755505935&w=2
>
> Short version: It's a bug that's been present since 2009 and nobody
> noticed until now.  And nobody's quite sure what the effect of this
> bug is.
Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
