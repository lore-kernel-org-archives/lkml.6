Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752885AbeEUKQz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 06:16:55 -0400
Received: from mail-he1eur01on0095.outbound.protection.outlook.com ([104.47.0.95]:4590
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752535AbeEUKQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 06:16:50 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH v6 05/17] mm: Assign memcg-aware shrinkers bitmap to memcg
To: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: akpm@linux-foundation.org, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        willy@infradead.org, lirongqing@baidu.com, aryabinin@virtuozzo.com
References: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
 <152663295709.5308.12103481076537943325.stgit@localhost.localdomain>
 <20180520072702.5ivoc5qxdbcus4td@esperanza>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <7a5c644d-625e-a01e-a9a7-304eea13d225@virtuozzo.com>
Date: Mon, 21 May 2018 13:16:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180520072702.5ivoc5qxdbcus4td@esperanza>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0202.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::26) To VI1PR0801MB1342.eurprd08.prod.outlook.com
 (2603:10a6:800:3a::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1342;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;3:tu3K9IohxbG0WjRBK+c29AfRn1yDszvf97FMEcpjYW8TN2qugLMEEE69ZUX8uci9lF1qZyGl2RUrahefBSoMGBbP51D0afKt7tgQO331bOX54OEJMxZhbNRnVahEL06kQTVqzeEKfjx5yFlsU/sMyb8sxzWSkxJpQXW1/CnpePpmi9R3YLZb7jZqIRnrCsac8FYtbJqq88Yu9NbwtpeEnxZLM2BdArqQgsxgFjvNeQJ1kAEIgl4gYKBEM3ZWpRA7;25:Yg3gdBd81oqy5Oy2sWRqKkKib8bPzB/LmqJ7A4Xm9sV7tZwEKNP3CE5z8czg6KvGk8+4jMl0wheUb+Y0X3HPxE2aNeebUbR13Kog8Yq3brZZ2OSM5gcowt3hvCZpYpMfCnwKsu2RhrWT44Zt2t4xS5drDuvOWKJPnkozSsqHUHM+eMGYtdYZY56Wpj5h3uM1LAnIT8EsLnEXt2QfMuobkC1T+CFsMZc4vwH5+xd2p8Q7G8l+faUkyeCq7vpPV4+vbKqCbQZEl2/DXfL9LFrCkboQFHANbxpMFrmAZw8/o2rNvqr7kIgthNP0rqb1ATVpPzIPr9qtd+gl15jpIUFgAw==;31:rqHSql6doYGk/di+S11DEGK1yVqweFxxtY1gApi/L+HqrFc7OeDi205f1wp4Ms6Kex7Pq9SRXaRdbWCrcN4m9TVTEprEKMDEm7O1U3c5ovKDHmv7CMtmMhhWQmUXTAYB7nO/AfdLgXnWNOE50zt+TtFxixuCSGvfTKO8J5+d44YBvjLI3u6sQFbsVxeAk4moXUPdqRplyIURH0X3XZwJGxCotR4MtqfJPBCs0ynxRi4=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1342:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;20:L5t/YtxxoJ7x/8DJYhYq7e3vc6Jt22ADa91rSnw6puVMnd6rUlgKHcujmaPdrldDcD63dBCnbcQjbJkvcN3b5FzizXKrCySsm0W205V16ILGKlEe4JY6jVjVLTfRuLdPl+VVB+xIeqwBrOj+z6gM3FtFEH4eSNG5OaMAtHntSPtMO4x5KohE+KPfBS8xBIlvXFr3Pujndf/cmBJHsF9GHpB0JA/QS3aeGS3UpMJfNmGbtFqKsBJrAzcfWujS2wvaYkY8naiKRluGPPrJyEmRDVEbCO+L5AfOUnKE7FB967bzywypHmrjFhyPH3cKgjvrDGmUv7XftoPJb0Tmp9d7dJ+mpt0KRREdwUofMqa+CLeYbfB6o+4990mnTMH/Eg/YdrjpaW6plRAvVLS5CRBC7KyCV1A2njmJanuJ7JQvPuINtNm5kuEZR6HC997FIUZ8icAk4+my2emb+3pAbs7Eotd8iBV9vTCTQ4HzjBURV9WhLt3TXfqBAYL1EMc6fLo7;4:QoKVoMuC+KJ7srDgBF8JW/feiKmI2sHVwjqt8VgNE9gmTdN6o1Nb+QkFN78OsiweUHTNZp2stKyerwB3gQFTULZoWUq5BOZ7e0ZRQKzCFE9+7d4L7kEr+cwV6X9YF3FZCWmZoCJ1PH4zOFcwkJgf/57GtBaxvMiMmHf7Wt6jdNilkZ1iGra7xZuJdn31ygnayODFD0+9c4Nwe0A1+/yISGUHb/4HE2wr+pW3T10FdhdwR5TwY6sOoFzEygK3saZgFv2+6vEab957QX1TW9n1ixXSEsGcNoTOVIBVMUVAXuo+uWa7LxdT7KlbH9bkyt3Gi15CQ2S6CR28NsFUxCVASlN8eM5LxlRTlAitJnoRlE0=
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1342F71A18A40F484249CCA6CD950@VI1PR0801MB1342.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851)(131327999870524);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB1342;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1342;
X-Forefront-PRVS: 06793E740F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39840400004)(346002)(396003)(366004)(39380400002)(376002)(189003)(199004)(39060400002)(105586002)(7736002)(53936002)(478600001)(305945005)(316002)(81156014)(8676002)(229853002)(16576012)(58126008)(106356001)(31686004)(6486002)(64126003)(66066001)(47776003)(4326008)(50466002)(230700001)(65956001)(81166006)(65806001)(8936002)(476003)(68736007)(446003)(6246003)(107886003)(6916009)(11346002)(97736004)(956004)(486006)(2616005)(25786009)(36756003)(3846002)(7416002)(26005)(386003)(31696002)(53546011)(23676004)(59450400001)(52146003)(2486003)(5660300001)(76176011)(16526019)(6116002)(86362001)(65826007)(52116002)(77096007)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1342;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDI7MjM6RGpHKzd3Nkh3WUZyT294R0lVUE5nZWps?=
 =?utf-8?B?MDFxaG9EWEdwRU1iamM5TE1IQVBseENxd21Yc1IwUmhid2t4aXk3ZlA0TzZk?=
 =?utf-8?B?MU5HZ2J6U0FMQ0g2Y1ZYK2ZVQVBoT1VsU3FKdVBpeHBLaUtMMXlsSGZPTDRp?=
 =?utf-8?B?b3pDNHQ2QVpzWnY5MmQyK2RwRGF6eXlObzVBY2VZbHhEeDdZY2xIcE0vazNJ?=
 =?utf-8?B?cVVzbWlaMStWM0VuVFpZMFRwZlNGM2tmNmpiRW5XV2ZpeGRnbGlYWjJIc2tH?=
 =?utf-8?B?TFNCalA3dVVRbUdWK3JMemVMaTBnUHJvY0EycXh5aTlsSHQ1eUhhY0lIVkNq?=
 =?utf-8?B?QldXaThPWEJCSVBuU05CaWY5TG90d3hjOTFBN2dPNTJqZHpMYThJU0dTNFFK?=
 =?utf-8?B?RDFXcTF2clBWN2k2TC9IS0ZNbXR5VWt3aWJPdjZuYXFGcVl6c3dtQmxlcDVN?=
 =?utf-8?B?Nkh1SW5VOVNsRlhZazN4L2I0RG4zZ0hMZzhLZFRmNGtIVHdHMjRHYnZMUXhQ?=
 =?utf-8?B?TzJvR2N1VitqUmdCdXNvYmIyeCtzQzZCUURsdXdiWU9VemFlazR5eUN6UVFI?=
 =?utf-8?B?OEpuei9OdXU2NmpmYjg3WHJMVEdpSFVJSG9IYy9saFBZZFl6VFpEall3SkZE?=
 =?utf-8?B?bHdpdm1HUlZzUzNQckxMOGs1cXAzUWlpN0p0eXdFeFdHUVB6eHVhT0g4cWE4?=
 =?utf-8?B?Nk5aVnpsT3pNRndENm1idTVBSytZSGw0V3hKVGM4VzdsSzU5aTd0dTRWVTRF?=
 =?utf-8?B?c0hiSlRUdmZLT3VONUdLc0hRM0NCN28zd1JTTTRRYzl2RGFLWVk3Sk9RNkN5?=
 =?utf-8?B?S2RnZ213UEF6NWxPUEpuRkFYRitPa1NBUGwzRVBORi8rcTdSMUN2UzlhUm12?=
 =?utf-8?B?WHVLTHpUNDA2bkJYaS9NY1VxOGZ2Y2pwdUd3VE1xcXB1WGJBTkI0ckFXd2l2?=
 =?utf-8?B?UHZCRGxaYVEzRU9RQXZwbzhlTXB0UlZabmErZEluVmR3bEJlMHVsbUNGeXhB?=
 =?utf-8?B?dWFXUGhZOTlJUjhXRHREUkxZZzN0Qmd3ckxFVVB3US8yZ2lpaEozT053cklW?=
 =?utf-8?B?ejlEcENVcStkYXVzTHgyT2kwZXI5T1JsQVBuS1p2cDZMWHpCVVVMQ3pxanY4?=
 =?utf-8?B?aFRxb2c5MGQ5ZjltbjJjeWc3Q0FrT0FjK2gzRXpQamZqOVRCUDNNUlNiOEp0?=
 =?utf-8?B?dWVOUW5RYTZxQkdQaDRqazROMGg2ckNWRlB3UHB6akE5Y0xSTklwb2lGT0JS?=
 =?utf-8?B?WlFSbFJuNS9lK0JrN2FOMXFDWWtLWDFITFgxU3JhWmMwUGFsdE84T3RaaFd4?=
 =?utf-8?B?S2NheDBlOGN3TnVobjhHeHplQmJkM2lXSm9lZTIrc01LL203S1pQQnhiUkhp?=
 =?utf-8?B?U0pNRFgvRTIxeFg4dkZYdVNVL0lPRml1R0R3Z0J6bGU2dTQweVJlb1FNV2ZB?=
 =?utf-8?B?MGFXRXlyc2EvanBVcWJHdFUvc0hGcDdSRmsvTldjR2ozSVhRRlNoUjZhY09B?=
 =?utf-8?B?ZTBESFFnYk9ZUEJKYUYrb28zV0pCSFA3S0VINDFMeWhENE9Gbm9aT3diRjJQ?=
 =?utf-8?B?NXJXV0F1Vm9pN2toSVpkK3ZBbEE1RWVCZDBkb0ovRVR6OHRJc0pmWlM0VGVs?=
 =?utf-8?B?Y3VSQmlZOE9IaGlTMjRlZTZhb1FWek5OWVdCa3lCVFRtT1NFbnhrT1NpYUo4?=
 =?utf-8?B?ek10S0cvS2ZnWHVjK0JFYXdxWUlHL29CSWVXcDFrc0YzOUJDRjRzL3FJLzhY?=
 =?utf-8?B?czJLTVV2czltdlowWHlIZWR2Y3NOaTgwQkk2a3pGNng4UXNJK3hZU1BzejJp?=
 =?utf-8?B?SzNjMlQ1ME5OL2dlb3ozQzh0N2FFMXlwa0gwQW5ZOWRneEVTMGVBczljemU1?=
 =?utf-8?B?dlFyeW1Xd08zK0lpdjJJSlZ4VlF3VXdnOTdkY0EzQndmUEE0RzBnUnpBQWUx?=
 =?utf-8?B?VG5MSHRRdENabzZ4WDVadG9rM2lmdDVJV3FLVnFQM2pMdW5TcU1mL2ZFd1d6?=
 =?utf-8?Q?xL0VrkpJ?=
X-Microsoft-Antispam-Message-Info: e9q+Rd13L8vMl4kKWoMNKZqon7RnFt+F75A++lInCi8S+5DH7Jj7eMwwh/EuvOE/4ZPWVdJc6ATHPd8SOZwjwQVpLp9mIetIKLu31+VOiX55wc8NgUfP13oZ28SIcOOV23fG/l35SE7U3evSJWgUo+sp50HzXyVKJ++uzkSZ3zE5PXcBvhIY1ercnbcVs0ub
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;6:6EFwLPWu1zAjFhnhWzzqOCjTIGZUfrxUE9S2WkzNw+UdGigWYaXTG9QYsTe2oXGvBZBHksiNH/npUlLAtFH/n973RgVMfJNMqlTlJOYJKLJ7hxyNvuLH+8FIHJ+71xm4v0cxWwXcSKiSbWhNp/DCl4iOMJKfnGPFRi0Tk39Dhm9qvD1LglusZXEU5OshTp9jdqUHE+RDd079ewLZe86S9TUmMBpSKdtfQYc/C7RcJC83I+6/xqzXKbLg/x6RNj75TGd+6oqzkdBVVX387NhS5gLBNoc88XzvTtpxbg2/txSFaARgZ8no/+JMUU/Ae/TOsfs0zgtbbzxt8MB1XR9xnzNdYfkMYA+CaBAM6WruqoblQTGPlV9HfkxzOKYfwPneFZatr10cm6QtD44xMWv7c7CJPnyPgIWOs8+JJbWO2baZFYZfmUjZ/jBJhYfDTq5k8d2JY6clfThhifnHLrAqxQ==;5:+Ukxu3Oemeay8teeeMDlxtQl4uabg2bygCs19KZC1OXYQQXXIzc3aHrz8AM9i+e6uugDzhwjt1AYh0DukQISHuU1F4sYsGv8uN0tHgZLogureaz0Av8/6ibehlAmR7pvU9BSrJEMnCNJZIrhuRVrVrj90aqR+csmfRL4P/zgslo=;24:g5y1wOUklFxHZFhE4UzoHF7ZiCcTJH2RhxwOhvqiyJLVz1CRCN7o4hQSROUJroX8YYd7FBlF5Wr61PbJ/3NM2A/tiZrKoF68oJwO/ECo0Xo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;7:90TF9ha6nCbdZkOmYT/BnheEMF2nOkOyRKLrK6jpybJp+HGF1Qh0U2x0CdZ++T2rSnPSAkVxO7Em7jGnRndamoQqhlwUgiWYliKPfBfrWdqK0wkJ9WOPtQWLtv8suK/HHzP7EWRfYExLxs6ztS47/hoyftKAvLO5uoVG7Bc0vENbPYza6MyKWDjt0hhnsNy7vE6M55wvFIlYyZuhoCR+9mUVplDxecEinSLRVhr1elvFmedQQTRULlMl3/++UAch;20:P4p2ldZIVuUPbjIIzjH+ZgTn1xojnQxSdqpII4ITFNA851GydktFSkUmPmD/IFOOOewSk8QccBane1llfi2SuSKPfAZ0zIVM5u2/YuY8wJtLNdGxHBS9kG9u0ipvd3nXjRNaqXOwFvdBl6aYrBNiNFG0WmlfWLy5YKBsBwQfhiU=
X-MS-Office365-Filtering-Correlation-Id: a5c72c4d-53a6-4609-0941-08d5bf03f4b5
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2018 10:16:43.5354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c72c4d-53a6-4609-0941-08d5bf03f4b5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1342
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.05.2018 10:27, Vladimir Davydov wrote:
> On Fri, May 18, 2018 at 11:42:37AM +0300, Kirill Tkhai wrote:
>> Imagine a big node with many cpus, memory cgroups and containers.
>> Let we have 200 containers, every container has 10 mounts,
>> and 10 cgroups. All container tasks don't touch foreign
>> containers mounts. If there is intensive pages write,
>> and global reclaim happens, a writing task has to iterate
>> over all memcgs to shrink slab, before it's able to go
>> to shrink_page_list().
>>
>> Iteration over all the memcg slabs is very expensive:
>> the task has to visit 200 * 10 = 2000 shrinkers
>> for every memcg, and since there are 2000 memcgs,
>> the total calls are 2000 * 2000 = 4000000.
>>
>> So, the shrinker makes 4 million do_shrink_slab() calls
>> just to try to isolate SWAP_CLUSTER_MAX pages in one
>> of the actively writing memcg via shrink_page_list().
>> I've observed a node spending almost 100% in kernel,
>> making useless iteration over already shrinked slab.
>>
>> This patch adds bitmap of memcg-aware shrinkers to memcg.
>> The size of the bitmap depends on bitmap_nr_ids, and during
>> memcg life it's maintained to be enough to fit bitmap_nr_ids
>> shrinkers. Every bit in the map is related to corresponding
>> shrinker id.
>>
>> Next patches will maintain set bit only for really charged
>> memcg. This will allow shrink_slab() to increase its
>> performance in significant way. See the last patch for
>> the numbers.
>>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> ---
>>  include/linux/memcontrol.h |   14 +++++
>>  mm/memcontrol.c            |  120 ++++++++++++++++++++++++++++++++++++++++++++
>>  mm/vmscan.c                |   10 ++++
>>  3 files changed, 144 insertions(+)
>>
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index 996469bc2b82..e51c6e953d7a 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -112,6 +112,15 @@ struct lruvec_stat {
>>  	long count[NR_VM_NODE_STAT_ITEMS];
>>  };
>>  
>> +/*
>> + * Bitmap of shrinker::id corresponding to memcg-aware shrinkers,
>> + * which have elements charged to this memcg.
>> + */
>> +struct memcg_shrinker_map {
>> +	struct rcu_head rcu;
>> +	unsigned long map[0];
>> +};
>> +
>>  /*
>>   * per-zone information in memory controller.
>>   */
>> @@ -125,6 +134,9 @@ struct mem_cgroup_per_node {
>>  
>>  	struct mem_cgroup_reclaim_iter	iter[DEF_PRIORITY + 1];
>>  
>> +#ifdef CONFIG_MEMCG_KMEM
>> +	struct memcg_shrinker_map __rcu	*shrinker_map;
>> +#endif
>>  	struct rb_node		tree_node;	/* RB tree node */
>>  	unsigned long		usage_in_excess;/* Set to the value by which */
>>  						/* the soft limit is exceeded*/
>> @@ -1261,6 +1273,8 @@ static inline int memcg_cache_id(struct mem_cgroup *memcg)
>>  	return memcg ? memcg->kmemcg_id : -1;
>>  }
>>  
>> +extern int memcg_expand_shrinker_maps(int new_id);
>> +
>>  #else
>>  #define for_each_memcg_cache_index(_idx)	\
>>  	for (; NULL; )
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 023a1e9c900e..317a72137b95 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -320,6 +320,120 @@ EXPORT_SYMBOL(memcg_kmem_enabled_key);
>>  
>>  struct workqueue_struct *memcg_kmem_cache_wq;
>>  
>> +static int memcg_shrinker_map_size;
>> +static DEFINE_MUTEX(memcg_shrinker_map_mutex);
>> +
>> +static void memcg_free_shrinker_map_rcu(struct rcu_head *head)
>> +{
>> +	kvfree(container_of(head, struct memcg_shrinker_map, rcu));
>> +}
>> +
>> +static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
>> +					 int size, int old_size)
> 
> Nit: No point in passing old_size here. You can instead use
> memcg_shrinker_map_size directly.

This is made for the readability. All the actions with global variable
is made in the same function -- memcg_expand_shrinker_maps(), all
the actions with local variables are also in the same -- memcg_expand_one_shrinker_map().
Accessing memcg_shrinker_map_size in memcg_expand_one_shrinker_map()
looks not intuitive and breaks modularity. 

>> +{
>> +	struct memcg_shrinker_map *new, *old;
>> +	int nid;
>> +
>> +	lockdep_assert_held(&memcg_shrinker_map_mutex);
>> +
>> +	for_each_node(nid) {
>> +		old = rcu_dereference_protected(
>> +				memcg->nodeinfo[nid]->shrinker_map, true);
> 
> Nit: Sometimes you use mem_cgroup_nodeinfo() helper, sometimes you
> access mem_cgorup->nodeinfo directly. Please, be consistent.

Ok, will change.
 
>> +		/* Not yet online memcg */
>> +		if (!old)
>> +			return 0;
>> +
>> +		new = kvmalloc(sizeof(*new) + size, GFP_KERNEL);
>> +		if (!new)
>> +			return -ENOMEM;
>> +
>> +		/* Set all old bits, clear all new bits */
>> +		memset(new->map, (int)0xff, old_size);
>> +		memset((void *)new->map + old_size, 0, size - old_size);
>> +
>> +		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, new);
>> +		if (old)
>> +			call_rcu(&old->rcu, memcg_free_shrinker_map_rcu);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void memcg_free_shrinker_maps(struct mem_cgroup *memcg)
>> +{
>> +	struct mem_cgroup_per_node *pn;
>> +	struct memcg_shrinker_map *map;
>> +	int nid;
>> +
>> +	if (mem_cgroup_is_root(memcg))
>> +		return;
>> +
>> +	for_each_node(nid) {
>> +		pn = mem_cgroup_nodeinfo(memcg, nid);
>> +		map = rcu_dereference_protected(pn->shrinker_map, true);
>> +		if (map)
>> +			kvfree(map);
>> +		rcu_assign_pointer(pn->shrinker_map, NULL);
>> +	}
>> +}
>> +
>> +static int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
>> +{
>> +	struct memcg_shrinker_map *map;
>> +	int nid, size, ret = 0;
>> +
>> +	if (mem_cgroup_is_root(memcg))
>> +		return 0;
>> +
>> +	mutex_lock(&memcg_shrinker_map_mutex);
>> +	size = memcg_shrinker_map_size;
>> +	for_each_node(nid) {
>> +		map = kvzalloc(sizeof(*map) + size, GFP_KERNEL);
>> +		if (!map) {
> 
>> +			memcg_free_shrinker_maps(memcg);
> 
> Nit: Please don't call this function under the mutex as it isn't
> necessary. Set 'ret', break the loop, then check 'ret' after releasing
> the mutex, and call memcg_free_shrinker_maps() if it's not 0.

No, it must be called under the mutex. See the race with memcg_expand_one_shrinker_map().
NULL maps are not expanded, and this is the indicator we use to differ memcg, which is
not completely online. If the allocations in memcg_alloc_shrinker_maps() fail at nid == 1,
then freeing of nid == 0 can race with expanding.
 
>> +			ret = -ENOMEM;
>> +			break;
>> +		}
>> +		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, map);
>> +	}
>> +	mutex_unlock(&memcg_shrinker_map_mutex);
>> +
>> +	return ret;
>> +}
>> +
>> +int memcg_expand_shrinker_maps(int nr)
> 
> Nit: Please pass the new shrinker id to this function, not the max
> number of shrinkers out there - this will look more intuitive. And
> please add a comment to this function. Something like:
> 
>   Make sure memcg shrinker maps can store the given shrinker id.
>   Expand the maps if necessary.
> 
>> +{
>> +	int size, old_size, ret = 0;
>> +	struct mem_cgroup *memcg;
>> +
>> +	size = DIV_ROUND_UP(nr, BITS_PER_BYTE);
> 
> Note, this will turn into DIV_ROUND_UP(id + 1, BITS_PER_BYTE) then.
> 
>> +	old_size = memcg_shrinker_map_size;
> 
> Nit: old_size won't be needed if you make memcg_expand_one_shrinker_map
> use memcg_shrinker_map_size directly.

This is made deliberately. Please, see above.

>> +	if (size <= old_size)
>> +		return 0;
>> +
>> +	mutex_lock(&memcg_shrinker_map_mutex);
>> +	if (!root_mem_cgroup)
>> +		goto unlock;
>> +
>> +	for_each_mem_cgroup(memcg) {
>> +		if (mem_cgroup_is_root(memcg))
>> +			continue;
>> +		ret = memcg_expand_one_shrinker_map(memcg, size, old_size);
>> +		if (ret)
>> +			goto unlock;
>> +	}
>> +unlock:
>> +	if (!ret)
>> +		memcg_shrinker_map_size = size;
>> +	mutex_unlock(&memcg_shrinker_map_mutex);
>> +	return ret;
>> +}
>> +#else /* CONFIG_MEMCG_KMEM */
>> +static int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
>> +{
>> +	return 0;
>> +}
>> +static void memcg_free_shrinker_maps(struct mem_cgroup *memcg) { }
>>  #endif /* CONFIG_MEMCG_KMEM */
>>  
>>  /**
>> @@ -4482,6 +4596,11 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
>>  {
>>  	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
>>  
>> +	if (memcg_alloc_shrinker_maps(memcg)) {
>> +		mem_cgroup_id_remove(memcg);
>> +		return -ENOMEM;
>> +	}
>> +
>>  	/* Online state pins memcg ID, memcg ID pins CSS */
>>  	atomic_set(&memcg->id.ref, 1);
>>  	css_get(css);
>> @@ -4534,6 +4653,7 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
>>  	vmpressure_cleanup(&memcg->vmpressure);
>>  	cancel_work_sync(&memcg->high_work);
>>  	mem_cgroup_remove_from_trees(memcg);
>> +	memcg_free_shrinker_maps(memcg);
>>  	memcg_free_kmem(memcg);
>>  	mem_cgroup_free(memcg);
>>  }
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 3de12a9bdf85..f09ea20d7270 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -171,6 +171,7 @@ static DECLARE_RWSEM(shrinker_rwsem);
>>  
>>  #ifdef CONFIG_MEMCG_KMEM
>>  static DEFINE_IDR(shrinker_idr);
> 
>> +static int memcg_shrinker_nr_max;
> 
> Nit: Please rename it to shrinker_id_max and make it store max shrinker
> id, not the max number shrinkers that have ever been allocated. This
> will make it easier to understand IMO.
>
> Also, this variable doesn't belong to this patch as you don't really
> need it to expaned mem cgroup maps. Let's please move it to patch 3
> (the one that introduces shrinker_idr).
> 
>>  
>>  static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>>  {
>> @@ -181,6 +182,15 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>>  	ret = id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
>>  	if (ret < 0)
>>  		goto unlock;
> 
>> +
>> +	if (id >= memcg_shrinker_nr_max) {
>> +		if (memcg_expand_shrinker_maps(id + 1)) {
>> +			idr_remove(&shrinker_idr, id);
>> +			goto unlock;
>> +		}
>> +		memcg_shrinker_nr_max = id + 1;
>> +	}
>> +
> 
> Then we'll have here:
> 
> 	if (memcg_expaned_shrinker_maps(id)) {
> 		idr_remove(shrinker_idr, id);
> 		goto unlock;
> 	}
> 
> and from patch 3:
> 
> 	shrinker_id_max = MAX(shrinker_id_max, id);

So, shrinker_id_max contains "the max number shrinkers that have ever been allocated" minus 1.
The only difference to existing logic is "minus 1", which will be needed to reflect in
shrink_slab_memcg()->for_each_set_bit()...

To have "minus 1" instead of "not to have minus 1" looks a little subjective.

> 
>>  	shrinker->id = id;
>>  	ret = 0;
>>  unlock:
>>

Thanks,
Kirill
