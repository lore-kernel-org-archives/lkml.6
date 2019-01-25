Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8403BC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1DB21919
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbfAYIUt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 03:20:49 -0500
Received: from mga11.intel.com ([192.55.52.93]:9312 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbfAYIUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 03:20:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2019 00:20:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,520,1539673200"; 
   d="scan'208";a="313406334"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jan 2019 00:20:48 -0800
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 25 Jan 2019 00:20:48 -0800
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 FMSMSX114.amr.corp.intel.com (10.18.116.8) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 25 Jan 2019 00:20:48 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.102]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.207]) with mapi id 14.03.0415.000;
 Fri, 25 Jan 2019 16:20:46 +0800
From:   "Du, Fan" <fan.du@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        Jane Chu <jane.chu@oracle.com>
CC:     Tom Lendacky <thomas.lendacky@amd.com>,
        Michal Hocko <mhocko@suse.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Takashi Iwai <tiwai@suse.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        =?iso-8859-1?Q?J=E9r=3Fme_Glisse?= <jglisse@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Ross Zwisler <zwisler@kernel.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Wu, Fengguang" <fengguang.wu@intel.com>,
        "Du, Fan" <fan.du@intel.com>
Subject: RE: [PATCH 5/5] dax: "Hotplug" persistent memory for use like
 normal RAM
Thread-Topic: [PATCH 5/5] dax: "Hotplug" persistent memory for use like
 normal RAM
Thread-Index: AQHUtDueC+prTFW/9U2I5MbyKGdviaW++3cAgAAELwCAAKO5YA==
Date:   Fri, 25 Jan 2019 08:20:45 +0000
Message-ID: <5A90DA2E42F8AE43BC4A093BF067884825733A5B@SHSMSX104.ccr.corp.intel.com>
References: <20190124231441.37A4A305@viggo.jf.intel.com>
 <20190124231448.E102D18E@viggo.jf.intel.com>
 <0852310e-41dc-dc96-2da5-11350f5adce6@oracle.com>
 <CAPcyv4hjJhUQpMy1CVJZur0Ssr7Cr2fkcD50L5gzx6v_KY14vg@mail.gmail.com>
In-Reply-To: <CAPcyv4hjJhUQpMy1CVJZur0Ssr7Cr2fkcD50L5gzx6v_KY14vg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTY4ZGQ4ODktYmRjNi00ODlmLWI4MzEtOWIzNWFhNzhhNjZlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiOWxHTmc3Q28wdjRHSVViU3FXRFM5QWNHRHdHeG1cL3Z3ZWhCTWdEWnYzSStFWk82cEJDUlwvZ1wvaHBNeFgyS2pzOSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan

Thanks for the insights!

Can I say, the UCE is delivered from h/w to OS in a single way in case of machine
check, only PMEM/DAX stuff filter out UC address and managed in its own way by
badblocks, if PMEM/DAX doesn't do so, then common RAS workflow will kick in,
right?

And how about when ARS is involved but no machine check fired for the function
of this patchset?

>-----Original Message-----
>From: Linux-nvdimm [mailto:linux-nvdimm-bounces@lists.01.org] On Behalf
>Of Dan Williams
>Sent: Friday, January 25, 2019 2:28 PM
>To: Jane Chu <jane.chu@oracle.com>
>Cc: Tom Lendacky <thomas.lendacky@amd.com>; Michal Hocko
><mhocko@suse.com>; linux-nvdimm <linux-nvdimm@lists.01.org>; Takashi
>Iwai <tiwai@suse.de>; Dave Hansen <dave.hansen@linux.intel.com>; Huang,
>Ying <ying.huang@intel.com>; Linux Kernel Mailing List
><linux-kernel@vger.kernel.org>; Linux MM <linux-mm@kvack.org>; Jérôme
>Glisse <jglisse@redhat.com>; Borislav Petkov <bp@suse.de>; Yaowei Bai
><baiyaowei@cmss.chinamobile.com>; Ross Zwisler <zwisler@kernel.org>;
>Bjorn Helgaas <bhelgaas@google.com>; Andrew Morton
><akpm@linux-foundation.org>; Wu, Fengguang <fengguang.wu@intel.com>
>Subject: Re: [PATCH 5/5] dax: "Hotplug" persistent memory for use like
>normal RAM
>
>On Thu, Jan 24, 2019 at 10:13 PM Jane Chu <jane.chu@oracle.com> wrote:
>>
>> Hi, Dave,
>>
>> While chatting with my colleague Erwin about the patchset, it occurred
>> that we're not clear about the error handling part. Specifically,
>>
>> 1. If an uncorrectable error is detected during a 'load' in the hot
>> plugged pmem region, how will the error be handled?  will it be
>> handled like PMEM or DRAM?
>
>DRAM.
>
>> 2. If a poison is set, and is persistent, which entity should clear
>> the poison, and badblock(if applicable)? If it's user's responsibility,
>> does ndctl support the clearing in this mode?
>
>With persistent memory advertised via a static logical-to-physical
>storage/dax device mapping, once an error develops it destroys a
>physical *and* logical part of a device address space. That loss of
>logical address space makes error clearing a necessity. However, with
>the DRAM / "System RAM" error handling model, the OS can just offline
>the page and map a different one to repair the logical address space.
>So, no, ndctl will not have explicit enabling to clear volatile
>errors, the OS will just dynamically offline problematic pages.
>_______________________________________________
>Linux-nvdimm mailing list
>Linux-nvdimm@lists.01.org
>https://lists.01.org/mailman/listinfo/linux-nvdimm
