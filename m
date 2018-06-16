Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83EBC5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 19:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C6B2088E
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 19:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C6B2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932967AbeFPTQe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 15:16:34 -0400
Received: from smtprelay0095.hostedemail.com ([216.40.44.95]:60981 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932542AbeFPTQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 15:16:33 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 1C45C837F242;
        Sat, 16 Jun 2018 19:16:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: price38_55da5ed9c1d49
X-Filterd-Recvd-Size: 2581
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Sat, 16 Jun 2018 19:16:29 +0000 (UTC)
Message-ID: <0a3d86d7746792a2f848cef386941fc182653515.camel@perches.com>
Subject: Re: [PATCH v2 5/5] Input: evdev - Switch to bitmap_zalloc()
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Yury Norov <ynorov@caviumnetworks.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        agk@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, shli@kernel.org, linux-raid@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input <linux-input@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Date:   Sat, 16 Jun 2018 12:16:28 -0700
In-Reply-To: <CAHp75VcxYPCLYq1J8qqjPdgDdQnWDgZKkavmyEWD8GNxcW2mWg@mail.gmail.com>
References: <20180615132017.23889-1-andriy.shevchenko@linux.intel.com>
         <20180615132017.23889-6-andriy.shevchenko@linux.intel.com>
         <20180615214231.GA371@yury-thinkpad>
         <CAHp75VcxYPCLYq1J8qqjPdgDdQnWDgZKkavmyEWD8GNxcW2mWg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-06-16 at 21:45 +0300, Andy Shevchenko wrote:
> On Sat, Jun 16, 2018 at 12:46 AM Yury Norov <ynorov@caviumnetworks.com> wrote:
> > On Fri, Jun 15, 2018 at 04:20:17PM +0300, Andy Shevchenko wrote:
> > > Switch to bitmap_zalloc() to show clearly what we are allocating.
> > > Besides that it returns pointer of bitmap type instead of opaque void *.
> 
> 
> > > +       mem = bitmap_alloc(maxbit, GFP_KERNEL);
> > >         if (!mem)
> > >                 return -ENOMEM;
> > 
> > But in commit message you say you switch to bitmap_zalloc(). IIUC
> > bitmap_alloc() is OK here. But could you please update comment to
> > avoid confusing.
> 
> There are two places, one with alloc, another with zalloc.
> I will clarify this in commit message of next version.
> 
> > > +       mask = bitmap_zalloc(cnt, GFP_KERNEL);
> > >         if (!mask)
> > >                 return -ENOMEM;
> > > 
> > >         error = bits_from_user(mask, cnt - 1, codes_size, codes, compat);
> > 
> > If my understanding of bits_from_user() correct, here you can also use
> > bitmap_alloc(), true?

Also it might be useful to have a separate bitmap_from_user
to alloc and copy.

