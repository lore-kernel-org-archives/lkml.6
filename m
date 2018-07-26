Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1124C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB77B2083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2dL9VGQI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB77B2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731583AbeGZUcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:32:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:57932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729801AbeGZUcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:32:52 -0400
Received: from jouet.infradead.org (unknown [177.79.81.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CCF320673;
        Thu, 26 Jul 2018 19:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532632479;
        bh=vme20K9mDxTv3P+9CN5JVS9660ReYEZMxgLcbYPCMUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2dL9VGQIMzoOgkLr2sazpFpyQgK8gusOCLbRw08bAxNIETwmxAsw6D4/0srSaScLG
         Z9R7gbEy8X3EbEK3ZuP+b5XWe6Vmm2E9CCGu4UyhP374yvfI/MKsyx3hoW63YNpaAa
         lceO/ndo3f+2gdCRKrT4rLeUcyPy78pmaHZ2l/MQ=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 673B81403B8; Thu, 26 Jul 2018 16:14:35 -0300 (-03)
Date:   Thu, 26 Jul 2018 16:14:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sandipan Das <sandipan@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Ingo Molnar <mingo@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Clark Williams <williams@redhat.com>,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>, linux-kernel@vger.kernel.org,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: Re: BPF relocation 'perf test' entries failing was: Re: [GIT PULL
 00/27] perf/core improvements and fixes
Message-ID: <20180726191435.GB20438@kernel.org>
References: <20180726131534.GD17940@kernel.org>
 <2fbfac01-e103-8daf-6187-b94d1725dbd0@linux.ibm.com>
 <20180726185805.GA20438@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726185805.GA20438@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 26, 2018 at 03:58:05PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Jul 26, 2018 at 11:04:08PM +0530, Sandipan Das escreveu:
> > I came across the same problem. Does the following patch fix it?

> > https://lkml.org/lkml/2018/7/26/669
 
> Oh my, that one was subtle... Checking...

Right, when it said it was running:

  40.3: BPF prologue generation

In fact it was running:

  40.4: BPF relocation checker

That error message in the 'perf test -v' output:

  libbpf: Program 'func=sys_write' contains non-map related relo data pointing to section 65522

Was the _expected_ one for "40.4: BPF relocation checker", then it
failed when it couldn't run the off by one "last" subtest, duh.

Thomas, this was a problem introduced by a patch from you, just for
reference, this one:

    Fixes: 9ef0112442bd ("perf test: Fix subtest number when showing results")

I should have caught this by running 'perf test' before/after applying
that patch, I'll now make sure this is done before sending pull reqs
upstream.

In fact I did after, and thought, hey, some BPF related regression, I
must've updated clang/llvm and something new appeared on the radar, so I
went that direction and went nowhere, well, now I have an uptodate
llvm/clang combo to play with BTF, pahole, etc 8-)

Thanks!

- Arnaldo
