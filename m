Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3187CC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C674724B7F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qv0StMJ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C674724B7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753334AbeGCM5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 08:57:03 -0400
Received: from mail-bl2nam02on0046.outbound.protection.outlook.com ([104.47.38.46]:2019
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752494AbeGCM5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 08:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxDXi/kwB6tU54JwSXj5SWV6HnlX6CpMvoKe+KXi2BE=;
 b=qv0StMJ7ChgDlLWFHtaloHxP/13PiDnSyE3TSralDg+kbzyi5j9I5HQw1fx5vkbZeH1M8+JmTXH/Dw55HsrtfNbYy7LW9pDSY+DjQ8NNcfCjOKewABNbrx35TuiaKk/iWNRrI3dS7QmwFhNrr7A0S7QkOgOyxrS4sPnwMQxm8Gk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com; 
Received: from [10.236.109.62] (165.204.78.1) by
 DM5PR12MB1450.namprd12.prod.outlook.com (2603:10b6:4:d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.26; Tue, 3 Jul 2018 12:56:57 +0000
Subject: Re: [PATCH] iommu/amd: fix missing tag from dev_err message
To:     Joe Perches <joe@perches.com>,
        Colin King <colin.king@canonical.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180703064005.18908-1-colin.king@canonical.com>
 <6763ec382f8d629f5f356f4cc023f20c2f76b26a.camel@perches.com>
From:   Gary R Hook <ghook@amd.com>
Message-ID: <d27fe634-89cf-7d9a-3e3d-a2baafabf0be@amd.com>
Date:   Tue, 3 Jul 2018 07:56:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <6763ec382f8d629f5f356f4cc023f20c2f76b26a.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR1701CA0018.namprd17.prod.outlook.com
 (2603:10b6:301:14::28) To DM5PR12MB1450.namprd12.prod.outlook.com
 (2603:10b6:4:d::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26530476-f92a-4afb-448f-08d5e0e4766a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1450;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1450;3:2Jl2EydZ5I4iNn6RYAruQNZpRyCxS79J/oxvlqVjsP2jSIaTlQH5Fe6TnJLM4oxayGr54gn3lqtbAKlPdu8TtEyDZpb0IWNSEluqTtZkUhKNHPrYfeM46h+D44eSL7T/zrvN+z43EXd6eU2RIrSQzqUjHFVX/0owJQJj/A7ePDJGc38k7GFL1gwAS2W0YXxzRm58yJtEfSyRY7w7nCVb/rENExuPu8tJVZifUigsKm+FyER+nUrXCr740O+D5c7Y;25:zcXUMBJEoNey4mmayeC1oNvxBcQcY8z6Ocf9qL1/PxiUqPJrfzTKUGGirFfFUvz4IY4HyflIdLam/cfmaZDfHglpMg5OAeGmoNWHFJwvsWLhG3JXoWnL40XfHNbnwJDc54pouIdyYMhuEyZvNdfuecp8lOO8t0a8CZqRd3GhIBHy4oPdDZVH8afI8BmykWLVMbHOdsbuN36KskLOJMdEDOTKr3uLj0yegAz1Nb8KMoPWgxcvgPIT5/MoqoI+ZZUzwbWEQnIL2TMALFvDZtM31irA6DMfgwuHmvDkzbSWafRKF6rasz3pbn6EoltHREvs5eO59tDBgEaYJsk1N1NLYg==;31:oHdBsxugEm9aF94V7J/ndFkY/wo4G9bqCV/sGkvgsH69C4cwdI7OqIhKvwDhP2pahQjcBotefNsXr3Rnqi/qsDWYbgpvVAklf7itTwLWgpwWhJmyeZGpqSz6SN4Ths5hEh/o82JQ9n6uJgi7CpmxclvjiGoAY1198i/YrAIydiF2tgq+K92IE+2pwQo9lrlPJf+p9VAkpSzGqCNCyZkrzEW8XuZO2MaSQEDpcoYy4BQ=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1450:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1450;20:gO3eirDNyyPrYI1IO6nZ2XnbsjLka00WYP2uFsKdZJg+JCm8jXiU/kElMlBMQXB4Qsg6NjhmedplNNHIs5x5VEq5Ubon5o5OOQdO0uEanw9HZoKaDFsG9wZPBvajR5e5ZngVVdGk2l5GGtyktWNU2Wt5SwFSkR0zeBMTSr1+nboLsMw2MFFYSYJ+XDxxazZf+YwTBVODMgLITQ/l4UUa1c7AH1L72DH1lV8xKx9VUm1UMemjVlcp6N32jRN4KQlikUcfIp1wH3ElyVd9PB3HY3e9RxqJEDxwmPIbcuiRGJYGoHeY8eaJZEH1b1o+VCpio8kp+pDsmQokV0pJZpfWWvWneHARJ5HcGsm7HYlR4ucOZHdSGONqtTEHHw9zWC31sq+7mQVgjLs50OH9yCMVBrzNk31HSmHoR2DHnqwTJ7/DtpxNBLXDFhhS+yWTIcjbbUTEQgUoACM8vlagEp3CWBje7t9YZgt6nC7SRkzspUF67uLEGkRo2bKbxoVdOJMI;4:dVmtGJzLRHN81Gp9eV31fjq6K0/z0yjVlDUk5p0ZXF2yzqqyr7sAk0gDNJ9WAvdEYa7ufLexJnnV16BKIbLaSFa4LKOvaEF41mgV6xOEvaYpAw1NLl0B5uP7fFTaGCkl1vPJKwG9QTt4ozxJIRtsvKXr0uK5idPjVkMDKeXbvRS8yoDDm5+2q1p4rCYzarIKpwf0yM7tYuO91udn8OjLIge+3EDHjQaqTKo9quTGbxb4BQGX1qtXnGZYawCgE+hFYQEVdPW0r815NSAa7gJ0iQ==
X-Microsoft-Antispam-PRVS: <DM5PR12MB1450108387C26B7CBE9E98ADFD420@DM5PR12MB1450.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DM5PR12MB1450;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1450;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(136003)(366004)(346002)(39860400002)(376002)(199004)(189003)(106356001)(25786009)(186003)(105586002)(31696002)(36756003)(65806001)(65956001)(6116002)(3846002)(66066001)(97736004)(11346002)(446003)(486006)(230700001)(47776003)(476003)(2616005)(956004)(50466002)(386003)(2906002)(15650500001)(53546011)(229853002)(6486002)(16526019)(23676004)(52146003)(72206003)(52116002)(77096007)(2486003)(31686004)(76176011)(316002)(8676002)(16576012)(58126008)(81166006)(6666003)(81156014)(65826007)(26005)(4326008)(67846002)(64126003)(6246003)(8936002)(110136005)(478600001)(5660300001)(14444005)(305945005)(7736002)(53936002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1450;H:[10.236.109.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNDUwOzIzOkthdFRyZ1NjRDhQUi9OV00rMjU2N0lXemlD?=
 =?utf-8?B?WHhGWkFHVFBHd0t6QU96Vm5vcnJ1NmZOL1BlU0hrcWNGMm9XZWo4dXQ0OXpW?=
 =?utf-8?B?eXlqa2FZaWJaK3JmNEN6S2NUd2p2NVpDZXJZS2JmK1BqeTlDLzNHNUt0aHN2?=
 =?utf-8?B?QmhhNGowUGtFUTljcFVxMDdBd0FlbXk2dndtRGpDY2ZFZ0hPbDhjYUdlczgy?=
 =?utf-8?B?T0xsZVNFQ3JudU1Vb1pNcUF3R3EzVXBlSHFtYVkyYmlsK1VzRXkzdzZ2YlFn?=
 =?utf-8?B?THNISVZkVFhSSW05Sm5PbHZEclIzMk1ON0JoTGZiSDBiUzNYTWNxTHZaT0Fh?=
 =?utf-8?B?aFpmVFZVNUtnTEVlWFdxS2JsZ29ocFRUeXVnUS9rc0xKdGlWUVlKam5XQ2Fr?=
 =?utf-8?B?b0NuaHdwOVZUQjdPQitSQTU0RGtmNTRIYUVaVmlIT3JBam94L2dKb0U3TGtn?=
 =?utf-8?B?THV3NmM3cXlGb2crVEdsTnhXWS9rWFh0ZHhDOWEvYjJGUGlhaWdjQU5aWFNU?=
 =?utf-8?B?NE5OQ3dZVnFvdjJkN25uVGdMMnJyQ1lJTUY0OHNqR3l5UVdXbnpESE5QUkUz?=
 =?utf-8?B?RU5kWEhtTFRxY0JZZ1ArRmVWTW1UOFBLaXhlVjhWR1kyaVFSaS9WcFJlY2Vr?=
 =?utf-8?B?YU1xZmdNTElIaHJDKzNKVUYvYjJuMzN4V0U5VXl0S1FyQkNtVHBuT1E2MExE?=
 =?utf-8?B?VXhKa2lVMWw5OG9KcU9KcmVvR3NsMTMyKzVFMi9lUHZsM2tkR1VlUEd3OVJs?=
 =?utf-8?B?ZDVkRXNwUzdxbDFTTTdiMnNTTnZhV3JOR1JidDQzVk0xOHJQdUxIb2hDVHFz?=
 =?utf-8?B?REY5ZlYrWE0zWFh3ZVJlWThOR2hOSW5iMUNDRzZaRjNTeWZOdkVqeXg0WHRv?=
 =?utf-8?B?Ymx6N2lqN05YMTh4enBIMXExRkR5dWNQaUZMdEVicmpzQWZnZDloNzczb0t0?=
 =?utf-8?B?TmlESFZwd1g0MVBrWkViZTlBcWlkT3JMUTl1bTI1NVgvYkF5bWZONWszeUh6?=
 =?utf-8?B?Rm9hOHJZWlZmTXJ6SXJpWmU5OGpJVm9Va0lqOUl5WUl5YXNZTm5FTFRFZU5z?=
 =?utf-8?B?KzhCMVFxOUhIdnpNZ3RYQ1NFQmhodUZZSjdEZkdvZ2ZSUTNXd0hRWkhUb2x3?=
 =?utf-8?B?MFJ0aGlFQ1R0WVZSbnh6QUlsOWZMOW9kTmlJTVJyaGh3VTNmZlVrSFRPb3V2?=
 =?utf-8?B?ay9ZK2lkbWJaRjc3OHBkbEF4NnUxS1RsWTZ4Q3Q5U2dUb1RYQkRkWHhiY3p6?=
 =?utf-8?B?SXcvZDFXeEZYbjZaY2lBL3NCL3lzN3dueFMvaDVpckNTTjcxalV1bXdncUJq?=
 =?utf-8?B?cmd1bzFVcXBhRitZa1N3T20xcTNBSjhJZ2s5R0FFL1d3ZDBrUmVZSmczcHlz?=
 =?utf-8?B?YkVwZzdjOExPU3h2dnN0UU5IdGRXZzJRQnJwd3h6ZkFGSU5NUytITTZCMmIy?=
 =?utf-8?B?dmtqQmJLbnNWWVhNLzhPaEd2Q1kwalJRZHg0UWVGT3NuL0c3VUxrYm5zZ1la?=
 =?utf-8?B?ajgyTzFSdnJOU0hqbkRWU2k3Q09pcTljdmtaeG1ZMmt5UWpUNkE3S1NhVU1h?=
 =?utf-8?B?eEhKS2ljMjl4bXZHY2JoV3hITi9UdDBGNndYY3E1VVkwU1IzQXlVYm0wdGgy?=
 =?utf-8?B?dzlkR1prZHRYRGUwb0J2Mm9wQWxiMEl0Rm1EUDVkZHZ6eW41RTdvWUFLdDI4?=
 =?utf-8?B?SEV6WnoyREJUc2M5SjhVNURuams4a2lFSGttaFRSaTZBY3RiR3VUQVk1SkpS?=
 =?utf-8?B?VkpVeEpDcy8vMWJ5eHRBWURsbTZyQzlJN2NKNS9aOWJuc2huZEwzdFByMlVk?=
 =?utf-8?B?ZXJRZ29SbzllcDZaUENBTy9kb1BYZ1NReTRHZzk4TFFGRU5XcnFtcm5HaVdh?=
 =?utf-8?B?ZHdxcEhnQ2l5NXI2WkVwZE41eGozcmMyb1c4NVVCNFlKdllNaGNFUUkrOHI4?=
 =?utf-8?B?bjc2MW1ZS21yOFNMTWQzYmZIUGZJcHhweW42Um5iUVN3bEpyV25FV2lGVGpt?=
 =?utf-8?Q?aXfbHa?=
X-Microsoft-Antispam-Message-Info: /tDcxVNFOn5wqwCAq80KPMoBWNck6Rk8TfivNERH9cNFktRBSojdN5w7z560o0EJ8RyoKzkOWKRRvcZCG5oaVWIpdB0O+Svp8XG8MbxbhYVp1yhjht5dNbFQ6upLL6QrEeSJZWsQ4ZTgbQZVoUu4VDNDqnZhVQT2TnBhAfeQqLiYoHNuaGNfdSrt9PQeMCqn0bZiaeBVyzRjsSGWk7h4AXyNLYvToQ+OAsn6i5H8baNrYJvmglnx4JMTQH/7mv49NstHe9bGpcvWPVB8axs0sIT1nqigbZGYkNDmfgfQzYvPvTGL0kF6NjXF1yMQiAlTqqyrDGNZ+w3ur6r0PHl2VATZVzIpVIW8sb4iiwqxN5A=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1450;6:phd0s8krAl33DsvKDBB0l6i5c/FoubQ/FbC3BuEw06PsTGbd2imhokaePH8dd3irFkma+d+1AM9LLTepqGOaZnZ3x4TBSztYVmcddseSH4n9RXf4z5B9hXxjqMj3pHnRCQis42kZu0U7r016vU/l+ENzq6RfzwBatT4ou6c9nNOQxh04DWwi8M7gyG2nm4vFADpN8ITjSDtR3iuIw+aVHgTUR6ixGNK1B+SwFKXXf1iJM+sYH8mDype0HAgiCtHbs3olux58vufaNrF/TpaUlICAkDsPFdMv1+4FxkkpnEJs2+galmtDV/NJFT3yqNxwxLcRzLPK1hgffFfKo4/TY1HyXeN4rti+/WUaQexCISA1aLbxIdLTVRVfjzUNPSWTvYHNsx99KoL9u8gvsVC4o2Qcq9uTObmrw2XUZ4M4eUvlrIpAitk2B8Sg1A5Qb90K63VHodfTq6nAEONh7rYH3A==;5:dSW72vM0HpmjZis4HPCYhc2AopzxFYxKDCe75cstQZlhMND/9waDNptBQJzlgCwVGL+8pDK+8G6Hmjl27Capxnb2nOlrsG9Pj5E2kXc2dlKKwc+Jb57SU/SCvi7BV7Tek4Va0vHjymHz6vggGOeuFwc4l1hrhtfmadEYxK0duIM=;24:nTRhRsUr4wTVwXUYoy0a6bG7gLIvzaYBEXmCjUB2xr/4bF2yVePk/xbnC3SYqM1BSRmbhsD06BVQfOWZgMLzSkFUCqDbHI7kBtjwchO3bq0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1450;7:IxlgPm9po7dW18F4+Ic41+SiwxBeJvLp5tJewbIA20WtpG50uM/e4wqRgNkad1LX33uV2XXvvoDYGg/xTdhg6U5QLzeIPfyPipw7iITBxZKip4/0uyD7JA6sM9llwTUeiV85MlO6ZCCOy4kP6QvHN5UrFfpXsKOFHMzS2yfy3PXlBvPThlYnx+UxbgQ9wpkCRCclc4KcHaaM8yHesmWXC8xFOHvAfHkRs+xTCPFHiiUfF8x06laqeE3UJqBmOR70;20:tM72AVyhZRUwEw62VuKty2qCy+rFTUyYnUECEBmQq19DOH/OzyYTofhB2vEzEutUeGlk6PalDkGrxd1eOApqJ42z8JWQpHp3qLGUVoi9HLiPcDTz81nYOpTBMbyF2UHNPXIDYNaJyhbS5NtQEv1v4pBtVVmwyNMjM0nJVwNIUqFI5GZ4CNU/fbsU1uTm5Vg08NmUZ2nKW7FwdkX8rAzTA5djqfe5AzY2waz61L8fbIp6bMMPSjV/YN7iIQ0+mXyJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 12:56:57.8277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26530476-f92a-4afb-448f-08d5e0e4766a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1450
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2018 05:07 AM, Joe Perches wrote:
> On Tue, 2018-07-03 at 07:40 +0100, Colin King wrote:
>> Currently tag is being assigned but not used, it is missing from
>> the dev_err message, so add it in.
>>
>> Cleans up clang warning:
>> warning: variable 'tag' set but not used [-Wunused-but-set-variable]
> []
>> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> []
>> @@ -616,9 +616,9 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
>>   		pasid = ((event[0] >> 16) & 0xFFFF)
>>   			| ((event[1] << 6) & 0xF0000);
>>   		tag = event[1] & 0x03FF;
>> -		dev_err(dev, "INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
>> +		dev_err(dev, "INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x tag=0x%03x]\n",
>>   			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
>> -			pasid, address, flags);
>> +			pasid, address, flags, tag);
> 
> Seems to have a superfluous ] that should be removed.

Yeah, I pretty much messed up all of the log messages in that function. 
My apologies. I'll create a patch for that problem; it shouldn't be 
fixed here.

