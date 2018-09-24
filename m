Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B492ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1422098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF1422098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731746AbeIXWnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 18:43:35 -0400
Received: from foss.arm.com ([217.140.101.70]:38542 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730699AbeIXWnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 18:43:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26D1180D;
        Mon, 24 Sep 2018 09:40:35 -0700 (PDT)
Received: from [10.163.1.125] (unknown [10.163.1.125])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E9393F5BD;
        Mon, 24 Sep 2018 09:40:33 -0700 (PDT)
Subject: Re: [PATCH] mm/migrate: Split only transparent huge pages when
 allocation fails
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
References: <1537798495-4996-1-git-send-email-anshuman.khandual@arm.com>
 <20180924143027.GE18685@dhcp22.suse.cz>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <421f9b78-cb0f-01ce-dca0-93ff6eae0816@arm.com>
Date:   Mon, 24 Sep 2018 22:10:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180924143027.GE18685@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/24/2018 08:00 PM, Michal Hocko wrote:
> On Mon 24-09-18 19:44:55, Anshuman Khandual wrote:
>> When unmap_and_move[_huge_page] function fails due to lack of memory, the
>> splitting should happen only for transparent huge pages not for HugeTLB
>> pages. PageTransHuge() returns true for both THP and HugeTLB pages. Hence
>> the conditonal check should test PagesHuge() flag to make sure that given
>> pages is not a HugeTLB one.
> 
> Well spotted! Have you actually seen this happening or this is review
> driven? I am wondering what would be the real effect of this mismatch?
> I have tried to follow to code path but I suspect
> split_huge_page_to_list would fail for hugetlbfs pages. If there is a
> more serious effect then we should mark the patch for stable as well.

split_huge_page_to_list() fails on HugeTLB pages. I was experimenting around
moving 32MB contig HugeTLB pages on arm64 (with a debug patch applied) hit
the following stack trace when the kernel crashed.

[ 3732.462797] Call trace:
[ 3732.462835]  split_huge_page_to_list+0x3b0/0x858
[ 3732.462913]  migrate_pages+0x728/0xc20
[ 3732.462999]  soft_offline_page+0x448/0x8b0
[ 3732.463097]  __arm64_sys_madvise+0x724/0x850
[ 3732.463197]  el0_svc_handler+0x74/0x110
[ 3732.463297]  el0_svc+0x8/0xc
[ 3732.463347] Code: d1000400 f90b0e60 f2fbd5a2 a94982a1 (f9000420)
