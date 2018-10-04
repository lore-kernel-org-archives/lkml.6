Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AF2C64EBD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F7F2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GH5fDCp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0F7F2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeJDVg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 17:36:29 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:57956 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbeJDVg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 17:36:29 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w94EgiBv078103;
        Thu, 4 Oct 2018 09:42:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538664164;
        bh=Wvt6VTkgLlW6lJWv9PZzmJdJsP4aiFNsbxzceA2fCwc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=GH5fDCp2tqu/6dsUqf9FyGXqOKMNR/rWSCeUuEMYQ7U3b0BXTNS21OAyXy29Nb3dP
         hyZCN/ENS5P6FnN/rQr2X8/G8ndYkq7qwGSZ07CfwnxTC0ltrXPoNjid+tUpuiR8Ch
         qpvBNOdQOtiI3ipMMy8lgoCUTUQjfwjCXKigkZCs=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w94EgiZq002952;
        Thu, 4 Oct 2018 09:42:44 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 4 Oct
 2018 09:42:43 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 4 Oct 2018 09:42:44 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w94Egdlp000694;
        Thu, 4 Oct 2018 09:42:41 -0500
Subject: Re: [PATCH RFC 0/2] mach-omap2: handle autoidle denial
To:     Tony Lindgren <tony@atomide.com>,
        Andreas Kemnade <andreas@kemnade.info>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <paul@pwsan.com>,
        <letux-kernel@openphoenux.org>
References: <20181004055147.23048-1-andreas@kemnade.info>
 <20181004142558.GB5662@atomide.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <013b01a1-2593-bdc0-dd9a-e5a114388067@ti.com>
Date:   Thu, 4 Oct 2018 17:42:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181004142558.GB5662@atomide.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/18 17:25, Tony Lindgren wrote:
> * Andreas Kemnade <andreas@kemnade.info> [181004 05:56]:
>> On the gta04 with a dm3730 omap_hdq does not work properly when the
>> device enters lower power states. Idling uart1 and 2 is enough
>> to show up that problem, if there are no other things enabled.
>> Further research reveals that hdq iclk must not be turned off during
>> transfers, also according to the TRM. That fact is also correctly described
>> in the flags but the code to handle that is incomplete.
>>
>> Since the order is first disable all autoidles, then disable selected
>> and then enable all, we need to either change that order or add
>> a usecount. Since it is done only in init, we could think about changing
>> order.
> 
> These patches look OK to me, assuming Tero will review them more
> closely.

There is no locking whatsoever in the autoidle counting atm, that must 
be fixed otherwise you get races.

> It seems we should just provide a generic interface for
> clk_allow_autoidle() and clk_deny_autoidle()? Otherwise we'll
> be forever stuck with pdata callbacks it seems.

The TI clock driver is actually providing these APIs, so that should be 
fine. I don't think there is any use / need for pdata callbacks atm, it 
just happens hwmod core is calling these at the moment which might have 
confused you.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
