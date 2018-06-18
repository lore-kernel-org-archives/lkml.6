Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545FCC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9202086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="JmLwCCi8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9202086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934354AbeFRLdE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:33:04 -0400
Received: from mail-eopbgr80134.outbound.protection.outlook.com ([40.107.8.134]:65248
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933337AbeFRLc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5V4DIdOzbx2bCgXwjuo7mL6VF0eWlKRiQUD76r0qUsA=;
 b=JmLwCCi8MG6T3quiY0ESOuavSiUqDlOHGR3TpVXnE6fI7PUcM+iE48dBpE+dit/wxyNNbE0dJdQKW9nuDNUpSZwP6458O7rnyEXPRWxelozx3cFlx6qYX6X22Hl8X2paB74Ub0NPpRpCe9ZyYXtZcVZsJrO42NSdl7/sKpWbqrk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 VI1PR0201MB2463.eurprd02.prod.outlook.com (2603:10a6:800:54::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.820.15; Mon, 18 Jun
 2018 11:32:52 +0000
Subject: Re: [PATCH 01/11] i2c: add helpers for locking the I2C segment
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Guenter Roeck <linux@roeck-us.net>, Crt Mori <cmo@melexis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Krufky <mkrufky@linuxtv.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-integrity@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-media@vger.kernel.org
References: <20180615101506.8012-1-peda@axentia.se>
 <20180615101506.8012-2-peda@axentia.se>
 <20180618110502.cb5s24srp4frahm6@ninjato>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <b860025e-3d4b-f333-80b4-3831dd969757@axentia.se>
Date:   Mon, 18 Jun 2018 13:32:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180618110502.cb5s24srp4frahm6@ninjato>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0502CA0013.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::23) To VI1PR0201MB2463.eurprd02.prod.outlook.com
 (2603:10a6:800:54::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea2ce1c3-a5cb-45c0-6e1d-08d5d50f3c5a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2463;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2463;3:mgIMjzOokgX9tAJsMQhIO3FbQ8bjFoh2Tvirqob2ZiiSOgpTYoqwS2HtxzrdZQaUYAd9sX7clOfnke3rTLVRKg8LbP91gKktewYFk6Pfi6MQRyJ0ilGXfxPfSoi/DN9scwveH0GDV41dhM7TzXB62whRvpCnrtykVf+Rv77x/fOUGkwrIQTGH3VdQljkdG5/5/CMA8vXiF1+Cv1wLJQrBYOumYuM0yVTvu06vt3MyVxzVSo81eFzXBAHR+vgzMml;25:Bky/8kgCIVG1kwqSSLax3trthDIMUN1GMVktNK3czjX5R0wY6c3mY/T5KO+nj+Rq/IjiGETeeNunEowF4G+qBRp2ppmqIzUAKFfTcByVFGqa/b/a9NTSQGIJYDh3rshSlunnmJbISVoiYNrnFnRcuZQPcGX9IhRgzOrBJByK9/OZlL+i5WaJiiFTIASk88KJ2bnrGYgg81rNzdKdDoijcUmKr6yRlmppO/42KCBBUI81BUhZhEAhccHQGMA1zHsJgjwh7Y4+Eldt0NpT/gyU6IuJtu9lV6IQGfRUHLA5APZ5aOAVbe7jUcWmGFKtkjMGUvJyGRaCWWQ8izjultzRng==;31:kRGwaJm4clb5r0N56PZZTngdKgTMHldAscu5ehkMa+mxom0MMaJMuKkQdU2M58oogloPpwQOPlPGSpF8dI3zg7+Q3a6ftro2So7w/8G7+JYoNZC5wWFg0zZ6HPeIFBn5vWlS51Y7eKbtbtOuI/eatTHEPx1c/96zFUjhweyFaWkmI8OFC++Zt2mK5azfyrHE1+DVecPA5K4SiY2MiTTSXAoz5tueGpWJrz28RQ2lE/Q=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2463:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB246307B8B1F4C4A5A71B0F8EBC710@VI1PR0201MB2463.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(2016111802025)(20161123564045)(20161123562045)(20161123558120)(6043046)(6072148)(201708071742011)(7699016);SRVR:VI1PR0201MB2463;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2463;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2463;4:+aG6mex0UpsXix2xq8FV5DiIhDmpSc65VGIwbR8XCHiq962IJYCdlx1KAKapUODkC5OqORFARufxlFqtXX6hFmFONjAvoMxOQ8NwdOrTIeVhNSTn+htMDSo6q+whJb2TS5ntvx16H2D/QosGUnG/ovtsbxPjTsV582tPAqkmZfWIOCA8EQsj2sSZcXw2shydU1MfJJaNGVeqFxbJkdt59OtAEEwrKOEsZ1G2RGCRQ9CY4CU21NYLKPbSbYIcK+/fqXFSXkdf53Q0/syQWNQdjw==
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(376002)(39830400003)(346002)(39380400002)(366004)(54094003)(189003)(199004)(74482002)(8676002)(68736007)(117156002)(66066001)(3260700006)(8666007)(6486002)(11346002)(229853002)(478600001)(65956001)(47776003)(23746002)(4326008)(386003)(6666003)(36916002)(25786009)(446003)(86362001)(8936002)(16526019)(77096007)(65806001)(76176011)(81156014)(26005)(59450400001)(81166006)(3846002)(305945005)(7736002)(36756003)(58126008)(53936002)(6246003)(65826007)(316002)(39060400002)(53546011)(50466002)(106356001)(476003)(2616005)(2906002)(230700001)(64126003)(16576012)(52116002)(486006)(186003)(31686004)(5660300001)(97736004)(54906003)(31696002)(7416002)(6916009)(7406005)(105586002)(6116002)(956004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2463;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;VI1PR0201MB2463;23:7QM9pg+Fkz2RiZyJ06VOJrAaV1ChuamDvbj?=
 =?Windows-1252?Q?JjCnoS+wRX1Lp97DwLi/W9CQ6LCWOOc+v6LDbj0a5fOQzm6vwF/9eWw8?=
 =?Windows-1252?Q?TMBBiA6oEW/hJcVAdy/C1IkTIMpbtwDvPT996uXx+59jJpfz9cKujub4?=
 =?Windows-1252?Q?cy74V9ho/BfXL9jbkJBgmScl7pbqFWjh7flMwsW8q/p8BDLb60AlmcjX?=
 =?Windows-1252?Q?7WXKWT+sZl0t6GntP0+PFUqgUwK3AkjR4YzZPHr5CKNjQDuFRKovVKVX?=
 =?Windows-1252?Q?cERLCh1vlKyJP1OL958kYrnQ4xBZNXIpITr1OlpfvV9QJV1YMQ/g+2bI?=
 =?Windows-1252?Q?uz8Y507cwGxDGSLwNnw2RKvHXRCXVsCstvWVDtnBP1wDArE5jobp7Fsj?=
 =?Windows-1252?Q?sl2qGmMdmx9nlIZwhVQlaydx28fjT44zzMFEFDC19pQb6P9P1IPfDhJQ?=
 =?Windows-1252?Q?8Wb72hEM1ncb9coA5Ba/fUQ+YpvoYvLlIdYDZQBdgfdH9GEQusbQZGt2?=
 =?Windows-1252?Q?xs4oCMk8VlqwWslx+LCrqelgm5CWdVizx6ljk4N7M1338RnecsD4g0Yh?=
 =?Windows-1252?Q?RqNsTm+Y6waCCPGEHcaAoBoKyqnK1R04JpTny/SW4gC+ApQ/ig9i5W/w?=
 =?Windows-1252?Q?TxFyr5nOXL7qS1u4NCsRN7B/jk7fpLw61y3DX6ONvTcZywtZjseZO/5U?=
 =?Windows-1252?Q?oLTZqcX3GoT4lRhyX6nG8OTUJt7HaDPaBNWk8NhK1F7J2rhEg6BJl2Qr?=
 =?Windows-1252?Q?wjqU7xtZXP8+STBcJCjQkL/ibKHZcm/DmfJ18Rxwwp0W2AHI5+pbgqaK?=
 =?Windows-1252?Q?seLwsXzyOeVmVkBjX5QK8ZilQy4hDoJBwPoO8t2EUKZE3rP0j3UAUTP2?=
 =?Windows-1252?Q?yiL6gzV4ml3I5UfqLozAYeDevGXhO/1ALCfq5zPH4ReaF7F9NARJOybF?=
 =?Windows-1252?Q?aOrQDx/3EdOS5NWzWjPO11qTHTjE1xiFSmTiWtkg3raYMilPWuJrKUN/?=
 =?Windows-1252?Q?fYvt5CWh+kullx2KtmHgnlCfVbuYE2JsUVZQl4BwiUTcRcRe+uhHnKAz?=
 =?Windows-1252?Q?uzVox6oajL8SxeyeCSeqdsHXVVM0vo/B/nQr/J69dd5fJcTrJyDzJrMW?=
 =?Windows-1252?Q?8zP5cQ3+iDBnAPdHsIJxEfaEk/H5WvYBmrrp3BFKrdW+0PuQuwAm1fhK?=
 =?Windows-1252?Q?ddGZcRPVuA39BYumrzhy4YYQMa5SOCwSsqmwVZpRhmXxGJ2LpIxe/+co?=
 =?Windows-1252?Q?Fs1bDU/4Bl1UalCR1GqVKBHHSqRZBXiQXlJ5l+W3cRLHGdQG3rLBurBv?=
 =?Windows-1252?Q?N2ssanZwhMjsLGo/3EHiDwg0nsB21qg3QeJsPc8zr63ViNeydMCerziR?=
 =?Windows-1252?Q?ZWzK+c3vOQABZ172vgk9HvWIAjR0tviJ2dp52IXQc6i5GFn9Xw9ISzjU?=
 =?Windows-1252?Q?/jqSenKw49EXu9jzpTYXDi389rRn7lNIL5aoF8aHUmIA0FE20DewhY1k?=
 =?Windows-1252?Q?ltbfE8kJQTLFycjbHZQQuztiDFOyGfeJPS8Moy9oVPXcHCjV5IcTzdpD?=
 =?Windows-1252?Q?wxaOHR1L05TzEpLsj0bKRlUx40tnPzZ/YCo7PEGb++UeZfKF+B4ZlLTC?=
 =?Windows-1252?Q?O/LwhzZ9wXuBEKnXNU3rLu0BWJYD2lXFORT1kHsM5mgUMSaf/0IpnnCZ?=
 =?Windows-1252?Q?LACYHJW2db3LYivKH58saNaawDXdon7LEMUhsJAvDVyp7ONsqdXgp3bn?=
 =?Windows-1252?Q?TUz7MTdyDQDQ0QfxG31G4W9yI9oTurysoBRqk3Gs=3D?=
X-Microsoft-Antispam-Message-Info: ze8LLxjBfH2v2mNqNj4CMx2UbEBXStPhWzgaiBTgOlTcCgqwIMM1VnNIILD7/W9XjAPCvH+h2F/toU/wqgPdAsvEg/by7b82TGirtGREeU4AlRZwkYvAYzecrPg4fCezuwrlAVpwAOEmHFgYWfRLLdg0WuMQRr1giW6CPAI9/ugZq4oitZHw0lkQjI6ncI4q
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2463;6:HiH7W7aTN99YSOlOSzagm5On9eZqydsv3OwXRS9rWLLhDFhxyBt7arqBDDPDlg2HeLdEi/DDQFjQ7ee4iItbsG5Zo33gajuLWiyQULH3VjHfg5Me1tSN4jZ1amVu3gxCprMJMeGFl924h3PX2ReO6soJar3eelpf7/kayGguIdhbkE9UeicIDCfkk9uNGg7guout6Fz1dy/M43aotLMIJmMMJj8r6scHTaHM8D1cm6hyQ7J1RyeD4b0VOhkw/4wJ6We2MeowMqfnN3TtLuz/oR9W9ycJ8gshCMMpeCeqFAMPV22Y+/9qqjRW4o80BCZ/7J0fZAn4NPU25r5xvAwQrqR9FXeKWMGjqRksxUrrPRTSpFKid3iERGccxYJEUfoP2vIljYQGN9CVb1qoR8bJ92MuKfdNKGRrGRw0pGG7Dccjr1cAv18crTKaBDY7/q7CnxMYZzHlMHsU3KfEFV3MXw==;5:JfZyCfnIs9wT8cT5LAHpR+eHMjU+i34PHMCJBcrbyuyxYmDmqYx4tl3lxmOp9u9KVr/SCUhCMku9grcrNt1+yIHk92l5BdJ+05LH3DRVe6SBiB2FU77aA0prAO0RueGtiSkH3wPqtl5b1N0my6cDald8wdncD8mi0CdOybfv3wg=;24:Wv8e8SBwCBN58/Nh4j3540sr1BhSve77nu4KQmXnx+R3WLmEUPAXHJAhZaw3ZVFUlc7aOVwVn4rOUSiBRj6r25GgF9rjek0bbPpaMV4fVtE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2463;7:gL+pN8DDXV9/EapPsr9gJ127EzkLw7g5LekTX5DnMT5tm5JgPeJY10ZouIVubxevN6pU6aq5uNK7A1tN3iAerHWldVEpVB4zFhIUMXLPhIZ+sHgex39LBsmfvn8CDJ/xDIHZTT2bMETD6WYp19aE8Xy5y1Y7nPWtz237r9ITT/nPNXDtwhS6AdoBrnzhPAOPC77OQsyVSjSVLSlJGmpJYQbqcZl6osFV5TJTmyHoQmF5vAhfQrLF51EYABueLCp9
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 11:32:52.6109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea2ce1c3-a5cb-45c0-6e1d-08d5d50f3c5a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2463
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-18 13:05, Wolfram Sang wrote:
> 
>> +static inline void
>> +i2c_lock_segment(struct i2c_adapter *adapter)
>> +{
>> +	i2c_lock_bus(adapter, I2C_LOCK_SEGMENT);
>> +}
>> +
>> +static inline int
>> +i2c_trylock_segment(struct i2c_adapter *adapter)
>> +{
>> +	return i2c_trylock_bus(adapter, I2C_LOCK_SEGMENT);
>> +}
>> +
>> +static inline void
>> +i2c_unlock_segment(struct i2c_adapter *adapter)
>> +{
>> +	i2c_unlock_bus(adapter, I2C_LOCK_SEGMENT);
>> +}
> 
> I wonder if i2c_lock_segment() and i2c_lock_root_adapter() are really
> more readable and convenient than i2c_lock_bus() with the flag. I think
> the flags have speaking names, too.
> 
> Is that an idea to remove these functions altogether and start using
> i2c_lock_bus()?

That would be fine with me. I don't have a strong opinion and agree that
both are readable enough...

It would make for a reduction of the number of lines so that's nice, but
the macro in drivers/i2c/busses/i2c-gpio.c (patch 11) would not fit in
the current \-width (or whatever you'd call that line of backslashes to
the right in a multi-line macro).

Does anyone have a strong opinion?

Cheers,
Peter
