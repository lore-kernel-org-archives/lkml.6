Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F07AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 01:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F376520866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 01:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547600876;
	bh=ZKHy6uhrsc1OV/zqKQdyUh6VIzyaCN0wZnffuBGFBkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e72ZovYtD6vt4ZhyahLNtwbyhjHF5QAamOkuU9VYWfGpls2kZdpkDs7nXiNMIO7wz
	 Rr1fFJAd6ZtGN1UXtgvVU8dhMJ0Slhs+KFBGFh9PNXhrvELof8T5sUIqZILOT6f4+E
	 g87dOZvwz4nId1qGXVvvsES/GUW4Fv7fTSxAYmiU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfAPBHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 20:07:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:60966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbfAPBHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 20:07:46 -0500
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E848D20866;
        Wed, 16 Jan 2019 01:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547600865;
        bh=ZKHy6uhrsc1OV/zqKQdyUh6VIzyaCN0wZnffuBGFBkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iSVF+jmlly0DpAVrHjRwcPCszGEAXfIEG1TZOaVWJwPi831eV4DmFvN6v2TFacdCB
         sZ1Wmv465jpU8D0RxbB/zCWrnIDfO2Z8kCvG71AzzAL7ogcG2Nrx1qfpVmids6QIX0
         +7zvZDHEi3lES/o0TLybbFZo9j5YG0eRIb9gWWNI=
Date:   Wed, 16 Jan 2019 09:07:38 +0800
From:   Guo Ren <guoren@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>,
        Mao Han <mao_han@c-sky.com>
Subject: Re: [PATCH] riscv: fixup max_low_pfn with PFN_DOWN.
Message-ID: <20190116010738.GA4817@guoren-Inspiron-7460>
References: <1547280987-7630-1-git-send-email-guoren@kernel.org>
 <20190115153613.GC26443@infradead.org>
 <20190115161000.GA22705@guoren-Inspiron-7460>
 <20190115161254.GA19081@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115161254.GA19081@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

I use PFN_DOWN() every where as possible and seems it's a habit
problem. So let risc-v maintainer to choose "PFN_DOW()" or
">> PAGE_SHIFT".

Also the same with "end_of_DRAM & max_low_pfn".

Best Regards
 Guo Ren

On Tue, Jan 15, 2019 at 08:12:54AM -0800, Christoph Hellwig wrote:
> On Wed, Jan 16, 2019 at 12:10:00AM +0800, Guo Ren wrote:
> > > >  	set_max_mapnr(PFN_DOWN(mem_size));
> > > > -	max_low_pfn = memblock_end_of_DRAM();
> > > > +	max_low_pfn = PFN_DOWN(memblock_end_of_DRAM());
> > > 
> > > I know it is used just above, but can we please just switch this
> > > code to use >> PAGE_SHIFT instead of PFN_DOWN, which just horribly
> > > obsfucates what is going on?
> > ???
> > #define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
> > 
> > phys_addr_t __init_memblock memblock_end_of_DRAM(void)
> > {
> > 	int idx = memblock.memory.cnt - 1;
> > 
> > 	return (memblock.memory.regions[idx].base + memblock.memory.regions[idx].size);
> > }
> > 
> > What's the problem? PFN_DOWN() couldn't be used with function call?
> 
> PFN_DOWN gives you the correct result.  But I think it actually
> drastically reduces readability over just opencoding it.
> 
> > My patch just want to point out that max_low_pfn is PFN not size. In fact
> > there is no error for running without my patch :P
> 
> No, I think your patch is correct.  I just wonder if we could make
> the code easier to read.
