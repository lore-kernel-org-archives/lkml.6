Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95FCC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A653D20862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A653D20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbeKHHgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 02:36:45 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45572 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbeKHHgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 02:36:35 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B76EFB09;
        Wed,  7 Nov 2018 22:04:14 +0000 (UTC)
Date:   Wed, 7 Nov 2018 14:04:13 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     <linux-mm@kvack.org>, Oscar Salvador <OSalvador@suse.com>,
        Baoquan He <bhe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH 4/5] mm, memory_hotplug: print reason for the
 offlining failure
Message-Id: <20181107140413.2c0061e440123be76bf419bf@linux-foundation.org>
In-Reply-To: <20181107101830.17405-5-mhocko@kernel.org>
References: <20181107101830.17405-1-mhocko@kernel.org>
        <20181107101830.17405-5-mhocko@kernel.org>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  7 Nov 2018 11:18:29 +0100 Michal Hocko <mhocko@kernel.org> wrote:

> From: Michal Hocko <mhocko@suse.com>
> 
> The memory offlining failure reporting is inconsistent and insufficient.
> Some error paths simply do not report the failure to the log at all.
> When we do report there are no details about the reason of the failure
> and there are several of them which makes memory offlining failures
> hard to debug.
> 
> Make sure that the
> 	memory offlining [mem %#010llx-%#010llx] failed
> message is printed for all failures and also provide a short textual
> reason for the failure e.g.
> 
> [ 1984.506184] rac1 kernel: memory offlining [mem 0x82600000000-0x8267fffffff] failed due to signal backoff
> 
> this tells us that the offlining has failed because of a signal pending
> aka user intervention.
> 
> ...

Some of these messages will come out looking a bit odd.

> @@ -1573,7 +1576,8 @@ static int __ref __offline_pages(unsigned long start_pfn,
>  				       MIGRATE_MOVABLE, true);
>  	if (ret) {
>  		mem_hotplug_done();
> -		return ret;
> +		reason = "failed to isolate range";

"memory offlining [mem ...] failed due to failed to isolate range"

> +		goto failed_removal
>  	}
>  
>  	arg.start_pfn = start_pfn;
> @@ -1582,15 +1586,19 @@ static int __ref __offline_pages(unsigned long start_pfn,
>  
>  	ret = memory_notify(MEM_GOING_OFFLINE, &arg);
>  	ret = notifier_to_errno(ret);
> -	if (ret)
> -		goto failed_removal;
> +	if (ret) {
> +		reason = "notifiers failure";

"memory offlining [mem ...] failed due to notifiers failure"

> @@ -1607,8 +1615,10 @@ static int __ref __offline_pages(unsigned long start_pfn,
>  	 * actually in order to make hugetlbfs's object counting consistent.
>  	 */
>  	ret = dissolve_free_huge_pages(start_pfn, end_pfn);
> -	if (ret)
> -		goto failed_removal;
> +	if (ret) {
> +		reason = "fails to disolve hugetlb pages";

"memory offlining [mem ...] failed due to fails to disolve hugetlb pages"


Fix:

--- a/mm/memory_hotplug.c~mm-memory_hotplug-print-reason-for-the-offlining-failure-fix
+++ a/mm/memory_hotplug.c
@@ -1576,7 +1576,7 @@ static int __ref __offline_pages(unsigne
 				       MIGRATE_MOVABLE, true);
 	if (ret) {
 		mem_hotplug_done();
-		reason = "failed to isolate range";
+		reason = "failure to isolate range";
 		goto failed_removal
 	}
 
@@ -1587,7 +1587,7 @@ static int __ref __offline_pages(unsigne
 	ret = memory_notify(MEM_GOING_OFFLINE, &arg);
 	ret = notifier_to_errno(ret);
 	if (ret) {
-		reason = "notifiers failure";
+		reason = "notifier failure";
 		goto failed_removal_isolated;
 	}
 
@@ -1616,7 +1616,7 @@ repeat:
 	 */
 	ret = dissolve_free_huge_pages(start_pfn, end_pfn);
 	if (ret) {
-		reason = "fails to disolve hugetlb pages";
+		reason = "failure to dissolve huge pages";
 		goto failed_removal_isolated;
 	}
 	/* check again */
_

