Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03488C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942A02083C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="iZU7w65W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942A02083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbeJOUpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:45:41 -0400
Received: from mail-eopbgr80048.outbound.protection.outlook.com ([40.107.8.48]:9088
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726422AbeJOUpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dBx5d2cEPp1O2pHpQWjAnCFq6OLkITmDGYmoaJu3Nk=;
 b=iZU7w65Wql5wXFZbeEwTAzfNd9I7uf1kSqaKi2+S4fkreUecHTU5mUviPKvWzljgVBJr3io8RoFOjYTK0f4Xz8yLQpCHEnG3Fy7cY/XvijtJjhTzstPjD6WuzPph+etdq/xyWuL4exMCm3DbXcCKU8HGwPCeWZokCEIxUloC6L8=
Received: from [10.1.196.75] (217.140.106.50) by
 AM0PR08MB3091.eurprd08.prod.outlook.com (2603:10a6:208:5c::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Mon, 15 Oct 2018 13:00:18 +0000
Subject: Re: [PATCH 2/4] iommu/arm-smmu: Workaround for Marvell Armada-AP806
 SoC erratum #582743
To:     hannah@marvell.com, catalin.marinas@arm.com, will.deacon@arm.com,
        corbet@lwn.net, joro@8bytes.org, robh+dt@kernel.org,
        gregory.clement@bootlin.com, mark.rutland@arm.com,
        jason@lakedaemon.net, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, thomas.petazzoni@bootlin.com,
        nadavh@marvell.com, omrii@marvell.com, nd@arm.com
References: <1539604846-21151-1-git-send-email-hannah@marvell.com>
 <1539604846-21151-3-git-send-email-hannah@marvell.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8a7eefcf-6a77-8dc1-2ce9-9bb7395a3bb7@arm.com>
Date:   Mon, 15 Oct 2018 14:00:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539604846-21151-3-git-send-email-hannah@marvell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [217.140.106.50]
X-ClientProxiedBy: CWLP265CA0033.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:11::21) To AM0PR08MB3091.eurprd08.prod.outlook.com
 (2603:10a6:208:5c::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8963fea-aafa-4ffe-a2af-08d6329e28ae
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3091;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3091;3:d4OaQhXCpdkitJxS4kWIxr924IbEQmrCr2gDo/WE4PLkj2E5icMJYILbiT9b4vHNE/KPyd55u7d28uM+XXCTVj8+H+X/n3WpxHTnWqdhJUK1XxXtoAzRYO91XSMBk6ZxTYQWGsnPFNtFXzLuq7Jp60v2pGl9AkTLId0PLpUPh7o5MCmRBk3nbbag62l66AobVhGbtV18PkNZS1IrPtVlazRA02sNH7V9Mmb60UQXY1EYpQmygKVuAUKL5b4J5G4m;25:JVpvZNr9ylhRbqADSLrvZRetusWutnIQtTlvxU+55xgQwQCyvA2c5hjGwpKbgYZEwW/WvsRgPys7vgbO/pA0sU6w3PW65QmTcRs//jvelYKv0LkNwlo39IhwmRN8sdoYYogseiKvZ9Mrg0/6AUMDdAqQgrhKzsPPRTVitjTSSL2AOfE4ybije+W4Hl82rAK0AjEmDremF8aTRzscwZy65mYnjBSOXCezv8wiZvyb0LfFVDd+/Ube+Q6cBaQCLQWx5xY3kYrMNZc/u/UO/do4K4wZmE85fUjuAnlVf/PUCFLF/R1PW7b+OoDwAsVYJxhYLEw2ip8iSYcVGEe+61XZWw==;31:dCOuTDgK6vYyleXjjYaGuEuZ2DSkOgYAX/bASgsGxHs6AGxcdufDs5X8Vv9QAAp9yLkHbv4ec+T4ekr++Z5/W1V864+t8lc0WOky82zWKfZ0wudF9AlIDv8mP2+z3oKGeguZ8jNgtAgDtbCUQqsClNy+WXqXF/+krBdo5DyeaayppsIOz4lKDy6e+6Gh+gQOSf1C0OS3ldZRHtATJpPmNL9EpaiEhWyVy0M/vA42gPA=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3091:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3091;20:mNN1cQ6W5yoSLw8DhI2r9RN2YCYtKgrk85BY3Q1lzloSqo7PeJ98yaHMPLVwBZP9vRH7q1IOKBwe6mMPfxCd49/hYtpbLPS54qkYSgeBVPz+lMc1d2lrAA5vVKJx2nNLJBiwpcba4mx7CgbgG5/MqLEThTFy/sNH90YOuP0+zQ1puQyhq5+RZmbs/8aLnSWEeEM7H3Xwja4ga+9NXpn7LE8JFluPo6s6rH7i/gEWgVfDCZDUsOWDqQ3qZ+kTXEmzq5a6VHwYLaepOrtLSDD7I3CY/Gxder0UaKtV2uE+o4PJ180GE8d2rS2d6oFcdfL1trYLkxY3X/XOd6oPhzaATDJMfftgZ06QOQc+JTObtMID0S5C89J/wHlFxMfgZJX5vTtohHsj8MWZC64UwIT8BndYkt1wIlqGvUdHWXeW8iI=;4:XXS+mnLDkc5WV8oEWdC6dOdj758JC+3HEHog4nHFp4fY+9/vYa6fF0SSCpGxaNoi/RpRVKYf/aPWWynToEPY26iVXzbQEo055xOqvdB4iwbEVSs/rXCsunwQVJyOzhSrXP5UoYoOUOWcnmZ4PjbC34nUQg+HZJCoRXYYTn5nllsrQEt8yn53Jii07SIOuJMVT5YpDL9ZzLska5Pci8EtshJfqyuBUgPjF9S8zTOXNCxZ+HpxLiST0HdWIzi5h75gfBBi5ehv04stfIsl6r1nmA==
X-Microsoft-Antispam-PRVS: <AM0PR08MB3091AF0270601D733F9FC39E96FD0@AM0PR08MB3091.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991067);SRVR:AM0PR08MB3091;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3091;
X-Forefront-PRVS: 0826B2F01B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(376002)(136003)(396003)(366004)(39860400002)(189003)(199004)(3846002)(65826007)(76176011)(5660300001)(66066001)(65956001)(65806001)(50466002)(7736002)(305945005)(25786009)(67846002)(386003)(2906002)(6116002)(58126008)(230700001)(52116002)(23676004)(2486003)(52146003)(53546011)(6246003)(6346003)(6486002)(26005)(72206003)(53936002)(229853002)(16576012)(64126003)(77096007)(186003)(81156014)(81166006)(8676002)(16526019)(478600001)(36756003)(105586002)(39060400002)(86362001)(31696002)(7416002)(956004)(44832011)(47776003)(68736007)(97736004)(486006)(2616005)(8936002)(31686004)(446003)(14444005)(476003)(106356001)(11346002)(316002)(4326008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3091;H:[10.1.196.75];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Robin.Murphy@arm.com; 
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA4TUIzMDkxOzIzOjhFTzgrQTFuaTcvS1B3U2NxbFpjUVozcjJZ?=
 =?utf-8?B?Ymw4MXh6S3pTTTBNSnNhdExZVW1kU2ZJeFp4NER0MGFReHhqZ0dSaVp4RUcr?=
 =?utf-8?B?UDA0VjdJWXJwME0vMXdPS0FaOXRxUGZDSWQxRm9qQkFQcEJ0VGoyTXo2bk0x?=
 =?utf-8?B?eUxMcjhDOUhzRjROc1Ryc2Z4dVZ6Z1orYVZyRm9USTl3bWJEUUpPdmFhRkZs?=
 =?utf-8?B?MnorSzFNSjUyQmVZb1RiZnZwYTYzMzJ6V01wdll4Q3JFMFNyVExPejI2T2hn?=
 =?utf-8?B?NmtwZjdkV0VvVnRSN2NEMTNWOWpKc2w1dU1KWDhzRUhldHZPR2ZnMjJwUnRF?=
 =?utf-8?B?VFF6N2IyZ29ubUJVSFd6dHZxVkVUc254TVY2N1BhQU91MTZzYlNTdTRsUjVK?=
 =?utf-8?B?VCtJSG9zTkh0Uy93S1ZpVjRRZzUxZzhRVTlFdXRHemRmZFpCV2JLWExwQnlX?=
 =?utf-8?B?T090RDZVa1FxUksvQXh5c21BRU9OM1c1R1RsVHNlM1lvY0NjU2l6d1lIWWxX?=
 =?utf-8?B?YjBOUGRFQXlieFJoSHp1VHoxSTMzeTYyUkd1eVFuZm9EbDdtdFRNTUVJZHZW?=
 =?utf-8?B?NlRveURESnRwQnpra2NlWG9pOWFsUTFLN1lyWkt1by9pUnNaejI2T1R5N052?=
 =?utf-8?B?RHpvK3J4dHAxSk4vWDJOeVk2Z3JVV0RQT0RhM2d3cUIwZzNFbVRPV3N4NnF1?=
 =?utf-8?B?MUV4OWFpYXY1ZVBZL3hQWklPMnc2ZWluNVpuSXJTU3djUlVMMEtWczVUYXpT?=
 =?utf-8?B?cWczVmJmZDJEbDVteTZvenB5UzEyd284WVltZ0NBbExPUjh6UEZDU2FERC9E?=
 =?utf-8?B?eVZGTUkzZnVtODN4TUt3V21QdFFLUndYZ3gvdVV3N0Z3Qi9tQUZvTlBsY1Fh?=
 =?utf-8?B?S25HWVJseHczYUc3bEZDdkVCT1FScU1vSjJHOVl1V1FRT0QyMGt4M2dTTHJn?=
 =?utf-8?B?bTE2ZlpEVlQ0UHRScTR0eGcyczUyZi9TTE5RK1ZoM0ZFcm96NHp3bG1ZMmY2?=
 =?utf-8?B?NmFHRndMQmU4ZWo0Zllnc1ZFNEFNMjFjdnpkbm9RUm9VemNoSDFRMmpoczg4?=
 =?utf-8?B?QzRSYWJjWjd2SjR2MTl2YnRkdW8zZWdXUSs1OUIxbXU1NDBKeitmWjJrL1Rv?=
 =?utf-8?B?UnFHazJVTGRvTXdnWDhCeXlQVzNzdWtBekVyRGkxZHdiOTMxK1VkU01SQlZQ?=
 =?utf-8?B?VE54Y2ZuTVdQc29qZlhZbU1rZHN6Q1dZVnFBekF1ZEdHWkI0L1h4ZUFZQ2lQ?=
 =?utf-8?B?TUFDcFFYcTJtVmVCdkQydmV6cHp3MWVMY2F6S2JXWWVFQldZbzNhS1IxQUFv?=
 =?utf-8?B?R1k4VDRqWm5qcW5KTG1NSHM0Rkk5VUIxUGs4QnI4a0NSOUxNaWtWWGNJL1da?=
 =?utf-8?B?TUlQUkJUbXF2OFRaaWZRbkV5VEdmSzZNeHB1b2ZRVzBKZExObXV1cG9RdkY5?=
 =?utf-8?B?NjVLeUdnUzZpK3JSSGV0cmtpeXc3eEtDaWJQWk9jKzB1ZHhTQ3ZldzdtQmYr?=
 =?utf-8?B?R01WaXlMVHp3MTIvSGlnYTYxWWxZTlI5ekw0ejkyUDdxWWhoNkNrWjUvRWR4?=
 =?utf-8?B?Sm5KRmE5K0hEeis5d1F6RGVvbElxUnlON0plWjYyM3JrV1dWT04zekNWUzBs?=
 =?utf-8?B?Q05HOUMyZ01PT2EzQ0hmZHNmT2lFVVd1VGJ4aGdLWFpza045V2tOUVhqdGM5?=
 =?utf-8?B?NHlNalliMkhPU1p6aUw2L2hFd3ZTa1liVjJ5Tlk2MjByNXFXMkdxQzZqdUJW?=
 =?utf-8?B?MDh3QUhPV1pTTktDUEdYY1pOT211NGF4QWNYcVkrYzZUZkpObkNlUktwa3g1?=
 =?utf-8?B?aGFtZG85TVowRFNmeDdXK3FlekJwUDVDYVcrNHk2d0dwRTI3aW9na3RHSkxB?=
 =?utf-8?B?RE5IUkNEWjQ4OFNRZnZaZUhCdE5RTzVNekdTT0djTTZyOHFxdjJNU1oyYkJP?=
 =?utf-8?B?eGFSWmJSQ1lwbVlhTWpRd2dUUCt6aWp3WENVZ1puYjBjTk5teXRTYi8yb3JX?=
 =?utf-8?B?d1BJQkRxczYxZDROTEJWVXRWdDhQcHBoWnp2YUZMM1ZtMmMvcVdqUDQ5Y1JT?=
 =?utf-8?B?cC9rcFZVYVNKVGdObURKNlNSdjFxMXBpUHpjcnJ5aDd4cTliS0Zwblc5MzNS?=
 =?utf-8?B?Y1E9PQ==?=
X-Microsoft-Antispam-Message-Info: j5lkphJtxw6CWNQiV4et+sX2xaGVLnLhM0HWqJDUOVaJUdlOMeGk+a5Hg1pl89ihJirQf4B7jfADeQ3aG94rIiCelLcqgU4eeps3kkaNtC6y+v1VjxeXigoJkMII1VZqFVL1f4ce5nECWkTDXG2LOLS3v4ZsL5E6iTHWh8TouJGN3ovprzOUJ/WYkDUSvXUu0M8V5XL+Kyk64MwuFMNd7iN28nqXnBJEVaWOXtM6C2rmUFCLJATGSzjJGFixCfdFHZgazYrXLUfjkd4oFsBVamUx0YKqXdV6bZcLkEungEJfjoV8KCCEYJ075D4uv3rg7DCkLriM1Bu1WuoXzCCmHTU9+7+o0Wg6kyVAE/bnJv4=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3091;6:Gj1xHMd1JyFPs69M/XT5nql6FhlGTXYKFmZ7YsKDCETFySRJMMY1Rux/MI5AjB4zBTEO2UeYPqnXAFFzXIOL9ByasbtTsRfcEb925QZ3XtqwzmdRMfPCUm/7OksZR28jMyyyZAUpRdEIMpGZwTUiHQquYLnTVk9ZuH8du810JKqHZwlBXVAB/or4Wy1AKMUG69TRXPeNvk4FOwgOtS1NDugy7WeHmM0zG2U3Xje8N7KmT2fwyikMKTycX1g/wesOBivIujT05PhboVtADwjGXWlkzkRXrxlclRzxfzIWWVZcy4k+Kjak+T47uJI6qBkQXICXY5muaHOk/mfyq5nW5ilP2pyyDyCKnSiSFl15E1zM6QM2bWe/l/3HkDPMvy4RR8BLukkmSLJbXg6wDV3Qc9YLRWH+AP6zcccvcju8HfVLVpSdDtfkEsyfuTOxpJER+sHMbURfwa463CKDZv8u7g==;5:eiXDWg7u8aqShNPt/GgW1ym2jsee+MBj1JITJcPpZtRlXchQRVhD+NZ3fy6mdkdN6FAreJcidUYpVCyb/p4T+SPi84hhj/wTEnPicubjTs4EZrQwca4qj4wjQ9R4WhHWMy+mus0xwgJofVA4NbVbxCjDHVeVFCmkW52OZqxKHkw=;7:tRfXMOuix/vTlwcnN5i2LLiwCI5EoBb7iz2tmxExdeb5c5Uo+E0tvpy+YaMBzjm99tk9TnM9PWCdEGTCsJc0GMsGx0d/yrRT9qkPVunhBTt5/a0CK1DN5kFMccQRHYe29RH1cJNbv3bnZ3W3OVULWC9lbM9PRe1BYooAq9051ASMSWmt2UcoFPTy2gsgxvAEZ3H5+qV2+whOo9km3pf1eXriXpsEa5CtTT1Iki8GKIRVtEwOkQEBPQgq6kWcM66P
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2018 13:00:18.3883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8963fea-aafa-4ffe-a2af-08d6329e28ae
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hanna,

On 15/10/18 13:00, hannah@marvell.com wrote:
> From: Hanna Hawa <hannah@marvell.com>
> 
> Due to erratum #582743, the Marvell Armada-AP806 can't access 64bit
> to ARM SMMUv2 registers.
> This patch split the writeq/readq to two accesses of writel/readl.
> 
> Note that separate writes/reads to 2 is not problem regards to atomicity,
> because the driver use the readq/writeq while initialize the SMMU, report
> for SMMU fault, and use spinlock in one case (iova_to_phys).

In general, this doesn't work. Here's what the SMMU spec says about 
SMMU_CBn_TLBIVA, but others are similar:

"If SMMU_CBA2Rn.VA64 is one, then AArch64 format is selected. The 
programmer should use 64 bit accesses to this register. If 32-bit 
accesses are used then writes to the top 32 bits are ignored and writes 
to the lower 32 bits are zero extended."

If your interconnect won't let 64-bit transactions through, then you 
can't use AArch64 format at stage 1 at all, since there's no way to 
invalidate entries with the correct ASID, and you'll have to restrict 
stage 2 formats to at most 44-bit IOVAs in order for TLBIIPAS2{L} not to 
invalidate the wrong thing.

> Signed-off-by: Hanna Hawa <hannah@marvell.com>
> ---
>   Documentation/arm64/silicon-errata.txt |  2 ++
>   drivers/iommu/arm-smmu.c               | 33 +++++++++++++++++++++++++++++----
>   2 files changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
> index 3b2f2dd..fc3f2a0 100644
> --- a/Documentation/arm64/silicon-errata.txt
> +++ b/Documentation/arm64/silicon-errata.txt
> @@ -67,6 +67,8 @@ stable kernels.
>   | Cavium         | ThunderX2 SMMUv3| #74             | N/A                         |
>   | Cavium         | ThunderX2 SMMUv3| #126            | N/A                         |
>   |                |                 |                 |                             |
> +| Marvell        | ARM-MMU-500     | #582743         | N/A                         |
> +|                |                 |                 |                             |

Nit: the convention here seems to be at least alphabetically sorted by 
Implementer.

>   | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585         |
>   |                |                 |                 |                             |
>   | Hisilicon      | Hip0{5,6,7}     | #161010101      | HISILICON_ERRATUM_161010101 |
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index fccb1d4..d64f892 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -119,6 +119,7 @@ enum arm_smmu_arch_version {
>   enum arm_smmu_implementation {
>   	GENERIC_SMMU,
>   	ARM_MMU500,
> +	MRVL_MMU500,

Is there any actually modification to the MMU-500 RTL itself here, or is 
the problem just in the interconnect in front of the SMMU programming 
interface? I would normally assume the latter, in which case treating it 
as a separate implementation isn't really accurate, and I'd much rather 
handle any workaround via smmu->options, just like the secure access 
workaround (which is a similar integration issue).

Robin.

>   	CAVIUM_SMMUV2,
>   };
>   
> @@ -276,13 +277,35 @@ static inline void smmu_writeq_relaxed(struct arm_smmu_device *smmu,
>   				       u64 val,
>   				       void __iomem *addr)
>   {
> -	writeq_relaxed(val, addr);
> +	/*
> +	 * Marvell Armada-AP806 erratum #582743.
> +	 * Split all the writeq to double writel
> +	 */
> +	if (smmu->model != MRVL_MMU500) {
> +		writeq_relaxed(val, addr);
> +		return;
> +	}
> +
> +	writel_relaxed(upper_32_bits(val), addr + 4);
> +	writel_relaxed(lower_32_bits(val), addr);
>   }
>   
>   static inline u64 smmu_readq_relaxed(struct arm_smmu_device *smmu,
>   				     void __iomem *addr)
>   {
> -	return readq_relaxed(addr);
> +	u64 val;
> +
> +	/*
> +	 * Marvell Armada-AP806 erratum #582743.
> +	 * Split all the readq to double readl
> +	 */
> +	if (smmu->model != MRVL_MMU500)
> +		return readq_relaxed(addr);
> +
> +	val = (u64)readl_relaxed(addr + 4) << 32;
> +	val |= readl_relaxed(addr);
> +
> +	return val;
>   }
>   
>   static void parse_driver_options(struct arm_smmu_device *smmu)
> @@ -1611,7 +1634,7 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
>   	for (i = 0; i < smmu->num_mapping_groups; ++i)
>   		arm_smmu_write_sme(smmu, i);
>   
> -	if (smmu->model == ARM_MMU500) {
> +	if (smmu->model == ARM_MMU500 || smmu->model == MRVL_MMU500) {
>   		/*
>   		 * Before clearing ARM_MMU500_ACTLR_CPRE, need to
>   		 * clear CACHE_LOCK bit of ACR first. And, CACHE_LOCK
> @@ -1640,7 +1663,7 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
>   		 * Disable MMU-500's not-particularly-beneficial next-page
>   		 * prefetcher for the sake of errata #841119 and #826419.
>   		 */
> -		if (smmu->model == ARM_MMU500) {
> +		if (smmu->model == ARM_MMU500 || smmu->model == MRVL_MMU500) {
>   			reg = readl_relaxed(cb_base + ARM_SMMU_CB_ACTLR);
>   			reg &= ~ARM_MMU500_ACTLR_CPRE;
>   			writel_relaxed(reg, cb_base + ARM_SMMU_CB_ACTLR);
> @@ -1923,6 +1946,7 @@ struct arm_smmu_match_data {
>   ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
>   ARM_SMMU_MATCH_DATA(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU);
>   ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500);
> +ARM_SMMU_MATCH_DATA(mrvl_mmu500, ARM_SMMU_V2, MRVL_MMU500);
>   ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2);
>   
>   static const struct of_device_id arm_smmu_of_match[] = {
> @@ -1931,6 +1955,7 @@ struct arm_smmu_match_data {
>   	{ .compatible = "arm,mmu-400", .data = &smmu_generic_v1 },
>   	{ .compatible = "arm,mmu-401", .data = &arm_mmu401 },
>   	{ .compatible = "arm,mmu-500", .data = &arm_mmu500 },
> +	{ .compatible = "marvell,mmu-500", .data = &mrvl_mmu500 },
>   	{ .compatible = "cavium,smmu-v2", .data = &cavium_smmuv2 },
>   	{ },
>   };
> 
