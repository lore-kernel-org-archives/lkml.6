Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF18C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD80420685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iy3fE71/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD80420685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbeGZOVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:21:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729506AbeGZOVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:21:38 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 359E620685;
        Thu, 26 Jul 2018 13:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532610291;
        bh=MtAG9sp4FkKU6QRe2eM2vwXgHcx8Qmmdc1OXgPJCroc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iy3fE71/DufOkpuMvHi4GnEHP/oju7W08SeGDOuX161pZW7dwRfge4AjRf54QRHPg
         0IYbhSkiQLTbnp4NcdR0auMLYOBLbgdrWi9o0hLtfi3rQ7Ovm5PslYrawR5XSBnDdi
         ypoS/nika0VjDi8B28hZHoqk+bnvqeKSFHdI5uDU=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 6334B1403B8; Thu, 26 Jul 2018 10:04:47 -0300 (-03)
Date:   Thu, 26 Jul 2018 10:04:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sandipan Das <sandipan@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, alexey.budankov@linux.intel.com,
        jolsa@redhat.com, ravi.bangoria@linux.vnet.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH] perf tests: Fix complex event name parsing
Message-ID: <20180726130447.GC17940@kernel.org>
References: <20180726105502.31670-1-sandipan@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726105502.31670-1-sandipan@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 26, 2018 at 04:25:02PM +0530, Sandipan Das escreveu:
> The 'umask' event parameter is unsupported on some architectures
> like powerpc64.
 
> This can be observed on a powerpc64le system running Fedora 27 as
> shown below.
 
>   # perf test "Parse event definition strings" -v
>    6: Parse event definition strings                        :
>   --- start ---
>   test child forked, pid 45915
>   ...
>   running test 3 'cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2,umask=0x3/ukp'Invalid event/parameter 'umask'
>   Invalid event/parameter 'umask'
>   failed to parse event 'cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2,umask=0x3/ukp', err 1, str 'unknown term'
>   event syntax error: '..,event=0x2,umask=0x3/ukp'
>                                     \___ unknown term
 
>   valid terms: event,mark,pmc,cache_sel,pmcxsel,unit,thresh_stop,thresh_start,combine,thresh_sel,thresh_cmp,sample_mode,config,config1,config2,name,period,freq,branch_type,time,call-graph,stack-size,no-inherit,inherit,max-stack,no-overwrite,overwrite,driver-config
 
>   mem_access -> cpu/event=0x10401e0/
>   running test 0 'config=10,config1,config2=3,umask=1'
>   test child finished with 1
>   ---- end ----
>   Parse event definition strings: FAILED!

Thanks, applied, and tested it in a x86_64 fedora 27 machine:

    Committer testing:
    
    After applying the patch these test passes and in verbose mode we get:
    
      # perf test -v "event definition"
       6: Parse event definition strings:
      --- start ---
      test child forked, pid 11061
      running test 0 'syscalls:sys_enter_openat'Using CPUID GenuineIntel-6-9E
      <SNIP>
      running test 53 'cycles/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks'/Duk'
      running test 0 'cpu/config=10,config1,config2=3,period=1000/u'
      running test 1 'cpu/config=1,name=krava/u,cpu/config=2/u'
      running test 2 'cpu/config=1,call-graph=fp,time,period=100000/,cpu/config=2,call-graph=no,time=0,period=2000/'
      running test 3 'cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2/ukp'
      <SNIP>
      test child finished with 0
      ---- end ----
      Parse event definition strings: Ok
      #

- Arnaldo
