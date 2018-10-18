Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806BBECDE3D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 02:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B742145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 02:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="Xljqpano"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B742145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbeJRKWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 06:22:44 -0400
Received: from imap.thunk.org ([74.207.234.97]:57582 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbeJRKWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 06:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=avVE5TMTFu5lhOqr5CydJgueCuSDUun9MePu/llXxB8=; b=XljqpanoJiXXyN21dl1I9Vmr0Y
        1rv+76FMCDgJB3WLb5o6uKqnKJlyKH5UD3H9k/BHRAPrmt5P8B6Wt+0kEBQiqO5V+HrychMrh1tLw
        RIhUYT6ZWLa0lAGOL2I/bx4A/Zhaj3S8fyJfyjTmRuMyxq/+gPNz7G77z4t8TH/bF9LI=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gCxyj-0006wh-1x; Thu, 18 Oct 2018 02:24:01 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9E1557A519A; Wed, 17 Oct 2018 22:23:59 -0400 (EDT)
Date:   Wed, 17 Oct 2018 22:23:59 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     liu.song11@zte.com.cn, fishland@aliyun.com, wang.yi59@zte.com.cn,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ext4: direct return when jinode allocate failed
Message-ID: <20181018022359.GA12382@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>, liu.song11@zte.com.cn,
        fishland@aliyun.com, wang.yi59@zte.com.cn,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181016145526.3288-1-fishland@aliyun.com,20181016190840.GF24131@thunk.org>
 <201810171026448096961@zte.com.cn>
 <EA9B5AA4-DA21-4B1D-9E89-8C9F16EB8986@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EA9B5AA4-DA21-4B1D-9E89-8C9F16EB8986@dilger.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 05:28:55PM -0600, Andreas Dilger wrote:
> 
> Looking at the patch there are two effects that it has:
> - optimize a very rare case where there is an allocation failure before locking
> - return an unnecessary error if "ei->jinode" is allocated before locking
> 
> I don't think it is worthwhile to optimize this case, since allocation failures
> will have a serious impact on the application, and I'd rather avoid the rare
> case where we don't return an unnecessary error than make the error case faster.

To be fair, the "unnecessery error" case is also extremely rare.  In
order for that to happen, two processes would need to be racing to
allocate allocate the jinode structure for an inode (since we bail
earlier when we check for the ei->jinode == NULL case before we take
the lock), where the first process succeeds in allocating memory ---
but the second one fails.

Both of these are super-rare cases, and involve the system thrashing
due to super-high memory pressure --- at which point worrying about a
micro-optimization or an unnecessary failure is going to be the last
of the system's problem.

This is why I said, "the patch probably doesn't hurt, but I also don't
see it helping much".

Cheers,

						- Ted
