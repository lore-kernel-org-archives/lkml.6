Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1FDC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF2620665
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbfAHWhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 17:37:50 -0500
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:43954 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728617AbfAHWhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 17:37:50 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1gh00I-0000S3-JR; Tue, 08 Jan 2019 23:37:46 +0100
Date:   Tue, 8 Jan 2019 23:37:46 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Anatol Pomozov <anatol.pomozov@gmail.com>
Cc:     fw@strlen.de, Dmitry Vyukov <dvyukov@google.com>,
        paulmck@linux.ibm.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: seqcount usage in xt_replace_table()
Message-ID: <20190108223746.shuwx3ro7cgwz7hh@breakpoint.cc>
References: <CAOMFOmU=t9YbE68YpoQn0Ug0XN1F+0iuJp9J=htCRRrbdaPSVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMFOmU=t9YbE68YpoQn0Ug0XN1F+0iuJp9J=htCRRrbdaPSVA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anatol Pomozov <anatol.pomozov@gmail.com> wrote:
> Or maybe xt_replace_table() can be enhanced? When I hear that
> something waits until an event happens on all CPUs I think about
> wait_event() function. Would it be better for xt_replace_table() to
> introduce an atomic counter that is decremented by CPUs, and the main
> CPU waits until the counter gets zero?

That would mean placing an additional atomic op into the
iptables evaluation path (ipt_do_table and friends).

Only alternative I see that might work is synchronize_rcu (the
_do_table functions are called with rcu read lock held).

I guess current scheme is cheaper though.
