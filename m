Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD49C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78AE24C92
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78AE24C92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753811AbeGBHzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:55:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:40228 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753169AbeGBHzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:55:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EED9CAD3A;
        Mon,  2 Jul 2018 07:55:44 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A08641E3BDF; Mon,  2 Jul 2018 09:55:43 +0200 (CEST)
Date:   Mon, 2 Jul 2018 09:55:43 +0200
From:   Jan Kara <jack@suse.cz>
To:     Huaisheng Ye <yehs2007@zoho.com>
Cc:     "\"Al Viro\"" <viro@ZenIV.linux.org.uk>, dan.j.williams@intel.com,
        dave.jiang@intel.com, willy@infradead.org,
        ross.zwisler@linux.intel.com, vishal.l.verma@intel.com,
        jack@suse.com, chengnt@lenovo.com, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        "\"Huaisheng Ye\"" <yehs1@lenovo.com>
Subject: Re: [PATCH 2/3] fs/ext2/inode: Fix a type cast error for fsdax
Message-ID: <20180702075543.k7y73aj3s3gp4ptz@quack2.suse.cz>
References: <20180701061848.7036-1-yehs2007@zoho.com>
 <20180701061848.7036-2-yehs2007@zoho.com>
 <20180701192600.GT30522@ZenIV.linux.org.uk>
 <16459a9432e.10c419704327.5268154349116077352@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16459a9432e.10c419704327.5268154349116077352@zoho.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02-07-18 14:23:42, Huaisheng Ye wrote:
>  ---- On Mon, 02 Jul 2018 03:26:00 +0800 Al Viro <viro@ZenIV.linux.org.uk> wrote ---- 
>  > On Sun, Jul 01, 2018 at 02:18:47PM +0800, Huaisheng Ye wrote: 
>  > > From: Huaisheng Ye <yehs1@lenovo.com> 
>  > >  
>  > > The type of offset within struct iomap is loff_t, which represents 
>  > > file offset of mapping. 
>  > >  
>  > > In ext2_iomap_begin, iomap->offset shall be given a type cast as 
>  > > loff_t instead of u64. 
>  >  
>  > Why is it an error?  loff_t is uniformly typedefed to long long. 
>  > In which case the second variant is different from the first one 
>  > *and* does not step into nasal demon territory?
> 
> Sorry for my inaccuracy.
> The type of iomap->offset is loff_t, is it better to cast first_block
> to loff_t, then do the left shift operation?

I think what Al meant is that in the kernel loff_t is 64-bit anyway and
furthermore it is signed which means most people have to look up C standard
to remember how right shift is (un)defined if it would overflow ;). So this
does not really make the code any more readable. Rather on contrary...

								Honza

>  
>  >  
>  > > -    iomap->offset = (u64)first_block << blkbits; 
>  > > +    iomap->offset = (loff_t)first_block << blkbits; 
>  > 
> 
> ---
> Cheers,
> Huaisheng
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
