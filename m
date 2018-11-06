Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7BDC46464
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 06:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46DD820827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 06:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XmGyjmXs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46DD820827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387598AbeKFQXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 11:23:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52826 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387469AbeKFQW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 11:22:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Dd+b8IQmQmmRE6HUq8tX/PNCCErs5mlTNIq7kwrdtt0=; b=XmGyjmXsFguXJOCnYaxp1+RHK
        fuEdoGkYoMzrvCqC2lhcvy91kXBohZhKP4mlyf+rY8ocLo7sLcQdH1wOaFUesWFGQjmPlTvdIQo5w
        UUb+jcCxj3Dk2xydSjNbKGn0tHDgbJ6QxaLPfhy5na1KxahtenfxiQv6sOAuDJth2LjkNsvaxEvdW
        cXziQJvN4vLTXqswRyiOoe6CYiQlGFV6GWtGvoYqPcYLNqTlybqAym811IxoCovDoB6gtNjBc535e
        +ZeCzHIB9hV4v6Gv2AWzynRC1Fvx+hPHs6srtY59W/VYL+Fgop+LpKJyXbKpj8+VQctUteJ24JiIX
        sZQ7iWjSw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJvKR-0004sB-V2; Tue, 06 Nov 2018 06:59:11 +0000
Date:   Mon, 5 Nov 2018 22:59:11 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>, zong@andestech.com,
        aou@eecs.berkeley.edu, alankao@andestech.com,
        greentime@andestech.com, palmer@sifive.com,
        linux-kernel@vger.kernel.org,
        Vincent Chen <vincentc@andestech.com>, kito@andestech.com,
        linux-riscv@lists.infradead.org, deanbo422@gmail.com
Subject: Re: [RFC 0/2] RISC-V: A proposal to add vendor-specific code
Message-ID: <20181106065911.GB13526@infradead.org>
References: <CAAhSdy0Y_jdc=2Lf8epof_+7HigCfhDxMNe8EF0fHfncqhs-zA@mail.gmail.com>
 <mhng-01f0ac6a-c2fd-41be-9d53-44d1c139d453@palmer-si-x1c4>
 <20181101174857.du2zu4vnrhpu5asf@excalibur.cnev.de>
 <20181105065807.GA1286@andestech.com>
 <20181105070551.GA7274@infradead.org>
 <CAK8P3a2c98VVPArCkdAR=-nnDBq1gYRCLDDgQB71eGiTSRdb4A@mail.gmail.com>
 <20181105090852.GA14924@infradead.org>
 <CAK8P3a2MSK-S+AzDGjq6t8WjcKrkj0XmynNL+fMPvL=JgnoEVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2MSK-S+AzDGjq6t8WjcKrkj0XmynNL+fMPvL=JgnoEVA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 02:51:33PM +0100, Arnd Bergmann wrote:
> With the stricter policy you suggest, we'd loose the ability to support
> some extensions that might be common:
> 
> - an extension for user space that adds new registers that must be
>   saved and restored on a task switch, e.g. FPU, DSP or NPU
>   instructions. ARM supports several incompatible extensions like
>   that in one kernel, and this is really ugly, but I suspect RISC-V
>   will already need the same thing to support all combinations of
>   standard extensions, so from a practical perspective it's not
>   much different for custom extension, aside from the question
>   how far you want to go to discourage custom extensions by
>   requiring users to patch their kernels.

Palmer already explain that this is supposed to be handled by the
XS bit + SBI calls.  I'm personally not totally sold on the SBI call
and standard ways to save the state in the instruction set, similar
to modern x86 might be a better option, but that is something the
privileged spec working group will have to decide.

> - A crypto instruction for a cipher that is used in the kernel
>   for speeding up network or block data encryption.
>   This would typically be a standalone loadable module, so
>   the impact of allowing custom extensions in addition to
>   standard ones is minimal.

And that is a prime example for something that should never be vendor
specific.  If an instruction set extension is useful for something
entirely generic it should be standardized in a working group as an
extension.
