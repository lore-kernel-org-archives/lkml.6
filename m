Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091BFC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFCFA23FF6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFCFA23FF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753973AbeGEPon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:44:43 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17734 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753929AbeGEPol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:44:41 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b3e3ce50000>; Thu, 05 Jul 2018 08:44:37 -0700
Received: from HQMAIL105.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 05 Jul 2018 08:44:40 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 05 Jul 2018 08:44:40 -0700
Received: from [10.2.171.197] (10.2.171.197) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 5 Jul
 2018 15:44:40 +0000
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by
 release-acquire and by locks
To:     <paulmck@linux.vnet.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     Will Deacon <will.deacon@arm.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
References: <20180704121103.GB26941@arm.com>
 <Pine.LNX.4.44L0.1807051010380.1697-100000@iolanthe.rowland.org>
 <20180705153140.GO3593@linux.vnet.ibm.com>
From:   Daniel Lustig <dlustig@nvidia.com>
Message-ID: <b41849a8-76cd-2375-dd80-c1bdeb9ea7d2@nvidia.com>
Date:   Thu, 5 Jul 2018 08:44:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180705153140.GO3593@linux.vnet.ibm.com>
X-Originating-IP: [10.2.171.197]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL105.nvidia.com (172.20.187.12)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/2018 8:31 AM, Paul E. McKenney wrote:
> On Thu, Jul 05, 2018 at 10:21:36AM -0400, Alan Stern wrote:
>> At any rate, it looks like instead of strengthening the relation, I
>> should write a patch that removes it entirely.  I also will add new,
>> stronger relations for use with locking, essentially making spin_lock
>> and spin_unlock be RCsc.
> 
> Only in the presence of smp_mb__after_unlock_lock() or
> smp_mb__after_spinlock(), correct?  Or am I confused about RCsc?
> 
> 							Thanx, Paul
> 

In terms of naming...is what you're asking for really RCsc?  To me,
that would imply that even stores in the first critical section would
need to be ordered before loads in the second critical section.
Meaning that even x86 would need an mfence in either lock() or unlock()?

If you're only looking for R->R, R->W, and W->W ordering between
critical sections, is it better to find a new unique name for this?
"RCtso" possibly, or something to that effect?

Dan
