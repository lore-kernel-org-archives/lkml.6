Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC88BC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E581253D5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="w67KkN6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E581253D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752073AbeGBMJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:09:48 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46428 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932944AbeGBMJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:09:38 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w62C8VwA068286;
        Mon, 2 Jul 2018 07:08:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530533311;
        bh=tygW0TW0FOu3iHSlexpm+CLFV/TQRP5bxqTXwMAdO3g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=w67KkN6cv2lDJhQXnBk+F93V+lzVhgi6Ylb3Xail03WigncMKFkBRk+GLYXG5YDgP
         HhI/s2k81Wl6+rwSZ6nNmk7uGFKpu7NBYuFPxqWJp9QcbZSNFZfFXUfMOsjt8WmF5M
         6yECYF5g86hFrHOASWYE6vjE2V7nfdFLw00OloIQ=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w62C8VP0008478;
        Mon, 2 Jul 2018 07:08:31 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 2 Jul
 2018 07:08:31 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 2 Jul 2018 07:08:31 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w62C8OGI027697;
        Mon, 2 Jul 2018 07:08:25 -0500
Subject: Re: [PATCH v7 0/4] ARM: davinci: complete the conversion to using the
 reset framework
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
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
 <9ec10627-49a5-07ad-8c9d-5ac873096cc0@ti.com>
 <CAMRc=Me1JTuw40tMWaai2oKMxmc_ktN2OKBhF8tmGt0cQ6magg@mail.gmail.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <e4bd9f57-617a-a59e-5d05-be1a6b3e6b3d@ti.com>
Date:   Mon, 2 Jul 2018 17:38:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAMRc=Me1JTuw40tMWaai2oKMxmc_ktN2OKBhF8tmGt0cQ6magg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Thursday 21 June 2018 05:11 PM, Bartosz Golaszewski wrote:
> 2018-06-21 12:52 GMT+02:00 Sekhar Nori <nsekhar@ti.com>:
>> Hi Bartosz,
>>
>> On Thursday 21 June 2018 01:07 PM, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> These are the remaining patches that still need to be merged in order
>>> to complete the conversion of the davinci dsp driver to using the reset
>>> framework.
>>>
>>> They apply on top of v4.18-rc1 with David Lechner's remaining patches
>>> merged.
>>
>> Series looks good to me.
>>
>> To preserve bisect, shouldn't the order of applying be patch #3, #4, #1
>> and #2 ?
>>
>> Given the dependencies and to preserve bisect its easiest if I take the
>> series with acks from remoteproc and clock maintainers.
>>
>> Open to other suggestions as well.
>>
>> Thanks,
>> Sekhar
> 
> Oops you're right about the order. Do you want me to resend?

With your ack, I can queue 1/4 for v4.19 and provide an immutable commit
to you (on top of v4.18-rc1) for you to merge any further changes you
want to queue from your tree.

Bartosz, given the number of moving pieces, I think its better to keep
2/4 for v4.20 release - once all other other dependencies have been merged.

Thanks,
Sekhar
