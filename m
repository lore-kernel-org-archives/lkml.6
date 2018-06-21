Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661DAC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 05:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A029208B7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 05:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A029208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932795AbeFUFti (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 01:49:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:54762 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932633AbeFUFth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 01:49:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2018 22:49:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,250,1526367600"; 
   d="scan'208";a="68746093"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.146.239])
  by orsmga002.jf.intel.com with ESMTP; 20 Jun 2018 22:49:29 -0700
Date:   Thu, 21 Jun 2018 13:51:44 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com,
        pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk
Subject: Re: [PATCH v11 6/6] x86/tsc: use tsc early
Message-ID: <20180621055144.i65hhyqe5dofop33@shbuild888>
References: <20180620212700.29178-1-pasha.tatashin@oracle.com>
 <20180620212700.29178-7-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620212700.29178-7-pasha.tatashin@oracle.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Wed, Jun 20, 2018 at 05:27:00PM -0400, Pavel Tatashin wrote:
> We want to get timestamps and high resultion clock available to us as early
> as possible in boot. But, native_sched_clock() outputs time based either on
> tsc after tsc_init() is called later in boot, or using jiffies when clock
> interrupts are enabled, which is also happens later in boot.
> 
> On the other hand, we know tsc frequency from as early as when
> tsc_early_delay_calibrate() is called. So, we use the early tsc calibration
> to output timestamps early. Later in boot when tsc_init() is called we
> calibrate tsc again using more precise methods, and start using that.
> 
> Since sched_clock() is in a hot path, we want to make sure that no
> regressions are introduced to this function after machine is booted, this
> is why we are using static branch that is enabled by default, but is
> disabled once we have initialized a permanent clock source.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> ---
>  arch/x86/kernel/tsc.c | 64 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 45 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 654a01cc0358..1dd69612c69c 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -39,6 +39,9 @@ EXPORT_SYMBOL(tsc_khz);
>  static int __read_mostly tsc_unstable;
>  
>  static DEFINE_STATIC_KEY_FALSE(__use_tsc);
> +static DEFINE_STATIC_KEY_TRUE(tsc_early_enabled);

Do we still need add a static_key? after Peter worked out the patch
to enable ealy jump_label_init?

Thanks,
Feng
