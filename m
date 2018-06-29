Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAF0C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2677E27B35
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevasonline.onmicrosoft.com header.i=@prevasonline.onmicrosoft.com header.b="YWSt2jeq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2677E27B35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=prevas.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966225AbeF2Ize (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 04:55:34 -0400
Received: from mail-eopbgr20129.outbound.protection.outlook.com ([40.107.2.129]:18400
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966147AbeF2Iz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 04:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prevasonline.onmicrosoft.com; s=selector1-prevas-dk;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6Ve/I/RSIRiPD8cTa+fguvG1+GKFO5N0WNAjwVl+sg=;
 b=YWSt2jeqm3eg86zhX6SMpJ+p0whE6FQsFqZ9CJpYN+CnBlpnAtsgAqi//gZCjvuikvMl1etvOUI6eBBeMpiRuVMWxicp5xymfT+7NFvOudXakESgXqXLKvmKOHLmxbtAuGzFjHyONHoYTRA2J/0yXOJSrJEj2IdyilKXFqK1/0Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sean.Nyekjaer@prevas.dk; 
Received: from [172.21.2.87] (87.54.42.112) by
 VI1PR1001MB1405.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.24; Fri, 29 Jun
 2018 08:55:22 +0000
Subject: Re: [PATCH v4 1/2] iio: dac: Add AD5758 support
To:     Stefan Popa <stefan.popa@analog.com>, jic23@kernel.org,
        Michael.Hennerich@analog.com, lars@metafoo.de
Cc:     knaack.h@gmx.de, pmeerw@pmeerw.net, mchehab@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linus.walleij@linaro.org,
        rdunlap@infradead.org, lukas@wunner.de,
        Ismail.Kose@maximintegrated.com, vilhelm.gray@gmail.com,
        pombredanne@nexb.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1530261516-21118-1-git-send-email-stefan.popa@analog.com>
From:   Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Message-ID: <5fc4b56f-f594-97f3-ff9f-2ee5fd2b197c@prevas.dk>
Date:   Fri, 29 Jun 2018 10:55:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530261516-21118-1-git-send-email-stefan.popa@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [87.54.42.112]
X-ClientProxiedBy: DB3PR0202CA0036.eurprd02.prod.outlook.com
 (2603:10a6:8:1::49) To VI1PR1001MB1405.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:e6::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bdaa545-ac7a-47a6-6a39-08d5dd9e0d01
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR1001MB1405;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR1001MB1405;3:pFuL9XpXtU8YMzdyx9QucX48zdjmPEr3/7pL0Jn3cq29I44YNy4EmjJ4bmd81BZmn7FyLslhzprFsXpH97oEc4AC/2Zj+UqLlE0Qrb37h8jJn+WOMeL6wKYGd1wOzJFVfbLiaEomsEii2i7oqlCtZUtRGsH7fJkTufuo9/gJkZIX2E2bp3VOInH+yNhF2BdCSTxz7l8Q30k8esBjdki0nAI1BGB7Fig/iS+G2X8sC8+w7t/XWkZ4D8/k5c5lmwY5;25:PsNfCW5zkhyQeTiG+UWbglHCyylqjZMOaIxwWYsii9dMBFbCcRaeS3nHTjFT1WygG6FYAMsF4LHT0xHlH4V5P5FqgsrFeQDg+YZbNd0dfoqS9AE9aAyc/M3sBKVd1CgKvwYES76DwYZFaXf8obIURllHGQJWwCrY2S7wineJanQrOPoCn8W7pBB8KQWsZHzfk+eMH8Kf8FfQoElK20Bt7oDl3Gg9oEKNDHXGOBelAtfgYZqYOVu6mS2IXyUSKebS8qQcd23bJiADBh0E/+lal4z7j4URrsu0QkQqDwaQII/DM4v4nHgy/qMKWMgB8NdzkbyVzcOc0p2lV7OSVfttaw==;31:1fKfHg0RWurBwNEbqYqa1TsILPD4DJA25oXXA9fXEyhUS8d8FbhNYHElhooakCp2JTyFe935DWBgbqwCuedA0ro+YFlDrAVEtb7wg4OPSjNfQYipLfiIFoxLYgJYQEC7FNclx4oMShONpiTA6WI0lZLOj2C1/Sbo7Httt6bAeC0vgslWtdTwJGvtjeVU8iSgoUd3f1juBPRxhpWeq8fVbrWIFS+hdKjkd8QEEzmFJuw=
X-MS-TrafficTypeDiagnostic: VI1PR1001MB1405:
X-Microsoft-Antispam-PRVS: <VI1PR1001MB14052B2EFDC1DF8964FC91B4EA4E0@VI1PR1001MB1405.EURPRD10.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(9452136761055)(232431446821674)(170811661138872);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR1001MB1405;BCL:0;PCL:0;RULEID:;SRVR:VI1PR1001MB1405;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR1001MB1405;4:QR8HiBiM5Bbj8H/iES7plm1TvO4AoUmlyqZ3PaaAgwa3FyEsi8Ku4io51kKlfxweXq9FN0aAgO1E+emrBvE2E0MX30pBeR/nyoO9xLHT2wUZNTRNDCHSMbMsfTX/ax3icZ9+A/kPfQiBkwKaxx4NwXDmFmfO7tb+grvKbXh8I+Xb72NJN+G36yn+Y7uQIKEDztG7621Y8tBuOdphHCpM4fJsz9AsnYShVmE+o+lJrRzrf85WVBtSMsspKehRl9DbZpDJLbVwoImUb2QmdwYi1wRy8arYjZILesnaj6Z8Ghxy4qm2gsPAJ7ieP7uklKO9xWJKCex2IauSQNdiixaNlTr7abx2ApWFLdvVqrOq+LdeEsp2D5owVZ6+pOwXPubQqmLNS9aEnTjme2A3HucqT0jmcS5NhTm99guOT4zbo6E=
X-Forefront-PRVS: 0718908305
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(136003)(39850400004)(346002)(376002)(396003)(366004)(52164004)(189003)(199004)(36756003)(1720100001)(2870700001)(64126003)(2906002)(44832011)(7416002)(229853002)(53936002)(65826007)(86362001)(67846002)(8676002)(81156014)(5660300001)(97736004)(81166006)(68736007)(50466002)(575784001)(486006)(14444005)(6486002)(31696002)(316002)(16576012)(8976002)(8936002)(58126008)(6666003)(53946003)(186003)(52116002)(65806001)(47776003)(52146003)(2486003)(23676004)(305945005)(65956001)(476003)(66066001)(16526019)(76176011)(956004)(2616005)(77096007)(74482002)(53546011)(11346002)(26005)(386003)(7736002)(72206003)(966005)(106356001)(6306002)(105586002)(39060400002)(25786009)(478600001)(6116002)(4326008)(6246003)(3846002)(446003)(31686004)(19627235001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR1001MB1405;H:[172.21.2.87];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: prevas.dk does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjEwMDFNQjE0MDU7MjM6d2hVRFppRWlXMW1CbmlkdWRJeEI3QnhG?=
 =?utf-8?B?Mm95Mm1SSUg4NStWcDJJQ1MxeEJmWWwwK2hnbVR1SmxFSFBTbU5ENDBsZXRL?=
 =?utf-8?B?dnAzTThpdE5PY1hmcER0bCtSd2pDbERuTW1RTTQva0Myc0VpcDhsSmpRVnVV?=
 =?utf-8?B?RmpMVGRyeVlYRHQ4MW90L0JoR0RsWUZHakhyNDFnY2FMelJqVjE4YVdwdjBH?=
 =?utf-8?B?cjZWMTc3MGxVL29qSWdFc3U1T0dXcGg4eVRxWlZ2Y2NwYTFiNW02bVhlKzM0?=
 =?utf-8?B?UHN6bStaSE81OTcrQXE4VTR3bUh1cjhOcksxdTErMDFjZmRaWjYrTUZ1UlR3?=
 =?utf-8?B?QmxzMUViMWdESUhNRXFaK0psTThPL3RIaHRRNG9QbVp6WTNDSlNlblM1akFZ?=
 =?utf-8?B?bmd5Uk9YRXhkWVNuQ1NtWU81ZnJGRzFEWHZNNXZwS21RalhIelI3cWpSdDlm?=
 =?utf-8?B?MUl1YUZvUnp5bnJqc29keUdwMVdmRWdjZjhNS1hiaHlWNzJmTnNuQzhzTk9D?=
 =?utf-8?B?UjJhdWxJUmRmZ3lDcXQ5M2c4Zlh2NFovYmgxd2NHclczbnZXMlk2STVjZmtB?=
 =?utf-8?B?UGI4STA0THZjeGxOS3liVlRUemtBR1JZV1RIbmluaWJlNWxEbGVsT2Z3NHZm?=
 =?utf-8?B?YmdWdHlQS3lDMGprVk54SGsrK3hCNmsyNjFpNklDTFhkd2dQWFc5QTVRaXZx?=
 =?utf-8?B?alBlaC84bjZRRnJtSjV6cUcrNDVzMWpXLy9JbEg4SGQ3UmgvYlYvSHVEVlhF?=
 =?utf-8?B?THhzck9jZFNDalZwZldkWDM4WG5hY2JFeUlvblowaWlBenowb1QvZVJFVFI1?=
 =?utf-8?B?YXYvL3hqbTZnakJLYVNFSFgwaWdtd0ZhTHdxTWFWRjQzbzN2RXBBeGpiUnV4?=
 =?utf-8?B?K040NENzTmZrclRaZjhiMVZhVDhLbngrZEd4ak1Sdk1JR3JQVWNhVDBYUEVu?=
 =?utf-8?B?VURwZ1ZMMFRkYXRxWGJrMzU2elkvOHNldEY3NkhVSXZrVWd1TjZLL3JOZ2Nw?=
 =?utf-8?B?UENuZE5pL21nZERlMThhYWJ4UWozRGhaQmJXY2F1TTRlQWRrNmNnL2tlaXZx?=
 =?utf-8?B?UE1lOUJPQzY4RlpSem9PeGR6dGlKd0JMeWR4N0VPenJuWS9QSWJkOE5UNFhX?=
 =?utf-8?B?Q2hERENpbE8veCtHdFJyNzdVOWRzQU9nbm1IT3RjZXg0TWtRRldrZGJaREVP?=
 =?utf-8?B?cDRtMk5VV3VWWjNrKzF0ZWdKYUphRGJUeDQrZzRiVVZ0WVI1NE9sdkRsQ3Vv?=
 =?utf-8?B?bFFNL2VhV2xiNFhVREQzK0UxbVZRWXVQR3RVd2xkQVFrcE16QXM3cU05ZVJV?=
 =?utf-8?B?enZqUjdxQnZKbUV0NTNRNDVydEp0UjhJUndSY0haVkQvSXBhOGNycmJHQ0NM?=
 =?utf-8?B?cDkzOS9HaUh4ak92VTR1QmlCT0FKRkp1ZDh1YndJVXo0Sml4Q3V1bG5HSE9j?=
 =?utf-8?B?TnVpY0JuOXdOelduTlk4Y01VZGg5aElwakxodHBuaGhpSW5jM0E0YjBORVIz?=
 =?utf-8?B?ZURzSjdtWDBqRDB2eDdzeVpzaHJmQy9JWVowQWtWVEhJWGxVSnZ1b0lsazNi?=
 =?utf-8?B?eU9RMVM4Y0tXM1hoTmRlcktrbTZnZGRtQTdsUHhJZFRLN2NIVmZIb0l1M2lo?=
 =?utf-8?B?RlQ2SlZPa3ZvWTVwUlRqNFhGbU4wdUp1aW9CZDRGVW9MWk8zQ1YzSmVkeHlK?=
 =?utf-8?B?NXdDY2wxekNJaGNIbzBJUDRkNEZhdUZ2YVJSSCtkazZodkYrL0xBRXVMZFRq?=
 =?utf-8?B?RDAybGtzN01vaFJSWi8vb0NzTjlUd05OVkd4bWRYQkoxcVFQTDRESFNab2N3?=
 =?utf-8?B?N2tMVEdCVU9LbXA1ZFh4S1pqRDlDVUFPa3o3R0oxWGc0OHZZTVc3Nmd4VHI4?=
 =?utf-8?B?UGp1R3dwVmRjVkJhc2owNWt6VGo4dnM5SUg1aGtWa0JjUlZ5MVpXbnZLV1hJ?=
 =?utf-8?B?d3dET2h1KzNub3RIdDk4OTF2bi92azBBZTVFazlUMVpjQkI4TS9LYTZITGVC?=
 =?utf-8?B?M1FyS3JKZEhObGd0WkVwd3Nka3loQW9QQ1UybUxTVXJZMEh4MVBMcXFFMHRk?=
 =?utf-8?B?bGZwQk9qWDREWXd1Z3ZKdmFjM0hqYlVwSmZBazNVTDFONlpHRElia3FtNUJO?=
 =?utf-8?B?Qkd2VEFCMUpNL0RZc3ZSTHJkc0w2WmFWYkNFWUlUNUV3NXlBTDY0a3BBaUhs?=
 =?utf-8?B?aXZjdHRqcHVxdldWWmdkR2VRbGFmbmxrakpwTjluWVdjYzNES1ptOFJEUUNy?=
 =?utf-8?B?QmhKVVB1dEQrU1ZDVSsvVGd6NnBqMGs0L2ErUmpkcHBRUWQra1E2aEd5WkU1?=
 =?utf-8?Q?7b5Kdao8FGj1Zd0JAM=3D?=
X-Microsoft-Antispam-Message-Info: r8LkpP+9bLjspS3o2/hEZBBZu/DcHNTp3QGc1aG1JuZJDxyhiyfyi3nC/Eds9aPOjXiRfVpPdpcrgzkPlfrLGc23C9QyEpFKY+M/5e9DiT/iB9eojVzIfK2UR+roJNjHR5IlyLVF64TwUAXuKXvQZU7YeqOtw1Kw2mS1DjS7SMSdwlKl27zFUzRfkTLkUQmO2MkkIgDf/pfL9k6nQdFmehL7exkHC96yJfJRJ0Kwo2lnmswFzt87c5Ccyf6kiA/K84CotrgZCXyZj1c+wKt1tcLdkI/2Py1c8szcqbmgbWCGvM6dQz4pZYbVwCWI9HI3k5UXrGnvbNDt0gD0G7s7eFBX/htTQwvynK/OQDNeqT0=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR1001MB1405;6:onJiwKS0qFn01p0g4c+mO60axu42IJowwpesgeowWtJdimoY5tQucSf0bSDH8bOvoXPk6E9nfIyXOTGHvEKwld6SB4/Xe8/7UASMrwQf7kpHEf/Hwke7cEw6oYFDZTc8BwGet8XCvIdvYb8iRb/Ore2YjuP07D/3eD9lsecLqn7s11PkOzZfauucCaSZihoI0Lrgr6zcQIuNnwwokG9TxIQfJtApF2gWjldVki+3D/3Sl2TMzUXZ4nVRQUxr9UoYxzr3V0niqa2sWm6RT2jNIFClqvoLHPG+blXuybg4CdaaOjNIdDnZs1lkhKH3IaJ6FUjjkQExWD9iIQZrnbxX/ijl+UyyhiLz2EHw3kttBqHi6yj/0yq/EDW+rfZCKG1A0K/ITrcdtXQbCvyyudHbRA0Mr6zWoE/QsvUBmyztxyxgcJh4ua+pUAmy/UCA0grmXB/plB0Dhza8MwMOXSHssw==;5:esWYYBvaMtruHZG+vgNDGJp05kMUEEvJ2R+SLwuk6KVXoONTBEO6lBrhPP5QP1/XwMrMC+aHxqMfHT+KmHQ/NuCnq83WQoU2rN5vJIm/yCyGo8SPQLA9paTAcYmdBGg9DyOcgOLDCv6vLzW8FDSbkAV8YbCx6pl8sEj+Uf7YU7U=;24:XHXCB9XjdQl7hnovf18c4Qjc5ZlU6Ax0HHP1LvBeGuDeMGLg/0FniPA7bt3abKOI+h4LNWhhZ33ODy10gHgQiK4kKXbXc1uQbPvbUq1fqag=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR1001MB1405;7:widWutz131c/6x55FLtdZTMWfPotrcZ4O7HsLm+SsbqBlVgIbUfp728Vmz+CUq/0fLChNBd9nzGFa/h/swEKBPIJgv/OqgAz3MjR9YfDcBk+Mwdy3B0a7xoVpp1ntnSVw7mCTqUBHWUyyO5Fy567P3JdsCPyJBeWaDTCZP6tt4KiRdgusf6eBqurwOjdfR6LZ+a9Ec/kBHk1vJJMcDblUlppkX7y0qd4sPkl70zwttHE4lnGiuT9qzGqWGYrUx4G
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2018 08:55:22.1319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bdaa545-ac7a-47a6-6a39-08d5dd9e0d01
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR1001MB1405
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29-06-2018 10:38, Stefan Popa wrote:
> The AD5758 is a single channel DAC with 16-bit precision which uses the
> SPI interface that operates at clock rates up to 50MHz.
> 
> The output can be configured as voltage or current and is available on a
> single terminal.
> 
> Datasheet:
> http://www.analog.com/media/en/technical-documentation/data-sheets/ad5758.pdf
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Reviewed-by:  Sean Nyekjaer <sean.nyekjaer@prevas.dk>
> ---
> Changes in v4:
> 	- fixed kbuild test robot warnings.
> Changes in v3:
> 	- AD5758 can be both a current and voltage output DAC. The
> 	  decision is made based on the DT and the channel type is set
> 	  during probe.
> 	- dc-dc-mode, range-microvolt and range-microamp are required
> 	  properties.
> 	- Introduced a slew-time-us property from which slew rate clock
> 	  and slew rate step are calculated using a best match algorithm.
> 	- Dropped the union from ad5758_state struct.
> 	- Introduced a IIO_CHAN_INFO_OFFSET case part of ad5758_read_raw().
> 	- Added a TODO comment which specifies that CRC is not supported.
> 	- Kept the includes in order and removed the unused ones.
> 	- Removed unused macros and shortened the lengthy ones.
> 	- Renamed AD5758_REG_WRITE to AD5758_WR_FLAG_MSK.
> 	- Added an explanation for enum ad5758_output_range.
> 	- Used bsearch() instead of ad5758_get_array_index().
> 	- Reduced the delays.
> 	- strtobool() -> kstrtobool().
> 
> Changes in v2:
> 	- removed unnecessary parenthesis in AD5758_REG_WRITE macro.
> 	- added missing documentation fields of ad5758_state struct.
> 	- changed the type of pwr_down attribute to bool.
> 	- changed ad5758_dc_dc_ilimt[] to ad5758_dc_dc_ilim[].
> 	- ad5758_spi_reg_write() now returns spi_write(st->spi,
> 	  &st->data[0].d32, sizeof(st->data[0].d32));
> 	- removed unnecessary new line in ad5758_calib_mem_refresh().
> 	- changed the type of the mode parameter in
> 	  ad5758_set_dc_dc_conv_mode() from unsigned int to enum
> 	  ad5758_dc_dc_mode.
> 	- removed unnecessary parenthesis in ad5758_slew_rate_config().
> 	- changed the type of the enable parameter in
> 	  ad5758_fault_prot_switch_en() from unsigned char to bool.
> 	- the same as above, but for ad5758_internal_buffers_en().
> 	- added a missing mutex_unlock() in ad5758_reg_access().
> 	- moved the mutex_unlock() in ad5758_read_raw() and removed the
> 	  unreachable return.
> 	- returned directly where it was possible in ad5758_write_raw().
> 	- removed the channel, scan_type and scan_index fields.
> 	- in ad5758_parse_dt(), added missing "\n", and specified what the
> 	  default mode actually is.
> 	- returned directly at the end of ad5758_init().
> 	- in ad5758_probe() used device managed for registering the device
> 	  and returned directly without the error message.
> 
>   MAINTAINERS              |   7 +
>   drivers/iio/dac/Kconfig  |  10 +
>   drivers/iio/dac/Makefile |   1 +
>   drivers/iio/dac/ad5758.c | 899 +++++++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 917 insertions(+)
>   create mode 100644 drivers/iio/dac/ad5758.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 00e9670..12d102d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -796,6 +796,13 @@ M:	Michael Hanselmann <linux-kernel@hansmi.ch>
>   S:	Supported
>   F:	drivers/macintosh/ams/
>   
> +ANALOG DEVICES INC AD5758 DRIVER
> +M:	Stefan Popa <stefan.popa@analog.com>
> +L:	linux-iio@vger.kernel.org
> +W:	http://ez.analog.com/community/linux-device-drivers
> +S:	Supported
> +F:	drivers/iio/dac/ad5758.c
> +
>   ANALOG DEVICES INC AD5686 DRIVER
>   M:	Stefan Popa <stefan.popa@analog.com>
>   L:	linux-pm@vger.kernel.org
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 06e90de..80beb64 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -167,6 +167,16 @@ config AD5755
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called ad5755.
>   
> +config AD5758
> +	tristate "Analog Devices AD5758 DAC driver"
> +	depends on SPI_MASTER
> +	help
> +	  Say yes here to build support for Analog Devices AD5758 single channel
> +	  Digital to Analog Converter.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ad5758.
> +
>   config AD5761
>   	tristate "Analog Devices AD5761/61R/21/21R DAC driver"
>   	depends on SPI_MASTER
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index 57aa230..a1b37cf 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_AD5592R_BASE) += ad5592r-base.o
>   obj-$(CONFIG_AD5592R) += ad5592r.o
>   obj-$(CONFIG_AD5593R) += ad5593r.o
>   obj-$(CONFIG_AD5755) += ad5755.o
> +obj-$(CONFIG_AD5755) += ad5758.o
>   obj-$(CONFIG_AD5761) += ad5761.o
>   obj-$(CONFIG_AD5764) += ad5764.o
>   obj-$(CONFIG_AD5791) += ad5791.o
> diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
> new file mode 100644
> index 0000000..bd1bed7
> --- /dev/null
> +++ b/drivers/iio/dac/ad5758.c
> @@ -0,0 +1,899 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * AD5758 Digital to analog converters driver
> + *
> + * Copyright 2018 Analog Devices Inc.
> + *
> + * TODO: Currently CRC is not supported in this driver
> + */
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +#include <linux/property.h>
> +#include <linux/delay.h>
> +#include <linux/bsearch.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#include <asm/div64.h>
> +
> +/* AD5758 registers definition */
> +#define AD5758_NOP				0x00
> +#define AD5758_DAC_INPUT			0x01
> +#define AD5758_DAC_OUTPUT			0x02
> +#define AD5758_CLEAR_CODE			0x03
> +#define AD5758_USER_GAIN			0x04
> +#define AD5758_USER_OFFSET			0x05
> +#define AD5758_DAC_CONFIG			0x06
> +#define AD5758_SW_LDAC				0x07
> +#define AD5758_KEY				0x08
> +#define AD5758_GP_CONFIG1			0x09
> +#define AD5758_GP_CONFIG2			0x0A
> +#define AD5758_DCDC_CONFIG1			0x0B
> +#define AD5758_DCDC_CONFIG2			0x0C
> +#define AD5758_WDT_CONFIG			0x0F
> +#define AD5758_DIGITAL_DIAG_CONFIG		0x10
> +#define AD5758_ADC_CONFIG			0x11
> +#define AD5758_FAULT_PIN_CONFIG			0x12
> +#define AD5758_TWO_STAGE_READBACK_SELECT	0x13
> +#define AD5758_DIGITAL_DIAG_RESULTS		0x14
> +#define AD5758_ANALOG_DIAG_RESULTS		0x15
> +#define AD5758_STATUS				0x16
> +#define AD5758_CHIP_ID				0x17
> +#define AD5758_FREQ_MONITOR			0x18
> +#define AD5758_DEVICE_ID_0			0x19
> +#define AD5758_DEVICE_ID_1			0x1A
> +#define AD5758_DEVICE_ID_2			0x1B
> +#define AD5758_DEVICE_ID_3			0x1C
> +
> +/* AD5758_DAC_CONFIG */
> +#define AD5758_DAC_CONFIG_RANGE_MSK		GENMASK(3, 0)
> +#define AD5758_DAC_CONFIG_RANGE_MODE(x)		(((x) & 0xF) << 0)
> +#define AD5758_DAC_CONFIG_INT_EN_MSK		BIT(5)
> +#define AD5758_DAC_CONFIG_INT_EN_MODE(x)	(((x) & 0x1) << 5)
> +#define AD5758_DAC_CONFIG_OUT_EN_MSK		BIT(6)
> +#define AD5758_DAC_CONFIG_OUT_EN_MODE(x)	(((x) & 0x1) << 6)
> +#define AD5758_DAC_CONFIG_SR_EN_MSK		BIT(8)
> +#define AD5758_DAC_CONFIG_SR_EN_MODE(x)		(((x) & 0x1) << 8)
> +#define AD5758_DAC_CONFIG_SR_CLOCK_MSK		GENMASK(12, 9)
> +#define AD5758_DAC_CONFIG_SR_CLOCK_MODE(x)	(((x) & 0xF) << 9)
> +#define AD5758_DAC_CONFIG_SR_STEP_MSK		GENMASK(15, 13)
> +#define AD5758_DAC_CONFIG_SR_STEP_MODE(x)	(((x) & 0x7) << 13)
> +
> +/* AD5758_KEY */
> +#define AD5758_KEY_CODE_RESET_1			0x15FA
> +#define AD5758_KEY_CODE_RESET_2			0xAF51
> +#define AD5758_KEY_CODE_SINGLE_ADC_CONV		0x1ADC
> +#define AD5758_KEY_CODE_RESET_WDT		0x0D06
> +#define AD5758_KEY_CODE_CALIB_MEM_REFRESH	0xFCBA
> +
> +/* AD5758_DCDC_CONFIG1 */
> +#define AD5758_DCDC_CONFIG1_DCDC_VPROG_MSK	GENMASK(4, 0)
> +#define AD5758_DCDC_CONFIG1_DCDC_VPROG_MODE(x)	(((x) & 0x1F) << 0)
> +#define AD5758_DCDC_CONFIG1_DCDC_MODE_MSK	GENMASK(6, 5)
> +#define AD5758_DCDC_CONFIG1_DCDC_MODE_MODE(x)	(((x) & 0x3) << 5)
> +#define AD5758_DCDC_CONFIG1_PROT_SW_EN_MSK	BIT(7)
> +#define AD5758_DCDC_CONFIG1_PROT_SW_EN_MODE(x)	(((x) & 0x1) << 7)
> +
> +/* AD5758_DCDC_CONFIG2 */
> +#define AD5758_DCDC_CONFIG2_ILIMIT_MSK		GENMASK(3, 1)
> +#define AD5758_DCDC_CONFIG2_ILIMIT_MODE(x)	(((x) & 0x7) << 1)
> +#define AD5758_DCDC_CONFIG2_INTR_SAT_3WI_MSK	BIT(11)
> +#define AD5758_DCDC_CONFIG2_BUSY_3WI_MSK	BIT(12)
> +
> +/* AD5758_DIGITAL_DIAG_RESULTS */
> +#define AD5758_CAL_MEM_UNREFRESHED_MSK		BIT(15)
> +
> +#define AD5758_WR_FLAG_MSK(x)		(0x80 | ((x) & 0x1F))
> +
> +#define AD5758_FULL_SCALE_MICRO	65535000000ULL
> +
> +/**
> + * struct ad5758_state - driver instance specific data
> + * @spi:	spi_device
> + * @lock:	mutex lock
> + * @out_range:	struct which stores the output range
> + * @dc_dc_mode:	variable which stores the mode of operation
> + * @dc_dc_ilim:	variable which stores the dc-to-dc converter current limit
> + * @slew_time:	variable which stores the target slew time
> + * @pwr_down:	variable which contains whether a channel is powered down or not
> + * @data:	spi transfer buffers
> + */
> +
> +struct ad5758_range {
> +	int reg;
> +	int min;
> +	int max;
> +};
> +
> +struct ad5758_state {
> +	struct spi_device *spi;
> +	struct mutex lock;
> +	struct ad5758_range out_range;
> +	unsigned int dc_dc_mode;
> +	unsigned int dc_dc_ilim;
> +	unsigned int slew_time;
> +	bool pwr_down;
> +	__be32 d32[3];
> +};
> +
> +/**
> + * Output ranges corresponding to bits [3:0] from DAC_CONFIG register
> + * 0000: 0 V to 5 V voltage range
> + * 0001: 0 V to 10 V voltage range
> + * 0010: ±5 V voltage range
> + * 0011: ±10 V voltage range
> + * 1000: 0 mA to 20 mA current range
> + * 1001: 0 mA to 24 mA current range
> + * 1010: 4 mA to 20 mA current range
> + * 1011: ±20 mA current range
> + * 1100: ±24 mA current range
> + * 1101: -1 mA to +22 mA current range
> + */
> +enum ad5758_output_range {
> +	AD5758_RANGE_0V_5V,
> +	AD5758_RANGE_0V_10V,
> +	AD5758_RANGE_PLUSMINUS_5V,
> +	AD5758_RANGE_PLUSMINUS_10V,
> +	AD5758_RANGE_0mA_20mA = 8,
> +	AD5758_RANGE_0mA_24mA,
> +	AD5758_RANGE_4mA_24mA,
> +	AD5758_RANGE_PLUSMINUS_20mA,
> +	AD5758_RANGE_PLUSMINUS_24mA,
> +	AD5758_RANGE_MINUS_1mA_PLUS_22mA,
> +};
> +
> +enum ad5758_dc_dc_mode {
> +	AD5758_DCDC_MODE_POWER_OFF,
> +	AD5758_DCDC_MODE_DPC_CURRENT,
> +	AD5758_DCDC_MODE_DPC_VOLTAGE,
> +	AD5758_DCDC_MODE_PPC_CURRENT,
> +};
> +
> +static const struct ad5758_range ad5758_voltage_range[] = {
> +	{ AD5758_RANGE_0V_5V, 0, 5000000 },
> +	{ AD5758_RANGE_0V_10V, 0, 10000000 },
> +	{ AD5758_RANGE_PLUSMINUS_5V, -5000000, 5000000 },
> +	{ AD5758_RANGE_PLUSMINUS_10V, -10000000, 10000000 }
> +};
> +
> +static const struct ad5758_range ad5758_current_range[] = {
> +	{ AD5758_RANGE_0mA_20mA, 0, 20000},
> +	{ AD5758_RANGE_0mA_24mA, 0, 24000 },
> +	{ AD5758_RANGE_4mA_24mA, 4, 24000 },
> +	{ AD5758_RANGE_PLUSMINUS_20mA, -20000, 20000 },
> +	{ AD5758_RANGE_PLUSMINUS_24mA, -24000, 24000 },
> +	{ AD5758_RANGE_MINUS_1mA_PLUS_22mA, -1000, 22000 },
> +};
> +
> +static const int ad5758_sr_clk[16] = {
> +	240000, 200000, 150000, 128000, 64000, 32000, 16000, 8000, 4000, 2000,
> +	1000, 512, 256, 128, 64, 16
> +};
> +
> +static const int ad5758_sr_step[8] = {
> +	4, 12, 64, 120, 256, 500, 1820, 2048
> +};
> +
> +static const int ad5758_dc_dc_ilim[6] = {
> +	150000, 200000, 250000, 300000, 350000, 400000
> +};
> +
> +static int ad5758_spi_reg_read(struct ad5758_state *st, unsigned int addr)
> +{
> +	struct spi_transfer t[] = {
> +		{
> +			.tx_buf = &st->d32[0],
> +			.len = 4,
> +			.cs_change = 1,
> +		}, {
> +			.tx_buf = &st->d32[1],
> +			.rx_buf = &st->d32[2],
> +			.len = 4,
> +		},
> +	};
> +	int ret;
> +
> +	st->d32[0] = cpu_to_be32(
> +		(AD5758_WR_FLAG_MSK(AD5758_TWO_STAGE_READBACK_SELECT) << 24) |
> +		(addr << 8));
> +	st->d32[1] = cpu_to_be32(AD5758_WR_FLAG_MSK(AD5758_NOP) << 24);
> +
> +	ret = spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
> +	if (ret < 0)
> +		return ret;
> +
> +	return (be32_to_cpu(st->d32[2]) >> 8) & 0xFFFF;
> +}
> +
> +static int ad5758_spi_reg_write(struct ad5758_state *st,
> +				unsigned int addr,
> +				unsigned int val)
> +{
> +	st->d32[0] = cpu_to_be32((AD5758_WR_FLAG_MSK(addr) << 24) |
> +				 ((val & 0xFFFF) << 8));
> +
> +	return spi_write(st->spi, &st->d32[0], sizeof(st->d32[0]));
> +}
> +
> +static int ad5758_spi_write_mask(struct ad5758_state *st,
> +				 unsigned int addr,
> +				 unsigned long int mask,
> +				 unsigned int val)
> +{
> +	int regval;
> +
> +	regval = ad5758_spi_reg_read(st, addr);
> +	if (regval < 0)
> +		return regval;
> +
> +	regval &= ~mask;
> +	regval |= val;
> +
> +	return ad5758_spi_reg_write(st, addr, regval);
> +}
> +
> +static int cmpfunc(const void *a, const void *b)
> +{
> +	return (*(int *)a - *(int *)b);
> +}
> +
> +static int ad5758_find_closest_match(const int *array,
> +				     unsigned int size, int val)
> +{
> +	int i;
> +
> +	for (i = 0; i < size; i++) {
> +		if (val <= array[i])
> +			return i;
> +	}
> +
> +	return size - 1;
> +}
> +
> +static int ad5758_wait_for_task_complete(struct ad5758_state *st,
> +					 unsigned int reg,
> +					 unsigned int mask)
> +{
> +	unsigned int timeout;
> +	int ret;
> +
> +	timeout = 10;
> +	do {
> +		ret = ad5758_spi_reg_read(st, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (!(ret & mask))
> +			return 0;
> +
> +		udelay(100);
> +	} while (--timeout);
> +
> +	dev_err(&st->spi->dev,
> +		"Error reading bit 0x%x in 0x%x register\n", mask, reg);
> +
> +	return -EIO;
> +}
> +
> +static int ad5758_calib_mem_refresh(struct ad5758_state *st)
> +{
> +	int ret;
> +
> +	ret = ad5758_spi_reg_write(st, AD5758_KEY,
> +				   AD5758_KEY_CODE_CALIB_MEM_REFRESH);
> +	if (ret < 0) {
> +		dev_err(&st->spi->dev,
> +			"Failed to initiate a calibration memory refresh\n");
> +		return ret;
> +	}
> +
> +	/* Wait to allow time for the internal calibrations to complete */
> +	return ad5758_wait_for_task_complete(st, AD5758_DIGITAL_DIAG_RESULTS,
> +					     AD5758_CAL_MEM_UNREFRESHED_MSK);
> +}
> +
> +static int ad5758_soft_reset(struct ad5758_state *st)
> +{
> +	int ret;
> +
> +	ret = ad5758_spi_reg_write(st, AD5758_KEY, AD5758_KEY_CODE_RESET_1);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ad5758_spi_reg_write(st, AD5758_KEY, AD5758_KEY_CODE_RESET_2);
> +
> +	/* Perform a software reset and wait 100us */
> +	udelay(100);
> +
> +	return ret;
> +}
> +
> +static int ad5758_set_dc_dc_conv_mode(struct ad5758_state *st,
> +				      enum ad5758_dc_dc_mode mode)
> +{
> +	int ret;
> +
> +	ret = ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG1,
> +				    AD5758_DCDC_CONFIG1_DCDC_MODE_MSK,
> +				    AD5758_DCDC_CONFIG1_DCDC_MODE_MODE(mode));
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Poll the BUSY_3WI bit in the DCDC_CONFIG2 register until it is 0.
> +	 * This allows the 3-wire interface communication to complete.
> +	 */
> +	ret = ad5758_wait_for_task_complete(st, AD5758_DCDC_CONFIG2,
> +					    AD5758_DCDC_CONFIG2_BUSY_3WI_MSK);
> +	if (ret < 0)
> +		return ret;
> +
> +	st->dc_dc_mode = mode;
> +
> +	return ret;
> +}
> +
> +static int ad5758_set_dc_dc_ilim(struct ad5758_state *st, unsigned int ilim)
> +{
> +	int ret;
> +
> +	ret = ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG2,
> +				    AD5758_DCDC_CONFIG2_ILIMIT_MSK,
> +				    AD5758_DCDC_CONFIG2_ILIMIT_MODE(ilim));
> +	if (ret < 0)
> +		return ret;
> +	/*
> +	 * Poll the BUSY_3WI bit in the DCDC_CONFIG2 register until it is 0.
> +	 * This allows the 3-wire interface communication to complete.
> +	 */
> +	return ad5758_wait_for_task_complete(st, AD5758_DCDC_CONFIG2,
> +					     AD5758_DCDC_CONFIG2_BUSY_3WI_MSK);
> +}
> +
> +static int ad5758_slew_rate_set(struct ad5758_state *st,
> +				unsigned int sr_clk_idx,
> +				unsigned int sr_step_idx)
> +{
> +	unsigned int mode;
> +	unsigned long int mask;
> +	int ret;
> +
> +	mask = AD5758_DAC_CONFIG_SR_EN_MSK |
> +	       AD5758_DAC_CONFIG_SR_CLOCK_MSK |
> +	       AD5758_DAC_CONFIG_SR_STEP_MSK;
> +	mode = AD5758_DAC_CONFIG_SR_EN_MODE(1) |
> +		AD5758_DAC_CONFIG_SR_STEP_MODE(sr_step_idx) |
> +		AD5758_DAC_CONFIG_SR_CLOCK_MODE(sr_clk_idx);
> +
> +	ret = ad5758_spi_write_mask(st, AD5758_DAC_CONFIG, mask, mode);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Wait to allow time for the internal calibrations to complete */
> +	return ad5758_wait_for_task_complete(st, AD5758_DIGITAL_DIAG_RESULTS,
> +					     AD5758_CAL_MEM_UNREFRESHED_MSK);
> +}
> +
> +static int ad5758_slew_rate_config(struct ad5758_state *st)
> +{
> +	unsigned int sr_clk_idx, sr_step_idx;
> +	int i, res;
> +	s64 diff_new, diff_old;
> +	u64 sr_step, calc_slew_time;
> +
> +	sr_clk_idx = 0;
> +	sr_step_idx = 0;
> +	diff_old = S64_MAX;
> +	/*
> +	 * The slew time can be determined by using the formula:
> +	 * Slew Time = (Full Scale Out / (Step Size x Update Clk Freq))
> +	 * where Slew time is expressed in microseconds
> +	 * Given the desired slew time, the following algorithm determines the
> +	 * best match for the step size and the update clock frequency.
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(ad5758_sr_clk); i++) {
> +		/*
> +		 * Go through each valid update clock freq and determine a raw
> +		 * value for the step size by using the formula:
> +		 * Step Size = Full Scale Out / (Update Clk Freq * Slew Time)
> +		 */
> +		sr_step = AD5758_FULL_SCALE_MICRO;
> +		do_div(sr_step, ad5758_sr_clk[i]);
> +		do_div(sr_step, st->slew_time);
> +		/*
> +		 * After a raw value for step size was determined, find the
> +		 * closest valid match
> +		 */
> +		res = ad5758_find_closest_match(ad5758_sr_step,
> +						ARRAY_SIZE(ad5758_sr_step),
> +						sr_step);
> +		/* Calculate the slew time */
> +		calc_slew_time = AD5758_FULL_SCALE_MICRO;
> +		do_div(calc_slew_time, ad5758_sr_step[res]);
> +		do_div(calc_slew_time, ad5758_sr_clk[i]);
> +		/*
> +		 * Determine with how many microseconds the calculated slew time
> +		 * is different from the desired slew time and store the diff
> +		 * for the next iteration
> +		 */
> +		diff_new = abs(st->slew_time - calc_slew_time);
> +		if (diff_new < diff_old) {
> +			diff_old = diff_new;
> +			sr_clk_idx = i;
> +			sr_step_idx = res;
> +		}
> +	}
> +
> +	return ad5758_slew_rate_set(st, sr_clk_idx, sr_step_idx);
> +}
> +
> +static int ad5758_set_out_range(struct ad5758_state *st, int range)
> +{
> +	int ret;
> +
> +	ret = ad5758_spi_write_mask(st, AD5758_DAC_CONFIG,
> +				    AD5758_DAC_CONFIG_RANGE_MSK,
> +				    AD5758_DAC_CONFIG_RANGE_MODE(range));
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Wait to allow time for the internal calibrations to complete */
> +	ret =  ad5758_wait_for_task_complete(st, AD5758_DIGITAL_DIAG_RESULTS,
> +					     AD5758_CAL_MEM_UNREFRESHED_MSK);
> +	if (ret < 0)
> +		return ret;
> +
> +	return ret;
> +}
> +
> +static int ad5758_fault_prot_switch_en(struct ad5758_state *st, bool enable)
> +{
> +	int ret;
> +
> +	ret = ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG1,
> +			AD5758_DCDC_CONFIG1_PROT_SW_EN_MSK,
> +			AD5758_DCDC_CONFIG1_PROT_SW_EN_MODE(enable));
> +	if (ret < 0)
> +		return ret;
> +	/*
> +	 * Poll the BUSY_3WI bit in the DCDC_CONFIG2 register until it is 0.
> +	 * This allows the 3-wire interface communication to complete.
> +	 */
> +	return ad5758_wait_for_task_complete(st, AD5758_DCDC_CONFIG2,
> +					     AD5758_DCDC_CONFIG2_BUSY_3WI_MSK);
> +}
> +
> +static int ad5758_internal_buffers_en(struct ad5758_state *st, bool enable)
> +{
> +	int ret;
> +
> +	ret = ad5758_spi_write_mask(st, AD5758_DAC_CONFIG,
> +				    AD5758_DAC_CONFIG_INT_EN_MSK,
> +				    AD5758_DAC_CONFIG_INT_EN_MODE(enable));
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Wait to allow time for the internal calibrations to complete */
> +	return ad5758_wait_for_task_complete(st, AD5758_DIGITAL_DIAG_RESULTS,
> +					     AD5758_CAL_MEM_UNREFRESHED_MSK);
> +}
> +
> +static int ad5758_reg_access(struct iio_dev *indio_dev,
> +			     unsigned int reg,
> +			     unsigned int writeval,
> +			     unsigned int *readval)
> +{
> +	struct ad5758_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	if (readval) {
> +		ret = ad5758_spi_reg_read(st, reg);
> +		if (ret < 0) {
> +			mutex_unlock(&st->lock);
> +			return ret;
> +		}
> +
> +		*readval = ret;
> +		ret = 0;
> +	} else {
> +		ret = ad5758_spi_reg_write(st, reg, writeval);
> +	}
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static int ad5758_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long info)
> +{
> +	struct ad5758_state *st = iio_priv(indio_dev);
> +	int max, min, ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&st->lock);
> +		ret = ad5758_spi_reg_read(st, AD5758_DAC_INPUT);
> +		mutex_unlock(&st->lock);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = ret;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		min = st->out_range.min;
> +		max = st->out_range.max;
> +		*val = (max - min) / 1000;
> +		*val2 = 16;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_OFFSET:
> +		min = st->out_range.min;
> +		max = st->out_range.max;
> +		*val = ((min * (1 << 16)) / (max - min)) / 1000;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad5758_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long info)
> +{
> +	struct ad5758_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&st->lock);
> +		ret = ad5758_spi_reg_write(st, AD5758_DAC_INPUT, val);
> +		mutex_unlock(&st->lock);
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static ssize_t ad5758_read_powerdown(struct iio_dev *indio_dev,
> +				     uintptr_t priv,
> +				     const struct iio_chan_spec *chan,
> +				     char *buf)
> +{
> +	struct ad5758_state *st = iio_priv(indio_dev);
> +
> +	return sprintf(buf, "%d\n", st->pwr_down);
> +}
> +
> +static ssize_t ad5758_write_powerdown(struct iio_dev *indio_dev,
> +				      uintptr_t priv,
> +				      struct iio_chan_spec const *chan,
> +				      const char *buf, size_t len)
> +{
> +	struct ad5758_state *st = iio_priv(indio_dev);
> +	bool pwr_down;
> +	unsigned int dcdc_config1_mode, dc_dc_mode, dac_config_mode, val;
> +	unsigned long int dcdc_config1_msk, dac_config_msk;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &pwr_down);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&st->lock);
> +	if (pwr_down) {
> +		dc_dc_mode = AD5758_DCDC_MODE_POWER_OFF;
> +		val = 0;
> +	} else {
> +		dc_dc_mode = st->dc_dc_mode;
> +		val = 1;
> +	}
> +
> +	dcdc_config1_mode = (AD5758_DCDC_CONFIG1_DCDC_MODE_MODE(dc_dc_mode) |
> +			     AD5758_DCDC_CONFIG1_PROT_SW_EN_MODE(val));
> +	dcdc_config1_msk = (AD5758_DCDC_CONFIG1_DCDC_MODE_MSK |
> +			    AD5758_DCDC_CONFIG1_PROT_SW_EN_MSK);
> +
> +	ret = ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG1,
> +				    dcdc_config1_msk,
> +				    dcdc_config1_mode);
> +	if (ret < 0)
> +		goto err_unlock;
> +
> +	dac_config_mode = (AD5758_DAC_CONFIG_OUT_EN_MODE(val) |
> +			   AD5758_DAC_CONFIG_INT_EN_MODE(val));
> +	dac_config_msk =  (AD5758_DAC_CONFIG_OUT_EN_MSK |
> +			   AD5758_DAC_CONFIG_INT_EN_MSK);
> +
> +	ret = ad5758_spi_write_mask(st, AD5758_DAC_CONFIG,
> +				    dac_config_msk,
> +				    dac_config_mode);
> +	if (ret < 0)
> +		goto err_unlock;
> +
> +	st->pwr_down = pwr_down;
> +
> +err_unlock:
> +	mutex_unlock(&st->lock);
> +
> +	return ret ? ret : len;
> +}
> +
> +static const struct iio_info ad5758_info = {
> +	.read_raw = ad5758_read_raw,
> +	.write_raw = ad5758_write_raw,
> +	.debugfs_reg_access = &ad5758_reg_access,
> +};
> +
> +static const struct iio_chan_spec_ext_info ad5758_ext_info[] = {
> +	{
> +		.name = "powerdown",
> +		.read = ad5758_read_powerdown,
> +		.write = ad5758_write_powerdown,
> +		.shared = IIO_SHARED_BY_TYPE,
> +	},
> +	{ }
> +};
> +
> +static struct iio_chan_spec ad5758_channels[] = {
> +	{
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SCALE) |
> +			BIT(IIO_CHAN_INFO_OFFSET),
> +		.indexed = 1,
> +		.output = 1,
> +		.ext_info = ad5758_ext_info,
> +	},
> +};
> +
> +static bool ad5758_is_valid_mode(enum ad5758_dc_dc_mode mode)
> +{
> +	switch (mode) {
> +	case AD5758_DCDC_MODE_DPC_CURRENT:
> +	case AD5758_DCDC_MODE_DPC_VOLTAGE:
> +	case AD5758_DCDC_MODE_PPC_CURRENT:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static int ad5758_crc_disable(struct ad5758_state *st)
> +{
> +	unsigned int mask;
> +
> +	mask = (AD5758_WR_FLAG_MSK(AD5758_DIGITAL_DIAG_CONFIG) << 24) | 0x5C3A;
> +	st->d32[0] = cpu_to_be32(mask);
> +
> +	return spi_write(st->spi, &st->d32[0], 4);
> +}
> +
> +static int ad5758_find_out_range(struct ad5758_state *st,
> +				 const struct ad5758_range *range,
> +				 unsigned int size,
> +				 int min, int max)
> +{
> +	int i;
> +
> +	for (i = 0; i < size; i++) {
> +		if ((min == range[i].min) && (max == range[i].max)) {
> +			st->out_range.reg = range[i].reg;
> +			st->out_range.min = range[i].min;
> +			st->out_range.max = range[i].max;
> +
> +			return 0;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ad5758_parse_dt(struct ad5758_state *st)
> +{
> +	unsigned int tmp, tmparray[2], size;
> +	const struct ad5758_range *range;
> +	int *index, ret;
> +
> +	st->dc_dc_ilim = 0;
> +	ret = device_property_read_u32(&st->spi->dev,
> +				       "adi,dc-dc-ilim-microamp", &tmp);
> +	if (ret) {
> +		dev_dbg(&st->spi->dev,
> +			"Missing \"dc-dc-ilim-microamp\" property\n");
> +	} else {
> +		index = (int *) bsearch(&tmp, ad5758_dc_dc_ilim,
> +					ARRAY_SIZE(ad5758_dc_dc_ilim),
> +					sizeof(int), cmpfunc);
> +		if (!index)
> +			dev_dbg(&st->spi->dev, "dc-dc-ilim out of range\n");
> +		else
> +			st->dc_dc_ilim = index - ad5758_dc_dc_ilim;
> +	}
> +
> +	ret = device_property_read_u32(&st->spi->dev, "adi,dc-dc-mode",
> +				       &st->dc_dc_mode);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "Missing \"dc-dc-mode\" property\n");
> +		return ret;
> +	}
> +
> +	if (!ad5758_is_valid_mode(st->dc_dc_mode))
> +		return -EINVAL;
> +
> +	if (st->dc_dc_mode == AD5758_DCDC_MODE_DPC_VOLTAGE) {
> +		ret = device_property_read_u32_array(&st->spi->dev,
> +						     "adi,range-microvolt",
> +						     tmparray, 2);
> +		if (ret) {
> +			dev_err(&st->spi->dev,
> +				"Missing \"range-microvolt\" property\n");
> +			return ret;
> +		}
> +		range = ad5758_voltage_range;
> +		size = ARRAY_SIZE(ad5758_voltage_range);
> +	} else {
> +		ret = device_property_read_u32_array(&st->spi->dev,
> +						     "adi,range-microamp",
> +						     tmparray, 2);
> +		if (ret) {
> +			dev_err(&st->spi->dev,
> +				"Missing \"range-microamp\" property\n");
> +			return ret;
> +		}
> +		range = ad5758_current_range;
> +		size = ARRAY_SIZE(ad5758_current_range);
> +	}
> +
> +	ret = ad5758_find_out_range(st, range, size, tmparray[0], tmparray[1]);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "range invalid\n");
> +		return ret;
> +	}
> +
> +	ret = device_property_read_u32(&st->spi->dev, "adi,slew-time-us", &tmp);
> +	if (ret) {
> +		dev_dbg(&st->spi->dev, "Missing \"slew-time-us\" property\n");
> +		st->slew_time = 0;
> +	} else {
> +		st->slew_time = tmp;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad5758_init(struct ad5758_state *st)
> +{
> +	int regval, ret;
> +
> +	/* Disable CRC checks */
> +	ret = ad5758_crc_disable(st);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Perform a software reset */
> +	ret = ad5758_soft_reset(st);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Disable CRC checks */
> +	ret = ad5758_crc_disable(st);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Perform a calibration memory refresh */
> +	ret = ad5758_calib_mem_refresh(st);
> +	if (ret < 0)
> +		return ret;
> +
> +	regval = ad5758_spi_reg_read(st, AD5758_DIGITAL_DIAG_RESULTS);
> +	if (regval < 0)
> +		return regval;
> +
> +	/* Clear all the error flags */
> +	ret = ad5758_spi_reg_write(st, AD5758_DIGITAL_DIAG_RESULTS, regval);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Set the dc-to-dc current limit */
> +	ret = ad5758_set_dc_dc_ilim(st, st->dc_dc_ilim);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Configure the dc-to-dc controller mode */
> +	ret = ad5758_set_dc_dc_conv_mode(st, st->dc_dc_mode);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Configure the output range */
> +	ret = ad5758_set_out_range(st, st->out_range.reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Enable Slew Rate Control, set the slew rate clock and step */
> +	if (st->slew_time) {
> +		ret = ad5758_slew_rate_config(st);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	/* Enable the VIOUT fault protection switch (FPS is closed) */
> +	ret = ad5758_fault_prot_switch_en(st, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Power up the DAC and internal (INT) amplifiers */
> +	ret = ad5758_internal_buffers_en(st, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Enable VIOUT */
> +	return ad5758_spi_write_mask(st, AD5758_DAC_CONFIG,
> +				     AD5758_DAC_CONFIG_OUT_EN_MSK,
> +				     AD5758_DAC_CONFIG_OUT_EN_MODE(1));
> +}
> +
> +static int ad5758_probe(struct spi_device *spi)
> +{
> +	struct ad5758_state *st;
> +	struct iio_dev *indio_dev;
> +	struct iio_chan_spec *channels = ad5758_channels;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	spi_set_drvdata(spi, indio_dev);
> +
> +	st->spi = spi;
> +
> +	mutex_init(&st->lock);
> +
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->name = spi_get_device_id(spi)->name;
> +	indio_dev->info = &ad5758_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->num_channels = ARRAY_SIZE(ad5758_channels);
> +
> +	ret = ad5758_parse_dt(st);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (st->dc_dc_mode == AD5758_DCDC_MODE_DPC_VOLTAGE)
> +		channels->type = IIO_VOLTAGE;
> +	else
> +		channels->type = IIO_CURRENT;
> +
> +	indio_dev->channels = channels;
> +
> +	ret = ad5758_init(st);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "AD5758 init failed\n");
> +		return ret;
> +	}
> +
> +	return devm_iio_device_register(&st->spi->dev, indio_dev);
> +}
> +
> +static const struct spi_device_id ad5758_id[] = {
> +	{ "ad5758", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, ad5758_id);
> +
> +static struct spi_driver ad5758_driver = {
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +	},
> +	.probe = ad5758_probe,
> +	.id_table = ad5758_id,
> +};
> +
> +module_spi_driver(ad5758_driver);
> +
> +MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD5758 DAC");
> +MODULE_LICENSE("GPL v2");
> 
