Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075C8C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27F820847
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="f7pFSfkj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27F820847
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeH1Vtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:49:52 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36482 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbeH1Vtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:49:51 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7SHurXd098737;
        Tue, 28 Aug 2018 12:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535479013;
        bh=ymoxweu15qYLc0XC1BN6g3wkvIP5PlSgfwg7BtU28BM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=f7pFSfkjurrjLn1YELLnaxeFXPKn3Nv+yfbdv4YZnKv8aHKVBhKAWaHM0B/z69URz
         C75UhIBS4liuhxTJwtleNcWAs6e+we/rQgDCQgZWFIHLsiGsxC1FMjVwy0+eccI/6B
         4zygvDRRQcoJ0+zaf4wuwDNgDGkfSM+dpcgcknDc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7SHurWM031428;
        Tue, 28 Aug 2018 12:56:53 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 28
 Aug 2018 12:56:53 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 28 Aug 2018 12:56:53 -0500
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7SHur9p000680;
        Tue, 28 Aug 2018 12:56:53 -0500
Subject: Re: [PATCH] nohz: Fix missing tick reprog while interrupting inline
 timer softirq
To:     Frederic Weisbecker <frederic@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        <stable@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>
References: <1533077570-9169-1-git-send-email-frederic@kernel.org>
 <8ecb9229-4c14-6967-0863-15b47cefd251@ti.com>
 <20180824061750.GA20523@kroah.com>
 <alpine.DEB.2.21.1808240851420.1668@nanos.tec.linutronix.de>
 <0d63c2bb-f75d-3f79-c19d-bb4ac9a00cd5@ti.com> <20180824184103.GD2730@lerouge>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <47d2416d-6359-1f48-311d-404fb5bfa3a8@ti.com>
Date:   Tue, 28 Aug 2018 12:56:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180824184103.GD2730@lerouge>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/24/2018 01:41 PM, Frederic Weisbecker wrote:
> On Fri, Aug 24, 2018 at 11:10:44AM -0500, Grygorii Strashko wrote:
>> Yes. i do not see local_softirq_pending messages any more
>>
>> But one question, just to clarify, after patch "nohz: Fix missing tick reprog while interrupting inline timer softirq"
>> the tick_nohz_irq_exit() will be called few times in case of nested interrupts (min 2):
>> gic_handle_irq
>>   |- irq_exit
>>      |- preempt_count_sub(HARDIRQ_OFFSET);
>>      |-__do_softirq
>> 	<irqs enabled>
>> 	|- gic_handle_irq()
>> 	   |- irq_exit()
>> 		|- tick_irq_exit()
>> 		   if (!in_irq())
>> 			tick_nohz_irq_exit(); <-- [1]
>>      |- tick_irq_exit()
>> 	if (!in_irq())
>> 		tick_nohz_irq_exit(); <-- [2]
>>
>> Is it correct? in 4.14 tick_nohz_irq_exit() is much more complex then in LKML now,
>> and this is hot path.
> 
> That's correct and it's indeed more costly in 4.14 as then the tick is going to be programmed
> twice.
> 

Sry, that disturbing you all, but what are the conclusion here for 4.14.y?
- take Thomas's patch https://lore.kernel.org/patchwork/patch/969521/#1162900
- revert commit 2d898915ccf4838c04531c51a598469e921a5eb5


-- 
regards,
-grygorii
