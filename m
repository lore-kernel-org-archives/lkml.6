Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FE8C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 375E225471
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 375E225471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934187AbeGBJfe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 05:35:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9191 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933423AbeGBJf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 05:35:29 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E4A3E4405BBA3;
        Mon,  2 Jul 2018 17:35:12 +0800 (CST)
Received: from [127.0.0.1] (10.142.68.147) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.382.0; Mon, 2 Jul 2018
 17:35:08 +0800
Subject: hrtimer become inaccurate with RT patch
To:     Thomas Gleixner <tglx@linutronix.de>,
        <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <anna-maria@linutronix.de>, <john.stultz@linaro.org>
CC:     Hangaohuai <hangaohuai@huawei.com>,
        "zhangjianwei (D)" <zhangjianwei8@huawei.com>,
        <yangchuanlong@huawei.com>,
        "Zhangbin (EulerOS)" <zhangbin46@huawei.com>,
        <liupeifeng3@huawei.com>
References: <12e6da4e-7681-771f-38d3-3c1abf943c24@huawei.com>
From:   gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <43d78927-3955-acde-a2d1-d2b82932a7a6@huawei.com>
Date:   Mon, 2 Jul 2018 17:34:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <12e6da4e-7681-771f-38d3-3c1abf943c24@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.68.147]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas/Anna/John,

  Recently I found that the hrtimer become inaccurate when there is a RT
process runs on the same cpu core, and the kernel has applied preempt_rt
patch.
  The Linux kernel version is v4.1.46, and the preempt_rt patch is
patch-4.1.46-rt52.patch.
  I know that in the preempt_rt environment the interrupt handlers no
longer run in interrupt context but in process context, so that RT
process will not be interrupt. But if the hrtimer is also runs in
process context the timer is useless when it's inaccurate. so I want to
consult you whether this is expected behavior? whether is reasonable to move the timer IRQ
handling to a thread?

  Check the patch-4.1.46-rt52.patch will found in function
'hrtimer_interrupt' the modify below:

@@ -1296,7 +1539,10 @@ retry:
 			if (basenow.tv64 < hrtimer_get_softexpires_tv64(timer))
 				break;

-			__run_hrtimer(timer, &basenow);
+			if (!hrtimer_rt_defer(timer))
+				__run_hrtimer(timer, &basenow);
+			else
+				raise = 1;
 		}
 	}
 	/* Reevaluate the clock bases for the next expiry */

@@ -1357,6 +1603,9 @@ retry:
 	tick_program_event(expires_next, 1);
 	printk_once(KERN_WARNING "hrtimer: interrupt took %llu ns\n",
 		    ktime_to_ns(delta));
+out:
+	if (raise)
+		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
 }

I think this is why hrtimer is run as a thread, I tried to set
hrtimer.irqsafe to 1, but the timer still seemed not right. Could anyone
give some advise? Thanks.

