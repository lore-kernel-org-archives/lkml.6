Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E3FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92285222A1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JpZ8ZbCo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392810AbfBMXHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 18:07:35 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:47036 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389360AbfBMXHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 18:07:30 -0500
Received: by mail-pl1-f196.google.com with SMTP id o6so1937039pls.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 15:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ycGZ/lql/XedLXMhQw613j8q5/nW7HtOXu0fJma7tbU=;
        b=JpZ8ZbCoGmgsStGrD7Ces+eiaAcEBDwP2MwHm1odgXkmFHZ61NwFL4leS20cW9WLfo
         FGa7uTtaOlqE4a7hhtN87sFCdcCrbr3+9j+g8Zt/SEDaGmT1DL6reEqmJ+sl9zPfB/ZL
         sIvXBaZIjR95Sae1LORKUqxDVbVAdr+AtYHnQl+AMJJuZk44ObCM+ljD1a66/KrTAs1u
         uQuAyBu/AGqV21vCZmuyQyTqyTcG+0nfpmGMLnXNosPfVrazfmWI/04pmdJ2OPq1avXF
         +ffFBzKHBjoz5yrs/5QRZCMudXVQUio/NrXOJ/xwNF8mKZP97g59R7MdV+4bD0TjA6yW
         JyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ycGZ/lql/XedLXMhQw613j8q5/nW7HtOXu0fJma7tbU=;
        b=iYFX+4KbfZpD6qXCzIrxXGCkqfPd3ogCtoDl2hqVqPfNGXulmmgkvmiJPwAnqZdCFZ
         FDk+uyDGDanOc49L8Fr6PfQfhFw36UgmDL3K1ymYWSbp6G/ovc5NTYrJnQfxscPeNR+/
         vAUP/ljvD0D5GvXQ4Op91MDs873JiwjxkZ/I5aH8LQSohUhkj3erVloFKJmfttyZpMtC
         nVjTnhCCfJ5WMaQ5sCNLZbOxLUTR3mUE0/N3bYvmfpq1XaeRL4nSmpz2F1eCFZJSHmaQ
         eZFtHFND5CH9pc+JjPoerqvOdTitFqNcKcIuinH/1d93nfjboWJqlPjt/0txRvL2kvlQ
         L0JA==
X-Gm-Message-State: AHQUAuYj0tzf85+12tbbe3xiYICQW+WmZTeViaB0UuPpEubzsZjZCEA9
        CRtMyqFED6GHsYjdwvEfD84HWg==
X-Google-Smtp-Source: AHgI3IbZxmz9Cji7ywEHkD4zdpRd9ZWq16bVDbDKyOfZsY/wyvM5SVUNTc9mXDq5Bsx5HN2KKJx0pw==
X-Received: by 2002:a17:902:b489:: with SMTP id y9mr666527plr.193.1550099249465;
        Wed, 13 Feb 2019 15:07:29 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id k71sm454104pga.44.2019.02.13.15.07.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 15:07:28 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gu3cl-0001KE-SJ; Wed, 13 Feb 2019 16:07:27 -0700
Date:   Wed, 13 Feb 2019 16:07:27 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        akpm@linux-foundation.org, dave@stgolabs.net, jack@suse.cz,
        cl@linux.com, linux-mm@kvack.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        paulus@ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
        hao.wu@intel.com, atull@kernel.org, mdf@kernel.org, aik@ozlabs.ru,
        peterz@infradead.org
Subject: Re: [PATCH 1/5] vfio/type1: use pinned_vm instead of locked_vm to
 account pinned pages
Message-ID: <20190213230727.GC24692@ziepe.ca>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
 <20190211224437.25267-2-daniel.m.jordan@oracle.com>
 <20190211225620.GO24692@ziepe.ca>
 <20190211231152.qflff6g2asmkb6hr@ca-dmjordan1.us.oracle.com>
 <20190212114110.17bc8a14@w520.home>
 <20190213002650.kav7xc4r2xs5f3ef@ca-dmjordan1.us.oracle.com>
 <20190213130330.76ef1987@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213130330.76ef1987@w520.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 01:03:30PM -0700, Alex Williamson wrote:
> > PeterZ posted an RFC that addresses this point[1].  It kept pinned_vm and
> > locked_vm accounting separate, but allowed the two to be added safely to be
> > compared against RLIMIT_MEMLOCK.
> 
> Unless I'm incorrect in the concerns above, I don't see how we can
> convert vfio before this occurs.

RDMA was converted to this pinned_vm scheme a long time ago, arguably
it is a mistake that VFIO did something different... This was to fix
some other bug where reporting of pages was wrong.

You are not wrong that this approach doesn't entirely make sense
though. :)

Jason
