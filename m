Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD70CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3AA20872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731147AbfAKK45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 05:56:57 -0500
Received: from foss.arm.com ([217.140.101.70]:52986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbfAKK45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 05:56:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02E5280D;
        Fri, 11 Jan 2019 02:56:57 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0C573F694;
        Fri, 11 Jan 2019 02:56:55 -0800 (PST)
Date:   Fri, 11 Jan 2019 10:56:53 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Konstantin Khlebnikov <koct9i@gmail.com>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net/core/neighbour: tell kmemleak about hash tables
Message-ID: <20190111105652.GA19375@arrakis.emea.arm.com>
References: <154693980088.104235.16222977463502002037.stgit@buzz>
 <CAM_iQpX1oiOiGFejO8yKNM_VT2BSMH9aFk-_1nPDjfO=jFmNgQ@mail.gmail.com>
 <CALYGNiOHu5gif7Kqgt_LCMBBOHq-LxffSFJGn6Joi6dccDfptQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALYGNiOHu5gif7Kqgt_LCMBBOHq-LxffSFJGn6Joi6dccDfptQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 07:26:09AM +0300, Konstantin Khlebnikov wrote:
> On Thu, Jan 10, 2019 at 11:45 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> > On Tue, Jan 8, 2019 at 1:30 AM Konstantin Khlebnikov
> > <khlebnikov@yandex-team.ru> wrote:
> > > @@ -443,12 +444,14 @@ static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
> > >         ret = kmalloc(sizeof(*ret), GFP_ATOMIC);
> > >         if (!ret)
> > >                 return NULL;
> > > -       if (size <= PAGE_SIZE)
> > > +       if (size <= PAGE_SIZE) {
> > >                 buckets = kzalloc(size, GFP_ATOMIC);
> > > -       else
> > > +       } else {
> > >                 buckets = (struct neighbour __rcu **)
> > >                           __get_free_pages(GFP_ATOMIC | __GFP_ZERO,
> > >                                            get_order(size));
> > > +               kmemleak_alloc(buckets, size, 0, GFP_ATOMIC);
> >
> > Why min_count is 0 rather than 1 here?
> 
> The api isn't clear and I've misread description.
> So it should be 1 for reporting leak of hash table itself.
> But 0 doesn't add any new issues.

Correct. I'd say it makes sense to set it to 1 so that you'd have
similar behaviour to the kzalloc() allocation.


-- 
Catalin
