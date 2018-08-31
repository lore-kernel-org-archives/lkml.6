Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CADEC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE5A20652
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="XcVTkGlv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE5A20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbeHaQ2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:28:00 -0400
Received: from mail-bn3nam01on0042.outbound.protection.outlook.com ([104.47.33.42]:18996
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728014AbeHaQ17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fllq/mD3sV9bt/N37w1923wlT1mAyt4uwn88cs6voXU=;
 b=XcVTkGlvI6/xT+x+f1J5KlXl17XPj+IVMc4IIhPbxwE2luvaslu91MeMoOoTMyW2dzw2mNlO+efcUZ/WvJu5PWj1Pc/oidiGL1JNIeJF3kbKhSuQsbqxuOaUmaMt+KZYCwibta1frGJkqF+n1gJkyVe4oBT0aWNSW0HIJUN1Vgo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com; 
Received: from [10.167.103.249] (111.93.218.67) by
 SN6PR07MB4925.namprd07.prod.outlook.com (2603:10b6:805:a5::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Fri, 31 Aug 2018 12:20:41 +0000
Subject: Re: [PATCH] ipmi: Fix I2C client removal in the SSIF driver
To:     minyard@acm.org, George Cherian <george.cherian@cavium.com>
Cc:     linux-kernel@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        Corey Minyard <cminyard@mvista.com>
References: <1535652846-17636-1-git-send-email-minyard@acm.org>
 <a57476f6-a1e5-d47b-766b-5a2221aba026@caviumnetworks.com>
 <fb47a9d3-c033-e2ab-1c49-a376190a83da@acm.org>
From:   George Cherian <gcherian@caviumnetworks.com>
Message-ID: <fc613923-4840-53a2-0831-01a15a6cdf15@caviumnetworks.com>
Date:   Fri, 31 Aug 2018 17:50:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <fb47a9d3-c033-e2ab-1c49-a376190a83da@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: MWHPR18CA0048.namprd18.prod.outlook.com
 (2603:10b6:320:31::34) To SN6PR07MB4925.namprd07.prod.outlook.com
 (2603:10b6:805:a5::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7449708-77ef-4365-b1d7-08d60f3c2bf5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4925;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4925;3:hY///9Eg0oNjHYF+RvpgbfU7P1sDAk6/JWKooY8GNodomEn1CJDDieAtyuqMG+Symsl0b+XrhxsaAyiCl5giQ8ZlORdGvYppQQpbKCA+eDC6IOkZraKEvxyefI/DPU5/lJjSfrE79U014sEdgoGcmnFwGxAx9MUF2W82VkjgfHe8fYMEmWQlgA5jYatDhHpekkfWQBysInx/nKaAgD7+zkZqotuZSN0S/RBsHaqSED+lwQO0N59KQGzg3WmMjjz0;25:bFz11qrXLAmdfuMUyPoNZPIGqvqWaw4I3s/9W96kB9yJWsyoNwh4pNrR6BRBeXikUDEOToyGn5MxTg5KU2PI7IBaDnSEto3KSlrl0T6lpUtYNBk984abr28/OQZ2HHsnJbXs/uWTayP83X/YR0oB0zuGQP/hSAhjbFH5OUAlKSa+n3oKReOacKIKCCtrj+und83zopemLw4P0pgG5RO3IZbsZIBsNRncu/vAyQPjJFVwKs0t+PefcpHE7BUmt5q7Cb40ws2/BDVSVZg11/RLHXHqiF5DkghMxQc8gFeXKHa9CuUA9rLkXUUxy4xBSRrAmUEnx91351yIC8pEn0nZAQ==;31:/w5eUMxfULJDDfr7Bhz75wzTv6/WkAxzaZPJ9Oi1958HME9QzCWUNVwXWVxfcZPa69+vzPCwCPcB1KddN3Fv9UGO98IZx/RW4ujiJ3SRmgdrzHNIZbiwhg8DpGlTPKRcr00cF697TsYtwfdpfa4vCh0xR/FTikNO7S2VA2xurt9RviWFJmrH08VndN2HdjXif7vEXNs2EU8Xog5WIf2LtOzawotDhGBRlYOqoNupaOY=
X-MS-TrafficTypeDiagnostic: SN6PR07MB4925:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4925;20:Zk/jT0ChR0uOrqmoSK9QV2WOiJqDkN8gM8mQIlWOPDsmEBxXVTyTHPCyudbRQvL78f8bm5eeTbrSs+9B1Np8p037zR3+o/G09ZxQtKqmvBYeO/B4f0ZPq9r2vR0JsPvJ/AYhU//z1gBJgY+IEYQiCzSGFohCqsgTDn0OZ0MObepK8kx/ZF2JJZFRlq7DmCbSKj6GS5Xvn4/0PVxYX5W+zviRyn9bMdQOOf5Dn+YwHgLYpaT9NsoN2+1V51TPc49cCGmvXSKaB+20UpUd+x+J1+KPySSlN8hy3QvrmNAb1DYhUkzzwMLvmHqPf92rfzEim2iiR4We5zoWb2rWhyDKwDdF0Gz1RzP5uaVHzSyJdtynKXSsbZ4t+UO9AX733yGMCApfbUBGn/rxXXC1UYJuFckKsLI9dRhYAzzt3cJ3Pzj5YpNcDpSQCUAflpCOok9PFgCtRN6gfdMvFVbuBAKc3MOkwzsFFuyLrCYaqgXLSRavTK1i4FPvc0Ou+u45HScklFhOjPaX51a+OQKANtYZhPMN52Kmf257EcohPmeYk66Taju/7xddj96b3Q3PG0uGtvpmzHgq0XobOaoWXPaqDFRx2Z91JVuayecc8+i4x0w=;4:nQac8iWA7am8vSRnv+97hzQAfaPqBSIWruNnZi3L3vLsxvmafLPbDRVW44UDk3QcbsoL6DEHkteKLB6Ni3czFx5CzYKqwlwuFposeWdhBEhmngcXUa4JxWk4+g/+mK+SeqDpz4kHLAi5LM/Sisq7LC/p2sJe2RadyNjaaPK1bxc9xurSm4ajYImqcuBYovg3F6P23kCQeR1EqWEjgnUiXmDY0AxaDmk9LnScHMSMiF2MJpvUrLGwqYu18uYAqRQCkWO7G2mxnXL+XLlxeCrZO8lyWq3luh/30B8L7NIMEFVdWaUI52yxiojMRuY4VniS
X-Microsoft-Antispam-PRVS: <SN6PR07MB4925C8A65F3B6D06764F916CF90F0@SN6PR07MB4925.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(213716511872227);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:SN6PR07MB4925;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4925;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(396003)(346002)(136003)(39860400002)(366004)(189003)(199004)(65826007)(64126003)(386003)(6666003)(3846002)(6116002)(6486002)(65806001)(446003)(229853002)(956004)(53546011)(47776003)(66066001)(65956001)(8676002)(2870700001)(2616005)(68736007)(486006)(14444005)(476003)(575784001)(31696002)(11346002)(50466002)(53936002)(305945005)(52146003)(26005)(52116002)(23676004)(58126008)(2486003)(2906002)(97736004)(16526019)(31686004)(8936002)(186003)(6862004)(16576012)(7736002)(25786009)(105586002)(42882007)(72206003)(5660300001)(36756003)(478600001)(6246003)(77096007)(316002)(4326008)(76176011)(106356001)(67846002)(81156014)(81166006)(5009440100003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4925;H:[10.167.103.249];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjA3TUI0OTI1OzIzOjZqeDd3TUpKV1Q1SFVjbFkrdkpQQldlbG9h?=
 =?utf-8?B?UGNDcFUrZlg4L1Zxek8wbnQrUUNZek1LYlhPSWpMS21JY1NhZkI4K2hpUnQy?=
 =?utf-8?B?eC84SU8vQ2E4aTlTWUZEQjNoZk15cG5WaFEzYi9YbXYxb29jcXNRSjBSSGVP?=
 =?utf-8?B?dnFMSGlqb1Y4d1VhSk90bkJrMlJTQmVEN2U5MEc4eWVQZnlFZUFQYmlUOE92?=
 =?utf-8?B?b3ZxQUVDOHRqM1lrUEdUbFB5amtpK043MDl0aVN2WmdzeUFNWDZsYXBoWXdn?=
 =?utf-8?B?dll6U0F4ZUJveGUwTjRkUVNJclJoODBTWmM2eVlvcUVYL3hJa2VUTnJyRTA2?=
 =?utf-8?B?b0lIV3RINEx4Q0FCQXo3djhTK3c1eDNDODBIZXJITGhSOWZWWFVzNHBqbkph?=
 =?utf-8?B?ZHE5UjZJUWRZTFhKb3V2WTFRS0JzL25HS1VmSGp1bHR4ajlBc1VJbVpnMG4y?=
 =?utf-8?B?a0J5eXRTK0I0VGp6aTJGSGlOaVFkTmR4dG11TVdUbE9RcWY3MXd0alNZK3hi?=
 =?utf-8?B?MEFjUHBaZlVLRGFza1VLL2lTUFJkS3VPUzluYUY5aDExWlk0Q1dSaTZVWENq?=
 =?utf-8?B?TSsyeHlobmZIRFZSNXIwNG9HTjNTSFV5NFJiSmFMUEdUZGZtemtuMU5vSXFq?=
 =?utf-8?B?VUxMTGN5REFza29jSkdaT0pMVHVncXl2RFNUblRhUUliV2U1VnZsSEVRUStn?=
 =?utf-8?B?SnkyV0FQYVpyem1YeWJEU0J1MllXYUpnZnIzQ085M0VNUXFudW9lZUdjRG1W?=
 =?utf-8?B?cUVGbkpHUmErTDMwMkJiNkozc3kxZndZbW1nSmQ1U2NFSXgwRFF3alNxTStx?=
 =?utf-8?B?NTN5bmVKcDYyN0h1RldyR2lLT01acEVWS0xTaHBEa2I1NU0vaDliY2ROM1Jo?=
 =?utf-8?B?LzZSdzdFMlAwYnBFSml5UG1wZitMT1pDaVRzcWVsbVViRklJOEhzaTFQeFdz?=
 =?utf-8?B?cDBkM3BCN3p3SEsrZ1RIS1FsdFhhZ1c5OHV1aGx4NWIwQWpXT3pLTVp2YVpG?=
 =?utf-8?B?bTg4TWEvc1RkcDJnV2QrdDJaSFd0YytjRm9aWDROMlhOWTl6ejBWbFg5R0wy?=
 =?utf-8?B?bTFyNHVlbDloWk05am00VlhpVndEZHBabEZqT0l6b05aMUhzS3MyWUVWYmpY?=
 =?utf-8?B?NnlCaUM4SzkzS3VYU0hsZmU1OC9WVVJocGN5dFpIb3hWeU5UcEtRN0JUTkxz?=
 =?utf-8?B?YTB3Vzl3dDBrR0pSQmhNNW1XbDV1eGZCT0p4Y0pUSUl2NytFbHNpR083ZWVl?=
 =?utf-8?B?QnlRS3J2cE93b1BCM09PcmpKUXN1NEJiZGtFbUhwRnNiTFR0VDdLRzhJcVN4?=
 =?utf-8?B?R0wzdlJZdnplZ3BZZFB0ZXlSY0tZTis1aXNiRmF4a3MxS1NuaURYcVdyVGF0?=
 =?utf-8?B?N2N2aitCQUxIVmU3aGdob2xCYlRReHlzQzFmSU5WVXE0RkVuZjNrN1dMN0I2?=
 =?utf-8?B?THVGa3NZSk8ySmdvMXFxMEJWK2IwQ3NYZkxpZVR5cVcrOEJ6bnNVeU1ORDN6?=
 =?utf-8?B?YjJ4VlNHQzdWT1dJK2NNV1F2bTcvMm14TlJobUh3RDVaZnpxOU80ZTNWOUQ1?=
 =?utf-8?B?SDNjaHJrdmpaeVREQUw5dFJ4TDYzbkVhTUpYVVZwM3dKNEtGTHFlL0d2MG5s?=
 =?utf-8?B?KzhEWGUzOHlDR3ZjZ29nT1VrL2FaZ3c0M3UxK0hVVDhMZnY0SGdmcjUxanRZ?=
 =?utf-8?B?dTBMRmZGcnpRWm5CTHRWRHlFMEF3aWhxSk42TW1tZG9JWGVLTkthbTVWU1Fh?=
 =?utf-8?B?ZkRlWmhaL0d6TTlvKzk0SUo1bGo2V2xLRldnbC9Ocnk5SnJxUGo2emt3Rm5L?=
 =?utf-8?B?Vmc2ZXdrS0xUa05wem9xTmVnS2FwNGR2eFNBUHR2NVE5T1JORC9rRzduS0lB?=
 =?utf-8?B?cjRQL0duWWl1UEhxZ0xIdXJoSVQ3clB1cFRHc0JRd1crOWRFUy8vdVg0MWd1?=
 =?utf-8?B?UExNWkgvbFZ4WjI5eXBYVDlNazlBMlZQc1cyclZwT0xmLy9LRGRTSzNrTWxu?=
 =?utf-8?B?T3lSUmQ5dzRtblBsakorZUxXYnJqVVJLUHRDdFlsT0lZSEdKSWw5K2RlOG9s?=
 =?utf-8?Q?k/JxpOFO3DXB6rL5dZm4+VDNg?=
X-Microsoft-Antispam-Message-Info: hO4zhzNj6fZ7WVlB61HhgXNvSTXHZNuUkx5NKEhXQQZpHAeYsBmoEvvXqCOac0bw7PtuLN9dG1cdlsXwn0vo6R0R6j3XpZcg0CrLGrj0H4K5l0j0JGei93ASvUf6UfIbqwz9rqBmNgDCLukpLMNIPwg4VQwQEsKQoVOEi1BNwYmwKJG0Uj5dV6lXuxK4hjXseZIL+BF5qO3dWALPqfZoDOkGslohrBvPw/fC8vk5kdrdLgWn5D3rS2aM8Wsv4vKWketB4AMpUVh5aukvuHvHFSbbZaRiAnF8r3hNa83oY+JvhlU0LWssWUwqLgmtEcUgJRjXOCgB8afw42aEN1ns2etiMG6frjmXfFAjbDfkgtE=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4925;6:4qulFKbq71Qwu6odxc7P7YgZ5tEdPaCjEhy6EYLD592LA53eYmTDrvR7TOlHcbQcEAxlWqyNU98aRpo59nbJ+h/sKv9BixjwsrLRxesL9w4XsLRLpkKg4zLbpeSARneqePAysPJTM6OUcrn7QBN33Vs07f1tqpA5hvhfQUcnLUhq8HCZ7J0fDYtAs+mplovOYhxNb4EVpD8SvmGjrVDC8pOQntqpUeBKA3XhJLSNNPnXVcboMEF5RcbIAPwA3YY+kkimPm0dBODne//PevLHfAQZTu2OEKTfHqnDdCKf17HeBUn7b3RPJhKPSY15mLmOjLXHhDn9MVEfV/1bjsJ2fidVz5vRt3ICecKmhFcb3sRlnMOMCgeFf4BrU/5AMA+AZFhT2dyY/k/vcX2D2waeUWt1UE0iWvoDazMCRDbeINqgycA9DQHwUt25Y5XjllZcBVp33wvH4CP9hLmF3nR+aQ==;5:e4dfsbPWyeJ8veRXq4ZmHak7+8k/YM59gCNMindqLTmQ99KdaAs2wpT1uR2dwcdRWcBlMFgZN31Udio/Uzq2uToxpG5dV3HZRds1qhLie681cbnB6mebMJwEzMVoAv8vyLJKeKjokCLrnikz7dWj33vE/Gq2A0OKKselgnTR9o8=;7:vB6tVUJY0p/XwHqO1qfy6Q4O1XSJqZ1Pe4W6jKAu1P5Z7QPA20Ia7KEJloxf4M/iBgX172dSjDASZ6ovY1/VsU0cUDKla1Jg1ZqQb11sev7Ly4f2Tyik1Jltpb9K+gZRh0emJcazhWell6VPRm8wnXJNnfbhvL8tnJIPm/ywf/Aqst1wk8e+hDembqk0b5OVTOkC9khEtNEXyWd+JDvZKBlcPfxsZzQra3KpHhUfEJGyBF9PneBSWqUZfWjNBOov
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 12:20:41.1277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7449708-77ef-4365-b1d7-08d60f3c2bf5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4925
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/31/2018 05:43 PM, Corey Minyard wrote:
> 
> On 08/31/2018 06:58 AM, George Cherian wrote:
>>
>>
>> On 08/30/2018 11:44 PM, minyard@acm.org wrote:
>>>
>>> From: Corey Minyard <cminyard@mvista.com>
>>>
>>> The SSIF driver was removing any client that came in through the
>>> platform interface, but it should only remove clients that it
>>> added.  On a failure in the probe function, this could result
>>> in the following oops when the driver is removed and the
>>> client gets unregistered twice:
>>>
>>>   CPU: 107 PID: 30266 Comm: rmmod Not tainted 4.18.0+ #80
>>>   Hardware name: Cavium Inc. Saber/Saber, BIOS Cavium reference
>>> firmware version 7.0 08/04/2018
>>>   pstate: 60400009 (nZCv daif +PAN -UAO)
>>>   pc : kernfs_find_ns+0x28/0x120
>>>   lr : kernfs_find_and_get_ns+0x40/0x60
>>>   sp : ffff00002310fb50
>>>   x29: ffff00002310fb50 x28: ffff800a8240f800
>>>   x27: 0000000000000000 x26: 0000000000000000
>>>   x25: 0000000056000000 x24: ffff000009073000
>>>   x23: ffff000008998b38 x22: 0000000000000000
>>>   x21: ffff800ed86de820 x20: 0000000000000000
>>>   x19: ffff00000913a1d8 x18: 0000000000000000
>>>   x17: 0000000000000000 x16: 0000000000000000
>>>   x15: 0000000000000000 x14: 5300737265766972
>>>   x13: 643d4d4554535953 x12: 0000000000000030
>>>   x11: 0000000000000030 x10: 0101010101010101
>>>   x9 : ffff800ea06cc3f9 x8 : 0000000000000000
>>>   x7 : 0000000000000141 x6 : ffff000009073000
>>>   x5 : ffff800adb706b00 x4 : 0000000000000000
>>>   x3 : 00000000ffffffff x2 : 0000000000000000
>>>   x1 : ffff000008998b38 x0 : ffff000008356760
>>>   Process rmmod (pid: 30266, stack limit = 0x00000000e218418d)
>>>   Call trace:
>>>    kernfs_find_ns+0x28/0x120
>>>    kernfs_find_and_get_ns+0x40/0x60
>>>    sysfs_unmerge_group+0x2c/0x6c
>>>    dpm_sysfs_remove+0x34/0x70
>>>    device_del+0x58/0x30c
>>>    device_unregister+0x30/0x7c
>>>    i2c_unregister_device+0x84/0x90 [i2c_core]
>>>    ssif_platform_remove+0x38/0x98 [ipmi_ssif]
>>>    platform_drv_remove+0x2c/0x6c
>>>    device_release_driver_internal+0x168/0x1f8
>>>    driver_detach+0x50/0xbc
>>>    bus_remove_driver+0x74/0xe8
>>>    driver_unregister+0x34/0x5c
>>>    platform_driver_unregister+0x20/0x2c
>>>    cleanup_ipmi_ssif+0x50/0xd82c [ipmi_ssif]
>>>    __arm64_sys_delete_module+0x1b4/0x220
>>>    el0_svc_handler+0x104/0x160
>>>    el0_svc+0x8/0xc
>>>   Code: aa1e03e0 aa0203f6 aa0103f7 d503201f (7940e280)
>>>   ---[ end trace 09f0e34cce8e2d8c ]---
>>>   Kernel panic - not syncing: Fatal exception
>>>   SMP: stopping secondary CPUs
>>>   Kernel Offset: disabled
>>>   CPU features: 0x23800c38
>>>
>>> So track the clients that the SSIF driver adds and only remove
>>> those.
>>>
>>> Reported-by: George Cherian <george.cherian@cavium.com>
>>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
>>> ---
>>>   drivers/char/ipmi/ipmi_ssif.c | 17 ++++++-----------
>>>   1 file changed, 6 insertions(+), 11 deletions(-)
>>>
>>> George, your fix was close, but not quite right.  The following
>>> should fix the problem, obvious in hindsight :-).  Thanks for working
>>> with me on this.
>>>
>> Thanks Corey!!!
>> This works for me now.
>>
> 
> Thanks.  Can I add a Tested-by: from you?
Yes.
Tested-by: George Cherian <george.cherian@cavium.com>
Can you CC this to stable too.

-George
> 
> -corey
> 
>>> -corey
>>>
>>> diff --git a/drivers/char/ipmi/ipmi_ssif.c
>>> b/drivers/char/ipmi/ipmi_ssif.c
>>> index e7e8b86..ca4f7c4 100644
>>> --- a/drivers/char/ipmi/ipmi_ssif.c
>>> +++ b/drivers/char/ipmi/ipmi_ssif.c
>>> @@ -182,6 +182,8 @@ struct ssif_addr_info {
>>>          struct device *dev;
>>>          struct i2c_client *client;
>>>
>>> +       struct i2c_client *added_client;
>>> +
>>>          struct mutex clients_mutex;
>>>          struct list_head clients;
>>>
>>> @@ -1639,15 +1641,7 @@ static int ssif_probe(struct i2c_client
>>> *client, const struct i2c_device_id *id)
>>>
>>>    out:
>>>          if (rv) {
>>> -               /*
>>> -                * Note that if addr_info->client is assigned, we
>>> -                * leave it.  The i2c client hangs around even if we
>>> -                * return a failure here, and the failure here is not
>>> -                * propagated back to the i2c code.  This seems to be
>>> -                * design intent, strange as it may be.  But if we
>>> -                * don't leave it, ssif_platform_remove will not remove
>>> -                * the client like it should.
>>> -                */
>>> +               addr_info->client = NULL;
>>>                  dev_err(&client->dev, "Unable to start IPMI SSIF:
>>> %d\n", rv);
>>>                  kfree(ssif_info);
>>>          }
>>> @@ -1667,7 +1661,8 @@ static int ssif_adapter_handler(struct device
>>> *adev, void *opaque)
>>>          if (adev->type != &i2c_adapter_type)
>>>                  return 0;
>>>
>>> -       i2c_new_device(to_i2c_adapter(adev), &addr_info->binfo);
>>> +       addr_info->added_client = i2c_new_device(to_i2c_adapter(adev),
>>> + &addr_info->binfo);
>>>
>>>          if (!addr_info->adapter_name)
>>>                  return 1; /* Only try the first I2C adapter by
>>> default. */
>>> @@ -1840,7 +1835,7 @@ static int ssif_platform_remove(struct
>>> platform_device *dev)
>>>                  return 0;
>>>
>>>          mutex_lock(&ssif_infos_mutex);
>>> -       i2c_unregister_device(addr_info->client);
>>> +       i2c_unregister_device(addr_info->added_client);
>>>
>>>          list_del(&addr_info->link);
>>>          kfree(addr_info);
>>> -- 
>>> 2.7.4
>>>
> 
