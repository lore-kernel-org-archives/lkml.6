Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33B5C282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 01:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CADA22148E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 01:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfA2Be5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 20:34:57 -0500
Received: from ozlabs.org ([203.11.71.1]:49331 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbfA2Bey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 20:34:54 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43pTZM2r3kz9sDK;
        Tue, 29 Jan 2019 12:34:51 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Dave Hansen <dave.hansen@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, zwisler@kernel.org,
        vishal.l.verma@intel.com, thomas.lendacky@amd.com,
        Andrew Morton <akpm@linux-foundation.org>, mhocko@suse.com,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        Huang Ying <ying.huang@intel.com>,
        Wu Fengguang <fengguang.wu@intel.com>,
        Jerome Glisse <jglisse@redhat.com>
Subject: Re: [PATCH 2/5] mm/resource: move HMM pr_debug() deeper into resource code
In-Reply-To: <b191ad4a-da4e-9bc7-4468-d6e4a8b3d66f@intel.com>
References: <20190124231441.37A4A305@viggo.jf.intel.com> <20190124231444.38182DD8@viggo.jf.intel.com> <CAErSpo4oSjQAxeRy8Tz_Jvo+cRovBvVx9WBeNb_P6PxT-A_XhA@mail.gmail.com> <b191ad4a-da4e-9bc7-4468-d6e4a8b3d66f@intel.com>
Date:   Tue, 29 Jan 2019 12:34:50 +1100
Message-ID: <87imy8s0ud.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <dave.hansen@intel.com> writes:
> On 1/25/19 1:18 PM, Bjorn Helgaas wrote:
>> On Thu, Jan 24, 2019 at 5:21 PM Dave Hansen <dave.hansen@linux.intel.com> wrote:
>>> diff -puN kernel/resource.c~move-request_region-check kernel/resource.c
>>> --- a/kernel/resource.c~move-request_region-check       2019-01-24 15:13:14.453199539 -0800
>>> +++ b/kernel/resource.c 2019-01-24 15:13:14.458199539 -0800
>>> @@ -1123,6 +1123,16 @@ struct resource * __request_region(struc
>>>                 conflict = __request_resource(parent, res);
>>>                 if (!conflict)
>>>                         break;
>>> +               /*
>>> +                * mm/hmm.c reserves physical addresses which then
>>> +                * become unavailable to other users.  Conflicts are
>>> +                * not expected.  Be verbose if one is encountered.
>>> +                */
>>> +               if (conflict->desc == IORES_DESC_DEVICE_PRIVATE_MEMORY) {
>>> +                       pr_debug("Resource conflict with unaddressable "
>>> +                                "device memory at %#010llx !\n",
>>> +                                (unsigned long long)start);
>> 
>> I don't object to the change, but are you really OK with this being a
>> pr_debug() message that is only emitted when enabled via either the
>> dynamic debug mechanism or DEBUG being defined?  From the comments, it
>> seems more like a KERN_INFO sort of message.
>
> I left it consistent with the original message that was in the code.
> I'm happy to change it, though, if the consumers of it (Jerome,
> basically) want something different.

At least using pr_debug() doesn't match the comment, ie. the comment
says "Be verbose" but pr_debug() is silent by default.

cheers
