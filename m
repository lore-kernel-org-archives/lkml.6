Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032621AbeCAPuR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 10:50:17 -0500
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:54354 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1031899AbeCAPuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 10:50:13 -0500
Subject: Re: [PATCH v3 2/2] timers: Don't search for expired timers while
 TIMER_SOFTIRQ is scheduled
To: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, tglx@linutronix.de
Cc: Haris Okanovic <haris.okanovic@ni.com>, julia.cartwright@ni.com,
        gratian.crisan@ni.com, anna-maria@linutronix.de
References: <alpine.DEB.2.20.1707182206110.2425@nanos>
 <20170803210657.19179-1-haris.okanovic@ni.com>
 <20170803210657.19179-2-haris.okanovic@ni.com>
 <28f05e39-6bc6-99c5-e1bc-91be3e79ea78@ni.com>
From: Haris Okanovic <haris.okanovic@ni.com>
Message-ID: <13c06708-f7ad-4f46-1c0b-f12d1ca16beb@ni.com>
Date: Thu, 1 Mar 2018 09:49:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <28f05e39-6bc6-99c5-e1bc-91be3e79ea78@ni.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [130.164.62.119]
X-ClientProxiedBy: MWHPR22CA0067.namprd22.prod.outlook.com
 (2603:10b6:300:12a::29) To DM5PR0401MB3622.namprd04.prod.outlook.com
 (2603:10b6:4:79::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9a6af70-747f-4342-17b5-08d57f8c1a28
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5PR0401MB3622;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0401MB3622;3:CpA28r2/gaSYv65Gnt0Nn1jo/PUp4UTaYjARz6m5/F7ECbF3Z2Rw88XNth6EQpIhukZFEsKW6RLNcrf4yWC0f7FR9F+0Q/e0u8TMBdc98MRL97h/z9sLGWrwwSw9seSr3wqcEK4cxpTWuZiRSxZMrzjTkDrkSfgtFCjQR68YI1WD1DW2etLylTvGX1Pr1dDnkiBsew8c74pW1BqWPXUu81WSaL3xasCCU4H5wMHu+o/kjx3C8BNHrZl09QCRO5Kt;25:NVRsU4ptp8nIX6b7Go1u9/3EGhk0+QsI2CCcMPOI2LGCYTcSD3jPvnkbW8MJ437E1FiLJiU6E/XKnxZtl57LpXM0XN67DtiP4Nk4ndirP17y4p3DZBg5qOYlsYFcgz1P0+ZQW0YwmdTc85sz3SU680U6js98jhbmbmPrSkypGIc80a9N0fKrjoWQmJjCFXX4lYoxVkU0Q2fWRj++LWQhFhWX2TQK2Nhi6X1fOKEcFBelABKx+JgClvu6RmtaoDILd9epJB/LEH9u61+TTS0owY8AGjUhLI5dcPnjv2RQgr2rVC3IRjZehOoO8R6psqhhwOh8X9Ew6zLjLQ1T0ti3CA==;31:LfXCI7Qub7L++JcKe6JWvFoSx3ldtOe7XlEq2xZmI6MX4DSqKfMszTZTU94eDXIqVtSm9Estfilo4YgqOq3HTJkxiOLdFa7TqbSftXwOKZDkC4NIserjL+BLRdbtGCIGSpE9SOQNZs+yI9Gg+ncddMyY/RT0iFqlDHuFo+Kw5UKvOKwrM23V3v2VvMEZkn4kUmfyczjTZqrFx6uCaSOAW8YYogflt8MfLSgmBVGGMyw=
X-MS-TrafficTypeDiagnostic: DM5PR0401MB3622:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0401MB3622;20:JGANrvhuR+5fyPOPDQWhzAosVv+uxCygPEtO/2iiJEuqAmI9xE/h8D31etayajFeqU+YmZRIiy9doWDit1OrYTaYxF00UvOLDanQsZAkBr7rwWetVIom/KC19JDTmQcs+s0dlQexYVYev8la0P4lJ7p7gtVyyjZrLPHXIV1+ryujampzmQqWPL4pRdM7RPPnBgusqCAQToJ9CFzAC0s1gG+RhJe1s2GUrxFHp+mleEEBeFliOt6FuYQc4jgd0csXul4WggKWgCPtT79ARzpXR5hDWXX/NYDrMJ1n0ozuHF6dej32zbleYHtwDv2WvJabMn5y8bO8ZRcq7baLu3b5eFALkz21uEIzO5h3gMDKFXxaOFpji2z00uTEY6I0nFAmtpP/sRvOuQrvHYOrUwOYgb95xQ2xwl6pur6dOZCMf6enhnctafKEEdEZ9GgvcYj3P6qoeAA6f6Iv0fa3NSxIbn0e6Ltj4hKAv6xZBqrYOdyrMx92xuT4aC4YSH3XAmfsr/gC/k43IacuPJZmZbRKNs0/tZd0tDGgduvqdXO2WUWWGwjKgAXno9ofp5ctBv55ldv0aVWm2xPLtRaEwjAfp3//KXD3C9MaLiALn4+7vOA=
X-Microsoft-Antispam-PRVS: <DM5PR0401MB36220F27A830E5D9D50926F9E5C60@DM5PR0401MB3622.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820)(145744241990776);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501229)(93006095)(93001095)(10201501046)(3002001)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR0401MB3622;BCL:0;PCL:0;RULEID:;SRVR:DM5PR0401MB3622;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0401MB3622;4:DlvEbC05MdHWBOon2peFS+tuAdVikFr2cTC7qgucKiZ7N2VntAcw2vRoHVfcNf/9Yt292E10fLWrhSdNdECyncHywDlix84JmQwXVt7m/mFKCa+2N+xTFJn+tsFwXKNFXjg9KIrWr9Z1Yewym6Kj92V7otIPL2d6Iu1FrVbzbnFEhv0fZwXYWI1RgtlyJwC5F1nnKBfOzq0EfaIIKpgXZffeXoalm8nnllO7xYAjNtFxfVQuzOd+wxDY98YK40NjwIlHmRf2KZzwNPoaN+CALPM0kJt013BXNYAom8KRN6RKHiP5RvCAOaOMcwOAGl82Ix58+4H18zLhu6B3ZeVNl9CfFtDmDfNqQ0FdsHGsnQs=
X-Forefront-PRVS: 05986C03E0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(39860400002)(376002)(346002)(189003)(199004)(8676002)(8936002)(81156014)(81166006)(67846002)(68736007)(36756003)(316002)(97736004)(966005)(76176011)(53546011)(31686004)(386003)(6506007)(3846002)(186003)(31696002)(86362001)(575784001)(16526019)(6116002)(2870700001)(2486003)(93886005)(52146003)(23676004)(2906002)(52116002)(25786009)(7736002)(26005)(4326008)(305945005)(65826007)(2950100002)(6666003)(50466002)(106356001)(6512007)(6306002)(229853002)(5660300001)(6246003)(105586002)(53936002)(59450400001)(478600001)(58126008)(64126003)(47776003)(66066001)(65956001)(65806001)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR0401MB3622;H:harisdt.amer.corp.natinst.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjA0MDFNQjM2MjI7MjM6di8zdkNKWjZPOHk1dG85azdyR1FxSXUz?=
 =?utf-8?B?SmttK3gzdXdNVkszTTBSZ1lOUTJ5VEdWRlZ4eXRnaE1yNHNpVzEwZ0RRL2FC?=
 =?utf-8?B?Y1RZV3RlaHVPdlU1M3U5NFRDZVdTSHBMbUlGYmVsUStQQXhjSnJPRnpZdktR?=
 =?utf-8?B?RWx6WmJCa0dvT3o1OWkrYjNWeHcwRU1QMDV6ZUNDVmF4NUlzL0pPTHlRTnFK?=
 =?utf-8?B?YnZhWU1SOWJRZllVN0NzTTdhQ0p4WGZFQzdtbEpmTzBvVFVNMmQ1Y3VvUkl4?=
 =?utf-8?B?UjZ0Q3FEbTYxemZ1emc5aW5VWTMwSitpaDdLRldTWnFGVEovd3dzYi9WZ2FS?=
 =?utf-8?B?MThCa29aRFk3ZlY2Q05BUjFXc0c3dDc3S1JCbVlkZzB2bENnQ1NBZVJ4QTdT?=
 =?utf-8?B?SktuSjR5aDdNQ2pPU3NTVkNLa2RpR2VGTzBGT2RWTC9LcmpidmhWdldKb3Jj?=
 =?utf-8?B?T2RXdUVKUXVtOThnU29xMkdMc0tlYm4rQkgxNDVPTmNvRTVrbDVrdmZPbXIw?=
 =?utf-8?B?YkRqcGpMMXhYbHVxVVdmM3BwTkVRN3QyYUR5UXFXQzEwMzNQb0lWc3J1Sno0?=
 =?utf-8?B?bkxkZlphOVkzUjMwdTlYT0c2QjIrM0liV3NSTzllSm5DVjdNY2EwSStSakph?=
 =?utf-8?B?ancwcUpXcGt1V1FEM0ZudndLUllzcXBaaFltWkV3TVVLdzJFanU2SlhkTjQ2?=
 =?utf-8?B?eFhYTXZQTXhIOFFzNkRWQlFscUdVVTB6azgvSTQxbFZqd0FUdTBNeVdFeG93?=
 =?utf-8?B?T21EZEJoUzBSeDhubnVnTmZvVXR1Z0hXZ1pZWm1wUEg3NnNjb2dRTmI1RDhl?=
 =?utf-8?B?bVJEVHBUd0ZTUjQ4Ym1VSHExQnZuaEJDOEh6eVVNZ0Y0Um9GVlVQakU3d1JK?=
 =?utf-8?B?RFBPRjNHdUZOK0R6OHB1V2FYL0NDQ1JOZHZialRVOXJ1ekdsaGxQVVpXcWxu?=
 =?utf-8?B?TFlOTzExMzUxemRmOXo4MHFGZ0YyWWFmQ2pCallVMGtmUFg5K01UZklVVXpU?=
 =?utf-8?B?VE1VSWhrZVdSd2JacGNOS0xPU2hjMDk3akR1VTg0QjhWaEdkMUpNcHRXbnEr?=
 =?utf-8?B?c3VMd2VyYytBdXZtK0dLRjZ2VzFSZ3dKbzR6c2J0Zno2aGVrVUlNT2JRRk95?=
 =?utf-8?B?d2RILzUvZjhyWFRtYllWZXdMTlBER20ySDNPOXZSWTMxaWcwcEFCN2lNeHFM?=
 =?utf-8?B?cFhOdFQvQlZQOStLa3dJYjVsTkd6cHE1TS8zem53MG03RFdUZnY5ejY1RW9T?=
 =?utf-8?B?QXFaVEMxTWNoMVZYb1dXaHdqNmR3YjBKQzBtbEp5ZVp2aXNjTjc0WnByeUZC?=
 =?utf-8?B?dnptMHIzaHhhL0s2alFMUWlaVjhaMllQeWFTNWZadll4SzFkakN6YldMSGk3?=
 =?utf-8?B?dTJDdFZaQ2p4SUxjSS82TmNidS80NjFiWG13M0x3R045dCs0dy9KN2ZCREFE?=
 =?utf-8?B?YVRIUFp0RnJnVzhvUENFNGJGaDFOTjI3SjJsQVBoNkV4dFhtRlBCUzl6eGk1?=
 =?utf-8?B?bUU3S090eHBKRWhmMEI3NXp5cVdPS28ya1JiZ2tSWm4zQVZOajgxVExDMFlR?=
 =?utf-8?B?VTYyb016bXV2UkduK282T1NvTUxaOXdoVmswREM4cWZLcW5td1Y4cm91b3hx?=
 =?utf-8?B?TUhXNUxETy9qYU9sNm1xUHFBYUVYYlVzVHNQekJCY0pWTS8rcmowTGZjL3du?=
 =?utf-8?B?Y2tJbGhicm03SUszUStaeENGekt6ck50RFhtYVVvTUwvM1BoeFpKVm13bVRv?=
 =?utf-8?B?K1VXemRKaHNDd1VRYnJNdktzRGs0Z1ZoMjVPY2QyeG1DRVFzUTFvTU5mVDJJ?=
 =?utf-8?B?dFhkWnlUTnRjQzBzYko5eTBnd3U1ZXY5bzMwN0VVVzJscGp5Q3U5SnRHTXIr?=
 =?utf-8?B?TWtWQnp2OHF3ZGpFa2MxSGZEcWxmUUJYT3NIeG5kdHBLTVNFVkxZRFp3MkxO?=
 =?utf-8?B?ZlYvTEFORlpQdEE9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0401MB3622;6:AdFV59x3MRwPjDAWEKtwrWYVTzMc2RwAVjaTUGle4QIOfVfhcNSm2Gex3o5nYPPskk2T8LXhBNkGUhvA4m6LaRdtweAHb9/cFA4DXmTGVhYW4qX1u5aNr4RzeF1bXg5HgsmnHtSZPor3gSg0vTdZ0Y3KD4Erz1Cl+jrKC03WsA2sW+l4LQ19/9COP0xGK8rHY7h88jd+nivP6R/yyzPWnvTLbI/Xtv5TBLEtfdcwWnv+l57genFB5RTEbhstamdb7UEjkqxqjkb/cwwRK3BQXOFMrwCEiFyqcNfMfUyTR8HEEyGznXEciPlm+Zdk7y+Z5IX5mMYudEkd1z8XODzNwZ3mnnRKpuyoVOEslkBhQ8I=;5:LQ+FA0sxg1hOgNHc8H3e7RoZVksKPHzOXT6qB3ZA2jycpj/x8b1FZdnx1/auwVk/SFofqm+RWopMOMNyJbxsx4gsNJYktzVW3iKuSHDwdpfNxKKTLLMGJFjYLV3jbYA6kThUuZBDJMJZ50047zrP9gWwUNOTeMinuwKDEoAlmU0=;24:4uVvKxTAix1ETvAReNRh/jvTcsT/Pcp5v0QDcN8+KsPu/bPsHSDvzap/E1LzRF5+f6pDrnVl4Hq6B9b9A8D8huIYdaJFG/TYK52yJb7y5RY=;7:mU/soNVTp/2wpsJLXCd5Yn9Eb3onrlzZu/VxP6eMFuHqBZxdsM4BHQ/RcoLxRz4LNMmDp7sXAO36pfoSgoptlDVgeYF68xAeUayLaVZB6FA8FfTOogR9ve6/pZ3I7g+tQ+5meGcxCJvSFY7a2YvmLTNajeV5dR+SgZUalgvcMaSk1AQv5oCD0y5NI/QfPvmpSvcYUrbRpj0IUrBg6Pz0TjYXR3Ncqlriiw40I0rywxLcTucANdB93AI0ZXVp+XCW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2018 15:50:04.4630 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a6af70-747f-4342-17b5-08d57f8c1a28
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0401MB3622
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1803010198
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*bump* Has anyone looked into this?

On 01/05/2018 01:37 PM, Haris Okanovic wrote:
> It looks like an old version of this patch is included in v4.9*-rt* 
> kernels -- E.g. commit 032f93ca in v4.9.68-rt60. There's nothing 
> functionally wrong with the included version to the best of my 
> knowledge. However, I posted a newer V3 [1][2] based on Thomas' feedback 
> that's substantially cleaner and likely more efficient (haven't measured 
> yet). I think we should include the latter version instead, if only for 
> the cosmetic benefits. Thoughts?
> 
> [1] https://patchwork.kernel.org/patch/9879825/  [PATCH v3,1/2]
> [2] https://patchwork.kernel.org/patch/9879827/  [PATCH v3,2/2]
> 
> -- Haris
> 
> 
> On 08/03/2017 04:06 PM, Haris Okanovic wrote:
>> This change avoid needlessly searching for more timers in
>> run_local_timers() (hard interrupt context) when they can't fire.
>> For example, when ktimersoftd/run_timer_softirq() is scheduled but
>> preempted due to cpu contention. When it runs, run_timer_softirq() will
>> discover newly expired timers up to current jiffies in addition to
>> firing previously expired timers.
>>
>> However, this change also adds an edge case where non-hrtimer firing
>> is sometimes delayed by an additional tick. This is acceptable since we
>> don't make latency guarantees for non-hrtimers and would prefer to
>> minimize hard interrupt time instead.
>>
>> Signed-off-by: Haris Okanovic <haris.okanovic@ni.com>
>> ---
>> [PATCH v3]
>>   - Split block_softirq into separate commit
>>
>> https://github.com/harisokanovic/linux/tree/dev/hokanovi/timer-peek-v5
>> ---
>>   kernel/time/timer.c | 21 +++++++++++++++++++--
>>   1 file changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
>> index 078027d8a866..f0ef9675abdf 100644
>> --- a/kernel/time/timer.c
>> +++ b/kernel/time/timer.c
>> @@ -208,6 +208,7 @@ struct timer_base {
>>       bool            migration_enabled;
>>       bool            nohz_active;
>>       bool            is_idle;
>> +    bool            block_softirq;
>>       DECLARE_BITMAP(pending_map, WHEEL_SIZE);
>>       struct hlist_head    vectors[WHEEL_SIZE];
>>       struct hlist_head    expired_lists[LVL_DEPTH];
>> @@ -1376,9 +1377,11 @@ static int __collect_expired_timers(struct 
>> timer_base *base)
>>       /*
>>        * expire_timers() must be called at least once before we can
>> -     * collect more timers.
>> +     * collect more timers. We should never hit this case unless
>> +     * TIMER_SOFTIRQ got raised without expired timers.
>>        */
>> -    if (base->expired_levels)
>> +    if (WARN_ONCE(base->expired_levels,
>> +            "Must expire collected timers before collecting more"))
>>           return base->expired_levels;
>>       clk = base->clk;
>> @@ -1702,6 +1705,9 @@ static __latent_entropy void 
>> run_timer_softirq(struct softirq_action *h)
>>       __run_timers(base);
>>       if (IS_ENABLED(CONFIG_NO_HZ_COMMON) && base->nohz_active)
>>           __run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
>> +
>> +    /* Allow new TIMER_SOFTIRQs to get scheduled by 
>> run_local_timers() */
>> +    base->block_softirq = false;
>>   }
>>   /*
>> @@ -1712,6 +1718,14 @@ void run_local_timers(void)
>>       struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
>>       hrtimer_run_queues();
>> +
>> +    /*
>> +     * Skip if TIMER_SOFTIRQ is already running on this CPU, since it
>> +     * will find and expire all timers up to current jiffies.
>> +     */
>> +    if (base->block_softirq)
>> +        return;
>> +
>>       /* Raise the softirq only if required. */
>>       if (time_before(jiffies, base->clk) || !tick_find_expired(base)) {
>>           if (!IS_ENABLED(CONFIG_NO_HZ_COMMON) || !base->nohz_active)
>> @@ -1720,7 +1734,10 @@ void run_local_timers(void)
>>           base++;
>>           if (time_before(jiffies, base->clk) || 
>> !tick_find_expired(base))
>>               return;
>> +        base--;
>>       }
>> +
>> +    base->block_softirq = true;
>>       raise_softirq(TIMER_SOFTIRQ);
>>   }
>>
