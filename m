Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694B6C67790
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A65920846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="aPGs/5sI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A65920846
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbeGZCfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 22:35:41 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:60761 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728407AbeGZCfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 22:35:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 86B10142524AA;
        Thu, 26 Jul 2018 09:25:00 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id jCEasJCKXR1R; Thu, 26 Jul 2018 09:25:00 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id DD560142524AD;
        Thu, 26 Jul 2018 09:24:59 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai DD560142524AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1532568299;
        bh=WmUcy9IfN26EvjoY86jVSxOXEhqPEY2DtyLWA3v+7g4=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:
         Content-Transfer-Encoding;
        b=aPGs/5sI3wHNUKEwZPn6Kjgou45GdEoT41bLeiIdq5MSFS9bCLd137eCwMPeRqoby
         mmnR5Q9qfC1fsT3VCJbtTMJN1LZ3Tjvs1o7PYx6b7btgyLk612GfpnY+STtBuMdJzL
         irq2OiHXonxQVtMT3qNWuaNcuZvlMdXOWal5mEQA=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id M3TymsYfXiqt; Thu, 26 Jul 2018 09:24:59 +0800 (CST)
Received: from [192.168.128.73] (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id 8FD1D142524AA;
        Thu, 26 Jul 2018 09:24:59 +0800 (CST)
Subject: Re: [PATCH] dmaengine: add a new helper dmam_async_device_register
To:     Vinod <vkoul@kernel.org>
Cc:     corbet@lwn.net, dan.j.williams@intel.com, robh@kernel.org,
        linux-doc@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180725054645.9723-1-sjhuang@iluvatar.ai>
 <20180725123826.GT3661@vkoul-mobl>
From:   Huang Shijie <sjhuang@iluvatar.ai>
Message-ID: <452f2991-241b-1f0f-efad-9c7e37814c5e@iluvatar.ai>
Date:   Thu, 26 Jul 2018 09:21:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180725123826.GT3661@vkoul-mobl>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,


=D4=DA 2018=C4=EA07=D4=C225=C8=D5 20:38, Vinod =D0=B4=B5=C0:
> On 25-07-18, 13:46, Huang Shijie wrote:
>> This patch adds the dmam_async_device_register for DMA code.
>> Use the Devres to call the release for the DMA engine driver.
> no users?
I can add some new users if you want.
I will add an extra patch for it.

>
>> Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
>> ---
>>   Documentation/driver-model/devres.txt |  1 +
>>   drivers/dma/dmaengine.c               | 35 +++++++++++++++++++++++++=
++
>>   include/linux/dmaengine.h             |  1 +
>>   3 files changed, 37 insertions(+)
>>
>> diff --git a/Documentation/driver-model/devres.txt b/Documentation/dri=
ver-model/devres.txt
>> index a3e8bceb5f19..26c6de621446 100644
>> --- a/Documentation/driver-model/devres.txt
>> +++ b/Documentation/driver-model/devres.txt
>> @@ -240,6 +240,7 @@ CLOCK
>>     devm_of_clk_add_hw_provider()
>>  =20
>>   DMA
>> +  dmam_async_device_register()
> can we name it dmaengine_async_device_register, not to confuse with dma=
 APIs
ok.
If no one objects the dmaengine_async_device_register().
I will use it in the next version.

Thanks
Huang Shijie

