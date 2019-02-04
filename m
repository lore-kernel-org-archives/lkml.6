Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D73C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CB3214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549293912;
	bh=6h0CpBkkUQl1k+1mcy9kVr5mt2/CR36wP7uWk0zSAHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZH5ekHruecaPUaDHfbTwagMvpVV/s/o32IdFKWiGbFULPSGCYyqnXKfy5AeKiYwkw
	 Tz3mtJrQC3WGWamYEARxFmYktGzYrMHvK07FgOWKY7glhLHkss8gWO+J0tQS54KUec
	 H5Q89I0uRVr1z8NIk7ab460HvapwG29cLkf5KiOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbfBDPZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:25:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:41044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728273AbfBDPZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 10:25:09 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B2502087C;
        Mon,  4 Feb 2019 15:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549293908;
        bh=6h0CpBkkUQl1k+1mcy9kVr5mt2/CR36wP7uWk0zSAHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fqkp9HaWpFrod6idTAbZsfMMIwF6TDX81qEkw0UGgmJLV3Q1gJV9G+51q47MQd9fr
         xjuScEzLLrqtFfC/o+80vPV5ZCW4M+0QcYByH18zBo7OZOgq3Ze/Cg2ogmLCubwJGX
         TWQc3YUtM3jcQM97UCppMjNNvmJRBbcpmRW6A9m4=
Date:   Mon, 4 Feb 2019 16:25:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Prateek Patel <prpatel@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Qian Cai <cai@lca.pw>, LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH v2] of: fix kmemleak crash
Message-ID: <20190204152505.GA12918@kroah.com>
References: <CAL_JsqKQb34zVNTzo9DLNiDwmWGxkrKezSOjwCUPAvgzUoLYjg@mail.gmail.com>
 <20190121174234.GC26461@rapoport-lnx>
 <2bb30550-435a-046c-4f45-21dd594aa695@free.fr>
 <3c886941-bf9d-f040-b568-ee7a8eba9a04@free.fr>
 <CGME20190123055509epcas3p18a6d66fa08412f2308cb2c1997328ea8@epcas3p1.samsung.com>
 <20190123055414.GA4747@rapoport-lnx>
 <78f4ea8a-996d-038e-9e33-5ff02fa2c43f@samsung.com>
 <20190123123143.GE4747@rapoport-lnx>
 <f2bdb061-2fdf-ee78-fc46-a38ebb40b03f@free.fr>
 <f6ea664b-68e9-de57-e5de-c691d828c8a2@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6ea664b-68e9-de57-e5de-c691d828c8a2@free.fr>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 11:10:39AM +0100, Marc Gonzalez wrote:
> + GKH
> 
> On 01/02/2019 17:23, Marc Gonzalez wrote:
> 
> > On 23/01/2019 13:31, Mike Rapoport wrote:
> > 
> >> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> >> Tested-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> >> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >> ---
> >>  drivers/of/of_reserved_mem.c | 18 +++++-------------
> >>  1 file changed, 5 insertions(+), 13 deletions(-)
> > 
> > Thanks for the patch, Mike.
> > 
> > Whose tree should this patch go through?
> 
> By the way, I think we can add
> 
> Acked-by: Prateek Patel <prpatel@nvidia.com>
> Fixes: 3f0c820664483 ("drivers: of: add initialization code for dynamic reserved memory")
> Cc: stable@vger.kernel.org # 3.15+

What am I supposed to do with this?

confused,

greg k-h
