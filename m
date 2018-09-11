Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70508C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AEB720854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZD/hj7eS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AEB720854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbeIKNYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:24:25 -0400
Received: from m12-18.163.com ([220.181.12.18]:44439 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbeIKNYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=yfYzb
        8Fkk4QkfK3wT32+KZRLSEelkm70iNASdYUaZWg=; b=ZD/hj7eS/Nx0utPCzqJ05
        jOXGjATcdGjY5/e5ltEiYUeJ6nR4YvEq8X4jkZMKZxXucsrlzgMPRrx7GK3RWuNy
        Gcbygmg6HDSQQ9yc5642mJB2JVM3BOM0megB+uhwdWiFy+Z5brs2WrGMwwyDIXb+
        MVcxdKlfsiBd/eMNYjEfkI=
Received: from [166.111.71.58] (unknown [166.111.71.58])
        by smtp14 (Coremail) with SMTP id EsCowADXHh_xe5dbptGYSw--.8087S2;
        Tue, 11 Sep 2018 16:25:21 +0800 (CST)
Subject: Re: [PATCH v2] usb: cdc-wdm: Fix a sleep-in-atomic-context bug in
 service_outstanding_interrupt()
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     gregkh@linuxfoundation.org, johan@kernel.org, bjorn@mork.no,
        mingo@kernel.org, oneukum@suse.com, viro@zeniv.linux.org.uk,
        mark.rutland@arm.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180901081210.16655-1-baijiaju1990@gmail.com>
 <20180911074930.2g6ryk7qe46cijhi@linutronix.de>
From:   Jia-Ju Bai <baijiaju1990@163.com>
Message-ID: <80bf95d7-7485-d74c-2e41-73bd358aa2c6@163.com>
Date:   Tue, 11 Sep 2018 16:25:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180911074930.2g6ryk7qe46cijhi@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: EsCowADXHh_xe5dbptGYSw--.8087S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw4DCF4kZw1DXF43Kw4rXwb_yoWfAFg_Wr
        1rX3yxAw4UJF47JrnrGrZ093s8G3y8Wry8JwsxWry7Jr15Xw4rW3WDAr98Gr1rXrW5t3Z8
        Wa9FgryFv3sF9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU52-e5UUUUU==
X-Originating-IP: [166.111.71.58]
X-CM-SenderInfo: xedlyx5dmximizq6il2tof0z/1tbiYxG+elaD0l296gAAs7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/9/11 15:49, Sebastian Andrzej Siewior wrote:
> On 2018-09-01 16:12:10 [+0800], Jia-Ju Bai wrote:
>> wdm_in_callback() is a completion handler function for the USB driver.
>> So it should not sleep. But it calls service_outstanding_interrupt(),
>> which calls usb_submit_urb() with GFP_KERNEL.
> At which point does wdm_in_callback() invoke
> service_outstanding_interrupt()? I don't see it. I see one invocation
> from wdm_read() and another from service_interrupt_work().
>
> Also, if that would be the case, then spin_unlock_irq() in an USB
> completion handler (which might run in IRQ context with interrupts
> disabled) would be wrong.

Yes, you are right.
I checked an old kernel version Linux-4.16 and got this report.
The current code looks much different from the code that I checked.
Sorry for my false report, and thanks for your correction.


Best wishes,
Jia-Ju Bai

