Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C853C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221E321884
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 221E321884
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389601AbeHGTMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 15:12:23 -0400
Received: from foss.arm.com ([217.140.101.70]:56876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727605AbeHGTMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 15:12:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7CA980D;
        Tue,  7 Aug 2018 09:57:10 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9874F3F5B3;
        Tue,  7 Aug 2018 09:57:10 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id B84361AE2D8E; Tue,  7 Aug 2018 17:57:14 +0100 (BST)
Date:   Tue, 7 Aug 2018 17:57:14 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Jason Baron <jbaron@akamai.com>,
        Tony Luck <tony.luck@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joe Perches <joe@perches.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [RFC PATCH 3/3] dynamic_debug: Add support for dynamic register
 trace
Message-ID: <20180807165713.GJ21809@arm.com>
References: <cover.1533211508.git.saiprakash.ranjan@codeaurora.org>
 <37c723a7892b21eb67b8447160d8d602703f321f.1533211509.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37c723a7892b21eb67b8447160d8d602703f321f.1533211509.git.saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 07:58:44PM +0530, Sai Prakash Ranjan wrote:
> Introduce dynamic debug filtering mechanism to register
> tracing as dynamic_rtb() which will reduce a lot of
> overhead otherwise of tracing all the register reads/writes
> in all files.
> 
> Now we can just specify the file name or any wildcard pattern
> as any other dynamic debug facility in bootargs and dynamic rtb
> will just trace them and the output can be seen in pstore.
> 
> TODO: Now we use same 'p' flag but will add a separate flag for register trace
> later.
> 
> Example for tracing all register reads/writes in drivers/soc/qcom/* below:
> 
>   # dyndbg="file drivers/soc/qcom/* +p" in bootargs
>   # reboot -f
>   # mount -t pstore pstore /sys/fs/pstore
>   # cat /sys/fs/pstore/rtb-ramoops-0
>     [LOGK_WRITEL ] ts:1373030419  data:ffff00000d5065a4  <ffff00000867cb44>  qcom_smsm_probe+0x51c/0x668
>     [LOGK_WRITEL ] ts:1373360576  data:ffff00000d506608  <ffff00000867cb44>  qcom_smsm_probe+0x51c/0x668
> 
> Also we add uncached_logk api to readl/writel definitions for arm64
> as of now. This can be extended to arm as well later for tracing.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  arch/arm64/include/asm/io.h   | 93 +++++++++++++++++++++++++++++++++++

Putting all of this in the arch code, which basically duplicates everything,
feels very wrong to me. Perhaps take a look at the ongoing work for
instrumenting the atomics and take some inspiration from there?

Ideally, the architecture just needs to provide the low-level primivites
(which it already does) and the core can generate instruments versions if
required.

Will
