Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752757AbeCOT25 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:28:57 -0400
Received: from mail-eopbgr00102.outbound.protection.outlook.com ([40.107.0.102]:50493
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751414AbeCOT2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:28:55 -0400
Subject: Re: [PATCH RFC] xfs, memcg: Call xfs_fs_nr_cached_objects() only in
 case of global reclaim
To: Michal Hocko <mhocko@kernel.org>
Cc: darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
References: <152112607662.7371.16175767692798928059.stgit@localhost.localdomain>
 <20180315174903.GM23100@dhcp22.suse.cz>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <c6a9bf24-50e6-8e60-94af-28e99c51f516@virtuozzo.com>
Date: Thu, 15 Mar 2018 22:28:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180315174903.GM23100@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.178.229.144]
X-ClientProxiedBy: DB6PR0402CA0014.eurprd04.prod.outlook.com
 (2603:10a6:4:91::24) To AM5PR0801MB1332.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88951b71-3d62-41e6-aee7-08d58aaafbf5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1332;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;3:0exByFjaLFhtt9EV6XhLD2AhPxl98kQci4QXyY+2/1P2nBKOead1fHH8QtE6OLS/jBx4sWMPXJlBf3doP+lPZ2/aoklj0jQmFdmncLVb3SnwgtnrRTucPMT5AFZwXsvZAKUwHEvscy0Yp8xyL5/FCqZY6zkizqUPtEDFFACZKhVYw+oEv7bmhzUyvELL5aZjV+xHUcLwPdr9C7NlCDZELfW1DReh7Ca08TupAzH57i1B84cRZyxUaYOOJfOe1co7;25:zgxgizIMhTurfuARXaEo/yavUfXOf8KaCUYqR/CALxDzp3EYxQ6NbzHpvPu2zrzcTMw0VWrv5ngUAeYahmXA3ZaoZIw1NhP//kgLI79aG13ZyFdM1/1mXDMWgwTYAdpc0C9Tz+V+2wT5RrdvohaCRciT3WEuvmQh1MuouUt7zyn3TsK7b4Mx4Oew+tYE6VbPFf4TPum3+ONNAukS9MvRceKYpAuzW6sDGrnxkPz2SERvQm0hrwh+ePMHJL4NtQXTLeLotz4YNJa3ZPQmFUJ20HInrPwB9MQ3InJw7WJhkdDTtPQCFtVZE+bEI9+JvGSX1atmHPf1m1osskgJ0fWVZg==;31:ZJ75ebTGYMP1xBKEHFjBjbzq5WbSSwAZcY6iJMimnVuh4kagm4UwcDXY9SI/c70PN8HE9XTGoVDKqaKjfB7lTn/MhXUsQUxJmeV56fDKWkYA3Fya0UhcMrRMJI+uGQw/g8mg+k5rsnrwgwhFdZ3c9MXVZASUH5Leg6rxwRKlRsin7g8TX9jJ4itxyFhiWO7LPycrWK6Gbmb6FFODeWN1M3IMV8htfUA8pHRtT6nzahc=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1332:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;20:kxNa3Uuxb7VTeCQWjUWCF222qzRsr9P7DTx/cgsfQI7SmJcCw+ep7AXf7VBg7YpmydvkS4bRhv86wUTp/LEUcY2q1rEFfLLyFnD8VttaYG1O27Sb1+RINKHaI+zDt1dVqI54mKOhimrj26Jj2MfEQI6piJ95upmKv3CSvV1apMXev8LLcLz//I1U7W+fQv8OSNaD/dLYZDndJAjWmoMgp3o1uqlnh4nSZavCmGavL3ijmRYDFyeReCBXgd7Uusj26d128MLCycoORaXZXSxKOcugxqxUn4X8GYc188IUw94J/rORfNVGYScH2Doh068fl6On+vZoSu57UZWIDS4vm+wjYtzOmsvNBFf3KmVLCm8tzdhKXXTirjtl/aSpbubIq1WKDbOZPmWv9pkBej3ycjrxc21rBg4CC/M6Hi0e5hYnFrgdyOvcl8Ku6t6TINy2kCz6GPWzZe9DpBpAPTUXJH4ovmP7YveWghP+nXIiNq8G04N+8sJQLP3Tbh6ObKYF;4:eZLIac1T4aSmB3FhHmZl3H5lkX9yjBf0HxvNgco6h3V0+/ZBl68CAd1XPWRRI0tJhGCc9HicFyZdM7QF9DDuErXati3h3Qufa81gx8o0UO9QtntAVtPaGtDYj+YibkXHpOfU2LL8twFlPFWs21+EQSeK0Hsksknxjt3brXP5fdOi+HB2cqxzdse1aG4oiqZFAfowC3UdCpTe2LcQdEs3xE66SWnYXUNgAa49e2CHp3wLWZLOyPaTyQaoA8u8y6bydu+2JC6/b25rSOlfnQ8sNAVAqdjZ+WuHI9lApNa4i9ozeuOnspa88yaJ2osVa1Lg
X-Microsoft-Antispam-PRVS: <AM5PR0801MB13328282D4D0C286F001A1CDCDD00@AM5PR0801MB1332.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211171220733660);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501272)(52105095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:AM5PR0801MB1332;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1332;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39850400004)(396003)(376002)(366004)(346002)(39380400002)(377424004)(199004)(189003)(6246003)(8936002)(16526019)(52116002)(106356001)(31686004)(6346003)(26005)(186003)(2486003)(52146003)(23676004)(8676002)(4326008)(25786009)(230700001)(97736004)(31696002)(81156014)(81166006)(58126008)(59450400001)(76176011)(386003)(6506007)(53546011)(3846002)(6116002)(36756003)(65826007)(66066001)(65956001)(65806001)(478600001)(68736007)(105586002)(64126003)(7736002)(305945005)(316002)(50466002)(86362001)(6486002)(2906002)(6512007)(53936002)(47776003)(6916009)(5660300001)(229853002)(2950100002)(6666003)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1332;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzI7MjM6RWpQSHQ3UCtUdXArTmhVY0lGTklpZCty?=
 =?utf-8?B?WmJFbStlWVg2Y1k5RS8xYlJQNjdycUhLcW5xME1KMnF4MjFDS2ZQaGpreHU0?=
 =?utf-8?B?RG9jVlh3SWRYS08vVGpXWjh6Q1crdklXbCtPa1BrRU11NUQyR0l2Sy9LQ0Jn?=
 =?utf-8?B?SGlwYnBMUy9CNGdWSE9TMnFKU3hXY3phNWVISVZQYjVMVEJFeHg0MG9BNmo3?=
 =?utf-8?B?WTdRakJuTmZIaGZwZTFOR1ptRjlvS2JiOFBvMERKOG1leG0zRE9jYjIwVWFn?=
 =?utf-8?B?QWlTK3hwVnpnamhhZk1sYWNvNi9MeEh5cWVMNmJQZmRENDIxMGltQkxHRmFB?=
 =?utf-8?B?ZndlRitmTm4vZzFLRWY4amFmTWp2NGkrOG1NMFYvemlramcwV3loTU5MM0pi?=
 =?utf-8?B?dGtwcktXWlVWUnJlcGYrSTUwYUtFM3pidnRGc09ZbXNFOC9JVlZ5aEcxOXVp?=
 =?utf-8?B?OWNXS0F0ek90OWdhREtBeVF6RUFuTnFBK3BnblVHL2czSGtyblowZXIxRkdS?=
 =?utf-8?B?ZnRVQ0tSRzBxaWpISzljTzRnbzNDdUphdVZ6Q3ZkR1p0TjU5UzhtVzdHTVdU?=
 =?utf-8?B?Z0F0K1hPZ0NjM1M5WUk0RFRoaHNFd3R3WSs3SW9xNW40TjBMRXBEeXpjb1VC?=
 =?utf-8?B?K0gxNzdHKzhyZmlNV2RpalVqdGpGV3dGYzdRR3h6d1F0Wk5MaDVHcVVjWExE?=
 =?utf-8?B?VlNIRk9GVnFmU08zUjZEcUREZHZSU2hHN3g2UVZzL0V5eVplVW9ZZ09QRkt6?=
 =?utf-8?B?MzhWY1A0eUdweUJTSTNrSGNlN3pqdVVHWFBFVXV0NzBBMk9OTHMyWkcrV1RT?=
 =?utf-8?B?T0czTUVFRGFuQmdFZ29QVWZBR2Npak52OTRqelZaMm0zVFNUNGlob2UwbHJT?=
 =?utf-8?B?akFzL0poc3R0ZTZQQXRBenFlVnMwUXptQXg2aG1MNDlBQkNORG8xV3BScGQ3?=
 =?utf-8?B?RlhERkVZWjRjZzZqYXlUenBiSzhPTU13Q0xEU25lNC90ZVpWalFXUlpKK1hO?=
 =?utf-8?B?VExMTzdibjRPRTZDaVUxa05leHFDcjJpelVvSThGV2RhODZjczB2ckIvcm1L?=
 =?utf-8?B?K25xdnkrM2hRUHNEYldjTmJsMVIxZFVKYTNhMVRaSXRWOTZoNjRYQjlFckdL?=
 =?utf-8?B?NmJSNFBNbEZlVDlITVpVUmJZcDZIQld0eHEyOGN4WHZQb2tVY1lqZHVCTU5M?=
 =?utf-8?B?U2Z1aU5PYk9kUDJiV3NEejlUbTBHejVHODc0Q3NBbGg2Vm90ajlpV2J2VVVy?=
 =?utf-8?B?ZXZhY3NPcWdyZUIrVUpucmhncVgrQmF3aGNLZFlKY0czVjF3aTRmVGl3SGtt?=
 =?utf-8?B?azlZQTZXL09oNTcxajFmWFRKQmpyajlhS0RuN1MwRjJpL1RKQlo1djk4eUhl?=
 =?utf-8?B?L1pIRFl4c091cU0rdmJhaHRlTmNEdVFjZU5iQkR2VFNvUUttaHh3NXNKSVh1?=
 =?utf-8?B?ZXdFZThLZ0h6M2VrTjI1bTVmRTRWNm9idnBjL3VOR2JFNHZmWUZLQlZjNnRh?=
 =?utf-8?B?aFp6bndqbnBWRWIybU5aM0NqRWdwZitndWVhL25jcVYrRUp2QUVWbEZvbVU3?=
 =?utf-8?B?WStKdFRZa3RsSXpsL1czRWFPUXVBUlB4azdqSkNtditmRE15U0FDZWVRbzY4?=
 =?utf-8?B?Z2hLUDNXeFhlcHgvaTQ1U0tsUWJVOGl5YTg3Wmh6YkcycDZCUlFFMFc1Mk5t?=
 =?utf-8?B?cm94cmdvUWtaVzV6SXRpQkhZd25ZcTd2Q29zY1dieGVVQk9XZ0toc0tRUzZJ?=
 =?utf-8?B?L3VPYldtOEVwcnE5NTl1dXhacHdVbEFqYlhhSGIxeDZLVnBjZGIycEZGZWFB?=
 =?utf-8?B?cXY5ZWJuUFdyeDM2VW9MOGRqOEx2ekxmSlQwU1lUbkcrQ2VEK1VQSFJOR0tJ?=
 =?utf-8?B?akNpbXRidjhKS2F1VnJEc2p2eWdtREpoTGJub240eEZjUktSa2JTalE5TlVL?=
 =?utf-8?B?c04xNURML3NnY0E9PQ==?=
X-Microsoft-Antispam-Message-Info: o+LaCQGlm/gh8kWsBscl0lAh2VD9vh5voT+aBNf+5r+MtU4mCGBUxZOO116EAv/MDbB+fxfkr94/RqDVHr/rtsUYlqI/yA/qgTlUieXaisLvgnSRIW9FeyiZzwvVuz2DhBossrsr28juXht29WpN7M5iiYLUKKdxCP81MUkFANRKybonzJl5GSNhkv4KxVQ+
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;6:vJrVRZ3kt7+yDVA9oJpMyVjGrERcDMgmWfZLnooSIo+DhkoRmP98/enwTVFh3sVzb/eNp96XKXNce5NhG2dK2ECb9+/PJmp195D7naQ6Kc5Paw8YQE1cyDHvDy1BkWthk1WHNZM8tpevvfP6xvm2ptjo6WRk2Kj0NvYDB/yL6KbMswzBbmZudqHuwa+ku/C/YypwbgLxejIC7uqTPQLn+zALXUqiOefiT0vyqaVKhU+YTj0duv0VEgBCPxiPr8Qae7DqsecunfuMwpUlLWATidrzVRc3/8tiastr/EOFlXjdUFz0Ln+9ygzkfy2XBoCT7TwB8dYDcNPavQ24q8ZMjDlwSCC/wZINydaDmmSYDSU=;5:FtN16kIHVmxoKdC9exVDecsx2MjfdV2Lntwoz/fum4953Q7UJlUKjRMP12X2/m8r/bGmMaWM3rhNwZ6MsJJJn5iV0xyqZPpGg7Qph0/Oy5yCW7WutLqekoyszhwOOJV9fy+IeG8wHZtDiKWuL6PX7bmc+ub1XG0uW62axoak34o=;24:4U1Mzv8ul6MOlcIqjm059k0SVkW2+eazHNEBd3q2V64cCgt2tLWpucl70y1tiHqWcfnW1PouaZHBY81S16MGJGAIHeuUYkFmfVITxsXk44c=;7:0/RH66IudbcL9SnfpWnacHxLfXxGIQFkKGyjFLEDA5IbJEtoOV0bm9OyW++tga2K2bSamEpIygMTUYw2HFev0fP8lM0txB2IJvu5+JIOFfl/ovg21HailrZ7BqiwEVEsxzsrxBrolno9zJNmIcA53jQMM/7lZB7+XyOk1pU4mPJox19wJb5s4lNHS0KWcayn38JM5G+WeZduZYTWoxjoN6Shh3v0qepZWn/T/VyLshZiZUviMES9s1+ad6q6iaV3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;20:wLdlOsQ6ONWBWA0wlTPOaAakYo7CWmrE7X/AYU1HouxCLzQKrSJUk2qskAoDOzJ3uOt8/PNsrz4C6BUdxam46vqYuoeMapFhrdBxtGM2janrVyYQtY09UMQ2wbsQVP23Yiu1dneIciHJAl8neRTgUqDqAuj8UResq6PWG5Ci0Ss=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 19:28:51.1236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88951b71-3d62-41e6-aee7-08d58aaafbf5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1332
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.2018 20:49, Michal Hocko wrote:
> On Thu 15-03-18 18:01:34, Kirill Tkhai wrote:
>> xfs_reclaim_inodes_count(XFS_M(sb)) does not care about memcg.
>> So, it's called for memcg reclaim too, e.g. this list is shrinked
>> disproportionality to another lists.
>>
>> This looks confusing, so I'm reporting about this.
>> Consider this patch as RFC.
> 
> Could you be more specific about the problem you are trying to solve?
> Because we do skip shrinkers which are not memcg aware by
> shrink_slab:
> 		/*
> 		 * If kernel memory accounting is disabled, we ignore
> 		 * SHRINKER_MEMCG_AWARE flag and call all shrinkers
> 		 * passing NULL for memcg.
> 		 */
> 		if (memcg_kmem_enabled() &&
> 		    !!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
> 			continue;
> 
> Or am I missing something?

sb->s_op->nr_cached_objects is a sub-method of generic super_cache_count().
super_cache_count() is owned and only called by superblock's shrinker,
which does have SHRINKER_MEMCG_AWARE flag.

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
> 
