Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD472C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A63214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1cN8OEKh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A63214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbeKUW45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 17:56:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:39864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728428AbeKUW45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 17:56:57 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E950B214C4;
        Wed, 21 Nov 2018 12:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542802967;
        bh=PUTb0DSsTAgeOTW0WRRcCQaSctk1wATXbnADztcRktk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1cN8OEKh4Kckix3JAGi5qcAASZx96NJZBBkE17d50lCj5ewebob8w6Wi0WJViSrlS
         NQXvOyrZwYTul2oPjNa8sbIzTyQgoAWa3/b5l6HdP7cUnLCtwWyQMpbTMurocZMZ3U
         Y9jja95AEMTJF6/ef7YRlrB5z2Dw6sBbIKHISfAY=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 85DDF1443D6; Wed, 21 Nov 2018 09:22:43 -0300 (-03)
Date:   Wed, 21 Nov 2018 09:22:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, mingo@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, ak@linux.intel.com
Subject: Re: [PATCH 1/2] perf vendor events: Add stepping in CPUID string for
 x86
Message-ID: <20181121122243.GC6248@kernel.org>
References: <20181114212416.15665-1-kan.liang@linux.intel.com>
 <20181115204411.GO9600@krava>
 <cc982c1b-0774-6f3e-a24a-3c3fba5c900b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc982c1b-0774-6f3e-a24a-3c3fba5c900b@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 15, 2018 at 04:01:46PM -0500, Liang, Kan escreveu:
> 
> 
> On 11/15/2018 3:44 PM, Jiri Olsa wrote:
> > On Wed, Nov 14, 2018 at 01:24:15PM -0800, kan.liang@linux.intel.com wrote:
> > > From: Kan Liang <kan.liang@linux.intel.com>
> > > 
> > > Perf tools cannot find the proper event list for Cascadelake server.
> > > Because Cascadelake server and Skylake server have the same CPU model
> > > number, which are used by perf tools to find the event list.
> > > 
> > > The stepping for Skylake server is up to 4.
> > > The stepping for Cascadelake server starts from 5.
> > > The stepping can be used to distinguish between them.
> > > 
> > > The stepping is added in get_cpuid_str().
> > > The stepping information for Skylake server is updated in mapfile.csv.
> > > A x86 specific strcmp_cpuid_cmp() function is added to handle two CPUID
> > > formats in mapfile.csv, "vendor-family-model-stepping" and
> > > "vendor-family-model".
> > > - If a cpuid-regular-expression from the mapfile.csv using the new
> > >    stepping format, a cpuid-string generated on the machine must include
> > >    stepping. Otherwise, it is a mismatch.
> > > - If the cpuid-regular-expression using the old non-stepping format,
> > >    the stepping in the cpuid-string will be ignored.
> > > 
> > > The script, which using environment string "PERF_CPUID" without stepping
> > > on Skylake server, will be broken. If so, users must fix their scripts.
> > > 
> > > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> > 
> > Reviewed-by: Jiri Olsa <jolsa@kernel.org>
 
> Thanks Jirka,
 
> Hi Arnaldo,
 
> Are you OK with the patch?
> If yes, I will go ahead to cleanup the *_cpuid_str() by moving them to
> header.c as promised. https://lkml.org/lkml/2018/11/15/929
> The new patch will be on top of this patch.

Looks ok after reading the discussion between you and Jiri, will now
look at the patch that Jiri reviewed.

- Arnaldo
