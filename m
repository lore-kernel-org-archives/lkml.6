Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A9BC2C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B5FB208B8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="s5xa/dVZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B5FB208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755230AbeFNNTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 09:19:22 -0400
Received: from mail-dm3nam03on0060.outbound.protection.outlook.com ([104.47.41.60]:52125
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755010AbeFNNTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 09:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1uzFsX9lOqhuvNtoTsuhpnFe0TC0ru8yefg6VXet+E=;
 b=s5xa/dVZEyrv/bm1hzBMcHgTsBxFTBjL9tAO9iyESZkrzXVPwBi14YB6NFxgi1XT9AHc4VN6gZN7jBHlCoE34XCSK711DeZcJONf0VzdRwDWBZQKogC1NCX9vbmQI/bhJVTbKBPXY5m8EG8JhpgxxMuDbs1N5QP0DqOP+LsV8AM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
Received: from localhost.localdomain (155.4.205.56) by
 BYAPR05MB4581.namprd05.prod.outlook.com (2603:10b6:a02:f2::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.12; Thu, 14 Jun 2018 13:19:11 +0000
Subject: Re: [PATCH v2 1/2] locking: Implement an algorithm choice for
 Wound-Wait mutexes
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
References: <20180614072922.8114-1-thellstrom@vmware.com>
 <20180614072922.8114-2-thellstrom@vmware.com>
 <20180614124129.GA12198@hirez.programming.kicks-ass.net>
 <3d73590a-13de-9164-4b32-9d7da6a1055b@vmware.com>
Message-ID: <cf725c06-e0cc-d28b-d3f3-62fe59e565fe@vmware.com>
Date:   Thu, 14 Jun 2018 15:18:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <3d73590a-13de-9164-4b32-9d7da6a1055b@vmware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: HE1P18901CA0023.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::33) To BYAPR05MB4581.namprd05.prod.outlook.com
 (2603:10b6:a02:f2::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b897670e-0af4-4c77-08bb-08d5d1f96d76
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4581;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR05MB4581;3:utUPLtp86z7W2eWZYAuGjwKzM/l4FKymm9PqI/YbCpi1mAHpbfxmAtozl6SMmWntU4GUK2wbKWnJM/HXz5pSddKo82udPzrIU4rb9aLyg5ZqLXc5HljiYI8sbePfzaeULejckyQ51FhDoFImrXNApjOamVLczvUBnpKtIQmjTeO886RO/TZSInbr5u/9WnU9qIoIBAdPtcl6t7yVX4nAZYpISRMgArmoH96C57FFx8xLhGL4AjZBA8YrP+6tVs9Z;25:RKNcT9YeU97MlGdGcW+QXMU8sAck2BADcd0+eaSIy4xAuxjs9HVr5Kit7ke+frub4kJuQ94teudFM6mUS01qwlD/961GS+pSkf/29Arf/loWa6Bi/t0FoJ9IZtuA3trmG35JOsaYwL2ZZq0ZxH1ybJPvn3JgTm5BcxeAdDR5ZQTGcDSgiDt3emcfDe9Nm9pgZKvmP4oonAzwXkBD9vKCl0/T298lqLOICzTTYCfml+IuNZ0JwBlasFmf42UBYLXFw0Bm42jKirldECBaw7oocNkai8uESjZp2vrv2Ss142XVEd2jLGLB09gLj8w46WOZ2lz6fy6IDEnKHeRu8gYXvA==;31:10CJl8P6Kf9Qy08OR/hi4JIF+mJvQgFOel6USIyl1jM9EY1rgU4af/ENoYLECF//0/lvM+0ueoKQykuGIhzFtzPUNDWBLf75sUl0zM8IG+UXePQja89Pz8lhP9u/AFr9pYYT5BnKv+kpRlLuAQ9Kg/q427rrsVyoj3/Bl0OJ1qfMNYSAHVTtUy80U9Pdq1tj/See7pINNT1+8ANgo8QNx+ZsZZqED3lJFhcuEHX1Kss=
X-MS-TrafficTypeDiagnostic: BYAPR05MB4581:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR05MB4581;20:aCGsTquakMoR0lwMgRBWWiFsV0GdYDQuPOfxn9/6/WgO/wdLnmzabUAPqp8HOyI2o40MYhz/sYQeGRy9eSnF/BQuL/qfNhjMGsgYGJmtboUgKG/TCsTeG3DZwPAgI0Q5k0WU0V/a1jmweidCC0dVIS5G/+eycNvBjV2Jy1tAroDk0n4vYstLxix7eVfMcx29xONTCD6qtcoPhidlDB1TjGMNIjOMtBgK8lQaEIO6URqpEH3TblSYdIc1S4++wiBjwhW9dlZYWnDgUWsUx3Irdzr4v0yFc95RR8pf3Vm2WYYsszg6YNOidszsgyw9mPW8C2m9JAj+8X+wDCa69AkUFz7M+a9kghMRwh5onxSb6NnsEa4tEK+VeeIjTTR/ndy03ospK+UfnXUufTAIiTmcfsE1xLRKKd0zDKLg5ZLMudbh9zXrBLZp28pKm8OZfPTq0lpCmM0FixCo+Ir9NCwplHyJGyZ0+wsPymrisWZUmu4twRyDj6C61SZ5VtCgR26Y;4:D47xooI98ZtI/Q7IvlfqwQUlzyP+ZekTz3KegeCr0xw74qQTfrxYXDFkvTXI0u531CDTxGNcLiZ6EfNRhRqYpL7ki6Rvn+a1V9DRGQhg2CbEbgmQxHfLiINP5wrmxMW6zbrwzM1JLOgseO3SxDxKiCwXtc2jxPPVhTZFjdyjBA7CVXwTE+WIoLu5qRHin2Go02lsxP1EH6nSRg/sNi2gwQFcofejhuGcAmMPwUOUaRf+PRDrePOvERE2N+mxMR0HQgvJ2Y2df9mmzw0ZuE43jg==
X-Microsoft-Antispam-PRVS: <BYAPR05MB45816F366120DA1DA3CAC90AA17D0@BYAPR05MB4581.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BYAPR05MB4581;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4581;
X-Forefront-PRVS: 0703B549E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(39380400002)(376002)(346002)(39860400002)(366004)(199004)(189003)(31686004)(956004)(2616005)(486006)(26005)(64126003)(476003)(446003)(11346002)(6246003)(53936002)(25786009)(68736007)(186003)(16526019)(50466002)(478600001)(6512007)(4326008)(229853002)(6486002)(65956001)(65806001)(66066001)(305945005)(47776003)(7736002)(81156014)(81166006)(8676002)(36756003)(316002)(58126008)(59450400001)(53546011)(386003)(54906003)(6506007)(5660300001)(7416002)(65826007)(105586002)(2870700001)(97736004)(52116002)(76176011)(6916009)(93886005)(6666003)(2486003)(106356001)(23676004)(67846002)(52146003)(3846002)(6116002)(2906002)(86362001)(31696002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4581;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjA1TUI0NTgxOzIzOmJWUGtPM0YxOVY2aHVHd0VSc284bHNmUmNB?=
 =?utf-8?B?dXpzR0Nxc1Eza05iYitvZjRFa0NMeXVzankrSGRXbWIyazcyYmJwMk5CZm4x?=
 =?utf-8?B?NmY0b05OVFp1SlJ3QkE0b21peWV4cWlad05CVVQyN0ZWVDM5aVJXNzNzNENm?=
 =?utf-8?B?QjJGT05ocDErWmxXWk9tL1d4WnFaVUJyVWY1ZXlTSG1td2x0VlhPUDZ2d2FT?=
 =?utf-8?B?Ny9zb0pwcnZacjdUWEp6N1RkUWZFaVJtU3NsaDJjRUJaQktGL3dWVFpiQi93?=
 =?utf-8?B?Nzg4K2pDeHZ0WlNFdThnNU1SZVVDWDR3VS9rOTU1MG9qenJ3TUM3WjNNWmN5?=
 =?utf-8?B?WkJDQ0VyMGNvcEd0ak95OVg5dys3UHdMMWFLa3FQVHZKR2pDazBmdXRqb21s?=
 =?utf-8?B?TjltY2h3S0JDOE5Tb0w1NnN0TXhONEJablM1M040RklCdW5scmYwaHArREV3?=
 =?utf-8?B?Nk5naHU0U1h1ak1YaDlQZytpQS9CaWcvemFGOS9HVXVSMkNKeUxaQWEwRjBY?=
 =?utf-8?B?R1RkNjc5Ty9MWGlRV3Q0TmM0ZWxQZjRhRmxHUWh1ZE1kZUhqYXQvRENlOWZQ?=
 =?utf-8?B?RUlrS1phcDVYcUhKUS94UkFDcGlsWEMyZmNzbU13US9CYWcxcXhXQVdmRlBo?=
 =?utf-8?B?dW5lLy9acTJLZDB5MS9VNy9paWZjRTgxc1MrS2REMkk1cWNXbkFmWjE5SjRX?=
 =?utf-8?B?TVZ3Qk9rODNkMXBsRE5iMVgzclZzMEtqaGhvVjE0dElPbGgzZTRlVVgzV2Yw?=
 =?utf-8?B?cDE1YktoYnRqTDF2Z1dtN3I1UEN0RUNhNVBLSHpQeVVrMTJYeWJvSEVWc1lH?=
 =?utf-8?B?bEwvSVJkeXlpUXEvaExwY1JYUCtTWVlVZmZJOUZYK0VnbklPU0VpZW8vbW9F?=
 =?utf-8?B?U3VjVmNJSGZkbVFiMXBIL1VsREdPYjVtcEtqbjRnV1BXRkF5djhnM3lqOHdI?=
 =?utf-8?B?bnMrc3FCa2Q5RG1rMVlzRE5rdGlWU1hPZ0prRlN4YjAvQUs4STBUb0lIaS9Z?=
 =?utf-8?B?aFV3cTBxSGJxVmhReEVXZnBuVnBlQ2UvNGJMeFJiV2NvckxxSVBQYXo3d2Q5?=
 =?utf-8?B?MVFzbDdUK1YwWVhGL2s5NlhlcVRhbmNDa2xwVi9yWW5iWmxJZGliY2lUVTNP?=
 =?utf-8?B?S2IvV3FTUTIwbWJkRWJCNUpTYnhFNWxXMDIwclgvSWp3M1l1aGxKc052N0F3?=
 =?utf-8?B?elRQTmpCQS9Sdk9LbFZVQlkzaGdJZTIzYlhjVnUvSHZicUlRektEZ3NBWEt6?=
 =?utf-8?B?SEt4MnovMGJlV3BuTitUYXBkSnNxWGRpTjJudVpNRVNFcVl5TktseU5BTnJ1?=
 =?utf-8?B?YURCTXFieHVaY2tkQlNaU2xVWFhwKzkzNVkrSHczTlFpVHNuVmhmZTE1SXRa?=
 =?utf-8?B?RzkyMzY5Mmd3TVg5YXNpUXBiM2dzQUVOcnlQbWI1YXpxdzNYdS9yK2JqbzVB?=
 =?utf-8?B?MzZYYWdmMm5FZHA0aXU3V1dzR1RHanZGRVcveVZXdThjRkU2UU1kVFZ4Rysv?=
 =?utf-8?B?d0ZnbzJ2MlJybGJXeURmZFpkY3RHdmp0a3lhVWUza20zN3dPWGc0bHplc0dl?=
 =?utf-8?B?TUczK05VY003WUNER2VKbTJ0ZWZRaWlWNXYzK3NFZFo3RDJrdGRPSnZLTnB1?=
 =?utf-8?B?dTBNRUI5dFp4M0poRmtaZVh2VkNKK0g5bitXSmJ0RlAyUlQvbUJPRHhjRzRC?=
 =?utf-8?B?SlI3am50Z1RibEptdlZoYlY1eHV3VC9lMFZuenFaSEdkUXNkdmhPelRxUkhB?=
 =?utf-8?B?QmplVlNzaU5SbytlSTVsc3hCOWFlVnlsdFZiYmlYQnZqOS92OGdvM2dWM051?=
 =?utf-8?B?eXErTFBmTlNIU0htQ1J2eXJsV2ZUaVJUY3dxeWg5Y3J6dE15OGprUXlyczZR?=
 =?utf-8?B?OEJrbFNyNS8yYkFCZExCMEFMOThvdmlGYXZSOEFmSzRqeHdnZFh2b1lHUjAv?=
 =?utf-8?B?T0xyczRONGRvWXVVbWRJeFhHT0kzRkJIZ0JqUDJEdUlaYTFrNnhvanZ4dHZV?=
 =?utf-8?B?SFZXTXBmTU5vdGhScFU4azJ0TFZNYWV2TW4zR042Q29rcmQzdHQyZ3pLZkND?=
 =?utf-8?Q?lchqU35T3jlX2SfX5t9XRQuoy?=
X-Microsoft-Antispam-Message-Info: Mh12eN0oVG92B49XfFEdG+LDloImWKt5/u+RpVBZh6BhMq9FfLUaTzXUOjsRZ8LWF9rrJEn+6Y3bgRSLMWbiil432v8WUiysHrImRtvpV+TtXeP/iEN/sCFnCYBv0z8O8SGulYntGjjoCZF7GFbvX/1RbmD2YmtTJyzlmL1H3o9eC5BaBEdQLwGcK+r7EBOr
X-Microsoft-Exchange-Diagnostics: 1;BYAPR05MB4581;6:vLMjdlhumYC2kGv5+Wl6B+elStVZKd9eK9MOVIqfVEHSnjweSaG1Qcy6t5txS8wnzXIq4ODJH2Mnij5CXa7ytVtiy+5srpU68Ig2UQGtA/aSBLbzpHYtTsFz8BrMFhHkdPYJbWO/p1jY6tRufyntt7AjNvyrV+gwSdjxZQG9byVn36O7MoOCvZgTGvQ0RV/9urJguldjY6RIMOr197h+9tgTe5yyb3R4OIwmbpONhyxVLotqqIKc5dgiKrNnDlUKso9Kv7S7AZkHDXY0ADg7Hc+f/0C3U9DumB6NnX+ZiLBDN9PGSFACdvUPrSz8KwdnQIHxttr0sbhOD9TycH5vSYN6HRaMyrV5EdR6AveAL0IIysOIuSN+1dkLIBQvARzTf9EdFW+VHMDZVyq770dTt78YUncp0HhDdwYnxFxk6xhyDqe0w10ecYTEsd6+By9IL8roRNvu9aQrXmKnyYzuzQ==;5:cRG+JF9MjVlUsGaeXvfeD+JDUiRNfp+lCggLQmSdGFjJiFqJzxBqhi+Shl6yTyNUU5GiPXfzfvEZrI700nZL2HIUSkYm8B4lLwMCCYIOIfb7SgE1rDggSJEtIVIVIn/9B4rXwT6hEaE5neO2DNvuedtmqeqyoZAy5yWa0ZbnN7w=;24:q79AXOdNVHCCQKUuYZwFcab70Hw5c2YPtjk1d4QMBfr75iQqUJfTwWO7ZI/Z15GWoQc1+h1XgALsD6LGJ7n7BRRXplY7F/7tldOwyamI5eI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR05MB4581;7:eNQkfnx45uDn8+RQptSwXRUZU1pkacW57BB/4naA9ENBpVt2w2QrmcqonpAGVAYFOLpGvNCucPafk5fC5G0kI0UVzkfcWOEwXhZqdwJqSZK+6m5g4x9sUB8Tbxx0uYc+1ppKlDwRUcN8WWDXGLuHYZtSpqzVg971A4Iy+3exZR1jsOuU6MWr1zXJbFRCEkhvvfSEUrdjSrRwuxcbf8QvejkR8pz08KcCNgKRtum80wlrOPO5Z8RS/iHCqieeyniz;20:X68RzU+7jlkiUPOVIiC5ayEgjpuxZI3WY4Vu1NHLFdSAN3h08jWMb4MBZjz9NomXnaq/sT5ypIu3wfwG9m+ssLLl5aVE1V3/K4monf3iQn9XqDmlhM8njfkudobOAFN5PxMA3l2XkiDGhwopYWTSjgnYTcmih6HG0d5LtWZhiw4=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 13:19:11.2986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b897670e-0af4-4c77-08bb-08d5d1f96d76
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4581
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/14/2018 02:48 PM, Thomas Hellstrom wrote:
> Hi, Peter,
>
> On 06/14/2018 02:41 PM, Peter Zijlstra wrote:
>> On Thu, Jun 14, 2018 at 09:29:21AM +0200, Thomas Hellstrom wrote:
>>> +static bool __ww_mutex_wound(struct mutex *lock,
>>> +                 struct ww_acquire_ctx *ww_ctx,
>>> +                 struct ww_acquire_ctx *hold_ctx)
>>> +{
>>> +    struct task_struct *owner = __mutex_owner(lock);
>>> +
>>> +    lockdep_assert_held(&lock->wait_lock);
>>> +
>>> +    if (owner && hold_ctx && __ww_ctx_stamp_after(hold_ctx, ww_ctx) &&
>>> +        ww_ctx->acquired > 0) {
>>> +        hold_ctx->wounded = 1;
>>> +
>>> +        /*
>>> +         * wake_up_process() paired with set_current_state() inserts
>>> +         * sufficient barriers to make sure @owner either sees it's
>>> +         * wounded or has a wakeup pending to re-read the wounded
>>> +         * state.
>>> +         *
>>> +         * The value of hold_ctx->wounded in
>>> +         * __ww_mutex_lock_check_stamp();
>>> +         */
>>> +        if (owner != current)
>>> +            wake_up_process(owner);
>>> +
>>> +        return true;
>>> +    }
>>> +
>>> +    return false;
>>> +}
>>> @@ -338,12 +377,18 @@ ww_mutex_set_context_fastpath(struct ww_mutex 
>>> *lock, struct ww_acquire_ctx *ctx)
>>>        * and keep spinning, or it will acquire wait_lock, add itself
>>>        * to waiter list and sleep.
>>>        */
>>> -    smp_mb(); /* ^^^ */
>>> +    smp_mb(); /* See comments above and below. */
>>>         /*
>>> -     * Check if lock is contended, if not there is nobody to wake up
>>> +     * Check if lock is contended, if not there is nobody to wake up.
>>> +     * We can use list_empty() unlocked here since it only compares a
>>> +     * list_head field pointer to the address of the list head
>>> +     * itself, similarly to how list_empty() can be considered 
>>> RCU-safe.
>>> +     * The memory barrier above pairs with the memory barrier in
>>> +     * __ww_mutex_add_waiter and makes sure lock->ctx is visible 
>>> before
>>> +     * we check for waiters.
>>>        */
>>> -    if (likely(!(atomic_long_read(&lock->base.owner) & 
>>> MUTEX_FLAG_WAITERS)))
>>> +    if (likely(list_empty(&lock->base.wait_list)))
>>>           return;
>> OK, so what happens is that if we see !empty list, we take wait_lock,
>> if we end up in __ww_mutex_wound() we must really have !empty wait-list.
>>
>> It can however still see !owner because __mutex_unlock_slowpath() can
>> clear the owner field. But if owner is set, it must stay valid because
>> FLAG_WAITERS and we're holding wait_lock.
>
> If __ww_mutex_wound() is called from ww_mutex_set_context_fastpath() 
> owner is the current process so we can never see !owner. However if 
> __ww_mutex_wound() is called from __ww_mutex_add_waiter() then the 
> above is true.

Or actually it was intended to be true, but FLAG_WAITERS is set too 
late. It needs to be moved to just after we actually add the waiter to 
the list.

Then the hunk that replaces a FLAG_WAITERS read with a lockless 
list_empty() can also be ditched.

/Thomas


>
>>
>> So the wake_up_process() is in fact safe.
>>
>> Let me put that in a comment.
>
>
> Thanks,
>
> Thomas
>
>

