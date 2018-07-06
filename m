Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AE5C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 00:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B969624076
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 00:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B969624076
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753564AbeGFAay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 20:30:54 -0400
Received: from mga18.intel.com ([134.134.136.126]:15810 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753451AbeGFAaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 20:30:52 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2018 17:30:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,314,1526367600"; 
   d="scan'208";a="238190557"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.13.138])
  by orsmga005.jf.intel.com with ESMTP; 05 Jul 2018 17:30:49 -0700
Date:   Fri, 6 Jul 2018 08:41:33 +0800
From:   Philip Li <philip.li@intel.com>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        kernel test robot <fengguang.wu@intel.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        palmer@sifive.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild-all@01.org, linux-riscv@lists.infradead.org
Subject: Re: [kbuild-all] [PATCH 3/6] timex: prepare compat helpers for y2038
 changes
Message-ID: <20180706004133.GA24731@intel.com>
References: <20180703054422.12089-4-deepa.kernel@gmail.com>
 <201807051322.sUohKhUO%fengguang.wu@intel.com>
 <CABeXuvoXX2=0XrnpDjxu74QBK3zd6qEk46tzYrMuRD+-FKjbZw@mail.gmail.com>
 <alpine.DEB.2.21.1807052232310.1771@nanos.tec.linutronix.de>
 <CABeXuvpa6GtEOEn5HbYPnAVqqweTXLBH0KUXssGpFBzUNeayZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABeXuvpa6GtEOEn5HbYPnAVqqweTXLBH0KUXssGpFBzUNeayZA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 02:45:05PM -0700, Deepa Dinamani wrote:
> Posted v2 now.
> 
> Fengguang,
> 
> Also the make.cross script pointed to by the kernel test bot is broken
> for riscv.
> 
> I applied the following fix to compile it.
> 
> Pull request: https://github.com/intel/lkp-tests/pull/11
thanks Deepa, i will follow up with the pull request to merge it.

> 
> Thanks,
> Deepa
> 
> On Thu, Jul 5, 2018 at 1:33 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Thu, 5 Jul 2018, Deepa Dinamani wrote:
> >
> >> The error is fixed with the following patch that goes in before patch
> >> 3/6 above in the series.
> >> Let me know if I should post a v2 instead.
> >>
> >> Thanks,
> >> Deepa
> >>
> >>
> >> commit bfe4b046ed7f01154aef44fcb77d3f172929ccc2
> >> Author: Deepa Dinamani <deepa.kernel@gmail.com>
> >> Date:   Thu Jul 5 11:47:25 2018 -0700
> >>
> >>     riscv: Include asm-generic/compat.h
> >>
> >>     riscv does not enable CONFIG_COMPAT in default configurations:
> >>     defconfig, allmodconfig and nomodconfig.
> >>     And hence does not inlude definitions for compat data types.
> >>
> >>     Now that time syscalls are being reused in non CONFIG_COMPAT
> >>     modes, include asm-generic definitions for riscv.
> >>
> >>     Alternative would be to make compat_time.h to be conditional on
> >>     CONFIG_COMPAT_32BIT_TIME. But, since riscv is already has an
> >>     asm/compat.h include the generic version instead.
> >>
> >>     Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> >>     Cc: palmer@sifive.com
> >>     Cc: linux-riscv@lists.infradead.org
> >
> > Post a real patch please instead of something which I have to cleanup
> > manually. A V2 of the series is probably the simplest way.
> >
> > Thanks,
> >
> >         tglx
> _______________________________________________
> kbuild-all mailing list
> kbuild-all@lists.01.org
> https://lists.01.org/mailman/listinfo/kbuild-all
