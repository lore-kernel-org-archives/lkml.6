Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF7FC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5F920671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:54:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5F920671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbeJXCSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 22:18:34 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50758 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeJXCSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 22:18:34 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 072A8147215DA;
        Tue, 23 Oct 2018 10:54:09 -0700 (PDT)
Date:   Tue, 23 Oct 2018 10:54:05 -0700 (PDT)
Message-Id: <20181023.105405.364015687995752826.davem@davemloft.net>
To:     jolsa@redhat.com
Cc:     dzickus@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: perf overlapping maps...
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181023063452.GB20075@krava>
References: <20181022161613.GF2945@krava>
        <20181022.105842.1364583912952511294.davem@davemloft.net>
        <20181023063452.GB20075@krava>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 23 Oct 2018 10:54:10 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>
Date: Tue, 23 Oct 2018 08:34:52 +0200

> I'm not sure about using the misc field bit defined/used by userland,
> in case there's some new one comming in future for fork event..
> 
> but the only other way I can think of now is adding new 'user' event
> for that, but that ended up as a bigger change (attached)
> 
> I think if we make some 'big enough' comment about the bit usage,
> your change is better.. will you post or should I?

There might be something else we can do to implement this, and I think
making a whole new event for what is an application internal problem
is overkill.

What is kind of silly about how all of the synthetic events work is
that we throw away a lot of information by tossing the events over to
the generic event processing engine of the perf tool.

So we generate the events knowing the thread, context, PID, cpu, etc.
and then we lose all of that information, and the event processing
engine has to look all of it up again.

This is also, BTW, the reason we have dependencies on synthetic event
emission ordering.  F.e. this comes up wrt. COMM and FORK events.

I understand that this design allows the perf tool types to define a
private function to dispatch the events, as is appropriate for what
the tool is doing.

But the side effect of this design is that it means it is hard to pass
internal state around, outside of the event object itself.

Anyways, I'll look into this and see if there is a better way to
implement this.

Thanks!
