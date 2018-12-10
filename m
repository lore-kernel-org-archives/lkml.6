Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9779C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A9120865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A9120865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=electromag.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbeLJIZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 03:25:58 -0500
Received: from anchovy2.45ru.net.au ([203.30.46.146]:42229 "EHLO
        anchovy2.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeLJIZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 03:25:57 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Dec 2018 03:25:57 EST
Received: (qmail 16128 invoked by uid 5089); 10 Dec 2018 08:19:16 -0000
Received: by simscan 1.2.0 ppid: 15968, pid: 15969, t: 0.0583s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
Received: from unknown (HELO ?192.168.0.122?) (preid@electromag.com.au@203.59.235.95)
  by anchovy3.45ru.net.au with ESMTPA; 10 Dec 2018 08:19:16 -0000
Subject: Re: [PATCH V2] iio: magnetometer: mag3110: add optional vdd/vddio
 regulator operation support
To:     Anson Huang <anson.huang@nxp.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1544425869-8188-1-git-send-email-Anson.Huang@nxp.com>
From:   Phil Reid <preid@electromag.com.au>
Message-ID: <71e3e6b1-0821-aff9-df58-7f4425c3c75a@electromag.com.au>
Date:   Mon, 10 Dec 2018 16:19:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1544425869-8188-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

G'day Anson,

On 10/12/2018 3:17 PM, Anson Huang wrote:
> The magnetometer's power supply could be controlled by regulator
> on some platforms, such as i.MX6Q-SABRESD board, the mag3110's
> power supply is controlled by a GPIO fixed regulator, need to make
> sure the regulator is enabled before any communication with mag3110,
> this patch adds optional vdd/vddio regulator operation support.
> 

[snip]

> +
> +	data->vdd_reg = devm_regulator_get_optional(&client->dev, "vdd");
> +	if (!IS_ERR(data->vdd_reg)) {
> +		ret = regulator_enable(data->vdd_reg);
> +		if (ret) {
> +			dev_err(&client->dev, "failed to enable VDD regulator\n");
> +			return ret;
> +		}
> +	} else if (data->vdd_reg == ERR_PTR(-EPROBE_DEFER)) {
> +		return -EPROBE_DEFER;
> +	}
> +
IANAE, but normally the return pattern for devm_regulator_get_optional

if (!IS_ERR(reg)) {
     regulator_enable ...
} else {
     ret = PTR_ERR(reg);
     if (ret != -ENODEV)
         return ret;
}



-- 
Regards
Phil
