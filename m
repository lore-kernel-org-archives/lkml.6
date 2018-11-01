Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881E6C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107352081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="aSBKFXTh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107352081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbeKAVs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 17:48:58 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:27813 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbeKAVs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 17:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1541076363;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=h8T47b5XVCRlDscN1+vTd3FKbVRtSjeCHHTDSyHbxT8=;
        b=aSBKFXThF0eECY8b2lmE0gs5ERbWkVDK1XhOeAT1nCOy7hU77d/9ks+Z9CeQ3ZK/Cd
        Jggy7KC2g6/yNCtpisZSFMWrWPshvgp8EWnVy1EiQIohVsaWdmlzgLThbLh6zUrVWw2Q
        w/cAnCVRCStySWIXKdnzWm7uMRjt0D5SiQzNOpkJaZQ/yojy+qVRMOMFYZodcnmo6xY+
        CzLbgO8chgGWnaay9TN1J3EgVhA3pDRSkcRZ+Mw0Vo/KtI71ST+UwGFxXpQ2dkKfp0eW
        H5AzbRreRK+SSHKA7iiPbDrCGR1Z5qUh2eQIs6hiYhs30JqiACaWP8AS2Zrs6WQ6G4cg
        khOg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkK3TmjrJUcWHjjnEOaMwSIQqdV"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:5c96:3539:c69c:189]
        by smtp.strato.de (RZmta 44.3 AUTH)
        with ESMTPSA id Z0624cuA1CjmNcK
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 1 Nov 2018 13:45:48 +0100 (CET)
Subject: Re: [PATCH] of: Fix cpu node iterator to not ignore disabled cpu
 nodes
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
References: <20181031144226.26747-1-robh@kernel.org>
 <87o9b9dphd.fsf@concordia.ellerman.id.au>
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <1055f6ae-a25b-117a-e9e4-44dd4f978803@xenosoft.de>
Date:   Thu, 1 Nov 2018 13:45:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87o9b9dphd.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 November 2018 at 12:08PM, Michael Ellerman wrote:
> Rob Herring <robh@kernel.org> writes:
>
>> In most cases, nodes with 'status = "disabled";' are treated as if the
>> node is not present though it is a common bug to forget to check that.
>> However, cpu nodes are different in that "disabled" simply means offline
>> and the OS can bring the CPU core online. Commit f1f207e43b8a ("of: Add
>> cpu node iterator for_each_of_cpu_node()") followed the common behavior
>> of ignoring disabled cpu nodes. This breaks some powerpc systems (at
>> least NXP P50XX/e5500). Fix this by dropping the status check.
>>
>> Fixes: 651d44f9679c ("of: use for_each_of_cpu_node iterator")
>> Fixes: f1f207e43b8a ("of: Add cpu node iterator for_each_of_cpu_node()")
>> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Christian Zigotzky <chzigotzky@xenosoft.de>
>> Cc: Frank Rowand <frowand.list@gmail.com>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>>   drivers/of/base.c | 2 --
>>   1 file changed, 2 deletions(-)
> This fixes my machine, thanks.
>
> Tested-by: Michael Ellerman <mpe@ellerman.id.au>
>
> It was actually originally reported to me by Christian, so also:
>
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
>
>
> cheers
>
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index cc62da278663..e47c5ce6cd58 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -776,8 +776,6 @@ struct device_node *of_get_next_cpu_node(struct device_node *prev)
>>   		if (!(of_node_name_eq(next, "cpu") ||
>>   		      (next->type && !of_node_cmp(next->type, "cpu"))))
>>   			continue;
>> -		if (!__of_device_is_available(next))
>> -			continue;
>>   		if (of_node_get(next))
>>   			break;
>>   	}
>> -- 
>> 2.19.1

Hi All,

Many thanks for your help! This patch fixes my P5020 board (dual core) 
and my virtual QEMU ppce500 machine (quad core).

Have a nice day!

Cheers,
Christian

