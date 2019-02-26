Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9EAC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B234F217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551202364;
	bh=f9OM1NuP9+ORGQX7OBDuC3jW+NXwNom+o4qluxdGXJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pViJprzBt+R+dAnirEWKOv0SXMI3E+IIXWeNWANZQlS39yXyXYlM6wW5+6p69irdu
	 nWxVO6sVZXv/25eGuOjZDidrcp1DEMKKN1wC/1I5lDisKAldAFLSkP5bl4QweygzKQ
	 foydLw13nffMwjMRRu0MaGyIoXXGBNgK/VBNZYnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfBZRcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:32:43 -0500
Received: from mail-yw1-f43.google.com ([209.85.161.43]:35308 "EHLO
        mail-yw1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfBZRcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:32:42 -0500
Received: by mail-yw1-f43.google.com with SMTP id s204so5812619ywg.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 09:32:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YPrsT0iUOY7Hfj5aR8jhnnzYbP/I7ueC+KO4Fv97uXg=;
        b=LEymMBcP1HMmVzbjILgZf1P5pMhQxMJvWN7OhMkOAxdOaYgJvVlnZpljPCEfFVFlCo
         WUh2TMRqiEvdpprK0cQYTQH9J710K7XXoCXFQsMoD/LQtm4S6e5XhgzulDnAU8SIxolj
         8hvxt2P5vZXuhINLnR3yh7XbCTQI3pbBKTtiwvjiKzIJgnIzLPq1aVF37S5GQcK9mfA/
         0wCTqWjYBg5sv59ezbxurMO2E5+RGmeXoDPVsZPNPEYzI/ug2vL06Yu1FSXHh6wIp15B
         PvC9p/VEda3F1pXAl58g+jbiGoSL5ID0PNCDz//dwiSpilUk52J37pX9SZfOMnui2GAg
         OxwA==
X-Gm-Message-State: AHQUAubnV5yYOoLXcDIIxhRNHUI1/+suORUSIxpONFval7AdT4QCm3KT
        uoeJEgz5fds8IrPfTc4VftE=
X-Google-Smtp-Source: AHgI3IbpWGDG7vBxnzM6stZTh/e/ZSGPj5DrSdOTWwDbhT6+QaALuc9u8ORlAEJ8/fV8JjyZ5/ttEA==
X-Received: by 2002:a25:484:: with SMTP id 126mr16832681ybe.409.1551202361314;
        Tue, 26 Feb 2019 09:32:41 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::2:7f17])
        by smtp.gmail.com with ESMTPSA id x130sm4295523ywa.78.2019.02.26.09.32.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 09:32:40 -0800 (PST)
Date:   Tue, 26 Feb 2019 12:32:38 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "dennis@kernel.org" <dennis@kernel.org>,
        "tj@kernel.org" <tj@kernel.org>, "cl@linux.com" <cl@linux.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: Re: [RFC] percpu: decrease pcpu_nr_slots by 1
Message-ID: <20190226173238.GA51080@dennisz-mbp.dhcp.thefacebook.com>
References: <20190224092838.3417-1-peng.fan@nxp.com>
 <20190225152336.GC49611@dennisz-mbp.dhcp.thefacebook.com>
 <AM0PR04MB448161D9ED7D152AD58B53E9887B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0PR04MB448161D9ED7D152AD58B53E9887B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 12:09:28AM +0000, Peng Fan wrote:
> Hi Dennis,
> 
> > -----Original Message-----
> > From: dennis@kernel.org [mailto:dennis@kernel.org]
> > Sent: 2019年2月25日 23:24
> > To: Peng Fan <peng.fan@nxp.com>
> > Cc: tj@kernel.org; cl@linux.com; linux-mm@kvack.org;
> > linux-kernel@vger.kernel.org; van.freenix@gmail.com
> > Subject: Re: [RFC] percpu: decrease pcpu_nr_slots by 1
> > 
> > On Sun, Feb 24, 2019 at 09:17:08AM +0000, Peng Fan wrote:
> > > Entry pcpu_slot[pcpu_nr_slots - 2] is wasted with current code logic.
> > > pcpu_nr_slots is calculated with `__pcpu_size_to_slot(size) + 2`.
> > > Take pcpu_unit_size as 1024 for example, __pcpu_size_to_slot will
> > > return max(11 - PCPU_SLOT_BASE_SHIFT + 2, 1), it is 8, so the
> > > pcpu_nr_slots will be 10.
> > >
> > > The chunk with free_bytes 1024 will be linked into pcpu_slot[9].
> > > However free_bytes in range [512,1024) will be linked into
> > > pcpu_slot[7], because `fls(512) - PCPU_SLOT_BASE_SHIFT + 2` is 7.
> > > So pcpu_slot[8] is has no chance to be used.
> > >
> > > According comments of PCPU_SLOT_BASE_SHIFT, 1~31 bytes share the
> > same
> > > slot and PCPU_SLOT_BASE_SHIFT is defined as 5. But actually 1~15 share
> > > the same slot 1 if we not take PCPU_MIN_ALLOC_SIZE into consideration,
> > > 16~31 share slot 2. Calculation as below:
> > > highbit = fls(16) -> highbit = 5
> > > max(5 - PCPU_SLOT_BASE_SHIFT + 2, 1) equals 2, not 1.
> > >
> > > This patch by decreasing pcpu_nr_slots to avoid waste one slot and let
> > > [PCPU_MIN_ALLOC_SIZE, 31) really share the same slot.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >
> > > V1:
> > >  Not very sure about whether it is intended to leave the slot there.
> > >
> > >  mm/percpu.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/mm/percpu.c b/mm/percpu.c index
> > > 8d9933db6162..12a9ba38f0b5 100644
> > > --- a/mm/percpu.c
> > > +++ b/mm/percpu.c
> > > @@ -219,7 +219,7 @@ static bool pcpu_addr_in_chunk(struct pcpu_chunk
> > > *chunk, void *addr)  static int __pcpu_size_to_slot(int size)  {
> > >  	int highbit = fls(size);	/* size is in bytes */
> > > -	return max(highbit - PCPU_SLOT_BASE_SHIFT + 2, 1);
> > > +	return max(highbit - PCPU_SLOT_BASE_SHIFT + 1, 1);
> > >  }
> > 
> > Honestly, it may be better to just have [1-16) [16-31) be separate. I'm working
> > on a change to this area, so I may change what's going on here.
> > 
> > >
> > >  static int pcpu_size_to_slot(int size) @@ -2145,7 +2145,7 @@ int
> > > __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
> > >  	 * Allocate chunk slots.  The additional last slot is for
> > >  	 * empty chunks.
> > >  	 */
> > > -	pcpu_nr_slots = __pcpu_size_to_slot(pcpu_unit_size) + 2;
> > > +	pcpu_nr_slots = __pcpu_size_to_slot(pcpu_unit_size) + 1;
> > >  	pcpu_slot = memblock_alloc(pcpu_nr_slots * sizeof(pcpu_slot[0]),
> > >  				   SMP_CACHE_BYTES);
> > >  	for (i = 0; i < pcpu_nr_slots; i++)
> > > --
> > > 2.16.4
> > >
> > 
> > This is a tricky change. The nice thing about keeping the additional
> > slot around is that it ensures a distinction between a completely empty
> > chunk and a nearly empty chunk.
> 
> Are there any issues met before if not keeping the unused slot?
> From reading the code and git history I could not find information.
> I tried this code on aarch64 qemu and did not meet issues.
> 

This change would require verification that all paths lead to power of 2
chunk sizes and most likely a BUG_ON if that's not the case.

So while this would work, we're holding onto an additional slot also to
be used for chunk reclamation via pcpu_balance_workfn(). If a chunk was
not a power of 2 resulting in the last slot being entirely empty chunks
we could free stuff a chunk with addresses still in use.

> > It happens to be that the logic creates
> > power of 2 chunks which ends up being an additional slot anyway. 
> 
> 
> So,
> > given that this logic is tricky and architecture dependent, 
> 
> Could you share more information about architecture dependent?
> 

The crux of the logic is in pcpu_build_alloc_info(). It's been some time
since I've thought deeply about it, but I don't believe there is a
guarantee that it will be a power of 2 chunk.

Thanks,
Dennis
