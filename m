Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C571AC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7009420873
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="upVYxbRV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7009420873
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbeIDTDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:03:54 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55580 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeIDTDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:03:54 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w84EcPEE079886;
        Tue, 4 Sep 2018 09:38:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536071905;
        bh=1rvnRy8y4a5TlsSopzolXkfmgBurCPjaSk4EDAO2qNA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=upVYxbRVrS73i93bFbPrB6JAWQDvpvN0m8EpR3VJs5NktxcxAsTwdu8y3YaE0d4j9
         L+O4mvpxOtuIuIlDWvSPGhQbFB6h9+mpgBbD6WMagJditrUG/VxK6ns8b3vrTcv0/0
         BhaofXa0AYguiNUnlHtcOfiBG0uCeynNsrw9grRo=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w84EcPX3028409;
        Tue, 4 Sep 2018 09:38:25 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 4 Sep
 2018 09:38:25 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 4 Sep 2018 09:38:25 -0500
Received: from [172.22.184.106] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w84EcOmZ005709;
        Tue, 4 Sep 2018 09:38:24 -0500
Subject: Re: [PATCH 2/4] ASoC: tlv320aic31xx: Add overflow detection support
To:     Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
References: <20180831182434.14499-1-afd@ti.com>
 <20180831182434.14499-2-afd@ti.com> <20180903130318.GH10302@sirena.org.uk>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <274b9d82-542b-dbf7-94e2-a61bc6eb2bbc@ti.com>
Date:   Tue, 4 Sep 2018 09:38:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180903130318.GH10302@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2018 08:03 AM, Mark Brown wrote:
> On Fri, Aug 31, 2018 at 01:24:32PM -0500, Andrew F. Davis wrote:
>> Similar to short circuit detection, when the ADC/DAC is saturated and
>> overflows poor audio quality can result and should be reported to the
>> user. This device support Automatic Dynamic Range Compression (DRC)
>> to reduce this but it is not enabled currently in this driver.
> 
>> +	if (value & AIC31XX_DAC_OF_LEFT)
>> +		dev_err(dev, "Left-channel DAC overflow has occurred\n");
>> +	if (value & AIC31XX_DAC_OF_RIGHT)
>> +		dev_err(dev, "Right-channel DAC overflow has occurred\n");
> 
> So, this will sound terrible but I'm not sure that unconditionally
> shouting in the logs is the right thing to do here - people do sometimes
> put non-audio signals through sound cards (using them as generic DACs
> and ADCs) and it seems like it could get very spammy.  Perhaps a lower
> level warning message, some counters or even some control that allows
> the warnings to be masked.
> 

As these events do not stop the function of the sound card, I agree
warnings would be more appropriate than errors, I'll make that change.

Andrew
