Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28183C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3CA22083E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cZWz4VzU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3CA22083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934066AbeGDIq3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:46:29 -0400
Received: from mail-eopbgr690056.outbound.protection.outlook.com ([40.107.69.56]:52275
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932148AbeGDIqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIDmJH0OYQqvgn8r0uy2F7d9zJOxTOfyp5Vspuwqxb4=;
 b=cZWz4VzUu3LjmrzhUWY69ybfTL5/KSd74TLUViOvKAWqa8jco8HAMTI4uuarO6JjYquiNPjdY4jf0jDFYj7120yIBMPk5UDjZnAxw9asQl73dp/T2zbCOSJxlVx1lBkQ2l0B+YsMyEYRMS3ovDNTES61Ay8aYts7Im/UJfNmYwM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vijendar.Mukunda@amd.com; 
Received: from [10.129.12.246] (125.21.194.1) by
 CY1PR12MB0309.namprd12.prod.outlook.com (2a01:111:e400:50f8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.24; Wed, 4 Jul
 2018 08:46:19 +0000
Subject: Re: [PATCH] drm/amdgpu/acp: Fix slab-out-of-bounds in mfd_add_device
 in acp_hw_init
To:     Alex Deucher <alexdeucher@gmail.com>,
        Daniel Kurtz <djkurtz@chromium.org>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Akshu Agrawal <Akshu.Agrawal@amd.com>, jclinton@chromium.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Christian Koenig <christian.koenig@amd.com>
References: <20180413161601.109431-1-djkurtz@chromium.org>
 <6e46904a-d721-d583-8ab5-82cb07df7934@amd.com>
 <CAGS+omATU0gus_EvbHtegGK1ZkaKVmSOr1E6QLQjd+LA_tC_LA@mail.gmail.com>
 <CADnq5_Nwt+i2Sezh2Rmg9VyYYbc8LAMJyS6eQf9K5yAp-GgAXA@mail.gmail.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Message-ID: <4444b8ea-ba99-902d-cb5b-5cf3f05b4803@amd.com>
Date:   Wed, 4 Jul 2018 14:18:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_Nwt+i2Sezh2Rmg9VyYYbc8LAMJyS6eQf9K5yAp-GgAXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [125.21.194.1]
X-ClientProxiedBy: MA1PR01CA0087.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::27)
 To CY1PR12MB0309.namprd12.prod.outlook.com (2a01:111:e400:50f8::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4317cbaa-f73b-4501-637f-08d5e18a9e9e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:CY1PR12MB0309;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0309;3:VsX8FdkKgaJWbQcZIvQ8TO8beiVZHbgrFjn/fL1G6E232Iwr93JwnbHKWceBfgpqrs6tkHvHSNcgu2UDn4lyjMvp4f307VIm5IPOTOJ8B93fnw2mUi1ZL1PwTVzOeSLHhxhhlQnm/yygB4zhbZVn+X9LgyV/tH/vKTjxo2o09OwC1jDmtCEW8K5+oLe+eQxKqOIDFUYzrzYiG8WMg4hS+V3j9gz3BhOxTg0PJsbfn9qI+PWV9rRvvP3jl0wFEfK4;25:bodS/Oy4iNL039DxxTbluorThofjhuiCQi3IOME+fulxpKLwzpnTeDlYnNC527PM6c6hNid3HTEJFSSCuiPenXndZXD+uQPvUNCXNgZlj40GBUyUf+q0BXjOyg1EsNgoBgkSE3QqMVIeQGOOjw0Xwlkg2xZiavMD7W+qmmf1rySgWZgItmzXRdid+/qNvx/7+o4hAQROgAz3NBrgujrlAGq4t/K7a9Yhk8m54TLaDULXqiQJkjDkz8078ETgSKIYJXspDYM+uY/+tp/HuDMauurCG180NyRjhAV5B/hZI6ZBA2dlLOLKrBU2V1dWlFS8tX9+7Mv57QRYpS56Z+uKMg==;31:/RenDF7njy8e95rxsicT/ZXR0skeU5obxGwPHwVl6Hm84q+48E++gFAuVA1DESKxKfaqOaCjjT7dJcHE16HweQSAugqYO+5KS6zTeiIUH3xtF2k8gA9SQ/DsKQOOPZ+CK/LRWp0aTPy7df3gCeH66QsGl7/zd/CGbs3HE0+QYB9sJq8oKJPVgRbcY2ZxI0Y+q4+7qsLEDW/jDEXT46qnb6nRc6y6st1YzuvCSVOeIOc=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0309:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0309;20:SNLr21fASLHoiKTtjlKWDzN3QiHQSgu1FSv+yhTEyrznOgbNjhvQ701Wfz2EkkuvsDICYCZwB6xXKomh4uOEhSEJVzbgIAVVia2fEDBkYwSE4rD2OynQI6jrPdLoa4i3xo7GNszKg9ozH8AikdAlsZVOl1u4BE1l4w9hm7xEo1GmUBD/rYqBOdbijQv15oQGrN7x1Hb81Zmhtrnr/6OsZ4PB02AujeFsZoi8l0TXm9j0p83Z4StL0vMzp9KbjuWoprMbpsZ2Z6gtyVQp+DMrFFKgQw1V0IdrZkYDs3Vnh42th3cy858eBebfoaWZKBTdk0l/UkmWYYIqNQE6VnrFZ1Q1JF4S6Xw8oI+9LiGxhQKYLh0JhiTDQTJx5btCzckI2/krQI2N1KvUzrRIyvAf5TJaqJMeRK4luyT7H4UL0LLFveqlezNOTWtTUu5NFqEC9xoezNCzorRX87d9VKyXTZOAHcTpfAAkf1zXN2dx7eG7yauRYUTCo0U706Go/mW9;4:gFz1BnfO9fmSvyHBIVW+P/OJuNeRL0iETmYRZr1C2ekViIxNGQbb+kaydTJxythFBBeHtstg0El+dojKeQ5QNAFJEjar/AAbLuOhHjL9kXz9zcqQBETX3MrWvt0TcAodiw4FzcnflBuxIihcsA4vaVS2y/1DfGAC6YgswGEiJFBXulbLtBNeaFzP5+HCp4qyQ4DzVNf0JlUwHfV4eOdHmWCaOF4Gs86mwHMSErBEkmlKzJKHs4VkAJQdOXN85hvYIZHq502LrkIWG4ZM8C3YvGS0grD5gIZBd1MxbCwmPG2+b2Eg8oe1KC0lrOe+bvbyJoSBTB6H5+94EFKLelikDBl2ZsMdLXO5jawHMy4USH+tMwm6pq7Sp9u7dlyijFAy
X-Microsoft-Antispam-PRVS: <CY1PR12MB0309CD55ED3668A793A4AB1497410@CY1PR12MB0309.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(217544274631240)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:CY1PR12MB0309;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0309;
X-Forefront-PRVS: 0723A02764
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(366004)(376002)(396003)(346002)(136003)(199004)(189003)(476003)(36756003)(67846002)(2906002)(105586002)(31686004)(106356001)(316002)(16576012)(54906003)(58126008)(93886005)(110136005)(966005)(6306002)(72206003)(478600001)(65956001)(66066001)(68736007)(229853002)(47776003)(6486002)(65806001)(8676002)(8936002)(81166006)(81156014)(6246003)(39060400002)(305945005)(7736002)(25786009)(97736004)(4326008)(230700001)(65826007)(6116002)(53936002)(3846002)(31696002)(5660300001)(6666003)(486006)(86362001)(77096007)(64126003)(11346002)(956004)(446003)(5024004)(16526019)(50466002)(76176011)(23676004)(53546011)(2486003)(26005)(52116002)(52146003)(386003)(2616005)(14444005)(505234006);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0309;H:[10.129.12.246];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjEyTUIwMzA5OzIzOjYxSVZiaHNlRW5nRVlBNmpubXE1OUxPZU8w?=
 =?utf-8?B?U0RRbTdZNm9XVEpNRnJYQy9RQzE2dHhFRThrYXFXdzRWRzg0OTcxMHovemZY?=
 =?utf-8?B?cTZDMUsvSmVFWTJVVGpnTzBNckJJRTFzVWhURmZuWXZ6TGtHOGhLYmtZODUy?=
 =?utf-8?B?Zk1oeG9sWlNCKzAxamJSamJOWWk5a3F4MmpUVXVNKzBIaUtqTjdleDdXL0Y5?=
 =?utf-8?B?VkptL3hKc1VhcVlOL3JmYUNCcEVXYTA4aXJldU4wRjJsb2hXTnl6S1EvWjQy?=
 =?utf-8?B?MEFTV3NXTjhHZDVOSmhIYWpyRFNrVXliaHV1NFhmYUl5UGRkTWYxZWpvZlJH?=
 =?utf-8?B?eFU5UDhEaFY5cGJEQ2REY1FNSWhndFJETWk5aW50Yk1oVUZCRjlLYmhjMFNH?=
 =?utf-8?B?bDl6VjREWDV5OGVCb3R1RXczeENaN0JoYmpOYUVkbkNueXhVQnBieVBId25M?=
 =?utf-8?B?ODZtWDZ5Q2xPQW8yKzZOckVHWTZuU1orR0xQZ2lHUWU3bTNuS0kyU252cVFY?=
 =?utf-8?B?elpMdE5YK1ViVHM5cXNpMUY4WmN2UWI4ZU9UYWgvK1NyQldoSExPQ2h3a1pN?=
 =?utf-8?B?K0VacjJFckJabmdXd2NKOW1vaG9xUk5ITjg5bXZ4N3ZlZGV0WGlDZzlTY0kw?=
 =?utf-8?B?ZXFkQ0EzeEJEL2NaVDJRb2dtVVhsc2tnZVE2eFhvZXVyeDVnM0Z5QkF5WFVX?=
 =?utf-8?B?NGx4S2s5UlZhaC83ZmxnN0p6bXl0U0ViaFEycllXbXZVNjgvWS9lekpsQVcz?=
 =?utf-8?B?bjh3QnI0QkYyc0NaRXVSRlFiMXlZM0xYd1FpQlRzVHArOWI5N0RzWVFQbzVZ?=
 =?utf-8?B?ODVGWVcxYTdxbEhaaHpBWUpvTHcrZEZ5aUlENUoxTW4xcHdmSmFBbTFhK2lZ?=
 =?utf-8?B?VjYrNWRiWEZlenQzblhuY0Npb2JlaTlSam1PRFhGOVFRSkxYN21ZRVh1aFNL?=
 =?utf-8?B?UEZ4QlU0SEVVZnFNUmNZUjJBU2drM051WXNDN0JVT2RlcHpGN1RvNVdBaHdV?=
 =?utf-8?B?TXkrWnRCYllodjlNZ0lRODJkcXRXaStkY1dWV1BGQzhEN2JjM0FtUWFobThH?=
 =?utf-8?B?QWF5QVdSRG8xbzZLS3Z5OXpDZzVpWXR0bjVrTzFEMzdIQ1pwcjVrektFSTZO?=
 =?utf-8?B?alJUWnpGZlROclF3VzJGREZXVmh6SXBmRHhHZERVaUlLajc2aVdNbnBMTU40?=
 =?utf-8?B?amhUR0ROVEx6M3NuaVo3S2J2SE1HK21MTTl0Umd6NzQrU05uSmpCbjhVNmxr?=
 =?utf-8?B?Qm53S08xb0F2KzZCS0REUWVadytENnBweEJBRytrVzZ1ekVlRG5kd1VNQXcw?=
 =?utf-8?B?bVdRRTJ0Tm9oOS9YS0JnVlJ2bUcyK1hhRUluMUlwcDUvSDNTbmx5Mk5rNS82?=
 =?utf-8?B?Mlh6TGpSZ1NwbVlaeVJDekhZcHg4bzg5S1J0S2VicFhzeFpyQzNIbTdNTWpU?=
 =?utf-8?B?R3E0WDB4c2UxWW8zRmVGTDYzZm84MSt6UTUvaXVDVjhJL292cjJaMUg2cUZF?=
 =?utf-8?B?MTJOWUovc0FIZDEyVWo1bjNIaHRTM3RSRjY0Rml5THNmZHYxbnlYaFFEMTN5?=
 =?utf-8?B?OTl6ZWtlRFI5QmNjNzRMQnpmdkFTeUVSM2RlZ0IwZFl3ZTJQMWFDaVo0ZTdY?=
 =?utf-8?B?NXlqU3VsMEZ2cDZoMlRsdzEyVGs3d0dURHJzYmVsV3J1d3JmbTY4MTZHMWRv?=
 =?utf-8?B?SkhrUm12NnVMUFVwUDZXWE1oNFVzTXppckNXVyt0a1NMMXJuNHhjaHRKREVs?=
 =?utf-8?B?S1MwNHA4WGs4STFJUkVUbnppWWFTYjFtMEhSR1NjMTl1c0wvVitvTnFQM3Nk?=
 =?utf-8?B?c0F5S1JhWmU1T3hkbHNZSGNSdU1BN1phd2JTWldaSTNXWG9CemVCU2ZLQVRU?=
 =?utf-8?B?Q3ZvT1B1V1RwamR0NmRRM0NzdlVQTWoxQ2lEVHU4MnV4S1gzMDArMlNGWjhm?=
 =?utf-8?B?OWQvL1BEVCttL2t4WW0yeFNzL2l3TU8xa3l4MjE5dlJCK1hLNjM2WDhZU1JN?=
 =?utf-8?B?TG56OGlJMkoybnRDWUpyUHNqU2ZrRHc5b0d3a0g1eHgwNVlXRWVSazRrcjdX?=
 =?utf-8?B?Q2MzKzZGeE1Sc3d0VER6VXgvbm5STnFoUTU4YlZOQmRsSXVBZCtVOHNHb3Jo?=
 =?utf-8?Q?+Q/RhUQ25qnEV90M+fiUKkTtVyrCok0gCPQ03C+0nHAX?=
X-Microsoft-Antispam-Message-Info: i529yn24NklvKQr0UUJKkhkZYM05/qPglnDvAazj0dTEh9Nt77cf5DOfCDZwTFF0FUQrjzlwiGJMDIkr1YK6HDsV26nLBoCkKYATfdydPH7bgCe/NbDoEarwmlb4uqVlKI51zYPaCkwDAc3do+7Cz7BsjMTUCEMZ4HWoWY4Ae7nbAQnRF86PX3G9YmzpJY7jI6MWJzL6oSYfODJmZvpLii5sbkW4N/E2r3S/PLr41a6HzxeIMsd1/P58Yx6POGCrjJpMCS9whjpM07qFGd5bmB8cH1Gs12G9qk5KozjYg5chhytizn53opg8CfzPYgPw7PrmzD1fRDSlFI4+CWh8cdPJkuhsTfFLxzKN7U1IaB0=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0309;6:NMbu62oCM9Iv4G4ht1yabuagdm/39meI3R0H1oRALO/RSqrVZIGqdk+UHvvzyNg5cvKnzd2uyMk5RAc7LJBxRnDDgwaP5jLcaeX/NDrTVQIRKUr8V+PZGj5nJPICN0iLhk1AvmUCu9q/qgxmnOS041UnwPmE6NOaZWop4YlypvDyhzqu7i4cTwn+pr3SijxfbdW1gUpD+zU5xlITtPa9vhGOGSSngeR0HjX8WjjCl7SqoqXDMdJ5uBN7yzfDpEXcosIfE72yvLXoVCJEvCOWwvyj/Duw+6KFg8CHomrKfZRcQ8TeSGG67kLhgvSVJxXV6YTQ6KK4o91MXC3ECOO/MtL0sCj4rpAeU/mPYBmH03GO3PflfuY70geW/jJNOPtb8XapRl+FT6sxVyYpW3tjTR/vpISQDpGkSRduvMk5zRdCCPeMoW5krPAUVZ0hJEhmHMnmU6pR0BG/R0le0udMqQ==;5:56koGv/aoeRCY4dkQGTN6GJsnRqXbiA6Z27jswALBEZ4GF2s25xIToE7T0YrJ0iwSwdfRFVIfcIs0BoDAWQsphvtUgrarZrIN3660PrG/onOg9ZVo14Jgn3KWuZdWdLiP84Pb/nGR0Q9jMbEAcI2WJAZYVaOAXLQ4OsUD1suim4=;24:MNBz1LJqkkGsK5stfK8FmPQBi6KEqcHL2PGowTSfYVJllDKYjt9LWMeyeWyo8FLwHjUI+B1asGQuY6PaUajkDXTeR/9xaBfuCdx4KzQdKOc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0309;7:vd/CoixgJBdz7/zcvOmP040477/HwYAERQVLVCGMAeKMcG3XQV/0axxZNVfa0dJcYul4NHJ3JPJxZ23Zrb1E7WafBWkzXqlBVq6mGS2sNCTRn+ZmA5KhBne22Jy3Oi1EZhEphuFZSnGNu6mdSH8lhGLMUDbK10jRxC12EF0MUFjfb0EA2kAwf/emi3mm42I01dyIaZGVkgJ8+AfQfZg0nHRLpyljpw9BzDdFi1Td4F3ANOjGUYeUCMW9UpBjhTnj;20:5m3IK0XiOc9IbTPADQgxcL18GYCvtNoInkOcoh7eVQ2uU5sh2sbYLj9G6vfQmXWQdusENCEsmLgb2EFNJLRbiDJ+DLWxxQWUq0eyvw8GeqtK5r2dZM46GhRa999NR0sK1ytITuac0a94qQup4frvTMbS1+qaqDmWQpSp+UCbj0c0YnsUZ/+hxvWb9pR2jS2KyL0aWMrsFktrqe80+ciqS9vOPOJ2XPUhcTcYqmqKLMlZ08Bd1EkeF5ALlwuk+peQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2018 08:46:19.4555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4317cbaa-f73b-4501-637f-08d5e18a9e9e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0309
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday 03 July 2018 09:50 PM, Alex Deucher wrote:
> On Mon, Jul 2, 2018 at 5:48 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
>> Hi Alex,
>>
>> On Sun, Apr 15, 2018 at 9:48 PM Agrawal, Akshu <Akshu.Agrawal@amd.com> wrote:
>>>
>>>
>>>
>>> On 4/13/2018 9:45 PM, Daniel Kurtz wrote:
>>>> Commit 51f7415039d4 ("drm/amd/amdgpu: creating two I2S instances for
>>>> stoney/cz") added support for the "BT_I2S" ACP i2s channel.  As part of
>>>> this change, one additional acp resource was added, but the "num_resource"
>>>> count was accidentally incremented by 2.
>>>>
>>>> This incorrect count eventually causes mfd_add_device() to try to access
>>>> an invalid memory address (the location of non-existent resource 5.
>>>>
>>>> This fault was detected by running a KASAN enabled kernel, which produced
>>>> the following splat at boot:
>>>>
>>>> [    6.612987] ==================================================================
>>>> [    6.613509] BUG: KASAN: slab-out-of-bounds in mfd_add_device+0x4bc/0x7a7
>>>> [    6.613509] Read of size 8 at addr ffff880107d4dc58 by task swapper/0/1
>>>> [    6.613509]
>>>> [    6.613509] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.14.33 #349
>>>> [    6.613509] Hardware name: Google Grunt/Grunt, BIOS Google_Grunt.10543.0.2018_04_03_1812 04/02/2018
>>>> [    6.613509] Call Trace:
>>>> [    6.613509]  dump_stack+0x4d/0x63
>>>> [    6.613509]  print_address_description+0x80/0x2d6
>>>> [    6.613509]  ? mfd_add_device+0x4bc/0x7a7
>>>> [    6.613509]  kasan_report+0x255/0x295
>>>> [    6.613509]  mfd_add_device+0x4bc/0x7a7
>>>> [    6.613509]  ? kasan_kmalloc+0x99/0xa8
>>>> [    6.613509]  ? mfd_add_devices+0x58/0xe4
>>>> [    6.613509]  ? __kmalloc+0x154/0x178
>>>> [    6.613509]  mfd_add_devices+0xa5/0xe4
>>>> [    6.613509]  acp_hw_init+0x92e/0xc4a
>>>> [    6.613509]  amdgpu_device_init+0x1dfb/0x22a2
>>>> [    6.613509]  ? kmalloc_order+0x53/0x5d
>>>> [    6.613509]  ? kmalloc_order_trace+0x23/0xb3
>>>> [    6.613509]  amdgpu_driver_load_kms+0xce/0x267
>>>> [    6.613509]  drm_dev_register+0x169/0x2fb
>>>> [    6.613509]  amdgpu_pci_probe+0x217/0x242
>>>> [    6.613509]  pci_device_probe+0x101/0x18e
>>>> [    6.613509]  driver_probe_device+0x1dd/0x419
>>>> [    6.613509]  ? ___might_sleep+0x80/0x1b6
>>>> [    6.613509]  __driver_attach+0x9f/0xc9
>>>> [    6.613509]  ? driver_probe_device+0x419/0x419
>>>> [    6.613509]  bus_for_each_dev+0xbc/0xe1
>>>> [    6.613509]  bus_add_driver+0x189/0x2c0
>>>> [    6.613509]  driver_register+0x108/0x156
>>>> [    6.613509]  ? ttm_init+0x67/0x67
>>>> [    6.613509]  do_one_initcall+0xb2/0x161
>>>> [    6.613509]  kernel_init_freeable+0x25a/0x308
>>>> [    6.613509]  ? rest_init+0xcc/0xcc
>>>> [    6.613509]  kernel_init+0x11/0x10d
>>>> [    6.613509]  ? rest_init+0xcc/0xcc
>>>> [    6.613509]  ret_from_fork+0x22/0x40
>>>> [    6.613509]
>>>> [    6.613509] Allocated by task 1:
>>>> [    6.613509]  save_stack+0x46/0xce
>>>> [    6.613509]  kasan_kmalloc+0x99/0xa8
>>>> [    6.613509]  kmem_cache_alloc_trace+0x11a/0x13e
>>>> [    6.613509]  acp_hw_init+0x210/0xc4a
>>>> [    6.613509]  amdgpu_device_init+0x1dfb/0x22a2
>>>> [    6.613509]  amdgpu_driver_load_kms+0xce/0x267
>>>> [    6.613509]  drm_dev_register+0x169/0x2fb
>>>> [    6.613509]  amdgpu_pci_probe+0x217/0x242
>>>> [    6.613509]  pci_device_probe+0x101/0x18e
>>>> [    6.613509]  driver_probe_device+0x1dd/0x419
>>>> [    6.613509]  __driver_attach+0x9f/0xc9
>>>> [    6.613509]  bus_for_each_dev+0xbc/0xe1
>>>> [    6.613509]  bus_add_driver+0x189/0x2c0
>>>> [    6.613509]  driver_register+0x108/0x156
>>>> [    6.613509]  do_one_initcall+0xb2/0x161
>>>> [    6.613509]  kernel_init_freeable+0x25a/0x308
>>>> [    6.613509]  kernel_init+0x11/0x10d
>>>> [    6.613509]  ret_from_fork+0x22/0x40
>>>> [    6.613509]
>>>> [    6.613509] Freed by task 0:
>>>> [    6.613509] (stack is not available)
>>>> [    6.613509]
>>>> [    6.613509] The buggy address belongs to the object at ffff880107d4db08
>>>> [    6.613509]  which belongs to the cache kmalloc-512 of size 512
>>>> [    6.613509] The buggy address is located 336 bytes inside of
>>>> [    6.613509]  512-byte region [ffff880107d4db08, ffff880107d4dd08)
>>>> [    6.613509] The buggy address belongs to the page:
>>>> [    6.613509] page:ffffea00041f5300 count:1 mapcount:0 mapping:          (null) index:0x0 compound_mapcount: 0
>>>> [    6.613509] flags: 0x8000000000008100(slab|head)
>>>> [    6.613509] raw: 8000000000008100 0000000000000000 0000000000000000 0000000100120012
>>>> [    6.613509] raw: ffffea0004208520 ffff88010b001680 ffff88010b002cc0 0000000000000000
>>>> [    6.613509] page dumped because: kasan: bad access detected
>>>> [    6.613509]
>>>> [    6.613509] Memory state around the buggy address:
>>>> [    6.613509]  ffff880107d4db00: fc 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>> [    6.613509]  ffff880107d4db80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>> [    6.613509] >ffff880107d4dc00: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
>>>> [    6.613509]                                                     ^
>>>> [    6.613509]  ffff880107d4dc80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>>> [    6.613509]  ffff880107d4dd00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>>> [    6.613509] ==================================================================
>>>>
>>>> Fixes: 51f7415039d4 ("drm/amd/amdgpu: creating two I2S instances for stoney/cz")
>>>> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
>>> Acked-by: Akshu Agrawal <akshu.agrawal@amd.com>
>>
>>
>> Was this patch ever picked up?  I can't find it in agd5f/linux.
> 
> It wasn't applied.  I don't see 51f7415039d4 ("drm/amd/amdgpu:
> creating two I2S instances for stoney/cz") upstream yet either.
> Daniel, Vijendar, which ones do you want applied?  Can you send me the
> patches?
> 
> Alex

Hi Alex,

"drm/amd/amdgpu: creating two I2S instances for stoney/cz" patch exists 
in drm-next branch. Please pick the patch .

Thanks,
Vijendar

> 
>>
>> Thanks,
>> -Dan
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
