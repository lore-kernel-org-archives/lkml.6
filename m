Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3475C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CAB22089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zO3sHbNa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CAB22089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933340AbeGJNS4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:18:56 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:54084 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754260AbeGJNSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 09:18:54 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6ADIUlt002439;
        Tue, 10 Jul 2018 08:18:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531228710;
        bh=UIOz9s/aXMMmz7qc2REfWZVXKNo01EPqkLLDw2WjpP4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=zO3sHbNak+bFnAgC9BcvKn97Ocu7hYHKsQJYLczVz7OIYrAipAuIfh9S/NVmGu5Eu
         n8TR8uzWzbbcNmbGvAwo5EEztMekYncCkDV3TNnyahyFkWHLgykgsnZ/64CpG9nnU6
         zeG3CunItF2gGYqsGxIaJ+X/uz38/I45KDgeEZoo=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6ADIUeW011618;
        Tue, 10 Jul 2018 08:18:30 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 10
 Jul 2018 08:18:30 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 10 Jul 2018 08:18:29 -0500
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6ADIPcb031164;
        Tue, 10 Jul 2018 08:18:26 -0500
Subject: Re: [PATCH v5 4/6] bus: ti-sysc: Add support for software reset
To:     Tony Lindgren <tony@atomide.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <robh+dt@kernel.org>,
        <bcousson@baylibre.com>, <paul@pwsan.com>, <t-kristo@ti.com>,
        <mark.rutland@arm.com>, <sboyd@kernel.org>
References: <20180709164841.14182-1-faiz_abbas@ti.com>
 <20180709164841.14182-5-faiz_abbas@ti.com>
 <20180710114248.GI99251@atomide.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <0ece4ef9-1306-d36a-acff-6ee4b98337c8@ti.com>
Date:   Tue, 10 Jul 2018 18:50:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180710114248.GI99251@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Tuesday 10 July 2018 05:12 PM, Tony Lindgren wrote:
> Hi,
> 
> * Faiz Abbas <faiz_abbas@ti.com> [180709 16:50]:
>> Add support for the software reset of a target interconnect
>> module using its sysconfig and sysstatus registers.
> ...
>> --- a/drivers/bus/ti-sysc.c
>> +++ b/drivers/bus/ti-sysc.c
> ...
>> +static int sysc_reset(struct sysc *ddata)
>> +{
>> +	int offset = ddata->offsets[SYSC_SYSCONFIG];
>> +	int val = sysc_read(ddata, offset);
> 
> Testing with omap4 sysc dts data I noticed we already
> have modules where there is only rev register and no
> SYSC_SYSCONFIG. So not using legacy mode. The
> above offset with -ENODEV value will not work :)
> 
> I added some more checks and moved them to the reset
> function.

Great. Thanks for the fix.

Thanks,
Faiz
