Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEE9C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B70220846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BXHTw4X9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B70220846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754434AbeFTQBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 12:01:02 -0400
Received: from mail-sn1nam02on0071.outbound.protection.outlook.com ([104.47.36.71]:20682
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754406AbeFTQA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 12:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imUYBas8bQvmstUbJzOpZw0Yf3/RzY+f3YaL2X0+qeI=;
 b=BXHTw4X9jHSAxkS0L9GCW3Up9q5QoBlFnM60pysR6arZkJ2JHYTuYpajibEW4YKcIHRLQA6kCCC33mHw3RntE+d++MLB4tCcEsJ8w6ouke71IMfm0Mi83iHD14UGidZKT5x/27CYZdJy/6wDpL4Ay9IBHxz6Kw4IPF9cvalLQWU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from [10.236.64.67] (165.204.78.1) by
 DM2PR12MB0172.namprd12.prod.outlook.com (2a01:111:e400:50ce::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Wed, 20 Jun
 2018 16:00:56 +0000
Subject: Re: [PATCH 1/4 V3] Add a function(ioremap_encrypted) for kdump when
 AMD sme enabled
To:     Lianbo Jiang <lijiang@redhat.com>, linux-kernel@vger.kernel.org
Cc:     iommu@lists.linux-foundation.org, kexec@lists.infradead.org,
        dyoung@redhat.com
References: <20180616082714.32035-1-lijiang@redhat.com>
 <20180616082714.32035-2-lijiang@redhat.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thomas.lendacky@amd.com; prefer-encrypt=mutual; keydata=
 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
 zSNqP+QUNp6BotWI
Message-ID: <e5bb19b7-7db4-1c1c-d8bd-cc44d6b7bebb@amd.com>
Date:   Wed, 20 Jun 2018 11:00:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180616082714.32035-2-lijiang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0801CA0004.namprd08.prod.outlook.com
 (2603:10b6:803:29::14) To DM2PR12MB0172.namprd12.prod.outlook.com
 (2a01:111:e400:50ce::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79439658-f17d-4e9a-842f-08d5d6c70239
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0172;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0172;3:qKHlSmIvT1f2en8eSvZFpjguPkQSYbtJVInDr7O7TJZrg9UgoLX5ZyqMWbsgjBz8d5WP0hKgzQPPiGq6f9P0pxZcAjUxDcgF6MPuHSwBTyCf/wktiPbYoUb5MiNaVewEWQnNMn93VIQPqzFcRPGZxVHFXFNx3CmancJK0Kni55DVRe7SII+jVj2s3k1PFiD7ZUIdSWhyjshgATvqhmO39Xm2C05jKjn0R9D31zw7YzvLRfg0oeQHRQBM/ipQhpjr;25:JC53IGLz++Ibxov7lmUJL/yvjA1fYG3djEnHeNoFldHGurea8oGIUj6q4M+88QGEKAT/Temmp924hSndYhLfbVGOXwBCqf56+kk19gkVS9pxyiC/Bp9qANVBRQKOUeGFeKnWLM+lRUdwt1PjZvkNwI25vc2WyOJyz1Obro3nYpNMM8y5zX3MFoj1Rx37pc8m9lmGe1cDn6oCcyM9LAUjVKJJCHRniFlXMO3wO7J4AJ3CEyjnqFJTvTWGWpli48zf6KJ+1IU5F7rGKHYwDsXz8TfKDuzyS5/bTiMasbU/aokqZL9Vbk4DSXY/ZBMJPAPJLsVjM7hmLd96L6iSePqFBQ==;31:Gyk1UTaojHnNjALU36kPCX3+J81T7a35dzZPE6DldoMlTMIvSB7kUUnW1kP53BeWpF3RGFhZkCMzs2C041wkKFf18/Mo6gLvHowhZO9tWQWvOWcY4Zzk2tyPxSp+6H9ToBJE6K2vkLMhoxmOqLTAnQJO302LcfnqXmHJ4gCpcg9Czxv/sIvCUmOa/YvFX8ZzdwxrlNneiV8x/u1AK8/bsaWQ/BEzYlbEef2+Oj4c1hg=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0172:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0172;20:29i056s/bjIPRMUKsYvJtf4EJWhsqrPN24FP6K1up2lyLBgWvxtpeHgULoaPsCDynZzmJ6NBTf+wwbMVX71g0o4k1/aNKPYim+MD1NoWmT5UdLjxJMb19lR+oJozXReIMTj+fWPzjKAv0W9GBEljLqxPniqDuEOWOH84kg+YhxtPp07uuTRygCC7DAifYFfo9yZ+C2F45CZygLI0ltbUHiJiJvAhptB91Q5TYR29eWQwFdFkINInFsvfGGbmyqhHbNnUge9ABa4Z37jkI8wAmRcg8b5n8D2QlArkwXVC1kLsxJZyya0YYvO6JZf8nGpRaVIHwdOAcZxWQuK9sH+Ddg3Sv+ocmJjQIBfZEM0Ns08iq+4zBFHnkdIShYRBRKBwqGMR0HqnTlmF13S0fnWIvnKPQnvoqIiKI6MvUm4sjMFZZyNoFrN7jqZ8JL/hgsLubz1ctMdaAdXADdegxg60ESGz5tU/7gz9jIRfh7p4SNKqVVdYcbFlO4DD6e+6JsVa;4:rvD+A+MY69EIXTnCmYJEy2kMoA8kEYe5wmk9gXNj6C+iyx+99WcfDuU13lcZdPIKXcqOayS+K56oMtfaHinN3VItuF3X1h9FPqgFqeSfNCr6kCLgq/g4z7h0FVcbEcY3mRFCDlYVDH+jbJI+rqE2k68jZttaraQjxWvVmm1kQnCoL3EBovKJuLjZVDYoM4Gduc90nzbph38XxdQV04qvf/BLLrLH3iqiHg3ljUKB2ue9lQ4twylJPuQ2gDH+y6v1z0mfaFgnzCWNcnHhJkzq6g==
X-Microsoft-Antispam-PRVS: <DM2PR12MB0172F633140E150AF4745ACAEC770@DM2PR12MB0172.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM2PR12MB0172;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0172;
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(396003)(376002)(366004)(39860400002)(39380400002)(199004)(189003)(76176011)(476003)(52146003)(2906002)(106356001)(478600001)(6666003)(72206003)(50466002)(23676004)(2486003)(64126003)(26005)(186003)(77096007)(86362001)(16526019)(52116002)(386003)(53546011)(486006)(11346002)(5660300001)(16576012)(2616005)(956004)(446003)(65826007)(316002)(58126008)(230700001)(6246003)(81156014)(31696002)(53936002)(305945005)(8676002)(36756003)(81166006)(8936002)(31686004)(6486002)(4326008)(3846002)(6116002)(3260700006)(7736002)(25786009)(229853002)(68736007)(105586002)(97736004)(47776003)(66066001)(65806001)(65956001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0172;H:[10.236.64.67];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjEyTUIwMTcyOzIzOkNJeWI5T1lxOFlWOWVwOGtBUnR1bGRlTWU5?=
 =?utf-8?B?eUw1WW83bjlVQTRZREhjV2FySjRaTHhpTitOdHlsYmI0N3VIUUhKNWwya09B?=
 =?utf-8?B?aDdtVUJRQ2RHSkZENGJOWWd3bFRyMU1FWW9sa1NjdHBKNUhIYVppUnB4cVFa?=
 =?utf-8?B?R0hKQmVnaFdCeG1kS3BGWG1FWGJta1NkdWpyeGFCdnQwd2ZIQmZEYzA1UEV2?=
 =?utf-8?B?SzVyL2IvWnhIbm43N3RPNW9jNDhYSWU5Y0xZM0ZzSE0zV09lUk96UWxpQUZu?=
 =?utf-8?B?U3Z6dWNYcnBWa0daYlFXZEM0SkRYN1BJQ0pzTWl3NExvNmEyYWZ5Z1dEb2w5?=
 =?utf-8?B?dndPWFJnK3hwUnhjNmt0WS8xak9zWjJmVndxR3R1aHNBeDJqVGVIejlhQTA0?=
 =?utf-8?B?OGhWSmVOaFRxQjdFVWg0R05mTlo3V1pGaUlJeUhrTDI2MmN6dkczV2pCRVVh?=
 =?utf-8?B?NnFPeDRUWkpmQ0lTcTZub1hTVEFuRUdyWDZ2RzNRNHFHVm5lbGF5eFJTVU1O?=
 =?utf-8?B?bm81K1c3OENkNzJvZXVxNjQrVDJnYmZ0K01wWFBmRHlpQ1ZZN1U0ck03MkRs?=
 =?utf-8?B?SHNWdFUybHowSW5NRzFCdFNMVjU0YnhzemM4VTUvZ3NrWnNzeFJGblFSU0JL?=
 =?utf-8?B?MVpDV0pBUzV6ZTZVNTRLSFAzU1NZTWlWM1hocm5zaHVYb29KdkNlbDQ0cFVX?=
 =?utf-8?B?WVVzRkVXa1puczRna3ZYTnVWTGx0Z0E5d3o3NFlxVUlhK3dsT1VSdk03Wjhs?=
 =?utf-8?B?cmRnbHJvRGJCTEtDbUM0bm5tUzlzZWxvUHBDdWhWa2NkSi9aK3VpV3IyWHB5?=
 =?utf-8?B?RVJJYjh5NGdyYXorUEZoczN6Qk0vcXJLWWVrR2lqbVIvRlJFdDJ1cFFuY21R?=
 =?utf-8?B?bStoZ3kwRVBrMDlzbDF1QmtUZkgwcElqSnFPTXdNdjQ4U1FONlRJVHh3NWEx?=
 =?utf-8?B?ZXZLNzlwRlFrTEpneHhUMkZNS0F6bUxGRmhVME9hWU9vdzFBbFZONnFGNHQv?=
 =?utf-8?B?aEVseHRzS1VJTGtoL2pCNmduVXU0N2dvL0pNSER4VlJDeDRoS3pOcjhobVEz?=
 =?utf-8?B?aUtWeVMrQVpXZ2dmeGNaRHk3MW44Y3BSZnBCSUNwZlovNzVFa0JUblpuam9D?=
 =?utf-8?B?NnJzMzcwazg0OVQ4ZHNFb1BmaWgwdW5WQVBPYUVWTWczVmZ5eGRvQTFDbk9R?=
 =?utf-8?B?WERiV2x2RFRlMXBMWkduWExzOVI4eHZLZW4zRUJkM0NJWU5UMXJPTEFQYlJW?=
 =?utf-8?B?STFoZnlzMHFLanhuc0RXYzVNckNQL2NKRGpNaDY1NktjSXB6UUMrcWloT0x2?=
 =?utf-8?B?MmJXZ20weklCQ01UNFhscEI0TXNheUQ3YVNtMGJVTkxYVzFoNlhSR0ZZbTNx?=
 =?utf-8?B?QWVIV25ZdFJRTjF0a0FkYkhDbjBaa0d3RVY0THdGSm96UjJIcms5NDkzNDQy?=
 =?utf-8?B?cUEzTVNPelV3N1ZsK1JMQzJ2MnZrUmF1SG5NbS92aFBtNnBOZHRFRzR4UytO?=
 =?utf-8?B?OWFONDVWTWdweVpQWkF1VkY2U241ZEpOTHRONGgzS1IzMElNY2J4RGkrR0M3?=
 =?utf-8?B?WE9kbXhmUkpZZG10SlZjVkx5dkFHU0doQVRkY2g1N3B6R3YxcEEwSUlLTVQ0?=
 =?utf-8?B?MUtFRWQ4a29OMjZIODVBMWFrZGhFK21QMmZDZkJNZU1lQkdOOHo2bXRCd2xU?=
 =?utf-8?B?Z1lnaFJvY2pWZ3pZRWFPTU41VG9ndHd1UXJMcUlKaWRNWkgxUzV4eGhUWDNy?=
 =?utf-8?B?VUczcGJ5YzNpMTdHNkhBeHorbHdiTUkrUnMxR2RSYi9YelhzdDhYdnMxekJo?=
 =?utf-8?B?cDkva2Jac2paL2NZOWFKTEpTRzU2RDY0YnFtU3J3VkxOazZzZVgxL3k2azQ5?=
 =?utf-8?B?NzZNN1hFbGc0cTJKdVBLRnBvQ3ladHl4ODM2M3FTMXIxQ1hTT3BjMGFrOFlK?=
 =?utf-8?Q?xKohuKb51yQGv5ucXUUKaCIX8KsGiI=3D?=
X-Microsoft-Antispam-Message-Info: oLyepacOja4cW/iLMfah994W3TwTb/Iz3lOINhMedm0nTBmqCXbfEgF1U8NzyWDlatHTJDLsHEu5Obmkb2bOAmNhwwQ4wO+yqVDL6PVCg/5tQn7ICsvQmXfr0eoHgS6f2pN5A4k3Sv2DxkOTOUpMzJDOQOq6E9vpAOK19RL4r9epuCtEPUrRYQEnKspIlU7CVa5M4WoZJwrP7m+XaEYk9vYPecgHy8Pf5pke4W5mMSDPpu66csmpthCYm+Ay+yCDC6KWXrdTaLb7eFYqrFnnXU7UiAh5k6wUPUl+Xju1NYNygq0N0lrm9rkJ8D7s6WCMYQKInPf/6xLAcsvqTdA8Yw==
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0172;6:kxZ9hayhvYQmqF7CznJyhNtNz6hcvdXLzxZCwepm/Lhmoqmb3KTHy1sKEqakvHhyIFNajrZeY4dpiY0AQXHXrSp68CetybprjvVwP0Ueo/o9NbAuNOZL11Xf7lGsJj94PPgiiE54muLXFBbkRTnsEJv26jlO1ZIgFvfSUDYi8YeU1X/cVthXDsv18JhzZipxrOTWCH16hn/21zwNUyqZRYHVrrAefi7FQViPU3lmj/8fJzb2T6HV+sephTsESrgIWcR5WM65/b8bO8JV/7F13lZCy2xOzB+KHLxv/bgGb3rf4joJOaJbrw+ecC4Jd522eAj/D9OF7HujXhlsTCldk62tOlzlPPQrP3+1l6xIjGTjuHzyioJRg1UNSexU4eAANh2MAeEcjGfgPXW2XiMIxhFLPz6LnqDw9lZRpGPSXxkpCzfUyz9ZXbwht2zVzxYUlw53G2wUS8Ux/vAPiTXzGA==;5:EPpbpV+633egszouUDiOlzgsLAN1JHnLUL7d5iXZPFJAb2JZEBQY+FoWYnzGVljxImhpyLGYua2DTHShk+LkloLTTYJO4ffIVwYS7Whbk+6Cs8XpkOtV4XN6Hi1fGAtxwn+NLHMCOQubXlzODf9syMbOoHCiNZdBavtyi4quH9k=;24:wKIUNJgUON9/lXTxQioZIjo8Egzry9wDDgWTQvzW3Pjy/uV1zj73jnTVKonCDjaZgXUPvnC/Uh/jpOIAjw23AE5ck2zSy45wpF9u93tshLs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0172;7:KSq31u7ifWe1r+cGK+eM1iekPW5V4OHBDYayXK7SLKp9HoAsmXrD5f6i1t/8yjIBaccwcFD6bcv6cLuM5fu/H3Xa5okTdZUqqeQYBJWQo/DcnIXpu2Ye4i7eeIUpmukVV8wRODDyN0S7EK8TEvaEG3qzF11mPQY/MvvEdt0qjm918n+yAB8phmAAHjZKkqB9YUEZQ+XU93h4gXMbSMsiT9UVLNjIs2L2OD9hTUNnwAyXrjd5fXH8fzhMv85gYPvp;20:lVgRbx+LwNGR90gnPsdHTnLNUbejcoA6eqGGTBE1oFFLsWh1U+z3B5gOtJ+10RAZRcVY0SATIrTjnyWyDhjcqFeBpY1569JgKPmMISsyzAzJsXMP584TjBMkhEX86dOcUqWK8PrPlq+5gS5rSQH/eCr71eBr+72A/a1LWqN/+jvkF5+1YmwdYONoQY+fnzn0Rv0I1fQTpfCBtRYG8JQLOu18eLheX+lwil6Tji1gVM0QbBxIi/vihpKmDbUdWy+I
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 16:00:56.2421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79439658-f17d-4e9a-842f-08d5d6c70239
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/2018 3:27 AM, Lianbo Jiang wrote:
> It is convenient to remap the old memory encrypted to the second
> kernel by calling ioremap_encrypted().
> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
> Some changes:
> 1. remove the sme_active() check in __ioremap_caller().
> 2. put some logic into the early_memremap_pgprot_adjust() for
> early memremap.
> 
>  arch/x86/include/asm/io.h |  3 +++
>  arch/x86/mm/ioremap.c     | 28 ++++++++++++++++++++--------
>  2 files changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
> index f6e5b93..989d60b 100644
> --- a/arch/x86/include/asm/io.h
> +++ b/arch/x86/include/asm/io.h
> @@ -192,6 +192,9 @@ extern void __iomem *ioremap_cache(resource_size_t offset, unsigned long size);
>  #define ioremap_cache ioremap_cache
>  extern void __iomem *ioremap_prot(resource_size_t offset, unsigned long size, unsigned long prot_val);
>  #define ioremap_prot ioremap_prot
> +extern void __iomem *ioremap_encrypted(resource_size_t phys_addr,
> +					unsigned long size);
> +#define ioremap_encrypted ioremap_encrypted
>  
>  /**
>   * ioremap     -   map bus memory into CPU space
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index c63a545..e365fc4 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -24,6 +24,7 @@
>  #include <asm/pgalloc.h>
>  #include <asm/pat.h>
>  #include <asm/setup.h>
> +#include <linux/crash_dump.h>
>  
>  #include "physaddr.h"
>  
> @@ -131,7 +132,8 @@ static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
>   * caller shouldn't need to know that small detail.
>   */
>  static void __iomem *__ioremap_caller(resource_size_t phys_addr,
> -		unsigned long size, enum page_cache_mode pcm, void *caller)
> +		unsigned long size, enum page_cache_mode pcm,
> +		void *caller, bool encrypted)
>  {
>  	unsigned long offset, vaddr;
>  	resource_size_t last_addr;
> @@ -199,7 +201,7 @@ static void __iomem *__ioremap_caller(resource_size_t phys_addr,
>  	 * resulting mapping.
>  	 */
>  	prot = PAGE_KERNEL_IO;
> -	if (sev_active() && mem_flags.desc_other)
> +	if ((sev_active() && mem_flags.desc_other) || encrypted)
>  		prot = pgprot_encrypted(prot);
>  
>  	switch (pcm) {
> @@ -291,7 +293,7 @@ void __iomem *ioremap_nocache(resource_size_t phys_addr, unsigned long size)
>  	enum page_cache_mode pcm = _PAGE_CACHE_MODE_UC_MINUS;
>  
>  	return __ioremap_caller(phys_addr, size, pcm,
> -				__builtin_return_address(0));
> +				__builtin_return_address(0), false);
>  }
>  EXPORT_SYMBOL(ioremap_nocache);
>  
> @@ -324,7 +326,7 @@ void __iomem *ioremap_uc(resource_size_t phys_addr, unsigned long size)
>  	enum page_cache_mode pcm = _PAGE_CACHE_MODE_UC;
>  
>  	return __ioremap_caller(phys_addr, size, pcm,
> -				__builtin_return_address(0));
> +				__builtin_return_address(0), false);
>  }
>  EXPORT_SYMBOL_GPL(ioremap_uc);
>  
> @@ -341,7 +343,7 @@ EXPORT_SYMBOL_GPL(ioremap_uc);
>  void __iomem *ioremap_wc(resource_size_t phys_addr, unsigned long size)
>  {
>  	return __ioremap_caller(phys_addr, size, _PAGE_CACHE_MODE_WC,
> -					__builtin_return_address(0));
> +					__builtin_return_address(0), false);
>  }
>  EXPORT_SYMBOL(ioremap_wc);
>  
> @@ -358,14 +360,21 @@ EXPORT_SYMBOL(ioremap_wc);
>  void __iomem *ioremap_wt(resource_size_t phys_addr, unsigned long size)
>  {
>  	return __ioremap_caller(phys_addr, size, _PAGE_CACHE_MODE_WT,
> -					__builtin_return_address(0));
> +					__builtin_return_address(0), false);
>  }
>  EXPORT_SYMBOL(ioremap_wt);
>  
> +void __iomem *ioremap_encrypted(resource_size_t phys_addr, unsigned long size)
> +{
> +	return __ioremap_caller(phys_addr, size, _PAGE_CACHE_MODE_WB,
> +				__builtin_return_address(0), true);
> +}
> +EXPORT_SYMBOL(ioremap_encrypted);
> +
>  void __iomem *ioremap_cache(resource_size_t phys_addr, unsigned long size)
>  {
>  	return __ioremap_caller(phys_addr, size, _PAGE_CACHE_MODE_WB,
> -				__builtin_return_address(0));
> +				__builtin_return_address(0), false);
>  }
>  EXPORT_SYMBOL(ioremap_cache);
>  
> @@ -374,7 +383,7 @@ void __iomem *ioremap_prot(resource_size_t phys_addr, unsigned long size,
>  {
>  	return __ioremap_caller(phys_addr, size,
>  				pgprot2cachemode(__pgprot(prot_val)),
> -				__builtin_return_address(0));
> +				__builtin_return_address(0), false);
>  }
>  EXPORT_SYMBOL(ioremap_prot);
>  
> @@ -688,6 +697,9 @@ pgprot_t __init early_memremap_pgprot_adjust(resource_size_t phys_addr,
>  	if (encrypted_prot && memremap_should_map_decrypted(phys_addr, size))
>  		encrypted_prot = false;
>  
> +	if (sme_active() && is_kdump_kernel())
> +		encrypted_prot = false;
> +

This change doesn't seem to go with the patch description.  Maybe it
should be a separate patch?  Or provide more detail in the description
for this change.

What is this change addressing?  What early_memremap() calls were failing
that required this?  If this truly is required, you can probably move it
up into the "if (sme_active())" block a few lines higher in the function.

Thanks,
Tom

>  	return encrypted_prot ? pgprot_encrypted(prot)
>  			      : pgprot_decrypted(prot);
>  }
> 
