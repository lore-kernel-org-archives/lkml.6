Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBA2C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5969220652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="JufcSMkZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5969220652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754774AbeFTJRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:17:34 -0400
Received: from mail-by2nam03on0057.outbound.protection.outlook.com ([104.47.42.57]:27486
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754326AbeFTJRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSrNDoUJ871doqn9WkECZ/1aI3n3RNfGwm0+iNT0ZPU=;
 b=JufcSMkZUFGXQsTQG52g8/CM/BGiMBHrotn8vDP1saxq1JKDfrle+S3DF2KT0w5+rEkxdnKKXqKLQMc9t5Icye3SIdix5AFbdjfcn4xoBL1fzpo+TCAyA9dBxYbH5/4vtV/eQ7Euw33Mrsrj3WYjdX9I6rNIjJFoHli6sdU87ak=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com; 
Received: from [10.167.103.249] (111.93.218.67) by
 BL0PR07MB4914.namprd07.prod.outlook.com (2603:10b6:208:43::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.20; Wed, 20 Jun 2018 09:17:22 +0000
Subject: Re: [PATCH v2] cpufreq / CPPC: Add cpuinfo_cur_freq support for CPPC
To:     "Prakash, Prashanth" <pprakash@codeaurora.org>,
        George Cherian <george.cherian@cavium.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     viresh.kumar@linaro.org, rjw@rjwysocki.net
References: <1529056995-122792-1-git-send-email-george.cherian@cavium.com>
 <67822500-0c9d-ac24-71bc-2717831ab29d@codeaurora.org>
From:   George Cherian <gcherian@caviumnetworks.com>
Message-ID: <44d52166-ed9d-c199-3e19-3df1317ee78c@caviumnetworks.com>
Date:   Wed, 20 Jun 2018 14:47:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <67822500-0c9d-ac24-71bc-2717831ab29d@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: BMXPR01CA0021.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::31) To BL0PR07MB4914.namprd07.prod.outlook.com
 (2603:10b6:208:43::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc4fcb03-f82e-4db6-0a05-08d5d68ea26a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BL0PR07MB4914;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR07MB4914;3:Jo2f3F4rHHcRZdnN3lKj+6rG+lAySurKNbCoHWyJZBwBNeY+YlBP8QctY8/AKR6eVphU+rKnoMiHoJNUQF17UXapT58lGzbk5hsSiDH6y9W4Mqx8Mu7pTixuEZIBCH1EK0uP4piKwJUjXEAEnK7CHsBxRiWfQSfNb5aeIzioaD85JIccCtt2PKq5z8shUcxXoGEbfm9KsJ3Kd7nYyueWzIveDKPymWga20qpC0aepIAfJxRaigNZEau2KPWbrj7B;25:fgxEbI+Az6u0kgNq+gyG1gFxDpKxFZFuZObPmuZAtfUJLiXp9RXO2OR2kuOabdV9VjI/5A4fU+xcw2hgEj2PXkFGy0CW/knjR4F2U0ERSekVUXmY8/NCUDzRZGNIirYdwBaVcX2GYIXsptr0kuOCh1O4lD8Ou6AIWxXM5pnP64R/63KMxDA/9E94GPz2BY8jJAvruBspSe5lSe81WXttS3TvUJTJ5AM3nfTAqnPxmToR32pbrry0Y2O+CL1MXgaetmHejQKMQwFAs0YFNyT5WxMpsI/o+7y7DwhsdrDUM3PmkTUnFhdUtMxFQ0TjHOxGtO6WL2b7mualp0NZfOtoRw==;31:zUCDoVSysKqCNkTaE4Nxab3PttMDVEDeyNr+Zf3NwxGgy4J6cENlk4xUwfZ6FLawXZSmP1K1HXJnnR/B47FHjkylkqaKPQ+5r328VYNEx+1v9XSoi+DWNtrHvtVhwuKd87ViuZx5XqIjda1oQvfTrvGBw6wz4GtYVuD9Kzh7sfTitNpUdm/WXh3NH3yIeulr507vzncvJ7UfMuRBiF4aw3gPMTvqIOwAVjWOXNb6kic=
X-MS-TrafficTypeDiagnostic: BL0PR07MB4914:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR07MB4914;20:ZXSzGrs9sFHJn31+JbmYifisAXtI3XEVbk7aQQTcyNrmdcInPACG02fzAhK0QoXxkdeqRtRI2P9w9WdKFVgzNxPqe7WJbYeb/ju8NunWVR7JBOq6LTEczl3Skw+trZAi+1GKVhXQpTNfNnUlC0Ezb5rnDJJvEG2yTm0YogbU1zFgfYF6dgLI5c7th5Xd2qqj0oc1QAykGdGc6ESqE1va2xG+70zqQ4LjW6bOnGqQ4ED5mnkjrywwAIcFab38vo+7vnNunGgyc/8R0w5DS65Cp6U2HtXqdPyt6unAqaExpZDdL+DtV1xV/0X1APUgAwCvUrvcjxbJNWlj2kDYknvPvmpJCXW3Vo6nxQRoeZR9BCfjg8K8RdTrgT0G7GjyZE6JfGcCrUrY6fHhJ7ghemYBrI8rJhVF/8Guphp+EIuMkcYvRbmjhWHb3XL8eQjXCXK5DWvDaEG7ZECL/Y6GH09vUAl6dHBRl0mzO6JuOg0hG5unWGly9OZjAIRsqES/87FBmnBOrwsodjGL87f0plV46PX5tJOCKg73agS4+d7dMyuXWy1SnpHdiaewkjdhkuwz1DQJCm+CvcLvySm1sh6esiZ661xGIn3tJfrNn/gKrZE=;4:cIhEUGImXV3XKhTAGO/Dgu0zcLn9UKpm/jRdK4CAU8bvoJyTT52RpnhAiaU5AwuOqumDK29xBwx/Kz1yZszlpJrbXVmzUDF5RhJipz4OinxP4kTgbf7waHSvXsjIm3yPAZ9p445TCMVrK1bLfZvDLv34GrpCBPZUT1/TJL1692jecnljzFscAU9LGxsokAsQNkh95blrfsmUEtUtxQAL3Gc4PwgsmuD38z7DOyqylvskkp3k8HC+4TvWr/P6gfdQIT660GkAU79AihQ2gUWeJtPRJlmd4VbIsGZtZVcdBuXH/AWNsY9XLFk8SP1fZCzu
X-Microsoft-Antispam-PRVS: <BL0PR07MB49144287DC8428A5BE81B064F9770@BL0PR07MB4914.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(10201501046)(93006095)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BL0PR07MB4914;BCL:0;PCL:0;RULEID:;SRVR:BL0PR07MB4914;
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(39860400002)(346002)(396003)(376002)(39380400002)(43544003)(199004)(51914003)(189003)(72206003)(66066001)(2906002)(67846002)(47776003)(6666003)(53546011)(2616005)(478600001)(11346002)(8676002)(81156014)(476003)(956004)(65806001)(486006)(68736007)(8936002)(36756003)(446003)(59450400001)(26005)(16526019)(52116002)(23676004)(186003)(52146003)(2486003)(65956001)(42882007)(16576012)(81166006)(316002)(58126008)(110136005)(7736002)(386003)(305945005)(31696002)(77096007)(76176011)(5660300001)(105586002)(106356001)(6246003)(6486002)(64126003)(31686004)(6116002)(229853002)(53936002)(97736004)(25786009)(3846002)(4326008)(50466002)(230700001)(5009440100003)(65826007);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR07MB4914;H:[10.167.103.249];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDBQUjA3TUI0OTE0OzIzOnRpQllIV0dZY3drYkpZQXY2Vi9KVit5cUtJ?=
 =?utf-8?B?WHZmNkhzSDgvbXpEbGZNemVXNmUyVS9mTDc0bTlFeUxCQ2M4NStDRmNycEh4?=
 =?utf-8?B?SWF0eEtqWEd1bHl2R25la28rdDJGbHZ1eDBKUHVjdjB6TUFwMjB4NDJUb0Jj?=
 =?utf-8?B?QllUeXBWUmRQUnRxcmR4MmQxYWxKcGFiTkFUVzZjQ2c3Q28xby91NUpSYVdr?=
 =?utf-8?B?VlorOWRIK3VGL3VkUXdvejNSUmsxZzArQTNEQ0FDYjNLTHgzTFVGYlRVTnVt?=
 =?utf-8?B?RGxPVzBxdGxVVElKMWQzVk5NeFBtSVdHaSs1R0ZSMllES1MrRVZ0ZUxLZUIr?=
 =?utf-8?B?NXFyWkhXKzVFTS85dkpwbzNNQjc5VHVrZ2p4N2J6dDdJVC9jYjJnUTd4dW8w?=
 =?utf-8?B?OGpmLzlhclQrN09CVURmMXpjSEZsUzB6dlhhdndvSlJSd2YzWklpUVpsbWFa?=
 =?utf-8?B?d1RyRktKUkRYM2ExS3VrTktnOXVhcW92cnMrQ296ejNJVVVockxrUXJKQ2sy?=
 =?utf-8?B?L1VMMkhmUlNrNzRRUy8yWmJhNUZxSEQ0cnMrT1JodWorei9kUlpWN0EyWjVL?=
 =?utf-8?B?NXlydjlNVFZDT2lSV1RUSnNTZkFiWjRKdWEwV1Z6TVdweEhYKzYzb1ZvY1Jo?=
 =?utf-8?B?YzA3SVpJVHZ2b3craUxoZ1JKWXlMcHh6N09nQmFaVVIwcnpmZFpmYURLdFNI?=
 =?utf-8?B?UU9nWmtSMUVCdXNBdlpBZ0ZlNHFla09sUitsVWt5aFpYanhYNHk4VkVCcS9L?=
 =?utf-8?B?dkhhcnZLNGhxMng0dzA5TmpxQ3E3MXBCVlZ6Ny80REtWL09YSnRrOVVCL2VE?=
 =?utf-8?B?MkNiNS85MlZkVWd3a3FLOVNxMzBkYVg3SG15dnVyMysvZEJqUmxPQVQ1RFp4?=
 =?utf-8?B?TTlXZnpXbmloMFVWTkQrNzRJQnU5YWNKaG51M3k3RjRCeVRaYmNWT0lpSHFR?=
 =?utf-8?B?ejlXZlZ4SnJDaDE2bm1qMXpIb25KMStzMlE0Q2lDNDNTWEFZbWUxQllYbmRz?=
 =?utf-8?B?NERTTk0rM1J4dkxNTHMvckdSWHA2WTFJVTBFVGdiNDhDZWFoTFNYRlMvN0ox?=
 =?utf-8?B?MFk5TEFKSW15OFM5a3lLRExNa0p5VEhHMkFNeFBMNlJhcEwxT2tObTJnWUNJ?=
 =?utf-8?B?MWhpeVVYVVBmNjh1dEozcTl3NlZ6MU1zZW5nOGM4dkxTQmVEVlJMR3hhUitq?=
 =?utf-8?B?c1ZKYkF6aEZTb2RaT0xTZ21uWnRhaFo5RytNbWppZC8wUDdaSFpyNDRBYW5J?=
 =?utf-8?B?TlNnd1BHNlA1K3hqdXA5VldMb2FmMjVmNldWK25sSE83Q0ZubDRKOU95VlZh?=
 =?utf-8?B?S3F6bThEbTBXdGJqRmNXelZRbHEwNXBZY3FjMUViSk8rNVlBUVF0TVFCWjU1?=
 =?utf-8?B?eW41OEdqZk0zTCtyTzRPeFhpYW1ncE1KT0JwS1lVWklpc05zNWtRR21tdE9k?=
 =?utf-8?B?ZmZ2cU5HTTJXclk4Z1pHM3lvWWtHaDkzc3ZRTzhIZ2tBZkdSTEU5c1BUWjRF?=
 =?utf-8?B?WDFNVnlCem9reDhTSXhXeE5WTFpab3RQU21PenVid0JtZDJqeXUrN3M0RWpH?=
 =?utf-8?B?MkZoU2J3aWJERjBKRFkrOFE1NkFLWXJDb0wyaWJFWkNLcWNlMUhybnd5Z3pr?=
 =?utf-8?B?WXhXWUtmV29abjQreXcyOU5JaU1heVZ0TWFXT09Vc2RHdzRDUWYwOEErdFRj?=
 =?utf-8?B?ME91MTFhTVhJS243S1poS09ZV1plTkJyOG5PV0l3cTIzQ050ZUxjcmtkOUNG?=
 =?utf-8?B?UHltdGJxcm02S0J3eFlha1VvUTJVUWErTEFIcFZxd0tHTTRjVG5PZDVzSGRK?=
 =?utf-8?B?YzJaNFhRRzdyazM1ZTMxSWZNQ1BlN0sxSmV0N0JIV29JNVZYMXZBM3RQSFQx?=
 =?utf-8?B?czhqT1hYTnF5L3dPRjZXcUVudjcySTdyZzN6Y3M5V2NxNEpySHlTMllONzhC?=
 =?utf-8?B?Y3JRbHFxSVNHSDJ2SlNTS2N4QkR0RTBnUE9SYm84aFVzcmRHVEJHREFwTW1k?=
 =?utf-8?B?U3dtVmduUlpqK2VNMy85cTVjS0JQR0NrNC8rVkxabVplaWtPNWNocWZ2Wnps?=
 =?utf-8?B?Y05nZ2p2d1BDWVlYRldIVmg5RDFyVXFUVkJwZFh3L1N4Q21TY3FRU0s5c3Er?=
 =?utf-8?Q?ndreJlJUiSvBdb2+GyBz34k=3D?=
X-Microsoft-Antispam-Message-Info: K1YNts3jOxSj/zOx+3apr7XHVVXAa10Ae8bAZE9cAW07jC7e4q8iCxnehyfGofpj3VnoR2LAopo5iSSmnZMGRzqGcKmJTGscdR9LcSKRN20ALAMXSsyzsmxDK+qKChaGtajlmpMbfDjik943O7N080RcH8vAvu0zlEO6vRb+Tc73s4sdAie55eB4aDD6GU/0xAbYD5Rdct+Gz14CuWAEh/yPWTMk9wVcgttf3bymc/DER8zKzaGfZEQm54V1InXP/VWTUuslvsXxZXEDEgZm/gvV+Aawg1mJIG8FynMob0e+/JUivd7UplOFcu+bam9v4OtpsFyMMWGafl1Pc5xbcw==
X-Microsoft-Exchange-Diagnostics: 1;BL0PR07MB4914;6:9Ztwejo30XuOsDLxij10j44t7V+UsuGDS0vizZvJ6gSa4UYF46xI0b80a0Du8ELWhEh6CDjzrQDD1iYwx1Wh1WJx3F8uj1Vzkj4ukFEONqBvYMf7AoqQPk+9PwqPbhD7Lx5bpe4dAbVjr5taFas/Yq0HGGCKYs676Tr9h+XYg/fN4N5O2CUUnJepJiHAzJGW0owhJLcH/eXPDyEKokkDh5vTRlQqgIA6TOsFtRGBv01xGxa/V409pd3Q0FdnB8muyNkHbadw1+kQXtBFRAKLDnPYSKlaBw9PlBlyOiHsN/uOtXG8KRG6Zil0s94NGiSwzIGGFFcVxxTut9BuYN6HDbUWTQ7VOrrcMqT06Gb7WE+epEGCpconyRoCfCfHAXqDo9UnTdp+64p90//vSab5Bf7/qh+KhOr863DUB/nASw2Fv3vnA22/YV1p5miDZ/AvyX4Sg9VOOPNZwlnVq6pujA==;5:XInSHrI3BEahLknt1O0q5BZhx66dWJG1q1gOpMYFCQcxv9oAJb9dS9nHpHqBrYGZNJpMJ9VEDgl5gZuhsRpy5wsM6NhYRYUnvQ6AS9YLRQ6V2bAzgWmIBOIKMc6480gJZ7M9TLP3E+oWHKwzfjYSgqR79EofTVbDvuGVutjnSek=;24:nKOUtsbEbmeLmpIgzFQIH0st3XJ0L4Dq4jioGz2owp19n/B220Yyj8Zt5hTJtuzZgZTlNVnxP7EoAGc13XeQXgt0ZZ4QD97IUIwKl9sjNmk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR07MB4914;7:dau76S/3DcdVkYvJtJRdmNWvqY+MN+PImAwRb7OycXvhTj/HYdhmXbkHUMDy532n0u2nGrMLSnun5g3vyZAk+Ke//OSJdT4lE28TyiAIJMTHD6liSEVlk4sUnWJAg8nfoHWitzJvPg5jnz93QEHb42bd8Y90I9q/1NwSL6479DFSEE6kxQRb6Tj+GudFv45nZ85ueI9x0q4C0tQEdvfQPVa26ngYxAfMtJUpClHn+Km2YlqqHyTrNwZanJ/MJJLf
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 09:17:22.3508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4fcb03-f82e-4db6-0a05-08d5d68ea26a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB4914
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prakash,

Thanks for the review.

On 06/19/2018 01:51 AM, Prakash, Prashanth wrote:
> External Email
> 
> Hi George,
> 
> On 6/15/2018 4:03 AM, George Cherian wrote:
>> Per Section 8.4.7.1.3 of ACPI 6.2, The platform provides performance
>> feedback via set of performance counters. To determine the actual
>> performance level delivered over time, OSPM may read a set of
>> performance counters from the Reference Performance Counter Register
>> and the Delivered Performance Counter Register.
>>
>> OSPM calculates the delivered performance over a given time period by
>> taking a beginning and ending snapshot of both the reference and
>> delivered performance counters, and calculating:
>>
>> delivered_perf = reference_perf X (delta of delivered_perf counter / delta of reference_perf counter).
>>
>> Implement the above and hook this to the cpufreq->get method.
>>
>> Signed-off-by: George Cherian <george.cherian@cavium.com>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 71 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 71 insertions(+)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 3464580..3fe7625 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -296,10 +296,81 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>        return ret;
>>   }
>>
>> +static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu,
>> +                                  struct cppc_perf_fb_ctrs fb_ctrs_t0,
>> +                                  struct cppc_perf_fb_ctrs fb_ctrs_t1)
>> +{
>> +     u64 delta_reference, delta_delivered;
>> +     u64 reference_perf, delivered_perf;
>> +
>> +     reference_perf = fb_ctrs_t0.reference_perf;
>> +     if (fb_ctrs_t1.reference > fb_ctrs_t0.reference) {
>> +             delta_reference = fb_ctrs_t1.reference - fb_ctrs_t0.reference;
>> +     } else {
> There should be another if () here to check if the reference counters are equal.
> We cannot assume, there was a overflow when the counters are equal. As I
> mentioned on last patch, the counters *may* pause in idle states.
My Bad... I somehow, over looked that point. In case of delta_reference 
being zero there is actually a check below to avoid divide-by-zero. 
There I returned  reference perf instead of desired perf, same I will 
take care in v3. Isn't that sufficient or is there a need for an 
explicit check here for delta = zero?

Moreover the delta calculation am planning to replace with single
line comparison in v3 for both normal and overflow case.
>> +             /*
>> +              * Counters would have wrapped-around
>> +              * We also need to find whether the low level fw
>> +              * maintains 32 bit or 64 bit counters, to calculate
>> +              * the correct delta.
>> +              */
>> +             if (fb_ctrs_t0.reference > (~(u32)0))
>> +                     delta_reference  = (~((u64)0) - fb_ctrs_t0.reference) +
>> +                                     fb_ctrs_t1.reference;
>> +             else
>> +                     delta_reference  = (~((u32)0) - fb_ctrs_t0.reference) +
>> +                                     fb_ctrs_t1.reference;
>> +     }
>> +
>> +     if (fb_ctrs_t1.delivered > fb_ctrs_t0.delivered) {
>> +             delta_delivered = fb_ctrs_t1.delivered - fb_ctrs_t0.delivered;
>> +     } else {
>> +             /*
>> +              * Counters would have wrapped-around
>> +              * We also need to find whether the low level fw
>> +              * maintains 32 bit or 64 bit counters, to calculate
>> +              * the correct delta.
>> +              */
>> +             if (fb_ctrs_t0.delivered > (~(u32)0))
>> +                     delta_delivered  = (~((u64)0) - fb_ctrs_t0.delivered) +
>> +                                     fb_ctrs_t1.delivered;
>> +             else
>> +                     delta_delivered  = (~((u32)0) - fb_ctrs_t0.delivered) +
>> +                                     fb_ctrs_t1.delivered;
>> +     }
>> +
>> +     if (delta_reference)  /* Check to avoid divide-by zero */
>> +             delivered_perf = (reference_perf * delta_delivered) /
>> +                                     delta_reference;
>> +     else
>> +             delivered_perf = reference_perf;
> 
> If we cannot compute delivered performance then we should return
> desired/requested perf and not reference_perf.
> 
Noted!!
>> +
>> +     return cppc_cpufreq_perf_to_khz(cpu, delivered_perf);
>> +}
>> +
>> +static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
>> +{
>> +     struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
>> +     struct cppc_cpudata *cpu = all_cpu_data[cpunum];
>> +     int ret;
>> +
>> +     ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t0);
>> +     if (ret)
>> +             return ret;
>> +
>> +     udelay(2); /* 2usec delay between sampling */
>> +
>> +     ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t1);
>> +     if (ret)
>> +             return ret;
>> +
>> +     return cppc_get_rate_from_fbctrs(cpu, fb_ctrs_t0, fb_ctrs_t1);
>> +}
>> +
>>   static struct cpufreq_driver cppc_cpufreq_driver = {
>>        .flags = CPUFREQ_CONST_LOOPS,
>>        .verify = cppc_verify_policy,
>>        .target = cppc_cpufreq_set_target,
>> +     .get = cppc_cpufreq_get_rate,
>>        .init = cppc_cpufreq_cpu_init,
>>        .stop_cpu = cppc_cpufreq_stop_cpu,
>>        .name = "cppc_cpufreq",
> 
> Thanks,
> Prashanth
> 

Thanks,
-George
