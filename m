Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9F9C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0DC620A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gPVEK+ZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0DC620A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbeHWUsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 16:48:15 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34890 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbeHWUsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 16:48:15 -0400
Received: by mail-pg1-f193.google.com with SMTP id z4-v6so2945496pgv.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 10:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EtLmjXIU95NEZbmVTgKB0qj1a78YNuoWwPP9N2CEyZU=;
        b=gPVEK+ZWjMDfjqZGnwyOd8HPpcFxphDMq/pwCI3EAXr1DCsmpU4KQwWEiBZQUV08At
         pRQ6H+WUrtJ9uJTCJKNlaODecsGfc5Vws53Vwk+iqQKTRHEaeXy4gefFfVVFDO8oIOh/
         fhX2XJU7oI+LcWBBFhAXdq4WgLQzrk73sdVILoS/6K9Z50SD8GGsxVhNPg2EIxsO1K7N
         9eFtoWBvRXNTcM26/1rGorZ8JJLRJPlSFNrnw7NYboFSqBpnlgIAIB/vVg5wpqv0j8Fj
         ogk5BPb3TWCaBBB52YGyFSqOEmy8eaW9Y7N+1HTKulRK5oC1him0ZMo7zauOsyi1ypH/
         lZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EtLmjXIU95NEZbmVTgKB0qj1a78YNuoWwPP9N2CEyZU=;
        b=LCp96HuzQpl2xh6EK/JncTfpKfwKPZiC5ak6VmAYWOBHIeid/AO8Nu7uCD5ZhtNxbf
         sy6QosaFBCmBAslQHYBZiLYhhiUmN8kA4yOVSiCmzhveFbZMxTt0sBkInrETE+Oez+rA
         uTXCKljNLWp5dU0LCOYb8IB8V94ffDuZ/a4amqy483DZjenNDC1a3KdJdpgQE+GkE66r
         ixajv1wC/F/nLB6VMBlkAlXMenyZ/+uV+MOjhrnCz4euETg07BJvvtz57y4NLCggsv8C
         JHk1f8roiyXFu1TdNhGaFIyOeiL5gAf2DIfMOTQLB2DQ1HWtte821vQuLGBlvIaCBiLD
         wZbw==
X-Gm-Message-State: AOUpUlEU6N21oKH8My/3T9xDYhPnsPgs/nay50jKjb2Mu+WLS/WBzaKV
        1UccqMtKKFxZKr2ZJFBXbsNpoA==
X-Google-Smtp-Source: AA+uWPwLJNOEBy3dol9yyGQFK9p2FAA/sL4hT8nLq7l+/ckIYsAvzHKmezqpL2D+FzlZ2QQhMKhHHg==
X-Received: by 2002:aa7:88d3:: with SMTP id p19-v6mr57278647pfo.160.1535044653960;
        Thu, 23 Aug 2018 10:17:33 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id x4-v6sm6244801pfm.119.2018.08.23.10.17.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 10:17:33 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1fstEi-0003xb-Pr; Thu, 23 Aug 2018 11:17:32 -0600
Date:   Thu, 23 Aug 2018 11:17:32 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Parav Pandit <parav@mellanox.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dasaratharaman.chandramouli@intel.com" 
        <dasaratharaman.chandramouli@intel.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Bloch <markb@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+29ee8f76017ce6cf03da@syzkaller.appspotmail.com>
Subject: Re: [RDMA bug] KASAN: use-after-free Read in __list_del_entry_valid
 (4)
Message-ID: <20180823171732.GC14664@ziepe.ca>
References: <001a1141551246502d056845782e@google.com>
 <001a1140f6ac1677460568489287@google.com>
 <20180823061630.GB736@sol.localdomain>
 <20180823145458.GC9366@ziepe.ca>
 <VI1PR0501MB22714BE9A34FA333671A0623D1370@VI1PR0501MB2271.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0501MB22714BE9A34FA333671A0623D1370@VI1PR0501MB2271.eurprd05.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 04:39:29PM +0000, Parav Pandit wrote:
> 
> 
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Thursday, August 23, 2018 9:55 AM
> > To: Eric Biggers <ebiggers@kernel.org>
> > Cc: Doug Ledford <dledford@redhat.com>; linux-rdma@vger.kernel.org;
> > dasaratharaman.chandramouli@intel.com; Leon Romanovsky
> > <leonro@mellanox.com>; linux-kernel@vger.kernel.org; Mark Bloch
> > <markb@mellanox.com>; Moni Shoua <monis@mellanox.com>; Parav Pandit
> > <parav@mellanox.com>; syzkaller-bugs@googlegroups.com; syzbot
> > <syzbot+29ee8f76017ce6cf03da@syzkaller.appspotmail.com>
> > Subject: Re: [RDMA bug] KASAN: use-after-free Read in __list_del_entry_valid
> > (4)
> > 
> > On Wed, Aug 22, 2018 at 11:16:31PM -0700, Eric Biggers wrote:
> > > Hello RDMA / InfiniBand maintainers,
> > >
> > > This is an RDMA bug and it still occurs on Linus' tree as of today
> > > (commit 815f0ddb346c1960).
> > >
> > > I've also simplified the reproducer for it; see below after the original report.
> > > Apparently it involves a race between RDMA_USER_CM_CMD_RESOLVE_IP
> > and
> > > RDMA_USER_CM_CMD_LISTEN.
> > 
> > That is an amazing reproducer!
> > 
> > I have a feeling this is the same cause as all the other syzkaller bugs in this code:
> > lack of any sane locking at all :\
> > 
> > We've talked about chucking a big lock around this whole thing, but nobody has
> > done it yet.. It isn't so simple.
> >
>
> I had some code in which reduces three locks (handler_lock,
> qp_mutex, id_lock) to single mutex to protect the cm_id and protects
> every exported symbol of rdmacm which works on cm_id.  But not ready
> enough to post it as patch yet. Lot of tests required before I get
> there and some refactor too before that.

That does sound promising..

Jason
