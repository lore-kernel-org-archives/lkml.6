Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8448BC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23606208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="XwRlKm7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23606208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbeGKF4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 01:56:51 -0400
Received: from mail-eopbgr700046.outbound.protection.outlook.com ([40.107.70.46]:54464
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726474AbeGKF4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 01:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYGsT1mh82h93dw1VC+9aFfL76HtCw38JNwAxqwwX7M=;
 b=XwRlKm7EBEb7DKxQ/MCzurpO/HZwF87MLuN9sNW3A7vN3zsjxNEb0ghG9mj67ejsx/jUzDqUKKNoCNb8D+kh/ut8+c5OWTgmjncpH6EBtn/b88MDAO1oZmtiC/KypfPYSKzW3kHWYoSLlIVOv8OKK41lJGKC68d3c80athwrgsg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com; 
Received: from [10.167.103.249] (111.93.218.67) by
 DM6PR07MB4923.namprd07.prod.outlook.com (2603:10b6:5:2b::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Wed, 11 Jul 2018 05:54:09 +0000
Subject: Re: [PATCH v3] cpufreq / CPPC: Add cpuinfo_cur_freq support for CPPC
To:     "Prakash, Prashanth" <pprakash@codeaurora.org>,
        George Cherian <george.cherian@cavium.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     viresh.kumar@linaro.org, rjw@rjwysocki.net
References: <1531131048-60762-1-git-send-email-george.cherian@cavium.com>
 <802dd310-a26c-3baa-696e-15393d6e1516@codeaurora.org>
 <3bfc37e1-e82b-c09d-462f-bf4f79aec91f@caviumnetworks.com>
 <687232fa-d355-1a91-be3d-7cde3c62fc5b@codeaurora.org>
From:   George Cherian <gcherian@caviumnetworks.com>
Message-ID: <7558209e-71c5-e4fc-541f-fac585abe9e1@caviumnetworks.com>
Date:   Wed, 11 Jul 2018 11:23:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <687232fa-d355-1a91-be3d-7cde3c62fc5b@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: MAXPR0101CA0064.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::26) To DM6PR07MB4923.namprd07.prod.outlook.com
 (2603:10b6:5:2b::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a986ebdd-9035-4440-8496-08d5e6f2b9a2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM6PR07MB4923;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4923;3:P0T2UoCGAyERl+Qr3tB8vl/sQfiGRcxThUwLTMVa0beEuTismCCiMtZWHdPEVr9948j/sXmSQ207AFiWDMWWbxIQJntt73miRgSdLHZ7wS5TF1KLmvpfoDqaa0Lk3TApLoqTZfImpjTjA9f6EqRmoUN7KZ7XBzMkwcJ4p7t0AbUP3Nm3EKYI02Adv1ZFEgP6pazf0uTyymJmjNhIN9AAtzDhLxTyTV7LOFgn6Vxvljpaco9h3Zz9Ch8ndUcCj1fr;25:L9TBS9BzGYye7BTpe70R/m032If7I6cUyz0wZ9Ph3Wp1ghSRPZvk/yTpx0dbZM8KADsVd4zpLpyWC+GcUjaOHDpBuRpg5RfGF6G3m6dUh+FZk80bErN3fiuAD41FsLTzvZfPIXjrGo/ZJj3lSHK83ck/01RJx7VVsKXFq9hdsr7y7SdMNaQWjyEWCBwF6VgGG78Ru5RMoZLN1r8faBFwhnwx31HazG00Rw1Tx/5LD++mTkAO3SMGCECLOLQ6Yacbji17c58c2JaP6DnAs/jhUvcCbN8KRfpLDVF8yetx/qEEgxysNtIhPovt2H17HMEFeM06Zqr3ujmYm8fyKMzrKQ==;31:b8wRqSPDApu0eBdHFXDbGOCoxKCVKE1T1SgRAt73Fn4BUmFJ8szg3C+TlO+fJY4PJsxqSMoxqJz6inse9dG+1uVJD5HWpu4MWnQsQ3Rx/tum2oEKg/D6U+UEwXR3QHgd3Ytx076vAdZUP9qTzc16yewZD4H+jIRD9/k0majhEJ549IuDME71kwsl8goa0bb1efP/W8kAd5oBYUxoCcYMs1uwGyamnPym48TQM4mukEc=
X-MS-TrafficTypeDiagnostic: DM6PR07MB4923:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4923;20:GSeDETnsvEjFVtttNriMzs6Xi9oJNpCMuEe+zTZF67gl9lzvCDOvQRxQOXJQw3beWO3guM4g/MB5vYfF9VbuRMoLI3QIiV/PdNQ+6st/3t/+CxfVJNTlaJDWkVQl2dFg2OcetzBVogPyM+HeZbUsnSGs7EhMiMSmqxio1bv3ZnufOc7GlcE6Iq0G2ej9Xsusxx0pWxU+Ce3FV3G5vuNxtfFuFWPxA2dLV3aRE4sVQRY+n8qodaisdOkiTx2MI7JHNt9FbtSBaSsoQ+RhVdqqg2/dQxHizZp0PaaGHw/50G934Um9RQMW9+MdnBvnWcr/U3CrxgZPNzXN92cFEGZUq58fp41DR/Y+nf/FG8RhZE+Adh7rpCs3PQGjK+3xFCbJvcxiUl4aGPSs9L5Q3tdewDLFb/412RqO6HTynyvhCc+tRf4gh026Tm4Wk4wgqs7qmCN0SOfm4D8sCtgD+TVMOB70w1dNaC4d/a+8/OOttUcffve5sqOiQ1xZTJbRN0wOerub9JfVGH5k4JUh02nS+S5AvmYaGU7mWzMmZbni9Pwy7d5W1dHwcJ8lvt9vv4UPsTEKNmCPsk3Lqr6KNN7ej9ML+AsJTZhGMzbp7WTKVxQ=;4:EOiNAu75zfsH742LURbfz4Z1fgIturIxM5UA9VuezvOezR+no/fFMe+iqtWQC5x1Ga4FNtqIXxYccVpbVhiWIDsVNzDYiH/3yeXZIWyrcZjCLMKW50qYwM3WNFl4VdH6gamlsSjmdQbTvzVX0+GyyatzEm8jNoyBtcTUA/qwVBqwHhkPMUJhmVUfhjiuuHql4OKCRQJnKvabPIRqOiwEFkF1gtXCjOtFuOqLjmGg/K0q9kzfnhvMLAB2Nm8Um3Lz6T6GhcdnnulO0VJEUPtqdg==
X-Microsoft-Antispam-PRVS: <DM6PR07MB49236F0803C32711F6DA0265F95A0@DM6PR07MB4923.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DM6PR07MB4923;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4923;
X-Forefront-PRVS: 0730093765
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(136003)(366004)(39850400004)(396003)(346002)(199004)(189003)(478600001)(31686004)(93886005)(65826007)(6246003)(72206003)(229853002)(97736004)(305945005)(50466002)(5660300001)(6666003)(7736002)(4326008)(105586002)(106356001)(31696002)(16576012)(110136005)(316002)(66066001)(386003)(956004)(67846002)(25786009)(76176011)(486006)(23676004)(52146003)(2486003)(476003)(77096007)(42882007)(26005)(186003)(47776003)(8676002)(16526019)(446003)(2906002)(2616005)(68736007)(81156014)(53936002)(81166006)(53546011)(230700001)(52116002)(3846002)(14444005)(6486002)(8936002)(36756003)(5009440100003)(11346002)(58126008)(6116002)(64126003)(65956001)(65806001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4923;H:[10.167.103.249];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjA3TUI0OTIzOzIzOnVtUFowTmZMNTI0NEpOVUd0eUZtL3RjbVlY?=
 =?utf-8?B?aC9KLzhVVm50OEFlUktjbUczZHl2dW9RQ1FQbjZhU05vNzdqY2ZRelJOK1RY?=
 =?utf-8?B?cGJiR29CdkYzdGFMSnZyZ0E0QXN1VHU4SHRkejMwR2xMSjk3UHJaQjlROW5W?=
 =?utf-8?B?ZjVsNkg0SHZLbkVuY3c5akFPTFgxRjdhajd2a3Y3MEY2NWFSK0xUVERORlFB?=
 =?utf-8?B?dklyYXhHUkplNzFwamVjV0pEclFDaHZEemszWit2MW9QOVRlY1UraFo2V04w?=
 =?utf-8?B?RUd1bFR0bXU0UU9GT3pDTkJDcEJ0UW9DVGtyTWRQRUt4RWZERW0vS01hWjA1?=
 =?utf-8?B?MTVHdU1DOE15SU1wU3BneE9YRmgzWkI0TWkxVUhDQTAwcEFrRENoOVJSdnBI?=
 =?utf-8?B?YmxPMzdjSWhaNDlwM3hqazRRMmtHSGNLVEdESlZGN3NWK2RjZFdmL0pNRFpC?=
 =?utf-8?B?ME5SZTNVUDc1SHNPaWprYm5FVmEwU2x3UGdud2ZtaHBuWGUyd05hNGVUMHI4?=
 =?utf-8?B?UWxhc0x5MXBWdXJCTGg1eVRvYm1nU2hBZXpVWEVIc0ZzYjhpWitjemFaY0pT?=
 =?utf-8?B?M0dOVlFMUEltV21ndXhtYU44aExjYkZEMUFlRW1Cd2tHZmdBam9Gams1RTl0?=
 =?utf-8?B?N0sxRDNCbVZicGJZeFpwdVBJRGM2emp5VWhBWXB0aEhxSk40bXR0dWM1dElJ?=
 =?utf-8?B?NXBVN1NDL2VBWFRZYktFbGdzeXVIWEx6MTFSdW9SZWdjVDVVOE1VVGJiQ3lr?=
 =?utf-8?B?OFNDMkNnMWZLMDVyV0wvdVhXU0NqamcvRXdPclpXWmcwR1VFWGJMUjJkL1g5?=
 =?utf-8?B?QWU0Z1E5OXE5cFFUTlFMaVl5alk2cEREWkdneXBNd0dsMEo3VXdpNWNaWVRT?=
 =?utf-8?B?QWVlRUIySlBNRy9Iam1aaVhOUHpYUFIyQnU2Rng3RG15S3prTDV3N0JlR25y?=
 =?utf-8?B?Wnk5M3NmWW1aamdUdXZBVkJUMExySWpFUzlwVm1DOElsODd1enpHeHRQcUFj?=
 =?utf-8?B?OWtMcEk3OE1NU0ZaL1JmNjgzaERuOVd2MTlCajJDb0R0dUcrb3pVNWxpQ29D?=
 =?utf-8?B?Wm5DUlc4SnhVWnR6bm9jNlpHd3ZkZDBGcHo5dlRKbTI2Q0Vqd21vZE40OXh1?=
 =?utf-8?B?cWZPcHFxUldJczJiVnV3c3FDYmRvclRScjVudHVVV3Z2Ui9nT2xOc3htWkxu?=
 =?utf-8?B?RURnRGRHc0o0STdEbWpBVUwzZDVlR1A4clBoNlJwTk1lK2VqeWdlQ1BaaUF5?=
 =?utf-8?B?Zkp3WHNFZnhLRWVPbjVKQmsxUU51M0EvdkNyZnJMbVYza1RSSnNqUTJaemJZ?=
 =?utf-8?B?L1RPNEF0Qnh0VUpjdlpQRmRnNTU1OEtXQzk5QUtvemRTeFhrNnpWVjN1akRo?=
 =?utf-8?B?cHlTN2JRN0M3RjU5bFN2eVM4bE5SYjJqRGlNRnVCRDNISC8wN3ZCa0V1a3JN?=
 =?utf-8?B?dnlJcDNsYmhmRkJIejRyVUVaOTkrdzBpZFY3eDdPOTZWb0s1L0NXUUVuQk9a?=
 =?utf-8?B?ZEZMVjBVaUNTRlJjRUtydTJEM2t3WjNaNGFlaVNTOXdsc2QyK2RNWjdPWjVY?=
 =?utf-8?B?MmRUUldWUERSbm5icVUzWGNNcUErVFc5bkFpUWlmTHZzeXlwQmF0V0x1MmdX?=
 =?utf-8?B?UlAwYmNjcHJWeFNMcGk4Sld2RE9jNVl1MzNPWldDbVN0emp1YU1CNDRDZ3Bs?=
 =?utf-8?B?bkhSbGRkcS93aFFLTXpHS0J4TzdJR0kvTW9wVm5rNHphdEMyci9oN0Y0UGR1?=
 =?utf-8?B?QWxoNk9lM0hqbDl3aGlER0pZYjZ1TGFFckRkS0dNVHFjRGl4THNranRoS0t1?=
 =?utf-8?B?dHo3WjVYV3VxbUxDWUYxYUFiYlJwelo4M0xLTEZUbFErT0dYRGtuV1VYdUta?=
 =?utf-8?B?L3lmQ1l6NWRod29DQ2IzcGRIVjNtZXR0S2JjQU0xb3VkdlNXMTJqclN6VHZu?=
 =?utf-8?B?RkNzajVKMVNTai85S01GWTBsWlU4SWtSbGsyWjJXYjJPQmkwVTdaNFF2UzVR?=
 =?utf-8?B?blpoQUQ1cVd6YzFmM3VUK2c1cVJGK0tOVzY2cHplYlAvSTd0VmJnK1ZvQWtT?=
 =?utf-8?Q?DpmEYDi6keT0NOEdKiOAeaUim?=
X-Microsoft-Antispam-Message-Info: Hom4EBpMEJMFSTPBvV3/kYsYt8lOMaYu3psLo0K2bODyEYxHZtslG9F+NRsoDHMUSxSKqatQ7TKbXeL/ZBeUw7S2JBmLN/sPV4kujFzfzvvE0Sj3CEvuL7TSUomy4gQ9q/dxxreROPYPfyGId4+XG1bexq6uAb9Em4ZcA4WcPDjKs0pus9Mra1VDXh3FxqDWNBdYQ/JvTT+ljNJMunjHlyEiwmmDN1Z3h+wcRlxeP0mUC3WMNxvujy30JY4NKd5hxYDyF0sENGTMx+jRoi58ZmXU6YIhBrLxwOlJSLTifSk6s2m86KxLoejrka9akfAnonM9oEmTBymLRc4cPa2cCKZCHC3kaN1CRe7a7Y3wAUI=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4923;6:SSLxcXqSCIHSUI80mf6NAwa+3JjK19lIaIdfmoErulZTd/dLn4GfOOaonL43r9dc7Vhtux78d52OepjSr+n6w9rUcDgpWSBq1U+Tfm7pFYNC1qm56z7PdfOErMcW+2AdC1yDwN3J2QXMtCXFDWc7lAJk8D4evnvWKuV7RraNS9zel7yHkK7ehnrzR60cQZGyBS0xOeG6f+YaSftEr8v1V1OblX+TIVh7byhvAvpuj4Il1BIRKpBu6EYo/EVFX3AioOx+JEMUKmU3ZGqLuakYIuIBZc4ZcF+WA6PMmMA5i8wbLVTA0E/YBTR5/AaycNEi1eUkIOtNItKUC8wqV70n3ZUEr2nq1BrqnWheC7hV9i6S6tRLMktY0ifJaOR96jkzMLIv7S8wR5f0fJVwIf51tPWikR/yN9QVamKVE1XE6l2vOqGAfa8aeKQUUDOYqU8Go5TKbwzLLjPSSFAlD8VpxA==;5:H6vkrZOr2fArTi8wSHVzF4eRGixl/EyGC9KPBbEhiVwLdeX4ya7WrSt97VVbTkPX86VU8nQTV6JSBGapDQGWk6XbhjaiUYoQFVtUx07pPyIExSveWOifQcChWEdHbx53BpUl6brPwHsHKWSzd20kaaxHXku/yzgFYbUaHFyDWmE=;24:o9vsGBujWdgVK9zer8SU5M67vQcrRDDFM/WUB2dG9qQxwZwb0FKL4Rxl8DzwOvC3GUQIvEooS3dMFtCrM9ylZdBJD6AakStKC31IG4oMvvU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4923;7:Oizq8YbOVUeS4tfacohfk5FKVcz1Nw36u+ZWroXk4IHXTWxlPhMVTK44oYN8v2H7kiCmJYoSi+DdSuRN9eQBA67XbVQ7OOoEBM1CC7LfVAqESItnedRRDgW40f20PmMqjRX5bn/PhhIMTVNGLXFGBIvkPuKNCEVRa7mKJJ9DlQ6KGxcBsqkjhgaHU3jfdrpl+0DByrWEWuAef7eCJKd/hSLAeRyUdQstjC0PT6iDMaIB6mytQfxGvWmxi4SfgLjg
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2018 05:54:09.3390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a986ebdd-9035-4440-8496-08d5e6f2b9a2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4923
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prakash,


On 07/10/2018 09:19 PM, Prakash, Prashanth wrote:
> 
> On 7/9/2018 11:42 PM, George Cherian wrote:
>> Hi Prakash,
>>
>>
>> On 07/09/2018 10:12 PM, Prakash, Prashanth wrote:
>>>
>>> Hi George,
>>>
>>>
>>> On 7/9/2018 4:10 AM, George Cherian wrote:
>>>> Per Section 8.4.7.1.3 of ACPI 6.2, The platform provides performance
>>>> feedback via set of performance counters. To determine the actual
>>>> performance level delivered over time, OSPM may read a set of
>>>> performance counters from the Reference Performance Counter Register
>>>> and the Delivered Performance Counter Register.
>>>>
>>>> OSPM calculates the delivered performance over a given time period by
>>>> taking a beginning and ending snapshot of both the reference and
>>>> delivered performance counters, and calculating:
>>>>
>>>> delivered_perf = reference_perf X (delta of delivered_perf counter / delta of reference_perf counter).
>>>>
>>>> Implement the above and hook this to the cpufreq->get method.
>>>>
>>>> Signed-off-by: George Cherian <george.cherian@cavium.com>
>>>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>>> ---
>>>>    drivers/cpufreq/cppc_cpufreq.c | 44 ++++++++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 44 insertions(+)
>>>>
>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>>> index a9d3eec..61132e8 100644
>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>> @@ -296,10 +296,54 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>>>         return ret;
>>>>    }
>>>>
>>>> +static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu,
>>>> +                                  struct cppc_perf_fb_ctrs fb_ctrs_t0,
>>>> +                                  struct cppc_perf_fb_ctrs fb_ctrs_t1)
>>>> +{
>>>> +     u64 delta_reference, delta_delivered;
>>>> +     u64 reference_perf, delivered_perf;
>>>> +
>>>> +     reference_perf = fb_ctrs_t0.reference_perf;
>>>> +
>>>> +     delta_reference = (u32)fb_ctrs_t1.reference -
>>>> +                             (u32)fb_ctrs_t0.reference;
>>>> +     delta_delivered = (u32)fb_ctrs_t1.delivered -
>>>> +                             (u32)fb_ctrs_t0.delivered;
>>> Why (u32)? These registers can be 64bits and that's why cppc_perf_fb_ctrs
>>> have 64b fields for reference and delivered counters.
>>>
>>> Moreover, the integer math is incorrect. You can run into a scenario where
>>> t1.ref/del < t0.ref/del,  thus setting a negative number to u64! The likelihood
>>> of this is very high especially when you throw away the higher 32bits.
>>>
>> Because of binary representation, unsigned subtraction will work even if
>> t1.ref/del < t0.ref/del. So essentially, the code should look like
>> this,
>>
>> static inline u64 get_delta(u64 t1, u64 t0)
>> {
>>          if (t1 > t0 || t0 > ~(u32)0)
>>                  return t1 - t0;
>>
>>          return (u32)t1 - (u32)t0;
>> }
>>
>> As a further optimization, I used (u32) since that also works,
>> as long as the momentary delta at any point is not greater than 2 ^ 32.
>> I don't foresee any reason for any platform to increment the counters at
>> an interval greater than 2 ^ 32.
> 
> We are NOT running within any critical section to make sure that there will be
> no context switch between feedback counter reads. Thus the assumptions that
> the delta always represent a very short momentary window of time and that
> it is always less than 2^32 is not accurate.
> 
> The single overflow assumption about when the above interger math will
> work is also not acceptable - especially when we throw away the higher order bits.
> There are hardware out there that uses 64b counters and can overflow lower 32b
> in quite short order of time. Since the spec (and some hardware) provides 64bits,
> we should use it make our implementation more robust instead of throwing away
>   the higher order bits.
> 
> I think it's ok to use the above integer math, but please add a comment about
> single overflow assumption and don't throw away the higher 32bits.
> 
Okay,
I will spin a v4 with the get_delta changes.
Also note that the get_delta function doesn't throw away the higher 32
bits.
>>
>>> To keep things simple, do something like below:
>>>
>>> if (t1.reference <= t0.reference || t1.delivered <= t0.delivered) {
>>>        /* Atleast one of them should have overflowed */
>>>        return desired_perf;
>>> }
>>> else {
>>>        compute the delivered perf using the counters.
>>> }
>>
>> No need to do like this as this is tested and found working across counter overruns in our platform.
>>>
>>>> +
>>>> +     /* Check to avoid divide-by zero */
>>>> +     if (delta_reference || delta_delivered)
>>>> +             delivered_perf = (reference_perf * delta_delivered) /
>>>> +                                     delta_reference;
>>>> +     else
>>>> +             delivered_perf = cpu->perf_ctrls.desired_perf;
>>>> +
>>>> +     return cppc_cpufreq_perf_to_khz(cpu, delivered_perf);
>>>> +}
>>>> +
>>>> +static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
>>>> +{
>>>> +     struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
>>>> +     struct cppc_cpudata *cpu = all_cpu_data[cpunum];
>>>> +     int ret;
>>>> +
>>>> +     ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t0);
>>>> +     if (ret)
>>>> +             return ret;
>>>> +
>>>> +     udelay(2); /* 2usec delay between sampling */
>>>> +
>>>> +     ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t1);
>>>> +     if (ret)
>>>> +             return ret;
>>>> +
>>>> +     return cppc_get_rate_from_fbctrs(cpu, fb_ctrs_t0, fb_ctrs_t1);
>>>> +}
>>>> +
>>>>    static struct cpufreq_driver cppc_cpufreq_driver = {
>>>>         .flags = CPUFREQ_CONST_LOOPS,
>>>>         .verify = cppc_verify_policy,
>>>>         .target = cppc_cpufreq_set_target,
>>>> +     .get = cppc_cpufreq_get_rate,
>>>>         .init = cppc_cpufreq_cpu_init,
>>>>         .stop_cpu = cppc_cpufreq_stop_cpu,
>>>>         .name = "cppc_cpufreq",
>>>
> 
