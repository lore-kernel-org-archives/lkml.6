Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6F7C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27BC920823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4O/CUN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27BC920823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeJaAFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:05:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbeJaAFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:05:33 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AED53204FD;
        Tue, 30 Oct 2018 15:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540912301;
        bh=c5qZK/ylEs1KowBEgAkpI4GJ7m5Kt/PIxHrNGM5No0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U4O/CUN3U1VlDx9f/pCdd5SZL9kn24nJ7t/PUPkHW97UJSPoSTS+VtPA/CGhPoAN9
         cJZvvuK1gsBTF2qIXnVGKTeqjaPsq1WlJ8wTgk2J7+yyOQSGCrjTciYFOKGl0iQ0Np
         jPVViA9Hcpf7v/LogHz/IZN7/qX1tFuEFf0TRwpY=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 0FD64142C5F; Tue, 30 Oct 2018 12:11:38 -0300 (-03)
Date:   Tue, 30 Oct 2018 12:11:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     leo.yan@linaro.org, Adrian Hunter <adrian.hunter@intel.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH] perf cs-etm: Correct CPU mode for samples
Message-ID: <20181030151137.GF23310@kernel.org>
References: <1540883908-17018-1-git-send-email-leo.yan@linaro.org>
 <20181030143226.GA23310@kernel.org>
 <20181030150449.GB8344@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030150449.GB8344@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 30, 2018 at 11:04:49PM +0800, leo.yan@linaro.org escreveu:
> Hi Arnaldo,
> 
> On Tue, Oct 30, 2018 at 11:32:26AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Oct 30, 2018 at 03:18:28PM +0800, Leo Yan escreveu:
> > > Since commit 9042f5e3539e ("perf tools: Stop fallbacking to kallsyms
> > > for vdso symbols lookup"), the kernel address cannot be properly parsed
> > > to kernel symbol with command 'perf script -k vmlinux'.  The reason is
> > > CoreSight samples is always to set CPU mode as PERF_RECORD_MISC_USER,
> > > thus it fails to find corresponding map/dso in below flows:
> > > 
> > >   process_sample_event()
> > >     `-> machine__resolve()
> > > 	  `-> thread__find_map(thread, sample->cpumode, sample->ip, al);
> > > 
> > > In this flow it needs to pass argument 'sample->cpumode' to tell what's
> > > the CPU mode, before it always passed PERF_RECORD_MISC_USER but without
> > > any failure until the commit 9042f5e3539e ("perf tools: Stop fallbacking
> > > to kallsyms for vdso symbols lookup") has been merged.  The reason is
> > > even with the wrong CPU mode the function thread__find_map() firstly
> > > fails to find map but it will rollback to find kernel map for vdso
> > > symbols lookup.  In the latest code it has removed the fallback code,
> > > thus if CPU mode is PERF_RECORD_MISC_USER then it cannot find map
> > > anymore with kernel address.
> > > 
> > > This patch is to correct samples CPU mode setting, it creates a new
> > > helper function cs_etm__cpu_mode() to tell what's the CPU mode based on
> > > the address with the info from machine structure; this patch has a bit
> > > extension to check not only kernel and user mode, but also check for
> > > host/guest and hypervisor mode.  Finally this patch uses the function
> > > in instruction and branch samples and also apply in cs_etm__mem_access()
> > > for a minor polishing.
> > 
> > Mathieu, can I have your Acked-by, please? Leo, thanks for acting so
> > quickly on this one! 
> 
> Thanks for reivewing.  Yeah, let's wait for Mathieu reviewing as well,
> as I know he is travelling so might be delay a bit.

I'm tentatively applying the patch, as this needs fixing ASAP, and I
take that you have tested it and it cured the problem for you, so should
be a good indication for the acceptance of the patch.

We can always fix some detail later.
 
> Just remind, we might need the similiar change for util/intel-pt.c and
> util/intel-bts.c when generate samples, otherwise they might have the
> same regression for kernel symbols.  I am not the best person to change
> these two files, but bring up this for attention.

Right, I think Adrian is working on it, Adrian?
 
> > Now processing coresight traces should be faster, less lookups :-)
> 
> Thanks!

- Arnaldo
