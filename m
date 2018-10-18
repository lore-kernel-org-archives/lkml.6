Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FF7ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 10:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3892083A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 10:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YEcguvcg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3892083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbeJRSOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 14:14:08 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:40731 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727500AbeJRSOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 14:14:06 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id DA5FEC53;
        Thu, 18 Oct 2018 06:13:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 18 Oct 2018 06:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=FT3Aff
        YcIxXaCvuX6OmjnsaFBL2PGZhLnWvE3Qa0Ua8=; b=YEcguvcgvFObsU0I5BDQkO
        j7VhPlLWnO8kZFtWMeHv069+5kNYtYgbavj0Z+WDTSTMRTUygiGqcDIb1G2d1JNB
        y+sFeNCMqKOFVn/82w9JE7IletW2Ajom4e/5kAN1Z0vAWZQUu/+MtBxSiefM/QvK
        qlk3+iKPMj5QFZF1I9CE4aBiyVQ1L4FpSu1+4KLRmqBzp3EO11QdGQZaI8R9SIs9
        wrTx2mDd891TfqRSFKw/Bht2jusWhGyM2/nGHnif1MXTBxyustYc2w+VadhEiqvf
        VcMloLF3Tt7GRBxO0dhrdtNpXRIcXt5+j6TX4R/Q5Yvx/0czjdTDjlJahmM16Dnw
        ==
X-ME-Sender: <xms:21zIW4W_HG7pdCOi_-ijBNMs21Dp92-OLtdTU82b42xgjySxg-1qPw>
X-ME-Proxy: <xmx:21zIW4iBpPzLVxvZTqBtkhBXV5MVH7hqRfHxpVQK7ckopBrcIIFScQ>
    <xmx:21zIW1vae9ccHvQWXhqJUVjQH5z3ZPWe11JSbeWUwPAuSmWIrDRCMQ>
    <xmx:21zIWwUjvJ5ayyVeWPaUI1UxNSyvHBAg8cwTNTVNhvvGBBE6IIY2zA>
    <xmx:21zIW9aj7Ual6a7-FjD0AvsR56R8j3UUoNg7UQNZ40vme9s2hdLZkA>
    <xmx:21zIW6tOEuX3WVvlp3EXunREGTV6nB2cHfmj7V8Ua7lKRnQS1Dginw>
    <xmx:21zIW0aCTyCNNNcrBrO146xazvGeps5OZZMYS29ZRLjzFGnnYpfFow>
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        by mail.messagingengine.com (Postfix) with ESMTPA id D193F102A0;
        Thu, 18 Oct 2018 06:13:46 -0400 (EDT)
Date:   Thu, 18 Oct 2018 12:03:08 +0200
From:   Greg KH <gregkh@linux-foundation.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Kiran Kumar Modukuri <kiran.modukuri@gmail.com>,
        syzbot+a95b989b2dde8e806af8@syzkaller.appspotmail.com,
        stable@vger.kernel.org, Eric Sandeen <sandeen@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] FS-Cache: Miscellaneous fixes
Message-ID: <20181018100308.GA8451@kroah.com>
References: <153978619457.8478.3813964117489247515.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153978619457.8478.3813964117489247515.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 03:23:14PM +0100, David Howells wrote:
> 
> Attached are another couple of miscellaneous fixes for FS-Cache and
> CacheFiles:
> 
>  (1) Fix a race between object burial in cachefiles and external rmdir.
> 
>  (2) Fix a race from a split atomic op.
> 
>  (3) Fix incomplete initialisation of cookie key space.
> 
>  (4) Fix out-of-bounds read.

Patches 1, 3, and 4 are now merged, thanks.  I didn't pull from you as
patch 2 needed to be dropped according to the thread.

thanks,

greg k-h
