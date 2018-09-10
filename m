Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677AEC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13FA720866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13FA720866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbeIJWPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:15:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:54760 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726709AbeIJWPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:15:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 702E8AF44;
        Mon, 10 Sep 2018 17:20:22 +0000 (UTC)
Date:   Mon, 10 Sep 2018 10:20:11 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Waiman Long <longman@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
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
Subject: Re: Plumbers 2018 - Performance and Scalability Microconference
Message-ID: <20180910172011.GB3902@linux-r8p5>
Mail-Followup-To: Waiman Long <longman@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <55b44432-ade5-f090-bfe7-ea20f3e87285@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2018, Waiman Long wrote:

>On 09/08/2018 12:13 AM, John Hubbard wrote:
>>
>> Hi Daniel and all,
>>
>> I'm interested in the first 3 of those 4 topics, so if it doesn't conflict with HMM topics or
>> fix-gup-with-dma topics, I'd like to attend. GPUs generally need to access large chunks of
>> memory, and that includes migrating (dma-copying) pages around.
>>
>> So for example a multi-threaded migration of huge pages between normal RAM and GPU memory is an
>> intriguing direction (and I realize that it's a well-known topic, already). Doing that properly
>> (how many threads to use?) seems like it requires scheduler interaction.
>>
>> It's also interesting that there are two main huge page systems (THP and Hugetlbfs), and I sometimes
>> wonder the obvious thing to wonder: are these sufficiently different to warrant remaining separate,
>> long-term?  Yes, I realize they're quite different in some ways, but still, one wonders. :)
>
>One major difference between hugetlbfs and THP is that the former has to
>be explicitly managed by the applications that use it whereas the latter
>is done automatically without the applications being aware that THP is
>being used at all. Performance wise, THP may or may not increase
>application performance depending on the exact memory access pattern,
>though the chance is usually higher that an application will benefit
>than suffer from it.
>
>If an application know what it is doing, using hughtblfs can boost
>performance more than it can ever achieved by THP. Many large enterprise
>applications, like Oracle DB, are using hugetlbfs and explicitly disable
>THP. So unless THP can improve its performance to a level that is
>comparable to hugetlbfs, I won't see the later going away.

Yep, there are a few non-trivial workloads out there that flat out discourage
thp, ie: redis to avoid latency issues.

Thanks,
Davidlohr
