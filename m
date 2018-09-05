Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB9FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C879820857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bPkic7G5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C879820857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbeIEXfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 19:35:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46748 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbeIEXfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 19:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Yy0aMVqxjghhI1mKLB2JyahWgF+sX+OHPJUlDSzKOv4=; b=bPkic7G5PWCu+KlH6OBJvNuKr
        XSRapgcPXbg/qMvOG/U/tQIVdNEFKFPjWN4BdB9GXZXttDBX0AFQC1Ovk/pIou0/sA2J+vNZl1G2A
        r1SrRbOeRLMabLwwutRDm1G+ySun04FmODi398PQm6gdlgvkckY3gg7gAQqcYSOFp0U+l2NXVKZx1
        awZW//Wf53bOmWEokM390p6jINeLmBIC6/0Z4w8P2olNLrUV1YQO+el9bXdEe4+7Enc3OeF6imjpg
        UW0UQFeF9kGJ4eSgsYqCrGRqKUw9Vsrbn7FpqC+jZALPAUz/l6MVwg3emglDe4o61CxL8t2vUrf3i
        p1f+UbQ+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxd5j-0000lB-E1; Wed, 05 Sep 2018 19:03:51 +0000
Date:   Wed, 5 Sep 2018 12:03:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "damein@vger.kernel.org" <damein@vger.kernel.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: [PATCH v2 2/3] RISC-V: Use Linux logical cpu number instead of
 hartid
Message-ID: <20180905190351.GB1420@infradead.org>
References: <1535445370-19004-1-git-send-email-atish.patra@wdc.com>
 <1535445370-19004-3-git-send-email-atish.patra@wdc.com>
 <20180831061104.GB19292@infradead.org>
 <ec0819d5-9dc6-6b25-47a9-cd9d9e5099a8@wdc.com>
 <20180904213654.GB2078@infradead.org>
 <d79833a8-98ae-fa19-9a7c-0afeb3d0bb92@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d79833a8-98ae-fa19-9a7c-0afeb3d0bb92@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 02:43:13PM -0700, Atish Patra wrote:
> On 9/4/18 2:36 PM, Christoph Hellwig wrote:
> > On Tue, Sep 04, 2018 at 01:35:10PM -0700, Atish Patra wrote:
> > > sure. How about this ?
> > 
> > That would work, but why not just keep calling sbi_remove_sfence_vma
> > directly from flush_tlb_all?
> > 
> I guess that's fine too. I just wanted to keep all flush_tlb_* same format
> to make it more coherent.

I'd just keep it simple by calling directly.  While the compiler would
probably optimize away the branch in an inline function we can just
avoid it entirely that way.
