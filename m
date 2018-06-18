Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416C8C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA09E20836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA09E20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935899AbeFRUk1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 16:40:27 -0400
Received: from smtprelay0114.hostedemail.com ([216.40.44.114]:33972 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755326AbeFRUkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 16:40:25 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 6737A18225645;
        Mon, 18 Jun 2018 20:40:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bells69_3d6f8845e4b26
X-Filterd-Recvd-Size: 2246
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Mon, 18 Jun 2018 20:40:22 +0000 (UTC)
Message-ID: <0ac0c93919e40d0c610419fa12e852e889d490e6.camel@perches.com>
Subject: Re: [PATCH v2 5/5] Input: evdev - Switch to bitmap_zalloc()
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yury Norov <ynorov@caviumnetworks.com>, agk@redhat.com,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        shli@kernel.org, linux-raid@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input <linux-input@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Date:   Mon, 18 Jun 2018 13:40:20 -0700
In-Reply-To: <CAHp75VcJLEmDTe0bCx7UkH4xMH44VUrvuFqdc++OYyE-JKd_cg@mail.gmail.com>
References: <20180615132017.23889-1-andriy.shevchenko@linux.intel.com>
         <20180615132017.23889-6-andriy.shevchenko@linux.intel.com>
         <20180615214231.GA371@yury-thinkpad>
         <CAHp75VcxYPCLYq1J8qqjPdgDdQnWDgZKkavmyEWD8GNxcW2mWg@mail.gmail.com>
         <0a3d86d7746792a2f848cef386941fc182653515.camel@perches.com>
         <8cfbdf809f531f8aa315fe1679c3273858038f41.camel@linux.intel.com>
         <780cba4e119110f2d2a81e237874592cff4d7868.camel@perches.com>
         <CAHp75VcJLEmDTe0bCx7UkH4xMH44VUrvuFqdc++OYyE-JKd_cg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-18 at 22:56 +0300, Andy Shevchenko wrote:
> On Mon, Jun 18, 2018 at 6:49 PM, Joe Perches <joe@perches.com> wrote:
> > Perhaps bitmap_dup_user [or some better name] could or should
> > be one of the helpers.
> 
> Can you help with estimation how many existing users need this kind of
> functionality? One of them evdev, which has an open coded variant.

My estimation via cocci script below is 1 existing user,
so it's almost certainly not worthwhile.

$ cat copy_from_user.cocci 
@@
unsigned long *p;
expression e1, e2;
@@

*	copy_from_user(p, e1, e2)

