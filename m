Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DC9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520D0222D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550152809;
	bh=JR2dZ1mZEX5R8rdNc0FxddVQxPeboYBpOXf2+kzbSng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dG7+Kja3CmyQIZzLP1AHltVMKZxtrJRDnK1nMW+0JQGtSwtN62LdRw7MsZ8EjUgsw
	 BC2HC3obKzlNshJ/bjT6GQxSAL0FSUsdKKsptCrbi0fqjd6T1slQnchHGQTn37AD5Z
	 +wG1EhVcNPXdcY704UaBeouiVvwv0hGcwchNTY2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391823AbfBNOAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:00:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:37734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728686AbfBNOAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:00:07 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50A8E2229F;
        Thu, 14 Feb 2019 14:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550152806;
        bh=JR2dZ1mZEX5R8rdNc0FxddVQxPeboYBpOXf2+kzbSng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e+VGCyE5Cybv4oZiGNb4zMa2csrHvN9TL4j5/xEyY+J1JB5+GjH1LCrhmMNphdnLP
         is/ZTCi7CfcqDlXLB1DcTjFe4L7XXXsTVXzvSLsm/lGHq5IifcpN50SVlmnV16KEiC
         QBH8T8Wzpk8zAtCmG2EQ1OeBPWiPu+ekDd4zPJuA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E2160410D5; Thu, 14 Feb 2019 10:59:58 -0300 (-03)
Date:   Thu, 14 Feb 2019 10:59:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC/PATCH 00/14] perf record: Add support to store data in
 directory
Message-ID: <20190214135958.GB7074@kernel.org>
References: <20190205133727.GF4794@krava>
 <20190211101957.GB14253@krava>
 <CABPqkBSkyHRaXN-oVLuJJ=aPEBfqOAunRUReHsxESnC=KKQuPg@mail.gmail.com>
 <20190211185306.GD5046@krava>
 <20190211193202.GG3269@kernel.org>
 <20190211201831.GE5046@krava>
 <CABPqkBRdmfOde793id4GEuwD=eYL8TLKe1p8k07xWAh1MPD3AQ@mail.gmail.com>
 <20190214113450.GC26714@krava>
 <20190214125759.GS3269@kernel.org>
 <20190214132638.GB13095@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214132638.GB13095@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 14, 2019 at 02:26:38PM +0100, Jiri Olsa escreveu:
> On Thu, Feb 14, 2019 at 09:57:59AM -0300, Arnaldo Carvalho de Melo wrote:
> > But with the build id in the MMAPs we wouldn't need to scan anything at
> > 'perf record' time, just at 'perf archive' time, where we would scan
> > everything, and as soon as we find a hit, we add that DSO to the list of
> > things we need to put in the tarball.
 
> ok.. it might little change the expected behavour in that you will not
> have .debug cache populated until you run perf archive.. some profile
> data might stop report after you reinstall the binary..

Well, nothing prevents us from continuing to, in 'perf record', go thru
the perf.data just collected to populate the .debug cache, its just that
we would do it just for that, for populating the cache, we wouldn't
_have_ to do that for collecting the buildids.

> on the other hand '.debug' cache would stop growing uncontrolably..
> so I think I'd be ok with this

That is another problem, and one that has to be solved in a way similar
to ccache's --max-size option.

The .debug cache is useful for various workflows, but may get in the way
for some others, which is why we have ways to disable it.

For instance, when working on some project it is handy to have copies of
binaries saved so that older perf.data files can find a file that was
rewritten by the compiler when doing changes in it, etc.

With the .debug cache and if using -g, we can get the older copy of the
binary _and_ its sources, annotation for older versions continue to
work, etc.

- Arnaldo
