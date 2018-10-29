Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE5FC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8962E2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGW7oHIh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8962E2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbeJ3DWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:22:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:59108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728221AbeJ3DWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:22:51 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D43592080A;
        Mon, 29 Oct 2018 18:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540837980;
        bh=Lk15W6sR8shuOHtrfohOoWYvE/72muOe/v6MpngrcR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DGW7oHIhLEvUgwYmSA44BDciXxsXi8V/XNhqaJqES5TBWr4zMkRQ4C9561MsoE2jc
         n2Jn7luZlB0gvEDASxQpuIKEfRFLKwHUTc4hPOJye3AxilsmDrk4q2kEDwk726302a
         QFQhx84ie7dk2R9ssIpv6RrZB8gxnuFNJHEzFfxY=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 0B2BC142C5F; Mon, 29 Oct 2018 15:32:58 -0300 (-03)
Date:   Mon, 29 Oct 2018 15:32:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
        wangnan0@huawei.com, jolsa@kernel.org, namhyung@kernel.org,
        kan.liang@intel.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        peterz@infradead.org
Subject: Re: [PATCHES/RFC] Re: A concern about overflow ring buffer mode
Message-ID: <20181029183258.GL21857@kernel.org>
References: <0247fca0-5a94-9a83-cefa-282804316729@linux.intel.com>
 <20181029.104008.791032322062574758.davem@davemloft.net>
 <b488a063-276c-ab8f-954e-f68e951146b4@linux.intel.com>
 <20181029.104827.680192866924184016.davem@davemloft.net>
 <d3626e3f-5993-7ee7-f817-48e9dcee17f4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3626e3f-5993-7ee7-f817-48e9dcee17f4@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 29, 2018 at 02:20:15PM -0400, Liang, Kan escreveu:
> 
> 
> On 10/29/2018 1:48 PM, David Miller wrote:
> > From: "Liang, Kan" <kan.liang@linux.intel.com>
> > Date: Mon, 29 Oct 2018 13:42:56 -0400
> > 
> > > 
> > > 
> > > On 10/29/2018 1:40 PM, David Miller wrote:
> > > > From: "Liang, Kan" <kan.liang@linux.intel.com>
> > > > Date: Mon, 29 Oct 2018 10:33:06 -0400
> > > > 
> > > > > I just realized that the problem in KNL will be back if we switch
> > > > > back to non-overwrite mode.
> > > > What is KNL?
> > > > 
> > > Intel Xeon Phi Processor, Knights Landing.
> > 
> > I don't understand how a specific piece of hardware directly leads to
> > ring buffer processing timeouts, or multi-minute thread map processing
> > times...
> 
> Perf top processes all samples in a serial way. With the number of CPU
> increasing under the heavy load, the number of samples increase
> dramatically. The processing time also increase significantly.
> When the processing time is longer than display refresh time, only the stale
> data is shown.
> 
> I use KNL as an example. Because the problem is even worse on KNL. There is
> nothing output with perf top.
> 
> In theory, it's a problem for all large scale platforms.
> 
> > 
> > You'll have to explain all of the details of your test scenerio, and
> > the exact problems triggers, which
> 
> My test was the same as yours, just running a parallel kernel build on KNL.
> 
> > caused you to write these patches
> > which causes serious regressions for what I consider a core simple use
> > case of perf top.
> 
> I agree that the warning message is annoying. I will try to find another way
> to deliver the message. But I think we do need the warning message.

There is no problem with the message, the problem is the thread where
the message is being displayed, just signal the display thread to
display the warning, not doing that in the event processing thread.
 
> You didn't see any warning before the patch. I think it is just because perf
> top hides the problem.
> 
> Thanks,
> Kan
> > 
> > And that's running perf top during a parallel kernel build.
> > 
> > 
