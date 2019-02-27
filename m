Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7CCC00319
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13B720C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551291593;
	bh=rzI7rb+hVB8TYR7oQr1n3cHox4PxCIAQQfWrxWsdEqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EKy7qxUIz3gTRZug1PNHASwRGTTsP2+w/Hcd4fpY0d/7x9xtVS3fwTWuZgLxOl/X2
	 Bm7Ypt9BeEIOiKzKSppni8V0c8dnZWaDDwgUdNVwcl0xyhOiu3G35iSxxLJD682xeD
	 89pDqPYxHBF49uIjFnCA2L5iG6CvvroZDNrIi2+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbfB0STw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 13:19:52 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45279 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbfB0STv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 13:19:51 -0500
Received: by mail-yw1-f65.google.com with SMTP id r188so8740749ywb.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 10:19:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SG8+AwNO9pTDAwy0XmZ/9E7QFTB4ck31FCzRYixEZc8=;
        b=alp2cTYny4MeaCGjBN2CKIUR3iLwFBW+Hm9KH1Ga4fLWCUaFxfC3G3ltCDHA0NXoxD
         /SGTxnSGseZA2+9Iqp0tul3YRjsOMc7l0pvQb/iKdG4bYCN2BQrNGCndC+JxWFgS15WZ
         fAyfGTJWFd9kBnutAng66snPIGqY09bCVXphGLy51vFm/KMEEhMOsBrq0vK9BZ4ob1q+
         uXIIJagcy5pSSh1y8GQXw2nKcaMlgYAqSVFELm1YiHSu1fd86CJgQ53OL+0un5tOI506
         +Z7GJvSKAOtla94126OnPHS7oNhDLp2LZkoTHFMq4enB29rcADit8tPQVthUlFhyhdCq
         UR5g==
X-Gm-Message-State: AHQUAuarxnpzH/Q68Hub4sVXf4Ntp5qqyLoYPpJNiBJdPdr2RxK8kwod
        /enCmSWJKExHm8D+zy3G+MI=
X-Google-Smtp-Source: AHgI3IabMG2wZlD0xIC/0ylhor6WEZDf5f/MU5YKIBYq/mBQVHnHCJajvrImEanBXzHlNeazUyIn3g==
X-Received: by 2002:a25:d64e:: with SMTP id n75mr3059230ybg.199.1551291590453;
        Wed, 27 Feb 2019 10:19:50 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::3:8416])
        by smtp.gmail.com with ESMTPSA id s5sm5667824ywg.108.2019.02.27.10.19.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 10:19:49 -0800 (PST)
Date:   Wed, 27 Feb 2019 13:19:47 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "tj@kernel.org" <tj@kernel.org>, "cl@linux.com" <cl@linux.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: Re: [RFC] percpu: decrease pcpu_nr_slots by 1
Message-ID: <20190227181947.GB2379@dennisz-mbp.dhcp.thefacebook.com>
References: <20190224092838.3417-1-peng.fan@nxp.com>
 <20190225152336.GC49611@dennisz-mbp.dhcp.thefacebook.com>
 <AM0PR04MB448161D9ED7D152AD58B53E9887B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20190226173238.GA51080@dennisz-mbp.dhcp.thefacebook.com>
 <AM0PR04MB44814BC1B03CC8D3963D969988740@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0PR04MB44814BC1B03CC8D3963D969988740@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 01:33:15PM +0000, Peng Fan wrote:
> Hi Dennis,
> 
> > -----Original Message-----
> > From: Dennis Zhou [mailto:dennis@kernel.org]
> > Sent: 2019年2月27日 1:33
> > To: Peng Fan <peng.fan@nxp.com>
> > Cc: dennis@kernel.org; tj@kernel.org; cl@linux.com; linux-mm@kvack.org;
> > linux-kernel@vger.kernel.org; van.freenix@gmail.com
> > Subject: Re: [RFC] percpu: decrease pcpu_nr_slots by 1
> > 
> > On Tue, Feb 26, 2019 at 12:09:28AM +0000, Peng Fan wrote:
> > > Hi Dennis,
> > >
> > > > -----Original Message-----
> > > > From: dennis@kernel.org [mailto:dennis@kernel.org]
> > > > Sent: 2019年2月25日 23:24
> > > > To: Peng Fan <peng.fan@nxp.com>
> > > > Cc: tj@kernel.org; cl@linux.com; linux-mm@kvack.org;
> > > > linux-kernel@vger.kernel.org; van.freenix@gmail.com
> > > > Subject: Re: [RFC] percpu: decrease pcpu_nr_slots by 1
> > > >
> > > > On Sun, Feb 24, 2019 at 09:17:08AM +0000, Peng Fan wrote:
> > > > > Entry pcpu_slot[pcpu_nr_slots - 2] is wasted with current code logic.
> > > > > pcpu_nr_slots is calculated with `__pcpu_size_to_slot(size) + 2`.
> > > > > Take pcpu_unit_size as 1024 for example, __pcpu_size_to_slot will
> > > > > return max(11 - PCPU_SLOT_BASE_SHIFT + 2, 1), it is 8, so the
> > > > > pcpu_nr_slots will be 10.
> > > > >
> > > > > The chunk with free_bytes 1024 will be linked into pcpu_slot[9].
> > > > > However free_bytes in range [512,1024) will be linked into
> > > > > pcpu_slot[7], because `fls(512) - PCPU_SLOT_BASE_SHIFT + 2` is 7.
> > > > > So pcpu_slot[8] is has no chance to be used.
> > > > >
> > > > > According comments of PCPU_SLOT_BASE_SHIFT, 1~31 bytes share the
> > > > same
> > > > > slot and PCPU_SLOT_BASE_SHIFT is defined as 5. But actually 1~15
> > > > > share the same slot 1 if we not take PCPU_MIN_ALLOC_SIZE into
> > > > > consideration,
> > > > > 16~31 share slot 2. Calculation as below:
> > > > > highbit = fls(16) -> highbit = 5
> > > > > max(5 - PCPU_SLOT_BASE_SHIFT + 2, 1) equals 2, not 1.
> > > > >
> > > > > This patch by decreasing pcpu_nr_slots to avoid waste one slot and
> > > > > let [PCPU_MIN_ALLOC_SIZE, 31) really share the same slot.
> > > > >
> > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > > ---
> > > > >
> > > > > V1:
> > > > >  Not very sure about whether it is intended to leave the slot there.
> > > > >
> > > > >  mm/percpu.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/mm/percpu.c b/mm/percpu.c index
> > > > > 8d9933db6162..12a9ba38f0b5 100644
> > > > > --- a/mm/percpu.c
> > > > > +++ b/mm/percpu.c
> > > > > @@ -219,7 +219,7 @@ static bool pcpu_addr_in_chunk(struct
> > > > > pcpu_chunk *chunk, void *addr)  static int __pcpu_size_to_slot(int size)
> > {
> > > > >  	int highbit = fls(size);	/* size is in bytes */
> > > > > -	return max(highbit - PCPU_SLOT_BASE_SHIFT + 2, 1);
> > > > > +	return max(highbit - PCPU_SLOT_BASE_SHIFT + 1, 1);
> > > > >  }
> > > >
> > > > Honestly, it may be better to just have [1-16) [16-31) be separate.
> 
> Missed to reply this in previous thread, the following comments let
> me think the chunk slot calculation might be wrong, so this comment
> needs to be updated, saying "[PCPU_MIN_ALLOC_SIZE - 15) bytes share
> the same slot", if [1-16)[16-31) is expected.
> "
> /* the slots are sorted by free bytes left, 1-31 bytes share the same slot */
> #define PCPU_SLOT_BASE_SHIFT            5
> "
> 
> > > > I'm working on a change to this area, so I may change what's going on
> > here.
> > > >
> > > > >
> > > > >  static int pcpu_size_to_slot(int size) @@ -2145,7 +2145,7 @@ int
> > > > > __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
> > > > >  	 * Allocate chunk slots.  The additional last slot is for
> > > > >  	 * empty chunks.
> > > > >  	 */
> > > > > -	pcpu_nr_slots = __pcpu_size_to_slot(pcpu_unit_size) + 2;
> > > > > +	pcpu_nr_slots = __pcpu_size_to_slot(pcpu_unit_size) + 1;
> > > > >  	pcpu_slot = memblock_alloc(pcpu_nr_slots * sizeof(pcpu_slot[0]),
> > > > >  				   SMP_CACHE_BYTES);
> > > > >  	for (i = 0; i < pcpu_nr_slots; i++)
> > > > > --
> > > > > 2.16.4
> > > > >
> > > >
> > > > This is a tricky change. The nice thing about keeping the additional
> > > > slot around is that it ensures a distinction between a completely
> > > > empty chunk and a nearly empty chunk.
> > >
> > > Are there any issues met before if not keeping the unused slot?
> > > From reading the code and git history I could not find information.
> > > I tried this code on aarch64 qemu and did not meet issues.
> > >
> > 
> > This change would require verification that all paths lead to power of 2 chunk
> > sizes and most likely a BUG_ON if that's not the case.
> 
> I try to understand, "power of 2 chunk sizes", you mean the runtime free_bytes
> of a chunk?
> 

I'm talking about the unit_size.

> > 
> > So while this would work, we're holding onto an additional slot also to be used
> > for chunk reclamation via pcpu_balance_workfn(). If a chunk was not a power
> > of 2 resulting in the last slot being entirely empty chunks we could free stuff a
> > chunk with addresses still in use.
> 
> You mean the following code might free stuff when a percpu variable is still being used
> if the chunk runtime free_bytes is not a power of 2?
> "
> 1623         list_for_each_entry_safe(chunk, next, &to_free, list) {
> 1624                 int rs, re;
> 1625
> 1626                 pcpu_for_each_pop_region(chunk->populated, rs, re, 0,
> 1627                                          chunk->nr_pages) {
> 1628                         pcpu_depopulate_chunk(chunk, rs, re);
> 1629                         spin_lock_irq(&pcpu_lock);
> 1630                         pcpu_chunk_depopulated(chunk, rs, re);
> 1631                         spin_unlock_irq(&pcpu_lock);
> 1632                 }
> 1633                 pcpu_destroy_chunk(chunk);
> 1634                 cond_resched();
> 1635         }
> "
> 

Yes, if the unit_size is not a power of 2, then the last slot holds used
chunks.

> > 
> > > > It happens to be that the logic creates power of 2 chunks which ends
> > > > up being an additional slot anyway.
> > >
> > >
> > > So,
> > > > given that this logic is tricky and architecture dependent,
> > >
> > > Could you share more information about architecture dependent?
> > >
> > 
> > The crux of the logic is in pcpu_build_alloc_info(). It's been some time since
> > I've thought deeply about it, but I don't believe there is a guarantee that it will
> > be a power of 2 chunk.
> 
> I am a bit lost about a power of 2, need to read more about the code.
> 

I'm reluctant to remove this slot because it is tricky code and the
benefit of it is negligible compared to the risk.

Thanks,
Dennis
