Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908CAC28CF6
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 05:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F37217BD
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 05:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="CxXU+KeK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F37217BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbeHEHgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 03:36:13 -0400
Received: from mail-eopbgr40107.outbound.protection.outlook.com ([40.107.4.107]:51840
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725727AbeHEHgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 03:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xN622BP3I5MgFOszq9F+f9L2QlkSpC15ixT7fyN0T/A=;
 b=CxXU+KeK9cqaMQ/il1WQQpBYgvigY9WNMDHmUgYSEpLZ99EsqRkRfaO542r+Tmg/pxtZlRNsEG8yXyTjsbbF1M/660R329O1J8G8FXpK3LFdOr3gPynclGejpphV/joUIzzZSgRi024gsu1eYrGJeJcGK1U0OeeghRAXnGPaul4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (128.69.177.17) by
 DB6PR0801MB2024.eurprd08.prod.outlook.com (2603:10a6:4:76::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.14; Sun, 5 Aug 2018 05:30:53 +0000
Subject: Re: [PATCH] mm: Use special value SHRINKER_REGISTERING instead
 list_empty() check
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, vdavydov.dev@gmail.com,
        mhocko@suse.com, aryabinin@virtuozzo.com, ying.huang@intel.com,
        penguin-kernel@I-love.SAKURA.ne.jp, shakeelb@google.com,
        jbacik@fb.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <153331055842.22632.9290331685041037871.stgit@localhost.localdomain>
 <20180803155120.0d65511b46c100565b4f8a2c@linux-foundation.org>
 <843169c5-a47a-e6cd-7412-611e72eb20ba@virtuozzo.com>
 <20180805000305.GC3183@bombadil.infradead.org>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <e5d67774-a006-e533-d928-64a4407cbb16@virtuozzo.com>
Date:   Sun, 5 Aug 2018 08:30:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180805000305.GC3183@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.69.177.17]
X-ClientProxiedBy: HE1PR0901CA0062.eurprd09.prod.outlook.com
 (2603:10a6:3:45::30) To DB6PR0801MB2024.eurprd08.prod.outlook.com
 (2603:10a6:4:76::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 170aab84-9761-415e-a57f-08d5fa949df2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB2024;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2024;3:hXAIEtsPQEc35B8oQRGr1VSYZHD+nyBpBHerEZ2fxs/sUoDRtsF8BWCwnJjyCJgABbsLIElNj1aS9tDzyNVnDNPuEEUuxu9s7WjVdi8JycT0u7KgTamZQhxZOhmEcNpyHWIwqsMi15meDanZFOG9+CHuRxesjxQ/d9FtNZPpz4DmEdvNlRccCd8budPSjlh2eU0DGgO+I+mr3eJ5wNR9vfJDgEl5Tt99t4GhegrAEUqcxF5PcWA7upPg4xxk1jbm;25:KDFR+/O+29xTOuo9xQtz0w2W/P+rXAsAzEFQv3u7Da256hnrJWSZgK7TxuNh9TrldAvHeXDf0pkw2DyZqN4S6Q3ra/QyMbnMTQ/xbEQW/XIjceZnfDDR2OfL/Ay4lvujOkpM370Yd1gJzRordXj4WtV7TJ2Cfjb0+ahRWngcXZWCcjY8FPOWli+zOdAxoxlR93pxXPFBe7KvaejfoTG+vBYB9RzNcM+yx9/zCBt1FBmFwdB/XFM8tgSzOJ5/FL1XVYnlo8e9Hu4iDIFWMG/vn+xEbrPkWX2/Sk+4YPa6SNWk1ZlqQhzz4Zi0IN6Fr7JesIiUga8OVIHbyux3yQzgEQ==;31:BMZntZVWi4UKPrVossj3tIXheYJtQ5e1nNGD4yMaktihpuIUjLSIGSs/JDmQf4e6jRwRSC5GGZ5KuXZ8LsDqywC+WWwrf8TBOCKqFMOxx5QNl7RW2cg8uHUOjtuboREMp6seqqc4zJNND2qowQCy9ZFzDf3vsM/I6USxJ+659A27oluk54XQQzaxfhD4D2XcJBCJ1uZCrbcgT9Jj+qmZv5gnwakihTOMe0Sho+WqYAQ=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB2024:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2024;20:aXDScQ3ca+3OiOiXLcr83OVrpQCemmvhI9uqJKFjS0JV0DFrqflk9XM/cPbtTmbWY39AF6h+xj3aXUZTjhMgQVBGmGvMkb8zjIrsHTCD5tk2dhDJCcrXspOXPKuqm7U3BXEXn2/n/hvCNA+5kfmr7Rfm3Y4eQ3zKl9kUOpiTZuVTUGYG5Mpkg2Jkayy1Wezd7zDb/ov3uxWSXortHC0yG7iHTNhEADFM4yl4a/TSZpR7nWAieEBTM9p8E3Vcfiiu2oIrVkhkI6VoIDDLbmVQZ1+e4DECn0aJ2XabUC29yTT6ValyoGJmxA86vHLR8LzaQGmAtwMuQVYg/o0ed1Af6FMQi6NCoFUxA7cQzv4WjWVDHLAOVDe7ku/Pv7iWriGwOKxcXNHf0yniiSC21W/BZWGx239g/wQEkwRsqU9fpaIJpDGfLNvdKO5rrhXpQKXhoKfPuvycdO50TJPMJJcuS065tOpfixmhRcZ6XiQKG1oMOeFyrx5bNLB9ekn9brSU;4:PY0rI3BX4fzG8zLVLuUWcD6dPxaHpKkE528hDKgfsR/fdZvkOrxg9mEyE1n6E0QjvuUUCvDmAGMN/Rluk3Nw1Gv5Fj0KPwo+hpX8gwZk/uutJSlydAil814AvtZmZfrf03zdv+Z/keEMWysL/dxOEmFQrxOpdU8c/55wspr3yeWHyf9mjB3PAApflsonHLcgK/LT39SLOpU0YD92NQRB4x1CBVV/6QCGaWKXlwX6oPPsfoaRonJyjRJS/bwhiKStZZRrS10zv9LjJiTVAgOL1g==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB20246F9FC19A3010D981B152CD210@DB6PR0801MB2024.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB2024;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB2024;
X-Forefront-PRVS: 0755F54DD9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(136003)(39840400004)(396003)(376002)(366004)(346002)(199004)(189003)(6116002)(3846002)(486006)(476003)(6506007)(386003)(2616005)(956004)(53546011)(55236004)(16526019)(76176011)(11346002)(36756003)(52146003)(23676004)(97736004)(52116002)(446003)(316002)(2486003)(58126008)(31686004)(26005)(230700001)(186003)(105586002)(106356001)(25786009)(93886005)(5660300001)(8676002)(39060400002)(305945005)(6916009)(81166006)(6486002)(81156014)(47776003)(7416002)(229853002)(4326008)(65826007)(6246003)(8936002)(65806001)(65956001)(966005)(66066001)(53936002)(68736007)(86362001)(478600001)(2906002)(50466002)(6512007)(6666003)(6306002)(7736002)(64126003)(31696002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB2024;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjIwMjQ7MjM6dFZrYXZvelBTL3I3MXZiSHZzY3FEeVBE?=
 =?utf-8?B?WjZDZ3pybDcxN3c3dStCUkU5dS9jYWdGbW5HQjhpKzYwZThPdU9aWW9xMnJl?=
 =?utf-8?B?R2VkK2xmV3NmaGYvMXdKeGp4cEZ3NElHakRtbkxEeXBCelRERFhCYWFEczIr?=
 =?utf-8?B?bFhSTlVTQUdrZTM1VUZyZ0Z0VkpYS3h2TUlNMDZ0dFF2TG9JNHEwdWhaVmRE?=
 =?utf-8?B?SWF1UHRHN0lMQnV5endjVEdicitpOWNteDFFclBvTEpUdGlwQTZ1Q0JJeTBU?=
 =?utf-8?B?R2kvdmorRFhER1Exenk0TmlUb0R0WjBwQ2UyK1lGM3lwcExURlEwTGQ0ZXQ5?=
 =?utf-8?B?REJRdUdlMjZ3d2cxeFo5Nk1nOWJoZk5zdDlvS3IvYVdRWkkyRHBnZS90bWJo?=
 =?utf-8?B?MFFSc2VYNFBNeXBkUS9lZTlRb2RwMGNUZlhwSmQ3OTJHaDB0cWEvSWJDdE1Q?=
 =?utf-8?B?K2N5eUxVbHF2cEE4RUhIUFhnZ05KUURiLzBBVTNOR2MwNG1VK0Zld3NZMWFD?=
 =?utf-8?B?aXFzMk9aUWFic1hyNHlHd0J4SmwzTHRka3V5NXY2a2s0NGYyVGpUN3FybUxD?=
 =?utf-8?B?N2hNamdlZXpvcE9OZmdKSWVtWk13dTV4RjFqRzIxYytxNm12dDIvUkRNSTJo?=
 =?utf-8?B?SzdtVHdmOStZRTg4Z1U4OU9JV0tRWWRmT21PVlErRFNtbDg5aXM1eFVxNmM4?=
 =?utf-8?B?Nk5CSlVxNnZ0RlBYNHEyaWt0eDg2UmJCcVBQQnIvem9vQ2Y5ckRJclpuYXhG?=
 =?utf-8?B?OWVQcXN3aW9SMTBsQmcyL3FyVFczelcyVGVCKzUzV0xRMzFjQWNaR3ZJL01C?=
 =?utf-8?B?VlNtM0pkM2JENEkvblRWRmhzZDNSdHk4SHZDVlFaR3gzVEE0SVlUd2VyL2o2?=
 =?utf-8?B?MFlRZ3V4VHpHQXJwZ1Z1QURzMzJuU3pHZUs1MEVoaEpaaUUvSkpsOHl0WnVl?=
 =?utf-8?B?ZFYxL1pzeXkvMzhBM0dHOEhaL2QrbDQzRklyYldLVmRKUVJGTzZCdGc3Yk01?=
 =?utf-8?B?M2VISmtaeGZOcTI4dFhhbG91R29KaUVlOWJVUHg1STBTUUc0b2RxbWoxU2hv?=
 =?utf-8?B?cmdyRW1CbDU1Q1c1bmp5M3Bjd0M0TmlOMERUbHdUNkwvcUlnTStIOXRXRXNW?=
 =?utf-8?B?L0JJK0FTR0pXOVcwejdRaWdZWnNLcWkwRWZiSWUxc1pOSnBkZnVjcUxHb0Vp?=
 =?utf-8?B?elFQRTRwMCtZdVFKYndCYlViMnhFZFFTclZrZlF2ZDNuUStBdjRSKzVoWDFa?=
 =?utf-8?B?Y2tXQjBoNElOd0s2YUh3SlRoR0pZaUxUSjNzUWtXaVNxRXo2bm1lTzNVczRs?=
 =?utf-8?B?YlhSWVZqTi9GeFcxc0NSNkQ2ZzM0VHpYZGlLWHF5d2J6aE55T1hUOFhmRytM?=
 =?utf-8?B?Wm5SbDljcFVxdEE4aHRHeWZxNzVicWkrT0tjTkJsWUhVeXpueEhDUWdpWEZs?=
 =?utf-8?B?czAzc3JPZnJMRkJQQmN5Ym1YeWp4cWRDeW5LL3cwd3VnL2I3QVE0R0JES1FT?=
 =?utf-8?B?MkpMNUlPU3hLYTJONVg3U2pnMUtyUHlqUC9MV1QyMTFZSHJRdEhGdjloc2Mv?=
 =?utf-8?B?WVYvUWp5M1ljZmh6VkxpWUZHVnkyY2p2eUJhYmZHbnNXOEVKZXBOV1hEMVph?=
 =?utf-8?B?NUEvZmtWVjRtcjZ2ak41VkxRQ2REQ1VEVGdTL2lFNTR5V2xQWmRnaW96bW9s?=
 =?utf-8?B?c2ZUbnZVcXl0ejJTZWpmRjRSaGdaRXRXMG1lT2d5MlBVdzRCSlJsNysvT2FS?=
 =?utf-8?B?OFNIQ1FvdjkxNU1WWTdaeVM2ME5TTUtvSXFsaWhNZGloUjIxNVRlSXZHZStI?=
 =?utf-8?B?V3NzV3NFc0RicTVZbFhwbW5OdDBoRUcvOUh4K3U4RHhrY3lZd2NlZUhNYlV0?=
 =?utf-8?B?QklOZGRKL1RhWlBhT0dOVk51TDM3OWVMeW1pa3FrM3JoNUxRdklaWVovTGRC?=
 =?utf-8?B?ck1XdEFFOGViM0NJaU5Rci8zaGlmdkErNHIrbVNtRjJKRUJpRkhKNTBnUU9W?=
 =?utf-8?B?SjRzL1lXVlZZY212T2JRYTBZYzdxVEkyVGhrS255cnp3Yk9MZk16UG9jWTJC?=
 =?utf-8?Q?WQdQJWeXV37iTRx7sZwcYcqq858?=
X-Microsoft-Antispam-Message-Info: dlpsg9MUbX4MKjJhPCgvi6Ae+N7yGBfFnfr7sYs8VCqEH9/1fTyyJp2cK43ivXJ/wJr4we7Po5U7pf3/tdGPKfhBSPJ+keQBd5Gce8PxPVp9x2tabf5S/uUX6p1qwkKy5KoxwdXUGMgqDVkAaO36gWeGwaeC8TipayRMNMyhaY0wcU2QQL4OVk6Ees6+VUPULWjLaN4QOKyASO6XKZQCyjrcEmYE+g02k2pdkkBj2pVhq70YU4gWaYhcb1T/TQjQyAHE55maXaxbwCeWREGl/w+Ooek+HWA3w02ukDfmdX1UE58gIGwWBCK2uzkvX+PVFCkQHFtGpLWi/qH+ulbxfPbfi4YH3E2w/LCteEPX0eA=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2024;6:1aSMTrFK3BTBCtTcPidR0aEUl7PDjetqlyyp/GgtB6ny0F6XdNilYb+/Q6pkgqENjoEvS5VCnLRm70vsLht0g1S1S9WPtKVj8Ypr1V7Fbh3nOWlCQny13UbL014WzrnKE+tVQhlDrtRiSf+GPocOEu9EgInnpeqSbkbIwvvVu1eegornW7qwQMgWKJaGAM1DR3H0H0sv12z7yfdSlB1Dv+3he+X+tGdmmIxV0y+UjOu+2WuqQg31lOtNE/8fNONMwlv3rUZQgmJ/R2NDsJbhsqJGtlFOeRXJw73F5WDsNiVW2WR3y5XZVXom1BYUCeXXsnEQq/DM66u8MzaHEeLxd4jpr9pEpccGI6qmN5AbNtgsmO9INN5hKNk04x3BBZZ/Z/wX0F5t08Hz8Y1efZGdAhbWjIgYw/LXbqTmlZPsW0q8KUwtcLlcGbK2WPW/6pBKlollCeOHtT6q3EWjHzU4Zw==;5:oPke4bLeeCJIQK9xQoVyn6ohg1dbmuofP4g0o4pAC01G8DMNQg3pN4THMauPQxwibbkzIvOp4Ifz3+8kUOQIGpfcPdVn3rv/eiXGx13eRypSOMv1tfcVXuXY+OCgGuiXdx8FbcMpeLcfnWu/RYaMbgc69ErNsVI02yyol1KXcas=;7:Z6tTnVh/fnET3/6ntdBSPhNdxjONXuingBmsjkxv/iwrkPWwDLXwqtRLqm5pcL1mbKwGgWJSlZXA5QPFeY1aETY9MPvl/gFHerUYjJVDZVJd5izbcY2ot9peX74blDx0rRXhKoDB5Ucu+ycms1nXWFB3yCBUr763nh9JJgxz1J3Bl+2lBsn78Qi9LdXzx3HGHIIC0h+wxIsrz87f/Sf1k7cW4ZVSrd4Z7UryLqNM4hs33OqtSle3EvI8xMHS4VuO
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2024;20:J9+9ApDV9KK/NI1hVTul/ZOdiVbOZDwaOFBqtPMuEvJ2c9FCHYTAmnYNeM4LX9EBPsRwKqRdc6cETHxy4D9Vk3DrlwK8sYResFtc4txTwayeIbxzjelHf0BAorm1+2vMCjhdqe7XlIOD3Y6mUk8b4fBrh5xI9ZW7tZbPplLlzwI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2018 05:30:53.7020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 170aab84-9761-415e-a57f-08d5fa949df2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.08.2018 03:03, Matthew Wilcox wrote:
> On Sat, Aug 04, 2018 at 09:42:05PM +0300, Kirill Tkhai wrote:
>> This is exactly the thing the patch makes. Instead of inserting a shrinker pointer
>> to idr, it inserts a fake value SHRINKER_REGISTERING there. The patch makes impossible
>> to dereference a shrinker unless it's completely registered. 
> 
> -       id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
> +       id = idr_alloc(&shrinker_idr, SHRINKER_REGISTERING, 0, 0, GFP_KERNEL);
> 
> Instead:
> 
> +       id = idr_alloc(&shrinker_idr, NULL, 0, 0, GFP_KERNEL);
> 
> ... and the rest of your patch becomes even simpler.

The patch, we are discussing at the moment, does *exactly* this:

https://lkml.org/lkml/2018/8/3/588

It looks like you missed this hunk in the patch.
