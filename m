Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE75CC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AAEF21732
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="nwsByYgE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AAEF21732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbeHHMHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 08:07:12 -0400
Received: from mail-eopbgr00137.outbound.protection.outlook.com ([40.107.0.137]:65344
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726542AbeHHMHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 08:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXzAPTbVceTV6Jh4Whk9FKXu5G6QLavvVQBojOvZDb8=;
 b=nwsByYgEJ2eogjuoSgNuty2dkVzXUsXYlbKFXjix/VaWGigqt9huBqBNqt44hNN/uAMKYwRczFlVKBHI3PbfkcbMgCBDCtQKmXJZD0mt6LZx1h+K9SadnGIreGy1Bp1n6/9q09Z4/kBzjtPo0sKCACtN4I5DjzhswnXJOeIORsE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 VI1PR0201MB2462.eurprd02.prod.outlook.com (2603:10a6:800:54::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.19; Wed, 8 Aug
 2018 09:47:51 +0000
Subject: Re: [PATCH v4 4/4] i2c: Add multi-instantiate pseudo driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        linux-i2c <linux-i2c@vger.kernel.org>
References: <20180808083006.31919-1-hdegoede@redhat.com>
 <20180808083006.31919-5-hdegoede@redhat.com>
 <CAHp75Vchow81kAaJ-b5Fr2ZjG7huasvM7HOfaKQzso7jaG2xXg@mail.gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <69e355c2-89ea-16bc-3d52-4ef9d0eb953b@axentia.se>
Date:   Wed, 8 Aug 2018 11:47:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Vchow81kAaJ-b5Fr2ZjG7huasvM7HOfaKQzso7jaG2xXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR09CA0053.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::21) To VI1PR0201MB2462.eurprd02.prod.outlook.com
 (2603:10a6:800:54::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8944882e-8b36-4dc7-964b-08d5fd1402b2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2462;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2462;3:MknmKwMLF2HsHm9sl4H1Tu5gbVmwvGkK0b9cKFIMPSSww5x96jIJpuD+HzspQEuQ6QlixkS6FNaOn/q5rxlCXCy39nqCoNz2Ja+urJbLZMVDcjuXDZkCPH3As4XNm0nILTIoRjYP1SUwhRikP/JHzVzIzl1tEErJdMqe0fVRM7BAur+3WRlzFgDd2/GTQwq3HTDxvru73/2QIL03hhHWZuDDfBvppIYbQEjE8zs/RmC5Dlg6unMjZHhR/TncJv5N;25:P+RSI0hEI5GVq9GAUn56p6m8KyDT3Ox7NquW+n0Klcv3nsfOHanJELxpZsJXTFhTLLpd/lK2knjlqZaCJ3iU3DQDKXQTWD3mXkHvf5TGHBikmLcEzZZEJDNG2wBJKxIQrdMgKRyY+SVscuf87iiinXZ4GWPyPwJu9IHdBgHbP1yYxiR3QdUAPQZoZ7s6+AuHPLWPQnKDYYTPGCr9/igs4oVQGe5kh+ELhs+w5dCYtgNyN1bu+ZCxRK5LakXLTM7VL845Cz8p83/UScE4sTu2R5wldDyC4kvKK7B4sylFTBRMIcY9jAJ/VYhxjWF9Ef5lv8P00wuwoopTPsVY7HLr1Q==;31:12nd2DMjhUi5z44cBYZy0b/YgLTPvQSS4lTDA9aS1EACa5X+QMAYxaBwiG7e5KJ/HVPM3Mo6Fis2F/FdOodjpy8kd6gmyrLCEIzJeVDtc+37qamNdFL6nf4qo7ch17woLM7q9pQ6i8a4wtsv8A7s3InkWOdad5DP2/hBeWFZQyy8XF34NqZeXIJ6VJA/rt5Mi2SO/U9i/EUudsC3gja70g9lyR4XSFPJnjCiY9PEYys=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2462:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB2462E4519B3FA00DB82531A9BC260@VI1PR0201MB2462.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:VI1PR0201MB2462;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2462;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2462;4:nfRQhi1JsZtUHAs0x5ae5DnouKZoy3kwfdfCvncrg/5TchKNaElkDyJKj6Q+O4cTVwIB7VPpB06nC7ALqpsVKiokAwTa55F4Fh5iF+4AffO/yfHw7gcqCNcVeReTi9ZaALerZCEK7F+iEUBLUc9ZauohANTtcTtVtURk/4HcK9QRi9KJ0STdkuloKR6GnCv97yMXneqZEBwsc2+Jx4lkchmvqFX+gFIYs++Qt9/xmOq72p3KAUfJ47F1jOzpF9xgzWTZ0H0RTiSBtwH8MAOXLA==
X-Forefront-PRVS: 07584EDBCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39830400003)(396003)(376002)(136003)(366004)(346002)(199004)(189003)(7416002)(47776003)(2906002)(65826007)(97736004)(65806001)(76176011)(5660300001)(6486002)(4326008)(81156014)(229853002)(81166006)(6666003)(64126003)(25786009)(52146003)(23676004)(36916002)(2486003)(117156002)(3260700006)(52116002)(65956001)(66066001)(8676002)(11346002)(106356001)(105586002)(39060400002)(305945005)(7736002)(486006)(50466002)(110136005)(54906003)(478600001)(956004)(31686004)(68736007)(446003)(53936002)(476003)(36756003)(2616005)(86362001)(58126008)(386003)(230700001)(316002)(16576012)(16526019)(26005)(14444005)(8936002)(186003)(77096007)(6116002)(3846002)(53546011)(74482002)(31696002)(6246003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2462;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDFNQjI0NjI7MjM6TTkyRUV4ODBweWpQZkl2Um5Ob1J0bzVM?=
 =?utf-8?B?L21ILzE5WE1wdk1YMW5hcVBqRGE3Z05qVEhwTlNzcjZMUjZIWGEyT3RhZlVB?=
 =?utf-8?B?eVY4MXNTU1JZYTRpNy9wNEtnZ1JZNmJ4YmllYmEzRGV3bnZ2TWVJL21rUGR0?=
 =?utf-8?B?UWhGR1l3bjgwQlhDdGE3am9aaENaVER2amxHZVd2VXBkYUJYeFdNSGhhdjI2?=
 =?utf-8?B?ZkRlbERYK2tVcjZNR2drNjJ6YjY3Q3ZDckIyOG9lMFluS2p1KzF3VnJKQkcx?=
 =?utf-8?B?VmN0UHpqSTJ4Z0FINHBDblB0RllVb3dxRHJPT0htSHpzcVE5SUZmZ2kybkNm?=
 =?utf-8?B?RC9ibjVONStqa2ZkYkNlS1FmZjlJSk01aUhNa09rMWx3Z3N4cWszblhxNHRN?=
 =?utf-8?B?dVpKOHlqcE5jN2o5Yy9WaVdpM1ZlU3laOTRGcW00QWc2eDJvdmR3WG1uK2JY?=
 =?utf-8?B?M2l0ZkpvRDQvSFYxb0lGUFBXa0dqMVVLNmppbVZ1N20vem11VHlJTHN4VURH?=
 =?utf-8?B?aitDOUkzaTdWZHhWYmF5WVd0WkFLdU9UMnhwMVNMdG5pN0hEZmVBcUxzNGpF?=
 =?utf-8?B?V094VlBEeTdSUXlKVE1aNDZYNEZrUmRINTJld0tQUHJ1amJDTEFQeENTR2F0?=
 =?utf-8?B?ZzFtaGlZRElVQ3Evb0ZyNlYxMVdPbEZVRGlnTE15YnBaQTBlUnRIQS8vckhz?=
 =?utf-8?B?MWszK282MXBzejJpRGFTNmJOY1ZvWTBXcjhmTHdtWUlkckIyMm5hdFUrT2Zr?=
 =?utf-8?B?QnlCV1EyTFE4NnllVkZBVEJVc005Y0s3UExEd3kvSEx3bENxQlVVQ1pSalQ2?=
 =?utf-8?B?VSt0NXJUMUlCN1ZiL2svWCtmYTg1cll1NGFSOFhUbHhIY2IzZlhyYnluc0dV?=
 =?utf-8?B?VWp6M3dhRktqam5FR1h1T3UrT09MRWNlNXJ6SXY4UHpIRkJuUWE2U0h5Vkxv?=
 =?utf-8?B?VEUreENVcnllbUIzRE5lZUFhWjFpWDVwczhsbkk0cXBWTUtabW5Za3NNeTkw?=
 =?utf-8?B?VUtaR3hJbHNmaTUvVUtvcUpFV1MzSTVORnp6UU1ZUVZ1RHlwaSswNTM4ckZq?=
 =?utf-8?B?MXF3Z1BYMWh0bUpJR2xSaHZBdlZqZmVDYVJYeWlEeDhVUElFWDhQOUFvWWZB?=
 =?utf-8?B?WmFCTzdkbENVTExMQ1granV6QlpvT1VoWlpHRGpZU0pLei9Wdmx5NE9JVzFT?=
 =?utf-8?B?N2ROTnlEdXMyNlFSdmtsSmRuT3k5a0NydzcrVzRjZlJoVXgvaFNMUlpGM3NJ?=
 =?utf-8?B?MW1RaWRnTEw3NW5vS1BuNlNYZGdyMVBlOGlkYnE3S0NFekRCZklORXl0NmVU?=
 =?utf-8?B?VklKNUd5aWZISjNYQXlEUXA2eTFjTDdRV0RPUzQ2ZGdRU2IyQ1BwMEpKY1Zp?=
 =?utf-8?B?N0twcVMzZWxNWVNVTDlsVm9TeGtoaGZiUzFZUVBRMEhZcnJHOVRUVHBleExH?=
 =?utf-8?B?MWZmcEpxMmRqd2NDTWJWSWJrNUZNWUhvdnZoNUhHVklIaW5zUU1CYXVqN2p2?=
 =?utf-8?B?K0lla3FQaEwzMDM3T2c1blUvNkRsazUyQUtVUWRNa2FUclZUcjNqRzNQRmkr?=
 =?utf-8?B?cEd0RFB0YjZ3M0hQUzBvYndieTg2WGVkRkZYU2Q3RHdVQSt0K1Rmd3d0ZXBC?=
 =?utf-8?B?Mk5MVzBuN3g0TUpmdll2T3hYNGMyWjNLdzlrL29vRGlZUWJDSExTc2tBVEd2?=
 =?utf-8?B?ekNtQ3BHZnlwb1JDYVdhVmI5K1U0OENhUzYvUmxSQmlybkVXVFhxTGRmRjlV?=
 =?utf-8?B?RUgvUTdyc2ZHWXl3OGxzdmdxM2dGUDQ3TCtSTk4xMHJhNDRHMTNUZjQ1dnRz?=
 =?utf-8?B?Y1V1b0E5VHBnK201ZG0weTlBVm5lb1grMzA3WTVjY3BMU2ZodU5Sbk9yY0dE?=
 =?utf-8?B?WlMzTGVWSmlhc3lkWThldFBKWm1OZHN2ZC9TRGVVT3A5bVJReDFJS25vM01W?=
 =?utf-8?B?S3B4cGNsaUIyRkNLcXQvM0ZYZDJMa1R0UjhGbFZHR3MzUzVwTXJCRDkzOHh2?=
 =?utf-8?B?MnpxUWNtYi9mS0hOUVVUZ0J0MCt2bVdQbDU4Szg1UHBUSUhCTzNpdVZ2N2Ir?=
 =?utf-8?B?NC9ReW9BUmw5dVRoeFFnZmllVzJ4cWRZQWhhQWh3dzFUWjM0MnR5UkYyeGFz?=
 =?utf-8?Q?o+eorHmnhB5t+Mh+mNk4XNdJzK96ql+xEq9n0NnkcVI/YS?=
X-Microsoft-Antispam-Message-Info: +c/j4KbTTXmDHx0uP9fZRPJ6WD9b1Yv2CTHY+BXymsuKKxYIcJG+psZ1VBCRcymMZRwoLgWM5bmCoDbqz+G0+OFdbWE955Qn5LgmZDvmAQLLgnOQoHFO0ANtiFraLvVn7cHk40XqCer9jYae0vBTnGrmueQS/5PDDzVdSQXsKt41fSrQKuNOiqqTAbMn+rM6XsdS5sAfHdNV6M1183wpr65hJcgm1K1r17To5FvL2pSCUmEoFKsQKq7bUGzVb5xjbha49cNnj4Z3WrhRLBaMB2Nyrc8RJ73c6kWKYibqrm5AsdXteTAFCH2i3lcBR8Ueirq9X+xrAEJtx7JmT/N83Vpa26gMmaEnDlyr1GPkJec=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2462;6:klYWVI6MReGF81vLU3tL3a1lOjzeBXOlDDzd3nHPBDgFH0aeg7kYBvQUEJzAMMtl+Kwdcc/8EeCP07DDfRzplThl0qc5m1CWdhXdBdeCscza212ab2SuvuIe4D1TXXFUCEOmR3k7c1H7p/EYdGLnK3tM8nYNEhRqaFkq2C4x254bBI1s7R4vTt2w/v9+ldyjiyjw/f2m5IQjaGO97rzNxgbxenNgqu6oPvXP07eUV8DNT0WWkBBv7LGAWklY266kYwnvKaYv7EWXmGcHyWScu8yXwd4qijbzVcZ5IaSXbo2AxBA3RKF1SCNZjYg/ZHQ9ezARDvpZHg85cjkn3WyY2RoPb3b3IXbDH0JoEynYL2sqYPRVBVxKkFBJQDZHFNUlu+e26ZEZdn0StZv6Wr6k3B0bAhBkEeOQQpv+q04/XS39WvYHhClBcE622qKNZBcnaILuGsvExO1RZyMA3eE0KA==;5:gKcCTLMQhE8mTxZAZHbGg4K7N/U2LYS0dAwWfj5w81rzQw/D82qdjsK2G6ra3MRC7aL0sIvRX1Qm5BBL3XRwK4or0/sLDhkbWDh1NmM+mA1adru7Ia8JErHKizXQeficsK0w29kVzDbD2K22qgDKeFGHA47yW6v1eF/KypKGRms=;7:SBZS2wBxla9plhME6xnrvbhrLKbZ4ZWCKLhPbJYaUC9BV5oqnCB7BFuyJIW/lkp4rRQkVd8ZhQ/upYoipUpOQdiDIlto7eM/sKD1CvfnbsKlpcTEuzEnaeaxXSvSxSq9w7SkgyUmEPeSSiEz0oicpPDLG2gbKMm7VTIA7Wt9r5k+jA5/b0C701hMqDUV/gT6xNiZo2/ZmJFhod+zSAekQXpPGX5xdbaZI306pY6zugVEHzytv56tV9JCB0dvjBnd
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2018 09:47:51.7974 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8944882e-8b36-4dc7-964b-08d5fd1402b2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2462
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-08 11:08, Andy Shevchenko wrote:
> On Wed, Aug 8, 2018 at 11:30 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> On systems with ACPI instantiated i2c-clients, normally there is 1 fw_node
>> per i2c-device and that fw-node contains 1 I2cSerialBus resource for that 1
>> i2c-device.
>>
>> But in some rare cases the manufacturer has decided to describe multiple
>> i2c-devices in a single ACPI fwnode with multiple I2cSerialBus resources.
>>
>> An earlier attempt to fix this in the i2c-core resulted in a lot of extra
>> code to support this corner-case.
>>
>> This commit introduces a new i2c-multi-instantiate driver which fixes this
>> in a different way. This new driver can be built as a module which will
>> only loaded on affected systems.
>>
>> This driver will instantiate a new i2c-client per I2cSerialBus resource,
>> using the driver_data from the acpi_device_id it is binding to to tell it
>> which chip-type (and optional irq-resource) to use when instantiating.
>>
>> Note this driver depends on a platform device being instantiated for the
>> ACPI fwnode, see the i2c_multi_instantiate_ids list of ACPI device-ids in
>> drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
> 
> Thanks for an update! My comments below.
> 
>> +struct i2c_inst_data {
>> +       const char *type;
>> +       int irq_idx;
>> +};
> 
>> +struct i2c_multi_inst_data {
> 
>> +       int no_clients;
> 
> Name a bit confusing. What about num_clients?
> 
>> +       struct i2c_client *clients[0];
>> +};
>> +
>> +static int i2c_multi_inst_probe(struct platform_device *pdev)
>> +{
>> +       struct i2c_multi_inst_data *multi;
>> +       const struct acpi_device_id *match;
>> +       const struct i2c_inst_data *inst_data;
>> +       struct i2c_board_info board_info = {};
>> +       struct device *dev = &pdev->dev;
>> +       struct acpi_device *adev;
>> +       char name[32];
>> +       int i, ret;
>> +
>> +       match = acpi_match_device(dev->driver->acpi_match_table, dev);
>> +       if (!match) {
>> +               dev_err(dev, "Error ACPI match data is missing\n");
>> +               return -ENODEV;
>> +       }
>> +       inst_data = (const struct i2c_inst_data *)match->driver_data;
>> +
>> +       adev = ACPI_COMPANION(dev);
>> +
> 
>> +       /* Count number of clients to instantiate */
>> +       for (i = 0; inst_data[i].type; i++) {}
>> +
>> +       multi = devm_kmalloc(dev,
>> +                       offsetof(struct i2c_multi_inst_data, clients[i]),
>> +                       GFP_KERNEL);
>> +       if (!multi)
>> +               return -ENOMEM;
> 
> Here I see the following:
>  - it's kinda unusual use of offsetof(), perhaps i*sizeof() + sizeof()
> would be more understandable
>  - there is no guard against i == 0

I don't see why a guard is needed? *Your* code below needs it, but that
issue is not a concern for the original code. It might however be a
good idea to fail the probe if there are no clients to instantiate, but
that's a different issue...

> 
> To solve both, it might be like
> 
> struct i2c_multi_inst_data {
>        int num_clients;
>        struct i2c_client *clients;
> };
> 
> ...
> multi = devm_kmalloc(sizeof(*multi), GFP_KERNEL);
> if (!multi)
>  return -ENOMEM;
> 
> multi->clients = devm_kcalloc(i, sizeof(*multi->clients), GFP_KERNEL);
> if (ZERO_PTR_OR_NULL(multi->clients))
>  return -ENOMEM;
> 
> But I would like to hear your (other's) opinion(s).

I think using two allocations is a waste in this case.

> 
>> +
>> +       multi->no_clients = i;
>> +
>> +       for (i = 0; i < multi->no_clients; i++) {
>> +               memset(&board_info, 0, sizeof(board_info));
>> +               strlcpy(board_info.type, inst_data[i].type, I2C_NAME_SIZE);
>> +               snprintf(name, sizeof(name), "%s-%s", match->id,
>> +                        inst_data[i].type);
>> +               board_info.dev_name = name;
>> +               board_info.irq = 0;
> 
>> +               if (inst_data[i].irq_idx != -1) {
> 
>> = 0 sounds more robust

But not as flexible/future-proof. Why should 0 be the only valid IRQ index?

Cheers,
Peter

>> +                       ret = acpi_dev_gpio_irq_get(adev, inst_data[i].irq_idx);
>> +                       if (ret < 0) {
> 
>> +                               dev_err(dev, "Error requesting irq at index %d: %d\n",
>> +                                       inst_data[i].irq_idx, ret);
> 
> irq -> IRQ in the message.
> 
>> +                               goto error;
>> +                       }
>> +                       board_info.irq = ret;
>> +               }
>> +               multi->clients[i] = i2c_acpi_new_device(dev, i, &board_info);
>> +               if (!multi->clients[i]) {
>> +                       dev_err(dev, "Error creating i2c-client, idx %d\n", i);
>> +                       ret = -ENODEV;
>> +                       goto error;
>> +               }
>> +       }
>> +
>> +       platform_set_drvdata(pdev, multi);
>> +       return 0;
>> +
>> +error:
> 
>> +       while (--i >= 0)
> 
> It can be simple
> 
> while (i--)
> 
>> +               i2c_unregister_device(multi->clients[i]);
>> +
>> +       return ret;
>> +}
>> +
>> +static int i2c_multi_inst_remove(struct platform_device *pdev)
>> +{
>> +       struct i2c_multi_inst_data *multi = platform_get_drvdata(pdev);
>> +       int i;
>> +
>> +       for (i = 0; i < multi->no_clients; i++)
>> +               i2c_unregister_device(multi->clients[i]);
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct i2c_inst_data bsg1160_data[]  = {
>> +       { "bmc150_accel", 0 },
>> +       { "bmc150_magn", -1 },
>> +       { "bmg160", -1 },
>> +       {}
>> +};
>> +
>> +/*
>> + * Note new device-ids must also be added to i2c_multi_instantiate_ids in
>> + * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
>> + */
>> +static const struct acpi_device_id i2c_multi_inst_acpi_ids[] = {
>> +       { "BSG1160", (unsigned long)bsg1160_data },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(acpi, i2c_multi_inst_acpi_ids);
>> +
>> +static struct platform_driver i2c_multi_inst_driver = {
>> +       .driver = {
>> +               .name = "I2C multi instantiate pseudo device driver",
> 
>> +               .acpi_match_table = ACPI_PTR(i2c_multi_inst_acpi_ids),
> 
> We don't need ACPI_PTR for the driver which depends on ACPI.
> In the general case we have an inconsistency with variable definition
> (might be unused).
> 
>> +       },
>> +       .probe = i2c_multi_inst_probe,
>> +       .remove = i2c_multi_inst_remove,
>> +};
>> +module_platform_driver(i2c_multi_inst_driver);
>> +
>> +MODULE_DESCRIPTION("I2C multi instantiate pseudo device driver");
>> +MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
>> +MODULE_LICENSE("GPL");
>> --
>> 2.18.0
>>
> 
> 
> 

