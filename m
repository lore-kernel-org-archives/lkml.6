Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0F7C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4452085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:36:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B4452085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbeKFVBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:01:42 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:14597 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730553AbeKFVBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:01:41 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 26491777AB24D;
        Tue,  6 Nov 2018 19:36:51 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 6 Nov 2018
 19:36:46 +0800
Subject: Re: [PATCH v2] bit_spinlock: introduce smp_cond_load_relaxed
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Chao Yu <chao@kernel.org>
References: <1539413249-4402-1-git-send-email-hsiangkao@aol.com>
 <20181030060441.16107-1-gaoxiang25@huawei.com>
 <20181105224654.GA25864@brain-police>
 <20181106090642.GH22431@hirez.programming.kicks-ass.net>
 <5eb42b84-5195-69f2-e7a7-97568f360506@huawei.com>
 <20181106110026.GJ22431@hirez.programming.kicks-ass.net>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <dedbc211-082b-be4a-1bce-2593084d4ca3@huawei.com>
Date:   Tue, 6 Nov 2018 19:36:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181106110026.GJ22431@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 2018/11/6 19:00, Peter Zijlstra wrote:
>>> Yes, that's much better. Ideally though, we'd get rid of bit spinlocks
>>> that have significant enough contention for this to matter.
>> OK, I will send v3 to fix like the above.
> That's not answering the full question though. What bit spinlocks did
> you find where this matters? And can't we convert them to proper
> spinlocks instead?

I just misunderstood your question and I get your point now.

"What bit spinlocks did you find where this matters?" nope..I said the original
background to Greg before, that is I tried to use smp_cond_load_relaxed instead
of busy spining in the development of erofs file system and I saw this bit_spinlock
implementation by chance...This is not a big modification but since I raised the
question before and I want to trace to the end...

"And can't we convert them to proper spinlocks instead?" I think bit_spinlock is
sometime preferred since it requires little memory and can be integrated into some
fields(eg. flags)...It is selectable for spinlocks don't have to many users
at the same time, so I think it depends on the detailed real use scenerio...
It is just a tool for user code to select case by case... That is my personal idea...

IMO, to use wrapped up function for the detailed scenario could be better than
open-coded all the time (eg. do cpu_relax(); while(...)) since it could be
optimizated even more for the specific architecture...

Thanks,
Gao Xiang
