Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C336313F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF0F20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:24:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF0F20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbeG3L6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:58:24 -0400
Received: from nautica.notk.org ([91.121.71.147]:37439 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbeG3L6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:58:24 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id BB95FC009; Mon, 30 Jul 2018 12:24:04 +0200 (CEST)
Date:   Mon, 30 Jul 2018 12:23:49 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     davem@davemloft.net, v9fs-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com
Subject: Re: [PATCH] 9p: fix Use-After-Free in p9_write_work()
Message-ID: <20180730102349.GA31932@nautica>
References: <20180729130248.29612-1-tomasbortoli@gmail.com>
 <20180729233336.GB28684@nautica>
 <4ac26f97-778b-6527-9a5b-08b7bfc8a5e8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ac26f97-778b-6527-9a5b-08b7bfc8a5e8@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Bortoli wrote on Mon, Jul 30, 2018:
> > Other transports also have the same issue see discussion in
> > https://lkml.org/lkml/2018/7/19/727
> > (that is another syzbot report, slightly different but I believe it
> > points to the same issue)
> > 
> > Basically, a more global view of the problem is a race between
> > p9_tag_lookup returning a p9_req_t and another thread freeing it.
> > 
> > Matthew wrote the problem himself in a comment in p9_tag_lookup in his new
> > version that used to be in linux-next at the time (I took the commit out
> > temporarily until I've had time to benchmark it, but it will come back in,
> > just you're working on thin air right now because the bug was only found
> > thanks to this commit):
> > +       /* There's no refcount on the req; a malicious server could
> > cause
> > +        * us to dereference a NULL pointer
> > +        */
> > 
> > So a more proper solution would be to had a refcount to req, have
> > p9_tag_lookup increment the refcount within rcu_read_lock, and have a
> > deref function free the req when the count hits 0.
> 
> Which commit ? that's a comment.

Sorry, the commit is this one:
http://lkml.kernel.org/r/20180711210225.19730-6-willy@infradead.org

It's now out of my 9p-next branch due to performance reasons but I'll
definitely take it back in once my performance mitigation patches have
had a few reviews.

> That sound like the proper solution. Let's do it that way then.

Cool :)

-- 
Dominique
