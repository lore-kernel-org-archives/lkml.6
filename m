Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3612C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B66420823
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EmWX0F+U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440239AbfBNWQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 17:16:33 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45900 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388126AbfBNWQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 17:16:32 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so3749705pgc.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 14:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t1hVwJWaLn2x3podPvX+xTLteVECyauDZZjQoDe0D+0=;
        b=EmWX0F+U8QlHwgyOQyU7/GpC3WglrqT05XbL6OtUXhmICyYGqD//fSe0HIl+i8ygVj
         KLImM7wLgwqYgwHC38M8+IdJpGvQF7STuPF4slPbpqRbJi4onN9XO0pxqn7viPOReHoA
         yD50Kc68GMkGWx3uRxx22P3bY9gTYJmFuwYuPUXwzZF+V0RVlVT+vctp2K+b0qkFvJIn
         S42lTYn684RC3NIapzX5v7GhbOGbCpPUAGz94OauM4EFokmqxeIVwCBS8XRmddSLSnkA
         XfaqPTxJ+62cn994jdfrHXkNizC58LofY5+68+iTjn1jXJqa3vqLrTUAPaCHMxON+wdK
         8Qsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t1hVwJWaLn2x3podPvX+xTLteVECyauDZZjQoDe0D+0=;
        b=gPILtj8hsNwSYZCIgdEUcTbVI/POM9y23jbXKfy3Yz/+lklgo+m7EMoxEqXZXOZM0T
         Nw4iGMO9mwyPM2nndfrDW0uxuoUko/GRpf2kb4RRlOBSl+I4Xyxxy34e4A2ZZJQD3ojO
         8rzA4gt76LAvB+sLcwYzj5HE2a/S9udOyLPi9uTs0F2NiGzWmDcPIWjI1mdsW0sidpxE
         n2WFQGE9m2RYKAd9Oqstsbj6bL5ZBtpd+/4aMpPGBPkc4kpMjnlGHK8chdeArnXVm0A6
         snoghCMXKwm7iSxRtl6JNyFTC3USFJqRnpgJIn0Iol4hD2QigAKC9wprXw2RDDNK2oJK
         xZ7A==
X-Gm-Message-State: AHQUAuY2OYnQj746wVvJP4xgn8DaJQeK0D3nKF0egOuj9WBCOBemCG8L
        CWHvluBCDCx82N4ShVhGrsMgug==
X-Google-Smtp-Source: AHgI3IYc8C5MWgcYOAWGTiHgiPL4HnY4upCes3+oFK6jZQx1q2Z66Zc0aNY3zCVaegBZFxjxNhBD3g==
X-Received: by 2002:a65:6249:: with SMTP id q9mr2077195pgv.229.1550182591612;
        Thu, 14 Feb 2019 14:16:31 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id l73sm7556152pfb.113.2019.02.14.14.16.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 14:16:30 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1guPIz-0005gz-UH; Thu, 14 Feb 2019 15:16:29 -0700
Date:   Thu, 14 Feb 2019 15:16:29 -0700
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
Message-ID: <20190214221629.GD1739@ziepe.ca>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
 <20190211225447.GN24692@ziepe.ca>
 <20190214015314.GB1151@iweiny-DESK2.sc.intel.com>
 <20190214060006.GE24692@ziepe.ca>
 <20190214193352.GA7512@iweiny-DESK2.sc.intel.com>
 <20190214201231.GC1739@ziepe.ca>
 <20190214214650.GB7512@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214214650.GB7512@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 01:46:51PM -0800, Ira Weiny wrote:

> > > > Really unclear how to fix this. The pinned/locked split with two
> > > > buckets may be the right way.
> > > 
> > > Are you suggesting that we have 2 user limits?
> > 
> > This is what RDMA has done since CL's patch.
> 
> I don't understand?  What is the other _user_ limit (other than
> RLIMIT_MEMLOCK)?

With todays implementation RLIMIT_MEMLOCK covers two user limits,
total number of pinned pages and total number of mlocked pages. The
two are different buckets and not summed.

Jason
