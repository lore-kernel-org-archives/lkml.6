Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C91FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34680208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="D0VnC4a9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34680208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbeK0UAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:00:10 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:60766 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729760AbeK0UAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:00:09 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id E6EC910C083B;
        Tue, 27 Nov 2018 01:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1543309376; bh=HFk6vi0/A8c5OLV6u2kjHgSelP6afBiO3DTyY1KKo0U=;
        h=Subject:To:References:CC:From:Date:In-Reply-To:From;
        b=D0VnC4a93Bi+s2qrRGT70b5wFMa13IU9G85yW5YYjnC8cuD5miMrwH24+Xvo1h5Nu
         FLM7QlXrAflKqsPmcwh5Cnf8ZZVZY4Utf2DmxOrhkMtgImB9TvOLzrweU7zPC2jPOV
         1kU0IvE/RK7ZkzAHOb1GPKe3z+CiBEMMIWvK/MOgV45hEXlnqfv0wLKUT75IUWPZly
         H0zRfp52VZHVi5wrUPrPqRKm0NrQ/mZma/ikoCXwJ4Xoj+z5Shitbtv2Tkbt4GMowF
         hMHJAv8buuejqqjUeNVy1k4ATun28y0CPdRa5Z9Ov7ZmViYdZM7eHt187AerZ7dAsq
         nzqIyCvimzn1g==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 7D463399D;
        Tue, 27 Nov 2018 01:02:56 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 27 Nov 2018 01:02:56 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 27 Nov 2018 10:02:54 +0100
Received: from [10.0.2.15] (10.107.19.26) by DE02WEHTCB.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 27 Nov
 2018 10:02:53 +0100
Subject: Re: [PATCH] net: stmmac: Move debugfs init/exit to
 ->probe()/->remove()
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jose Abreu <jose.abreu@synopsys.com>
References: <20181123122122.18957-1-thierry.reding@gmail.com>
 <9c8443aa-edaa-2398-bdd8-df49f2529cb6@synopsys.com>
 <20181126153419.GD19710@ulmo>
CC:     "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <netdev@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Jose Abreu <jose.abreu@synopsys.com>
Message-ID: <3f5ef823-4683-04f8-5f3a-0ccfdb472d6d@synopsys.com>
Date:   Tue, 27 Nov 2018 09:02:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20181126153419.GD19710@ulmo>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.26]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-11-2018 15:34, Thierry Reding wrote:
> On Fri, Nov 23, 2018 at 12:44:02PM +0000, Jose Abreu wrote:
>> On 23-11-2018 12:21, Thierry Reding wrote:
>>> From: Thierry Reding <treding@nvidia.com>
>>>
>>> Setting up and tearing down debugfs is current unbalanced, as seen by
>>> this error during resume from suspend:
>>>
>>>     [  752.134067] dwc-eth-dwmac 2490000.ethernet eth0: ERROR failed to create debugfs directory
>>>     [  752.134347] dwc-eth-dwmac 2490000.ethernet eth0: stmmac_hw_setup: failed debugFS registration
>>>
>>> The imbalance happens because the driver creates the debugfs hierarchy
>>> when the device is opened and tears it down when the device is closed.
>>> There's little gain in that, and it could be argued that it is even
>>> surprising because it's not usually done for other devices. Fix the
>>> imbalance by moving the debugfs creation and teardown to the driver's
>>> ->probe() and ->remove() implementations instead.
>>>
>>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>>> ---
>>>
>> Did you test trying to dump "descriptors_status" file when
>> interface is not open ? I think that's the main reason why this
>> is not in probe ...
> Indeed, that seems to cause a hang. Still, it doesn't sound like the
> right things to repeatedly create and remove debugfs files just because
> we can't provide the contents when the device is down.

Agree.

>
> How about we return an empty file or an error code instead when the
> interface is down?

I think an error code would be more suitable (ENODEV/EBUSY ?).
Can you submit v2 ?

Thanks and Best Regards,
Jose Miguel Abreu

>
> Thierry

