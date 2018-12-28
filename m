Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE68C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 03:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DF7214C6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 03:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731250AbeL1D1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 22:27:50 -0500
Received: from mga12.intel.com ([192.55.52.136]:48324 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731205AbeL1D1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 22:27:49 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2018 19:27:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,407,1539673200"; 
   d="scan'208";a="121697285"
Received: from wangdan1-mobl1.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.210.154])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Dec 2018 19:27:45 -0800
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1gcioK-0004r0-HH; Fri, 28 Dec 2018 11:27:44 +0800
Date:   Fri, 28 Dec 2018 11:27:44 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Fan Du <fan.du@intel.com>, KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yao Yuan <yuan.yao@intel.com>,
        Peng Dong <dongx.peng@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Liu Jingqi <jingqi.liu@intel.com>,
        Dong Eddie <eddie.dong@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Zhang Yi <yi.z.zhang@linux.intel.com>
Subject: Re: [RFC][PATCH v2 01/21] e820: cheat PMEM as DRAM
Message-ID: <20181228032744.i6d7g7ykdi7hjrai@wfg-t540p.sh.intel.com>
References: <20181226131446.330864849@intel.com>
 <20181226133351.106676005@intel.com>
 <20181227034141.GD20878@bombadil.infradead.org>
 <20181227041132.xxdnwtdajtm7ny4q@wfg-t540p.sh.intel.com>
 <CAPcyv4hBBvcHiUSU4ER6WV7Po_GEwDjFcJy2aE3VW5Nwiu+Qyw@mail.gmail.com>
 <CAHbLzkqR2z+wcVXkKRoHysXtjtn12P33emr15h_HB=jMaByV5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHbLzkqR2z+wcVXkKRoHysXtjtn12P33emr15h_HB=jMaByV5w@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2018 at 11:32:06AM -0800, Yang Shi wrote:
>On Wed, Dec 26, 2018 at 9:13 PM Dan Williams <dan.j.williams@intel.com> wrote:
>>
>> On Wed, Dec 26, 2018 at 8:11 PM Fengguang Wu <fengguang.wu@intel.com> wrote:
>> >
>> > On Wed, Dec 26, 2018 at 07:41:41PM -0800, Matthew Wilcox wrote:
>> > >On Wed, Dec 26, 2018 at 09:14:47PM +0800, Fengguang Wu wrote:
>> > >> From: Fan Du <fan.du@intel.com>
>> > >>
>> > >> This is a hack to enumerate PMEM as NUMA nodes.
>> > >> It's necessary for current BIOS that don't yet fill ACPI HMAT table.
>> > >>
>> > >> WARNING: take care to backup. It is mutual exclusive with libnvdimm
>> > >> subsystem and can destroy ndctl managed namespaces.
>> > >
>> > >Why depend on firmware to present this "correctly"?  It seems to me like
>> > >less effort all around to have ndctl label some namespaces as being for
>> > >this kind of use.
>> >
>> > Dave Hansen may be more suitable to answer your question. He posted
>> > patches to make PMEM NUMA node coexist with libnvdimm and ndctl:
>> >
>> > [PATCH 0/9] Allow persistent memory to be used like normal RAM
>> > https://lkml.org/lkml/2018/10/23/9
>> >
>> > That depends on future BIOS. So we did this quick hack to test out
>> > PMEM NUMA node for the existing BIOS.
>>
>> No, it does not depend on a future BIOS.
>
>It is correct. We already have Dave's patches + Dan's patch (added
>target_node field) work on our machine which has SRAT.

Thanks for the correction. It looks my perception was out of date.
So we can follow Dave+Dan's patches to create the PMEM NUMA nodes.

Thanks,
Fengguang

>>
>> Willy, have a look here [1], here [2], and here [3] for the
>> work-in-progress ndctl takeover approach (actually 'daxctl' in this
>> case).
>>
>> [1]: https://lkml.org/lkml/2018/10/23/9
>> [2]: https://lkml.org/lkml/2018/10/31/243
>> [3]: https://lists.01.org/pipermail/linux-nvdimm/2018-November/018677.html
>>
>
