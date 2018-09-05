Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94430C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4825D20861
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="YIL4BevO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4825D20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeIETlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:41:17 -0400
Received: from a9-46.smtp-out.amazonses.com ([54.240.9.46]:45566 "EHLO
        a9-46.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726046AbeIETlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1536160239;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=lsfLbHwBykz5/SXR183FmYEmB+8XC5HYqw0k1LBs37Q=;
        b=YIL4BevOO1zr6j4gYKlM3X6UYj97UxNgwqQQI81Mwtts1A2x25fBqaS70B8Yw//k
        QpUK3+i7FG1NfaJXIC/9pcLNaAGNcrO+xrrnjwSSyPgdzGUXy1N/TqBdL7G/TEA5uNQ
        iT64nzQKLRsE7RxMnp+IItQitrNlY4b0PXkWYuFM=
Date:   Wed, 5 Sep 2018 15:10:39 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
cc:     linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Aaron Lu <aaron.lu@intel.com>, alex.kogan@oracle.com,
        akpm@linux-foundation.org, boqun.feng@gmail.com, brouer@redhat.com,
        dave@stgolabs.net, dave.dice@oracle.com,
        Dhaval Giani <dhaval.giani@oracle.com>, ktkhai@virtuozzo.com,
        ldufour@linux.vnet.ibm.com, Pavel.Tatashin@microsoft.com,
        paulmck@linux.vnet.ibm.com, shady.issa@oracle.com,
        tariqt@mellanox.com, tglx@linutronix.de, tim.c.chen@intel.com,
        vbabka@suse.cz, longman@redhat.com, yang.shi@linux.alibaba.com,
        shy828301@gmail.com, Huang Ying <ying.huang@intel.com>,
        brouer@redhat.com, subhra.mazumdar@oracle.com,
        Steven Sistare <steven.sistare@oracle.com>, jwadams@google.com,
        ashwinch@google.com, sqazi@google.com,
        Shakeel Butt <shakeelb@google.com>, walken@google.com,
        rientjes@google.com, junaids@google.com,
        Neha Agarwal <nehaagarwal@google.com>
Subject: Re: Plumbers 2018 - Performance and Scalability Microconference
In-Reply-To: <1dc80ff6-f53f-ae89-be29-3408bf7d69cc@oracle.com>
Message-ID: <01000165aa490dc9-64abf872-afd1-4a81-a46d-a50d0131de93-000000@email.amazonses.com>
References: <1dc80ff6-f53f-ae89-be29-3408bf7d69cc@oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.09.05-54.240.9.46
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Sep 2018, Daniel Jordan wrote:

>  - Promoting huge page usage:  With memory sizes becoming ever larger, huge
> pages are becoming more and more important to reduce TLB misses and the
> overhead of memory management itself--that is, to make the system scalable
> with the memory size.  But there are still some remaining gaps that prevent
> huge pages from being deployed in some situations, such as huge page
> allocation latency and memory fragmentation.

You forgot the major issue that huge pages in the page cache are not
supported and thus we have performance issues with fast NVME drives that
are now able to do 3Gbytes per sec that are only possible to reach with
directio and huge pages.

IMHO the huge page issue is just the reflection of a certain hardware
manufacturer inflicting pain for over a decade on its poor users by not
supporting larger base page sizes than 4k. No such workarounds needed on
platforms that support large sizes. Things just zoom along without
contortions necessary to deal with huge pages etc.

Can we come up with a 2M base page VM or something? We have possible
memory sizes of a couple TB now. That should give us a million or so 2M
pages to work with.

>  - Reducing the number of users of mmap_sem:  This semaphore is frequently
> used throughout the kernel.  In order to facilitate scaling this longstanding
> bottleneck, these uses should be documented and unnecessary users should be
> fixed.


Large page sizes also reduce contention there.

> If you haven't already done so, please let us know if you are interested in
> attending, or have suggestions for other attendees.

Certainly interested in attending but this overlaps supercomputing 2018 in
Dallas Texas...
