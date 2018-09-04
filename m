Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66411C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC1820652
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=interia.pl header.i=@interia.pl header.b="BB9vvPC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC1820652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poczta.fm
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeIDTeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:34:11 -0400
Received: from smtpo.poczta.interia.pl ([217.74.65.238]:56407 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeIDTeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:34:10 -0400
Date:   Tue, 04 Sep 2018 17:08:34 +0200
From:   Jacek Tomaka <Jacek.Tomaka@poczta.fm>
Subject: Hugepages mixed with stacks in process address space
To:     kirill.shutemov@linux.intel.com, akpm@linux-foundation.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org
X-Mailer: interia.pl/pf09
X-Originating-IP: 103.217.167.188
Message-Id: <ptihjzjmxbrcpgbmabkt@xekh>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1536073715;
        bh=+kGgFWpYeGDq62WoFyPy5wq/aKQWlQX//aDTPZGfOxI=;
        h=Date:From:Subject:To:X-Mailer:X-Originating-IP:Message-Id:
         MIME-Version:Content-Type:Content-Transfer-Encoding;
        b=BB9vvPC+TjfFXCI4VaBH7UrM2O3XS9DMWgT+r/usGx3OOq0NKNDhQcbhtchvyWR+5
         P+Im+Bkvfh1o/fBWgXHLx+FQfB7C8Az5c98ce0gCfNacTjtUjWAr9kVPzuVkLd9YSp
         kSlYoLdzDVGPZcgpkYplOKrhKKAecvZV+OcWUHCs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

I was trying to track down the performance differences of one of my applications 
between running it on kernel used in Centos 7.4 and the latest 4.x version. 
On 4.x kernels its performance depended on the run and the variability 
was more than 30%. 

Bisecting showed that my issue  was introduced by : 
fd8526ad14c182605e42b64646344b95befd9f94 :x86/mm: Implement ASLR for 
hugetlb mappings

But it was not the ASLR aspect of that commit that created the issue but the 
change from bottom-up to top-down unmapped area lookup when allocating 
huge pages. 

After that change, the huge page allocations could become intertwined with 
stacks. Before, the stacks and huge pages were on the other side of the process 
address space. 

The machine i am seeing it on is Knights Landing 7250, with 68 cores x 4 
hyper-threads. 

My application spawns 272 threads and each thread allocates its memory - a 
couple of 2MB huge pages and does some computation, dominated by memory 
accesses. 

My theory is that because KNL has 8-way 2MB TLB,  when the huge pages are 
exactly 8 pages apart they collide.  And this is where the variability comes from, 
if the stacks come in between, they increase chances of them colliding. 

I do realise that the application is (I am ) doing a few things dubiously:  it
allocates memory on each thread and each huge page separately.  But i thought
you might want to know about this behaviour change. 

When i allocate all my memory before i start threads, the problem goes away. 

/proc/PID/maps: 
After change: 
7f5e06a00000-7f5e06c00000 rw-p 00000000 00:0f 31809                      /anon_hugepage (deleted)
7f5e06c00000-7f5e06e00000 rw-p 00000000 00:0f 29767                      /anon_hugepage (deleted)
7f5e06e00000-7f5e07000000 rw-p 00000000 00:0f 30787                      /anon_hugepage (deleted)
7f5e07000000-7f5e07200000 rw-p 00000000 00:0f 30786                      /anon_hugepage (deleted)
7f5e07200000-7f5e07400000 rw-p 00000000 00:0f 28744                      /anon_hugepage (deleted)
7f5e075ff000-7f5e07600000 ---p 00000000 00:00 0 
7f5e07600000-7f5e07e00000 rw-p 00000000 00:00 0 
7f5e07e00000-7f5e08000000 rw-p 00000000 00:0f 30785                      /anon_hugepage (deleted)
7f5e08000000-7f5e08021000 rw-p 00000000 00:00 0 
7f5e08021000-7f5e0c000000 ---p 00000000 00:00 0 
7f5e0c000000-7f5e0c021000 rw-p 00000000 00:00 0 
7f5e0c021000-7f5e10000000 ---p 00000000 00:00 0 
7f5e10000000-7f5e10021000 rw-p 00000000 00:00 0 
7f5e10021000-7f5e14000000 ---p 00000000 00:00 0 
7f5e14200000-7f5e14400000 rw-p 00000000 00:0f 29765                      /anon_hugepage (deleted)
7f5e14400000-7f5e14600000 rw-p 00000000 00:0f 28743                      /anon_hugepage (deleted)
7f5e14600000-7f5e14800000 rw-p 00000000 00:0f 29764                      /anon_hugepage (deleted)
(...)

Before change: 
2aaaaac00000-2aaaaae00000 rw-p 00000000 00:0f 25582                      /anon_hugepage (deleted)
2aaaaae00000-2aaaab000000 rw-p 00000000 00:0f 25583                      /anon_hugepage (deleted)
2aaaab000000-2aaaab200000 rw-p 00000000 00:0f 25584                      /anon_hugepage (deleted)
2aaaab200000-2aaaab400000 rw-p 00000000 00:0f 25585                      /anon_hugepage (deleted)
2aaaab400000-2aaaab600000 rw-p 00000000 00:0f 25601                      /anon_hugepage (deleted)
2aaaab600000-2aaaab800000 rw-p 00000000 00:0f 25599                      /anon_hugepage (deleted)
2aaaab800000-2aaaaba00000 rw-p 00000000 00:0f 25602                      /anon_hugepage (deleted)
2aaaaba00000-2aaaabc00000 rw-p 00000000 00:0f 26652                      /anon_hugepage (deleted)
(...)
7fc4f0021000-7fc4f4000000 ---p 00000000 00:00 0 
7fc4f4000000-7fc4f4021000 rw-p 00000000 00:00 0 
7fc4f4021000-7fc4f8000000 ---p 00000000 00:00 0 
7fc4f8000000-7fc4f8021000 rw-p 00000000 00:00 0 
7fc4f8021000-7fc4fc000000 ---p 00000000 00:00 0 
7fc4fc000000-7fc4fc021000 rw-p 00000000 00:00 0 
7fc4fc021000-7fc500000000 ---p 00000000 00:00 0 
7fc500000000-7fc500021000 rw-p 00000000 00:00 0 
7fc500021000-7fc504000000 ---p 00000000 00:00 0 
7fc504000000-7fc504021000 rw-p 00000000 00:00 0 
7fc504021000-7fc508000000 ---p 00000000 00:00 0 
7fc508000000-7fc508021000 rw-p 00000000 00:00 0 
7fc508021000-7fc50c000000 ---p 00000000 00:00 0 
(...)

I was wondering if this intertwined stacks and hugepages is an expected 
feature of ASLR? If not, maybe mmap's MAP_STACK flag could finally start 
to be used by the kernel to keep all the stacks together in process address 
space?

Or should users just not allocate huge pages on separate threads?

MAP_STACK could also be used to mark a VMA as a mapping for stack, 
(if there are flags left) to re-implement: 
65376df582174ffcec9e6471bf5b0dd79ba05e4a proc: revert /proc/<pid>/maps [stack:TID] annotation
correctly, as having these pieces of information in place would greatly 
simplify my investigation. 

Regards.
Jacek Tomaka
