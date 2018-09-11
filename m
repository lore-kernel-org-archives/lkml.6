Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F10C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17C520839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="o532/3nf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F17C520839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeIKOhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:37:09 -0400
Received: from m12-15.163.com ([220.181.12.15]:34053 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbeIKOhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=f00wM
        8SF24LQxf2Za+47IhG6aAowtVvDpl7dTP1dD0M=; b=o532/3nfpBIH7z37POFIj
        Y4QmazY2BYiqzxRm8T28lRypOaVIKF+yEDgSwUkTPbqBd/0+TeUMhB1EZK37BOmX
        cnTXrgBMqqKnIBrU6HY4/sXe+Ib4eUET/ahExxzppTRGgbtq2TsNflfcf7C7CrQh
        p0Crjh5nHFoZ5x56Yh13gI=
Received: from localhost.localdomain (unknown [49.65.59.196])
        by smtp11 (Coremail) with SMTP id D8CowACHO9ELjZdbyNVwGw--.51844S2;
        Tue, 11 Sep 2018 17:38:20 +0800 (CST)
Subject: Re: Affinity managed interrupts vs non-managed interrupts
To:     Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>,
        linux-block <linux-block@vger.kernel.org>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
References: <602cee6381b9f435a938bbaf852d07f9@mail.gmail.com>
 <alpine.DEB.2.21.1809021357000.1349@nanos.tec.linutronix.de>
 <66256272c020be186becdd7a3f049302@mail.gmail.com>
 <alpine.DEB.2.21.1809031719460.1383@nanos.tec.linutronix.de>
 <dd1c5df55aa99cf4a37bcc58e77e840a@mail.gmail.com>
 <f436fa6a-b865-fadb-4f77-44309ff84405@163.com>
 <c0f779f1d5ef131c39f9397f97d453e8@mail.gmail.com>
 <alpine.DEB.2.21.1809051235180.1416@nanos.tec.linutronix.de>
 <d2a6f7cf-31df-de17-82e3-eccb9cc73ed8@163.com>
 <alpine.DEB.2.21.1809061244151.1570@nanos.tec.linutronix.de>
 <20180911091354.GA9898@lst.de>
From:   Dou Liyang <dou_liyang@163.com>
Message-ID: <876cd3e2-7519-eab9-7da6-2a672256365e@163.com>
Date:   Tue, 11 Sep 2018 17:38:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180911091354.GA9898@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: D8CowACHO9ELjZdbyNVwGw--.51844S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JryfCFWfJw13Kw4xZF15twb_yoW3tFgE9F
        yvy3WfJw12krsY9w1xtFWqgFnrZFW5u3W8A3yYvrs7XFyYvrn8Z34DCF15Xa4xW3429rya
        9rn0qr4avFWjgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeubyJUUUUU==
X-Originating-IP: [49.65.59.196]
X-CM-SenderInfo: pgrxszxl1d0wi6rwjhhfrp/1tbiMQ++olUMHx8+5gABsi
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
At 09/11/2018 05:13 PM, Christoph Hellwig wrote:
> On Thu, Sep 06, 2018 at 01:46:46PM +0200, Thomas Gleixner wrote:
>>
>> I think the right solution for these pre/post vectors is to _NOT_ mark
>> them managed and leave them as regular interrupts which can be affinity
>> controlled and also can move freely on hotplug.
> 
> Yes, agreed.  Marking the pre/post vector as managed was a mistake
> (and I don't think it even was intentional, at least on my part).
> 
Got it !

And, I am trying to fix this by:

  -Don't set affinity for pre/post vectors in
   irq_create_affinity_masks().

  -And do not setup the desc->affinity of pre/post vectors in
   alloc_msi_entry().

So, the affinity in alloc_descs() will be NULL, and the interrupt won't
be marked as IRQD_AFFINITY_MANAGED.

Is it OK? and I will show the codes after testing it.

Thanks,
	dou

