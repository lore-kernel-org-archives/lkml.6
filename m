Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58330C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4385206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AoW3+TSv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732289AbfBOFvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 00:51:53 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:18400 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfBOFvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 00:51:53 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190215055150epoutp0343377c232c23fe2c49384bd323ec723e~Dc7M8mu2y0708507085epoutp032
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 05:51:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190215055150epoutp0343377c232c23fe2c49384bd323ec723e~Dc7M8mu2y0708507085epoutp032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550209910;
        bh=Abymj8AetJuUedVZCGKrJTCDIOuTLl+KooQOlVnX9bc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=AoW3+TSvQoCJ+KyUtdR0DJQuhWn9UMcX7csXt/pbI3Z9XD9ok5JQSkUg+AuiaJsEn
         2Wed9k1LVfwgBFecn4I8zbG+YgX2J6Ip/9BXVfzEXl17vqt9rLFluDMhnyrnlWC99C
         u8sDWRJadn0v7JEQxtt/mk84sUH8ZQssYBtQYIOY=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.158]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190215055148epcas1p461fbb907be9e2f9972883668cf82a9b8~Dc7K2KiLV1319613196epcas1p4L;
        Fri, 15 Feb 2019 05:51:48 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        24.F9.04206.073566C5; Fri, 15 Feb 2019 14:51:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190215055144epcas1p4e337c7e04db859215638d848774b31ed~Dc7HDdOld1516015160epcas1p4B;
        Fri, 15 Feb 2019 05:51:44 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190215055144epsmtrp1191afd38400a9083c5c486d2f17b95e7~Dc7HBwQxx2300823008epsmtrp15;
        Fri, 15 Feb 2019 05:51:44 +0000 (GMT)
X-AuditID: b6c32a39-d7dff7000000106e-ca-5c665370eed0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7A.EF.03601.F63566C5; Fri, 15 Feb 2019 14:51:43 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190215055143epsmtip1650ae388df3b79ba83eb8c5c44559f9f~Dc7G6gXnp2296522965epsmtip1P;
        Fri, 15 Feb 2019 05:51:43 +0000 (GMT)
Subject: Re: [PATCH] usb: dwc2: hcd: call dwc2_is_controller_alive under
 spinlock
To:     Minas Harutyunyan <minas.harutyunyan@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
From:   Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <4f1362aa-f544-4857-b16f-2d0202277ddd@samsung.com>
Date:   Fri, 15 Feb 2019 14:51:43 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <410670D7E743164D87FA6160E7907A56013A7DC6C8@am04wembxa.internal.synopsys.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmnm5BcFqMwfkuE4vmxevZLC7vmsNm
        sWhZK7PF2iN32S3eTbnN7MDqsX/uGnaPvi2rGD227P/M6PF5k1wAS1S2TUZqYkpqkUJqXnJ+
        SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QXiWFssScUqBQQGJxsZK+nU1R
        fmlJqkJGfnGJrVJqQUpOgWWBXnFibnFpXrpecn6ulaGBgZEpUGFCdsbDSTdZClaLVfxdeJC9
        gfGIYBcjJ4eEgInE6fNLmLsYuTiEBHYwSszsXsAI4XxilDjybiULhPONUeLP439MMC2vTxyC
        qtrLKHG96SpU/3tGiV+nVrODVAkLBEucO/GRGcQWESiUuPD5GRNIEbPAdkaJhX+Ps4Ek2AR0
        JLZ/Ow42llfATmLhxclgDSwCqhK/561nAbFFBSIkDve+Y4SoEZQ4OfMJWJxTIEri09S1YL3M
        AuISt57Mh7LlJba/nQN2kYTAZTaJt1c/MUPc7SJx6sYdqB+EJV4d38IOYUtJvOxvg7KrJXY1
        n4Fq7mCUuLWtCarBWGL/0slANgfQBk2J9bv0IZbxSbz72sMKEpYQ4JXoaBOCqFaRuPT6JRPM
        +LtP/rNC2B4Sf+fdZYWE1itGiSmTnjJOYFSYheS3WUj+mYXkn1kImxcwsqxiFEstKM5NTy02
        LDBFjvBNjOBkqWW5g/HYOZ9DjAIcjEo8vCsyUmOEWBPLiitzDzFKcDArifDy+abFCPGmJFZW
        pRblxxeV5qQWH2I0BQb9RGYp0eR8YCLPK4k3NDUyNja2MDE0MzU0VBLnXe/gHCMkkJ5Ykpqd
        mlqQWgTTx8TBKdXAOCtldccEiZzntdF9jxxbVA7qz9Pe9D1+W8CDdf0M99Y6Jxtcn5lin3A5
        LGHKzRvzPF2//GbyizAI3L2jNyPH9qDGwkmr2iUK5A6yn5K/uUZ449uYa0qHW/knBnkyFhrw
        JO+5wmmYOm3aSalfTM4a3g9F7y0/y7rm5Bz1udt0BbSEmZqXLt0koMRSnJFoqMVcVJwIAAaM
        L4SsAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsWy7bCSnG5+cFqMwaEfNhbNi9ezWVzeNYfN
        YtGyVmaLtUfuslu8m3Kb2YHVY//cNewefVtWMXps2f+Z0ePzJrkAligum5TUnMyy1CJ9uwSu
        jIeTbrIUrBar+LvwIHsD4xHBLkZODgkBE4nXJw4xdjFycQgJ7GaUONZ7kxEiISXx+elUti5G
        DiBbWOLw4WKImreMEocbtrGC1AgLBEucO/GRGcQWESiUWPlyDRNIEbPAdkaJBzumsUJ0vGKU
        +LvpKFgHm4COxPZvx5lAbF4BO4mFFyeDdbMIqEr8nreeBcQWFYiQ+Ph0H1SNoMTJmU/A4pwC
        URKfpq4FizMLqEv8mXeJGcIWl7j1ZD5UXF5i+9s5zBMYhWYhaZ+FpGUWkpZZSFoWMLKsYpRM
        LSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIjg0trR2MJ07EH2IU4GBU4uENTEuNEWJNLCuu
        zD3EKMHBrCTCy+ebFiPEm5JYWZValB9fVJqTWnyIUZqDRUmcVz7/WKSQQHpiSWp2ampBahFM
        lomDU6qBccL8f8m3bnFt6PnQ8iqA72SRofvXjeYG3rEHp9QusuqJurX986n8knq1Z+f+9dTb
        X95ec/Fau2qH4dxD2wsOi7su/Lb3gUziv1UKvFH3bh/OO7dzx/Kbhw9YTp8Qq/k8qa3I5HhB
        BXNF08PNHOGTSzn7rS+ac7NLauqXtMw5cdDo7B6Zhs1PjiqxFGckGmoxFxUnAgCEapr8iQIA
        AA==
X-CMS-MailID: 20190215055144epcas1p4e337c7e04db859215638d848774b31ed
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190214100344epcas1p316a40d88f3b52a10745c95cc3d16a0ed
References: <CGME20190214100344epcas1p316a40d88f3b52a10745c95cc3d16a0ed@epcas1p3.samsung.com>
        <1550138622-10761-1-git-send-email-jh80.chung@samsung.com>
        <410670D7E743164D87FA6160E7907A56013A7DC6C8@am04wembxa.internal.synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minas,

On 2/14/19 8:43 PM, Minas Harutyunyan wrote:
> Hi Jaehoon Chung,
> 
> On 2/14/2019 2:04 PM, Jaehoon Chung wrote:
>> This patch is referred to Robert's patch
>> commit cf54772b913b ("usb: dwc2: call dwc2_is_controller_alive() under spinlock")
>>
>> During running sdb with otg mode, the usb is hung sometime.
>>
>> The one of SDB hang issues should be fixed with this patch.
>> After hang, it doesn't never trigger the usb interrupt.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>>   drivers/usb/dwc2/hcd_intr.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/usb/dwc2/hcd_intr.c b/drivers/usb/dwc2/hcd_intr.c
>> index 88b5dcf..8d3b155 100644
>> --- a/drivers/usb/dwc2/hcd_intr.c
>> +++ b/drivers/usb/dwc2/hcd_intr.c
>> @@ -2222,13 +2222,13 @@ irqreturn_t dwc2_handle_hcd_intr(struct dwc2_hsotg *hsotg)
>>   	u32 gintsts, dbg_gintsts;
>>   	irqreturn_t retval = IRQ_NONE;
>>   
>> +	spin_lock(&hsotg->lock);
>> +
>>   	if (!dwc2_is_controller_alive(hsotg)) {
>>   		dev_warn(hsotg->dev, "Controller is dead\n");
>> -		return retval;
>> +		goto out;
>>   	}
>>   
>> -	spin_lock(&hsotg->lock);
>> -
>>   	/* Check if HOST Mode */
>>   	if (dwc2_is_host_mode(hsotg)) {
>>   		gintsts = dwc2_read_core_intr(hsotg);
>> @@ -2276,6 +2276,7 @@ irqreturn_t dwc2_handle_hcd_intr(struct dwc2_hsotg *hsotg)
>>   		}
>>   	}
>>   
>> +out:
>>   	spin_unlock(&hsotg->lock);
>>   
>>   	return retval;
>>
> 
> 1. Checking core alive or not was introduced in our internal reference 
> driver for our setups, because sometime AHB-PCI bridge can hung, not 
> core itself. If it happen then only way to overcome it - reboot core 
> setup and PC.
> 2. Actually this issue was fixed on our setups and currently no need to 
> check access via bridge to core.
> 3. Any case if it still happen on some platforms then first need to 
> check and fix HW

I didn't check with latest kernel. we're using v4.4.172.
This issue is occurred on only ARTIK boards.
- During running test about 10~15 hours, suddenly hang.
- It's impossible to fix HW side.

After applied this patch, passed the test case as 100%. (Before applied, it didn't pass the test.)

> 
> On asserted any interrupt for dwc2, handlers call sequence is follow: 
> common->gadget->host handlers. If core alive checked in common handler 
> then checking same stuff in host handler again not needed at all.

Right, it's the duplicated checking according to sequence.

> 
> So, core alive checking in host handler create issue for your test, I 
> suggest to not fix alive checking in host interrupt handler as you 
> suggested and done in common handler, but just remove it.

Will remove it.

Best Regards,
Jaehoon Chung

> 
> Thanks,
> Minas
> 
> 
> 
> 
> 

