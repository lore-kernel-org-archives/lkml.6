Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751368AbeEUJT0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 05:19:26 -0400
Received: from mail-he1eur01on0111.outbound.protection.outlook.com ([104.47.0.111]:53686
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750945AbeEUJTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 05:19:22 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH v6 15/17] mm: Generalize shrink_slab() calls in
 shrink_node()
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
 <152663305153.5308.14479673190611499656.stgit@localhost.localdomain>
 <20180520080822.hqish62iahbonlht@esperanza>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <1105a543-08f8-5284-81a9-3ea6739b489b@virtuozzo.com>
Date: Mon, 21 May 2018 12:19:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180520080822.hqish62iahbonlht@esperanza>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0202CA0047.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::33) To AM5PR0801MB1331.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1331;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;3:b92e53clgGJidVax1DV7OK9RkrazXsRHOk3DVjYxrrtpY3l0ejksmOUkYbFwDUX4KU79w50itqeKbCP5vsJiV0Q0kerU/kTFGigR2rUzpvAEk9LbboH6MtVhZFA8KukP/JCrtZtxSbaKVK26OCnuzHFq/9sIbdSr17Vjxr7uZCVuVk061dGNJ6BRRYQohcewgRsPyWi2B9DCQErxaODobAyblQtLbFJudXCTdoU3bECaKz2AGBB5eNxV14Qr2a86;25:LRnz1MgHMe5ISMFAQFDa4J9LGpWS7rBa9SaEAzwFw87ngLzTzNhtfi349IYhFFYr3dXWBm4UGBs0UUmIBH4CkSbVuUKA+SMTJTm4ZttBQNc4R0CQhrReLywQSiZJlc+DxpubbOA2JHqIBJQLZOsqlVPmajnTUvObKsK2snFabovv0NvdT9NQBw5lpjB6JCAGitDp/Q2m5FASbyNd6eDSoYDFIMImp7yAtVUDD7uRhP2FVEObpubL9KW95w0aK54ShJ3b5nM33JBR0YhtgGePDJs4+Gvz/DpqXppkp4CyPd1s51HwCDCqjgQbCa81dZ2BOLyweefiNUJIfQyD7kmMbg==;31:wa5JqBZ2p2y6jc+ZDqbHsNo/JuTsgCl+fLxBYvLvPoE98tOvv+44A3QtIPcfClehGDOCCyAC41297VqtzsATAlabk1l6M80ttbTlwdiSDEQu/dQKfdXTbqMv6HhiX4lvDHi4RufuH4cEfrg/6CcBTsOvGaTS2d5EPpqqPpv/2sX1uMNsEU6LgQJAYl/pwGMB5GuwDH+feIQBCN4Hx0n/Uv75fw47S1soEIlsjHvYvP0=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1331:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;20:i/0Wf+uHXKP1jjmNkzHQtttIyCwjGeJnDcsfYLILCfNp+pXBMyMrJ3LqGmGwZAxdOwwNxfjUPGQ44uDwx+H3d1Cocff1F+0KoGAcbNhG27xq/fhLmSInDDEUcwhyANjTYrqXpo7pKUqSyywsW++/lnEG5gtCVVP1L6U2ymg8rnrBgr1NfpWjwjIgA6wL9DVwz9z8kpBi3fcYR84ZBWkSVBIW5CwUavQUgbAAFVxvYEJsj0e1T1DIsjQHtVT/dX4TfR9GMcwr8l2hSayun3wb5kMbdnzRlpU3TEKAMskF2j4xYW1SJKAjKpL6nURLCFiYmyHkeAw9csLHud/0ETl+TAAiXiX4u6zmYefHzSPXtOy+leunTKCQjd3tKckt+fHnI9pSfRPu3zBc5/BFqSMbayFHyUnWr3YkUzHKEeQ9O2siXigk3Sa3hhaDnR6k16gIlE+9Ka0Qmmk6+SB6iOagS54TDEN1qgS82G0n0BseCIebIuBr4QGYyW1qe5URc0Hx;4:IIUXosd15lr5Z16Lg/LMAaEYfMND0oew+DFMx9noi3KZ4SPEImErdwe48Mspvi9XkMfWWDOtreGFNkPVNAJUUw2lvbJI59fVGOjCiRYKLc7D8L/b2jsEJArCGNCd0Uis79hSVA7OnrlavG6W8MTvgEe8lYOOLQvP6GR1YaN9E4ow+CO35X2B+Nq+GCigSbVhRBWTsXI+hKBYjm16ofym+MKNI35zu4i8SZhpFGD6tLUQA7DHXXSGfgkZPAf6MCXe0lHOv8QuJgD0LyD59JSV1DaI8ZFBux+rwvJfVO4zXvVaenrqH47zrnwqjfMJ+FLW
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1331CF6BFA2A1E55B17E7422CD950@AM5PR0801MB1331.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1331;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1331;
X-Forefront-PRVS: 06793E740F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(39840400004)(366004)(39380400002)(376002)(346002)(189003)(199004)(16576012)(58126008)(230700001)(53936002)(11346002)(4326008)(6666003)(316002)(25786009)(3846002)(6486002)(8676002)(81166006)(39060400002)(81156014)(6116002)(305945005)(6916009)(478600001)(7736002)(229853002)(956004)(2616005)(8936002)(476003)(446003)(105586002)(65826007)(64126003)(2906002)(97736004)(486006)(52146003)(68736007)(23676004)(52116002)(2486003)(31696002)(36756003)(7416002)(107886003)(31686004)(86362001)(106356001)(65806001)(26005)(65956001)(66066001)(53546011)(5660300001)(76176011)(16526019)(47776003)(59450400001)(77096007)(386003)(6246003)(50466002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1331;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzE7MjM6SXNSWVVSUVFYVEpHQkl5RXFyZ3RpWUdu?=
 =?utf-8?B?K05weWxsL2R3Q3I2RVFHa0twd3lwTGlWOEJLYUErb1pjMHYvbEpGbW5YNm5V?=
 =?utf-8?B?NEo0cnZDakVoZFI4bnk5R3lFQ3hrOWJwbi9NZkVuOXRQSDJ1dURnR1IxNWxK?=
 =?utf-8?B?WjFlSUNTTHhRdmd5Qy9BeVNaQ1F3UTlJQUt3eXduQVhMNVF2RTArbXZlVHdZ?=
 =?utf-8?B?YzgvTVptR3h5c2NuNlRxcFRhWUxlNm55KzlZK2pzdXBXN2twSmxaSWxKcFJD?=
 =?utf-8?B?N2puUDRTM3JIZ2xQSW85MDZtaHFYNjZMdlF6eDVxOEJPVER4ZHVXMjh0Smly?=
 =?utf-8?B?MHI1ZFFQZkZ3citmS292eTgrZGJtcmhCeTFNYkxHSFgyMWZmOGp3TndqSFhH?=
 =?utf-8?B?WW1rUCtVaEVHUCtnUnluUzVXM2NJdGpiVUU3RFAxbDRqSk9jV0xMa3FKYUY2?=
 =?utf-8?B?bUtDL0paMmVncEpVVitzNGlCbVh2cGx0QmwxSWVoZDRRSngwZUJFNWRDNjNZ?=
 =?utf-8?B?c0UvOCtXOWpvRnlRSXloYVJiR0p3dmNQdno1N0FsU2Q0L0lOVXFpQm1HRUg1?=
 =?utf-8?B?SWpuM3pTSlBqYmJxTGRaV0tnRFkxeVhhdEw3bUR6RG1TMUtOdjkwbnF6ajdF?=
 =?utf-8?B?cFduM21KUW1ZazNqMXBSL3dNb3U3ZGZzeXJlOXVNUTZqbHNxTzRhNFE3U09k?=
 =?utf-8?B?Vlc2ekl0TS9nUVpQeEtVbVRGeUFocW56V3FHRnZEbmYvTTl5T1NxRTA2RjNq?=
 =?utf-8?B?V2xZMDVqNzFiRUk5SXcybmVTRzErK1BTdXVpS1U0anNORmlnYWpDL2kxWmRY?=
 =?utf-8?B?bHhPRWhSK0VMeHRGdTJLWnFFQmVMU255aytsL24ySHl0KzVoaUNKandPNnp4?=
 =?utf-8?B?RnVtNTR4b2hLR3REd2dUek1JMnBUVnlWRFN5ekVGVGdxYUtMcHZsd0pmQlJS?=
 =?utf-8?B?MVgrOU1xY0tuUC9MLzdaT1BTaUJGRGcwWHpIQ1VpSjFDczIweVF4S0hpeFNP?=
 =?utf-8?B?QWFnSGkzdEVYNmFNUmtQS2h3aGMrdkNUOG55OW05MGo5Vjh5dVpjTXg4ZWNV?=
 =?utf-8?B?WmFocjhubHFzbFNFOFhGdmJyT1c3L0lLZzlFdmprOG9sS3I1RmsyNzJOL3B2?=
 =?utf-8?B?Z05NdE91KzZsRXhCcVowUC9leHdTQ2FlN2V3WEVNTXBUME5FTFNZNTZON2My?=
 =?utf-8?B?Qjh0VlNqMzlML1VSbkVxQ1JxUUMza0xwQnVwc05ScUNNREFWVTcxbmpOQi84?=
 =?utf-8?B?UmloaUtGQU5JVWdhaGExTW9VMWs1VVpFTDcveUdRcXNzM25BbzFtQWhjd25h?=
 =?utf-8?B?d2VIaWhXbXFDd2dRRUdDTFZFOUVWeklHS3NhY3Y3YVgrb2w4UmRlQXErUUk5?=
 =?utf-8?B?enRQY2U0RjNZUFlrVWhLQjY1ejhWb0Y3ZmRKdFBjMWZnYXNlL1JkOVVJQzhH?=
 =?utf-8?B?UnNvQXpRWWgvRmdGcDB4OFAvRGRQUzF1Qjd3T1pOWE9QdEdSeXd6a29RQmQ1?=
 =?utf-8?B?STRIZnBLeHdLVDdXME9hR1BaWnV0UEFiOXp0cTN5bjViSjZ1S04vS3lyVjdK?=
 =?utf-8?B?VUY0b3BRLzZJSVhrd2JQZVJZc05EYWVmVjU1aGNUVFJlNExuTGhEWE0vQllK?=
 =?utf-8?B?WE1UMjJSNDB2YVJURm9iN0VwVDFwZXVnaC9PbUlTVDA0U3FSNC9iczNOUm16?=
 =?utf-8?B?UFdqYTRJY3kxZG9CVkJJVGxTUnhQdngxc1RTdlI5YnAwL0NPMFB5WHFyZWtn?=
 =?utf-8?B?bUE2OVpkalNpL0xCTDhOaE5ZWE4xcjNXekZjWHJTMnkrVUhDUUwzdzhCUHhJ?=
 =?utf-8?B?cGJQSHg3TzlLdk1HaWV5clZvTEYvL3ZEb0h3R3VDeVBpVW42RHorUTE3aTFP?=
 =?utf-8?B?c1Aya0hnTFRIQnNSMmFjYm91MFdkdldSNFlWcHoxeVhQUHZoMjhkT2JabC8w?=
 =?utf-8?B?QTNCei9YRHRoM0ZISis4UXJ0dHNxVmZTLzRRSjJBTnNPN0NCTnU0QWs5Qk1V?=
 =?utf-8?B?VU9YR0xvUVFNVlNKY0kwRzdiRHF6ZFU1SlMrVVR3PT0=?=
X-Microsoft-Antispam-Message-Info: xdMffAfMxn3czpkWQyF/BgOFJ9by8gHfXjCXofwg9GB7Mg5obIvtLxosAhpyREdotrJHs5PFPHz2zPArNk8pAbQUI7Wq53NSfVfWSasVbk+jUz4YUurBP3zpjrn7CTZyn2CokygM8Ay/wQLsjOlVmxquHbekONhBpYXAZRxCa1toJUut84R4gP4P7LzghMCW
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;6:kRbrNJw+HmhYfj2J/OS4BpwyTEQnkR4vCvHuDJyAk5H8nLNq7SlI0JW/uHDrvWRrHvzf6muKRXkldzuWj8LX2FqQyAwzIOSob93/2FvdX2/h6GijPVwBml9xyYAgcaUKEN1VOirvz4wUXt1s9/ppcFgfhkmHsnN/u2Es6zkaeeH7bqdgbMElWwzZtZFi5KRl/FjW9DUJ2/by4cBqzddpz4BHTmgDTbsrXS7lFJVFtVGUgbsQFWO5nrsNMTKZIBxd07qvKtl3bNa41GXIvfxqQtnU0TkWu0U4YxEn3fCfsK5dJ6dlHfzO+fAXqOO4GRmRgPc05DeyKzIIcX8wcXiGf+J/8+OnoGQBEPOZ0953EVdUew7QAYhUUcar0L4nJ7h1Jf1+LansV8VlW6X16yDefPe6UOxFH+ELdDrTXXWGn3vw621tS1m2UVR+q4wZ/iqiJodQsvBUIyA/T1DBwYySUA==;5:kZGiub/KcN32X2yPLfPnGKfcbtD6d+3iDbusfP9zH/AMAd7JOokGwo3ySxCBGtVOoHjJ9g4zdDtQZgmLTrphhh8ATR4pV8X1DQVI+t/GwBMT0LHhYOYyTl5gx+SW3VvKF2cV2+NpACxkoZCMR9vB0dkvG6QmUK1PCS+L9b158k0=;24:5FmqFsZo6aZE5zCbiaZ7RiC7WicnMVm8Hjeg0kWkJ1k17h2vDOwlwjIYTliDL2hvhfZM3V7CfLaRItnr1AxNzE+a1u1xFZ1SVurjW2B2aT8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;7:lo3OD5aMICgvKS2U6qEDukWs1yd/AQh8JcpfgY95b1isDX4ny07nVRH3m4/JvSPVAXcGexjfRt18gfEc8UlHtY3JbY6xLiC+GZJWT2uMx/0unWxJK5Wd9JMetw6LIsRD2tATkaeaKF6lcibbKvGgCeF7XlYLI7b/NRrdjwBYWDNILw8jJPXXtYjhnePoxIiqiMv6J9DeCezLhMHK18mdnaOcnWoYVpCFO+HIbMqHEQlgVDMS/jRa5L7OK8yHEatr;20:+sonUaW7U1nmdQqlkRWFsC3Bh5V/mnWSupy5/wLyNiUOR4/2wH63YdWzlFnemAVMpK/AYN78lqeiGhxPGNgYavQwCVskVU3TjxeVA/k3rqURRNA5sw6Q0Pxv79ISvS387ZqhL9LrxyqgP3VlvVXTKuY4THvk9bt6Cd3uTTUO5+8=
X-MS-Office365-Filtering-Correlation-Id: 95ba39ea-48b2-4b28-10f9-08d5befbeda0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2018 09:19:15.7747 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ba39ea-48b2-4b28-10f9-08d5befbeda0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1331
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.05.2018 11:08, Vladimir Davydov wrote:
> On Fri, May 18, 2018 at 11:44:11AM +0300, Kirill Tkhai wrote:
>> From: Vladimir Davydov <vdavydov.dev@gmail.com>
>>
>> The patch makes shrink_slab() be called for root_mem_cgroup
>> in the same way as it's called for the rest of cgroups.
>> This simplifies the logic and improves the readability.
>>
>> Signed-off-by: Vladimir Davydov <vdavydov.dev@gmail.com>
>> ktkhai: Description written.
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> ---
>>  mm/vmscan.c |   13 +++----------
>>  1 file changed, 3 insertions(+), 10 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 2fbf3b476601..f1d23e2df988 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
> 
> You forgot to patch the comment to shrink_slab(). Please take a closer
> look at the diff I sent you:
> 
> @@ -486,10 +486,8 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>   * @nid is passed along to shrinkers with SHRINKER_NUMA_AWARE set,
>   * unaware shrinkers will receive a node id of 0 instead.
>   *
> - * @memcg specifies the memory cgroup to target. If it is not NULL,
> - * only shrinkers with SHRINKER_MEMCG_AWARE set will be called to scan
> - * objects from the memory cgroup specified. Otherwise, only unaware
> - * shrinkers are called.
> + * @memcg specifies the memory cgroup to target. Unaware shrinkers
> + * are called only if it is the root cgroup.
>   *
>   * @priority is sc->priority, we take the number of objects and >> by priority
>   * in order to get the scan target.
> 
>> @@ -661,9 +661,6 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>  			.memcg = memcg,
>>  		};
> 
> If you made !MEMCG version of mem_cgroup_is_root return true, as I
> suggested in reply to patch 13, you could also simplify the memcg
> related check in the beginning of shrink_slab() as in case of
> CONFIG_MEMCG 'memcg' is now guaranteed to be != NULL in this function
> while in case if !CONFIG_MEMCG mem_cgroup_is_root() would always
> return true:
> 
> @@ -501,7 +501,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>  	struct shrinker *shrinker;
>  	unsigned long freed = 0;
>  
> -	if (memcg && !mem_cgroup_is_root(memcg))
> +	if (!mem_cgroup_is_root(memcg))

Yeah, we can do this. root_mem_cgroup is also initialized in case of memory
controller is disabled via boot parameters, so this works in all situations.

>  		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
>  
>  	if (!down_read_trylock(&shrinker_rwsem))
> 
>>  
>> -		if (!!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
>> -			continue;
>> -
>>  		if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
>>  			sc.nid = 0;
>>  
>> @@ -693,6 +690,7 @@ void drop_slab_node(int nid)
>>  		struct mem_cgroup *memcg = NULL;
>>  
>>  		freed = 0;
>> +		memcg = mem_cgroup_iter(NULL, NULL, NULL);
>>  		do {
>>  			freed += shrink_slab(GFP_KERNEL, nid, memcg, 0);
>>  		} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
>> @@ -2712,9 +2710,8 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>>  			shrink_node_memcg(pgdat, memcg, sc, &lru_pages);
>>  			node_lru_pages += lru_pages;
>>  
>> -			if (memcg)
>> -				shrink_slab(sc->gfp_mask, pgdat->node_id,
>> -					    memcg, sc->priority);
>> +			shrink_slab(sc->gfp_mask, pgdat->node_id,
>> +				    memcg, sc->priority);
>>  
>>  			/* Record the group's reclaim efficiency */
>>  			vmpressure(sc->gfp_mask, memcg, false,
>> @@ -2738,10 +2735,6 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>>  			}
>>  		} while ((memcg = mem_cgroup_iter(root, memcg, &reclaim)));
>>  
>> -		if (global_reclaim(sc))
>> -			shrink_slab(sc->gfp_mask, pgdat->node_id, NULL,
>> -				    sc->priority);
>> -
>>  		if (reclaim_state) {
>>  			sc->nr_reclaimed += reclaim_state->reclaimed_slab;
>>  			reclaim_state->reclaimed_slab = 0;
>>
