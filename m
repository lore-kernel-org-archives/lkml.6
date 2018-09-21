Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04017C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B107C21531
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dc2q6qoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B107C21531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389302AbeIUL5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 07:57:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47368 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388944AbeIUL5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 07:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cg03QiRjf+HUQPKf/1TFGUUl54s7S7du4g8XL+t6vRk=; b=dc2q6qoqIxXBTE9q6iHSZxC8fR
        L2vj/KvmnIDkDtqwbwObTedmdHm3RyBP7J+FiXkATIqzjeITQejJpjy2Cp6xHFHN//AFXQB8pORUi
        +qUAkfLC+9AIEdw5r39uOVrf+ng0J3wwU7v9fiseqtjPSEHOjiM6Fpt1N1EaROP5qvy7YpSDFJtSw
        NcCO4/G42OVfq+YXydx3/3HZJffEQiGYsV8yR9ZBOlWUn8l3mfjZPUcM2w3tZjeHBfj941+o9cMCZ
        dFa+UDOsrsHn1Bx72snk6HTHx6dYsXCW4s98nO67BVygNZ1Bh+Mn2MCBYW1y1o6Gzr13GzqJ6J4Ed
        ZZotdvBQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g3EdJ-00026K-EN; Fri, 21 Sep 2018 06:09:41 +0000
Date:   Thu, 20 Sep 2018 23:09:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Firoz Khan <firoz.khan@linaro.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: Re: [PATCH 0/3] System call table generation support
Message-ID: <20180921060941.GB13865@infradead.org>
References: <1536914314-5026-1-git-send-email-firoz.khan@linaro.org>
 <20180917171720.wda5qrl7hyyacmwl@pburton-laptop>
 <CAK8P3a1=BriZ7hgzgK4QpAT00MBEtXaKOSU+vdHN1=5owB9i4A@mail.gmail.com>
 <20180920204833.gpypjjxcmxjupls6@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180920204833.gpypjjxcmxjupls6@pburton-laptop>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 08:48:37PM +0000, Paul Burton wrote:
> > Speaking of nanoMIPS, what is your plan for the syscall ABI there?
> > I can see two ways of approaching it:
> > 
> > a) keep all the MIPSisms in the data structures, and just use a subset of
> >     o32 that drops all the obsolete entry points
> > b) start over and stay as close as possible to the generic ABI, using the
> >     asm-generic versions of both the syscall table and the uapi header
> >     files instead of the traditional version.
> 
> We've taken option b in our current downstream kernel & that's what I
> hope we'll get upstream too. There's no expectation that we'll ever need
> to mix pre-nanoMIPS & nanoMIPS ISAs or their associated ABIs across the
> kernel/user boundary so it's felt like a great opportunity to clean up &
> standardise.
> 
> Getting nanoMIPS/p32 support submitted upstream is on my to-do list, but
> there's a bunch of prep work to get in first & of course that to-do list
> is forever growing. Hopefully in the next couple of cycles.

p32 is just the ABI name for nanoMIPS or yet another MIPS ABI?

Either way, І think if there is yet another ABI even on an existing port
we should always aim for the asm-generic syscall table indeed.

Especially for mips where o32 has a rather awkward ABI only explained by
odd decisions more than 20 years ago.
