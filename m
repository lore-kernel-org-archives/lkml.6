Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E84C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35FC219EF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="USjH6eNd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C35FC219EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbeHHPLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 11:11:09 -0400
Received: from mail-eopbgr30105.outbound.protection.outlook.com ([40.107.3.105]:15180
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726971AbeHHPLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 11:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SaCo9MC6lne0n8PfH0evLVK7bfF4iBw9H1R/2C/c4oE=;
 b=USjH6eNdnjSosgt6XSSM/Prse/yZhVkb1eGdfcoDDP8XshVlbB8vIZ3M9HkHf2U3vTirQxImlK5XQKI+wQ3eLNaPYArR0na2tbe0tDhazoAGLKWA478vxk5RC23ACqmjX4VT0eDlk2+15h/F0h1H1MHVfQ4iDcGPaG+iqKFk/o8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 DB6PR0801MB2023.eurprd08.prod.outlook.com (2603:10a6:4:76::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Wed, 8 Aug 2018 12:51:15 +0000
Subject: Re: [PATCH RFC 02/10] mm: Make shrink_slab() lockless
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     mhocko@suse.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        vdavydov.dev@gmail.com
References: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
 <153365626605.19074.16202958374930777592.stgit@localhost.localdomain>
 <591d2063-0511-103d-bef6-dd35f55afe32@virtuozzo.com>
 <e6489e38-6f73-2f5d-61b6-ffd1f6462aab@i-love.sakura.ne.jp>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <411e77ce-90a6-8af6-dd57-bd3b6804beff@virtuozzo.com>
Date:   Wed, 8 Aug 2018 15:51:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e6489e38-6f73-2f5d-61b6-ffd1f6462aab@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR0501CA0030.eurprd05.prod.outlook.com
 (2603:10a6:800:60::16) To DB6PR0801MB2023.eurprd08.prod.outlook.com
 (2603:10a6:4:76::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8e17781-2d02-4382-8201-08d5fd2da10e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB2023;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2023;3:dBgU9XDzmbPc1u137ItZdqxFj2Eq3xiwR0WQVmaNjyQxaLNMJUCV5RgTrEkjRZCrLxmmEuavV68vh4ilUHoGJRQKBBXLFbyQzE42wf/ZIeVCSIYLkN7tZav/KNxEBaBwOnHsVT1tng/O6+0Yb2AGaDVBLVYxNMwVE6UNrre7rXVLmJzpAiQaW9rEHvBA4476Ts5Chb3ao8C6ndxxfiHFr8N+pinGGIYXzFWigLAD3bnpW5OHODTIU9Q3EBBhLt0x;25:bQen5/5J95aaguuu0Y3/Ik6YL6QC+5V8f0PHbxHO+WSG+/QK8j9s8v3/2+LyvfiM5Fu4rWYjIggQZDbRUPBuqEaPDAS8h/IUBwNMx8kZ/pqXE3JFIfbo7mGuBJf3MHKCqq2bwZKWyeXbKqQ9uTtFVJuYW8fxKv2/yscs2Hf40d4Y0CeIZKso3lKWcXx1EEeTcC1BLHuXFHR+pZCQF5Oi9zphypsofaOhPTqCwWi8d8h4AT9FLG0sPA6kuDtoBiZ6BQ+bERXBzpzosBk6HkNMcC+UQd/U+yNqtXe/A6RKZKaiS/lHii6Df0KS2t3extxay4znOFsto9pvDHjwNv4r5w==;31:pM7pzM7Mi/huc4TSYTkgutxXJ1EDHlKzjM1TO3gXqT+Plx5crju+X/dGCDug5fYY3ljKrRUHb2zmI4D8OWC0g32ILmQbBWH2sAtGVMTkgAtzlcgXwMNDXpvolxpCvFD88b5SGINVcXpVx33x9bSZnWybs6+AvNA05iNnFBkhm5MB/57UgM/kRk/1Ew6xjW1SiYDNbV29Vmz/kpXES64YmTQ3HilT8NUEFUg6BBAkKqs=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB2023:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2023;20:XDqPwYaW8aeZONdDl99wWXTEqA1UDXr4s/We1yby8gjKboCmN4GA/ydSDPC+g1AqhkUYAugaV7iLeGjWbLTJqRPHPc4ZPFbDeT7d7ncBiY/cfy54nL3GjDorBFoAU3mszSiqdznf5iJ3aSfI3A8faNICzH/dT2GR8YylpLO+Uqf/kqlbFwu0D3kTaFT40zlqoxOkEj7XukU7H9BmpB2B+jj/OvotWu6q3xXG0Ruah6EJ34VZddBCRpvZICErsh5By/jhpeS3YQYxK778Y3Hd0jxKym91ltIKgrSIoh8dZDNuIim2p5C0Q7+H6tA3lgdCfvNzt8hMdzkfATY16SoFECsNOrK06e8olJMB8lIKEmG4ba+4TtkM0TWaQxSFUj+TPMXhCKzgwBTIhYigxXH40fhFa2WuyL2dWqyLPJ7DZ7+Y5q72dtLPFp+5pyILMnYYMrIbT96Q2F8nsSRWVSgOQ0s0rekiJjdTWXoDqzKPtblsYh9vaBRdIHIYmfPDrh53;4:O0L3xlZgPA8/i2V3h1QaWFdcA5rEvy3TEDRcWhGEWkgyFWWna0AWznGVdjxKfvUJm0RsDsQ/YcuyFqfsYtGiuVNN6PkACuqEz9ULBxWd21MFDxBkOwLOwRMna39ScVcS0ZgY9IvLD8QBBbR+8E8vG7Ancp2MBF610R3gP6He3xeXTBM2VbdMNVj/er4RwQdHpqk0iCf4P1GZZlFWaPf/YOwg2nnBILcx57OdcPjzczjA0860dQnC+1Keq885WfVF8xinIAmHIgCz6Ege6gmMln/1ly24pMMffVGSFRBi2iDQi3/22/c/XKZnzUrmeT6G
X-Microsoft-Antispam-PRVS: <DB6PR0801MB20238D644E98C546EBA30B0BCD260@DB6PR0801MB2023.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB2023;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB2023;
X-Forefront-PRVS: 07584EDBCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(366004)(346002)(396003)(39840400004)(136003)(189003)(199004)(81166006)(81156014)(478600001)(6246003)(39060400002)(316002)(16576012)(58126008)(47776003)(64126003)(68736007)(66066001)(25786009)(65956001)(486006)(97736004)(65806001)(4326008)(86362001)(36756003)(446003)(11346002)(31696002)(53936002)(956004)(2616005)(476003)(93886005)(50466002)(217873002)(3846002)(76176011)(52116002)(386003)(229853002)(53546011)(5660300001)(16526019)(186003)(305945005)(6486002)(77096007)(26005)(7736002)(8676002)(2906002)(2486003)(23676004)(52146003)(106356001)(6666003)(105586002)(6116002)(230700001)(6916009)(65826007)(8936002)(31686004);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB2023;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjIwMjM7MjM6UC8wZjFMSmlBOVNCem1lbU03ZzRMbE5Z?=
 =?utf-8?B?YVhPY2hlNk5FVEp2WEJhS1g3V25pT29CWW5uZEJYQzlWem15VHNqK3VDVU83?=
 =?utf-8?B?RHdxYitaVDhKRUJtT3YwcEtwbGdlNHJCdFFlaWZlc0tuOXA4VkY2ejRlVlVB?=
 =?utf-8?B?dzFpeTFHakdoZlp1OUV0N2UxRXFQWmxGTTB1bXJKaktWS3pTaXZodGYyMFk2?=
 =?utf-8?B?dk9YL010L0VvaE4yTy9nT0hKUHA1R0RLRU9wTzhYYVRsSlNEOVlxcUFpMDNo?=
 =?utf-8?B?WmhPNmcvSzFVNlV0RzAzWHpDWXd5eFBHSGVmNlVCYWNxN2tyQ1ZwNHUyN2o1?=
 =?utf-8?B?NnJpR1BQeURQMGNRVG81MnczSmg1Qy9jZHNNRUJYS1h3MFl4UjBRMEFrQkpL?=
 =?utf-8?B?ME83YldWNHdHaVVieEo0THlTQjc3YmxpWDFCbEwzVWFtQ280Zk50djJHUENh?=
 =?utf-8?B?WDVId1NQRVJSTjhhL1ZWZnRLWHAzcHpSbDZwaUJxQlY4dkdFS3ZWVXQ0UWhl?=
 =?utf-8?B?eXdva01xN2ZVbWZ4TklNL0R6REZNNUl0R2h2cGhMbHd3NU9KZGVYK2k1dVNO?=
 =?utf-8?B?SGtzYmE2VUhhbFRYZW1vRjE0NnIxQU9vWWhDTm1SMENzVkJ3QjNTdWdFN3Vx?=
 =?utf-8?B?U2lVdjdndVFnQjBwNnZ3Vk9FT1BaNUZHYi8xNFhWRjJ6NnpDQnBvSDhGdTVv?=
 =?utf-8?B?Q3R2NTRZSHJjVUFtR2JBOVovdDBWMFYvbnhBdFNvdURlVGdmVms4QXZyOVRP?=
 =?utf-8?B?UnFod1Q3aDQ1ajZRVEx6WE5QemVGVkZGRmFXV1V5K3p2dFNyN0FKUGx4Rlhy?=
 =?utf-8?B?TndrMEhyNk9sYy8vdFJvMDNSeVhRYXUyM1VPNFQyK0JKTmJOWC9wam5oVERs?=
 =?utf-8?B?L3k0WWpiejVzWFRtcXkrRFh6VG5aWUtocEFMM2J3OWZRNGVybjNOWFhNTjVU?=
 =?utf-8?B?WXRib0h4Z2xaeTdaRDFMQWpwdU9SckUxUkZCaGxDK1hQOWFROTR4OXZRRkNO?=
 =?utf-8?B?TC8xT0NpQVAwNzFrVXd3ekxyUHNQSDdyZEpPNElVSk1qTGJxenp1MURXdVFN?=
 =?utf-8?B?MUx0eFVjeFJFNkVobHRLVVNHMzBFRDRqNmlmaEZpSHhNNnlBV2ZoMmg3MmZy?=
 =?utf-8?B?QitWT0EramJGRUVJK3pSc1pJaDljOHF2UXJ1cWdraTk5a1FWSjBKRFY3WmZ0?=
 =?utf-8?B?dzdqaDFFSXVDcFpLQTZYK1h5T0xTNmJkWFhvdElpeWhZTGd1SzlZQXh2TWlr?=
 =?utf-8?B?RWdySk93UVNBNFh1aFFyZ09ZT041VUtQSWsxcEF5QmRNM3BDOVFiQ2VZOXV2?=
 =?utf-8?B?Zk9weTBkU1ZKUFFTNWpMUjdtbW44Tm0rRGRwdXdUMWk4a3dWRWx0a3BqNm8w?=
 =?utf-8?B?SFZoUEVlbnVGb2kwdWk2dHo2Snh0UDQzblhrc1lGYkJBVlRTTFlLcTUxS3ZG?=
 =?utf-8?B?aktvTk90S0IxUVF4N0RzeFJ1aGx0SHRKR2w2emhBdk1zSVcrekVwTUhTYVRJ?=
 =?utf-8?B?b0NNS21lSXZOb0kyK0FWM0ZSMjdYKzl2VDdyS3k4aFM4UEZla01YaEVPV1Zt?=
 =?utf-8?B?WmRnUklnOXBJMGsyY29DRGJQOFZRYnVTSnQwMlJQMW5xQWtjaXRBdWVLcHUw?=
 =?utf-8?B?OWd1QzFySVQrU3IxUVJmT1gyUnNyYTEzS2E1SnVDMHFRdFJKM3Nsei9sVzVM?=
 =?utf-8?B?WGhzeEhvcW5tUnljTFJnbE15NE1QYmdKd08zSU1LK3NzTWFQM1hjSEU5L2pU?=
 =?utf-8?B?a2JlckZadmtaaG1Pd0cvMkJ0OTRoZlpLZjNGWHRBVmlPZFcyN0ZoRFNGWXZI?=
 =?utf-8?B?dmZqRkRwU1Nkc212MHR1NitIYy9ndU9uN2lMQ3VmRVF5TE9mSnZMVWFZeDhD?=
 =?utf-8?B?eENjRlpESmVFUHhDNGdxclNROVZGdjVNeGhtUlArNFpGZHVLbkJhVy9VS1pk?=
 =?utf-8?B?QnY0cDhIRGFZdXh0UHYvZlZnb25heE9oVFl2c3BYYnU1MDhFVG1GTVBjNlhJ?=
 =?utf-8?Q?ko/iS3vx?=
X-Microsoft-Antispam-Message-Info: osGPk14SGfslx4KDsUh5/ZvkEQcph2cmsT3D+UkLZqHF7+a6ZX8N29RjUuE8OLznTPn/H4aZR9K9yT6Ai5PsM++PAk0Y22vihfl180swrW1Js7JLO0+2ciaAAcPMoz1p0Q8Xk2ysx4D0kE13VKoAEtDQH2OsGGp5RekJ0fkzW8nWJ4kA0ydWLGQzY76vofhtCyn+YBwwcoZ0hg/JGMY90fBXLX/VmKO4+0ZGod8p6UO3MWIPT1Di3lp9zAYtSaPr7oosCzEl59jy9kmeiRU+Q57KLHSikkvGx9dDf6IZhQ8tYt3HrkCdszqxuaa7PWwXZ4WMZ0cXOPWkOOaya9dLBkuy4QKtefMnGqFVsiz1N0c=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2023;6:NVdSG57yZUkrL2PhfbVLhnteDuPZslcMLO7D35JEwRbZTSXTNvnlb/6VSGsd0LXRANr4hCvSr/2DMwma97beiV1zFopMJQ7Pb67EXXU/HRjpbxJKKt872kgVvJlr8UONQXEHHlPonjxeQTDtsBqixSLrY4NuefFcysxnbdFhq+Gfi5F+iYPkkzZxe+UoYgKPLLfqS29Gg+HMqaEWvHm4DRJmTuBEduMRQYvXKoypuFyR5QSGHnFTUzAfxwJsKq0hc+ZAHNjxWyJAiDPMSE/1Q5XLUORjWSzOLEMh7pwwcQE9g4lVbEoxaUe+XBccdfZUyawCAJMmpXXg4M1LPrsuO8PZrUiQldyyz5+OHTeCNh9sXwo6vTic6aI0BFhMva5TqBsRi/diaJ5cMiJZy+kjNndMuTUDcbXiTpCcOtJZ7gqu4LzqWCrg52lPC1XRDt3uz9lEeldEWHsdAVlF0zZqBQ==;5:kgbEgBup4sesfOdOU/L233CffRKkj9tvFpv7znru+SGH/QP+wddiMMXW+6ocoMQpXiaCgNCOoRzqP64eyGu+0+ZDfpI5V2+0lc96Z7BlPZ4RqmbstdjvfLcqNt4XbaIg5jwK4VnqzTIU1BpKXFzISEhCNHnKFGM+Tr0Dc6H76x4=;7:UsXIvJt1oBCkkberdFiYvSlQY6ae18BGL1PaIYjGLiYrBd4ZPoLorJcRB/JvJj8CAtKAx0WwlfpYNWupm+MJo4KyZPBlHjjYZSyI+XuHnvP2+DudGrz4ObgY9Sr/Mbu5n7mh43atbEBmyjiMb2eXJ9IP1nynNqIQYeB+PA8BQx8Mt5i4VnqRvqikkWnwsXyKjNrKoISkfH6UDfY8kRTNFzdw7w15NzBQUXJf3P8P8jZdgBkuU8iYsxjqkAKwezAQ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2023;20:J8CW13K0h03RiM+WYgJI6JzLZLLtMapC32ZvPq3f9sIY+8tb3zH5oHM3ufKmLua9uynDJjYKlimM89lyzn2XCWQTu6hOgHOtIKUpSOHo6UXMiG3XNZJUcgsipgf2Yt3m1Ip9nS4Fb3UWH82xpZARF9W5/2/AakM90yVEv7nXlyg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2018 12:51:15.3796 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e17781-2d02-4382-8201-08d5fd2da10e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.08.2018 15:36, Tetsuo Handa wrote:
> On 2018/08/08 20:51, Kirill Tkhai wrote:
>> @@ -192,7 +193,6 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>>  	int id, ret = -ENOMEM;
>>  
>>  	down_write(&shrinker_rwsem);
>> -	/* This may call shrinker, so it must use down_read_trylock() */
>>  	id = idr_alloc(&shrinker_idr, SHRINKER_REGISTERING, 0, 0, GFP_KERNEL);
>>  	if (id < 0)
>>  		goto unlock;
> 
> I don't know why perf reports down_read_trylock(&shrinker_rwsem).

This happens in the case of many cgroups and mounts on node. This
is often happen on the big machines with containers.

> But above code is already bad. GFP_KERNEL allocation involves shrinkers and
> the OOM killer would be invoked because shrinkers are defunctional due to
> this down_write(&shrinker_rwsem). Please avoid blocking memory allocation
> with shrinker_rwsem held.

There was non-blocking allocation in first versions of the patchset,
but it's gone away in the process of the review (CC Vladimir).

There are still pages lists shrinkers in case of shrink_slab() is
not available, while additional locks makes the code more difficult
and not worth this difficulties.

Kirill
