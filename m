Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C16C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D6D206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D6D206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbeIEM6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:58:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:54482 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726401AbeIEM6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:58:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6CFDDAEA5;
        Wed,  5 Sep 2018 08:29:30 +0000 (UTC)
Date:   Wed, 5 Sep 2018 10:29:29 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hid: hid-core: Fix a sleep-in-atomic-context bug in
 __hid_request()
In-Reply-To: <20180901121659.1257-1-baijiaju1990@gmail.com>
Message-ID: <nycvar.YFH.7.76.1809051026540.15880@cbobk.fhfr.pm>
References: <20180901121659.1257-1-baijiaju1990@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Sep 2018, Jia-Ju Bai wrote:

> The driver may sleep with holding a spinlock.
> 
> The function call paths (from bottom to top) in Linux-4.16 are:
> 
> [FUNC] hid_alloc_report_buf(GFP_KERNEL)
> drivers/hid/hid-core.c, 1435: 
> 	hid_alloc_report_buf in __hid_request
> ./include/linux/hid.h, 1023: 
> 	__hid_request in hid_hw_request
> drivers/hid/hid-picolcd_core.c, 111: 
> 	hid_hw_request in picolcd_send_and_wait
> drivers/hid/hid-picolcd_core.c, 100: 
> 	_raw_spin_lock_irqsave in picolcd_send_and_wait
> 
> [FUNC] hid_alloc_report_buf(GFP_KERNEL)
> drivers/hid/hid-core.c, 1435: 
> 	hid_alloc_report_buf in __hid_request
> ./include/linux/hid.h, 1023: 
> 	__hid_request in hid_hw_request
> drivers/hid/hid-picolcd_core.c, 245: 
> 	hid_hw_request in picolcd_reset
> drivers/hid/hid-picolcd_core.c, 235: 
> 	_raw_spin_lock_irqsave in picolcd_reset
> 
> [FUNC] hid_alloc_report_buf(GFP_KERNEL)
> drivers/hid/hid-core.c, 1435: 
> 	hid_alloc_report_buf in __hid_request
> ./include/linux/hid.h, 1023: 
> 	__hid_request in hid_hw_request
> drivers/hid/hid-picolcd_fb.c, 215: 
> 	hid_hw_request in picolcd_fb_reset
> drivers/hid/hid-picolcd_fb.c, 206: 
> 	_raw_spin_lock_irqsave in picolcd_fb_reset
> 
> [FUNC] hid_alloc_report_buf(GFP_KERNEL)
> drivers/hid/hid-core.c, 1435: 
> 	hid_alloc_report_buf in __hid_request
> ./include/linux/hid.h, 1023: 
> 	__hid_request in hid_hw_request
> drivers/hid/hid-lg4ff.c, 465: 
> 	hid_hw_request in lg4ff_play
> drivers/hid/hid-lg4ff.c, 441: 
> 	_raw_spin_lock_irqsave in lg4ff_play
> 
> To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.
> 
> This bug is found by my static analysis tool DSAC.

Could you please rewrite the changelog so that it's human readable? The 
above is a bit hard to understand, I think something along the lines of 
"__hid_request() has to be allocating with GFP_ATOMIC because there are 
the following callchains leading to __hid_request() being an atomic 
context: ... a->b->c.._hid_request()" etc.

Thanks,

-- 
Jiri Kosina
SUSE Labs

