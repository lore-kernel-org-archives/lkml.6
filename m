Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933068AbeCOQGi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:06:38 -0400
Received: from mail-db5eur01on0111.outbound.protection.outlook.com ([104.47.2.111]:4096
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932397AbeCOQGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:06:34 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH RFC] xfs, memcg: Call xfs_fs_nr_cached_objects() only in
 case of global reclaim
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
References: <152112607662.7371.16175767692798928059.stgit@localhost.localdomain>
 <20180315155316.GY4865@magnolia>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <782fbe3a-4025-16f7-bfae-424e1bc6f073@virtuozzo.com>
Date: Thu, 15 Mar 2018 19:06:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315155316.GY4865@magnolia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0101CA0012.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::22) To VI1PR0801MB1342.eurprd08.prod.outlook.com
 (2603:10a6:800:3a::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72e760c2-41a3-4fbd-84cd-08d58a8eb650
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1342;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;3:aFVtx8u410mP4EPrFm/UCiDuhplM99bpjcoOZAM/J9S+QVozR5MHDCbgDguI80mnW6Jql72w/T3ptpdQCAyMjYUSIb9oAx8aEoC+/JNKcprvxXl7JmPkqunED02Kek0jvn/bLX5immjOEH5VkHAwUu5/XcGzzuO5054JappyC+/Ohr8kgujqn1534/PY/dRCrfEminEPrPbXYZXLBdCl3wuLqAUof7iBvLXPj4tdxaXEmnmymduBQpeLMUUYD23u;25:1j4CxXbTrocpsb18kPFbDz1gbh6OMebWOx1yjnynftejq3fTdKIBTtk27EW/6N5lJQZS//vHiP63r0ofQoHEFoh8cBjC6tQVsFg1bLWTwzcKj/mvyG4JKIDusoNKmPZcD14BxdNdNGB01ZEdK/W/PaVW1vgle4D4byulxBXNyBFOxgV1kE9x2dZW5kUtE7IppJ6iwuGTRoyRevDzNvia2dR7TlednZMCtsGT9M7HXx9igOV7Li1Y9OX2IS+aboNMDzqv5sQOJ1dxFf6rnqPyPySXfsp354i+NxiKvjpBd7BlYM+/KZ3PBKJDMboJKiuHHQHNjC5txn2WcyV6LSeR7A==;31:4CfHPMJBJbrB7ZeT9r9/se8q7MSMXkd7KRxpG6g5FXec0+JGIATutSPqyWay4mfv9iStyP5aYbKpZPVqxlOKdVe4fpTcF5Rmf20AzyXUfJayX0CaA5DoWeCYk1hFU2ZyUY0SUUad2bEOkXczn65o+VC1ASbMix7NZZ6nai8xQeI027K9HBoYoSA58+bfIf3zAM9tSsxhWsqGV2yaITkgaSPHxlw9PhvdWB7PwF96QVQ=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1342:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;20:CL2F+ZVfzSdkolyDQZZWGovbYBCfv0Zx70Dl3VApB+UPccmhst7p1xIwaBjY4U8fJzMz7t1c45bgn97hHAXXLvd7EGjCgq12bOdcpxS7qS21FFabTBF2ew6RcOylASJogUzbsr356Kb88HRuwspIS7qmwNR3Qv4s26dwDBaASW6ZCedLbaT1iDhh0JMIwoSShLIA/mljJOkBNj8BC8bmv/ERsa3JWyJ1RwcJ7YlMsdk3egpB4HYYbVsv7Zpx7JZYCJdoxxzallypJ3tCvF74rmn2e2TCc+MvyGHrNRJR4ontT0ZwfDSH/EvLdm+jLifqCU/v2blSJ5Z6rhmMN4ck/iv0+QHTRu36VMMxwPiuyRsJtrHyogtnDWD2JHmBnr8QHlWWHagQGpf230g1kslcqhX6slTP1rEIFH1s4suHLZvZCJN91bBKy5YPR/nWxdEaW5htXjl1j1FcBN+V34kKUm6HuyA5a1bwRbioOeNT8mLgtQHpQ5SJCvJv3J5+Y/2f;4:0sp+BHFHBW7SD8rkrM3Ggv+vR6FKMt9XE9x6Zf9SDK2cT+0AviKW/LysL2hGLoDy8gtuOC7FgDP5oy22d9Xt0MCY7Ha5AtmJN9Z9PqCyVTF2oSIMUckgBfZmIfQQOTXjJRQbyd4RNGwxOnUHwMrR4KXWLblX88k4FaUYtpTadtlY8qMOU+3ULXCbJmzlZvzqkUSehTDs2IGBO3G6QERpMr8xSDZSFlfhrnMwzZKRZMIY8qovWcAzS0LgzGrSHxxa4NTj8CUYDcuoMv4yYrFO/2WRgN7ugVWGKE+bCrhsA8TACcbeuV3+0yhNHV9Fy5I5ds6N3+p8AAZh4NptWUexgvmB+izW/fWITS6iX5Rc+kI=
X-Microsoft-Antispam-PRVS: <VI1PR0801MB13422CA0A8893F26135AA441CDD00@VI1PR0801MB1342.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(211171220733660);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR0801MB1342;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1342;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(346002)(39850400004)(39380400002)(376002)(396003)(189003)(199004)(7736002)(2906002)(2950100002)(4326008)(25786009)(31686004)(478600001)(65806001)(68736007)(8676002)(64126003)(65956001)(47776003)(66066001)(59450400001)(386003)(26005)(86362001)(97736004)(53546011)(316002)(31696002)(105586002)(966005)(55236004)(77096007)(186003)(50466002)(36756003)(52146003)(6306002)(58126008)(230700001)(8936002)(2486003)(5660300001)(23676004)(6666003)(52116002)(76176011)(6246003)(65826007)(81156014)(81166006)(6916009)(305945005)(3846002)(16526019)(6486002)(53936002)(106356001)(16576012)(229853002)(6116002)(422495003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1342;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDI7MjM6OUlDWEdhbzlRMDd2SlkxV0lpSVZqK0RQ?=
 =?utf-8?B?T2VxM243OVg3OWJXYktYMndUT1N3b0lqWTBoblJPbllyaldTcDNQUFovZk1x?=
 =?utf-8?B?RDAzYU5tS3FJaVRuMkJ3azFoVmRZVlcvMUEyMlV2Ui9SY1dXQUc3VENXNGlT?=
 =?utf-8?B?TjNNZVUwNFZ4clNrYUFWU0ZEUUNTbkJreEE2QW1GZmZsMmtLWTlva3hKb04r?=
 =?utf-8?B?UU14YXZ5R2RKaklkYWY0VHJsUDF5QTFENzFpdDB6clRCRXNoNkFNTTFHOXZQ?=
 =?utf-8?B?Q2o4dlJweEcwZVdpS2diZWNEZkhwVVdlRkRDWVgxS3ovNVk2VlVPeEdXYlNq?=
 =?utf-8?B?SGZUOWlHcFg3MWRoV1QxOFBoeEVQVEtBcXZ1RzcrR2xtejlYS3lvbVo4STBT?=
 =?utf-8?B?TUp0SlJybCtzSzRkcTM2ZVhmVjVoaUxNZC9TSGJTQzRRZ01NMW1CRmEzOHhE?=
 =?utf-8?B?OEpLaHJBZ0wrVmlaZTErUHdvSnZINkJUY0ZsbjgwUXdvWnI5TEhsOVRkcU5Y?=
 =?utf-8?B?Y0lUZkIvd2VJWmdwNE8rNUpPNDQrc1lSRzBhQlhQTnFKWkNrc2lFL3k4U2Np?=
 =?utf-8?B?TWxySlA0NERUa1ZGT3ZtZnJYcitqNkpsbE82emQ3SVI3STJVOHN0TDM1WlI4?=
 =?utf-8?B?RFVQWnFXanBZems2WFdIQlh2N3NZd0R6VXhSRDVBZS9nS2hWd3BuVXBCQlF5?=
 =?utf-8?B?YXRSd2xlYUVtd1FFZmo4WjhuTElsWHhPd0JyalM5Y2x2NXIyaDB1NVh0K1dB?=
 =?utf-8?B?OUZCaUxzOVMwdDArQ0FJTkd0L1JLSVIwZk5lYVBVclRucFo1dnI3MHhQbHpW?=
 =?utf-8?B?VlJVdlBEeisvazNyeFBYeDlmdUthM005bWxLV1VlWERrM3lvNEFqQ1Z1Um4v?=
 =?utf-8?B?dnNzU2dNM2dlQnJ3Mks2OVN2QUE1bzVaNnFFQzRGMUFFc1pHcHVTSmJaOFFp?=
 =?utf-8?B?RW5PZlJyRjRGYiszSGRTWit5cnVucVNZZUtKZWFxK3RYTjRGTndTZ3VIbEdQ?=
 =?utf-8?B?azJkdSt3clhNUVl2ZVoveXFIVWtpTks5ak1ZTzlvTldWL1EyZGNWZkNMdnRL?=
 =?utf-8?B?ZzBJaWlJRDlnWHZoVW5Ec2ZTbEtaN3BSQXdONVRLZStjWkdaUWpnVktsNzRG?=
 =?utf-8?B?WlhrU2FOekNGYk9VVnZhem01TVFPSHlHMjdkS0pqTVAxL0lKcWdTbnFqT2xO?=
 =?utf-8?B?RFF4ejB2QW91VER5Nm1nRlVISXF0dnBoWmlDbmZ1M2pOczQ4M3Fzb2NoTnZj?=
 =?utf-8?B?Z05RdXlrUThkNGJueHBxb1BjZ1NtbXFPcFpEMXFobDhaUUdCL0FWT3RMc3VV?=
 =?utf-8?B?cEQvZjhnNHlGUmtWb0REMVZMTVdrRmZjS1oxZXJPemtMVDNBbW1QTDVjdUdi?=
 =?utf-8?B?R2lDYVR1R2hQOElUSThwd3J4YkphZE1LeGEzZnhSNzZKY3pteEtCcU5sYm82?=
 =?utf-8?B?Y2ViV0ZPSnhjYi9CemZwUEVyR1U1c3Z5Ums4ckhwSU1wOE03eUVYUEJJdWtZ?=
 =?utf-8?B?TEw2S2QzZGhBTVNrWHVFNXpnSXZUM3dzRnVxazdBSnA5Qll2cmFLNXVYaUtx?=
 =?utf-8?B?REZsVHh5L1pLQzJ2a1NVTDdGUldCTXU2UTNGcEJVNTU0bHYrYThXK1FFeTRE?=
 =?utf-8?B?cHYzbWpDUDZCUFlQeGJOdjNWUTVuQTNyeFQ0UmtmdXVUSXg0TE9rcmVQRWZs?=
 =?utf-8?B?L1cwR25QYlF4UFFvYnExVW9CdUNteFZGZ3NXdlVTUWJpbEJRMnFNUkxOR0hr?=
 =?utf-8?B?bVlDZVFFcm96WXVqd2tmT3hyQXJGRDZqRmxwYytFWFVzZVlpbHRmd29VRWlr?=
 =?utf-8?B?OTZIeDNzNUl5V1JNL3pNeUsrTVY3ZFQ2T3RTTkZ1bnVNZWthenYwT2VpakhW?=
 =?utf-8?B?a3NVQk9wVE42YStENE9qZGx5RUZxcWxDQTZ1TVBGVFUwMEc5amtibGgwTENW?=
 =?utf-8?Q?6l8E1S2HGzgX0qAg7xw+dZZyPjqYhc2g=3D?=
X-Microsoft-Antispam-Message-Info: kzvV5ZL/KtfjtmqVVnp6fnT+e43ButLtDl4EvyGJz8JEGwktcKP9/CFTCftC9XAWG9Y2wyMEY71/dBEXTMZjUsznBdFe4o/C1V5Z1rBHOS14+dH3Pbo4EQi6cwWEzyf3ZrTsxl6CxmC71a70CS0ck+gJfSj8km2jRFUpRro1Zq9zvml0D7tEiDKJME5srubk
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;6:eWc/yugQqSLfFY/Nngkr6xmfGc2XTkuEVBcH3Ce4kaVFfszUxDgSfufOSomdcBwgG3GI1BpOKz4kqMr8lJ5owOQ06oT0yXwpWxltKQgOB3Q422uIozwT247OgAi0ovIGr1mxv2L29bbon4M9QVuKZ13qzr3Ezo8pFB40oVxrM707cZezSotj7Ys1fDoqOtYTnkIsnm86YSb3xGBAdCo8FQaHWYx6Q5ZdQV8fFpVRaIiu5IIb4yEKGe/fsd4ZDSxLS1JR4YFfxmkMfbp5ZtgZp8S1TzrD1yPNkcgsy2KMuPPGIISu0/XuUB7MRppgdMbm47a0+1jDu6lBQZtGNoFAW/QTrB3T/wEnqSGeQ7ggGFY=;5:PjNHIN5otmm/yOdqaZyI5xVCc0CGts7bbNAseJfoi0FIXRcVsX3sIQUAJTK342DHD8U3L0FP8DnCTQ79ZkU2pNFbbkuTV+btwo4xIikwso1udop3GLW4Q0if2j4NBt9xiiI5sCQEnzuIYTnq8K3u8/mmalxIl4iS1QHVdCrnm/s=;24:/ki3tvAEqMQS5nMGo/BFLiezlRoKmMyb47Wr6nzRreeFN3u7Bue9uSIH3Oyrlgg38jfNL/nzqP7VHrGUDKqw8Cm6PQps11lWtQVweIqzmwY=;7:lkRnkbENiSFvLaREpWuDISIfNrtKS7x9wN54WTTFeT/FtrP1hfWpwJz0ebySsY/k49zyRrTNX7XP4Vc9zYJjV+uvB+quVvpyCwipfRYBTM2vdJBmtp69Oc/INdmou7usRcyGm0jAxdoWNnGM6BNOB11jx2q+uE7DTCoBypFn4VnnIQg1FsKqzOq4I43ltYWuzeEeNeVO2NeBs46JYc3Xx019c4jE1FT287BY8NrFTn5UMBprEQ3ySdks1s5sF1rF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;20:mcsfssKD+7gsACr/F0TipfSPqG+TAUiwlN54jiDYM8lHDXV+vclx2RorobUXGpOm59rKO4E0ZW5cNz0FtJ4M/vtlpmPijHn9ThsgtQUoLAiSP7PG4B5DQ+Ww542uKP8OJuyk+mvpU0TbTsF2VZkILrs06IKoinbdH9WAkjMNd+g=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 16:06:28.7293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e760c2-41a3-4fbd-84cd-08d58a8eb650
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1342
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.2018 18:53, Darrick J. Wong wrote:
> On Thu, Mar 15, 2018 at 06:01:34PM +0300, Kirill Tkhai wrote:
>> xfs_reclaim_inodes_count(XFS_M(sb)) does not care about memcg.
>> So, it's called for memcg reclaim too, e.g. this list is shrinked
>> disproportionality to another lists.
>>
>> This looks confusing, so I'm reporting about this.
>> Consider this patch as RFC.
> 
> So... I think the reasoning here is that xfs doesn't allocate inodes on
> behalf of any particular memcg (or put another way the cost of the
> inodes is shared by everything in the system) so if the shrinkers get
> called because a particular memcg is bumping up against its limits it
> makes no sense to try to purge xfs inodes?

Yes, since shrinking xfs cached objects doesn't free memcg kmem.
 
> Followup questions: does the same reasoning apply to the xfs buffer and
> quota shrinkers?

It's not need, as these shrinker don't have SHRINKER_MEMCG_AWARE flag.
So, they are called only in case of global reclaim (memcg == NULL).

But they may require another type of change. They use list_lru,
so they may need to have SHRINKER_MEMCG_AWARE flag. This is depends
on how objects linked to xfs_buftarg::bt_lru and xfs_quotainfo::qi_lru
are allocated. If they are accounted to memcg (i.e., use GFP_ACCOUNT
flag in their kmalloc/slab alloc/etc), they have to have this flag.
Ideally, all user initiated allocations should be made with this flag.

If they already use GFP_ACCOUNT while shrinker is not marked as SHRINKER_MEMCG_AWARE,
it never shrinks objects related to memcgs.

> Do any filesystems associate their metadata memory
> allocations with a specific memcg?  If not, why not put this in
> super_cache_{scan,count}?

They do, since generic super_cache_{scan,count} have a deal with sb's s_dentry_lru
and s_inode_lru, and use list lru, which supports memcg accounting.
 
> --D
> 
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> ---
>>  fs/xfs/xfs_super.c |    2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
>> index 951271f57d00..124568aefa94 100644
>> --- a/fs/xfs/xfs_super.c
>> +++ b/fs/xfs/xfs_super.c
>> @@ -1788,6 +1788,8 @@ xfs_fs_nr_cached_objects(
>>  	struct super_block	*sb,
>>  	struct shrink_control	*sc)
>>  {
>> +	if (sc->memcg)
>> +		return 0;
>>  	return xfs_reclaim_inodes_count(XFS_M(sb));
>>  }
>>  
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-xfs" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
