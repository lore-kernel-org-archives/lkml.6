Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B66C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 07:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971A521019
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 07:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="USg6Jlz+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbeLaHYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 02:24:05 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:42196 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbeLaHYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 02:24:05 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBV7NfCi086845;
        Mon, 31 Dec 2018 01:23:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1546241021;
        bh=dcJlzenKwlZxVF52kac9hRUeb8Zn724yAguLWcOgVXw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=USg6Jlz+wZP3VODbRYvdCRa3p9dTEgOEYYe21B87kupdYEkHzIDGMSQsn+9yhcHhn
         +VktUbFzAF4l6TPhNJNHwDL3S2qDnGx7xTQw2f21eEBqBNWg8iSNNQ+6/+/jiC8hGI
         KF/pfJSAGQj/89TyjqcAMIMMuwt0JhYVmjTP/nI8=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBV7Nfrx071415
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Dec 2018 01:23:41 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 31
 Dec 2018 01:23:40 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 31 Dec 2018 01:23:40 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBV7NbvQ030072;
        Mon, 31 Dec 2018 01:23:38 -0600
Subject: Re: [PATCH v2 2/3] clk: ti: check clock type before doing autoidle
 ops
To:     Tony Lindgren <tony@atomide.com>,
        Andreas Kemnade <andreas@kemnade.info>
CC:     Stephen Boyd <sboyd@kernel.org>, <bcousson@baylibre.com>,
        <letux-kernel@openphoenux.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <mturquette@baylibre.com>, <paul@pwsan.com>
References: <154356242517.88331.8496814814468751012@swboyd.mtv.corp.google.com>
 <9eb7b090-4803-d389-4112-3bf058385b2e@ti.com>
 <154356463284.88331.13323307899580657085@swboyd.mtv.corp.google.com>
 <eca27a46-2ca3-1a02-c0c8-c1c00b3b2f46@ti.com>
 <20181130153729.GG53235@atomide.com>
 <154362191595.88331.15503578806026771935@swboyd.mtv.corp.google.com>
 <20181203153910.GA6707@atomide.com> <20181203172246.0e767a16@kemnade.info>
 <20181204164556.GB6707@atomide.com> <20181227211222.5996c356@aktux>
 <20181228200229.GY6707@atomide.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <76d9fc57-898b-53ba-1dca-78e5b5c9b2be@ti.com>
Date:   Mon, 31 Dec 2018 09:23:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181228200229.GY6707@atomide.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/12/2018 22:02, Tony Lindgren wrote:
> * Andreas Kemnade <andreas@kemnade.info> [181227 20:13]:
>> Hi,
>>
>> On Tue, 4 Dec 2018 08:45:57 -0800
>> Tony Lindgren <tony@atomide.com> wrote:
>>
>>> * Andreas Kemnade <andreas@kemnade.info> [181204 06:17]:
>>>> On Mon, 3 Dec 2018 07:39:10 -0800
>>>> Tony Lindgren <tony@atomide.com> wrote:
>>>>> The consumer device stays active just fine with PM runtime
>>>>> calls. So yes, the problem is keeping a clock controller forced
>>>>> active for the period of consumer device reset. Other than
>>>>> that typically autoidle can be just kept enabled.
>>>>>    
>>>> Are we still talking about the same problem? Maybe I am losing track
>>>> here. Just to make sure.
>>>> The patch series was about disabling autoidle for devices which cannot
>>>> work with it during normal operation. Not during reset or something
>>>> like that.
>>>> Or is the keep-clock-active-during-reset just a requirement for bigger
>>>> restructuring ideas?
>>>
>>> Yeah there are two issues: The fix needed for the issue you brought up,
>>> and also how to let a reset driver to block autoidle for reset.
>>>
>> Hmm, is this set now waiting for the famous "somebody" fixing all
>> the stuff?
> 
> Well I think we're still waiting on Tero to comment on this.

The only item requiring immediate fixing is the point Stephen made out, 
removing the usage of CLK_IS_BASIC from this patch.

Afaics, the reset related concerns Tony has can be handled later.

-Tero

> 
>> What are currently visible symptoms for the driver not blocking
>> autoidle for reset? Maybe I can at least test something there. I have
>> also omap5 here.
> 
> Oh that's just for making drivers/reset drivers to work in
> the long run. Let's keep that separate from these fixes..
> 
> Regards,
> 
> Tony
> 
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
