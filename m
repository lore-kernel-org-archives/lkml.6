Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A754FC37124
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706842089F
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfAVAYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 19:24:05 -0500
Received: from mga12.intel.com ([192.55.52.136]:30337 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfAVAYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 19:24:05 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2019 16:24:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,504,1539673200"; 
   d="scan'208";a="120235153"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.37])
  by orsmga003.jf.intel.com with ESMTP; 21 Jan 2019 16:24:03 -0800
Date:   Tue, 22 Jan 2019 08:23:35 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libnvdimm: Clarify nd_pfn_init() flow
Message-ID: <20190122002335.GA5855@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <154785884329.2202034.3295476681016958230.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190121075102.GA3758@richard>
 <CAPcyv4iGZdEw-agURohZdC7hkjrDp74M_gVdSbCB5DP-bk5YYw@mail.gmail.com>
 <20190121205713.vai2oor3saopcja7@master>
 <CAPcyv4g7hR34mNSQOLARTrX--UFpgg68thfg75hZOzq5AaBw5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4g7hR34mNSQOLARTrX--UFpgg68thfg75hZOzq5AaBw5A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 02:34:06PM -0800, Dan Williams wrote:
>On Mon, Jan 21, 2019 at 12:57 PM Wei Yang <richard.weiyang@gmail.com> wrote:
>>
>> On Mon, Jan 21, 2019 at 10:04:40AM -0800, Dan Williams wrote:
>> >On Sun, Jan 20, 2019 at 11:51 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
>> >> On Fri, Jan 18, 2019 at 04:47:23PM -0800, Dan Williams wrote:
>> >[..]
>> >> Also, I have one confusion about your saying: two probes.
>> >>
>> >> If the two probes are:
>> >>
>> >>     * for dax%d.%d: 1. nd_dax_probe 2. dax_pmem_probe
>> >>     * for pfn%d.%d: 1. nd_pfn_probe 2. nd_pmem_probe
>> >>
>> >> Then, if the first probe fails, the device itself would be destroyed. How the
>> >> second probe do its job?
>> >>
>> >> >       rc = nd_pfn_validate(nd_pfn, sig);
>> >> >       if (rc != -ENODEV)
>> >> >               return rc;
>> >
>> >Here is an example path for a device-dax instance:
>> >
>> >    /sys/devices/platform/e820_pmem/ndbus0/region0/dax0.1/dax0.0
>> >
>> >In this case the order of events is:
>> >
>> >1/ region0 discovers it contains a pmem namespace and registers namespace0.0
>> >2/ The pmem namespace driver calls nd_dax_probe() to check for the
>> >presence of a device-dax configuration
>> >3/ If present, nd_pfn_validate() returns 0 and nd_dax_probe()
>> >registers the dax0.1 device (this is a libnvdimm 'personality device).
>> >4/ When nd_pmem_probe() sees nd_dax_probe() return 0 it in turn fails
>> >the probe of namespace0.0 with -ENXIO. All devm allocations during the
>> >probe of namespace0.0 are released.
>>
>> I may have another opinion here.
>>
>> The probe return error means the device will not attach to this driver.
>> But the device itself it not released.
>>
>> We allocate devm on one device and those memory will be released when
>> the device is destroyed. If I am correct.
>>
>> This means at this point, pfn_sb's memory still exists in the system.
>> Even finally we will release it, when namespace0.0 is destroyed.
>
>No, that's not the way devm works. Memory allocated by devm is
>released at ->probe() failure, or after ->remove()
>
>See the devres_release_all() call in drivers/base/dd.c::really_probe()

Ah, you are right.

-- 
Wei Yang
Help you, Help me
