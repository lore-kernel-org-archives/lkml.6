Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8A3C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 01:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A75D205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 01:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A75D205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbeIFGbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 02:31:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:13135 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbeIFGbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 02:31:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2018 18:58:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,334,1531810800"; 
   d="scan'208";a="87578708"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.13])
  by fmsmga001.fm.intel.com with ESMTP; 05 Sep 2018 18:58:18 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Christopher Lameter <cl@linux.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        <linux-kernel@vger.kernel.org>,
        "linux-mm\@kvack.org" <linux-mm@kvack.org>,
        Aaron Lu <aaron.lu@intel.com>, <alex.kogan@oracle.com>,
        <akpm@linux-foundation.org>, <boqun.feng@gmail.com>,
        <brouer@redhat.com>, <dave@stgolabs.net>, <dave.dice@oracle.com>,
        Dhaval Giani <dhaval.giani@oracle.com>, <ktkhai@virtuozzo.com>,
        <ldufour@linux.vnet.ibm.com>, <Pavel.Tatashin@microsoft.com>,
        <paulmck@linux.vnet.ibm.com>, <shady.issa@oracle.com>,
        <tariqt@mellanox.com>, <tglx@linutronix.de>,
        <tim.c.chen@intel.com>, <vbabka@suse.cz>, <longman@redhat.com>,
        <yang.shi@linux.alibaba.com>, <shy828301@gmail.com>,
        <subhra.mazumdar@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        <jwadams@google.com>, <ashwinch@google.com>, <sqazi@google.com>,
        Shakeel Butt <shakeelb@google.com>, <walken@google.com>,
        <rientjes@google.com>, <junaids@google.com>,
        Neha Agarwal <nehaagarwal@google.com>
Subject: Re: Plumbers 2018 - Performance and Scalability Microconference
References: <1dc80ff6-f53f-ae89-be29-3408bf7d69cc@oracle.com>
        <01000165aa490dc9-64abf872-afd1-4a81-a46d-a50d0131de93-000000@email.amazonses.com>
Date:   Thu, 06 Sep 2018 09:58:17 +0800
In-Reply-To: <01000165aa490dc9-64abf872-afd1-4a81-a46d-a50d0131de93-000000@email.amazonses.com>
        (Christopher Lameter's message of "Wed, 5 Sep 2018 15:10:39 +0000")
Message-ID: <877ejzqtdy.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christopher,

Christopher Lameter <cl@linux.com> writes:

> On Tue, 4 Sep 2018, Daniel Jordan wrote:
>
>>  - Promoting huge page usage:  With memory sizes becoming ever larger, huge
>> pages are becoming more and more important to reduce TLB misses and the
>> overhead of memory management itself--that is, to make the system scalable
>> with the memory size.  But there are still some remaining gaps that prevent
>> huge pages from being deployed in some situations, such as huge page
>> allocation latency and memory fragmentation.
>
> You forgot the major issue that huge pages in the page cache are not
> supported and thus we have performance issues with fast NVME drives that
> are now able to do 3Gbytes per sec that are only possible to reach with
> directio and huge pages.

Yes.  That is an important gap for huge page.  Although we have huge
page cache support for tmpfs, we lacks that for normal file systems.

> IMHO the huge page issue is just the reflection of a certain hardware
> manufacturer inflicting pain for over a decade on its poor users by not
> supporting larger base page sizes than 4k. No such workarounds needed on
> platforms that support large sizes. Things just zoom along without
> contortions necessary to deal with huge pages etc.
>
> Can we come up with a 2M base page VM or something? We have possible
> memory sizes of a couple TB now. That should give us a million or so 2M
> pages to work with.

That sounds a good idea.  Don't know whether someone has tried this.

>>  - Reducing the number of users of mmap_sem:  This semaphore is frequently
>> used throughout the kernel.  In order to facilitate scaling this longstanding
>> bottleneck, these uses should be documented and unnecessary users should be
>> fixed.
>
>
> Large page sizes also reduce contention there.

Yes.

>> If you haven't already done so, please let us know if you are interested in
>> attending, or have suggestions for other attendees.
>
> Certainly interested in attending but this overlaps supercomputing 2018 in
> Dallas Texas...

Sorry to know this.  It appears that there are too many conferences in
November...

Best Regards,
Huang, Ying
