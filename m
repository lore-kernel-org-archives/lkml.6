Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F15C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 20:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F70208D9
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 20:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nBWpc/nI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F70208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932545AbeGHUXY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 16:23:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33652 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754234AbeGHUXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 16:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Fn55o0hCMnUuE1FhTwWwE/i1pPyTfsiY9UbT26TOnwE=; b=nBWpc/nIdsCeGj2++HVLHrxF0
        yEMi0IUK9Hpi+E4Z7R3g3h60xfX0hqqKSlhVH62ipvonLF5xglpXqtBvh0+9vOJ02ZFzzG3/su1px
        c2bQgBIS3AE15xhocHAZcUk7jNPp11t88nRMRDHOmfRUZWKvfGAh3bumx+xLJ89KcRlPqPpryAQku
        elcSVH+qZr4UQ7QhLhEFwfaYFNi4hj1Q9d0AkKE8z97xxjKFsfNHbm7DXUCujuO1CiQ0D0Lj/wfPb
        KbHYgLtnavF+qausS7n4zJ60ngXfebxO9xV0rUN9TTo/Fj1mbYDgvN3scOuJyqR8H5KYVv053LVy3
        kZGa0PeIQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcGDD-0000ep-9R; Sun, 08 Jul 2018 20:23:15 +0000
Date:   Sun, 8 Jul 2018 13:23:15 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Tejun Heo <tj@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
        Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] block: Create scsi_sense.h for SCSI and ATAPI
Message-ID: <20180708202315.GA2239@infradead.org>
References: <CAGXu5j+mgGZkTDS6EDRspJKKbU=vMT4ehv9T-SekPba=ESoGDg@mail.gmail.com>
 <9A0BC289-4203-4C77-A012-AAB07F42061F@kernel.dk>
 <CAGXu5jJsGWDsZNDJvUUqncSaAcvond_B_J7=BbvVW0X3r6Sxww@mail.gmail.com>
 <aa150272-ffeb-fb8f-7303-0d9502cf9a71@kernel.dk>
 <20180523142545.GA16248@infradead.org>
 <24d36869-e037-042d-cb16-20a81b34eb76@kernel.dk>
 <CAGXu5jJn=1Rz=D8VUwv_VoaGoLtaD=+tcPZxQxntweZoZwFa5Q@mail.gmail.com>
 <f4eb4cd5-8976-3990-69b0-26cca054aa45@kernel.dk>
 <20180524080015.GA2866@infradead.org>
 <CAGXu5j+pRUWgny+h5ToVQXBP8nANjreVhnXjk5TVgy84ufNsRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+pRUWgny+h5ToVQXBP8nANjreVhnXjk5TVgy84ufNsRg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 10:06:59AM -0700, Kees Cook wrote:
> On Thu, May 24, 2018 at 1:00 AM, Christoph Hellwig <hch@infradead.org> wrote:
> > On Wed, May 23, 2018 at 03:14:19PM -0600, Jens Axboe wrote:
> >> Ugh, so that would necessitate a change there too. As I said before,
> >> I don't really care where it lives. I know the SCSI folks seem bothered
> >> by moving it, but in reality, it's not like this stuff will likely ever
> >> really change. Of the two choices (select entire SCSI stack, or just move
> >> this little bit), I know what I would consider the saner option...
> >
> > Oh well.  How about something like this respin of Kees' series?
> >
> > http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/sense-cleanup
> 
> Does the CONFIG_PCMCIA in drivers/scsi/Makefile now get exposed in
> weird config cases?
> 
> Otherwise, yeah, looks good to me. Thanks!

Btw, did you plan to resend the series with this and your changes
applied?
