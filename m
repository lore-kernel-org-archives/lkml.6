Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 67E75C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09693208D9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="ZLpJF8b8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09693208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=epam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754627AbeFNFlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 01:41:23 -0400
Received: from mail-he1eur01on0042.outbound.protection.outlook.com ([104.47.0.42]:62432
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754589AbeFNFlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 01:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlwJMhVn1xOKnTX4uyBaABlOHjXEOdr89ymGd1hBRus=;
 b=ZLpJF8b8TovZTj3tV3SJVTrimTEYWWk4QuPJPqs5gzY21jivKGlNoP6lFR7MGsIdMk9wJKY2B4FvHjFhj/bI5Ofs2SwR2+/+oPiLK7FBYyL90B2lUZxkyX0LiVm2qF7vLiNm2g47pEkefgwFLD5xhNYV1sdybZkewM3oJ2TAWjo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
Received: from [10.17.182.9] (85.223.209.53) by
 VI1PR0302MB3216.eurprd03.prod.outlook.com (2603:10a6:803:18::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.16; Thu, 14 Jun
 2018 05:41:14 +0000
Subject: Re: [PATCH v3 8/9] xen/gntdev: Implement dma-buf export functionality
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc:     daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com
References: <20180612134200.17456-1-andr2000@gmail.com>
 <20180612134200.17456-9-andr2000@gmail.com>
 <bd5adb0e-af98-528f-d6f9-9d5888ff2412@oracle.com>
 <5c50f951-47db-782d-1ac2-162892f7ec91@epam.com>
 <35fb3f9b-2817-f284-6318-588a72c71f98@oracle.com>
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <9f006537-e57f-67b3-e9a1-7897fa3beee2@epam.com>
Date:   Thu, 14 Jun 2018 08:41:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <35fb3f9b-2817-f284-6318-588a72c71f98@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [85.223.209.53]
X-ClientProxiedBy: AM6PR0202CA0036.eurprd02.prod.outlook.com
 (2603:10a6:209:15::49) To VI1PR0302MB3216.eurprd03.prod.outlook.com
 (2603:10a6:803:18::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61d7017c-448d-4734-aaa1-08d5d1b97226
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0302MB3216;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3216;3:2VudQSkwyLOcwux70lrUgd0bFiD0rgBIP1KmiiNK/TCpbnD3k6nveK/uFeNl32keE0/xhdFgL9sIz+Km4QcDujSYANcTr8+hkUtAzJNV/owKSAA9N8ARjnMShZ0xkmD6Bw/tuFDVNnpY9DWUIZBr5UdWg5BS7VnfU+k62IATh2Uf/I2/w8akq96il9/1qT69+M+bFYwvfLmdYv78ZT4ErTqCJ0qfpfiK4GTIMEs6KCMfk7gGT0xb6b/k6mMrUIM9;25:TjepjBqxLU5kDqPiRpS7+92AwqwL69oMo3wrkMASQPZH4cUagGQ0LZcahsT9VXBVBuPvb3PXJoP5fGPKOak1IIe5caTppEnfrgIw35R1PYt3eQXthfiIo2C4uVce+rOPuJIq0mQgw3N5PPTxk2qu8vW/Z/LlqKL55Ve93KIu174D0IAALpfZy0pi0PWb7qwYKXGbA8Q8nzGtybAlKwVbDC6MGEgpEbvI1pdCTiqBwzzkNvUjpGYucsalbfBO0PhUSSZXA1qQbZIMjDpYC30ZE4FmtpicfkRl1hRuJSyZg9iy+ETPjH/3OYQ0C42FlYeEGmm8Ek310bGzj8gVCNa0nw==;31:fOhSg9wwbHtBtkW2AhynCCmSAZe6wLKad0PoTFC9jNfRebQcgWfl3Q6VuxmA+LSrfmY71xK0nOuPMzhD0mxFO24I3iO4Kv6MNTiRdjy7n0sbtZUDxNqQte6/niyFgsIGpPpNt0mhe09qn56dgm6C3JrKS6IaALL8UQxwhoCUPsdmXRK7tqCZ+gTt11xK9q3QwVIkaqoQ7jhM6IS5mA/hosN0pwlxw6WScBU/5d4/AlQ=
X-MS-TrafficTypeDiagnostic: VI1PR0302MB3216:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3216;20:tU9gWxZZSBCZ+N8AxmMp1ylRu/KawPdc69AKSKvIUWffG6qoYBCdRvFfRktLCrR6tADzQ43nlNoAtQlF6Cfz8eEIWdY1Y38yVD483VUd1Z/xxtzbx0b093K+RNqOaHdQFD5FQHp1+k32ATQ4OPhZ5b6QmBduW0pp2E0kLFUvGHrAMsHIgLFkXjnI+3HpMVkKJh1Y4E8Af7DkoNFtOxjOv4F7OZ6L1eP6k0QedruOKzIO4yOhlKaNT+ls7Ld2pd5DrV0v75Uw2gqBgewoOHaPBkJeWuVj+8QjN7X1B5v9iwyA/1xOXdQteMtmHQ3ShqWkjjF0CIJ9UeUviCup4tRYgx8iyljAYASmMH4nLlX2+lf/p7cN3oPbOSB6kAyIWSaOpiur5cO+lgUdb/9UAygj7Keu6hVjUFMu0K+mVhlxp5y4HYQ9OROLizIgMcfaZjbE2Z1G+6L+mkoF68VCLOuDzJyQ+7VJkeUo80GzlRL9m/okvBQ+sLe0rTg4+LPaUEEk;4:SwDawhKqttHhk1RNV4/BSp+NYLvQXWn/g7nN++7pGojaFsMNRCYRU60GLZvwOYqexhwcbTEKRAv1Yd1OO0yZ+/obnSDYlzvdmRgQYJB7dsxrfDh5LMXGgJyVH0TzlIqGPXxfLQOEhuk43e3+ZOXG6zrQP2VlRkr/l2C11PUZ3YujKnJVRpcT54btRK8QIEiS+6+do0Yq4QZ9uQhiCjnkN4ujVHsuT+3t9U/JpRUXX6tyA4zw16NtTyYipIAW1fL04C/GvT5AUwMLwB9Dn4PFfA==
X-Microsoft-Antispam-PRVS: <VI1PR0302MB3216568A801F8FA6852C98E5E77D0@VI1PR0302MB3216.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0302MB3216;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0302MB3216;
X-Forefront-PRVS: 0703B549E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(346002)(39380400002)(396003)(366004)(39860400002)(189003)(199004)(4326008)(72206003)(106356001)(110136005)(64126003)(80792005)(386003)(50466002)(316002)(58126008)(2486003)(478600001)(52146003)(23676004)(446003)(97736004)(16576012)(52116002)(229853002)(6486002)(55236004)(956004)(25786009)(105586002)(39060400002)(6666003)(2616005)(68736007)(76176011)(6246003)(65826007)(16526019)(53936002)(3846002)(26005)(6116002)(77096007)(2870700001)(86362001)(47776003)(36756003)(186003)(5660300001)(67846002)(59450400001)(305945005)(93886005)(7736002)(31686004)(65956001)(476003)(11346002)(8936002)(53546011)(81166006)(81156014)(8676002)(66066001)(65806001)(31696002)(486006)(7416002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0302MB3216;H:[10.17.182.9];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAzMDJNQjMyMTY7MjM6MWpiTGpjRHJPNEdJeklSMWNTZk1LQkNW?=
 =?utf-8?B?NzdSN0xqaTVhQkZxNVlmVW0yU2dLOEpTOVJKS1A0VGV0cCtpbVNLeXZlQmFw?=
 =?utf-8?B?M29Mai9xNkQzaVZxU09hcFlmRmNVZUFrUHlQbkM4UzZjUnI2alpuNTdzVmIr?=
 =?utf-8?B?VFBOSTJiVHVIa0VoU0Z4UkdTejBPanJBNTZkWktFbW5oNW9sWjRPMFVhc3pH?=
 =?utf-8?B?SUZnNFo0a0lmSDlwWXZOd0xMTGhCeFFGSFMrcEFSTmt0RU96cFRkVTJkK054?=
 =?utf-8?B?V0dkRU84aTJ2NmpscjZKcmlSUndUdTBzMHJnVjZBaGJiaWpPME9aR2k2dW0w?=
 =?utf-8?B?bVUxaVphSVdsblo4YXdiL1hwdXhNOFVObXRmaWl6SWdIU2pGWGlkTG5qOU9D?=
 =?utf-8?B?emx6bGNCUFMxYll2MEV2Z1hvaklCOEo2dXRmOFZtZmJqTnZKcUtOR0ZmWEc2?=
 =?utf-8?B?MDBmSnR1c0hCMDNQeXJ4N3liM3BKSTJGREF0TkZmYXpyNHY5RVNSQ1hjWEtl?=
 =?utf-8?B?ajNuVWV2RjZTRzJjbEt0THQyOEhhd2pGaVdYSGN4WFhaZWhUMUNXanprb2lV?=
 =?utf-8?B?Z0M4UlFYbmlZVXVLM1JLK1JOSVpQV09Mb2ZhQXczVlcvSkRmd0JSV2pUNTQw?=
 =?utf-8?B?QjJDYVpFY1U5SGZkWWY2aWlMRFlmVjhYTHJFVXZBWmNmdjZ4T0FSZ0JtUWcv?=
 =?utf-8?B?aVBtbmc2Q290enpTakVFbWIxVHVvTUZOK2Noc0R3NXd3N0pQTFk1K2FzR05V?=
 =?utf-8?B?RTdjOG9taVQvRXoyVnQ2RE54UUZIemJSdkdTWHdZamF1RUJTNDBBT3UvSGh2?=
 =?utf-8?B?WDdHSFh1S05Kd0ltODFUYkRvcHdqdExqL1pRdnJRWENDbGdSZDlYb1JwSEtU?=
 =?utf-8?B?TjEveUNsaTdjQ0RIQ21RbGp0bTNNMmE4Z0ljckNXYmxxTk5CSE54dFRVaGxE?=
 =?utf-8?B?ZVRoVTJMSFh3UHljT0F6SXRZbnpncTJYVXpsQ2dVdVFXMThTK1lFUUE4TVgz?=
 =?utf-8?B?STVhcXVsSHBYa0Zua3gwMnRtc1ZBMG1iMUVoNGhsbUJBbDhSRlNzdUxNWEYy?=
 =?utf-8?B?eC91Nit0a0pPeVVJa1dITERQcWdHNVZ2bVI2N3FRMHg3R3R5UVF6UVlRc2VN?=
 =?utf-8?B?Y1V2KzArUmpLMkpKVjI1RGQ4V2pRMml5TURUZE15d0ZBa0V3VThka2tLY0V6?=
 =?utf-8?B?eUtSZnVpUjFVeHhLOHBUSnl6b2JyWXNYYjluN254QTJReHA2UXJKYWxJcmhu?=
 =?utf-8?B?WDgwSnNGeHZJOWcrNWNHY0Qvd0NMWUFJVHpXeEM4eVdTb3JjaUtsSTloZDkr?=
 =?utf-8?B?RUFKY2tBU0MxS2E0Rm5oVnF3N2Y4NEQrWHFiUUwxRzVxYnVMVmVTelA2MUZB?=
 =?utf-8?B?VXNsRVlpYlE5ZnF2dEtZY21pRTJHTFllbjVTZzI0RXE0YStmWGl3SHRxWFlU?=
 =?utf-8?B?QUdsRDBHcTlnd1dmZFQxcmpPc1JrMWc0YklManFidEhicGkrZ1gxRW5yYWtJ?=
 =?utf-8?B?RTU4aU1nVVBoTGprK1pQZTVVelM4Z0FHVldGK0RoOXYzek4wMmRlOEFPNEJl?=
 =?utf-8?B?Y2hWRmlHVkNibnd4OFp4TVpicFV1L21hWXNRbzF3dWFMMGRKQnphcXVDRGRO?=
 =?utf-8?B?MVN2aHB0cWd0T3F0USs2YlRQbDlOaURSa3lEaU83ODF1YmNiaEU3R3pRSzJl?=
 =?utf-8?B?eHdkMElNU3NZbkU2MGl0OFNmaUJDR3NDMUplL244eGc5UU9DK0VaSlVuV092?=
 =?utf-8?B?Wk8rQndIcGdxcnNmZlczcjhZeHNhSENKbnZxb2NoU3U5UDVVM1BhbDJLU3Fu?=
 =?utf-8?B?TFlNbXpuYVRUUDRsRk1Pa0t0S2swT28xT2tMUVFad3JyWDFabFBvRTZLUHFo?=
 =?utf-8?B?bnNLTDlIVksyQitJQW5NMG1yT2JYcW1KdUJ0VnZLWnkwNVhiejMyWEczREY2?=
 =?utf-8?B?YWVGcjJ3NG5LUHFuZlRScXpvMWpwUXZqbm5ZSWkwSXQzNlk3c1JLODBiSWZ3?=
 =?utf-8?B?UElnZWlEQXpMRzVidjdTc0tFTmdpaVkrbm1ORm1KbjVuWUlQaHlDTy9yRUZB?=
 =?utf-8?B?VXd2ZmFCSWN1MHlrY3ZHTTc1bkYzTFBvZ1RvT2xGM244L1JDWEpXUlhSQWcv?=
 =?utf-8?Q?raj6Cx/DgFkUNNoyuJJaPR5RWFMWPYsZaknIMEw/kEV1y9?=
X-Microsoft-Antispam-Message-Info: BzpkJ0e3uYlwlb0rw6WMedKOxYGP8Xq6rjsEj6Uy9H6wpiqpb8m/x299X3QQFQP9yD+c8kPaQXfhhwWhaYa0/9Wekr9gfCPQXGX+kY0710417jXMhnJojExl7bmrykiPkxbemj5R6bNFX4ifMa8Dxd4nmVPy+uZIrcaVlm4iNI6O3WJT6ev+UD4UUyRQotC8
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3216;6:pYsApCFE2TOqcPHuJy0SYDkq1FZVwov0v5taP57O2PmlZ+XxAmTtsXB6qSu/AUzekb9cwXkVdYAaitnz12itzFp2dW0RMTSfNchF1ZEjCkRT1MKcQz6F9zPg90XHH09irRdcvFlDmkaWLkpHL9TFAZw8N5l8xCPTJGuCfMPTA4bE5fzm7iEiO4umU4f3BD49vjYUD9s4kjs38Nd6n1IUQo6GUMeiKPwklbKmLurLI+/cIFndTB5Quh3FKcLlC9AZ49wiUDKhXsxHcoPKAOELI2oNBm+lerASru5L9mTGKj/+p9eQdLkElzxsfq6ZeB2n8eIudzwRmZbLQevdndTXbVNkJEO0QcQBHJqfLAsUocxuoj0/s8eFJTkpePLipfXww62GcDBMr1IJXqBIgQsrQ//qS7PqyXdXpbigLHAhUbQncUEYRfWYaaeuKrGN1yDWgcmKtCnKkWc6Lvrbh5MDXg==;5:VHsRzLbgqOIlxhbHrhetfygtRrc+/+Uurf4dFSVGtk9rJuAKuhDpUKhFGg3Yvu/LHx07a8MAxh4k2gauVL/5TkjT7S6oS1++o16KlXZVTYP485CyPcgVZmgRvd4UfgwRvEvkPohF1BSnWWboolY+BJOqhZ8F+pUuXKU2x/Wbxcs=;24:CaI0gpdvtsKxnajlTMJ0OP/vjFyLOEERPK4hE7FomTtXsM0Vm2nQhUSlrvFTMpDu9XIqdQTlnb35wN5Pe/bpUDdApGP8Cy8wEVlLP4oRu28=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3216;7:Tbsq0g7iLAiWXYHvOqSIZf1kF4t+BukZ6lRLfhl3m7IU9o50vpNqOguPwHni4FU/N47bU462MOxeeQzTd+ivigHs+xVP6KVL2Qph89RGz6N5RKW/sXGEUVsY6JJa4TWHwRYU+6lbYnoUZXKnKqEVtMVepb3MioXVLFd9J7KHuJELLYE+D1d/06eCXksyG8Tpv92hgHsYrygyiYohKR1juP7Lj4RLE99i0I/Gb5CQm6WMgEnyxo5MD+wGUk7V18u0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 05:41:14.7738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d7017c-448d-4734-aaa1-08d5d1b97226
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0302MB3216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/14/2018 01:19 AM, Boris Ostrovsky wrote:
> On 06/13/2018 07:57 AM, Oleksandr Andrushchenko wrote:
>> On 06/13/2018 05:58 AM, Boris Ostrovsky wrote:
>>>
>>> On 06/12/2018 09:41 AM, Oleksandr Andrushchenko wrote:
>>>> +
>>>> +static struct gntdev_dmabuf *
>>>> +dmabuf_exp_wait_obj_get_by_fd(struct gntdev_dmabuf_priv *priv, int fd)
>>>
>>> The name of this routine implies (to me) that we are getting a wait
>>> object but IIUIC we are getting a gntdev_dmabuf that we are going to
>>> later associate with a wait object.
>>>
>> How about dmabuf_exp_wait_obj_get_dmabuf_by_fd?
>> I would like to keep function prefixes, e.g. dmabuf_exp_wait_obj_
>> just to show to which functionality a routine belongs.
>
> That's too long IMO. If you really want to keep the prefix then let's
> keep this the way it is. Maybe it's just me who read it that way.
I'll rename it to dmabuf_exp_wait_obj_get_dmabuf.
As it already wants fd it seems to be clear that
the lookup will be based on it.
>
>>>>    +#ifdef CONFIG_XEN_GNTDEV_DMABUF
>>>> +void gntdev_remove_map(struct gntdev_priv *priv, struct
>>>> gntdev_grant_map *map)
>>>> +{
>>>> +    mutex_lock(&priv->lock);
>>>> +    list_del(&map->next);
>>>> +    gntdev_put_map(NULL /* already removed */, map);
>>>
>>> Why not pass call gntdev_put_map(priv, map) and then not have this
>>> routine at all?
>>>
>> Well, I wish I could, but the main difference when calling
>> gntdev_put_map(priv, map)
>> with priv != NULL and my code is that:
>>
>> void gntdev_put_map(struct gntdev_priv *priv, struct gntdev_grant_map
>> *map)
>> {
>>      [...]
>>      if (populate_freeable_maps && priv) {
>>      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>          mutex_lock(&priv->lock);
>>          list_del(&map->next);
>>          mutex_unlock(&priv->lock);
>>      }
>>      [...]
>> }
>>
>> and
>>
>> #define populate_freeable_maps use_ptemod
>>                                 ^^^^^^^^^^
>> which means the map will never be removed from the list in my case
>> because use_ptemod == false for dma-buf.
>> This is why I do that by hand, e.g. remove the item from the list
>> and then pass NULL for priv.
>>
>> Also, I will remove gntdev_remove_map as I can now access
>> priv->lock and gntdev_put_map directly form gntdev-dmabuf.c
>
> Yes, that's a good idea.
>
>>> I really dislike the fact that we are taking a lock here that
>>> gntdev_put_map() takes as well, although not with NULL argument. (And
>>> yes, I see that gntdev_release() does it too.)
>>>
>> This can be re-factored later I guess?
> OK.
>
> -boris
>

