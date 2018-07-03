Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5547C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87967249E1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="y8totlC/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87967249E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933973AbeGCQ1d (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:27:33 -0400
Received: from mail-by2nam01on0049.outbound.protection.outlook.com ([104.47.34.49]:52960
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932440AbeGCQ1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCspS0vKbB7CrfNPMtrE5u/wAKqgASm51Y9cxEmSTiI=;
 b=y8totlC/BVRXtRtlScUH8KJom17pTs5aerREdXsBZb+r1R+ttNUCRzT4gvwC7t3miu3/bKuaNIRFCOb6tBLIdO2S8RurJoLBgxNUa1euIJaAo2lxamy/oTI2WI4SfdTx48Kl1HknYDDwHqXvufvxStBM+nLiRuyRKoliaEJe0cg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com; 
Received: from [10.236.70.155] (165.204.78.1) by
 DM5PR12MB1449.namprd12.prod.outlook.com (2603:10b6:4:d::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.24; Tue, 3 Jul 2018 16:27:28 +0000
Subject: Re: [PATCH] iommu/amd: fix missing tag from dev_err message
To:     Colin Ian King <colin.king@canonical.com>,
        Joe Perches <joe@perches.com>, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180703064005.18908-1-colin.king@canonical.com>
 <6763ec382f8d629f5f356f4cc023f20c2f76b26a.camel@perches.com>
 <d27fe634-89cf-7d9a-3e3d-a2baafabf0be@amd.com>
 <d93bfa0f52d8907019b16336645986cd339ebf75.camel@perches.com>
 <f3e15437-68c1-58eb-bc34-93fa70e50dc9@amd.com>
 <6fbcf273-bc0a-5dbd-fa0e-a7f656c4ccbc@canonical.com>
From:   "Hook, Gary" <ghook@amd.com>
Message-ID: <dc5d5fc0-0c4b-3728-2dba-987840e7c1fc@amd.com>
Date:   Tue, 3 Jul 2018 11:27:25 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <6fbcf273-bc0a-5dbd-fa0e-a7f656c4ccbc@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: CY4PR18CA0056.namprd18.prod.outlook.com
 (2603:10b6:903:13f::18) To DM5PR12MB1449.namprd12.prod.outlook.com
 (2603:10b6:4:d::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd03d96e-1adf-4670-43ee-08d5e101def5
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1449;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1449;3:OFjSRhx+8YRRemf4gpf+PaYBQO8aJty2bq7vUHxMBtpq+AMc9DVugowa+8cyXPGGr+WAVNdpjxnVE19IsGj3KX0l0tOWmwBMapcCuMks3yieK2RivF5U+acZbuBxF+F4kLZb1580ZVZoWkK+F8iUMDU5HoS1Xu1sloLrwuVkJ4RTprZuF/dobLIrD7GzPXMU0pidmZLYCUciynqE5dahIXxGBQpXbOMKjffY1y3K+4vqFAX5TjkxJ2lOiYRuZGNK;25:s/MQtdlRx0yyhVGvPUeAW3FmLwaCm/lS8td3MKDe2GyjU8PfXT6c6oJYSFNwSCyzktOZz4HyqR9O8TaCdSiuy9f4A1MKmWCw0cJziVcCNBYPLgqKKGh47dQPzEf/CpOfs4feXd3tD01ZHtA0xmWZ+6ltBRRF5xZwphuhbP36jpKXooAbyRLDMgmqX4Wcj9YBQ5xat8TExFHTjeQ65quW2qQnltAaLTftcAc87gf22TvgLjr2X7QvRDO6u2b2Vcue91+oJC8eGphFvgtMQnytqgJrL1wv8PkIq2lFbGeM10khjOmoKUU2M+BhIXaUSKLyyW8wMat50Q3x3Ga19QKwtQ==;31:H37miSTUARRXwPl6It4ah421xwYT1KSaPrWuEHwtXmXdc3u+lxn9tSZcfmTm6Bljv50a9pd91Kbmhcz74GDTpGJNJVlrJFmoxyqSn9g+aNysMaL+G8uYL4Y3B7QuWeto2MrXwBKxcwsNL7TdvMKDRfyOctewSk3YFfFfB0SwijHo30Id0sQdMNv4qAxx9/VzR6qczshmBOauTrfgI0OGVIsrzSAEV8RAydTWfbRLj/I=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1449:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1449;20:Oi250S+3rT4wTPJY6jLlZkl6WEPl1qRM+aLTgBzfnOrwAuHD9QwZ0y0t5tfO4+Q2FWzHjQa4t2xd6KoUFHqAZuxrwCJ8QENjKoJkDDza3hwboee0oNYnk4AACcvWPfvWW85Qq6ASu8R13G1OiIe3ub/xzeUC0ry2ePYdSobGocmRY3roW2HVGkWVDKbfQIqwcuDAdy8rYiIkfNQyMZgR7H3hi20WEi0nivsBIsmQJm3jzx3Ex58xdRMuHG0Uwtp81e1yUuLQb6mdczy6o4EBwvdTwmjknL4bkAtEb29OdjK0vtMAxlUAwFjP7YrDccooVmjK5be/9+khhlQH/0jOfqjXJfe3eJRLslH9MvdXuid0UhcLxvijVXt3mwE6WTVCRTMxSZHoFEMU0pZhW5H3eeIfmRpk51jpyMH6L4Kr0uNAsg5ch0E/K3f+IiYL6MfX3gmNwKMYWfxFAGPHXNG8OL4OpA/jQEDopr6HJcCzJk92gA1q8gYZQtApdbThgj+n;4:0odO0C2s8WPowej2xzjsNXx1Q/6vCaGLSB5AP5CeYdH8ZEPe33Au02sRNQWHCg6nJ9G9vBSr9mNd4y2QcWBEgcXePQAB3Ly6zRcMTZAoWQtB55zkg/rhRaICLA/HB9ON7Tj1K7I1Hj7RZfmYNthnPtuK0m+Vzzs7DPDilyW2tT4+maVV4dhxLbVHBXfWM2/ISR21ion4p1VopGePgGl2hNQwKzukZdMiC0CSRctlOgH/pYIQv1hZL4+phxm2qmvyPDDI1h8x17ej0tDXdKg2ew==
X-Microsoft-Antispam-PRVS: <DM5PR12MB1449A6D30E9D4E211591FEC4FD420@DM5PR12MB1449.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR12MB1449;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1449;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(346002)(396003)(376002)(136003)(366004)(199004)(189003)(11346002)(106356001)(8936002)(72206003)(2870700001)(446003)(186003)(25786009)(53936002)(4326008)(3260700006)(6246003)(31686004)(956004)(2616005)(5660300001)(476003)(105586002)(486006)(68736007)(97736004)(15650500001)(2906002)(6486002)(6666003)(305945005)(65826007)(316002)(14444005)(229853002)(16576012)(36756003)(93886005)(3846002)(58126008)(67846002)(47776003)(6116002)(386003)(53546011)(65956001)(52116002)(31696002)(7736002)(8676002)(66066001)(81166006)(16526019)(81156014)(26005)(77096007)(76176011)(50466002)(2486003)(478600001)(110136005)(52146003)(23676004)(65806001)(64126003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1449;H:[10.236.70.155];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNDQ5OzIzOlo3YVo3NjR4dyt1a2xjaVdOcURlb3FWQ013?=
 =?utf-8?B?VnRGWk5FQVR0S0w1cXhtc2dFZm5pTnZsSmZ3TnhEMzRlUVdKcUsrT2tyRnhV?=
 =?utf-8?B?SkFkenRTa3RjczhOSmNUaFZ1Y3lrTUQ1WVlRcW54TkZnRXk5M2k5ak1HamRZ?=
 =?utf-8?B?bUs2Y1lwelkyZnJ5bG53Q3hZRExsV0dBeVFocUpxZTc2cS9KYXM0SVF0YXZC?=
 =?utf-8?B?emFiMkNtamFFbEx1UjBkWGZGSjRXMmd2ek9RTGhiMVRJZjBDM3NJUjFSR0Rs?=
 =?utf-8?B?cTA0RFlPOU90aFZNcXlYTkpNT0kvd1MxdWJ6L2s1TkNJMzkwWTAyeHdQU1dP?=
 =?utf-8?B?U0N2SmpNWWllVGhtWVp5REtxcUV5Q0pRVnBNbXVnanRWdHhzOFdncjVHeGUv?=
 =?utf-8?B?N1VxNGI5UGFWbHp2LzMxTW1JWWVDcld2MUZTazZyNEZBMGc0S2NIQm5MRlJG?=
 =?utf-8?B?WlV4ODRVVGIvak9pdGxNaFlwUmFGYzQwL0FUL0Y4bFA4U3gzMGYxb200c3Zs?=
 =?utf-8?B?TStRTGw3NHVHRDFIMlVId3ZmLzRQMDE5c09yVU9zUHR3dkN3anRXZmt0cTFH?=
 =?utf-8?B?M0RPM04wVUM5OUpBYlp0a3VMa0UzdlhCWGlSK0RaM1FiUFpSZ1hVcDNDVGhQ?=
 =?utf-8?B?YytoYllIeEFiWEVtSEZBQW45MjhxWXhtNm9aekVJMlVZWjR3N2tVMmp2NXov?=
 =?utf-8?B?ZFM4Vm5kbUtIMTRPSEY4ZHVTbGFKMzVmNGN4NVdNU0hVREU4MDZTd244Q3Zw?=
 =?utf-8?B?Mk4vNzFnemdDZjVENnRMbmphQzcvWkJ6OHRYT0gzNjFiQ1lPdWFOaHdOVXVo?=
 =?utf-8?B?b000cmxld05SNmdTRXpBbGtNemhVZkphV1dmVC8yLzhMdlBwZnVDODhOUkty?=
 =?utf-8?B?VE13WkIvTTBySlFiZktweGJYc0VqUlM0MjNkWTJCQUNkeEQxVHlpQVlHZlhM?=
 =?utf-8?B?OW01Z1Q2RDllSnNScDBCSHpKZ1JObGhsMFllVjY5RUhqSXFUMVprMW5BaThW?=
 =?utf-8?B?MmhXKy8zVG02QXlTVWhpWWx3YS8rUkZkNWRwZTBOZTVoMjlOSkwyZmNWSFhI?=
 =?utf-8?B?QWNQb0c2NWhhWWp1S2g3NTBWaGVhejhEUEJDaVhHaXdxb3hoR29ITHR6NTVa?=
 =?utf-8?B?Vmoya1ZHMDJNUjdpeFZDNmZQMmR4QUpIMC9JRWsvc0wrMnhPUU4xaG1hWWRr?=
 =?utf-8?B?dTRRVHVadGZ4UndpclhLZHRUbTRqL3dWeklvVzhmN3k4dUJaWk5kWTRmUFZz?=
 =?utf-8?B?bTFrL2lDcHlzbnRoVXRvVWt1bytxdU9zU2F1OG9PUEN5WHl4aUx3Tm1aUWtG?=
 =?utf-8?B?Z0w5VU1ZWXYrRzUzUGlEc0R2Umk4UGk3Zm1PTUc0bXJJQmFtS3ppb0VlSFV5?=
 =?utf-8?B?b3ZHY05OK0ZmN2MvQ2srVFUzRU5EOVg1bFhUYU4zTUhGOVpRQUdEOE53T0Rx?=
 =?utf-8?B?RXQyNU4zUzdiOTBiYVpSSXVkeDFDa1RYdWFDcEhGem5vQ0JKSGsvbEZqeDR1?=
 =?utf-8?B?OXUrcmN1VmlDWTlEcldMMWJyV0ZrZkJ5Q2pwa0hnTXRXamduUE56RmxXR2Fl?=
 =?utf-8?B?QzZHeXVWSVpPR3BTa2tkWURkVEhOZ0hsVE43R081S2lPQWw2WFVGNnhub2w3?=
 =?utf-8?B?ZnJ4Y2xmUW9kS2YwSFhRWjlPWXNFekFIYW1oaVdoSHh1bFhnV3dUTVpmVUxi?=
 =?utf-8?B?b1ZLNG0rZExvVEwzVjNGbnBkWW5qL3RVMk9YYTJYbWRJaUdGUjhPYmc5K21p?=
 =?utf-8?B?YitobEgzU0NoRU9NL0FrRFBjVVFWSVNLa2pTZ0VyWTFlamRKTFBwVEVobkY2?=
 =?utf-8?B?TGQxNDZXWEhpNDFLNThoMzJDQmw4Y2tIaVlIS2JhZElXSFU3RDVvblB0Ynh0?=
 =?utf-8?B?MnVYajNSbkEwNjlWZmFOenFRM2Ztd0c2Rk93aWJKVlFTdjVpV2ZvS1J0OUlo?=
 =?utf-8?B?WFRXSUlwQWhuUUxKWnFURGhOdEtzRGcxbElLSXUvNlJ4aUtvdi8rWERBUldN?=
 =?utf-8?B?a01Bbk9VenAwM25JUjBXZmswVUk3UWZ4aWJZaFVXZlRDZDd3YXF1Z1ByWC9u?=
 =?utf-8?Q?5VTOSjwvuCFOrdHsAV6Y7psSi?=
X-Microsoft-Antispam-Message-Info: I52/v1w+OyE/KTIf3ul7uHuNtZkoZbgLemHka9lUvGfSl3AUeYBm652sJA60C4ur5MVNmY2YL9JEwyBvPhMacQD2AekbrR7I5512EwmtrrF62woIkdt/KTixKyfKz0DPNDKXfdgjLwjIOEQ6AppwDDUZCdep3ZWE4qFZyMVpJgEV5pK/B+zY0b5HtLTLKU6X8TNr/7jG4C458xjyJujGsOpmD/tK5J3YRAs7aWErJXEtIh8K8/wOUiJGWrBPAyO7eemrp/XKbGUmaigaD/uaDVbklnMqGb9GktubtrLTERocnFtyjIypMeMJ1PG/ElUPeFxWoUZvLlQqpzpRv6ywiYrxk9f9dJvyo1Z/TU2P+JY=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1449;6:AGzZo/nixf1/GQ5erduY8iLJIt7VgGGIoRBYjHUYJP9sbjyvQ89tB/aSU2ma4+fCWqEmznX5bNtBQmSzk3tjMfRV0vDnuKCx9amS9qywR52aGH0eUpdQcXyXvHiRmqcXxj67rertAaizscTzb/d7H0WLnhxGt44BjQMErDr2VrQrnoHFG4EiwEv2PwGfWZvapINzFnlVPfEh3D3a4yqm8WmvzSkTP+mRpuNkUBfJtxX/6ODxsuq1KkAvGTM+IbFXH8KDBjrTZKuEClfmwq/bdO1tNto26U5JNMsoTlfCPMajq/Bof3Br1CEjJ7WprW0TsJcRSt789q82kzfWe+iwCujYVE+wnFpBJmXxEN6iNhwXijQVUP0UEllQIsypnkLY6lLi1vqfjWMoKLmnAeKaP/80S5oj/kHe3BmqPM/AWLhkPYjoxPjEZVw4YYjRvZEDUz45j1sp4KTmSKLT5r/asw==;5:HDAimwXuHIKITXq4zsAgCJOuQTFLBtSkG68Cw7Yv7ZWPHUxBAHKr3ylc0yiljIdv3Q6FJ/KvUAcIBdoDZ8M/KQwLvFfOzCl8XoT1V1PSOd5Bf12z6/bm3LrHaQG6FL1H8aTiUKuvY2cEmWLabQ+D8KLc+UAEUjfaa+J/z9oytKI=;24:mqH9fUqpwzkFcS+XNQsQBjYSZlesqQFJNWE5iZ4hW04aT7KLTYSuYAnRx9REqR0NjXa/DSsKUWLEcXwnlr1VgeBBf/2JrJb/G2Pf3RVfPRM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1449;7:xaV2ePk4H53kjvQzKzG2xyrJo7MknlNkBygn6VDGZAuK/1z0WwXfvaB6dPfy3WBnuhWKytt8FdMTDflJKtQy81ISuOlzJPrjAmjxVPeszXD4M3IfT9B3uMTpcoK1iu4kABTvYmjylo8+1o/LwViUxsyceTVLLn0JeVOqkLTAHrGFoyhWbEaSyh3ikad0wozyJ6dHdrj/YR77BWlmapkD6VO8/An8E0zbebC4wJhCDB7SCifZe/fCr7t5dXBx49Dh;20:1uiCNZES8ZQ89vhvvzDj1AQZ2vV+ERsU5tzcW9Xz5DP9PgxBXd6JkbMRyFiloVQLrHC00NlyRryBpxit3L93YvtHQWOL/z2HVVDUrKi9AY7mT3e9Ksr73xkUoVH8yVAgX0FkXDkUlpWpz4biC2f4xx8ZTHmfRVfsHjB6BRiCn6EqWWcOHd++IASAWXiHU8vg9UjKzbDlje21kTLO2fUzbNH3s1GA0QrYvYcioeRahCkmPK4xNYbb4HO2cNGwETAq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 16:27:28.9751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd03d96e-1adf-4670-43ee-08d5e101def5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/2018 11:24 AM, Colin Ian King wrote:
> On 03/07/18 17:21, Hook, Gary wrote:
>> On 7/3/2018 10:55 AM, Joe Perches wrote:
>>> On Tue, 2018-07-03 at 07:56 -0500, Gary R Hook wrote:
>>>> On 07/03/2018 05:07 AM, Joe Perches wrote:
>>>>> On Tue, 2018-07-03 at 07:40 +0100, Colin King wrote:
>>>>>> Currently tag is being assigned but not used, it is missing from
>>>>>> the dev_err message, so add it in.
>>>>>>
>>>>>> Cleans up clang warning:
>>>>>> warning: variable 'tag' set but not used [-Wunused-but-set-variable]
>>>>>
>>>>> []
>>>>>> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
>>>>>
>>>>> []
>>>>>> @@ -616,9 +616,9 @@ static void iommu_print_event(struct amd_iommu
>>>>>> *iommu, void *__evt)
>>>>>>             pasid = ((event[0] >> 16) & 0xFFFF)
>>>>>>                 | ((event[1] << 6) & 0xF0000);
>>>>>>             tag = event[1] & 0x03FF;
>>>>>> -        dev_err(dev, "INVALID_PPR_REQUEST device=%02x:%02x.%x
>>>>>> pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
>>>>>> +        dev_err(dev, "INVALID_PPR_REQUEST device=%02x:%02x.%x
>>>>>> pasid=0x%05x address=0x%016llx flags=0x%04x tag=0x%03x]\n",
>>>>>>                 PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
>>>>>> -            pasid, address, flags);
>>>>>> +            pasid, address, flags, tag);
>>>>>
>>>>> Seems to have a superfluous ] that should be removed.
>>>>
>>>> Yeah, I pretty much messed up all of the log messages in that function.
>>>> My apologies. I'll create a patch for that problem; it shouldn't be
>>>> fixed here.
>>
>> Well, no, I misremembered. The extraneous square brace has been there
>> forever. Needs fixin', though.
>>
> 
> The opening square bracket is much earlier:
> 
> dev_err(dev, "AMD-Vi: Event logged [");
> 
> ..and all the subsequent dev_err messages have the trailing square bracket.

Gah! Mystery solved. I'd forgotten about that.

"Never mind."


