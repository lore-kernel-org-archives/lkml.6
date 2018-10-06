Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA803C65BD0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 08:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797D02087D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 08:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797D02087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbeJFPvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 11:51:54 -0400
Received: from mga11.intel.com ([192.55.52.93]:29339 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727762AbeJFPvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 11:51:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Oct 2018 01:49:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,348,1534834800"; 
   d="scan'208";a="86211030"
Received: from lensonx-mobl3.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.208.115])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Oct 2018 01:49:23 -0700
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1g8iH4-0005M5-Ub; Sat, 06 Oct 2018 16:49:22 +0800
Date:   Sat, 6 Oct 2018 16:49:22 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, LKP <lkp@intel.com>
Subject: Re: [PATCH v4.19-rc7] treewide: Replace more open-coded allocation
 size multiplications
Message-ID: <20181006084922.xq5bxpghyvbq4tao@wfg-t540p.sh.intel.com>
References: <20181005233559.GA37919@beast>
 <20181005235131.GA27193@kroah.com>
 <CAGXu5jJfs0KpRa6yag=ud0sJVW-tM-E4xuvgCMnBdFfDck5E1g@mail.gmail.com>
 <20181006002235.GA18415@kroah.com>
 <20181006031434.GA224454@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181006031434.GA224454@joelaf.mtv.corp.google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 08:14:34PM -0700, Joel Fernandes wrote:
>On Fri, Oct 05, 2018 at 05:22:35PM -0700, Greg KH wrote:
>> On Fri, Oct 05, 2018 at 05:04:16PM -0700, Kees Cook wrote:
>> > On Fri, Oct 5, 2018 at 4:51 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
>> > > On Fri, Oct 05, 2018 at 04:35:59PM -0700, Kees Cook wrote:
>> > >> As done treewide earlier, this catches several more open-coded
>> > >> allocation size calculations that were added to the kernel during the
>> > >> merge window. This performs the following mechanical transformations
>> > >> using Coccinelle:
>> > >>
>> > >>       kvmalloc(a * b, ...) -> kvmalloc_array(a, b, ...)
>> > >>       kvzalloc(a * b, ...) -> kvcalloc(a, b, ...)
>> > >>       devm_kzalloc(..., a * b, ...) -> devm_kcalloc(..., a, b, ...)
>> > >>
>> > >> Signed-off-by: Kees Cook <keescook@chromium.org>
>> > >
>> > > Has this had any testing in linux-next?
>> >
>> > No; they're mechanical transformations (though I did build test them).
>> > If you want I could add this to linux-next for a week?
>>
>> That would be good, thanks.
>>
>> > > And when was "earlier"?
>> >
>> > v4.18, when all of these were originally eliminated:
>> >
>> > 026f05079b00 treewide: Use array_size() in f2fs_kzalloc()
>> > c86065938aab treewide: Use array_size() in f2fs_kmalloc()
>> > 76e43e37a407 treewide: Use array_size() in sock_kmalloc()
>> > 84ca176bf54a treewide: Use array_size() in kvzalloc_node()
>> > fd7becedb1f0 treewide: Use array_size() in vzalloc_node()
>> > fad953ce0b22 treewide: Use array_size() in vzalloc()
>> > 42bc47b35320 treewide: Use array_size() in vmalloc()
>> > a86854d0c599 treewide: devm_kzalloc() -> devm_kcalloc()
>> > 3c4211ba8ad8 treewide: devm_kmalloc() -> devm_kmalloc_array()
>> > 778e1cdd81bb treewide: kvzalloc() -> kvcalloc()
>> > 344476e16acb treewide: kvmalloc() -> kvmalloc_array()
>> > 590b5b7d8671 treewide: kzalloc_node() -> kcalloc_node()
>> > 6396bb221514 treewide: kzalloc() -> kcalloc()
>> > 6da2ec56059c treewide: kmalloc() -> kmalloc_array()
>> >
>> > The new patch is catching new open-coded multiplications introduced in v4.19.
>>
>> As this is getting smaller, why not just break it up and do it through
>> all of the different subsystems instead of one large patch?
>>
>> And do we have a way to add a rule to 0-day to catch these so that they
>> get a warning when they are added again?
>
>They could just be added to scripts/coccinelle and 0-day will report them?
>
>For example, 0-day ran scripts/coccinelle/api/platform_no_drv_owner.cocci on
>a recently submitted patch and reported it here:
>https://lore.kernel.org/lkml/201808301856.vMNJerSs%25fengguang.wu@intel.com/
>
>But I'm not sure if 0-day runs make coccicheck on specific semantic patches,
>or runs all of them (CC'd Fengguang).

0-day runs all coccinelle scripts. However only auto report out
warnings that are known to have low false positives.

So if you add new coccinelle scripts that emit accurate enough
warnings, it'd be good to inform the LKP team to add the new
warnings to our auto-report-out white list.

Thanks,
Fengguang
