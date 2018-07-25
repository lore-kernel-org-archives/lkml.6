Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4048C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A874C20671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNkKv+bD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A874C20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731334AbeGYVrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:47:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35802 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729529AbeGYVrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:47:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id a3-v6so8594647wrt.2;
        Wed, 25 Jul 2018 13:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3IzN7CAVIzBh2G5NyqlZwHJNxRUYCpAbQLt2mvhOFok=;
        b=fNkKv+bDJ2dAlJ+a1xK5Y3z4v9RkKfXiR+xDEWTuvQhxZeurJstabCRfPDDZaaq0Zr
         qSKnFWI8kcGb1L6X2cxry6v7Umy7FALo6U356mp4dNZNgJZYcOd7wOqFyIaEnS4Uvj6b
         iS9/sgOk7N3Jy6z3VCIoYmwx/3xjjF6lEpC1TIiyfJe4AZ+GbQBvC00Fh+AMwGnsNgvl
         eTCUPTyiTKM93Elmbp6zwB2FCIy/+cvfc//UJYxyfsWaadaUMWoROFlq85ThHaIlMFWn
         90vMs6EuRseutf/iLfZGVMSN7mY6DMt5H9h+USMwg+PCyEm+zeBBssePBSqjoDRImjFV
         zAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3IzN7CAVIzBh2G5NyqlZwHJNxRUYCpAbQLt2mvhOFok=;
        b=IblnnNayAPt7zcqfFd5ulGWsxd2u05Xzxoscvq7hRpn9bZ5A9/KOUG/VVStpZTyrCA
         6PDCx4y8LKYdQyhz6pvDAF2/sKd0+iu3zdLwRCHYNEUDM8nAeJQ+L/ajKnxMHvPmkQah
         ACx8P50knkYtnWTtM/EZX5RefRnpvnWBaqYAucgd676NzVz4TYsXjex3g1Fw6opClRtW
         mf9WCYOQUYi0TdtOxScVctB1noOAkNJZcikbuPlnIFlqInCJtzACdj6tQa3pKBlxqjsH
         Zw1iUxPrDuiDpfSHaO3OaGuJKy18YxidGdxQnu0k1Muu+05TTQi0c19R/xE0ot3FliZW
         ToNQ==
X-Gm-Message-State: AOUpUlF2Nq1pcqkihTFeoMnS9KBMYzO8ZI/q4dsIceNsmC8WPqE5fU2s
        ev0WRsW0WYbVq7/5o1lH6E0=
X-Google-Smtp-Source: AAOMgpcDRTxJoy/Ye0Tz/fb1LK9v/uFCL9GBFSYK95c2RthSiY0EDI1WdJne2idHPphtnABl2rkz1A==
X-Received: by 2002:adf:9546:: with SMTP id 64-v6mr15012348wrs.257.1532550860294;
        Wed, 25 Jul 2018 13:34:20 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id u18-v6sm33514535wrm.80.2018.07.25.13.34.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 13:34:19 -0700 (PDT)
Date:   Wed, 25 Jul 2018 22:34:16 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexei Starovoitov <ast@fb.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Ahern <dsahern@gmail.com>,
        David Carrillo-Cisneros <davidcc@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>, kernel-team@lge.com,
        Kim Phillips <kim.phillips@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Lukasz Odzioba <lukasz.odzioba@intel.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Maynard Johnson <maynard@us.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Leach <mike.leach@linaro.org>,
        Milian Wolff <milian.wolff@kdab.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Robert Walker <robert.walker@arm.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Sangwon Hong <qpakzk@gmail.com>, stable@vger.kernel.org,
        Stefan Raspl <raspl@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 00/27] perf/core improvements and fixes
Message-ID: <20180725203416.GA3142@gmail.com>
References: <20180725180001.15108-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725180001.15108-1-acme@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling, I'm now investigating why these failed:
> 
>   38: LLVM search and compile                               :
>   38.1: Basic BPF llvm compile                              : Ok
>   38.2: kbuild searching                                    : Ok
>   38.3: Compile source for BPF prologue generation          : Ok
>   38.4: Compile source for BPF relocation                   : FAILED!
>   40: BPF filter                                            :
>   40.1: Basic BPF filtering                                 : Ok
>   40.2: BPF pinning                                         : Ok
>   40.3: BPF prologue generation                             : Ok
>   40.4: BPF relocation checker                              : FAILED!
> 
> 	I think these failures are not related to changes in this patch
> kit. Details about the test environment, versions, etc.

Ok!

> The following changes since commit 1d59d16e9b4d5be80c9786a8b129c0f2af0e9522:
> 
>   Merge remote-tracking branch 'tip/perf/urgent' into perf/core (2018-07-24 14:34:32 -0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.19-20180725

>  52 files changed, 1456 insertions(+), 109 deletions(-)

Pulled, thanks a lot Arnaldo!

Could we please also fix these before v4.18 is released, which trigger in 
perf/urgent:

Warning: Kernel ABI header at 'tools/include/uapi/linux/perf_event.h' differs from latest version at 'include/uapi/linux/perf_event.h'
Warning: Kernel ABI header at 'tools/arch/powerpc/include/uapi/asm/unistd.h' differs from latest version at 'arch/powerpc/include/uapi/asm/unistd.h'
Warning: Kernel ABI header at 'tools/arch/x86/lib/memcpy_64.S' differs from latest version at 'arch/x86/lib/memcpy_64.S'
Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf.h' differs from latest version at 'include/uapi/linux/bpf.h'

?

Thanks!

	Ingo
