Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B567C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6763F20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nowMZAGP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6763F20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbeK3Ua5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:30:57 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54324 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeK3Ua5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:30:57 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAU9M2dh087959;
        Fri, 30 Nov 2018 03:22:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543569722;
        bh=yDvRztIBD9GMAuTYT4+whwL3Ir7313jBzki3jwa+Oe8=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=nowMZAGPbX5Hh5pZo0BCAZYKgyvb/3eJO5nSjAYo7AHY2glXb6cR7XwDnF+DcBpy0
         xF7hGjRUtnU+SLXiz4aSq7UJpnf7apk/krgetz/jW4NieEX+fEPi2FzAwAmFMp0VJY
         D3HysV6RYHlHmepuGKl5OsLzlgJs1DqBT8O5e6xU=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAU9M25P090256
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Nov 2018 03:22:02 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 30
 Nov 2018 03:22:02 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 30 Nov 2018 03:22:02 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAU9Lwlb008660;
        Fri, 30 Nov 2018 03:21:59 -0600
Subject: Re: [PATCH v2 0/3] mach-omap2: handle autoidle denial
To:     Stephen Boyd <sboyd@kernel.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        <bcousson@baylibre.com>, <letux-kernel@openphoenux.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <mturquette@baylibre.com>,
        <paul@pwsan.com>, <tony@atomide.com>
References: <20181110203115.13335-1-andreas@kemnade.info>
 <154353757335.88331.5161306764126530976@swboyd.mtv.corp.google.com>
 <6c450d4f-8dbf-5122-edcc-3ac17e295bbe@ti.com>
 <154356466554.88331.3614998218425782290@swboyd.mtv.corp.google.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <cb68f26e-aa7e-bf49-df1b-9fad85334efb@ti.com>
Date:   Fri, 30 Nov 2018 11:21:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <154356466554.88331.3614998218425782290@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2018 09:57, Stephen Boyd wrote:
> Quoting Tero Kristo (2018-11-29 23:37:35)
>> On 30/11/2018 02:26, Stephen Boyd wrote:
>>> Quoting Andreas Kemnade (2018-11-10 12:31:12)
>>>> On the gta04 with a dm3730 omap_hdq does not work properly when the
>>>> device enters lower power states. Idling uart1 and 2 is enough
>>>> to show up that problem, if there are no other things enabled.
>>>> Further research reveals that hdq iclk must not be turned off during
>>>> transfers, also according to the TRM. That fact is also correctly described
>>>> in the flags but the code to handle that is incomplete.
>>>>
>>>> To handle multiple users of a single ick, autoidle is disabled
>>>> when a user of that ick requires that (has the OCPIF_SWSUP_IDLE))
>>>>
>>>> Changes since v1:
>>>> - uses spinlocks instead of mutexes
>>>> - invert counter logic
>>>> - check whether clock type is basic
>>>>
>>>
>>> I'm expecting someone like Tero or Tony to review this.
>>>
>>
>> Rest of it looks fine to me, except for the discussion under the
>> CLK_IS_BASIC flag, which might trigger a bigger rework of the code.
>>
> 
> Is that a Reviewed-by tag?
> 

Not yet, lets see where discussion ends up with patch #2. :)

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
