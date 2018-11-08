Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC17ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E32206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="b2XNdOhW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E32206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbeKICY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:24:29 -0500
Received: from mail-co1nam03on0055.outbound.protection.outlook.com ([104.47.40.55]:22848
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726684AbeKICY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:24:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=panY3uT0O04SgpSSeokS9TDPibUmtMB+JcTEZv4wb8A=;
 b=b2XNdOhW0/QYiiNzfSrYqXanfP7PLl7REEGA7G0HnBerQX4s3rVPLg/Zf1hfStE4LdrkWa7ccYXkGvv7hntv287SqTQo3XCd/I62pKmWcu3h/QFvcei9uIE23o20fYGqjCSPzfjRfbNRnEilRyFIeOOcswiZm6a2cYZ4l/M7WZI=
Received: from MWHPR03CA0002.namprd03.prod.outlook.com (2603:10b6:300:117::12)
 by BLUPR03MB551.namprd03.prod.outlook.com (2a01:111:e400:882::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.23; Thu, 8 Nov
 2018 16:48:05 +0000
Received: from BN1BFFO11FD015.protection.gbl (2a01:111:f400:7c10::1:179) by
 MWHPR03CA0002.outlook.office365.com (2603:10b6:300:117::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1294.20 via Frontend Transport; Thu, 8 Nov 2018 16:48:04 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BN1BFFO11FD015.mail.protection.outlook.com (10.58.144.78) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1294.14
 via Frontend Transport; Thu, 8 Nov 2018 16:48:04 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id wA8Gm3qL006609
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 8 Nov 2018 08:48:03 -0800
Received: from NWD2MBX5.ad.analog.com ([fe80::49e:7a9f:284e:1a49]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0210.002; Thu, 8 Nov 2018 11:48:02 -0500
From:   "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] iio: adc: Add ad7124 support
Thread-Topic: [PATCH v3 2/3] iio: adc: Add ad7124 support
Thread-Index: AQHUb6XpJEA5nW78CEmCTW7LTZ+YdaU+QcAAgAgRfwCAACMwgIAAA7WA
Date:   Thu, 8 Nov 2018 16:48:02 +0000
Message-ID: <1541695681.2091.10.camel@analog.com>
References: <1540831111-3040-1-git-send-email-stefan.popa@analog.com>
         <20181103121606.2fc461ec@archlinux> <1541687328.2091.2.camel@analog.com>
         <CAL_Jsq+zc2RGWgkwXNk8qjJqjo+FpdPZUOOxd44mb8Cu7+EsaQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+zc2RGWgkwXNk8qjJqjo+FpdPZUOOxd44mb8Cu7+EsaQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.118]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F2A07CA037339499301B9F90DFF2413@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(346002)(2980300002)(438002)(189003)(199004)(51444003)(2900100001)(246002)(103116003)(86362001)(47776003)(5660300001)(305945005)(1720100001)(7636002)(8936002)(4326008)(966005)(7736002)(106466001)(6306002)(478600001)(2501003)(6246003)(72206003)(8676002)(14454004)(53546011)(76176011)(102836004)(26005)(7696005)(2486003)(186003)(50466002)(11346002)(23676004)(356004)(2906002)(6116002)(54906003)(110136005)(316002)(229853002)(93886005)(336012)(3846002)(106002)(486006)(476003)(446003)(2616005)(126002)(36756003)(426003)(436003)(345774005);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB551;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD015;1:YGb6xCqGOLl0sYk+1xv+8UmgcYvSXcqP/OG94fKuziejSq5ZrDJboKLJKs9czSeNmDCz+uu0UbxCZ8UbOZYimUxflfWh71UGNz1AfyvyQgRCw6uEyml4lrf9qjHapSr0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34431114-c966-4bae-4cf1-08d64599f3da
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BLUPR03MB551;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB551;3:FbuK24pz9xzuWcA7Hr0w0Lm2oCaBiRGlXPerC8KKpw90xpeG85CfodBUj0TaNGl3LD48X4hUZxq3ixxMQp11mzEHf7gNFRV2ycxyYnTKAeWSLSuOyUWXVZz7qW08sy768HilqEhocSp3TMSVVPV5EU0UmvX4Fp62wWM+i9SkZcPrwxJiW25mrSfEpGQn5m8vn9vzlcWbZuynzphf0TrJ1EY8DdrqjkvUR3ivEHw66IUXMrlPHXtixijkGBnaoQsD3VOaoPRkGU4RdL+kuoldtTY/kC7mbID3DsEgE3SW6HrvhzViYLDxEG9JUxnjyhvW8vhIlK86BefcyEuNPyXtSHzeKzyaLJdoPtD5W72f3lI=;25:E2cGzRN4e8MaFzkBYbnOSO0RMANBBMBQMBOy09quMarBqHLWZSKSGzgvRcZ363ZOSCU56RPdQDVeENDV/vKufi/HX4sZFIyM2aqtcmyuU3myWHDY5GjSRxNs5OLQ0YIua++Q3UVuaYrb1GcHozbPer2J02dv5cI+8w/QdyCACJhKkY8c9WMvEs4pjMN51wyXi8kp5h5RDJrujMHeeRlAjVKUf9IWP5KyHBDcBMyXv4Bn6WZImjXQYwa7r+5vvVo1ChE3hGgtWIFgWHtbElOYSrBywlSbcGLRthLqtY3x99QguLr3lp4+ZeklkvTZFsTxis7fKdOHCKdyxs9U9dluLw==
X-MS-TrafficTypeDiagnostic: BLUPR03MB551:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB551;31:Ww2Tu10cz1ozarHeDn3khUqdvNqsndHk/ygDB0kUJaRyrkqQ80vr+8Uc5eXee98sjVbxznbUk59uDXpvq6CIlYK14F+yGQ4xUBpa01/NfGn/MbvRf9H/q16sYjj7v3vF0Cx9qh82S0+4h7nzZtqPqYIUmOfmDB0aMmJuH+5SDlq0gfRa1qH9feEBIra0BvbP9RrUyq2W8aVMj/ZF5FloIOaYQo+oAoAGnBSiimcZNYQ=;20:r1SZVrEdIPEBUVaZhxN0VpqSh2M6v1iCHSjGLzX2vJXjEvfU6Rda7RFBUwLsrG/lvbU75UY1cQGlXh/Ds166/purZxvAkK+tAjlfuN7RbJlnQDygbidrQaShAbhdQNeZIAKE5ZIzKtYGwwuOMSYjc/S+zQI2jztNtiBCEPWf7Rc1bd45LbY2jX4jxxKzfTlIQPDYbo3XAi92q5RuN2DwBgHR3DTAt4rQJIQbPu4bfiUkUzQtvYh1N/R2jNSLpZ10fNZ7DBVZjdt64lbUdmMRgWHS3Us68zrsjCV4hQLS1aBoomIAzT43En7Iu56WnKZn4i5hA21zzLqAdvW/XZNCtYOU5B+SqRgny8tR3LnZIYRSe3jzRcFMcqbcq0UOpQmVHlhoOF0VFBpcA2nC6AO86n9idkj2mia6w0rN5gQ9yDrXEU5VKhOV+2U3aeF5dSaiqGOCSsLQzTIijWpqD8bfoyYySOIpBSBzOlQgMwbun5sdGsGpkcgtQXDL9Y9u+P+I
X-Microsoft-Antispam-PRVS: <BLUPR03MB551B705DC88A89F8E1894E89DC50@BLUPR03MB551.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674)(270121546159015);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231382)(944501410)(4982022)(52105095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BLUPR03MB551;BCL:0;PCL:0;RULEID:;SRVR:BLUPR03MB551;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB551;4:U8aCqvzqKCtWatcw7Ow11wHltEUOe6wDoPubJe/9X13EKC0l3vAI2EwKbSJw6emZH07fntQCJpl+K4Qh91oM4HqZfaNOs7pb6T3j4SwHBgPE226riDAA44GqzyqO1JLJ0ZFqaNy6JFMwOQBtD3jI0CXDs0C8pH+aaSDmCJZMK6w+o5Lr0Y7SQRiDf/e4IA0Va+Bul/NU/y7rmXmT8FBtt2wvsd2PaA7Ko5hP2+ddtJNZNCWvLN9i4YYdtjhlBXoKYsia19EdZUtwI81GhnxhQNi728/YYebh4B7ZoPzpTgHr8io15GDng6srhWDDEAiapFebzkd2L516+Jr56mYC+e19n/tM3THRZrD3NBdU4Bc=
X-Forefront-PRVS: 0850800A29
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjAzTUI1NTE7MjM6VytsUGVVRFplemgzK0dMSGlvWEV1Wm9WNW5i?=
 =?utf-8?B?OFo2WXhPVGhpa3NrSFdIbEdVb2phekt0RFRwRnpPTlZpUHpyRHdmUlEyaDJY?=
 =?utf-8?B?K3o5MWQ5UVQzUWhLMFVzczhKYVVBNWgxUHVxci83UjVwK2Q5dE1yWTlhVmRQ?=
 =?utf-8?B?MTV5ZThDZjlWMnR5M0kyUnoxMkgvTEw5bXdsbkRUTHVuU05jQkNwemJ1Q211?=
 =?utf-8?B?Z2p2RlJzR1NEaUhqMFFHc2IxbUJmSXVobTdQMXl1Z1lCaDZ3V2ptVytQeTdu?=
 =?utf-8?B?czRhaUZ6a2MrWlpFcTRpZG5sSGs4SGZ4bThjQmhIdHdEaGZMckM0dlBWL0ZW?=
 =?utf-8?B?SkdaTnNQVWhoS2tFWnA1cUVuRGRwQ3hTMXpPZTc5dXBiZDlENzE5MU9xcG1P?=
 =?utf-8?B?VmZSeTVQaDJ0N3VLMlE1bC9VUUZmNkp4Y1d1WFFLVlp4WjV6RU5zYm5NUnlM?=
 =?utf-8?B?bWNzRStDcjNoajNvTlNpVGxuclN1VDhPVzU1SXBOWnlyZlQxT1ArQlBKcEk4?=
 =?utf-8?B?SXlCVzJpQi91L3g0anBJbTVpVnNJaUxndXhMcmthTTYvdStIWDIyUCtwZHJM?=
 =?utf-8?B?QnNqaTBueGNmK2VtbWFsbUpTbXVxUWhaOGhxVG1WYVQ3cXphRk9sb2JlbEdU?=
 =?utf-8?B?NzJ4ZVZCc3FWblRpMlFXM2xiMFpGZUdnaW1lL2x1M1A5bFJjbnRrSVg2d2Jl?=
 =?utf-8?B?ZzlRdXpZMGI3eGVvZENNU2NaSzVlNXdSY0VSVVNEdk1RS1haMHJlc09lQ05I?=
 =?utf-8?B?c1k5VXhuaExaUjlhUWNNejgvN3pEaHEvWlZ4Z2ZyVlRTWWswL3M3SDhrdnRy?=
 =?utf-8?B?cElyMVlaMDA1MWNabUVyNVRMR3JDUXBpT2hHQW5NbjhmTk9BSGV2b1BBb2hF?=
 =?utf-8?B?OHlsbGYxUGRYRUlQUmpUYmF5SGprMWpsZEdRUGJIbkI1YzRNOEdzNldjaVBj?=
 =?utf-8?B?QVFjYmFDUFZtUW5PQ0F3OE5EcEhwTGlkbWx5V01ZODlwMnVyRFJEQ0R6ajdT?=
 =?utf-8?B?UzdzYzlPZCswaHFKMlFwOEtRNUVWcFQ1K2JUZlRSREhoajZUc2ZDb0RpaW9R?=
 =?utf-8?B?dWhDWEJUVGxqK2FCKzFXTTBTN2Y3eFhSVXQrRmRsSmpYdCt6ekY5SkYrVDht?=
 =?utf-8?B?ZEtMek1YQTVla1ZDdVBucENORXBFWEg4cEpGcThvUzE5MFJwc0xkVEtadnBJ?=
 =?utf-8?B?MmFadlc4NmFaektDSUpOMHlsR1dpalNVRmMvUHk1ZCt3QTZFREowKzZySDRj?=
 =?utf-8?B?U2JYbWVGM0FVLzlDZjdaTnU4Q05ZSkwxREdkdXNjUjR1QkdqRldYeGpBQmZE?=
 =?utf-8?B?cmVJM281aXkwR1pxNTFyNWlWT0xCdlRxREQ1eE5qWWRCN3hNWlFRZ09wMDF1?=
 =?utf-8?B?Z0x0SGFHSHVHdVVnWkhjN2ZtdmdoZTQwZDJncEE1M2F1UFVTVndYRVM0SDkw?=
 =?utf-8?B?UmhEcHdJK2NjU0RvT3dXSVJZTlJ3dHZvVGxPc2hheEsxcnhQY0t0UU5PZVdv?=
 =?utf-8?B?NGJ0NW9kV0t6NS9rQ3k4ODZXTkJ3V0c5bnlCbjBXMU9GZlpKZDVQQXZqenhP?=
 =?utf-8?B?Y1hybTJxUlZIUk40MTFIcUhwOWY4VVNRb0o3RXpQd3NkUk5MbVkxc2NyM1R4?=
 =?utf-8?B?ZGFSckdibzkyaFJ4NUliQWhkTkJBTUxJTWNrMUc2MlVvelB3ZStXdjZVQjJI?=
 =?utf-8?B?Y0hPVDBaUHJXQnFwaTJyOXZLeVVKVnVUOFE3UXJTT3QzVExFZFA4Z0ZJV2k0?=
 =?utf-8?Q?87ncvB8OthQlI/IFWOJj+mLl0zzpheeENykY=3D?=
X-Microsoft-Antispam-Message-Info: ahCdz09NuScV4/MqQoaWFj1jWr5OPocHeyvoEVghimbi6beVKkAk4DKWZFvX6lwaCLsCVwB9uFKOJ2KYrOa5ri99rh/inw5P7bKJRF0XxNS2u8acVUZyyb/EIrFfDnStft9Rn+eIHe3Wjc6Nhxq/eqofmCrPUr1kCCa+4OmytjpGzTpkLzx1DcV7+QOfUkjcWu3SgzTCFkgegENOiKnivq+wd2VgEETDdOjMOPrRb/ZJG0tCp0Kw52UpxeUwE9p3gkJbYpwVKFQfEtAgmAO+ZZpHfCSvo51JMAb5YdV/aLi83Ns8ToBf1N5covZ5amRLtDBShbU/+ZtH98Ay915VPXhZoONbDjjgdf5c0jzRt6Q=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB551;6:PrrfCvHDXjB5whLvGkUMkkhXTahWqTZKQ31DdsiJRyUVxw8UpXjyV+0cNlRhbvXZaC+M0ADmuEVtDLk5REaVofGVUGzfGycpZPcWfSybbIne5uVhcpgS8+Jrb/NwqPgWTutZ/5vh5fUbYOcuG98R0QG+v6LY7eB3dpFhOgjtMknIVDSDCWsbIHWeHJTb6Q6Pe8IZ39inM6iY/KnpmppM3DX72HRtnvjXt+v6vAY74SihcNiV2/oDpNYF+OvYOrGK07Z7nr7vZF7tbiAtEogTGBDUaBfV1TgyHgY2tsrsqm2Vnr/GH0oDfWDhaKSfocndlkwdLGVGdyj+RcBlUkQMy2XuxMS90l2fw2A2R1/2AZccIMkhpUPLTGO5LVhx1+nrKhf09dsdh4i8HCtnamVX16oIq743ircpX16HeQ+9xwwwInf9s0i7YmuWc1LoKTISu+Rg06+XHxtdASIidaqCBA==;5:imfduYukUGXFIcwMa9wKmk7599SDkIf7SVFWWSrbLgYm8xyVvyvzexyHGr1ZwNjTByMlLIJFzmmKE4vADI6kQXU17/NVtUJkPswJzyp2HGtU0haOqo6Vzbl8vk/me1yDjrhou9pt4lj6x0ciXrQ2GpG1z2TlmOfjwL92+X/JScE=;7:vUO4pDb/gzvhZgJpsbUWikWMAsQil+HjHtPLdT1qvdhNBnVWBIwFYVYq1wuKjsf7igiFB740xpOm9wR7D+TaDmVuaiHk6Nk1a6+mmjcsgZWBdM7+KUkDH+uiC9t04e7mRGh8Z37N0sSSWmZtlepniw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2018 16:48:04.0174
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34431114-c966-4bae-4cf1-08d64599f3da
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB551
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gSm8sIDIwMTgtMTEtMDggYXQgMTA6MzQgLTA2MDAsIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBP
biBUaHUsIE5vdiA4LCAyMDE4IGF0IDk6MDIgQU0gUG9wYSwgU3RlZmFuIFNlcmJhbg0KPiA8U3Rl
ZmFuU2VyYmFuLlBvcGFAYW5hbG9nLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gDQo+ID4gT24gU2Is
IDIwMTgtMTEtMDMgYXQgMTI6MTYgKzAwMDAsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+ID4g
PiANCj4gPiA+IE9uIE1vbiwgMjkgT2N0IDIwMTggMTg6Mzg6MzEgKzAyMDANCj4gPiA+IFN0ZWZh
biBQb3BhIDxzdGVmYW4ucG9wYUBhbmFsb2cuY29tPiB3cm90ZToNCj4gPiA+IA0KPiA+ID4gPiAN
Cj4gPiA+ID4gDQo+ID4gPiA+IFRoZSBhZDcxMjQtNCBhbmQgYWQ3MTI0LTggYXJlIGEgZmFtaWx5
IG9mIDQgYW5kIDggY2hhbm5lbCBzaWdtYS0NCj4gPiA+ID4gZGVsdGENCj4gPiA+ID4gQURDcw0K
PiA+ID4gPiB3aXRoIDI0LWJpdCBwcmVjaXNpb24gYW5kIHJlZmVyZW5jZS4NCj4gPiA+ID4gDQo+
ID4gPiA+IFRocmVlIHBvd2VyIG1vZGVzIGFyZSBhdmFpbGFibGUgd2hpY2ggaW4gdHVybiBhZmZl
Y3QgdGhlIG91dHB1dA0KPiA+ID4gPiBkYXRhDQo+ID4gPiA+IHJhdGU6DQo+ID4gPiA+IMKgKiBG
dWxsIHBvd2VyOiA5LjM4IFNQUyB0byAxOSwyMDAgU1BTDQo+ID4gPiA+IMKgKiBNaWQgcG93ZXI6
IDIuMzQgU1BTIHRvIDQ4MDAgU1BTDQo+ID4gPiA+IMKgKiBMb3cgcG93ZXI6IDEuMTcgU1BTIHRv
IDI0MDAgU1BTDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGUgYWQ3MTI0LTQgY2FuIGJlIGNvbmZpZ3Vy
ZWQgdG8gaGF2ZSBmb3VyIGRpZmZlcmVudGlhbCBpbnB1dHMsDQo+ID4gPiA+IHdoaWxlDQo+ID4g
PiA+IGFkNzEyNC04IGNhbiBoYXZlIDguIE1vcmVvdmVyLCBhZDcxMjQgYWxzbyBzdXBwb3J0cyBw
ZXIgY2hhbm5lbA0KPiA+ID4gPiBjb25maWd1cmF0aW9uLiBFYWNoIGNvbmZpZ3VyYXRpb24gY29u
c2lzdHMgb2YgZ2FpbiwgcmVmZXJlbmNlDQo+ID4gPiA+IHNvdXJjZSwNCj4gPiA+ID4gb3V0cHV0
IGRhdGEgcmF0ZSBhbmQgYmlwb2xhci91bmlwb2xhciBjb25maWd1cmF0aW9uLg0KPiA+ID4gPiAN
Cj4gPiA+ID4gRGF0YXNoZWV0czoNCj4gPiA+ID4gTGluazogaHR0cDovL3d3dy5hbmFsb2cuY29t
L21lZGlhL2VuL3RlY2huaWNhbC1kb2N1bWVudGF0aW9uL2RhdGEtcw0KPiA+ID4gPiBoZWV0DQo+
ID4gPiA+IHMvQUQ3MTI0LTQucGRmDQo+ID4gPiA+IExpbms6IGh0dHA6Ly93d3cuYW5hbG9nLmNv
bS9tZWRpYS9lbi90ZWNobmljYWwtZG9jdW1lbnRhdGlvbi9kYXRhLXMNCj4gPiA+ID4gaGVldA0K
PiA+ID4gPiBzL2FkNzEyNC04LnBkZg0KPiA+ID4gPiANCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTog
U3RlZmFuIFBvcGEgPHN0ZWZhbi5wb3BhQGFuYWxvZy5jb20+DQo+ID4gPiBIaSBTdGVmYW4sDQo+
ID4gPiANCj4gPiA+IFRoZSBkaXNjdXNzaW9uIGFyb3VuZCB0aGUgRFQgYmluZGluZyBoYXMgZ290
dGVuIG1lIGxvb2tpbmcgYXQgYml0DQo+ID4gPiBtb3JlIGNsb3NlbHkgYXQgdGhhdCBmb3IgdGhp
cyB2ZXJzaW9uLg0KPiA+ID4gDQo+ID4gPiBTb21lIG1vc3QgY29tbWVudHMgaW4gdGhhdCBzZWN0
aW9uLsKgwqBBbHNvIGEgcmVhbGx5IG1pbm9yIG9yZGVyaW5nDQo+ID4gPiBpc3N1ZQ0KPiA+ID4g
aW4NCj4gPiA+IHJlbW92ZSB3aGljaCBJJ2QganVzdCBoYXZlIGZpeGVkIGlmIHdlIHdlcmVuJ3Qg
Z29pbmcgYXJvdW5kIGFnYWluIGZvcg0KPiA+ID4gdGhlIGJpbmRpbmcuDQo+ID4gPiANCj4gPiA+
IE1haW4gYmluZGluZyB0aGluZyBpcyBJIGRvbid0IHRoaW5rIHRoZSBvZHIgdmFsdWUgYmVsb25n
cyBpbiBEVC4NCj4gPiA+IEdhaW4gaXMgbW9yZSBtYXJnaW5hbCAodW5sZXNzIHRoZSBwYXJ0IGNh
biBhY3R1YWxseSBiZSBkYW1hZ2VkIGJ5DQo+ID4gPiBhIHdyb25nIHZhbHVlIC0gd2hpY2ggSSBo
b3BlIGl0IGNhbid0ISkuwqDCoEknbSBub3QgdGhhdCBmdXNzZWQNCj4gPiA+IGFzIHRoZXJlIGFy
ZSBkZWZpbml0ZWx5IHJlYXNvbnMgdG8gc3BlY2lmeSBhIGRlZmF1bHQgc2NhbGUgdG8NCj4gPiA+
IGNvdmVyIHRoZSByZWFzb25hYmxlIHJhbmdlIG9uIGEgcGluLg0KPiA+ID4gDQo+ID4gPiBUaGFu
a3MsDQo+ID4gPiANCj4gPiA+IEpvbmF0aGFuDQo+ID4gSGkgSm9uYXRoYW4sDQo+ID4gDQo+ID4g
VGhhbmsgeW91IGZvciB0aGUgcmV2aWV3ISBTbywgaG93IHNob3VsZCBJIHByb2NlZWQ/DQo+ID4g
DQo+ID4gRmlyc3QsIHdlIG5lZWQgYW4gYWRjLnR4dCBmaWxlIHdoZXJlICJiaXBvbGFyIiBhbmQg
c29tZXRoaW5nIGxpa2UNCj4gPiAiZGlmZi0NCj4gPiBjaGFubmVscyIgc2hvdWxkIGJlIGRvY3Vt
ZW50ZWQuIFNob3VsZCB0aGUgZmlsZSBiZSBwbGFjZWQgdW5kZXINCj4gPiBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYz8NCj4gWWVzLg0KPiANCj4gPiANCj4gPiBSZWdh
cmRpbmcgdGhlICJvZHItaHoiIHByb3BlcnR5LCBpdCB0b3RhbGx5IG1ha2VzIHNlbnNlIHRvIHJl
bW92ZSBpdA0KPiA+IGZyb20NCj4gPiB0aGUgRFQuIEhvdyBhYm91dCB0aGUgImdhaW4iPyBTaG91
bGQgd2UgbGVhdmUgaXQgaW4gdGhlIERUIGFuZCBhbHNvIGFkZA0KPiA+IHRoZQ0KPiA+IHBvc3Np
YmlsaXR5IHRvIGJlIGNvbmZpZ3VyZWQgZnJvbSB1c2VyIHNwYWNlPw0KPiBMb29rIGF0IG90aGVy
IGJpbmRpbmdzLiBJIHRoaW5rIHRoZXJlIGFyZSBvdGhlcnMgaGF2aW5nIGdhaW4uIElmIG5vdCwN
Cj4gdGhlbiBpdCBwcm9iYWJseSBzaG91bGQgb25seSBiZSB1c2VyIHNwYWNlIGNvbmZpZ3VyYWJs
ZS4gSWYgc28sIHRoZW4NCj4gY2FuIGl0IGJlIGEgY29tbW9uIHByb3BlcnR5IHRvby4NCj4gDQo+
IFJvYg0KPiANCg0KSGkgUm9iLA0KDQpJIGZvdW5kIG9ubHkgYSBjb3VwbGUgb2YgZXhhbXBsZXMg
dXNpbmcgZ2FpbiBpbiBvdGhlciBiaW5kaW5ncywgc28gSSBndWVzcw0KaXQncyBub3QgY29tbW9u
IHByYWN0aWNlLiBJIHdpbGwgcmVtb3ZlIHRoZSBnYWluIGFzIHdlbGwgZnJvbSB0aGUgRFQgYW5k
DQpzZXQgaXQgd2l0aCB0aGUgZGVmYXVsdCBvZiAxLg0KDQpASm9uYXRoYW46IEkgdGhpbmsgdGhh
dMKgSUlPX0NIQU5fSU5GT19IQVJEV0FSRUdBSU4gaXMgdGhlIGF0dHJpYnV0ZSB0aGF0DQpjYW4g
YmUgdXNlZCBpbiB1c2VyIHNwYWNlPw0KDQpUaGFuayB5b3UhDQotU3RlZmFu
