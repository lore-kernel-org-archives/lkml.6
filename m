Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7F7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B4B214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eFAGrOs3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DPw0CZwC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B4B214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeJJSMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 14:12:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46500 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeJJSMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 14:12:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0376160C80; Wed, 10 Oct 2018 10:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539168678;
        bh=eBFiSE6DJN11KP37itxEDB1KVrkl8L0Q1O3ckUJ2Xfc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eFAGrOs3CCUjo+06lEV9Bf7pcQt2v3yhN7IQFoFaXhdSIXjUhgRo8A4rx8Azhz0ln
         Rty0FqU7ilO7PpkPMsJR/8peyhdFa4/7MzJVL38DJawnOc5og2MGCUgp6T2+Oybz94
         bKjiwI4No8pdQsG2iDjluqX5XMPU2whgm6hjLOzw=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id BD456601D4;
        Wed, 10 Oct 2018 10:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539168676;
        bh=eBFiSE6DJN11KP37itxEDB1KVrkl8L0Q1O3ckUJ2Xfc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DPw0CZwCrZFsiiP/ZoBKzYAU97CEx4EDF+93+DqkL5Apbc3oOa2ast6uHqRuGHyhp
         +H8UKwdP9Fyu21UuvGgMj03B+vc6I4YJLtI0ucAC6yNiWCQSXTAmSKFJ4jT5AJeDTL
         qOCnXsU+e0zpv+W/SaM3dDQcIBiR3mLYUqF7ZwAU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 10 Oct 2018 16:21:16 +0530
From:   Arun KS <arunks@codeaurora.org>
To:     Oscar Salvador <osalvador@techadventures.net>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        mhocko@suse.com, vbabka@suse.cz, iamjoonsoo.kim@lge.com,
        gregkh@linuxfoundation.org, osalvador@suse.de, malat@debian.org,
        kirill.shutemov@linux.intel.com, jrdr.linux@gmail.com,
        yasu.isimatu@gmail.com, mgorman@techsingularity.net,
        aaron.lu@intel.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, vatsa@codeaurora.org,
        vinmenon@codeaurora.org, getarunks@gmail.com
Subject: Re: [PATCH v5 1/2] memory_hotplug: Free pages as higher order
In-Reply-To: <20181010080724.GA20338@techadventures.net>
References: <1538727006-5727-1-git-send-email-arunks@codeaurora.org>
 <20181010080724.GA20338@techadventures.net>
Message-ID: <f18b87a0762c4379b78e9b5e09ff4840@codeaurora.org>
X-Sender: arunks@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-10 13:37, Oscar Salvador wrote:
> On Fri, Oct 05, 2018 at 01:40:05PM +0530, Arun KS wrote:
>> When free pages are done with higher order, time spend on
>> coalescing pages by buddy allocator can be reduced. With
>> section size of 256MB, hot add latency of a single section
>> shows improvement from 50-60 ms to less than 1 ms, hence
>> improving the hot add latency by 60%. Modify external
>> providers of online callback to align with the change.
> 
> Hi Arun, out of curiosity:
> 
> could you please explain how exactly did you mesure the speed
> improvement?

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index e379e85..2416136 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -690,9 +690,13 @@ static int online_pages_range(unsigned long 
start_pfn, unsigned long nr_pages,
                         void *arg)
  {
         unsigned long onlined_pages = *(unsigned long *)arg;
+       u64 t1, t2;

+       t1 = local_clock();
         if (PageReserved(pfn_to_page(start_pfn)))
                 onlined_pages = online_pages_blocks(start_pfn, 
nr_pages);
+       t2 = local_clock();
+       trace_printk("time spend = %llu us\n", (t2-t1)/(1000));

         online_mem_sections(start_pfn, start_pfn + nr_pages);


Regards,
Arun

> 
> Thanks
