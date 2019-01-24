Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401C3C282C0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 02:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C43F217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 02:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lCyVnoKI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfAXCAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 21:00:38 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38886 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfAXCAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 21:00:37 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so2159990pfi.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 18:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=YBIIZ8XOcYpaFmWKBLCH70Y4SkewX00OSYFAAy95m8A=;
        b=lCyVnoKIkk13kXnT5OyBWlkSBrMkjmiKfZb1cw8X7hf/TaVeMiXGHG2vGBHbjUY0vl
         3Dzm18NzkKFFaSB8vx31/DYYZGug1K1gZsuggbRZnysemxJcO8q6ty9NWUduAM1tXhuw
         +pRzYFA8K9IisgQCQ5gfHIAtHEbYbMcY5RrXiCEBrastikdjo/phXweL+VSMip1xVEju
         7bUNeaNkwY7C9tbWIu2jOmmir9+9xaAVyWUoUISUow5fJ2gacNQHvqpe84LTEsR8K8D6
         7rM2vxHhpRWQ//2oCAG4+IYAQws+HLByct+pQ6rGiBA0MnVJCFZvTxG8NDXR6hZC5Hwo
         stFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=YBIIZ8XOcYpaFmWKBLCH70Y4SkewX00OSYFAAy95m8A=;
        b=YkEgX35EcYwskcjFS1OrpV2aRYMAbhMLkV5mGkiJsnyBEGwyXUm7Yn/RvOi/neO6PQ
         P1BeZcO569aMy3POmoyVFWnxzMMgFeZZPdZUQJxXicIcA3VQ38bULrAtL0WRHC7cIGbm
         705wHofgH2cJm3bJ9CfszVGkUz8fUAvZyyrzPMdcWSvwQA11FrunvKy/KpWSpQRoWRHd
         vdQr9AVNsRuM1UMGBG2RDi9McifFRpwLLh+mffcFKauCmgo3PA2pIuwYtsEmJ96FkBP4
         uloF6EhIxVY98efsY2UYFuV3QJit8nT49vfvHm3p7HyBNPjhepOHTd+MmLNqXLM8cgue
         l4Iw==
X-Gm-Message-State: AJcUukekB/8NTaur9FQoMxEY7Z933dpKYDep4JUQDyVGzvNrpStZRbr3
        Nv8ktHa1JXCW9P8w0ZwNZy9cYw==
X-Google-Smtp-Source: ALg8bN5pgBtXEUSLj8HFEq6LKlFYqjruRT616qmbOBJP+tc2RuQaPabbDF8zenhzJ/HlBucBhGxPHw==
X-Received: by 2002:a62:2b8b:: with SMTP id r133mr4477658pfr.246.1548295236700;
        Wed, 23 Jan 2019 18:00:36 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id f20sm24636364pfn.177.2019.01.23.18.00.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 18:00:35 -0800 (PST)
Date:   Wed, 23 Jan 2019 18:00:35 -0800 (PST)
X-Google-Original-Date: Wed, 23 Jan 2019 17:51:28 PST (-0800)
Subject:     Re: [PATCH] riscv: fixup max_low_pfn with PFN_DOWN.
In-Reply-To: <20190116010738.GA4817@guoren-Inspiron-7460>
CC:     Christoph Hellwig <hch@infradead.org>, aou@eecs.berkeley.edu,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, ren_guo@c-sky.com, mao_han@c-sky.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     guoren@kernel.org
Message-ID: <mhng-7c486840-63d3-4645-84ff-8c89660fc552@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2019 17:07:38 PST (-0800), guoren@kernel.org wrote:
> Hi Christoph,
>
> I use PFN_DOWN() every where as possible and seems it's a habit
> problem. So let risc-v maintainer to choose "PFN_DOW()" or
> ">> PAGE_SHIFT".
>
> Also the same with "end_of_DRAM & max_low_pfn".

PFN_DOWN makes sense to me, as that's what we're trying to do here (round a 
physical address down to page frame number).  Am a I misunderstanding 
something?

>
> Best Regards
>  Guo Ren
>
> On Tue, Jan 15, 2019 at 08:12:54AM -0800, Christoph Hellwig wrote:
>> On Wed, Jan 16, 2019 at 12:10:00AM +0800, Guo Ren wrote:
>> > > >  	set_max_mapnr(PFN_DOWN(mem_size));
>> > > > -	max_low_pfn = memblock_end_of_DRAM();
>> > > > +	max_low_pfn = PFN_DOWN(memblock_end_of_DRAM());
>> > >
>> > > I know it is used just above, but can we please just switch this
>> > > code to use >> PAGE_SHIFT instead of PFN_DOWN, which just horribly
>> > > obsfucates what is going on?
>> > ???
>> > #define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
>> >
>> > phys_addr_t __init_memblock memblock_end_of_DRAM(void)
>> > {
>> > 	int idx = memblock.memory.cnt - 1;
>> >
>> > 	return (memblock.memory.regions[idx].base + memblock.memory.regions[idx].size);
>> > }
>> >
>> > What's the problem? PFN_DOWN() couldn't be used with function call?
>>
>> PFN_DOWN gives you the correct result.  But I think it actually
>> drastically reduces readability over just opencoding it.
>>
>> > My patch just want to point out that max_low_pfn is PFN not size. In fact
>> > there is no error for running without my patch :P
>>
>> No, I think your patch is correct.  I just wonder if we could make
>> the code easier to read.
