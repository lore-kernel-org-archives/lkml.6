Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D7EC10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E092184D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="JuyoTIIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfBZPPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:15:52 -0500
Received: from a9-32.smtp-out.amazonses.com ([54.240.9.32]:48736 "EHLO
        a9-32.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726222AbfBZPPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 10:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1551194150;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=PLVgO+c/ksXQb0z1YKKNh9eSmG21/bkZ8P7aGZVkmZE=;
        b=JuyoTIIcD8txoIZN2v41dqigGwuCwFeamHQYH1nFqXaLUN6ydM49m8YpFEO1SW/V
        fS5QE5vWi9q9Edfw/orCnpJeZugTmcjKEix+fxI9r4jk+bE2EKkKw4ao5sviXIZHQRQ
        vdMUA5jYCL1JzaULPCIgrIMBqQG2rBy5/xcfNGIY=
Date:   Tue, 26 Feb 2019 15:15:50 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     "dennis@kernel.org" <dennis@kernel.org>
cc:     Peng Fan <peng.fan@nxp.com>, "tj@kernel.org" <tj@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: Re: [PATCH 2/2] percpu: km: no need to consider
 pcpu_group_offsets[0]
In-Reply-To: <20190225151616.GB49611@dennisz-mbp.dhcp.thefacebook.com>
Message-ID: <010001692a605709-407cf476-e7b6-43be-8551-66c54059e92f-000000@email.amazonses.com>
References: <20190224132518.20586-1-peng.fan@nxp.com> <20190224132518.20586-2-peng.fan@nxp.com> <20190225151616.GB49611@dennisz-mbp.dhcp.thefacebook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.02.26-54.240.9.32
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2019, dennis@kernel.org wrote:

> > @@ -67,7 +67,7 @@ static struct pcpu_chunk *pcpu_create_chunk(gfp_t gfp)
> >  		pcpu_set_page_chunk(nth_page(pages, i), chunk);
> >
> >  	chunk->data = pages;
> > -	chunk->base_addr = page_address(pages) - pcpu_group_offsets[0];
> > +	chunk->base_addr = page_address(pages);
> >
> >  	spin_lock_irqsave(&pcpu_lock, flags);
> >  	pcpu_chunk_populated(chunk, 0, nr_pages, false);
> > --
> > 2.16.4
> >
>
> While I do think you're right, creating a chunk is not a part of the
> critical path and subtracting 0 is incredibly minor overhead. So I'd
> rather keep the code as is to maintain consistency between percpu-vm.c
> and percpu-km.c.

Well it is confusing if there the expression is there but never used. It
is clearer with the patch.

