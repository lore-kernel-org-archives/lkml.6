Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520F3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253AB2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfBSDUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 22:20:21 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:37004 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725861AbfBSDUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 22:20:21 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 50A2DBEC831247312DA2;
        Tue, 19 Feb 2019 11:20:18 +0800 (CST)
Received: from [127.0.0.1] (10.142.63.192) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Feb 2019
 11:20:09 +0800
CC:     <liuyu712@hisilicon.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <john.stultz@linaro.org>, <suzhuangluan@hisilicon.com>,
        <kongfei@hisilicon.com>, <wanghu17@hisilicon.com>,
        <butao@hisilicon.com>, <chenyao11@huawei.com>,
        <fangshengzhou@hisilicon.com>, <lipengcheng8@huawei.com>,
        <songxiaowei@hisilicon.com>, <xuyiping@hisilicon.com>,
        <xuyoujun4@huawei.com>, <yudongbin@hisilicon.com>,
        <zangleigang@hisilicon.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2 08/10] hikey960: Support usb functionality of Hikey960
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
References: <20190218112310.17860-1-chenyu56@huawei.com>
 <20190218112310.17860-9-chenyu56@huawei.com>
 <1550544615.2210.27.camel@mhfsdcap03>
From:   Chen Yu <chenyu56@huawei.com>
Message-ID: <c02407b4-1825-83f5-2aff-dd41ae16e2ab@huawei.com>
Date:   Tue, 19 Feb 2019 11:20:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1550544615.2210.27.camel@mhfsdcap03>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.63.192]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2019/2/19 10:50, Chunfeng Yun wrote:
>> +	if (ret)
>> +		hisi_hikey_usb->typec_vbus_enable_val = 1;
>> +
>> +	hisi_hikey_usb->typec_vbus = devm_gpiod_get(dev, "typec-vbus",
>> +			hisi_hikey_usb->typec_vbus_enable_val ?
>> +			GPIOD_OUT_LOW : GPIOD_OUT_HIGH);
>> +	if (!hisi_hikey_usb->typec_vbus)
>> +		return -ENOENT;
>> +	else if (IS_ERR(hisi_hikey_usb->typec_vbus))
>> +		return PTR_ERR(hisi_hikey_usb->typec_vbus);
>> +
>> +	gpiod_direction_output(hisi_hikey_usb->typec_vbus,
>> +			!hisi_hikey_usb->typec_vbus_enable_val);
> maybe a simple way if use fixed regulator?
> 
The hardware of the Hikey960 board has been fixed, and the type-c
port can act as UFP. So it is better to close the vbus when Hikey960
connect to host(e.g PC).
>> +
>> +	hisi_hikey_usb->otg_switch = devm_gpiod_get(dev, "otg-switch", GPIOD_IN);
>> +	if (!hisi_hikey_usb->otg_switch)
>> +		return -ENOENT;
>> +	else if (IS_ERR(hisi_hikey_usb->otg_switch))
>> +		return PTR_ERR(hisi_hikey_usb->otg_switch);
>> +
>> +	gpiod_direction_output(hisi_hikey_usb->otg_switch, USB_SWITCH_TO_HUB);
>> +
>> +	/* hub-vdd33-en is optional */
>> +	hisi_hikey_usb->hub_vbus = devm_gpiod_get(dev, "hub-vdd33-en",
>> +			GPIOD_OUT_LOW);
>> +	if (IS_ERR(hisi_hikey_usb->hub_vbus))
>> +		return PTR_ERR(hisi_hikey_usb->hub_vbus);
>> +
>> +	gpiod_direction_output(hisi_hikey_usb->hub_vbus, HUB_VBUS_POWER_ON);
> ditto
>> +
>> +	hisi_hikey_usb->role_sw = usb_role_switch_get(dev);
>> +	if (!hisi_hikey_usb->role_sw)
>> +		return -EPROBE_DEFER;
>> +	else if (IS_ERR(hisi_hikey_usb->role_sw))
>> +		return PTR_ERR(hisi_hikey_usb->role_sw);
>> +

Thanks
Yu Chen

