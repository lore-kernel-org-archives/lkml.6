Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF00C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9922075B
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ShnQP+Q0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9922075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391351AbeKVMBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:01:49 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:43443 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729285AbeKVMBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 07:01:49 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 933D72120D;
        Wed, 21 Nov 2018 20:24:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 21 Nov 2018 20:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=+DqmAef9nynSzpToR29ufZifS3WEaqaPTIrDN/QrL
        hc=; b=ShnQP+Q0abDzOMhwD/kze1rhnUBYjj5deLGoz1vQsAMhApcnM2FgGscGs
        fJ3G5IxZFmRYlDB6gB4pKDZY9vjvnNiC71bA8oHFAICQHGAJl8KG1azBf66Xaa0I
        hOSS9TidIKQiYbSf6nYYlE/HcYgGLav6Q0kR6KuNhsHqWDpEHzgaQAqdHtIqr/p4
        yvgtUtHPYWEbPxEGTmaVtK4AR45dvBA/ebe6IF52ro1ySWrdNy/eKHBGuIBZ53HK
        UJABjY86JuFVljMdG8h1hjMKvbMIfV+BJbeXVHXCX6GRRA+eAroJdkBKBPgaSLYM
        Y4t5ZeYGA25dQVslxgxR30N9ZavJQ==
X-ME-Sender: <xms:YQX2W1QHVQiPYiOMX0MPnqP8wL3CWuYvG7bFshf9OvGMeavNnurdMw>
X-ME-Proxy: <xmx:YQX2WwC0XM31T37Cumu36r_TNvV9imcqI2faT3bD0Zi6CtHzHo4b1Q>
    <xmx:YQX2W2-yDf7TWJQvU4MM_8DLK4g22qz_naQxxnS2VNPVkr8FwW6vcQ>
    <xmx:YQX2W-7HsRa8_h7NHQyz2bjZvxGdbacYrmOBlAFmnpbBiXVcPL2PjA>
    <xmx:YQX2W0GgXvk3WfbaXcyqCfTijJdOwnTkMuVslperU9k63oYHLK3tBA>
    <xmx:YQX2W0kIAVAfB_yjvdtjDH3FFBWeM0rve2J_CEd-Ab1lzzLPRN0VGQ>
    <xmx:YwX2WzVMfCz1tWHJfaROqnG7OiajzYlUad--cpRbuLX8MKswWXgtfw>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id 39E78102DE;
        Wed, 21 Nov 2018 20:24:46 -0500 (EST)
Message-ID: <0d599e228d336c532b4d4bcde31be5f5565dce1b.camel@russell.cc>
Subject: Re: [RFC PATCH v1 5/6] powerpc/mm: Add a framework for Kernel
 Userspace Access Protection
From:   Russell Currey <ruscur@russell.cc>
To:     Christophe LEROY <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 22 Nov 2018 12:25:18 +1100
In-Reply-To: <f579dd05-975c-5e3f-1dd2-0702f1cf3fea@c-s.fr>
References: <ab8fcb458e1a6ad86382767b3ce7f7cc0d5b7121.1541568127.git.christophe.leroy@c-s.fr>
         <a8df3cd2be841ff5dd7b8d3fd357f40f9935f5a4.1541568128.git.christophe.leroy@c-s.fr>
         <d5aa6ff391c0438371cae507e0b82a96eec4e979.camel@russell.cc>
         <f579dd05-975c-5e3f-1dd2-0702f1cf3fea@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-11-21 at 09:32 +0100, Christophe LEROY wrote:
> 
> Le 21/11/2018 à 03:26, Russell Currey a écrit :
> > On Wed, 2018-11-07 at 16:56 +0000, Christophe Leroy wrote:
> > > This patch implements a framework for Kernel Userspace Access
> > > Protection.
> > > 
> > > Then subarches will have to possibility to provide their own
> > > implementation
> > > by providing setup_kuap(), and lock/unlock_user_rd/wr_access
> > > 
> > > We separate read and write accesses because some subarches like
> > > book3s32 might only support write access protection.
> > > 
> > > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > 
> > Separating read and writes does have a performance impact, I'm
> > doing
> > some benchmarking to find out exactly how much - but at least for
> > radix
> > it means we have to do a RMW instead of just a write.  It does add
> > some
> > amount of security, though.
> > 
> > The other issue I have is that you're just locking everything here
> > (like I was), and not doing anything different for just reads or
> > writes.  In theory, wouldn't someone assume that they could (for
> > example) unlock reads, lock writes, then attempt to read?  At which
> > point the read would fail, because the lock actually locks both.
> > 
> > I would think we either need to bundle read/write locking/unlocking
> > together, or only implement this on platforms that can do one at a
> > time, unless there's a cleaner way to handle this.  Glancing at the
> > values you use for 8xx, this doesn't seem possible there, and it's
> > a
> > definite performance hit for radix.
> > 
> > At the same time, as you say, it would suck for book3s32 that can
> > only
> > do writes, but maybe just doing both at the same time and if
> > implemented for that platform it could just have a warning that it
> > only
> > applies to writes on init?
> 
> Well, I see your points. My idea was not to separate read and write
> on platform that can lock both. I think it is no problem to also 
> unlocking writes when we are doing a read, so on platforms that can
> do 
> both I think both should do the same..
> 
> The idea was to avoid spending time unlocking writes for doing a read
> on 
> platforms on which reads are not locked. And for platforms able to 
> independently unlock/lock reads and writes, if only unlocking reads
> can 
> improve performance it can be interesting as well.
> 
> For book3s/32, locking/unlocking will be done through Kp/Ks bits in 
> segment registers, the function won't be trivial as it may involve
> more 
> than one segment at a time. So I just wanted to avoid spending time 
> doing that for reads as reads won't be protected. And may also be
> the 
> case on older book3s/64, may not it ?
> On Book3s/32, the page protection bits are as follows:
> 
>    Key	0	1
> PP
> 00	RW	NA
> 01	RW	RO
> 10	RW	RW
> 11	RO	RO
> 
> So the idea is to encode user RW with PP01 (instead of PP10 today)
> and 
> user RO with PP11 (as done today), giving Key0 to user and Key1 to 
> kernel (today both user and kernel have Key1). Then when kernel needs
> to 
> write, we change Ks to Key0 in segment register for the involved
> segments.
> 
> I'm not sure there is any risk that someone nests unlocks/locks for 
> reads and unlocks/locks for writes, because the unlocks/locks are
> done 
> in very limited places.

Yeah I don't think it's a risk since the scope is so limited, it just
needs to be clearly documented that locking/unlocking reads/writes
could have the side effect of covering the other.  My concern is less
about a problem in practice as much as functions that only don't
exactly do what the function name says.

Another option is to again have a single lock/unlock function that
takes a bitmask (so read/write/both), which due to being a singular
function might be a bit more obvious that it could lock/unlock
everything, but at this point I'm just bikeshedding.

Doing it this way should be fine, I'm just cautious that some future
developer might be caught off guard.

Planning on sending my series based on top of yours for radix today.

- Russell

> 
> Christophe
> 
> 
> > Curious for people's thoughts on this.
> > 
> > - Russell
> > 

