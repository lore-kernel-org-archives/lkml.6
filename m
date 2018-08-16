Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CA4C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571C32148C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqformS/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 571C32148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elisp.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390256AbeHPMCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 08:02:41 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42923 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbeHPMCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 08:02:41 -0400
Received: by mail-pl0-f65.google.com with SMTP id g6-v6so1782935plq.9;
        Thu, 16 Aug 2018 02:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lxW5Nz2hsqCOewfGtIUbQP8JNHR8XOu5Rhq2i9EiAxo=;
        b=SqformS/g+SJ6kdElmh7wdlit0JQ//yFf5izM3KZZ2ZvclH4TaHXCJfkPvmTfQ4MA5
         bG2e13wTXOkkO6G/sG/W7VCEd57KXqLv32EF/KSIqzFbxXDdBiJfzSoOAC6EbxCtcBk1
         V7XIBemF2UtzM5F3oEPa4DPuTLQtguMFhLAjRGqc0xZTpGgIRMG/hIDN3t9xo1XHQgq3
         cWPFenqcCqFMrrQQJLtp3injIq8z/pJ55TYyYOCJc57tcsodtUarSpj2xAo0ZxK/Wurt
         zDaHTZ/Ueve+vk3MwD2kFN6gbz5YUf6vrYIa1p8T4NiczuvL6uU24kFq6Fk+xXLdOuRo
         hEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lxW5Nz2hsqCOewfGtIUbQP8JNHR8XOu5Rhq2i9EiAxo=;
        b=SuHhdEi6dQ/WOzsGsZOhQLX78DpKpEfhJLwu6lo2dgZIwm4VKHR92iMmobsZsmH4Eq
         kro0zvTVQDwrQz6Ag1Bgj360bjJH6kt6J9HaZ2VaNlaMjvcCpUba4hZmi/HbCnsROLG3
         6pL24UC9FXFQUf33xOkzlfZq0YG4jGc+SrDeFZwGnV4JKAu10F4dTLcv2E/sVXEhAPLL
         Vep9VCDEt504zW2gDaGoydoFOawGsjSE7AN/GOztYy63kjVwEPwpea3QSAs4ESub7XN/
         OMtKu6Sh/yzQC7E6qpi26047k6M3cceJmuPeBBxZ2uVqi8Z6SrQu6NbEq8x7fcDEepdC
         JPyQ==
X-Gm-Message-State: AOUpUlHnwxuXWNoAJbKjbnX8iFv4pY1ffL7Z1c6eW9QHUV+CFKZ5RF8G
        lfmrgskbLtce4yyPzRhisx0=
X-Google-Smtp-Source: AA+uWPxyS8/pvWrw6N8mwczlk898fmcrUz7TojWzFS7FPNUnduokIPRIvhEZXqRE3HCSYB7uit0Vxw==
X-Received: by 2002:a17:902:4201:: with SMTP id g1-v6mr28110686pld.203.1534410334645;
        Thu, 16 Aug 2018 02:05:34 -0700 (PDT)
Received: from localhost (h101-111-148-072.catv02.itscom.jp. [101.111.148.72])
        by smtp.gmail.com with ESMTPSA id l85-v6sm45523839pfk.34.2018.08.16.02.05.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 02:05:33 -0700 (PDT)
Date:   Thu, 16 Aug 2018 18:05:31 +0900
From:   Naohiro Aota <naota@elisp.net>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>
Subject: Re: [RFC PATCH 00/17] btrfs zoned block device support
Message-ID: <20180816090531.knjb423b3fm5fdk4@zazie>
References: <20180809180450.5091-1-naota@elisp.net>
 <d5473558-47a1-708e-551b-fabb4ea0842e@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5473558-47a1-708e-551b-fabb4ea0842e@gmx.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 03:28:21PM +0800, Qu Wenruo wrote:
> 
> 
> On 8/10/18 2:04 AM, Naohiro Aota wrote:
> > This series adds zoned block device support to btrfs.
> > 
> > A zoned block device consists of a number of zones. Zones are either
> > conventional and accepting random writes or sequential and requiring that
> > writes be issued in LBA order from each zone write pointer position.
> 
> Not familiar with zoned block device, especially for the sequential case.
> 
> Is that sequential case tape like?

It's somewhat similar but not the same as tape drives. In the tape
drives, you still *can* write in random access patters, though it's
much slow. In sequential required zones, it is always enforced to
write sequentially in a zone. Violating sequential write rule results
I/O error.

One user of sequential write required zone is Host-Managed "Shingled
Magnetic Recording" (SMR) HDDs [1]. They increase the volume capacity
by overlapping the tracks. As a result, writing to tracks overwrites
adjacent tracks. Such physical nature forces the sequential write
pattern.

[1] https://en.wikipedia.org/wiki/Shingled_magnetic_recording

> > This
> > patch series ensures that the sequential write constraint of sequential
> > zones is respected while fundamentally not changing BtrFS block and I/O
> > management for block stored in conventional zones.
> > 
> > To achieve this, the default dev extent size of btrfs is changed on zoned
> > block devices so that dev extents are always aligned to a zone. Allocation
> > of blocks within a block group is changed so that the allocation is always
> > sequential from the beginning of the block groups. To do so, an allocation
> > pointer is added to block groups and used as the allocation hint.  The
> > allocation changes also ensures that block freed below the allocation
> > pointer are ignored, resulting in sequential block allocation regardless of
> > the block group usage.
> 
> This looks like it would cause a lot of holes for metadata block groups.
> It would be better to avoid metadata block allocation in such sequential
> zone.
> (And that would need the infrastructure to make extent allocator
> priority-aware)

Yes, it would introduce holes in metadata block groups. I agree it is
desirable to allocate metadata blocks from conventional
(non-sequential) zones.

However, it's sometime impossible to allocate metadata blocks from
conventional zones, since the number of conventional zones is
generally smaller than sequential zones in some zoned block devices
like SMR HDDs (to achieve higher volume capacity).

While this patch series ensures metadata/data can be allocated in any
type of zone and everything works in any zones, we will be able to
improve metadata allocation by making the extent allocator
priority/zone-type aware in the future.

> > [...]
> > Naohiro Aota (17):
> >   btrfs: introduce HMZONED feature flag
> >   btrfs: Get zone information of zoned block devices
> >   btrfs: Check and enable HMZONED mode
> >   btrfs: limit super block locations in HMZONED mode
> >   btrfs: disable fallocate in HMZONED mode
> >   btrfs: disable direct IO in HMZONED mode
> >   btrfs: disable device replace in HMZONED mode
> >   btrfs: align extent allocation to zone boundary
> 
> According to the patch name, I though it's about extent allocation, but
> in fact it's about dev extent allocation.
> Renaming the patch would make more sense.
>
> >   btrfs: do sequential allocation on HMZONED drives
> 
> And this is the patch modifying extent allocator.

Thanks. I will fix the names of the patches in the next version.

> Despite that, the support zoned storage looks pretty interesting and
> have something in common with planned priority-aware extent allocator.
> 
> Thanks,
> Qu

Regards,
Naohiro
