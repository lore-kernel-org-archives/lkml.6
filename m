Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA07C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 04:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086FB2133F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 04:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BJQPZluH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086FB2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754020AbeGCEoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 00:44:17 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55386 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753877AbeGCEoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 00:44:14 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w634h2Ta113180;
        Mon, 2 Jul 2018 23:43:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530592982;
        bh=dBrAsXQccUVpB23uHhBc8O9ceE5Fp6RINEkm+9/ustU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=BJQPZluHHaH1YKNBM2v1F6yXydUy7Big5AfHkMGqBfTF0nmU6UJ4DXnV/BD4rDGhO
         Tf4sQFOLLikURNg//FbKUQUTQploYROEAKh9NUi245Cz1i9zsFKGIwHT+ZvTs+x6rF
         2PzZGOeBYHwqmDQWDY9zyr8e/gTSsjbzsL/iUy2Y=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w634h2Tr020975;
        Mon, 2 Jul 2018 23:43:02 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 2 Jul
 2018 23:43:01 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 2 Jul 2018 23:43:01 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w634gte7019703;
        Mon, 2 Jul 2018 23:42:56 -0500
Subject: Re: [PATCH v7 0/4] ARM: davinci: complete the conversion to using the
 reset framework
To:     David Lechner <david@lechnology.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180621073706.22812-1-brgl@bgdev.pl>
 <9ec10627-49a5-07ad-8c9d-5ac873096cc0@ti.com>
 <CAMRc=Me1JTuw40tMWaai2oKMxmc_ktN2OKBhF8tmGt0cQ6magg@mail.gmail.com>
 <e4bd9f57-617a-a59e-5d05-be1a6b3e6b3d@ti.com>
 <345aed22-629a-abf6-df22-adee88a43df6@lechnology.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <03256c00-c23f-68c4-c62b-fb4b85547551@ti.com>
Date:   Tue, 3 Jul 2018 10:12:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <345aed22-629a-abf6-df22-adee88a43df6@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 July 2018 08:57 PM, David Lechner wrote:
> On 07/02/2018 07:08 AM, Sekhar Nori wrote:
>> Hi Bjorn,
>>
>> On Thursday 21 June 2018 05:11 PM, Bartosz Golaszewski wrote:
>>> 2018-06-21 12:52 GMT+02:00 Sekhar Nori <nsekhar@ti.com>:
>>>> Hi Bartosz,
>>>>
>>>> On Thursday 21 June 2018 01:07 PM, Bartosz Golaszewski wrote:
>>>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>>
>>>>> These are the remaining patches that still need to be merged in order
>>>>> to complete the conversion of the davinci dsp driver to using the
>>>>> reset
>>>>> framework.
>>>>>
>>>>> They apply on top of v4.18-rc1 with David Lechner's remaining patches
>>>>> merged.
>>>>
>>>> Series looks good to me.
>>>>
>>>> To preserve bisect, shouldn't the order of applying be patch #3, #4, #1
>>>> and #2 ?
>>>>
>>>> Given the dependencies and to preserve bisect its easiest if I take the
>>>> series with acks from remoteproc and clock maintainers.
>>>>
>>>> Open to other suggestions as well.
>>>>
>>>> Thanks,
>>>> Sekhar
>>>
>>> Oops you're right about the order. Do you want me to resend?
>>
>> With your ack, I can queue 1/4 for v4.19 and provide an immutable commit
>> to you (on top of v4.18-rc1) for you to merge any further changes you
>> want to queue from your tree.
>>
>> Bartosz, given the number of moving pieces, I think its better to keep
>> 2/4 for v4.20 release - once all other other dependencies have been
>> merged.
> 
> I was thinking the same thing as well. I will pick it up in a
> clk-davinci-4.20 branch if that sounds OK.

Sounds good. Just check that there really are no users of that API
before queuing :)

Regards,
Sekhar
