Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99CEC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8E92086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8E92086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbeIKSv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 14:51:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50666 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727384AbeIKSv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 14:51:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 159C24075166;
        Tue, 11 Sep 2018 13:52:31 +0000 (UTC)
Received: from llong.remote.csb (ovpn-123-172.rdu2.redhat.com [10.10.123.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 097F82156889;
        Tue, 11 Sep 2018 13:52:25 +0000 (UTC)
Subject: Re: Plumbers 2018 - Performance and Scalability Microconference
To:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Aaron Lu <aaron.lu@intel.com>, alex.kogan@oracle.com,
        akpm@linux-foundation.org, boqun.feng@gmail.com, brouer@redhat.com,
        dave.dice@oracle.com, Dhaval Giani <dhaval.giani@oracle.com>,
        ktkhai@virtuozzo.com, ldufour@linux.vnet.ibm.com,
        Pavel.Tatashin@microsoft.com, paulmck@linux.vnet.ibm.com,
        shady.issa@oracle.com, tariqt@mellanox.com, tglx@linutronix.de,
        tim.c.chen@intel.com, vbabka@suse.cz, yang.shi@linux.alibaba.com,
        shy828301@gmail.com, Huang Ying <ying.huang@intel.com>,
        subhra.mazumdar@oracle.com,
        Steven Sistare <steven.sistare@oracle.com>, jwadams@google.com,
        ashwinch@google.com, sqazi@google.com,
        Shakeel Butt <shakeelb@google.com>, walken@google.com,
        rientjes@google.com, junaids@google.com,
        Neha Agarwal <nehaagarwal@google.com>
References: <1dc80ff6-f53f-ae89-be29-3408bf7d69cc@oracle.com>
 <35c2c79f-efbe-f6b2-43a6-52da82145638@nvidia.com>
 <55b44432-ade5-f090-bfe7-ea20f3e87285@redhat.com>
 <20180910172011.GB3902@linux-r8p5>
 <78fa0507-4789-415b-5b9c-18e3fcefebab@nvidia.com>
 <3db2b742-9e09-a934-e4ef-c87465e6715a@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <82f06ae8-5a3f-283f-5ad3-e6ab2f42dbc6@redhat.com>
Date:   Tue, 11 Sep 2018 09:52:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <3db2b742-9e09-a934-e4ef-c87465e6715a@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 11 Sep 2018 13:52:31 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 11 Sep 2018 13:52:31 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2018 08:29 PM, Daniel Jordan wrote:
> On 9/10/18 1:34 PM, John Hubbard wrote:
>> On 9/10/18 10:20 AM, Davidlohr Bueso wrote:
>>> On Mon, 10 Sep 2018, Waiman Long wrote:
>>>> On 09/08/2018 12:13 AM, John Hubbard wrote:
>> [...]
>>>>> It's also interesting that there are two main huge page systems
>>>>> (THP and Hugetlbfs), and I sometimes
>>>>> wonder the obvious thing to wonder: are these sufficiently
>>>>> different to warrant remaining separate,
>>>>> long-term?  Yes, I realize they're quite different in some ways,
>>>>> but still, one wonders. :)
>>>>
>>>> One major difference between hugetlbfs and THP is that the former
>>>> has to
>>>> be explicitly managed by the applications that use it whereas the
>>>> latter
>>>> is done automatically without the applications being aware that THP is
>>>> being used at all. Performance wise, THP may or may not increase
>>>> application performance depending on the exact memory access pattern,
>>>> though the chance is usually higher that an application will benefit
>>>> than suffer from it.
>>>>
>>>> If an application know what it is doing, using hughtblfs can boost
>>>> performance more than it can ever achieved by THP. Many large
>>>> enterprise
>>>> applications, like Oracle DB, are using hugetlbfs and explicitly
>>>> disable
>>>> THP. So unless THP can improve its performance to a level that is
>>>> comparable to hugetlbfs, I won't see the later going away.
>>>
>>> Yep, there are a few non-trivial workloads out there that flat out
>>> discourage
>>> thp, ie: redis to avoid latency issues.
>>>
>>
>> Yes, the need for guaranteed, available-now huge pages in some cases is
>> understood. That's not the quite same as saying that there have to be
>> two different
>> subsystems, though. Nor does it even necessarily imply that the pool
>> has to be
>> reserved in the same way as hugetlbfs does it...exactly.
>>
>> So I'm wondering if THP behavior can be made to mimic hugetlbfs
>> enough (perhaps
>> another option, in addition to "always, never, madvise") that we
>> could just use
>> THP in all cases. But the "transparent" could become a sliding scale
>> that could
>> go all the way down to "opaque" (hugetlbfs behavior).
>
> Leaving the interface aside, the idea that we could deduplicate
> redundant parts of the hugetlbfs and THP implementations, without
> user-visible change, seems promising.

That I think it is good idea if it can be done.

Thanks,
Longman

