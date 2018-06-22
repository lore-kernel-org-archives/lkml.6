Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09425C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B49245FD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B49245FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934212AbeFVRYA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:24:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:32277 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754264AbeFVRX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:23:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 10:23:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,258,1526367600"; 
   d="scan'208";a="49146568"
Received: from haiyuewa-mobl1.ccr.corp.intel.com (HELO [10.249.173.233]) ([10.249.173.233])
  by fmsmga007.fm.intel.com with ESMTP; 22 Jun 2018 10:23:56 -0700
Subject: Re: [PATCH ] ipmi: kcs_bmc: fix IRQ exception if the channel is not
 open
To:     minyard@acm.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     luis.a.silva@dell.com, avi.fishman@nuvoton.com,
        openbmc@lists.ozlabs.org
References: <1529636218-280096-1-git-send-email-haiyue.wang@linux.intel.com>
 <ea0a4cd3-2973-7ac8-c4a1-26379d9066cc@acm.org>
From:   "Wang, Haiyue" <haiyue.wang@linux.intel.com>
Message-ID: <980bbe06-afa6-67b0-a3d3-c5fd921dcfbd@linux.intel.com>
Date:   Sat, 23 Jun 2018 01:23:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <ea0a4cd3-2973-7ac8-c4a1-26379d9066cc@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-06-22 20:43, Corey Minyard wrote:
>> Signed-off-by: Haiyue Wang <haiyue.wang@linux.intel.com>
>> ---
>> Hi Corey,
>>
>> This patch looks introducing BIG modification, it should be easily
>> understandable, and makes code clean & fix an error design, which
>> is introduced by misunderstanding the IRQ return value.
>
> I'm having a little trouble understanding your text above, so let me 
> try to repeat
> back to you what I'm thinking you are saying...
>
Sorry for my bad writing.... :(
> You have two (or more) devices using the same interrupt, and at least 
> one is an
> IPMI KCS device.  And interrupt comes in to the other device when the 
> IPMI KCS
> device is not running.  The original code issues an abort when that 
> happens,
> which is obviously incorrect.  It then returns -ENODATA, .
>
> When the interrupt comes in for the abort handling, the driver will 
> then issue
> another abort, and again returns -ENODATA.  This time neither driver 
> handles
> the interrupt, resulting in the logs.
>
> In general, I think the change you have here is good.  You don't want to
> issue an abort in this case.  But...
>

> If I am right, this fix doesn't completely solve the problem.  It does 
> solve this
> immediate problem, but what if there is an OS on the other end of the
> KCS interface that sets the IBF flag?  The same situation will occur.  
> In fact
> it will occur even if there is only one handler for the interrupt.
>
> Maybe it's best to have the interrupt disabled unless the device is open.
> You have to handle the interrupt disable race on a close, but with the
> sync functions that shouldn't be too hard.
>
In fact, in BMC chip design, the LPC controller has many devices, such as
Port 80 snoop, BT, KCS etc, they shares the same interrupt. :)

Take AST2500 BMC as an example, please search the keyword 'interrupts = 
<8>' in
this file:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/aspeed-g5.dtsi?h=v4.18-rc1

And may have 4 KCS channels:
https://patchwork.kernel.org/patch/10318877/
This patch just enables kcs3 & kcs4, which use the same interrupt number 8.

So the interrupt should be enabled always.

And this IRQ issue root cause it that the IRQ handler just return IRQ_NONE
if it is not opened. And for abort actions, I just put it under its 
related channel
IBF is set. Because only IBF is set, aborting makes sense.

> -corey

