Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A90FC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DADCC21104
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DADCC21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbeKHP5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 10:57:20 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35036 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725724AbeKHP5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 10:57:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62B59A78;
        Wed,  7 Nov 2018 22:23:26 -0800 (PST)
Received: from [10.162.0.72] (p8cg001049571a15.blr.arm.com [10.162.0.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DF733F5BD;
        Wed,  7 Nov 2018 22:23:24 -0800 (PST)
Subject: Re: [RFC PATCH 4/5] mm, memory_hotplug: print reason for the
 offlining failure
To:     Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <OSalvador@suse.com>,
        Baoquan He <bhe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
References: <20181107101830.17405-1-mhocko@kernel.org>
 <20181107101830.17405-5-mhocko@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <18bd20ff-7b3c-bcf2-042d-5ab59fdd42e1@arm.com>
Date:   Thu, 8 Nov 2018 11:53:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181107101830.17405-5-mhocko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/07/2018 03:48 PM, Michal Hocko wrote:
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
> Signed-off-by: Michal Hocko <mhocko@suse.com>

It might help to enumerate these failure reason strings and use macros.
