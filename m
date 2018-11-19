Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317DBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31A620823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="k9qqu4Ic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D31A620823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeKSSl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 13:41:56 -0500
Received: from mail-eopbgr710054.outbound.protection.outlook.com ([40.107.71.54]:7500
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726784AbeKSSl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 13:41:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUtYpIkUnUwAvGxtBhU6T9RM09IPZrG2bm5cQtSTE7k=;
 b=k9qqu4IcW+8UdtCmqrUFwAkICULCkezCE2cjWh+eeV+nLez8k/U7H7+EKM3pM4Rs6zSGJYYr7m7kNxtK10uQgeVwIAIBCt0vHN0UuHP+R1/xiNLMSkLeow16go2SQMatvP8xuuzD/e+wo4ea5/CSwDRW4tgvsAMlJw7ke1zlBGc=
Received: from CY4PR03CA0085.namprd03.prod.outlook.com (2603:10b6:910:4d::26)
 by CO2PR03MB2229.namprd03.prod.outlook.com (2603:10b6:102:a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1339.26; Mon, 19 Nov
 2018 08:18:54 +0000
Received: from BL2FFO11FD027.protection.gbl (2a01:111:f400:7c09::169) by
 CY4PR03CA0085.outlook.office365.com (2603:10b6:910:4d::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1339.21 via Frontend Transport; Mon, 19 Nov 2018 08:18:54 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BL2FFO11FD027.mail.protection.outlook.com (10.173.161.106) with Microsoft
 SMTP Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id
 15.20.1339.12 via Frontend Transport; Mon, 19 Nov 2018 08:18:54 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id wAJ8Irsf001636
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 19 Nov 2018 00:18:53 -0800
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS7.ad.analog.com ([fe80::595b:ced1:cc03:539d%12]) with mapi id
 14.03.0301.000; Mon, 19 Nov 2018 03:18:53 -0500
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "matheus.bernardino@usp.br" <matheus.bernardino@usp.br>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "victorcolombo@gmail.com" <victorcolombo@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 3/7] staging:iio:ad2s90: Add max frequency check at
 probe
Thread-Topic: [PATCH v2 3/7] staging:iio:ad2s90: Add max frequency check at
 probe
Thread-Index: AQHUfvbfh1n37K0Q/k6pFxHZVzUF/KVXFuQA
Date:   Mon, 19 Nov 2018 08:18:53 +0000
Message-ID: <8d86411bf3267e9d4c72f725d3da87ac4bace203.camel@analog.com>
References: <20181118042540.12697-1-matheus.bernardino@usp.br>
         <20181118042540.12697-4-matheus.bernardino@usp.br>
In-Reply-To: <20181118042540.12697-4-matheus.bernardino@usp.br>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A36684CFA48A9498407F9F79AF3FF5D@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(136003)(346002)(2980300002)(438002)(189003)(199004)(23676004)(106466001)(4326008)(76176011)(7416002)(186003)(26005)(478600001)(356004)(39060400002)(2501003)(86362001)(2486003)(36756003)(246002)(7696005)(14444005)(2201001)(2906002)(106002)(8676002)(229853002)(4001150100001)(476003)(7636002)(7736002)(126002)(50466002)(305945005)(316002)(486006)(3846002)(2900100001)(14454004)(102836004)(5660300001)(446003)(11346002)(110136005)(54906003)(47776003)(6246003)(8936002)(336012)(118296001)(2616005)(426003)(436003)(6116002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR03MB2229;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD027;1:6oXhTu7le5RZe5BEAybYt8dgu2pYT46P8eimHVPTxDxaSD1aWF1djy5yZusH2mC048LrAvkntYNJS476bSZSuzxRrHn9KrUnihs7hMLndKGTPaWACvmMmR5woSC5WiXz
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b36e9faa-96a5-4e8d-fba1-08d64df7a519
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CO2PR03MB2229;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR03MB2229;3:7hC7V5Le6YBYhdnwfY1F7ERekOJ5A8AmLnVwEZ7S2h3n2lPFtAbGNpstBO7brVrA+E0tUTj+cIk+cB6gxmm8Cx44OxaxzNovolGQ0sxy0UVNZ8GJtlQFK7Y0Iyeb5BsQnvowcBzT/LfrnKmVGTn9saGIDQC/+s/Wy1qiLDKoTsF1MqHYVZtpMhG2fozwr4NJH/Z8c0PCeK5V+GwkQG+nsbqHIKa6na7r6Uq88ViwlmSIugeyFufBpDmIioti4d2i3yktEU62glzYsgwQvo+2TR+sSOU0IJS66pHOZpltqgMTa0cVS+7FW6dsC4zHsmwBh1+YdGd4x36+tO417DyEEtRl6Ep2JqoTLkCFuZQVz/U=;25:Yrxtksctl+Qbzwt+K/LskJud9x6guk0kBq09hEApWtLxLAiEVw4/g0nM1HA89Vn1N4K1EvHdyvUMaMV3tvSVJPIr881nvJ0wszruJR4rX9+e3n9pgO+ROUNLQe9OjaKfYECbM5mtt1PSAwqekG0DigP7+LXtks5+oSJgGUhWaAKvcxTZGrJiSTCc13XN69nuclo+LFlUWE2TUlHvR9Ym0ZJGH6dtSecg3WPE0lrzJWDomndrktaVY+mHJYDc640sNXur/FZrurWOkGSLjdBSvIoa92c4cMAcUzApv3h3pn1jZBwpswAAjD7QijCtYCoc8R07I/OzWfoeNUfnbBqIOw==
X-MS-TrafficTypeDiagnostic: CO2PR03MB2229:
X-Microsoft-Exchange-Diagnostics: 1;CO2PR03MB2229;31:tmaeF67VdHKKzs96UDkkmPi/bFsC+vONlB++jG+QFCHBFiIA2ch/e9f+hpRTuXzynm7IW03UuIAZytSol/MRaEaIksvlG+oXfWFPClKWLzW1CNJNB9ARN+GHa8Wevi1wdlsChv42bnSgv14y4aBEz7f+DmaaO/efAVpYp+tWQYmvBtMauj4Ujh82WSrwzy6Q2IrWY9pPsdN6luQoWlZQqt6VBPVKlKLm3ssXbTgOgN4=;20:jT+/1mGCiodXAmIZpGYE7y2WdqeVwW3rZOad4JUTqo3OzSjemqeAErP3lhszBS7mN75y9/PJ0M6bmkVWc62UzCUKC2w0VDsJb1Ze9TtkY/jzLVxmD9Xmvlhg33SFDMiw8xqxniecHYM49HsMYucZmHCokXN1hNqeSZatkE3h3UufhCCR2mvfCbkWlukESdvjjuak9XKaWDZe3V9HK9aukain/Ke6/vxYFIWcFx28RwnNwo9sHEk0mIpSDzDWW9WysKSqSU4edtnNAExURHb8D9rv6DluX6bZWjZHHZ1k6vt7IZzyDOrME45MutZOKnnx3UXqwyKzHceLjly64QU7Pbd+pJnRnr3y7Fe9t27x1Wp2C5xjqFRs+dH1V2EO7JdQIiSoHWuBdtoA5OjyomPucBwr9Cl/15Z7mRrJL3JeWsdtEdrLNrSGCcBFtbe0zEeROuul/X4rexUONZe0acOKZf5chqoCO4wjfwir6S16wnJGGvibr816jMlkKQ3BqgP0
X-Microsoft-Antispam-PRVS: <CO2PR03MB222919DDEEA77DF4B440D8AEF9D80@CO2PR03MB2229.namprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3002001)(3231415)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:CO2PR03MB2229;BCL:0;PCL:0;RULEID:;SRVR:CO2PR03MB2229;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR03MB2229;4:FhK7VWMGGQD7J1TOmlDTwZ2tViIvrL7J9QvS2jvMMcM6h8/YmEb8jdT/4ZwxGTB9QUFB2fL2waUwjrwlAQ23Ap2KwdoVAvdA3N7H8Yuh1jV/QZVjgAbya1A+MAQGjd+CXU4jiMck/vAR7Xbus3d3yXLGqwyICHbl3vYG0zqEDmASLFKf5Qv9nP4CeJV8UHlSohEY4AOSvUOu2qWSq5x5AKBeHITOHnVup5kPRIN6cZ6tiQxiDQmQTv4JWGiFF+OxyxuHu8VxcmIlT9Azeu3wmA==
X-Forefront-PRVS: 08617F610C
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDTzJQUjAzTUIyMjI5OzIzOjhlZWN3enpHTHJrWGJtQzZHRzlHbUZ0a0JH?=
 =?utf-8?B?Nk9qYmlCQWRNbFY0b3NUUkVYY2p3UHBZZ0xoOEZBRTY5S2pzVE1QcC9oYXNa?=
 =?utf-8?B?NE45U2lBQnVvVXpheGU5NTQ2aFIydGZNQktoYjB6Qm9UQ200T2I4d3RsNDk4?=
 =?utf-8?B?VkREUS9uZDE2NFhOczdJUi85TlZJUFUxWGx4RE5FOEpJS0NnSUFHR2dXZnBr?=
 =?utf-8?B?bkdHbURSTVpxbUQwNk1RaTRyYXRwR1paTVFRN3VLN2orMzVNQWpLcUxIOEJP?=
 =?utf-8?B?cjVEOWdwaGQyb1dHcUFrV2ZKSnAyd3NZaTVjTUVOaVcvTnhxR1UrWVFjTUpK?=
 =?utf-8?B?YzBnWjRLRHV4OUZxTG5JZEFiRnFjb2FSeWtuN1I1ZDhPSjR1dzk0a2drZzZk?=
 =?utf-8?B?eWFyT0xReFhnUXpiR3VldHN2eG1SQVpmcFpKR2M1aE9qWWRPTVdpdy9PeXBK?=
 =?utf-8?B?TnRKc3dNTUZxR0FSN3BtUGZ6SkVnNGljVVhJWDA0eHNnWHdVNWZVaVkxbWUx?=
 =?utf-8?B?OWtNbVQzR3BQYnUrNGxxZExhVjdMam1XSEVSdWNPaUw1UmpiaW4vd1ErdDBy?=
 =?utf-8?B?alVFR1UyaWw2OU5SQ2trRXJQSnA2dVIzeUpQZ2dtbXE0UUhnb2I3RUdvMEZh?=
 =?utf-8?B?RDVUdkJxd1NTMXhLaEt2Q21jNWcyNnEzVlZHelk2aERqYTlRSHB0SEN3dkww?=
 =?utf-8?B?NllkOWJTQVpRczZidjZaSHFHNkgwWnNmVWZHM1c4Ti9kTVVKL2xXRFFkT0xY?=
 =?utf-8?B?SzRNUVNWTUV5NGpnd3BTNnduYUdETm81ektLajl1SW1JTzM2Qk5ZQUFVR1Bz?=
 =?utf-8?B?Nk0yKzVGc0JoekJkZnZhYVJ0WndJZHptVXdlaTVsMlFvSndieEY0SGZhYzhY?=
 =?utf-8?B?Njg5Z0ozNDA3ZHpDSGxqUHg5Mk83UXFFSjhuNUl0VlNvMGYxRTRQaCtiaFdB?=
 =?utf-8?B?Z29QZjUwR1FVVjJkS05ITDJSc0YzNHlqUmp5NWpRak5vSVRqT2JIaDI2NWV2?=
 =?utf-8?B?cmtuNWpKRVBjNXlFYTJTMWhldkZtdDlLMHVWOS81KzBNdENnMFJHR3NLTHZk?=
 =?utf-8?B?WGtSWGE5aWJCeEV5R1JMWGRuSUZpUXc4ZlJDM2o5ZUNFUzc3amczdUxVa2lz?=
 =?utf-8?B?UWRscVk2ZU8vQmppTW5MeXBkcHBHNEFIZEMwb1VSQnZBeW1pdEpSb0NiNUs3?=
 =?utf-8?B?a1U2YVR2bXFrTmp6dGFTMzd6WkppbjJmeG02VnQwTUNYeXlzTTV4cUpKcGo3?=
 =?utf-8?B?WTdTYmwrUUlVUU1Za1dUYVo1VTViVUE5RUlpK3JpdjVUbkRndnRzSkVtdC9n?=
 =?utf-8?B?WVBuUVN6SDZmUUtMaE1EZ2lvUFplazJWcDA3bkMyWm1wTmZpVFFrV1lndHRJ?=
 =?utf-8?B?dVVNa1MyVEsvVGFSQXhFcjNIT3BYMG0xMXhTMlpSUEF1YUo0NThPcVBEUU0v?=
 =?utf-8?B?TFJnUkNibG9zblFic2VxeFA4b3J6YkhIclgxZGF0QSs0aEo3ZWpqS3htUUFP?=
 =?utf-8?B?a0NmbmlxUEh3Q01CaEw1VUJ5WmdUWkl2Y0xPK3R3clVlL0o3eXZrUjlxZThq?=
 =?utf-8?B?V0plU1puUnQ5b3pKaFkzRDdVMUFlMzQwTmh3dEtpeklpMmkyYjhLby9yOCs3?=
 =?utf-8?B?cS84QktlRGg5YjRReUxBMFdYM1NoUDF5dll1eHpXQ0U2ekM0c1JrZjNaeTVn?=
 =?utf-8?B?d1pka2E1RXVKbklPZnV4S2x2QVpPUUk2ZUdZSml0dDE1MHRyY0RJK1BBZTRX?=
 =?utf-8?B?NUk2UnRsZXZGSFlnK09pdz09?=
X-Microsoft-Antispam-Message-Info: 6ElVMN/rB6QCLcxkIsUtiomDBQW9RemPdeHcVqqdabnp7ubriVQZscPQuK7xnY/lxOBkpwLuWOeX+r/LxMeTw5/5XaKmF1z9d9MZTq8obP3yPGQJgOuvOJNlsfV1vIre1frFlqrAFCq9XkkCtHq0RNslFw+rxa0Gg4bclFf2JTo+2FY8kyg7Uvwtvxv/jf4cFkl2WhYoYRp2lak082HW653esXUZx/wWTlc2AOdrrQbIsrL7LCnq1tUl2/FSwu7sVzXH9/TdzGQ83FYaqftoUfuQVHT3Hna02Ak67DxxNVJDoRR+ZfBC1z8pFpn834YAwJbCBo5pdO6FrsHILq0CxwGAWIHQy/9FZgCMZEvKIgA=
X-Microsoft-Exchange-Diagnostics: 1;CO2PR03MB2229;6:6a1YEHi+y4VqGpWco1dK2gRRQtrM2Kc2l88+W3ikrmHwEP7/laSepvtfJSU2c/qFJA7NozFj01nN1CEn7HP1hxaTZG2319BMme1PMVs4TMGoLrEN+RdBjN1tWgaGwTymZL5XIh03IGYCyH9DA+U0YM4e33PxPolCVlOHHMFYzAggFfh3R5qAp/XSc1ekPdzNo7sxvypinJx9LyBgfkBK5UaTRt7opkR0hEtK05+MamGLPo2RB5LrLPWSHK9MKYJvVoQZOCju9NsaFLa08fVFOhxikuf3RQIHexV+lVQ9syW1WZtQsfVTxGgyttmVdksVmv/HcCe9QVmBWRsKa/gsb86dYYup+7gibmbUh6qfavncizX/UzQlEuWzok9lSjQO68qziSAysH/3i8MXJjfzh6p2w15LBTF/JdcLsHrZHsOCGoHdV5P8bgQPE8m0rmk4hRCSKRwDiYiRs69cBDb0yA==;5:tAL/qW99uuf5OkIEiYNWvxE/FY/B/ftPaXjXIJ2QD60Wf7Zj/Ki/rJKYJqk62wsqURnXKf0pS58KQummG8PV+58e0infyCtGlCbQg45Ye9y+hAl9OBx35h7p3LGieiJccW9Is5DOIwQ/TnCcNLWtmAcww7RZOOF4/bpBipCj+xU=;7:vC+jHALskJNVp/v3HwFW2LZ2OCiYq55Urp0/sSRcN+KZZGL1ygI58HhnoQrvouay8R/qBT/iWtNRYJOzjRiPtMUYLWqMDnwi8na+zFDS5DTo4UiNZXKdK9Nf6/kXzjhrTi6swJ1LsRh2PEPR+9Etuw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2018 08:18:54.0770
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b36e9faa-96a5-4e8d-fba1-08d64df7a519
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR03MB2229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDE4LTExLTE4IGF0IDAyOjI1IC0wMjAwLCBNYXRoZXVzIFRhdmFyZXMgd3JvdGU6
DQo+IEZyb206IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5j
b20+DQo+IA0KPiBUaGlzIHBhdGNoIGFkZHMgYSBtYXggZnJlcXVlbmN5IGNoZWNrIGF0IHRoZSBi
ZWdpbm5pbmcgb2YgYWQyczkwX3Byb2JlDQo+IGZ1bmN0aW9uIHNvIHRoYXQgd2hlbiBpdCBpcyBz
ZXQgdG8gYSB2YWx1ZSBhYm92ZSAwLjgzTWh6LCBkZXZfZXJyIGlzDQo+IGNhbGxlZCB3aXRoIGFu
IGFwcHJvcHJpYXRlIG1lc3NhZ2UgYW5kIC1FSU5WQUwgaXMgcmV0dXJuZWQuDQo+IA0KPiBUaGUg
ZGVmaW5lZCBsaW1pdCBpcyAwLjgzTWh6IGluc3RlYWQgb2YgMk1oeiwgd2hpY2ggaXMgdGhlIGNo
aXAncyBtYXgNCj4gZnJlcXVlbmN5IGFzIHNwZWNpZmllZCBpbiB0aGUgZGF0YXNoZWV0LCBiZWNh
dXNlLCBhcyBhbHNvIHNwZWNpZmllZCBpbg0KPiB0aGUgZGF0YXNoZWV0LCBhIDYwMG5zIGRlbGF5
IGlzIGV4cGVjdGVkIGJldHdlZW4gdGhlIGFwcGxpY2F0aW9uIG9mIGENCj4gbG9naWMgTE8gdG8g
Q1MgYW5kIHRoZSBhcHBsaWNhdGlvbiBvZiBTQ0xLLiBTaW5jZSB0aGUgZGVsYXkgaXMgbm90DQo+
IGltcGxlbWVudGVkIGluIHRoZSBzcGkgY29kZSwgdG8gc2F0aXNmeSBpdCwgU0NMSydzIHBlcmlv
ZCBzaG91bGQgYmUgYXQNCj4gbW9zdCAyICogNjAwbnMsIHNvIHRoZSBtYXggZnJlcXVlbmN5IHNo
b3VsZCBiZSAxIC8gKDIgKiA2ZS03KSwgd2hpY2gNCj4gZ2l2ZXMgcm91Z2hseSA4MzAwMDBIei4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVs
ZWFuQGFuYWxvZy5jb20+DQoNCkkgdGhpbmsgeW91IGNhbiB1c2UgIlN1Z2dlc3RlZC1ieToiIGlu
c3RlYWQuDQpCdXQgdGhpcyBpcyBhbHNvIGZpbmUuDQoNCj4gU2lnbmVkLW9mZi1ieTogTWF0aGV1
cyBUYXZhcmVzIDxtYXRoZXVzLmJlcm5hcmRpbm9AdXNwLmJyPg0KPiAtLS0NCj4gQ2hhbmdlcyBp
biB2MjoNCj4gIC0gQ29ycmVjdGx5IGNyZWRpdCBBbGV4YW5kcnUgYXMgdGhlIHBhdGNoJ3MgYXV0
aG9yDQo+IA0KPiAgZHJpdmVycy9zdGFnaW5nL2lpby9yZXNvbHZlci9hZDJzOTAuYyB8IDEyICsr
KysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvaWlvL3Jlc29sdmVyL2FkMnM5MC5jDQo+IGIvZHJp
dmVycy9zdGFnaW5nL2lpby9yZXNvbHZlci9hZDJzOTAuYw0KPiBpbmRleCA5MTNkNmZhZDJkNGQu
LmZlOTBmMjA1NmJmZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zdGFnaW5nL2lpby9yZXNvbHZl
ci9hZDJzOTAuYw0KPiArKysgYi9kcml2ZXJzL3N0YWdpbmcvaWlvL3Jlc29sdmVyL2FkMnM5MC5j
DQo+IEBAIC0xOSw2ICsxOSwxMiBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L2lpby9paW8uaD4NCj4g
ICNpbmNsdWRlIDxsaW51eC9paW8vc3lzZnMuaD4NCj4gIA0KPiArLyoNCj4gKyAqIEFsdGhvdWdo
IGNoaXAncyBtYXggZnJlcXVlbmN5IGlzIDJNaHosIGl0IG5lZWRzIDYwMG5zIGJldHdlZW4gQ1Mg
YW5kDQo+IHRoZQ0KPiArICogZmlyc3QgZmFsbGluZyBlZGdlIG9mIFNDTEssIHNvIGZyZXF1ZW5j
eSBzaG91bGQgYmUgYXQgbW9zdCAxIC8gKDIgKg0KPiA2ZS03KQ0KPiArICovDQo+ICsjZGVmaW5l
IEFEMlM5MF9NQVhfU1BJX0ZSRVFfSFogIDgzMDAwMA0KPiArDQo+ICBzdHJ1Y3QgYWQyczkwX3N0
YXRlIHsNCj4gIAlzdHJ1Y3QgbXV0ZXggbG9jazsNCj4gIAlzdHJ1Y3Qgc3BpX2RldmljZSAqc2Rl
djsNCj4gQEAgLTc4LDYgKzg0LDEyIEBAIHN0YXRpYyBpbnQgYWQyczkwX3Byb2JlKHN0cnVjdCBz
cGlfZGV2aWNlICpzcGkpDQo+ICAJc3RydWN0IGlpb19kZXYgKmluZGlvX2RldjsNCj4gIAlzdHJ1
Y3QgYWQyczkwX3N0YXRlICpzdDsNCj4gIA0KPiArCWlmIChzcGktPm1heF9zcGVlZF9oeiA+IEFE
MlM5MF9NQVhfU1BJX0ZSRVFfSFopIHsNCj4gKwkJZGV2X2Vycigmc3BpLT5kZXYsICJTUEkgQ0xL
LCAlZCBIeiBleGNlZWRzICVkIEh6XG4iLA0KPiArCQkJc3BpLT5tYXhfc3BlZWRfaHosIEFEMlM5
MF9NQVhfU1BJX0ZSRVFfSFopOw0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKwl9DQo+ICsNCj4g
IAlpbmRpb19kZXYgPSBkZXZtX2lpb19kZXZpY2VfYWxsb2MoJnNwaS0+ZGV2LCBzaXplb2YoKnN0
KSk7DQo+ICAJaWYgKCFpbmRpb19kZXYpDQo+ICAJCXJldHVybiAtRU5PTUVNOw0K
