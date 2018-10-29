Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86896C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF4320880
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaqPJUen"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF4320880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbeJ2XYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 19:24:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbeJ2XYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 19:24:04 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58A442087A;
        Mon, 29 Oct 2018 14:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540823709;
        bh=6ChYCwOl1KhuOEpfA/eluSOjslLDTvWiQ7/x/uRK9Ig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NaqPJUen2BeCPwqpoGJhdxYSUZ6Zh7tSIBnLDqxe2BwQaMsVCwol3o2QL8FsDbokr
         fYtOa1XXHRpcKQGTUEMDNiPaJwI1b16jIuP7jjC0k+LxXEPi0HvTDbTmy+hXQKbp0s
         YIIVp5PbXXwrUM+P0I7iLMcOXgnLeWqBdVvHxye8=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 461C3142C5F; Mon, 29 Oct 2018 11:35:06 -0300 (-03)
Date:   Mon, 29 Oct 2018 11:35:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
        Wang Nan <wangnan0@huawei.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCHES/RFC] Re: A concern about overflow ring buffer mode
Message-ID: <20181029143506.GF21857@kernel.org>
References: <20181026183805.GD3353@kernel.org>
 <20181026184255.GE3353@kernel.org>
 <20181026190211.GF3353@kernel.org>
 <3b81c999-9039-94e9-7a74-cdbd48fca08b@linux.intel.com>
 <20181026191231.GG3353@kernel.org>
 <65cbd052-15d9-f3fb-4a8f-781c3ce7a297@linux.intel.com>
 <20181026192424.GH3353@kernel.org>
 <4f84468f-37d9-cf1b-12c1-514ef74b6a48@linux.intel.com>
 <20181029130331.GC21857@kernel.org>
 <0247fca0-5a94-9a83-cefa-282804316729@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0247fca0-5a94-9a83-cefa-282804316729@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 29, 2018 at 10:33:06AM -0400, Liang, Kan escreveu:
> On 10/29/2018 9:03 AM, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Oct 26, 2018 at 04:11:51PM -0400, Liang, Kan escreveu:
> > > On 10/26/2018 3:24 PM, Arnaldo Carvalho de Melo wrote:
> > > > Em Fri, Oct 26, 2018 at 03:16:29PM -0400, Liang, Kan escreveu:
> > > It is mainly for performance reason to switch to overwrite mode. The impact
> > > was very small when I did my test. But now the effect is easily noticeable
> > > in other tests. Yes, I agree. We may change it back to non-overwrite mode
> > > until the issue is addressed.

> > So, I have these two patches in my perf/core branch, with Fixes tags
> > that will make them get to the stable kernels, ok?
 
> I just realized that the problem in KNL will be back if we switch back to
> non-overwrite mode.
> The problem is that users have to wait tens of minutes to see perf top
> results on the screen in KNL. Before that, there is nothing but a black
> screen.
 
> Sorry I didn't notice it last Friday. Because I thought the ui_warning in
> perf_top__mmap_read() can give user a hint. So the user can switch to
> overwrite mode manually.
> But unfortunately, the ui_warning doesn't work. Because it is called after
> perf_top__mmap_read(). The processing time of perf_top__mmap_read() could be
> tens of minutes.

So we need a way to notice that we're in a machine like that and warn
the user before the wait takes place, ideas on how to do that?

- Arnaldo
