Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80880C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE50208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qCK4huLV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AE50208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731931AbeGaLpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:45:30 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56038 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbeGaLpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:45:30 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6VA4ehr011625;
        Tue, 31 Jul 2018 05:04:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1533031480;
        bh=Oyh4vvZyi4HJFAzG7qfLiCI4dKmRvIgfJ4oKrnmBUgw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=qCK4huLVkGcj4GqC9fqquYcOS/y4dfaMPLaVhufyG52hRv6dK4sIMyHYhPKartY7+
         KXO1xwj5GT6k2zKGk31OgHsHsiuTeOvO87x6pSWK12rEg1VljGZk2dXylwLMttxNVs
         gluE60pnAiobhCMN0aVxKpB8JJCFFJmKkS0Rk6Nc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6VA4eHl012361;
        Tue, 31 Jul 2018 05:04:40 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 31
 Jul 2018 05:04:39 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 31 Jul 2018 05:04:39 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6VA4Xqh019783;
        Tue, 31 Jul 2018 05:04:34 -0500
Subject: Re: [PATCH v7 1/4] remoteproc/davinci: use the reset framework
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
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
 <20180621073706.22812-2-brgl@bgdev.pl> <20180731042539.GE5090@builder>
 <CAMRc=MdwCruRZ_EQ3Pzq-=HdhiA6pfSZczRKMa5i9Rju0JgHig@mail.gmail.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <c3484965-1efe-2425-86e0-ecb78ea189dd@ti.com>
Date:   Tue, 31 Jul 2018 15:34:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAMRc=MdwCruRZ_EQ3Pzq-=HdhiA6pfSZczRKMa5i9Rju0JgHig@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn,

On Tuesday 31 July 2018 01:25 PM, Bartosz Golaszewski wrote:
> 2018-07-31 6:25 GMT+02:00 Bjorn Andersson <bjorn.andersson@linaro.org>:
>> On Thu 21 Jun 00:37 PDT 2018, Bartosz Golaszewski wrote:
>>
>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> Switch to using the reset framework instead of handcoded reset routines
>>> we used so far.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>> Reviewed-by: Sekhar Nori <nsekhar@ti.com>
>>> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
>>
>> Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>
> 
> Sekhar,
> 
> can you take this through your tree or is it already too late?

The last -rc is already tagged and I am not sure ARM-SoC will be open to
new stuff now (there is also a bit of lag after I send my pull request).

Is this something you can take in your tree along with Suman's patch?

There are no build dependencies with my tree, so it will be safe to
queue from your tree. It will be great if this can be merged late in the
cycle though to avoid breaking remoteproc even for short while during
the merge window.

Or if you okay with it, it will be safest to send it soon after
v4.19-rc1 is tagged.

Let me know.

Thanks,
Sekhar
