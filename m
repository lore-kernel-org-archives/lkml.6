Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436BEC65BD4
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 01:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE4262089D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 01:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE4262089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbeJGIdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 04:33:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:9922 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbeJGIdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 04:33:38 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Oct 2018 18:28:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,350,1534834800"; 
   d="scan'208";a="86320273"
Received: from lensonx-mobl3.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.208.115])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Oct 2018 18:27:40 -0700
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1g8xrA-0000xl-2d; Sun, 07 Oct 2018 09:27:40 +0800
Date:   Sun, 7 Oct 2018 09:27:40 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, LKP <lkp@intel.com>
Subject: Re: [PATCH v4.19-rc7] treewide: Replace more open-coded allocation
 size multiplications
Message-ID: <20181007012740.uv6tujq7ii5iaczc@wfg-t540p.sh.intel.com>
References: <20181005233559.GA37919@beast>
 <20181005235131.GA27193@kroah.com>
 <CAGXu5jJfs0KpRa6yag=ud0sJVW-tM-E4xuvgCMnBdFfDck5E1g@mail.gmail.com>
 <20181006002235.GA18415@kroah.com>
 <20181006031434.GA224454@joelaf.mtv.corp.google.com>
 <20181006084922.xq5bxpghyvbq4tao@wfg-t540p.sh.intel.com>
 <CAGXu5jKftdZdGxkxv6t_maoG2uDqCdBJHvzZoM=Noiakrkyb6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAGXu5jKftdZdGxkxv6t_maoG2uDqCdBJHvzZoM=Noiakrkyb6Q@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 06, 2018 at 08:51:16AM -0700, Kees Cook wrote:
>On Sat, Oct 6, 2018 at 1:49 AM, Fengguang Wu <fengguang.wu@intel.com> wrote:
>> On Fri, Oct 05, 2018 at 08:14:34PM -0700, Joel Fernandes wrote:
>>>
>>> On Fri, Oct 05, 2018 at 05:22:35PM -0700, Greg KH wrote:
>>>> And do we have a way to add a rule to 0-day to catch these so that they
>>>> get a warning when they are added again?
>>>
>>>
>>> They could just be added to scripts/coccinelle and 0-day will report them?
>>>
>>> For example, 0-day ran scripts/coccinelle/api/platform_no_drv_owner.cocci
>>> on
>>> a recently submitted patch and reported it here:
>>>
>>> https://lore.kernel.org/lkml/201808301856.vMNJerSs%25fengguang.wu@intel.com/
>>>
>>> But I'm not sure if 0-day runs make coccicheck on specific semantic
>>> patches,
>>> or runs all of them (CC'd Fengguang).
>>
>> 0-day runs all coccinelle scripts. However only auto report out
>> warnings that are known to have low false positives.
>>
>> So if you add new coccinelle scripts that emit accurate enough
>> warnings, it'd be good to inform the LKP team to add the new
>> warnings to our auto-report-out white list.
>
>It runs with MODE=report by default, yes? I'd need to expand the cases
>to cover that (it is patch-only currently) so that would be a roughly
>10,000 line Coccinelle script. :)

It first runs with "-D report", then with "-D patch" to create
possible patches.

Thanks,
Fengguang
