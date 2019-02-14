Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CF4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F43D21934
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AqFGGKQk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393683AbfBNGAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 01:00:10 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36376 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391894AbfBNGAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 01:00:09 -0500
Received: by mail-pg1-f194.google.com with SMTP id r124so2479033pgr.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 22:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EyhZ0LXI8S6DO+1lKPJ+3xCo7Hi2M9DApl/OXP8GRG0=;
        b=AqFGGKQkWIE4m9oWUPQKPfYDWffEV3DD3kw2gte/hIVc+ZOI2ALww287MyZktoOcDi
         CbpDfqNDDxjQTYKo+HSL1jPCcxgIu0tlHCqsVDa+M5KY9ZBsLFTmv/t2wqc5kisOEAq3
         Ey9IsWcwZPCXnG/nVFmz7GUhhGKdm8IWeTP2Dk0HwbmuU3cqx7K5BZzuoEE5qUenFwFw
         FhXuEgKL+2MrnrRuMG0A1nR+NYB/69dpYPvc7V/phtqqydIA5J2EkPID7AxDk9lsLjAP
         NbaOeXfbMwnJ+uPtI2ATX/eErFA+0vBz71ipAT/cQzRY+HNlZcQmNhta5uk0wuPGbr4p
         3GKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EyhZ0LXI8S6DO+1lKPJ+3xCo7Hi2M9DApl/OXP8GRG0=;
        b=Sf9ViAPvpAdBJmj885N4HAugn4Z8C0WEztRTfcOzG/xEz+2t45Cl8WRoHtTp2x0mPI
         uE0QJLIWjrlt+hgWuT/k8BVELMMeyUExu9Apkqfh+tVmjEE6KIjqvndBN2wINCA8VH4h
         MP1ZBlzkEjl4q8IoKIpxysT4fJxj+31A1nVKVp1Jsqf7JeY+OKCaRNvyylMcWNiRZ6Pb
         1nKwK+bjupZ7QYa8RMfmoYxsJVR/YatryEwhQWqwIkf7croqoMWv46Gk3HC3SIIj4MV9
         eg/kib456aLlUcz1/7w5p8y5LJebLRQlqx/ebDco2xyePEtk76OyLuY0Qrr+dJrnj+DO
         7Mfw==
X-Gm-Message-State: AHQUAuZZKUvbGNu2/H8ZATATvhegLLAtMUDheIkotq6kZhu//ZCYeC0Q
        HJ6hre2Plu3/Tv62XhVXKDnGxg==
X-Google-Smtp-Source: AHgI3IZsTuAr/2agKNUI6fHNmik1DYYjhaWBR5rn+7baCxky03ZS5RyeSxDZdNqDP/QzwRlb2m6TAA==
X-Received: by 2002:a62:9f1a:: with SMTP id g26mr2297647pfe.123.1550124008008;
        Wed, 13 Feb 2019 22:00:08 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id z127sm2288820pfb.80.2019.02.13.22.00.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 22:00:07 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1guA46-00040P-Jk; Wed, 13 Feb 2019 23:00:06 -0700
Date:   Wed, 13 Feb 2019 23:00:06 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        akpm@linux-foundation.org, dave@stgolabs.net, jack@suse.cz,
        cl@linux.com, linux-mm@kvack.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex.williamson@redhat.com, paulus@ozlabs.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, hao.wu@intel.com,
        atull@kernel.org, mdf@kernel.org, aik@ozlabs.ru
Subject: Re: [PATCH 0/5] use pinned_vm instead of locked_vm to account pinned
 pages
Message-ID: <20190214060006.GE24692@ziepe.ca>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
 <20190211225447.GN24692@ziepe.ca>
 <20190214015314.GB1151@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214015314.GB1151@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 05:53:14PM -0800, Ira Weiny wrote:
> On Mon, Feb 11, 2019 at 03:54:47PM -0700, Jason Gunthorpe wrote:
> > On Mon, Feb 11, 2019 at 05:44:32PM -0500, Daniel Jordan wrote:
> > 
> > > All five of these places, and probably some of Davidlohr's conversions,
> > > probably want to be collapsed into a common helper in the core mm for
> > > accounting pinned pages.  I tried, and there are several details that
> > > likely need discussion, so this can be done as a follow-on.
> > 
> > I've wondered the same..
> 
> I'm really thinking this would be a nice way to ensure it gets cleaned up and
> does not happen again.
> 
> Also, by moving it to the core we could better manage any user visible changes.
> 
> From a high level, pinned is a subset of locked so it seems like we need a 2
> sets of helpers.
> 
> try_increment_locked_vm(...)
> decrement_locked_vm(...)
> 
> try_increment_pinned_vm(...)
> decrement_pinned_vm(...)
> 
> Where try_increment_pinned_vm() also increments locked_vm...  Of course this
> may end up reverting the improvement of Davidlohr  Bueso's atomic work...  :-(
> 
> Furthermore it would seem better (although I don't know if at all possible) if
> this were accounted for in core calls which tracked them based on how the pages
> are being used so that drivers can't call try_increment_locked_vm() and then
> pin the pages...  Thus getting the account wrong vs what actually happened.
> 
> And then in the end we can go back to locked_vm being the value checked against
> RLIMIT_MEMLOCK.

Someone would need to understand the bug that was fixed by splitting
them. 

I think it had to do with double accounting pinned and mlocked pages
and thus delivering a lower than expected limit to userspace.

vfio has this bug, RDMA does not. RDMA has a bug where it can
overallocate locked memory, vfio doesn't.

Really unclear how to fix this. The pinned/locked split with two
buckets may be the right way.

Jason
