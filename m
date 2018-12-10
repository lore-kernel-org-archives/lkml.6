Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2602DC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF96B20821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF96B20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeLJMra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 07:47:30 -0500
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:57730 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726664AbeLJMra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 07:47:30 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1gWKy4-0007kE-6g; Mon, 10 Dec 2018 13:47:24 +0100
Date:   Mon, 10 Dec 2018 13:47:24 +0100
From:   Florian Westphal <fw@strlen.de>
To:     syzbot <syzbot+592df0494801b6648ec6@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Subject: Re: INFO: rcu detected stall in xfrm_hash_rebuild
Message-ID: <20181210124724.iuver2va3yjdsokf@breakpoint.cc>
References: <00000000000075fe86057ca6367e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000075fe86057ca6367e@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot <syzbot+592df0494801b6648ec6@syzkaller.appspotmail.com> wrote:
> Hello,
> 
> syzbot found the following crash on:
[..]

> Workqueue: events xfrm_hash_rebuild

Ignoring this report for a second -- I think it makes sense to see
if we can just remove the entire hash table rebuild/resize code.

After recent tree conversion, we could probably make the exact policies
part of the 'inexact tree' (which would be renamed to 'policy tree' or
some such).

Special-casing the exact policies made a lot of sense when we had
a single list for the inexact policies (to keep its length down).

But now I think we could try to unify all of this and only maintain
the existing tree-based storage.

Would also remove the need to do lookups in two different
data structures (bydst-hash-then-inexact-tree).

What do you think?
