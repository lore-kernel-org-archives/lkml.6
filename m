Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCF9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DFED218DE
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbfBRCeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 21:34:21 -0500
Received: from mga01.intel.com ([192.55.52.88]:39730 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727266AbfBRCeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 21:34:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2019 18:34:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,382,1544515200"; 
   d="scan'208";a="300490965"
Received: from unknown (HELO [10.239.13.114]) ([10.239.13.114])
  by orsmga005.jf.intel.com with ESMTP; 17 Feb 2019 18:34:17 -0800
Message-ID: <5C6A1AD4.9020200@intel.com>
Date:   Mon, 18 Feb 2019 10:39:16 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     David Hildenbrand <david@redhat.com>,
        'Nitesh Narayan Lal' <nitesh@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "lcapitulino@redhat.com" <lcapitulino@redhat.com>,
        "pagupta@redhat.com" <pagupta@redhat.com>,
        "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>,
        "riel@surriel.com" <riel@surriel.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "dodgen@google.com" <dodgen@google.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "dhildenb@redhat.com" <dhildenb@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
References: <20190204201854.2328-1-nitesh@redhat.com> <286AC319A985734F985F78AFA26841F73DF6B56A@shsmsx102.ccr.corp.intel.com> <f9516222-793a-a169-c18a-728ca0256cd3@redhat.com> <286AC319A985734F985F78AFA26841F73DF6F0E3@shsmsx102.ccr.corp.intel.com> <bdd4298d-b84b-1ffb-0d9c-3ff5798da325@redhat.com> <286AC319A985734F985F78AFA26841F73DF71F38@shsmsx102.ccr.corp.intel.com> <751444f1-2ff8-e6f8-3501-b0408e3f6035@redhat.com> <5C6A1A28.40808@intel.com>
In-Reply-To: <5C6A1A28.40808@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/18/2019 10:36 AM, Wei Wang wrote:
> On 02/15/2019 05:41 PM, David Hildenbrand wrote:
>> On 15.02.19 10:05, Wang, Wei W wrote:
>>> On Thursday, February 14, 2019 5:43 PM, David Hildenbrand wrote:
>>>> Yes indeed, that is the important bit. They must not be put pack to 
>>>> the
>>>> buddy before they have been processed by the hypervisor. But as the 
>>>> pages
>>>> are not in the buddy, no one allocating a page will stumble over 
>>>> such a page
>>>> and try to allocate it. Threads trying to allocate memory will 
>>>> simply pick
>>>> another buddy page instead of "busy waiting" for that page to be 
>>>> finished
>>>> reporting.
>>> What if a guest thread try to allocate some pages but the buddy 
>>> cannot satisfy
>>> because all the pages are isolated? Would it be the same case that 
>>> the guest thread
>>> gets blocked by waiting all the isolated pages to get madvised by 
>>> the host and
>>> returned to the guest buddy, or even worse, some guest threads get 
>>> killed due to oom?
>> Your question targets low memory situations in the guest. I think Nitesh
>> already answered parts of that question somewhere and I'll let him
>> answer it in detail, only a short comment from my side :)
>>
>> I can imagine techniques where the OOM killer can be avoided, but the
>> OOM handler will eventually kick in and handle it.
>>
>> In general your question is valid and we will have to think about a way
>> to avoid that from happening. However, in contrast to your approach
>> blocking on potentially every page that is being hinted, in Nitesh's
>> approach this would only happen when the guest is really low on memory.
>> And the question is in general, if a guest wants to hint if low on
>> memory ("safety buffer").
>
> I think we should forget that the guest is low on memory because
%s/should/shouldn't
> this approach takes all the pages off the list, not because the guest 
> really
> uses up the free memory.
>
> Guest allocating one page could also potentially be blocked until all 
> the pages
> (as opposed to one page) being madvised and returned to the guest buddy.
>
> Best,
> Wei

