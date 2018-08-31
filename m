Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171ABC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E76D2083B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="P+X98dPk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E76D2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbeHaQGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:06:21 -0400
Received: from mail-eopbgr680064.outbound.protection.outlook.com ([40.107.68.64]:1758
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726990AbeHaQGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbLB3jNGmGov0HJFRfxNdns/NytivcpipX1RkKL0RT8=;
 b=P+X98dPknFbbSmPy5h7Jlqg7tPzoWZzGZzEHSoEOM7etpUnzWo56jHm2Gfhi8T4cnF7/LBwB9Y0Fjm0hwhiHCEEdlawcDYstm2C6HbaBAuJhyrShFSn+mskxSuusCArNREtZl++7lshR/KfFNRaTJispVx56t2sAGHg0NjV6LMQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com; 
Received: from [10.167.103.249] (111.93.218.67) by
 BYAPR07MB4918.namprd07.prod.outlook.com (2603:10b6:a03:55::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.15; Fri, 31 Aug 2018 11:59:06 +0000
Subject: Re: [PATCH] ipmi: Fix I2C client removal in the SSIF driver
To:     minyard@acm.org, George Cherian <george.cherian@cavium.com>
Cc:     linux-kernel@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        Corey Minyard <cminyard@mvista.com>
References: <1535652846-17636-1-git-send-email-minyard@acm.org>
From:   George Cherian <gcherian@caviumnetworks.com>
Message-ID: <a57476f6-a1e5-d47b-766b-5a2221aba026@caviumnetworks.com>
Date:   Fri, 31 Aug 2018 17:28:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535652846-17636-1-git-send-email-minyard@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: MA1PR0101CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::13) To BYAPR07MB4918.namprd07.prod.outlook.com
 (2603:10b6:a03:55::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 988b9485-251b-4095-2878-08d60f3927e6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4918;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4918;3:Z2mtSkE+R86ijb1c4qlOKqqri8EyItLQd2+kpHMRYJ6Po9u2w7Z5cGmGvzSDhqE8HffMIb1G3ppw2yMxzRrRKkT94f7k0qal3n71tW5dS5p2CW3tRcZpaGCALPJ29iGjyseAMvixQcZZwGd0p20XT71a08NXuZurcv6xklaQ/u2jhPLqR36NFQ/6ep+DW/0WCjNg/A4XNNbnAgteXWkC16e6+KaNyYrcSGkgIOojK68SYAp6/YibyUD2k/vUuGfU;25:ka38dskQl9K0d7ArOWmkDWb6vbE99hbt6UaOqfAxEMySExS81umfnTnbZqxaV03J+UBni1hB85h+jKJedG2lilHIPBnfb+2kQX9ahSsiOeMrwTtlD3i2Mkw3fogBBb1Kl/kwjbV1sX5iDdPWHevwNLViCZGZGCHgDbyPcxKCHHHkpTLSni3iL57GyXi2VIeKC09QYeGM1M9kCD7J8z5+RkclJeb/bYoszDEdzMMpFK2Bjif6HqT2JqbeLhMnsZjkjhh1oagCVWx9DzW1MmP1zIAsjXo4Xn0pQ1v54zR7vw06nmcHVEEEe6jeoT1m1Q3e8ccmLECpYq9pqoC21L7ajQ==;31:nj/E/e+85z18Dt3vUIietGPqZZgNIcf67fhiYhUvwj1HuM92JUlat2PxAIUYXAvufX0OHfjqj0JxLM8JOLzA1ep4PH/+UhCsoJHhivygswgjhDTEQn1BsaTEXu5+owvyux/8RQXgjEuht4Y5fjVNkzujsKQ/FXP7yhNn6iytqkTtesizElwuw3YqVdEfLv2y9eoCv23nomCOZqgIRd2xSmVF9ZY0iOayhKoAAz2Tzsw=
X-MS-TrafficTypeDiagnostic: BYAPR07MB4918:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4918;20:YxoPVeuqCsoUUbU3xFzpeaLMAGyfd7pN2LCl7nbM8v0M7XlbdnUiQ6y5EghCfgYK+3w/QCY9VdT7muINCV/KCO3ePvNHPTbsfhQQvCC8TOQ94sMV0n2ERo0fvJh9zxK+Xvh9mIqZNMfQtwnS51fRQiqLhnND90+IQKStTCQv8PpbXF+0BteT803WkjiKiRVUTd9RlN+q/CSelIb852Ha2/rCM7bTZbpKQp8r7QUMDiQlsSPXno2P/+WlBYeXhUx6bG6IkT+vTJlgo6+S1MvOE8hGXmEEqooLUA48Yo8kL58g6JTP9BBUPPYfsjHHVIfHkYvri3F8bTyXRNbSgotEe5DPe9y/t4iWAkomPlAQCWKcIi+7uyi45kN/tXaIV0l7kNHRLRKqnxN9+z8WUTiCioqxBQqTtqL8BPDFZ3O2c+N6FdE4jYfuI1KxUp0ciS84cMU9v7dbcNyrmLmRgta4h+tYKuW6dYMBO6MIpYerxIS9LrgHtmHWRKSkkWK6kUGXvjGR9bzVePgzH0u3oe2aUQpraSaRljoEBihBPXU4mDCnnU3SH8ae9/u7yDiVxRpEz2x9js8zxcuLQKTyrzaTQ7evljbCpVihrsx4aecVCY0=;4:0eDL4eT3HYETK9oHXJbe94hYu9QFTzRwcpFvHL8SkG52oUnjvDp5zN6UBOTQQb6EYl/v16cVwMW7Qq4pNdo5vJg8P4z9gG/bqu2hMQxEt3Y30eYXef/CKV61DCsQdbL44cD/CmUvcWj0IKYKyCsloirpJsm76TZ1Zvh24wroW5AapmgwzqOFgn8dk7XzylniEKIFQXtDh2Gx2QzQDy9F/z1MVoO/+lzoP0dj7vncjEGIyXEkk+32+D5/WryPbrCxTs2uHbF0ZfbeixXoXFr1/g1Wzu7QMF1ZBaNjtDh3UySZinzn5+XzrGbGwDfE6zrA
X-Microsoft-Antispam-PRVS: <BYAPR07MB49182FB1878598A9B8D3B188F90F0@BYAPR07MB4918.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(213716511872227);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:BYAPR07MB4918;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4918;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(346002)(396003)(136003)(376002)(39860400002)(189003)(199004)(6116002)(4326008)(36756003)(6862004)(3846002)(64126003)(6246003)(230700001)(76176011)(8676002)(229853002)(5660300001)(316002)(97736004)(6666003)(67846002)(65826007)(52116002)(16576012)(53936002)(2486003)(2906002)(52146003)(23676004)(58126008)(5009440100003)(31686004)(106356001)(105586002)(6486002)(7736002)(305945005)(77096007)(476003)(31696002)(26005)(575784001)(66066001)(65956001)(65806001)(16526019)(186003)(42882007)(11346002)(50466002)(14444005)(81166006)(446003)(486006)(81156014)(2616005)(956004)(8936002)(478600001)(47776003)(25786009)(53546011)(386003)(68736007)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4918;H:[10.167.103.249];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjA3TUI0OTE4OzIzOldXQ3Z6eHdDSnBVTnQxYndDRURYRlNCUnk0?=
 =?utf-8?B?eVV2UDd3ZGtZQ25aNlEvQzlreXg5QStIQTdyVEkwYmZkdWI1K1V4SkFRb0E0?=
 =?utf-8?B?Y3J0U1J4dTRnUkxncmJlV2s1c1laL2cvMmpvQWYzZ1Q4amFRMXFEWVh1ZDJK?=
 =?utf-8?B?Z0NrcUtXOTRTelo0VDFhZkhiNGc4Z3dVMXo2dnU0Zk1mbHZXVnpVQ3dmVS94?=
 =?utf-8?B?Wm5iSHVRWHh1RmYwQnJBOEdMdGo1d0tRMUQ2RU1jd2F2dVJRcWEzaFVLNEtV?=
 =?utf-8?B?dlRIUXl5b3VDL3ZFemx0eVdVYjJ1Zk1NS244cGdabzhDbUY2K0I1eThoQTlX?=
 =?utf-8?B?aW9pVHBMMWVTc3JVdm9oR1ZXNEtuYmEwVVlYVkd6dWlRbkwzVTdrMGRLOXUx?=
 =?utf-8?B?VlhVQ3BtV1pEdWVoSGx1RVEvZDJqZTllYS9ERm1TcUp0UTBTdGpORUFrMk04?=
 =?utf-8?B?a1dzdFA0aytYWUU0NXZSZWUrZ0VJR2ZwYmFCcE1MaExNK25ZNmZwVWZaSFdL?=
 =?utf-8?B?akFXbVpNWmh3WERYZzJLTUQ4ODYrUldoK1Z4ZUVvSEEwSDZNK2VjZFI3eklt?=
 =?utf-8?B?UURLSGVrS0JZS0hiS0tTL051MHk2SDFPK09CTjRXWnB1QS9tUjEvdmJEVHV0?=
 =?utf-8?B?YjFKVFd4MHgwT0dURFByaGs4dVFGREd6T0ZMR2c4UitJQjFEa2M2aFhReWFr?=
 =?utf-8?B?VUlleUN6c1EzRElzemdhVHJEZUxKVUJDQS9kRDdOYlBXSlovQTA5a1VhMG1t?=
 =?utf-8?B?YnE5ZzVpaEhKMEtiNGxQZDcrbHJCbUtiMmgydFhReE9vTXpQSDdNVnF5MlNz?=
 =?utf-8?B?dU1YOUtUMDBWU25RQWRUZ3Y1NjJ2NTVFSzlqWU11UGZ5V1Y3QzhKOW9OdEZ5?=
 =?utf-8?B?ZTF2V1lHR0JyS1JTeTRwUHFNNm53a1gwenRyVUJCL2NKRGZMQzBCMFVkSzJC?=
 =?utf-8?B?Z2JQQkZ1OS9INnZiNDdHaTQ5ZWgwaE1DaHlHODhjZmhSSk1HSGJqejRrQXBl?=
 =?utf-8?B?amtBaHBqQndRZzd0TDlFTWhXaHZ3M24vZXlZVGtSV2w3Umt3RXZBQm10Q2Zq?=
 =?utf-8?B?b0NadWorRWNRREhTUlE1WDZKRUNYZWd4b1QvSUQ0Y2hFQXVCdGNIWnJaUUJt?=
 =?utf-8?B?WmMzR1RVc0RhNlVQbVRGUlZRZ01qZWJDdnlnUUcxVzd6a3NCaTFXTXpaYlNE?=
 =?utf-8?B?b3ZwL1ViMVBHc3RWZ1h0OTVyeWMzZkRuaW1vZlU4L1M5anNnZmpQc0dWVFAv?=
 =?utf-8?B?dGhuMWhBNWZNV3lSQkc0b0pNaFpvTHJTQVlpOEUwd0laeTduQlVpZTBITFpa?=
 =?utf-8?B?dEJOOGNpalFYdXpKVXF3VzNCODZlQ1Rack1hNkwrcVlkcEhNbmVEUURwUnpB?=
 =?utf-8?B?MXpVZGxwTmpJRHM5R3g5dzltNndyaWVHaG02N3pleWxCRDRIZk1seUFXR2pV?=
 =?utf-8?B?SFpWNytMU1B0b2RSRGttVkx0U0ZYYXNqTG1PbmtXcEJ0ZXFWTHlXMUttb1VV?=
 =?utf-8?B?WDE4NHFXZnJXM2xkUlVOcVFxeE1lKzBHeVhuaFMvODJDZ1FmMlVGanpYU3dX?=
 =?utf-8?B?ay9ZNXJVZjdhWksrZmo2V0pRQ2JoUkRVUjVjQ3VaYXlFSTBKei9xTVMwSTBn?=
 =?utf-8?B?Sk5oRHpmOWxwNnJJSzdzZXNIQW5BWnhMQTBoMmp2ZjllTTZWV25ZK0pjalU1?=
 =?utf-8?B?QzRwSWxScUdaclE5NjA4b1MrOXBwSEIwcTQ0cVhPeE5rTk4xVzhvaVM4MjI3?=
 =?utf-8?B?YWFTQmFLa2lJZmdBcjdkMmVWZ2dNZFpoM0lYZ1RhWkcrckMzMTFST3pwZHh3?=
 =?utf-8?B?QWZoZXdoaHBMaWVrc09BeVZoN2hMRlU3M0xsalpicHhaRzN2ZStMZWx5TGFM?=
 =?utf-8?B?aXdSNzVoemk4TzF0ejF3SGxHOTAwSWZJTlMwRnNGaWU4M1BwZTZpZW45KzFS?=
 =?utf-8?B?WkNwc3h2L2gzMzVTaE5lSlpLUFBUL2ordFBJcytncEJselNsUXFOSkh5NmNw?=
 =?utf-8?B?dGVMNTk1UVkrcDQyd2hyQmh3UmZWRVJRcWdPY24wOWJWVm5PZE9iVlFpU1p4?=
 =?utf-8?Q?ofn5kEM5P8NJsNNNWe41MtMP7?=
X-Microsoft-Antispam-Message-Info: PG40i8ryhYanDeOIoaWJNzxGCj1a5K3O0tYLXdJ4mJL7dV/ILWFF60rk5CiA5wjCZ0D25YsZ7kPLA4MKXNarNenIrtbM7jcXrViA/TYJLQLNJ8F9c/2DNya4dZCT96BRIAijEO5F4jIIONF2WIfC/x9NqLXpXTNHR+12gjsxa+jzA7CJRZuD1BGTh/uHAqYLBehs91gGz56lODTkx//5bYouyHWCU6dFRBxjcoLj5K1qGg53eC9/in0wgx3o6Z3zsqyzCuLVE0NK21VBg2zS/h5tJkzwEixzWElImlvU63y+F5rAof5WTjfeiyCx4y1WyWpCjZVjU2bwM4oz7jkmJAjhwk2VUdElF93ofZ6aJSU=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4918;6:nO//8ik57q6i9TEiISL07uHMlClRRvNAC482PqV3hZBx+5ZOhllBmLJ4xuI6wzrYZWbykc2LlTkJKwf7fpHFhCEAevsIghuqS7YsCGbyK6orogtDeiT4zj3aznWXz2knmmyTYjnUKVjOEFy81YZShYAf9URSTIGjvG4957xcOcalZFn0iffqb5fasCJpKJtfr0/pBS5lRuX7/NnFVXlEcHEs829ur85qWyLbxfN/5HaW5I2z9hcY4fqSJUbb3IUbtQUn2R+n9K94Cz+esWPj2rh2MNdbLvAskcN7J7cZpGNYs+yFId0McFTu+sa4xx8hIjfGN548vliTmMBCfGWArDpW0DGVBHLiFtWqLUkCrY+2RLVLNUvK5A9hQbuxW5/i9jl0P5nTwyhT9gTuZRgXHUlnqMh8BGGGiIlm5fnFBktkHI02GDsO/XAMgotJ1yecZCBti76TR7pJyk2+HBLtQg==;5:SP0+e7pQ9TsHNiHvlHzzSG15E6ZbJCBp5+ZgHxJcoCzc805NC5/bJTD+xgs5apijpdTzCcvlHNm+lnOSh1Z1Q3r2oHWZ7rLtNnd6jV+0zxaAjAZfqN/UIdyuH1ckB76Wm2lwg/QaoAH5MOW7nzouBRxLwZijpQ9Cwzz6LvP6664=;7:Q/+Sd6xMj9BjTXyXUZx8FieAV7WfRs+DyWJ+j3o1TCgp8PZnzyC170VOdmtJG2GixOo+lnnwCe5KTh1GSYIh7DnMy1YyhYsBuNjeeBLQzqtYx1+UGeJJylO2o+7O2hu5Ee2CjRgom7ff6tiiEHyNnRLLY/kVc05LYUa5uCREO3nfziG66SwD3mEoGhgvcHhEK2+XLeaXMAkrJ2yyDRFjIObS4zQ5Hcid5zHF/4G3+oIDi4SG3MCedRJIQ16VsA9N
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 11:59:06.1138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 988b9485-251b-4095-2878-08d60f3927e6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4918
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/30/2018 11:44 PM, minyard@acm.org wrote:
> 
> From: Corey Minyard <cminyard@mvista.com>
> 
> The SSIF driver was removing any client that came in through the
> platform interface, but it should only remove clients that it
> added.  On a failure in the probe function, this could result
> in the following oops when the driver is removed and the
> client gets unregistered twice:
> 
>   CPU: 107 PID: 30266 Comm: rmmod Not tainted 4.18.0+ #80
>   Hardware name: Cavium Inc. Saber/Saber, BIOS Cavium reference firmware version 7.0 08/04/2018
>   pstate: 60400009 (nZCv daif +PAN -UAO)
>   pc : kernfs_find_ns+0x28/0x120
>   lr : kernfs_find_and_get_ns+0x40/0x60
>   sp : ffff00002310fb50
>   x29: ffff00002310fb50 x28: ffff800a8240f800
>   x27: 0000000000000000 x26: 0000000000000000
>   x25: 0000000056000000 x24: ffff000009073000
>   x23: ffff000008998b38 x22: 0000000000000000
>   x21: ffff800ed86de820 x20: 0000000000000000
>   x19: ffff00000913a1d8 x18: 0000000000000000
>   x17: 0000000000000000 x16: 0000000000000000
>   x15: 0000000000000000 x14: 5300737265766972
>   x13: 643d4d4554535953 x12: 0000000000000030
>   x11: 0000000000000030 x10: 0101010101010101
>   x9 : ffff800ea06cc3f9 x8 : 0000000000000000
>   x7 : 0000000000000141 x6 : ffff000009073000
>   x5 : ffff800adb706b00 x4 : 0000000000000000
>   x3 : 00000000ffffffff x2 : 0000000000000000
>   x1 : ffff000008998b38 x0 : ffff000008356760
>   Process rmmod (pid: 30266, stack limit = 0x00000000e218418d)
>   Call trace:
>    kernfs_find_ns+0x28/0x120
>    kernfs_find_and_get_ns+0x40/0x60
>    sysfs_unmerge_group+0x2c/0x6c
>    dpm_sysfs_remove+0x34/0x70
>    device_del+0x58/0x30c
>    device_unregister+0x30/0x7c
>    i2c_unregister_device+0x84/0x90 [i2c_core]
>    ssif_platform_remove+0x38/0x98 [ipmi_ssif]
>    platform_drv_remove+0x2c/0x6c
>    device_release_driver_internal+0x168/0x1f8
>    driver_detach+0x50/0xbc
>    bus_remove_driver+0x74/0xe8
>    driver_unregister+0x34/0x5c
>    platform_driver_unregister+0x20/0x2c
>    cleanup_ipmi_ssif+0x50/0xd82c [ipmi_ssif]
>    __arm64_sys_delete_module+0x1b4/0x220
>    el0_svc_handler+0x104/0x160
>    el0_svc+0x8/0xc
>   Code: aa1e03e0 aa0203f6 aa0103f7 d503201f (7940e280)
>   ---[ end trace 09f0e34cce8e2d8c ]---
>   Kernel panic - not syncing: Fatal exception
>   SMP: stopping secondary CPUs
>   Kernel Offset: disabled
>   CPU features: 0x23800c38
> 
> So track the clients that the SSIF driver adds and only remove
> those.
> 
> Reported-by: George Cherian <george.cherian@cavium.com>
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---
>   drivers/char/ipmi/ipmi_ssif.c | 17 ++++++-----------
>   1 file changed, 6 insertions(+), 11 deletions(-)
> 
> George, your fix was close, but not quite right.  The following
> should fix the problem, obvious in hindsight :-).  Thanks for working
> with me on this.
> 
Thanks Corey!!!
This works for me now.

> -corey
> 
> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> index e7e8b86..ca4f7c4 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -182,6 +182,8 @@ struct ssif_addr_info {
>          struct device *dev;
>          struct i2c_client *client;
> 
> +       struct i2c_client *added_client;
> +
>          struct mutex clients_mutex;
>          struct list_head clients;
> 
> @@ -1639,15 +1641,7 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
> 
>    out:
>          if (rv) {
> -               /*
> -                * Note that if addr_info->client is assigned, we
> -                * leave it.  The i2c client hangs around even if we
> -                * return a failure here, and the failure here is not
> -                * propagated back to the i2c code.  This seems to be
> -                * design intent, strange as it may be.  But if we
> -                * don't leave it, ssif_platform_remove will not remove
> -                * the client like it should.
> -                */
> +               addr_info->client = NULL;
>                  dev_err(&client->dev, "Unable to start IPMI SSIF: %d\n", rv);
>                  kfree(ssif_info);
>          }
> @@ -1667,7 +1661,8 @@ static int ssif_adapter_handler(struct device *adev, void *opaque)
>          if (adev->type != &i2c_adapter_type)
>                  return 0;
> 
> -       i2c_new_device(to_i2c_adapter(adev), &addr_info->binfo);
> +       addr_info->added_client = i2c_new_device(to_i2c_adapter(adev),
> +                                                &addr_info->binfo);
> 
>          if (!addr_info->adapter_name)
>                  return 1; /* Only try the first I2C adapter by default. */
> @@ -1840,7 +1835,7 @@ static int ssif_platform_remove(struct platform_device *dev)
>                  return 0;
> 
>          mutex_lock(&ssif_infos_mutex);
> -       i2c_unregister_device(addr_info->client);
> +       i2c_unregister_device(addr_info->added_client);
> 
>          list_del(&addr_info->link);
>          kfree(addr_info);
> --
> 2.7.4
> 
