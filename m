Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55586C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A84F217DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A84F217DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbeHUW6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 18:58:40 -0400
Received: from nautica.notk.org ([91.121.71.147]:44896 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbeHUW6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 18:58:40 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id C79A2C009; Tue, 21 Aug 2018 21:37:10 +0200 (CEST)
Date:   Tue, 21 Aug 2018 21:36:55 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Doron Roberts-Kedes <doronrk@fb.com>
Cc:     Tom Herbert <tom@quantonium.net>, Dave Watson <davejwatson@fb.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] strparser: remove any offset before parsing messages
Message-ID: <20180821193655.GA15354@nautica>
References: <1533854411-28184-1-git-send-email-asmadeus@codewreck.org>
 <1534855906-22870-1-git-send-email-asmadeus@codewreck.org>
 <20180821145321.GA44710@doronrk-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180821145321.GA44710@doronrk-mbp>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doron Roberts-Kedes wrote on Tue, Aug 21, 2018:
> There are a few issues with this patch. First, it seems like you're
> trying to fix bugs in users of strparser by changing an implementation
> detail of strparser.

Yes, that's why I have been writing since the original discussion that I
do not like this fix, but as I said in the other thread and v0 of this
patch I do not know how to tell the bpf function to start with an offset
in the skb in e.g. kcm_parse_func_strparser

I could add the pull in that function, but that feels a bit wrong on a
separation level to me.

> Second, this implementation change can add malloc's and copies where
> there were none before.

Yes I agree this is more than suboptimal for tls, I've also said that.


> If strparser users do not handle non-zero offset properly, then that
> doesn't motivate changing the implementation of strparser to copy
> around data to accomodate those buggy users. 
>
> Why not submit a patch that handles offset properly in the code you
> pointed out? 

One of the solutions I had suggested was adding a flag at strparser
setup time to only do that pull for users which cannot handle offset,
but nobody seemed interested two weeks ago. I can still do that.

That's still suboptimal, but I don't have any better idea.
To properly fix the users, I'd really need help with how bpf works to
even know if passing an offset would be possible in the first place, as
I do not see how at this time.


Thanks,
-- 
Dominique Martinet
