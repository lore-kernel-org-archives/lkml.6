Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C6AC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE26620652
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE26620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbeH3BcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:32:13 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38682 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbeH3BcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:32:12 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fv85a-0005oK-2w; Wed, 29 Aug 2018 21:33:22 +0000
Date:   Wed, 29 Aug 2018 22:33:22 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Pirko <jiri@resnulli.us>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>
Subject: Re: [PATCH] net: sched: Fix memory exposure from short TCA_U32_SEL
Message-ID: <20180829213321.GA19965@ZenIV.linux.org.uk>
References: <20180826055801.GA42063@beast>
 <20180826061534.GT6515@ZenIV.linux.org.uk>
 <CAGXu5jK7VzayzZTcxgZBf-+YHWO+Hv7s8utj2rzTc3gFtA8pFQ@mail.gmail.com>
 <20180826173236.GU6515@ZenIV.linux.org.uk>
 <20180826225749.GY6515@ZenIV.linux.org.uk>
 <cb9d4e74-3498-48bd-45e0-05e925dbdb5b@mojatatu.com>
 <CAM_iQpVEyq9hR3bbOtLFKoLo6nHCtiL6A__uEz3JdDO79GF_8A@mail.gmail.com>
 <20180828000310.GE6515@ZenIV.linux.org.uk>
 <CAM_iQpXk48ip4dAKpc-HMwxf+wC6eYAK-atpsCSv7T7u7sLFMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpXk48ip4dAKpc-HMwxf+wC6eYAK-atpsCSv7T7u7sLFMw@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 12:07:09PM -0700, Cong Wang wrote:
> On Mon, Aug 27, 2018 at 5:03 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Mon, Aug 27, 2018 at 02:31:41PM -0700, Cong Wang wrote:
> > > > I cant think of any challenges. Cong/Jiri? Would it require development
> > > > time classifiers/actions/qdiscs to sit in that directory (I suspect you
> > > > dont want them in include/net).
> > > > BTW, the idea of improving grep-ability of the code by prefixing the
> > > > ops appropriately makes sense. i.e we should have ops->cls_init,
> > > > ops->act_init etc.
> > >
> > > Hmm? Isn't struct tcf_proto_ops used and must be provided
> > > by each tc filter module? How does it work if you move it into
> > > net/sched/* for out-of-tree modules? Are they supposed to
> > > include "..../net/sched/tcf_proto.h"?? Or something else?
> >
> > If you care about out-of-tree modules, that could easily live in
> > include/net/tcf_proto.h, provided that it's not pulled by indirect
> > includes into hell knows how many places.  Try
> > make allmodconfig
> > make >/dev/null 2>&1
> > find -name '.*.cmd'|xargs grep sch_generic.h
> >
> > That finds 2977 files here, most of them having nothing to do with
> > net/sched.
> 
> 
> Moving it to include/net/tcf_proto.h is fine, as out-of-tree modules
> can still compile by modifying the included header path.
> 
> include/net/pkt_cls.h might be a choice here too.

Nowhere near as massive exposure (123 files vs. 2977), but still - do
ethernet drivers need that?  Because that's 77 out of 123...
