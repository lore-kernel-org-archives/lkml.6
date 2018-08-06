Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCAFC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143C721A38
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="rkbHtBw9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143C721A38
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732957AbeHFRtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:49:43 -0400
Received: from mail-bn3nam01on0083.outbound.protection.outlook.com ([104.47.33.83]:7520
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729724AbeHFRtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbVheMZgVnOakf8vBi9pdM5pSCmAfTpkV7nHWwbrthA=;
 b=rkbHtBw9MNhrxCiGZ6KGrnDqkX2glK0bSLo2yEMQGtfRo94LH1QlCntU3zAm+vNt1zcDw6CwBRa9BP+TFeYXBwDw8sdvyz4TZwT22sOswcxurFgWzVNwTT7BF1FUss9T3eHMH90KHV9Z03yrKUaBGgX+Qui0KQiS5KFSqZhRuRI=
Received: from BN6PR03CA0002.namprd03.prod.outlook.com (2603:10b6:404:23::12)
 by DM5PR03MB3130.namprd03.prod.outlook.com (2603:10b6:4:3c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Mon, 6 Aug
 2018 15:39:55 +0000
Received: from BN1AFFO11FD010.protection.gbl (2a01:111:f400:7c10::175) by
 BN6PR03CA0002.outlook.office365.com (2603:10b6:404:23::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1017.15 via Frontend Transport; Mon, 6 Aug 2018 15:39:54 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; davemloft.net; dkim=none (message not signed)
 header.d=none;davemloft.net; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BN1AFFO11FD010.mail.protection.outlook.com (10.58.52.70) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.13
 via Frontend Transport; Mon, 6 Aug 2018 15:39:54 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w76FdrJv014964
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Mon, 6 Aug 2018 08:39:53 -0700
Received: from NWD2MBX5.ad.analog.com ([fe80::49e:7a9f:284e:1a49]) by
 NWD2HUBCAS7.ad.analog.com ([fe80::595b:ced1:cc03:539d%12]) with mapi id
 14.03.0301.000; Mon, 6 Aug 2018 11:39:53 -0400
From:   "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "leonard.crestez@intel.com" <leonard.crestez@intel.com>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH v4 3/6] regmap: Add regmap_noinc_read API
Thread-Topic: [PATCH v4 3/6] regmap: Add regmap_noinc_read API
Thread-Index: AQHULX3lmADMg50hNEu4jWxWJ+IIGKSzDoCAgAAQ+IA=
Date:   Mon, 6 Aug 2018 15:39:53 +0000
Message-ID: <1533569985.11050.9.camel@analog.com>
References: <1533557087-10401-1-git-send-email-stefan.popa@analog.com>
         <1533557087-10401-4-git-send-email-stefan.popa@analog.com>
         <20180806143901.GP2414@sirena.org.uk>
In-Reply-To: <20180806143901.GP2414@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.110]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <45EFF5F1965E4A4098CFDE159DB03EBC@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(396003)(2980300002)(438002)(189003)(199004)(7416002)(23676004)(47776003)(7696005)(76176011)(6246003)(2486003)(4326008)(305945005)(6916009)(26005)(102836004)(2351001)(186003)(5660300001)(2501003)(3846002)(5250100002)(106466001)(6116002)(5640700003)(316002)(229853002)(336012)(72206003)(86362001)(356003)(50466002)(478600001)(476003)(1730700003)(246002)(486006)(436003)(11346002)(7736002)(446003)(7636002)(2616005)(8676002)(126002)(36756003)(426003)(103116003)(14454004)(106002)(2900100001)(14444005)(2906002)(8936002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB3130;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD010;1:ABLylvd8qymAmHKkbt4WyAX7x7eSje46riJjiGGPdBLQ+iBb5otDoCh8Yml78tJ0EtiqoIjn/63QRJRyPnDzC0QzeqL+cgTYlHgWcfwjn30D32FXSn4/QrZ8tFUuPY+7
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ecdc257-b3c3-46b3-57f2-08d5fbb2db29
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:DM5PR03MB3130;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3130;3:8dxnKPvhcvzYJ5aDRpd+JTCNKOhQMdHLnJVXqtM6g4qIsW/SVdMT4fAUdCW96JhJvqyOQElIjufIT+RueqGg3LdGHZdVQG+tJWV9RM7C/KiUTLDXR0+GEA+mtodEJOi02eUpqF312TQi2yhO5nnGvqJ/U9CWUBifl4fWaPraqnUfa4b9VToh35a9a6alt6SsPD5DabCe03XEV3QleVYoEGDcMdurhcN/haJk1aNHKVA5xrw7gsJqLeha8rhaqaS1gLZCZfJOtvdOpYL2CGfRHqFAX7/ZyDagsVCoatfQ+z/CyoKv12bMWyNv/dc5MR42kh6qjmTrxZlmTjxZ5GK1aXtdgpQVlfZOKqPJNa8Qm0M=;25:o7Pnk1z8VN2idlvutxDD+B8Pf2h7IIt9mSloYX5A8ccAf3ij3jeV5mRhIXca1p53keV65o1YebFTKG30UhllSvKSSDfB3Xj2Gla/mUWkl1WYOm80Aj7alGMqjQFRUnp5pF5zbrqL2rdQZh3hmApafLj8GUB2kOj2LycTYTsJn1V5of9Igg0f1Zk2J0HUmPeifhOtEgzI8bM5mGJmI5plC1nS/zXu/+TsvCDfNSLVFU0IzOxetNDwtiUFU8T+Y98ihL27V0xyfAxsRKD9p5oS40gihCQim0/NnS8L+jfbijh7yiu5SPoFTi7jSDntCEIhQBDwC0ga1/jKrgYf61ajHA==
X-MS-TrafficTypeDiagnostic: DM5PR03MB3130:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3130;31:BydgKF+2VQ++oWRirc0Q2IrQatMf8ZWw9+9b1VqsAmpWlqjPtHMQ6E8XWGQ7BPMADBuFMchd4ysKmOEHGqEREeFY3lEpY0ClXdJqFvyEcUxt9QWqEdQIWotHsEGVvtljX+D43ZHDCKmo8/bF4rnU/k4iUr6pWlfF1mbAJdV/OE5jGRa6t6modEnv0H3f0G8Wu8ZM56s6R5yROP1tVd8CwnHIcZdJsTyYX9smnKUxGxc=;20:WQZ18WOCfSL8Nnihx/tYawYb/MD2fkWCbgAuvUjmm27JmTADFYbQneVDIqIefKmApk4eTEbdOAT9X21fiM8zOoY/+eaaacewww9utpqXl5pSCQT2Qu3E3W3dkrrYAUHfEupgFxYcEgj/uBbcarAVq4ayrkZP70za/jBKI7dQEqUkiBsKNopc5029s8gWv5fu8jessEgiQUPbCGvP/uiyU9rDWd96GAO7AqF7ZMK2zjlW0KbHb1yrCaVYrYBQraWVa9mnKaqOqwemyAUqdjuPg+8r/zv2RyFRYRQv/gY33dDzwnw3UurbieWfIoXZwAp1Yz4uWEuDOOyyEjRsTiMw0o8iZVYSxN1KJf2JOEkwl84ZtkefnLzhPhq6s3t4/skJ91idWVpUUpHj7twc8cTIA1ofRB03lgXhJ8YXvYHbEX5MvUjzQ+m1ZjSvahID4Llvzu1Ax3Qpd/dXl0SMjeJgUN4+FOSDE3//37I1314yUpdewOsuK1APufOVQDoRt3Hc
X-Microsoft-Antispam-PRVS: <DM5PR03MB31308977760F91D7C273206F9D200@DM5PR03MB3130.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(93004095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM5PR03MB3130;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB3130;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3130;4:UPtl+vXEgY7cA6TDx2qAJeAhOAEjqGPWwAytDBbpHufyaoFh/49m5JHpIWhCdnwIR7mydWcTp/AcTiwAw+JK4GgFA2B1Vdl4suFEVz83C4e/ttGD6Yni6yPzjiwv0Ynk+zq7k8eaKOx2d6F5+O3x3/vi67PfOqe5vKIqT1ctSHdxFEaWagXw6CKrrARe0cDAZpvrosLs9YNf7AkBdAtNNn0IlVx3nXLlS/bwrUYWtCAmSO9Onm1zHvXwtp3vTYXRQhtHNO/EnvMG/7m4PdZ/5w==
X-Forefront-PRVS: 07562C22DA
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjAzTUIzMTMwOzIzOmQxc2NML3Z3akNwdVpMRXNsd0VQVEVZMFUy?=
 =?utf-8?B?RC92VDlFNzVZUlA4OW5USUYwYkp2akZSRW9pZnFaQkphVjRoK2NsU2tFek5u?=
 =?utf-8?B?R0kwYm5Pd2Qra2I4ZUJoTDhBNGJVQ0dhVTBVT2hVaG81WC8zdlB3STQ1VUhD?=
 =?utf-8?B?aG5LRnd3SHJvNGdLeFl6aXRONGdrK04xUk9tL3NtT0pIak0xSzRZTFgwNzRo?=
 =?utf-8?B?aXRJRStNZUNtUmEvYW5lNkVQZmp6S1hBR0xkeVBaOFlqSUJ3dVc0OUNNNGZx?=
 =?utf-8?B?SkE3WGRRVXpsNERSODBob053cnU1eWNxVXhFMmdtRUhQWlJTQytZMlE3bTho?=
 =?utf-8?B?U0h0S2h3MnZ4dGxsdGJxOGNFdmdBN29iRW1PMUttSE5aQ0ZROTc0VUJLLy93?=
 =?utf-8?B?NG81SWtGZ0pxK2d0dkNkSXFEcnVOZ2hIVWZLKzFncU83RUVTSzhMQXY2OHVW?=
 =?utf-8?B?dGtSbHQ1WUVEd1UxNEN5eEZTQkt3N3lUb3NvWFRraW84Mkd5TFZsRGRHSldS?=
 =?utf-8?B?Z09sRWFIVWtJSUFPQ1RiTTRJWGI5ckoxS1lQbnZielR0emJXLzhHNDdMbTlF?=
 =?utf-8?B?aGhIYTZocjhISkM4T2cwVjBwTTRteVpLRmlQUkhNY2tHR0VUT3gvZlBncExp?=
 =?utf-8?B?RThqcEh3cThhMmtJbmo2YjVDS2ROT3c4aGpsREFPcGpuQko2YXVITDYxdDc3?=
 =?utf-8?B?VSs2WWxtSXpwSTlRNittTERkUU9ibmZWdnNDV0RIVFQvM29QbHJRRCtZM3Z6?=
 =?utf-8?B?bmxMTjlGbkkvdHc4K3N5cXF0c0ZZYmwzWTN1WVU5c05BTWpid09HZ0ZYZ0h5?=
 =?utf-8?B?dTJqa1BEQnVRZURoMU5pUnBkbXZwOW80bGsxekNyL01qbHViUThESEFWczN1?=
 =?utf-8?B?SjNpU2x0OGlpNERtaEtDenVGZzRxd1g2ZUljUFd0NWRJTEJ6cGV6MHNNVDZz?=
 =?utf-8?B?d1JuSjRzSWxKNkZRVmRyUVdhSFFRajhTMTU2VjhzL25kUDdYR2VuRldreUhu?=
 =?utf-8?B?SldrbGdPNHFqMXRiVlJRMjVDb0lwVDB4MXNUVTV6Vjg2b3RWOVpMdytjVXd1?=
 =?utf-8?B?bWVpYzB0QkdvYjNvR0JwQlB2eUUwSTdNVUt3LzhON2RmZGNydFY3cm5PK1dk?=
 =?utf-8?B?aTJ2YUI0Z0luUDlZSDE1eFVLZ1d2cE0wbGpBWHJxOVJkVWZiTlRIMXU3NHpa?=
 =?utf-8?B?eHdhZFBTRGlnenpGYngzbnZkZGtrcU4xKzNHWGZOLzN1RjV5WXJSRlRlRU9Q?=
 =?utf-8?B?UUVFWDFxaDh0L0FvTTBIdXpOSGpjNUtkNmlGOXlrUFYxeEowdXNybmdQWXF1?=
 =?utf-8?B?czBwbkpRcTVmdDF0VU5LSFVOa09jQjlYOUM2ajlnOC82NU1zSlBTV01pR2NV?=
 =?utf-8?B?RlM5UTdxclVUZlZHcXoxVjE3Q2VFTGpQVmJKWkhyMDVCZDloQzc3REh6MkFG?=
 =?utf-8?B?MEpqMVMyNDQ1SXYzcEZzUnNVVDBaUGUxT0tFdzdIMWtMeURyLzM1ZkN3Wjdz?=
 =?utf-8?B?Ui96UGRXQllNUUZ0OTZQeWN3QjVwbmNOTGo2WkFFcHJxSGJLKy9GVEJKV3hF?=
 =?utf-8?B?WDZxREpzYWx2bEIxQ2w3S2dETDhya0lST0dBZmxrMGRVczlnWWtXeWp2NEdR?=
 =?utf-8?B?bThWd1FHcDVUQXhSZHFkcWlZSDdYNTA4NEwxRTZqUThEUU1MZW5Bak1VMko3?=
 =?utf-8?B?OXNjZU1jTHowUUpyUnFXSWxNM1RQbTJpUWtUaWhoSnhhTy94TWN4Q2l0WHo5?=
 =?utf-8?B?eXlPbC8rRnhicnVqd0dxUT09?=
X-Microsoft-Antispam-Message-Info: Hc8k4U9ihOax1caEPoi62ERJlb4kFlCKkIkt0s160az3Ve0xpC4uT1pLGayOsgoBN3Exhsjj6D4C7sHyOYnYhw46161d16DTy6x2pdIp0ZTy+BQ7Zw9Nk2hQX1sHjMfUBHylK5IhjRdA4s6uL/cuKlhcAH3GpdfeLQK8YhcXmkRMGXxp4d29qjBm5igSiYKpsDPHCRTBTMU5yUjugJ7u9NDz7BOlGzX4MWRh6LkzXfZhVN6FPnMg3JY34M9CauZUt5EuFXC9cfbMRDVuf4r5NPv32/YMJ9s4DV4FIB3nOn/ncS6/xHJwuHOTUVPI22BWeA/jgmdk/7UZ3Bb4ix99SjvbJF0GTxiMV7mb0EM/rkU=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3130;6:yqIRQEN0FC9EaFKESfNily8laYmMGtW5rzxfad/rE8JVICddHrDxxAsoCPny6MHJ0g2HAmgOPiSekxLuPNQjf6EGFeF9zUFfVz/y7B3xpfZsV5t0uzOZv9khmVY41fSJKpz7CvdiIdcBLsvSNGI33UZ+QBIR7k7r25TJEx2yWILY16E1wxoRzlSwvyvMYW00Fsl7SK/NGK0IHBfLax+/Iaz0LsWyj1aXA6zg3aro0yqWAKrEPbNLzaVnaDKUsSyXMZiPPnYqJ0NmjfoX+Q5khKA3NJHYdj0iDUe4ddl65kMBfzoOxPu0YHvijDOa0UzIWb7GHvHvNrwEDJN+wB016RdDs7Iv1Ayq6XA2/0CeLMCSLrwmNbDZxbZIpbF1Yjjrcoz2sZtx4g+dYHGUAFqbxI5Rji8aVtn9FTRv/iBH+jPzLGDD9ClZ0XRCvRGe0f4iNT3DOwgHFGCFULs53eGQ/Q==;5:Sf4metHBmx3E1MbSgKhh3OWulObGPSkr0YdbWIWDrqpR9xa/V3viRVMIbQyDwb8uEfxnvU6+2YDS1o1WdrBEJeZiZj9anXe42Jvu07ofGaP7Lv+OUqN9vRNfwWxVNgmCAF/nNrkIRX7A2ZEbUFvJiORNM/egfUwc0qiDPMzfOgY=;7:Z9jhynixtd+tmTYh803AKTPGsMhqeUR/Gw0GOOf6ouwzMq1MjhgxRciOwUO5uqJQebF1GDZSqPnIeVRK6Fv8Ej7+6WKYT2+tjFpzUSjnVsSCTuQ0qCqo/bVEaQvTGiqonGSxMKRyXlrmYTDpGw3ztNkxjEUd0s2qIg7Ab7fu8wk3RXwAAzbd4n3+ruS468KpHqOkGe84TG7BsEnWr19oYx6O5x4CQk6sieNAI+YREG2q01Kpg2qwRLvAldjqj89n
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 15:39:54.1369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ecdc257-b3c3-46b3-57f2-08d5fbb2db29
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTHUsIDIwMTgtMDgtMDYgYXQgMTU6MzkgKzAxMDAsIE1hcmsgQnJvd24gd3JvdGU6DQo+IE9u
IE1vbiwgQXVnIDA2LCAyMDE4IGF0IDAzOjA0OjQ0UE0gKzAzMDAsIFN0ZWZhbiBQb3BhIHdyb3Rl
Og0KPiANCj4gPiANCj4gPiArCWlmICghcmVnbWFwX3ZvbGF0aWxlKG1hcCwgcmVnKSB8fCAhcmVn
bWFwX3JlYWRhYmxlKG1hcCwgcmVnKSkNCj4gPiB7DQo+ID4gKwkJcmV0ID0gLUVJTlZBTDsNCj4g
PiArCQlnb3RvIG91dF91bmxvY2s7DQo+ID4gKwl9DQo+IEkgc3VnZ2VzdGVkIGhhdmluZyBhbiBl
eHBsaWNpdCBvcGVyYXRpb24gdG8gY2hlY2sgaWYgYSByZWdpc3RlciBzdXBwb3J0cw0KPiB0aGlz
IG1vZGUgb2Ygb3BlcmF0aW9uIHdoZW4gSSByZXZpZXdlZCBhbiBlYXJsaWVyIHZlcnNpb24sIEkg
ZGlkbid0DQo+IG5vdGljZSBhIHJlcGx5IG9uIHRoYXQ/DQoNCkhpIE1hcmssDQoNClNvcnJ5LCBJ
IGdvdCBjb25mdXNlZCBhYm91dCB3aGF0IG5lZWRzIHRvIGJlIGRvbmUuIFNob3VsZCBJIGFkZCBh
IG5ldyBmaWVsZA0KdG8gdGhlwqByZWdtYXBfY29uZmlnIHN0cnVjdCB3aGljaCB3aWxsIGJlIGNo
ZWNrZWQgZHVyaW5nIHRoZSBmdW5jdGlvbiBjYWxsPw0KU29tZXRoaW5nIGxpa2XCoGNhbl9tdWx0
aV93cml0ZT8gSG93IGRvIHlvdSBzdWdnZXN0IGl0IHNob3VsZCBiZSBjYWxsZWQ/IElzDQpyZWFk
YWJsZV9ub2luY19yZWcgb2s/DQoNClRoYW5rIHlvdSENClN0ZWZhbg==
