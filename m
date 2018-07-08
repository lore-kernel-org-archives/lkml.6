Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856F6C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 12:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28DD82089B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 12:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="h4D0fMpG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28DD82089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754290AbeGHMqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 08:46:53 -0400
Received: from mail-eopbgr70103.outbound.protection.outlook.com ([40.107.7.103]:42726
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932380AbeGHMqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 08:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4Jxwqzd5A0ahk0Uz1p1Qh1gIKpuJx9cviQkR9Assm8=;
 b=h4D0fMpGqbDdNDckeDe/GqwhKYYpVVWczbXPjj+SVQE5dzjgSd75A6WktVahHAV8RFCFw5DLNUEUNMyGc79O7/Mc4GrD8sWgbhMbFM5XK0RUtjygdzRm1zxh0lSsYBfl6lOR4/+k2xWlKV4eYYaTsV13dpQ0SC0y9crw0JzGMSw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 AM5PR0201MB2449.eurprd02.prod.outlook.com (2603:10a6:203:34::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21; Sun, 8 Jul
 2018 12:46:47 +0000
Subject: Re: [PATCH v2 2/3] i2c: Add helper to ease DMA handling
From:   Peter Rosin <peda@axentia.se>
To:     Jun Gao <jun.gao@mediatek.com>, Wolfram Sang <wsa@the-dreams.de>
Cc:     srv_heupstream@mediatek.com, devicetree@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <1530955795-17714-1-git-send-email-jun.gao@mediatek.com>
 <1530955795-17714-3-git-send-email-jun.gao@mediatek.com>
 <eb0a3e62-3efb-3862-3da5-bdf2952a146c@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <b95b8d38-5b0d-7517-f7d9-bea1c7f1408d@axentia.se>
Date:   Sun, 8 Jul 2018 14:46:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <eb0a3e62-3efb-3862-3da5-bdf2952a146c@axentia.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0341.eurprd05.prod.outlook.com
 (2603:10a6:7:92::36) To AM5PR0201MB2449.eurprd02.prod.outlook.com
 (2603:10a6:203:34::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81fe1bd3-220c-41b9-570a-08d5e4d0de38
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2449;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;3:vpauRVMlfhVBqvz5/b50yASbgQbq3uKoh0UrFSSJIx/Cs7dnkCMreNav9LUfsqE6q+DMJkgz7W7sUVr0woo8U5YreuoBzEJk4FsnAsVCKDWihA4g8vMXJkuS+5rV8HiVUnAES34wQwP+E1bpp1rvRair1LPiAhJlCch3NOHOlcdeLvHRiWbqZAip1K5lhQDbQDOxeqN5u8LCKw3RwvLewGQbRFch+zKoIKfBTmionku8B9nsmVxerQxNupkNeJkq;25:JEiOR+HYDgyfM+YqWM+F4NXoaFLWsg+R+jYRZIglk/OM5qXH0DqezjyKs1MSYxYQZqZjxSYCzB5/Z7YYHoTqo6kKzIDTf9SMJjZp0s6VwikA4bc4wFuwNqQaLcM1+UgBuAG8mwacSyTFYE6IeSuvbktZv6YDjJ2BIJJslWpy7WD2WdmfzmWoEr4Yn+YW+H7mch0Etpsz6bY8WWEj/R6F0sfl2T8d+ZFhsYSJkRrYnzMh8amVEl+oUoGuen9jT9dpD1WxxpnVxeV9KSEI2xRRp1eg/KzNLGlLxv0G/2zf4SvlvykTiPVVzIRC2zBIsJLgjQTA4PfrRuSPsMSwZwEZdg==;31:ZUCIdMneP4cdNPNNB/NYbCoj7SeyER2gU/ChBnU6UjGw9iFkUSW3BMYjs34D5M6jmhPR3wbK9wvtPbwttGcDcWngzzLQOxUOa8ZpJmiHTDMxfjLIcqAhaA5YmuTFBVzjcwMhkBKlOP3awdit6XKrDV496ARZfMQifCMBF8htcRPr3veIdP8UzN71YVvvA/5NWkd1b2/JGnTgp1Ax1xVqb++GOMfciA5xp7V3CkfxtAg=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2449:
X-Microsoft-Antispam-PRVS: <AM5PR0201MB2449028BA6DFEBE895B875EABC450@AM5PR0201MB2449.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6043046)(6072148)(201708071742011)(7699016);SRVR:AM5PR0201MB2449;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2449;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;4:Q3JZ4I8LbXyxsW5g6iRY9R04B0gXHGiy2rEa5ThGTvVV7B0DhFFeK2GSYBEFHsi+BrthmVf4Veqf8VGHLiUXLJqM7eDLNwzLTJPFWzdDCWb6OPcuiOhvV8ARhzYTIuTSh8Og2kKpEJcV+yWucS4Zp3h4YUehHOHbx4zHVSArCUxaxGocNcWOU5dkKrmKEZy4BFY3HJX09EIK5eADmEiNmf+anQiVa2v7ycm1pSBH8vP3B6k3dcpoLgw1jVuzpvVd8iGp6bTpmaHd32v2vKU1HA==
X-Forefront-PRVS: 0727122FC6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(136003)(396003)(376002)(366004)(39830400003)(346002)(199004)(189003)(2616005)(476003)(50466002)(230700001)(3846002)(6116002)(316002)(58126008)(105586002)(6246003)(446003)(16576012)(2906002)(110136005)(52116002)(2486003)(36916002)(52146003)(23676004)(97736004)(11346002)(117156002)(956004)(16526019)(478600001)(31686004)(3260700006)(25786009)(229853002)(186003)(486006)(26005)(386003)(77096007)(76176011)(53546011)(4326008)(106356001)(31696002)(53936002)(6666003)(6486002)(68736007)(74482002)(8936002)(8676002)(65826007)(305945005)(7736002)(81156014)(65956001)(66066001)(81166006)(5660300001)(86362001)(36756003)(64126003)(47776003)(65806001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2449;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjAyMDFNQjI0NDk7MjM6NG9nMWI0bVVvdGNSSVEzVldKUys0ejI4?=
 =?utf-8?B?SVJzVVRPSDlFK2t0SlNFVitpQUtEUEZpaHFkUTFoSjNjM2ZDS3BkbUlpalBo?=
 =?utf-8?B?dXpNUFlzVGl2bnB1NzhJVTlUS0YzYS9iR2owYlZpbVpTNE92MTNqVEhhVjAx?=
 =?utf-8?B?Kzc5MjFFUmF1a3NHa2l0OW16KzloK2haZ3JDTnNXbWhSMHdlRnpJTW8wUVdT?=
 =?utf-8?B?ekppMHNUcW1QTXpTbzgya1Z2eEVFdVNJdmxQMjM4S3NHVVpselNDcFI5dnlX?=
 =?utf-8?B?cTFjYXdKVFF0dmlRS1JBQ1Z3dnhBVEJwRFhtQ2NqZGNNTFlJUDAzN0pqT0xT?=
 =?utf-8?B?TjNKS0M0eDliWnFVdnNrbXcwbDc4Zmx5U2VzMDV6SEtHWVpBdjlrdmdPVWdF?=
 =?utf-8?B?QmJTc3BoY0l4TWRXdDJRZE1XWVdnU2JnYmtiUGZhQVN2SkxoVVZnNll0WTQ0?=
 =?utf-8?B?SFZCVStlT0RUUlYxVnBjT2pva0tKb0xibk1YcHdMVSs0VHFhRUJrNUdCaGh4?=
 =?utf-8?B?WlNhQXJQaVhxZUhJZ0JobnJBOEQyWXI5cFh3VjVma0ptME9hYTFjSmViWDNk?=
 =?utf-8?B?VDBZWXlDcmxSK25rQ2hwMm9MQ3NCVmxmV1pXVEJZellLdjBKQllCTHZTbGh2?=
 =?utf-8?B?TGYrVm00WVptUnExc2ZqTUVyL3phclFwNXRXakQwdExWUjlpUDFyTmwyVUJ6?=
 =?utf-8?B?NW9QOXhLVlQwZE5nU05ucEdBTkNvelh2cDUxRGxqT3NuZ1JPNUZ5bkRMUzV4?=
 =?utf-8?B?aURFT2VadWNVZElkU3A5Z3NsaktPNjFVZWZrbW1IcnZZZERkaXJQa2xZdmJz?=
 =?utf-8?B?eG8vQlovNy9UbStPMHdUcm5Qemp0TXV2VWo1MUppV1hyYTI3Q2dtTTU5bVd5?=
 =?utf-8?B?QlIzYjVqOUZJOS9nY09ad1IyQnFJY3ZhcGRTbUdDTlBvdmZ6OFQ2WElIUFNa?=
 =?utf-8?B?aVNKWWNKV2NPY0FUWEJIdHZSU3ErOS9oL0dKT3E0T1N3RU1SNC9UVERrYTFz?=
 =?utf-8?B?elAzR0J0MXprS29LWlhJclh0S0FSdjMycXhRc1g5RGFCaVp3QWxBL0F1ejRq?=
 =?utf-8?B?bkpyVC93RmdZKzI3TDY2UWVXYkZoZ2QwLzFVN1ZWdjdxYmhHeU5ha0MreHdx?=
 =?utf-8?B?V0o1Znd6aUpYMjNIaUk0ek5jV3lHdGViNUNhMjBsRHJmZW1CUzdrdE5MRTZQ?=
 =?utf-8?B?VEdSMDNNQUNSMkpUZUtTNjlaMTQ4MkpLa1JTci94Tlo0RkJneU9ZWEQwbHBH?=
 =?utf-8?B?ZnB5U0EwRXlhN0lkN1IxdkdGK0IwbWdKMTI1Q0h3OEtYR0VzZ0p4VWJsVUdN?=
 =?utf-8?B?NmM0MFEzcHZnUkFMbHd1VEhKV2JMcHRUblF0eVBVZmVPRzBWRGxJR3NVLzk2?=
 =?utf-8?B?bnlHL3kzYkVDeDlNUnI2TnhTdHlhWVlVL3B1RU00TllsTU1icm9ZWjF1aEFT?=
 =?utf-8?B?OTRMTXN1Zjl2Ly9lQW9TWWY1eHZZSk50SUs1aUlEcU5SUnJVbndzaXN3T01V?=
 =?utf-8?B?aUhlUzZLNWFFSkttaDJsK0JEN0xPaHVvVG9FNHNrNm91RFNzQ1NhSVRrSG0r?=
 =?utf-8?B?bHY0SlJRVGx4MEZlWGF1MTBobXM0aWlEMnFSdUp0WTVHam8wQTA3SnBCL0Rk?=
 =?utf-8?B?dUhpOWNMYUFMNzNHT2pwdDZyRGY2WDlZUFJSejNIVXU1RytmNHFUZnBTaTd5?=
 =?utf-8?B?UjlraS9FZEFqejlEQmtlTkN3YlZpcStFWmxWN090UGlUZjV6dWJCb2dyclBS?=
 =?utf-8?B?TzhjMXRTRWJZQ3VTM3l6UUQ2eVdYRDk4bVlZUFBlU21CU1dkWGpUaXJGZ0lQ?=
 =?utf-8?B?bWtCQWFrT3dGV2JTWjUrZEtEcWxHeElaeWtNb1RDTTB2dTg3bXhRZXZxOUMz?=
 =?utf-8?B?NkYxRmhQUnIxUVZRMHcrdWdXc2RJSTJRNU5OeGxJbXRVbFZXRERkRmpwMklF?=
 =?utf-8?B?RkUrVFQvTGhuMVZXTnlzTGRIeXQ5aXRuSVArM0xReldnUVhXUDVMaTU5MUlP?=
 =?utf-8?B?WWM3VXozdHJLNFdHUDNIWGFNVys1UFl6WjhzT1lreU1yNHVSSXhVRi9mM3ly?=
 =?utf-8?Q?tXr6y4=3D?=
X-Microsoft-Antispam-Message-Info: cHTGM595cK/hNdeUfUzG3Wvop/oaYlOm5LAITaA/0yjCzVyXzH1u6UTFb1hDSOAXsPtMsK23F2mSGppdtxG81P+yF1NxaJ4CiaqDCwdP+/Oyk8wgTRVNRxw4oQfCthM7mWefzlJxM+Ah1nyrIJpEqsL1a8o+AMautq4FxbxwsoY+YolAjpCptfWxY0WIlHrDILDt7TJgxfi8UKtxZuNLvNUB8h82r8UcBHVJZ3SWudGkepYKoPdkN0f2tgQDysnY258JVxFB/wKmriV9LgEcX1/eRuMMF4EwLMXFTymwVeiw+K7wJ9uai0oTDI1FepchJ9va9AgKW4jyXI13FcgIqHW5K2clgqpZLhGXhzRNxDc=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;6:X4tlAJ3/AQ35TnFFjFaxf5T0MGJD3s29hrRWyl+FjPWZVVTcQDLV6p/OKrc+M7M4gRZ6gMiV9eeRRPDXFdPVnuh+jOj2SUsdrCLhV2G7eT9liJa4qTxP3ibMGcu7Vc+30Ke/QevmRebMAe2d9WyxqsbNBAmoDonkVDngz/NVmIWEa3upTyAlu/nfEEJbMmLyStb1JsyeYAz7dQT6c4HX+CZI7gKamQplC1E56NK3nwLSc2g/vnF7OL5mFt2WfMRRTaFHOsCaR+Yt5JKjov+JDvDptLBbYWcfVhzd+k0KFVbC7kQuT7bqHJKSfjzOSeKaX8sKmSdwxx9IdRY0mZ6iNprEd39BAo61+ToYCLOeen+e7IVOSYCO0YRipcbmbJG7osF0bgpHitHs3bd9bI8ZVRLZbx+nWod+pScwJ8gfOdQ++wzyZMqZTURwBcOf9KT4zFaoW7fB25M8SkOFgwgeSg==;5:0/L/FLdyKCHY+ESFuG/sTDejt7vlZeutCKAZqlxc+WlihexjUhUOVyNL1Cfh56GHxyJ1gYnvoESgk3z/6P32LtvPs0yuUUp84gBcwxxcWQXvy5BOGEQJZQEGj2xVvvj8NVkcf/rbli+4FDdPjhA06ht9ubBHLhw4jSQt6M9ByX0=;24:886jizMwhk1XPKP8GgP8N6wAYw9LjoXvL5Ixdo48MyUP9ODfAvToELWQfPVakdjaD0C+Ts6F8bJuX1spAbEkYwf1wVxD0r3ASD8i1XanoMc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;7:b6J7bXDVEOr0Rl4lz94Wpr/Ye+LJP4XklqhzAjZ4REKYHs7Q7HvODH3IPdPahvvSohCrxCXTbs0KewdFA4baCHpbPdCIZepnncU8Q6IAiquoh18ft9hIl2e/9Gfznw0BoEf7IP9jkmf6mRo0e4VbnYiDOli9vvOmdugQcbyOrXrCTQG/gXMmwZhElA1Dj9LemQwQPxwkYaed08XJ/18laARXsNY0i76d3T14wW921omhiA9q9klJwnb9tySYoTaa
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2018 12:46:47.0093 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81fe1bd3-220c-41b9-570a-08d5e4d0de38
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-08 13:58, Peter Rosin wrote:
> On 2018-07-07 11:29, Jun Gao wrote:
>> From: Jun Gao <jun.gao@mediatek.com>
>>
>> This function is needed by i2c_get_dma_safe_msg_buf() potentially.
>> It is used to free DMA safe buffer when DMA operation fails.
>>
>> Signed-off-by: Jun Gao <jun.gao@mediatek.com>
>> ---
>>  drivers/i2c/i2c-core-base.c | 14 ++++++++++++++
>>  include/linux/i2c.h         |  1 +
>>  2 files changed, 15 insertions(+)
>>
>> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
>> index 31d16ad..2b518ea 100644
>> --- a/drivers/i2c/i2c-core-base.c
>> +++ b/drivers/i2c/i2c-core-base.c
>> @@ -2288,6 +2288,20 @@ void i2c_release_dma_safe_msg_buf(struct i2c_msg *msg, u8 *buf)
>>  }
>>  EXPORT_SYMBOL_GPL(i2c_release_dma_safe_msg_buf);
>>  
>> +/**
>> + * i2c_free_dma_safe_msg_buf - free DMA safe buffer
>> + * @msg: the message related to DMA safe buffer
>> + * @buf: the buffer obtained from i2c_get_dma_safe_msg_buf(). May be NULL.
>> + */
>> +void i2c_free_dma_safe_msg_buf(struct i2c_msg *msg, u8 *buf)
>> +{
>> +	if (!buf || buf == msg->buf)
>> +		return;
>> +
>> +	kfree(buf);
> 
> Considering that the i2c-core-smbus.c file does the following for its
> DMA safe buffers...
> 
> static void i2c_smbus_try_get_dmabuf(struct i2c_msg *msg, u8 init_val)
> {
> 	bool is_read = msg->flags & I2C_M_RD;
> 	unsigned char *dma_buf;
> 
> 	dma_buf = kzalloc(I2C_SMBUS_BLOCK_MAX + (is_read ? 2 : 3), GFP_KERNEL);
> 	if (!dma_buf)
> 		return;
> 
> 	msg->buf = dma_buf;
> 	msg->flags |= I2C_M_DMA_SAFE;
> 
> 	if (init_val)
> 		msg->buf[0] = init_val;
> }
> 
> ...I do not think your variant of i2c_release_dma_safe_msg_buf is
> appropriate for the i2c-core-base.c file. It's simply not possible to have
> central knowledge of the rules for when to free the buffer, and encoding one
> set of rules is only confusing (when there are more than one set of rules).
> I suggest that you make your variant driver specific.

Ignore me. Your i2c_free_dma_safe_msg_buf is of course compatible with
the existing i2c_smbus_try_get_dmabuf. Sorry for the noise.

Cheers,
Peter

( However, the naming of these two functions are not really consistent... )

> Cheers,
> Peter
> 
>> +}
>> +EXPORT_SYMBOL_GPL(i2c_free_dma_safe_msg_buf);
>> +
>>  MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
>>  MODULE_DESCRIPTION("I2C-Bus main module");
>>  MODULE_LICENSE("GPL");
>> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
>> index 254cd34..6d62f93 100644
>> --- a/include/linux/i2c.h
>> +++ b/include/linux/i2c.h
>> @@ -860,6 +860,7 @@ static inline u8 i2c_8bit_addr_from_msg(const struct i2c_msg *msg)
>>  
>>  u8 *i2c_get_dma_safe_msg_buf(struct i2c_msg *msg, unsigned int threshold);
>>  void i2c_release_dma_safe_msg_buf(struct i2c_msg *msg, u8 *buf);
>> +void i2c_free_dma_safe_msg_buf(struct i2c_msg *msg, u8 *buf);
>>  
>>  int i2c_handle_smbus_host_notify(struct i2c_adapter *adap, unsigned short addr);
>>  /**
>>
> 

