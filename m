Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD94C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81DF32145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81DF32145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbeIXP1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 11:27:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:35134 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725935AbeIXP1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 11:27:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6831AAD94;
        Mon, 24 Sep 2018 09:26:07 +0000 (UTC)
Date:   Mon, 24 Sep 2018 11:26:06 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] hid: hid-core: Fix a sleep-in-atomic-context bug in
 __hid_request()
In-Reply-To: <20180913033432.16336-1-baijiaju1990@gmail.com>
Message-ID: <nycvar.YFH.7.76.1809241124480.15880@cbobk.fhfr.pm>
References: <20180913033432.16336-1-baijiaju1990@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Sep 2018, Jia-Ju Bai wrote:

> hid_alloc_report_buf() has to be called with GFP_ATOMIC in 
> __hid_request(), because there are the following callchains 
> leading to __hid_request() being an atomic context:
> 
> picolcd_send_and_wait (acquire a spinlock)
>   hid_hw_request
>     __hid_request
>       hid_alloc_report_buf(GFP_KERNEL)
> 
> picolcd_reset (acquire a spinlock)
>   hid_hw_request
>     __hid_request
>       hid_alloc_report_buf(GFP_KERNEL)
> 
> lg4ff_play (acquire a spinlock)
>   hid_hw_request
>     __hid_request
>       hid_alloc_report_buf(GFP_KERNEL)
> 
> lg4ff_set_autocenter_ffex (acquire a spinlock)
>   hid_hw_request
>     __hid_request
>       hid_alloc_report_buf(GFP_KERNEL)

Hm, so it's always drivers calling out into core in atomic context. So 
either we take this, and put our bets on being able to allocate the buffer 
without sleeping, or actually fix the few drivers (it's just lg4ff and 
picolcd at the end of the day) not to do that, and explicitly anotate 
__hid_request() with might_sleep().

Hmm?

Thanks,

-- 
Jiri Kosina
SUSE Labs

