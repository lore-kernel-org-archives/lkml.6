Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06554C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC8292184D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551198717;
	bh=6YS7vDnwUzZoLFrPkAuEKDzQ0NU0+qtKngEXDGYPfoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GY9d6FHk2FK61yNolxqwcqgIJSiKzHq8KNAe4p4Wp0A22PXibCFkz8tlTFCA16Ldf
	 z79KyrkPhqyXZku4Rb74/6NWIfgEerebk9eKM33ZH6ScuOcmHzkyomWz7kwib/Klcs
	 l4mm1ckNvD2DqgaNlP9n69MKnZW/WHwmpQWBjufw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfBZQb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:31:56 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38046 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfBZQb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:31:56 -0500
Received: by mail-yw1-f65.google.com with SMTP id o184so5637413ywo.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 08:31:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eliy+LXVAm/reO1JhBaGptnuIQdxQu+wUBgKDytlVvQ=;
        b=RLEEwkx/zAkzrJHU+a5h36RbqUF3wTxRBiEZ0MD76F1LnVFeHsVUnhXI+YGbwJcrmA
         9zqAr9Ziqoe9PgUKi+9U6SBcD8KVvApK5/o9grb/VX2NNfDV3rtJY+24/cGt4iu0AH/T
         2hZ8wBd4jmfxVwWVXDf//sCMs4gvO8t4DNSs/0urSppqDgMKU8eLu9eusaylaiJvPBez
         wfoYE+jbEtb4RpPAhmkOTd5xWrT2grr5ztBgnQ/MyoaKHeaXWfuAflpUX6fVf/wz6NXn
         dqQtnARlY1P6PjHV2IOOCeT/cJlDRhm6+pxTCtUyhgqNLD62/W/3VjbIWwdiShWZJ1Bv
         4cXQ==
X-Gm-Message-State: AHQUAuYXW2Ukzk6wiuxAMRVspXRr+vCDZHeOHhSqXtD9kUcbS6651n8V
        1p9ydVQakGFNagmO8Zzz43I=
X-Google-Smtp-Source: AHgI3IaDYm6I0be+SHNf29F3AQM1X/gSL2A4NS43BZxsGCnY1RuKykUsFHiaOxgDbTdpbCjn9pPc2g==
X-Received: by 2002:a25:8882:: with SMTP id d2mr19048907ybl.381.1551198715061;
        Tue, 26 Feb 2019 08:31:55 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::2:7f17])
        by smtp.gmail.com with ESMTPSA id f188sm4204686ywb.64.2019.02.26.08.31.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 08:31:53 -0800 (PST)
Date:   Tue, 26 Feb 2019 11:31:51 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Christopher Lameter <cl@linux.com>
Cc:     "dennis@kernel.org" <dennis@kernel.org>,
        Peng Fan <peng.fan@nxp.com>, "tj@kernel.org" <tj@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: Re: [PATCH 2/2] percpu: km: no need to consider pcpu_group_offsets[0]
Message-ID: <20190226163151.GA47262@dennisz-mbp.dhcp.thefacebook.com>
References: <20190224132518.20586-1-peng.fan@nxp.com>
 <20190224132518.20586-2-peng.fan@nxp.com>
 <20190225151616.GB49611@dennisz-mbp.dhcp.thefacebook.com>
 <010001692a605709-407cf476-e7b6-43be-8551-66c54059e92f-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010001692a605709-407cf476-e7b6-43be-8551-66c54059e92f-000000@email.amazonses.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 03:15:50PM +0000, Christopher Lameter wrote:
> On Mon, 25 Feb 2019, dennis@kernel.org wrote:
> 
> > > @@ -67,7 +67,7 @@ static struct pcpu_chunk *pcpu_create_chunk(gfp_t gfp)
> > >  		pcpu_set_page_chunk(nth_page(pages, i), chunk);
> > >
> > >  	chunk->data = pages;
> > > -	chunk->base_addr = page_address(pages) - pcpu_group_offsets[0];
> > > +	chunk->base_addr = page_address(pages);
> > >
> > >  	spin_lock_irqsave(&pcpu_lock, flags);
> > >  	pcpu_chunk_populated(chunk, 0, nr_pages, false);
> > > --
> > > 2.16.4
> > >
> >
> > While I do think you're right, creating a chunk is not a part of the
> > critical path and subtracting 0 is incredibly minor overhead. So I'd
> > rather keep the code as is to maintain consistency between percpu-vm.c
> > and percpu-km.c.
> 
> Well it is confusing if there the expression is there but never used. It
> is clearer with the patch.
> 

Okay. I'll apply it with your ack if that's fine.

Thanks,
Dennis
