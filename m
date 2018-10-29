Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76644C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C112082B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C112082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbeJ2VLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:11:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39175 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729146AbeJ2VLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 17:11:08 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7D5E2464CC16B;
        Mon, 29 Oct 2018 20:22:36 +0800 (CST)
Received: from [127.0.0.1] (10.142.63.192) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Mon, 29 Oct 2018
 20:22:29 +0800
CC:     <wangbinghui@hisilicon.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <suzhuangluan@hisilicon.com>, <kongfei@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Tsai <lucas_tsai@richtek.com>,
        shufan_lee <shufan_lee@richtek.com>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 08/10] usb: typec: Add support for usb role switch in
 rt1711h driver
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <20181027095820.40056-1-chenyu56@huawei.com>
 <20181027095820.40056-9-chenyu56@huawei.com>
 <20181029115813.GA14534@kuha.fi.intel.com>
From:   Chen Yu <chenyu56@huawei.com>
Message-ID: <d3268b28-db8c-fb1d-5cc4-5226c4181a2d@huawei.com>
Date:   Mon, 29 Oct 2018 20:22:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20181029115813.GA14534@kuha.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.142.63.192]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/10/29 19:58, Heikki Krogerus wrote:
> On Sat, Oct 27, 2018 at 05:58:18PM +0800, Yu Chen wrote:
>> This patch add struct device_connection to rt1711h driver to support
>> find "usb-role-switch" in tcpm_register_port.
>>
>> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Lucas Tsai <lucas_tsai@richtek.com>
>> Cc: shufan_lee <shufan_lee@richtek.com>
>> Cc: John Stultz <john.stultz@linaro.org>
>> Cc: Binghui Wang <wangbinghui@hisilicon.com>
>> Signed-off-by: Yu Chen <chenyu56@huawei.com>
>> ---
>>  drivers/usb/typec/tcpm/tcpci_rt1711h.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
>> index 017389021b96..5f8b952612fe 100644
>> --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
>> +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
>> @@ -39,6 +39,7 @@ struct rt1711h_chip {
>>  	struct tcpci_data data;
>>  	struct tcpci *tcpci;
>>  	struct device *dev;
>> +	struct device_connection dev_conn;
>>  };
>>  
>>  static int rt1711h_read16(struct rt1711h_chip *chip, unsigned int reg, u16 *val)
>> @@ -237,6 +238,7 @@ static int rt1711h_probe(struct i2c_client *client,
>>  {
>>  	int ret;
>>  	struct rt1711h_chip *chip;
>> +	const char *dev_conn_end;
>>  
>>  	ret = rt1711h_check_revision(client);
>>  	if (ret < 0) {
>> @@ -254,6 +256,7 @@ static int rt1711h_probe(struct i2c_client *client,
>>  		return PTR_ERR(chip->data.regmap);
>>  
>>  	chip->dev = &client->dev;
>> +	dev_set_name(chip->dev, "rt1711h");
>>  	i2c_set_clientdata(client, chip);
>>  
>>  	ret = rt1711h_sw_reset(chip);
>> @@ -264,6 +267,15 @@ static int rt1711h_probe(struct i2c_client *client,
>>  	if (ret < 0)
>>  		return ret;
>>  
>> +	ret = device_property_read_string(chip->dev, "dev-conn-end",
>> +			&dev_conn_end);
>> +	if (!ret) {
>> +		chip->dev_conn.endpoint[0] = "rt1711h";
>> +		chip->dev_conn.endpoint[1] = dev_conn_end;
>> +		chip->dev_conn.id = "usb-role-switch";
>> +		device_connection_add(&chip->dev_conn);
>> +	}
> That is wrong. You should not read name of a device from a property.
>
> Regardless of that, I don't think this patch is needed at all. You
> need to describe this kind connection with OF device graph
> (Documentation/devicetree/bindings/graph.txt).
>
> I've prepared a proposal how we should be able handle graphs in the
> device connection API:
> https://lkml.org/lkml/2018/10/24/613
I will fix this patch. Thanks!
>
> thanks,
>


