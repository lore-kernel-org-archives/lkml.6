Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13646C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 10:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC5621581
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 10:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC5621581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbeHON0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 09:26:23 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43188 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728838AbeHON0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 09:26:23 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id C9CFA261A20
Subject: Re: [PATCH 3/4] phy: rockchip-inno-usb2: allow to force the B-Device
 Session Valid bit.
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-kernel@vger.kernel.org, amstan@chromium.org,
        groeck@google.com, kieran.bingham@ideasonboard.com,
        kernel@collabora.com, bleung@chromium.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20180815095934.11205-1-enric.balletbo@collabora.com>
 <20180815095934.11205-4-enric.balletbo@collabora.com>
 <2209969.yNeHebgXRl@phil>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <72ca2b54-785c-8fe3-b472-5b8837afe00a@collabora.com>
Date:   Wed, 15 Aug 2018 12:34:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2209969.yNeHebgXRl@phil>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On 15/08/18 12:18, Heiko Stuebner wrote:
> Hi Enric,
> 
> Am Mittwoch, 15. August 2018, 11:59:33 CEST schrieb Enric Balletbo i Serra:
>> The OTG disconnection event is generated after the presence/abscense of
>> an ID connection, but some platforms doesn't have the ID pin connected, so
>> the event is not generated. In such case, for detecting the disconnection
>> event, we can get the cable state from an extcon driver. We need, though,
>> to force to set the B-Device Session Valid bit on the PHY to have the
>> device respond to setup address. Otherwise, the following error is
>> shown:
>>
>>     usb 2-2: Device not responding to setup address.
>>     usb 2-2: device not accepting address 14, error -71
>>     usb usb2-port2: unable to enumerate USB device
>>
>> The patch allows to tell the PHY to force the B-Device Session Valid bit
>> when the OTG role is device and clear that bit if the OTG role is host.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
>> @@ -1024,6 +1051,12 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
>>  	INIT_DELAYED_WORK(&rport->chg_work, rockchip_chg_detect_work);
>>  	INIT_DELAYED_WORK(&rport->otg_sm_work, rockchip_usb2phy_otg_sm_work);
>>  
>> +	rport->force_bvalid = false;
>> +	if (of_device_is_compatible(rphy->dev->of_node,
>> +				    "rockchip,rk3399-usb2phy"))
>> +		rport->force_bvalid = of_property_read_bool(child_np,
>> +						"rockchip,force-bvalid");
> 
> That feels a bit clumsy, especially as the rk3399 seems to have the id

Agree, It is, let me explain :)

Ideally we shouldn't have this check, to get rid of this check I only need the
offsets for bvalid_session register for all the compatibles and fill in phy
configuration data (rk3228_phy_cfgs, &rk3328_phy_cfgs, rk3366_phy_cfgs,
rv1108_phy_cfgs)

To be honest I didn't look if all the datasheets are public available, let me do
some research. Or, if anyone has the datasheet and can tell where the
bvalid_session bit is I can fill all the data.

Best regards,
 Enric

> connection in general ... maybe you could just make that conditional
> on the presence of the extcon?
> 
> Or alternatively if needed put that in the soc-specific data struct we
> have already instead open-coding soc compatible checks.
> 
> Heiko
> 
> 
> 
