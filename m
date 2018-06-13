Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D425AC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E424208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="XNyJQh71"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E424208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=epam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935550AbeFMM1c (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:27:32 -0400
Received: from mail-he1eur01on0064.outbound.protection.outlook.com ([104.47.0.64]:62638
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935244AbeFMM12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXs/a/mfOsY5sDm4SSMeVi/Za3vrN4QmGUdOM5tSwkc=;
 b=XNyJQh71Tu4EV/3zDtcUakYRIg2G6I85H6EWOn8+7/iCfWlx+ZZ90aV5LYsVrLTDAo03MN9nEXYxZlE/0gLOVDdFxluxOmx3xKTUqgy73QvwodDGqtr5DtXLYpUSMy3L4jzdWgpEWCk29wnsji/2C7k4VgpfZMoU2neNWMJ0BC8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
Received: from [10.17.182.9] (85.223.209.53) by
 DB3PR0302MB3209.eurprd03.prod.outlook.com (2603:10a6:8:9::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.18; Wed, 13 Jun 2018 12:27:23 +0000
Subject: Re: [PATCH v3 3/9] xen/balloon: Share common memory reservation
 routines
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc:     daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com
References: <20180612134200.17456-1-andr2000@gmail.com>
 <20180612134200.17456-4-andr2000@gmail.com>
 <d63f0cf5-5154-f2a3-155e-fdb6dd0959e2@oracle.com>
 <cbaeec5c-0d69-881c-2b42-54855e53015a@epam.com>
 <b79713a9-3a2d-6465-3b22-622bfb7a4d3e@oracle.com>
 <cceefb52-d1bf-c6cd-1b73-489015602f57@epam.com>
Message-ID: <f1537e68-d50b-924c-fe29-3d0d0eb9cae0@epam.com>
Date:   Wed, 13 Jun 2018 15:27:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <cceefb52-d1bf-c6cd-1b73-489015602f57@epam.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [85.223.209.53]
X-ClientProxiedBy: AM0PR06CA0035.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::48) To DB3PR0302MB3209.eurprd03.prod.outlook.com
 (2603:10a6:8:9::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7cb59f1-b294-4f24-d59b-08d5d12904de
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0302MB3209;
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3209;3:b2wvlatwl45bnQvNC/XqsggT7c2sezzbXOjQEqz7gngND1JTeJfjHodGBu1kJ2ksht52lmnYn2OrG/Gm7sASS0k1TwaVkV9zMlleBB8gsoNdi6S9PeUE8CjE5ixJ4FIzLS1+hvhM1unSpCS+0g/UmgZBjI63gB9UtiXmAK5Iv3Re/mqbKMvyBcozgER6EqnEGXVSELzWTz3n12uogRubMALdtPCFFvNi96n2NrdpBIkIGSoi083dQ+cp2jZrgBe7;25:q0DcHqdfVjyEvA5GdkwJjSRY48rlcVXFy1hRahPmTTlsOYNptrt9sN3wuj/4yYdKHuhsnBGZ2sY4Ke86V+tRcfObivnefZWSfVyiggrIEofA76sjfo65JQoKh5iLaIqqdL0pclICDGC7zWsvFy7TjDJwLoXbkMK9JSefkaJ29A0KAWakV0xK7+jXnAjIweEBnpBc1ks597nvuAeFdnx3tOdEFK76wegets/sg4ZD7zTLMrJwhtiPkFAoYXDB2AAVqzI18m7ai3Iwt9Lb8HJliTcIIivRpJcEwUQBWPfiaXsILWbKtp7P3/sWK7E67HZso3Bva8b/gfutyMIVE3/Lpw==;31:r9rmxq1XC6mjd7W1RW61ibN76xBu5nlK9nEEPgL6zZu4ghwoZm0+a619df4bIO4hAeB5EPAsLNQ88g4aykBfXUCQXNodSdmhBZc6oFWhk52Sp+le3z8BPNY/ZyKfWLJ/eZnp5hAguUwbgi22zvwlWCEYegxs4cC/GmAmRqiTqPv7mNOcPKGiHVijGIoZsXdgv6jVncahykVxXAoJFcyEsDQO/XEO5HINdYET821SLI4=
X-MS-TrafficTypeDiagnostic: DB3PR0302MB3209:
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3209;20:cNXPe4FGm6an++wLYbiZ9ywBst0xi/C1DWQLVzN0Gzc0owbbEqNpCTChaSxdTLrEQYKzEH/4CW2Yd0sUokfdW39JjLwb3eelBHqulxBsutAAMbSOjrXM3I1K+JGjq1LPhg3BgqQEf7dvfHa2cQ3ry8pauSnNJNHKRq+l1emBVwlmnxY9eBf5bbNyPSxsnpwSSRY/WRCD1fcrtsBq4rQ2sFDVUeztwPiG9RzkGDoDtO/kE08qn7D63IPA4prlcTZBmv+2+u0ykPPvvXqQf1wVrUk/O0LGKApR4/NZzPUgaJy6yiHV1ssdYp/wtgOsPYmgEhxgwGchKwF05TFZrNhGUN9if9H6jc7odSUQGiiDrwz/sKkLQ9wRvNT9btV61kITXPBXO8XqGat3Kz6OYS7ikg0ZS8e4GeshjhvVNIyBvDjmoVreCCCw+6fjdivLwDQKxhyghmB3Vjg+UxWJz/uG1Rbk4k8tXLhBYqnPIWAbTz7c0vmicHDtSs7QMMK0V7F0;4:F8Ke6hwQDVsX3sR8P/atL2A+xFKUSwAPl37BHgZYvzYp71L7vK7gBU3sR1C2iNqlUGWZPyFzRaUmihlIfwRS0VHmiNeFxY7m0z74392i2mgRBvmjIcD+YeZQcoK1q2o1GIFJ56QFKxLCasqiGGX+cq7Nqwm0W7ofrIB+Avrz/H2V4QHTxmT6WGLK+igRaQIfRtYj+VZP2pJ8pUHg2rQN0y/5ZWx0L9v6w5wigLob/vhS5S5E5JmZ0hCSFpFRtlWtUnZI7umGyQf91YZBcuizTTMbcHmxKloELjTmfcGet+sf2oK+ZuNvt4NMuThwuo2m
X-Microsoft-Antispam-PRVS: <DB3PR0302MB3209CC4FFBC2242D1E642DEAE77E0@DB3PR0302MB3209.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(4114951738403);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB3PR0302MB3209;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0302MB3209;
X-Forefront-PRVS: 07025866F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(39380400002)(376002)(346002)(366004)(396003)(199004)(189003)(25786009)(8936002)(2906002)(2616005)(8676002)(229853002)(36756003)(486006)(478600001)(86362001)(3846002)(65826007)(105586002)(53936002)(6116002)(81156014)(956004)(6486002)(31696002)(31686004)(106356001)(6306002)(446003)(2870700001)(11346002)(476003)(72206003)(81166006)(6246003)(4326008)(39060400002)(966005)(97736004)(7736002)(305945005)(65806001)(65956001)(7416002)(66066001)(47776003)(316002)(16526019)(186003)(68736007)(93886005)(58126008)(5660300001)(23676004)(26005)(59450400001)(67846002)(110136005)(50466002)(16576012)(52146003)(80792005)(64126003)(55236004)(386003)(53546011)(2486003)(76176011)(52116002)(77096007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0302MB3209;H:[10.17.182.9];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjNQUjAzMDJNQjMyMDk7MjM6cXhhMEFVR21VaWttTGRuWWRLVEpDblR1?=
 =?utf-8?B?WXUrR1RrMFA0ZE5uQmlwQ2NyVlhlbDA5dzVudjRrTG1aeE82T08zV2g1YWk0?=
 =?utf-8?B?blI3aWVCYm1MUXJEMTJUTWo0b2w2T0VEUXJrdFFVYzZWbWFjMGVQY0s2Z3J5?=
 =?utf-8?B?SlBoU0gvSUtHSGl1NVJQUDk1R0taMVBQS094S056QlVGSitmT2R2UGZoRldL?=
 =?utf-8?B?TUV4MmdsdTRJZG8waE9rc1JFOTlVTHBwOEJrL2dWQ2dab0RRMVJUaG9qaDRG?=
 =?utf-8?B?WW1qdG9mVTh4UDJja1NsSWd3Rjk4UGZmNDk3VUh4VDNBdnJRL1ltZFlneXF0?=
 =?utf-8?B?a2llYW9GdG55RG9WdFF4aUZSVUNCUitPU2doQW0rMFB6dnM4RkJUa2IyZUlS?=
 =?utf-8?B?c1hBcjM4WlZtSGwzcWtVbW1XUXNSd25vTkhwQndENytRclh1WE5UdFJFV1Iw?=
 =?utf-8?B?YlE3YStXRW1KMVJwdmUvRUgvditmMVEyLytOb0FvUHRkZ0oxN1oxNlByU2RT?=
 =?utf-8?B?c0VJRmozUytINmhZSFNyV0dHaDlZR0lsRTNRWEszbEpEQjhwRHBGMndLUHQ3?=
 =?utf-8?B?M1FsQWZ6RlgrNGRpNTc5Q29mL3o5V1lKMllLc1B3UCtDN0pNZUxrWnFFUGxK?=
 =?utf-8?B?WWFYOUg2VTI5VzI4NjZHTktDalVtS09jWTB0QTdUcnhJNlZqU3Y0QlYwTE5t?=
 =?utf-8?B?VnZSVmtRTUNyM2ptZFpIU2ZjWHAzQU5BUFJNWUllOVFtU0s0QWY1bEdDVDRV?=
 =?utf-8?B?YU8rbDFuTGRGaVRKdXJpUDVQK3VDWlZDSEcxQ3Mrc0RHam1HTlp2VjlkM3JL?=
 =?utf-8?B?S1lrRGIyYk9iTWx3NjBUYkFVbWdqRXFNd1g4OWE4aWVDWGVHdVpORU1BTzRa?=
 =?utf-8?B?TDNnN2p1TXdmUUJuKzd6aFlSZkNPYkR0SnBFQUhyUVRQT1RuYjNmOE5xeFR2?=
 =?utf-8?B?cCtITHBkc1VkcTE0WXJaU1pib0hUeXg5SGpoaGtBTXoxZU13TVZLWm4rc3lH?=
 =?utf-8?B?WFdFYnFlNXVVT0VkakZiaTVvY0VtaW52c2czWGpiZXlxcjIyRWNIZE5tSlRq?=
 =?utf-8?B?Y0U2UEQ0MS9FNDZQdCtmUXEwbEpiblJUcXdGbC9SdURLOXJ2Z2hiNFdmTnRG?=
 =?utf-8?B?dW9naXMveW1wbzZTWk1VM1FMOTBYYVdEc1VCKy9GeFpoa1FRV0hrRmYxTG5m?=
 =?utf-8?B?UVpFekRPMDdFWFJvSkZ2WXY3QXZJUFRLL0xmTGRseTgzS0d5ZWV2SStnWGh2?=
 =?utf-8?B?ZjFkRXkrYmJvTTk4SG92bU5LN1BWdlBibjhPcEtSM0dORFVveTI2SHpvYjND?=
 =?utf-8?B?RG1SMjlhWlRTeU1mdlRabW1sVDZLWHZUNG1RSUEvdm5SR2ZRRVB5d0RxbU1h?=
 =?utf-8?B?OUhrRVcvN2FJWldXNlh3cVoxaTN2eW9xbG9nWldKcjhQRFlBU1RGTStmZTQ4?=
 =?utf-8?B?MlREL1pjNm10WnFYdHMwVlo3b0NPVGFtenNPcFlNc1BScTRKTnBlQURQUkEw?=
 =?utf-8?B?SU41TFI1bkNTdmpuWnVWZFJoTThWOHA3bmluWnhoRWtrWTJFeEhlMWlFODk1?=
 =?utf-8?B?MXFESnUrSFNvanh2d3lLQ3JXc2VxVDZmY1hyV1ErenduU0xZamI4SzRwMjZS?=
 =?utf-8?B?NEZUcGFjdGhQY2IyTVlCN2JnLzZrKzZ0bGJpWmZSbmRrdWJleTVsM2tyZWN6?=
 =?utf-8?B?UmJBVysvdEJ0SnBGUDNheElNcXhxK1VZeGpMcG44UmNWRXpNVHJMd3NDK3VG?=
 =?utf-8?B?aFJwbVZjN2JMd0R1S2o2cmZRVk1WQmU2QWRacTN3T2dNcWNLY2ZLM0ZvOUM4?=
 =?utf-8?B?Wnk3d3hNUUp5bitEbGgyQjdhUTZDTGcxdGVSb2pRbGF4d3FXQXhycnhQV1RX?=
 =?utf-8?B?T0h1VEtyZzB4aW1YSisxUzVLckRGNFJKMlRzVGJoUFQzWVZsaDRjZ1VEU2Y3?=
 =?utf-8?B?eWU0Sm9yUVo5azB0Umg3RFZsemgyUWtLRTZBR1crMm9GWTRXOXlDSHk5anFU?=
 =?utf-8?B?WmFsTERSVDcxR3pJSFg3ak80dzAxRG93UFRzUHd5M2dUS0RiSVYxMzZ0a1V6?=
 =?utf-8?B?bFMyd1hnODNDZHROeFRteE5VaXJWY3VHVlRCb056RldRWDB1V2U4VC9MZVVU?=
 =?utf-8?B?YWtvRlpSVUlkTDNQYitadVREVmlXSGhQVVJpRzZQZmZaS3FmcHY1TG1SR2o1?=
 =?utf-8?B?WTFTbS83blhrdDVYR0R6UmxSMTBxMlE9PQ==?=
X-Microsoft-Antispam-Message-Info: JiA9N4Y7ARyQC39uS6jty5amvirmENylNwG7na29RI2viATVG53gQIGjwWpyFWjCdktEJJe6gU+hNsFCi4J6ySGOopMIfCcmeMbavn7qIME9F/x0ZneQoL+VkEWi62Nw4o9zFWGkTxH72pRG5w5m3VJhsXduuWLjfNCGp0kecUkzB+TLwptAWBMAjq2AhOB3
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3209;6:Nsrb62KM2Ialfh8bx+Km/Vw3dOgbRCxmeeW0PVTm+G3Uubt+MQDNTtzAUCZi+x1+PMYnh1xBdXrG0AKZrUrAjIeefWRtotMInLytO7R7mMpT5F0zbgFypG7BBASk52m67M0NHUS+klliW+I8fQCRYmEOquPHvjk1VjjsM1cIh7+rHD+ZQi2nu7pAVY9ybRvvR0dZO9isB4128QRZgDQdvaLacQMCfsmuMt8Q7XbpQsYpnp7xfiwxknABcPzEcVhk14q+cJU35rszeWO+DyMdI+4MuNjWNfrf9CjBfJrJ81HsSdXlXnatIlTtaInBOPTyxoy5wcfNJ4QWF5e9Rch6e/TCCBA+oLyguSefSK39dgvFvON5aaVvjWAc41BuE97QyticYaO7VB5Dz9IqiF53kItWgw0+p9vkAD0AzXlIka9UydUmDEGuSw8T24CedfmAdjPXQHnwp3h1XagJRsCzGw==;5:WeMgeI23T1eumgpNpTs2L+oThvoC5HlbrVBzJ9vjrdEu1tJPrXLUJ3z/4aJ94F+A0dzzJ9CI4FLpc3WxhCaq6CjuNtV+2AhSLZsM5XELEYjucr9yq/BzmxnX6doioc20Qqdtt9LXeBpMs0P35d/bBzbAuo4T1bQaGYfyTXBNiYQ=;24:sKtae152iVSIKDKHBP+gmRLaAj9OplKZgfVYWW3JQpjRukRp1A1gxLWFaECAQ1i4e/FqThGpvYX9bk5fNqvAK27zpbZBA8M9AEDTpfa9ErM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3209;7:5ERxbkxh7laEfOMBeTLIks5mR1AFk2o9G79YAcYQ3hi55HACjR49g8kAJYX3i7c859+n1itvMJi+vBORd6wnxpHWbgmqBiXwUG0qMMUBfPYmu2+uSeNfBAY0fQyEr2quQNZfP8jGBNXjK9p4BszAJOEptn9BNVtm7nlPwxZZF6pecq7AD9RJ1On1nDKl/vJuTJXpdeVNeCR7jCt9r54G0XJEzLD5GANh3kK2IL9s2/H3vFwDJ2VUrX9b0Q3P2Q45
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2018 12:27:23.9793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7cb59f1-b294-4f24-d59b-08d5d12904de
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB3209
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13/2018 03:03 PM, Oleksandr Andrushchenko wrote:
> On 06/13/2018 03:02 PM, Boris Ostrovsky wrote:
>>
>>
>> On 06/13/2018 02:26 AM, Oleksandr Andrushchenko wrote:
>>> On 06/13/2018 03:47 AM, Boris Ostrovsky wrote:
>>>>
>>>>
>>>> On 06/12/2018 09:41 AM, Oleksandr Andrushchenko wrote:
>>>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>>
>>>>> diff --git a/include/xen/mem-reservation.h 
>>>>> b/include/xen/mem-reservation.h
>>>>> new file mode 100644
>>>>> index 000000000000..e0939387278d
>>>>> --- /dev/null
>>>>> +++ b/include/xen/mem-reservation.h
>>>>> @@ -0,0 +1,64 @@
>>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>>> +
>>>>> +/*
>>>>> + * Xen memory reservation utilities.
>>>>> + *
>>>>> + * Copyright (c) 2003, B Dragovic
>>>>> + * Copyright (c) 2003-2004, M Williamson, K Fraser
>>>>> + * Copyright (c) 2005 Dan M. Smith, IBM Corporation
>>>>> + * Copyright (c) 2010 Daniel Kiper
>>>>> + * Copyright (c) 2018 Oleksandr Andrushchenko, EPAM Systems Inc.
>>>>> + */
>>>>> +
>>>>> +#ifndef _XENMEM_RESERVATION_H
>>>>> +#define _XENMEM_RESERVATION_H
>>>>> +
>>>>> +#include <linux/kernel.h>
>>>>> +#include <linux/slab.h>
>>>>> +
>>>>> +#include <asm/xen/hypercall.h>
>>>>> +#include <asm/tlb.h>
>>>>> +
>>>>> +#include <xen/interface/memory.h>
>>>>> +#include <xen/page.h>
>>>>
>>>>
>>>> I should have noticed this in the previous post but I suspect most 
>>>> of these includes belong in the C file. For example, there is no 
>>>> reason for hypercall.h here.
>>>>
>>> Yes, it seems that the header can only have
>>> #include <xen/page.h>
>>> Will move the rest into the .c file
>>
>>
>> You may need something for clear_highpage() and maybe for Xen feature 
>> flags. But you'll find out for sure when you try to build. ;-)
>>
> #include <asm/tlb.h>
>
Or even
#include <linux/highmem.h>
according to [1]
> ;)
>> -boris
>>
>>
>>
>>>> -boris
>>>>
>>>>
>>>>> +
>>>>> +static inline void xenmem_reservation_scrub_page(struct page *page)
>>>>> +{
>>>>> +#ifdef CONFIG_XEN_SCRUB_PAGES
>>>>> +    clear_highpage(page);
>>>>> +#endif
>>>>> +}
>>>>> +
>>>>> +#ifdef CONFIG_XEN_HAVE_PVMMU
>>>>> +void __xenmem_reservation_va_mapping_update(unsigned long count,
>>>>> +                        struct page **pages,
>>>>> +                        xen_pfn_t *frames);
>>>>> +
>>>>> +void __xenmem_reservation_va_mapping_reset(unsigned long count,
>>>>> +                       struct page **pages);
>>>>> +#endif
>>>>> +
>>>>> +static inline void xenmem_reservation_va_mapping_update(unsigned 
>>>>> long count,
>>>>> +                            struct page **pages,
>>>>> +                            xen_pfn_t *frames)
>>>>> +{
>>>>> +#ifdef CONFIG_XEN_HAVE_PVMMU
>>>>> +    if (!xen_feature(XENFEAT_auto_translated_physmap))
>>>>> +        __xenmem_reservation_va_mapping_update(count, pages, 
>>>>> frames);
>>>>> +#endif
>>>>> +}
>>>>> +
>>>>> +static inline void xenmem_reservation_va_mapping_reset(unsigned 
>>>>> long count,
>>>>> +                               struct page **pages)
>>>>> +{
>>>>> +#ifdef CONFIG_XEN_HAVE_PVMMU
>>>>> +    if (!xen_feature(XENFEAT_auto_translated_physmap))
>>>>> +        __xenmem_reservation_va_mapping_reset(count, pages);
>>>>> +#endif
>>>>> +}
>>>>> +
>>>>> +int xenmem_reservation_increase(int count, xen_pfn_t *frames);
>>>>> +
>>>>> +int xenmem_reservation_decrease(int count, xen_pfn_t *frames);
>>>>> +
>>>>> +#endif
>>>>>
>>>
>
[1] https://elixir.bootlin.com/linux/v4.17.1/ident/clear_highpage
