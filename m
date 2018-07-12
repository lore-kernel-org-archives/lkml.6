Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93371C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352A920647
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="hxtRYCGP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 352A920647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732653AbeGLPMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 11:12:52 -0400
Received: from mail-eopbgr60067.outbound.protection.outlook.com ([40.107.6.67]:63776
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732373AbeGLPMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 11:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrUTglE28fv8FggmGFFhHc5gg2kGTHxu2UzzZRQ9qQQ=;
 b=hxtRYCGPDuagEnHTER3xSXnWDW2tREfJh4obuZZ4xhupFcIJCGZqZDTd9YRB5+ygDB09AWs9HGnJ0BsDmQKF2CeRlc4bymQWJSoVJSem69IuUouqFXsdk+l0TYwAu9FseSllzXitZgXm904bywp9EH5fgUNph5a8zrL6E0OwsuE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tariqt@mellanox.com; 
Received: from [10.8.0.51] (193.47.165.251) by
 HE1PR05MB3257.eurprd05.prod.outlook.com (2603:10a6:7:35::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Thu, 12 Jul 2018 15:02:48 +0000
Subject: Re: [RFC PATCH] mm, page_alloc: double zone's batchsize
To:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Tariq Toukan <tariqt@mellanox.com>
Cc:     Aaron Lu <aaron.lu@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kemi Wang <kemi.wang@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Saeed Mahameed <saeedm@mellanox.com>
References: <20180711055855.29072-1-aaron.lu@intel.com>
 <20180712125408.GL32648@dhcp22.suse.cz> <20180712155536.20023cc4@redhat.com>
From:   Tariq Toukan <tariqt@mellanox.com>
Message-ID: <2b51fa24-5fc7-f328-1bf3-a78f28eb742f@mellanox.com>
Date:   Thu, 12 Jul 2018 18:01:12 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180712155536.20023cc4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: VI1P18901CA0010.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::20) To HE1PR05MB3257.eurprd05.prod.outlook.com
 (2603:10a6:7:35::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96281a6d-233d-4216-f101-08d5e808895e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR05MB3257;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3257;3:TxlGC9oA+i0nUe1zWyhFd1r7a37C/RfBsJ7nD0+sMAIrzrC0fqkW9IdKuUY9V8wozQECvlPn2Oic4Kc4vWcciiKX9KC4tRuLhYjGYlQ5vy1xEkSsZu5ZzWBBmlhLFzwhT+eLMAaQSntx+AoNCEp9yN3CYRTGGY72FJJ9xGg8XYTkFIt7o0pcD4cWbdQF7CX2WTsPHBr7o2WrKS2A3hmwZQzfAQ23KXppmixir6YYhH8PFeWfWlL0Z1lxtfQtHom9;25:Hx8wpUBvZdbugpxNyiD8wE+QDyUaC1s3tC0ofFOCH0w2bbON1jlRLnMO/HP/j9VhJ6qjHcjg1kiYjCG892M1PJkUE1qnkIw5fRb/F/lW6TdOOHHtIadDRirmu3RByJJumS2GiX0GEnEa8c9QEr6rh/LD5IeuUDul88o/MfRZL2Msg/2aYP5udaZN7jYE0iCdr4jStOfw6IhYlqfMzgySVxSenFvhkaGMR7obVXtORtrBRy5L+DCWNZHcKt+HWdtyoWeoYSCMLqEM/ZxPmVusMIklkbuVdPFEkW8gURE13lAOVrStPAWiudqsyRxWEeX52EgY8HQfyJRj+f3zRIKQtw==;31:9+B/zzDmezdc5gYQISRhF8wZQJQQqUJvn+OH2xbcAXNhSgW3dwvuDPpRBvOdXyagFvyF8JbfNvpxfK0kmQn+0iOgGITNQxRNX0b+qMvCejfmnk3eu3YdkJ89yX4EcibhdgmAi+H8JNBQ1wReg7Y0ZK5TM893goM5p9MlusXnJ1a5xcnLEEy8LNgm6ezwH/RQO1KNey0jqzDJc8ry/65ZhSEkXPr/yazplXeypo1xV6c=
X-MS-TrafficTypeDiagnostic: HE1PR05MB3257:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3257;20:vnTAIo+8/iFlZgcLC2oZgWyA+39jIO8SyMuIV8i0Kpg96BOyIBECNKxhqVRGlKW9Z4uMw35AdP1CJFUj1AYoxngX/Ovj6o3CqHoipFMNvuheiA31WS6kzGX7J1FR/wcDIbLGvWyMDPnsWFGC+pqHAlAZJ7s0V7F2qh9Z+o0mH0D60dAx/jZHWgXsZDuKbj28nYaN4H/GVyIXlURH4SRNT3RcknWlfHhYe5VNAaDtWCEWnoWJ65KkqP97armSc+jGtr1Nerv/M2YF7Y5Sn4EAKI+XQJ56nYvR/ggHrsdfp8amZaHcmWhNH3qECH8xVdemCgIlKbwF8tG801nyMLd7iaCzOkw4y966Md2PjirhzykimIN+UFqQP4KNhaa8eHx8mNeCKUElY8tMaGN4O+MGryHnRxG/oCk3Iy8jYyGf5QRqkwPaxipXBachKvLZ1K83DX2bLCKWbPh1fYH/upbOtYWqAbEHU5TKWw+XA70meYQ8jQ9V0JCanfm5tI615ZAc;4:mUlmTmZDBxpfUcwJoWhd1/q5U7Uv4x5OUcmjoCNIqyenpHDokkrw1rzGwQNNtOcrDCdbwgHyTaRrKiZYbyJEbKncI7y/xmve/ey7h+mgG6ze4vnN4SXq7ConUNr3t4Z1MLC1JDIdEzfjv0mVaj7YdYmSrWtsNBaihyrfT1CZrznfVHofIraVBE8z8E5xKLNquEhUxsSAJDJO9OMEDeG2bS2J2B4z623+rqAQTQn6rvGrEZd7SVH8sF9si0sCCpZGbHcdb1/2JfJbOD5tRPCg+w==
X-Microsoft-Antispam-PRVS: <HE1PR05MB3257AF328A34B40CC617E7C5AE590@HE1PR05MB3257.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:HE1PR05MB3257;BCL:0;PCL:0;RULEID:;SRVR:HE1PR05MB3257;
X-Forefront-PRVS: 0731AA2DE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(376002)(136003)(39850400004)(396003)(346002)(199004)(189003)(52146003)(68736007)(107886003)(6246003)(53936002)(31696002)(386003)(97736004)(65956001)(230700001)(110136005)(478600001)(66066001)(50466002)(4326008)(2906002)(86362001)(316002)(76176011)(36756003)(106356001)(67846002)(58126008)(65806001)(54906003)(16576012)(47776003)(31686004)(81166006)(8676002)(25786009)(81156014)(229853002)(2616005)(956004)(16526019)(77096007)(476003)(446003)(65826007)(6486002)(105586002)(11346002)(26005)(8936002)(7416002)(486006)(7736002)(6666003)(6116002)(23676004)(14444005)(64126003)(305945005)(5660300001)(2486003)(53546011)(52116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB3257;H:[10.8.0.51];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA1TUIzMjU3OzIzOnF5alQxS3BQWExJckE3ZlNlejRTQ0paKy9j?=
 =?utf-8?B?UVZZM3M3bWtENGVrRnVuUjZRTGV2MTVURkF2b3lxVEwyZ2ZQbklCSWR4emRu?=
 =?utf-8?B?V0tReVlDT3BTbklzckU3a3RBUFpZZllmQ09aMXduU3AyVzVUSlcvNDNXeHNB?=
 =?utf-8?B?OTdQVi9qcG4yNjVwKzlva0RBY29BVFpEOWIrMVdNY1E4dW5oQ2tQY0FXYXpJ?=
 =?utf-8?B?NHdweDRGTXF6NCtqZmVPaUQrZ2lFcW5kZGRXR3B1cmUwYmZybzlrd25VTlEx?=
 =?utf-8?B?V3Z2NkZDb1lRRGlrZlZlaWlhSENPbmE5M2EzNERONVAwQTQyYVZaSjBmNEdo?=
 =?utf-8?B?TkxRMHJ6cXJjb2I0aXE0LzByQWVwOWdNbGJEWXBXQzZCK2VITmVnV0dCSWtr?=
 =?utf-8?B?UlJJYlJ0ckNpV1AwZi9nRHg4bzlNbE1wOEJiY1d4NUlteEhkOVM0MWxHcEdz?=
 =?utf-8?B?eURZWFBNQ0ZSQkRoNFo4YWk0ZjQ1YUNJRVIybzhScTBOQ2pTUEQrTGQ2bGFQ?=
 =?utf-8?B?YlNVcFpLRU1jWkxHRWlkQmtTT2c2Qk0zd00weDFDaVJ4N0IyU1NOcVM5WmdG?=
 =?utf-8?B?YVl4cWUrRXVwbFdSOTU3OXZrVVZBUG5DTU82cmZSaXRBeWRLY0RsVG5vVVJM?=
 =?utf-8?B?dHNSd2tBNEVUWDRPQ2dFS2tDanlqK2E1Uk1CWlJyRTNxczZ6TWhKT2NlYlNY?=
 =?utf-8?B?bWphWWNBT1lPeXptMThYK0UzRW1lL0xGVytDQnA3RGZaTFFLVUowT2JaZWp4?=
 =?utf-8?B?bVhaSFdhUER6K293TjhuaXN2NENENmE0K1E1TE9hdkIzTlFGeUlSSGRzTDdJ?=
 =?utf-8?B?d3dTblRVY3VIWTVkMGdNUjVWV2pvckdqTS8ycklOR2NSM0NyOWwyQWV5ZFJ1?=
 =?utf-8?B?cGx1SmhDcUZmSGJvNWhRLzVsMUxmSFJXMTNNS2gxdHQvVDNUOXRlYkhFdUxK?=
 =?utf-8?B?WHB0ai9KQ2pMRHovUTczTEJWZG8reGJ0bGVvMklWVEVMWm95enNSdGZMMU5Q?=
 =?utf-8?B?R1ZHNkp5aDE5T3RtQmNXU1YrajNOWkt6YWZOd0h3QkgvbzFaV202MEZOZzZP?=
 =?utf-8?B?bmJWZ3JqM3I0SE1wZyt5cUwwRWhhcjNFQ1U4WFZwYkt2bXFkdGdBcjRRUDVt?=
 =?utf-8?B?dThkSjE5dldSK2kvOW1icGR4K2hzYmEwWVhNaUhEemozallNcGtqY0FMb0Fr?=
 =?utf-8?B?bUJxdFMvdHBIcDNoNlp2VS8vcWQ0QTVETlJkek1YYU93QmtXTFpseHZibFhO?=
 =?utf-8?B?eXdhRVpFclhSSTZFVkJqNGJ3OG9RdVdnM1BhdjcyTTRrV0lQeUZjWXhpOHo4?=
 =?utf-8?B?NHlySEhCcTNnMlVDbVY2Nk1OVzhTd1EweVROYzdLM2t0MTVWMkNVb1pWT2hK?=
 =?utf-8?B?Y3JYSytsRzl5ZGtNYUxhaDcvRXZBVzR1aXFqQ0VJVlBPd3lwRURVV3VPWnlO?=
 =?utf-8?B?ZDA5T0lHSFNEbDZXSkF4bVVzdWU3ZEhCTlE3WmNaRk8vMDVmU29vTGFqTzg4?=
 =?utf-8?B?MERHT2ZlOENVa0NtR3JaQlV3b3p1dXhPTHJHUEVCVHhrcDN6cnN0OU8rR0dK?=
 =?utf-8?B?bUdNcHZMd0hMVTBaVElTaWY3dnFQQWcxbmJlMzFoY203eTFxN2crQkRBWGdQ?=
 =?utf-8?B?bmkxSi9VWFZGN0VTb0hqSitRc2ZaSGNROE9mNlpvckp3U3VtbWpjcTVVRE92?=
 =?utf-8?B?N2ljOUFBWkdUSCtKSlRhVGI1OUx5aHZYZFZHT2tqMHl0cG9qamJwcXhJQUxW?=
 =?utf-8?B?aFNLUm9DWFY3aWV0aUtFdHV1UWEwS2wwVmZMQTVvNzd6a1RXWG1CbFVhVXk4?=
 =?utf-8?B?TzJabVpsZHBOdi83am5uU3NONHM2UlFXd2FBcDNOT2l1VnpnbDdnSS9aU3hm?=
 =?utf-8?B?NS9salRWMHowQWJEQjQySDdmeE9oemcvNEJ4c0kyQjlrT1A5cU55WW1JeGZU?=
 =?utf-8?B?MnhaYWtkdFZyK3ZlbkFGTzQvYUM1U2ZGd254T0NGQkd5WWpJK2FNRU5GTjlx?=
 =?utf-8?B?Vi9UeXgyc0dpMU1EU29yRlk4SkdPRFFUVXFmZz09?=
X-Microsoft-Antispam-Message-Info: cGwxY6ohSgnZ8lOkf2Bpfne9R+r/H9ap5DUAO7TZBcQVTQvClyez8/yGt/2YHD8oM6t9UQrS6LLdDaqf15MQv6yHJBXsX7ZiS17dlGztw2KdBqbbbF/nD47stn+9QVOnlaGLGFxhB4BfuxGzRiYuzDsG2AJUjYT7Og/IltloKWhdAyFQ+i8iCu0wpnXwLj1E50d+/VU35UJ+6Dv9kIEypA6fTzdZVN4qcjsHLqUUa4zk9/lg2wwOWJAVHdu1ZwiuFuUbuNZVBP3uRzU3Il76BBuoEM2EyuJvTx5uBYxU/x0DoRfNrxA9NKIwvVNR2sXaO2Av3gSXO8GWclOLg08fMsrT22St9fSrzx1sdsFvccY=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3257;6:uB+4P10QGW3EoTc6TE/eZYMXKVMRRyRurrnl6GmpywEMmxJH+vPXo3/+JxAO2Xmt8JitqmHSc9/pZT9Pm1quFZjvYwvoaW541qBclzBNT2b07z+hzFNrhyDdFWewOBjNZK+JhKvBVxdTpzB1mDkCHrh6cmQvpDb6gG7vMJsTTrplf/HqJRJA+ygCKZvn8LIhcZ4aagfx2dt3nlTKXh1Zc8TSRTI3UP+GDJNb/C5zyx511Iu6kXs9nPbkDuAKlTZHdVjoH9uMBUnoxxePoTJFRj747qMVCG6hOtXQXUBRwe6G2eN9mq9mEB7miH3b8dJxckJ0E5ywAbNVdCzpsvohPTw/KHrSifIrtVZHyyyqJhXtYTMccqkmEq2QYJvW/y/hOIZmp+14mpnE0DHj4yzEfTOtcqcAEqrJYdZU9/BY57RiSku3kwjHiP3P/cRfdEYYnWkGGSghSZik4XhrIeqS6Q==;5:P18LwTNBb8KLHxmXNbh1UUGd8Gcp5Ave1PLbFo738bnkUF5V7azOJKWu+/RHlwzXZmi/mhZXWRqyCb/d4WggqyNOpq2MOhOu3Zj5PuWAAm4DdBZWINuf/Rx5/Zrng/mwVEBaTZ3W4XxTPYc3tGvSYZ/L9pYYnrrFWOEqqlQzf1I=;24:zJ0ZP1Ebf1GYF7ThlMZuA2NBJ3IiWWDyrjxvoeChwLQryAA+NOoifol7d8ZALoz1qqHQgFhUQ0OnygkQuhJgCxKaPJd6Q4nFGiTan61wnoI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3257;7:a3kMKZIcHfyXUP/O+VzK+IS8fo82OTddTHrIVdWVYa/HYLUI9A/jxAzDrK1HfMXgcSdBsRsF8MHXETpwS73D3/4LD9kU1UlTmFi5f45xxdh8XXnIcXEBS5aruBIba2DiIu/KH+5yEu9AkgurN/vod9l51bpGyUxZjpUSBtrk17pXPT3p0ZWAeKT1SLqx3+UXmeYxqHLkk8s+NZ/jMmDsFB8FInUGrkJ326/YFFyGs6aa5sjc4PhPLL2pb91BeH8E
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 15:02:48.3938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96281a6d-233d-4216-f101-08d5e808895e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB3257
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/07/2018 4:55 PM, Jesper Dangaard Brouer wrote:
> On Thu, 12 Jul 2018 14:54:08 +0200
> Michal Hocko <mhocko@kernel.org> wrote:
> 
>> [CC Jesper - I remember he was really concerned about the worst case
>>   latencies for highspeed network workloads.]
> 
> Cc. Tariq as he have hit some networking benchmarks (around 100Gbit/s),
> where we are contenting on the page allocator lock, in a CPU scaling
> netperf test AFAIK.  I also have some special-case micro-benchmarks
> where I can hit it, but it a micro-bench...
> 

Thanks! Looks good.

Indeed, I simulated the page allocation rate of a 200Gbps NIC, and hit a 
major PCP/buddy bottleneck, where spinning the zonelock took up to 80% 
CPU, with dramatic BW degradation.

Test ran relatively small number of TCP streams (4-16) with unpinned 
application (iperf).

Larger batching reduces the contention on the zone lock and improves the 
CPU util. I also considered increasing the percpu_pagelist_fraction to a 
larger value (thought of 512, see patch below), which also affects the 
batch size (in pageset_set_high_and_batch).

As far as I see it, to totally solve the page allocation bottleneck for 
the increasing networking speeds, the following is still required:
1) optimize order-0 allocations (even on the cost of higher-order 
allocations).
2) bulking API for page allocations.
3) do SKB remote-release (on the originating core).

Regards,
Tariq

diff --git a/Documentation/sysctl/vm.txt b/Documentation/sysctl/vm.txt
index 697ef8c225df..88763bd716a5 100644
--- a/Documentation/sysctl/vm.txt
+++ b/Documentation/sysctl/vm.txt
@@ -741,9 +741,9 @@ of hot per cpu pagelists.  User can specify a number 
like 100 to allocate
  The batch value of each per cpu pagelist is also updated as a result. 
It is
  set to pcp->high/4.  The upper limit of batch is (PAGE_SHIFT * 8)

-The initial value is zero.  Kernel does not use this value at boot time 
to set
+The initial value is 512.  Kernel uses this value at boot time to set
  the high water marks for each per cpu page list.  If the user writes 
'0' to this
-sysctl, it will revert to this default behavior.
+sysctl, it will revert to a behavior based on batchsize calculation.

  ==============================================================

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1521100f1e63..c88e8eb50bcb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -129,7 +129,7 @@
  unsigned long totalreserve_pages __read_mostly;
  unsigned long totalcma_pages __read_mostly;

-int percpu_pagelist_fraction;
+int percpu_pagelist_fraction = 512;
  gfp_t gfp_allowed_mask __read_mostly = GFP_BOOT_MASK;

  /*
