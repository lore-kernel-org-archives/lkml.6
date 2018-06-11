Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 214EFC5CFF0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96F020660
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OqqlXAMT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C96F020660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934104AbeFKRSO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:18:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57786 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932108AbeFKRSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PflLm/5s/4TdX1CmxNF52ES2BiAgBh/MZmqin+q/9OI=; b=OqqlXAMT0s8+6FpdwfsHvu/8M
        rWNZ/kGM8/6FWxSu/fIGCmHCAR9NRxkmsc/bKN41rtV22TKQAQYKppT1SNC7WbRjzmDPqTPigAIoE
        DK6j0wUZ06K3elbRQWrlf5vhXr1vo+Y4j87ZWzSpA57XNMyFg0hgoQ2OZsnch54D8hQMvwsCBLYGn
        8Ym3472FlEOASbqgp5k8GrVALtmmI0DHoLTiTxfvQzM44hRHsBhkxd56IgLhaqRdkUWyE5t1dPLy7
        wwzWWElJVW1H2ZRUmn+dZMk4846NX5RzzFF9nmg5Wrr+RZQNBHiLcSJ9REKnsWh0V3T2pJWXaTw+x
        HOOCToJ4A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSQSJ-0007tx-UI; Mon, 11 Jun 2018 17:18:11 +0000
Date:   Mon, 11 Jun 2018 10:18:11 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
Subject: Re: perfmon trouble
Message-ID: <20180611171811.GB28292@bombadil.infradead.org>
References: <20180608184842.GD30522@ZenIV.linux.org.uk>
 <CA+55aFz9cS3m=wZxqKbzrCLEjhPoPddKw5U2MDKNqbG79Wx6bw@mail.gmail.com>
 <20180609051051.GF30522@ZenIV.linux.org.uk>
 <20180609155107.GH30522@ZenIV.linux.org.uk>
 <20180611021028.GT30522@ZenIV.linux.org.uk>
 <20180611162313.GA6942@infradead.org>
 <20180611164859.GA28292@bombadil.infradead.org>
 <CA+55aFykGPDTVN=UvrcDvwV3S_sixXREu8D7eK+x695OmA2PNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFykGPDTVN=UvrcDvwV3S_sixXREu8D7eK+x695OmA2PNw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 10:04:00AM -0700, Linus Torvalds wrote:
> On Mon, Jun 11, 2018 at 9:49 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > The problem is that even oprofile on ia64 depends on perfmon.
> 
> Hmm? You can definitely enable ia64 support for oprofile even without perfmon.

Oh, I think my memory is playing tricks on me.  This is my confusion, I think:

oprofile-$(CONFIG_PERFMON) += perfmon.o

so perfmon events are exposed through oprofile, but you can disable
perfmon without disabling oprofile.

> Because I'd be inclined to just remove CONFIG_PERFMON support, and see
> if anybody even notices..
> 
> I'm not expecting a lot of people to do a lot of oprofile on ia64
> anyway. It's a bit late to start optimizing things now.
> 
> Do people use perfmon still? Maybe. Maybe not. Perhaps we could just
> mark it as broken in the Kconfig file for now, and see if somebody
> says something?

That gets my vote.

Tony?  Fenghua?

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 792437d526c6..ff861420b8f5 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -455,6 +455,7 @@ config IA64_MCA_RECOVERY
 
 config PERFMON
        bool "Performance monitor support"
+       depends on BROKEN
        help
          Selects whether support for the IA-64 performance monitor hardware
          is included in the kernel.  This makes some kernel data-structures a

