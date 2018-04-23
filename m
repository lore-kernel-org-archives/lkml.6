Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx4/TE5F+QLuNHNAoEa2oHAmkren1U+1/I7g4GH2PniRsc68/a2jFYHVPK/MZnw3wpGcuHH6W
ARC-Seal: i=1; a=rsa-sha256; t=1524481381; cv=none;
        d=google.com; s=arc-20160816;
        b=0m97oaJqpCbJ2U5m4prAcuPicqy0fxbxpDj11oaTUazYsEUmo4hPEiX+s82tCopR7x
         B4LBmd/XOLYbzaV+rx84PJ3XWS57dCBvEpf9Wkf8PHnFeuQKnT+LSfxA0lwoO2TDqN7J
         8pzLd0AD+kK+YV9mbBrSw4OFvHPO/p/dFGp8MF+1i7xIg0Aur586qaSUD1AA9HUtCL+p
         JbjEqErMO2EKizwyiAo5P/rQOyrbloUyrT9wEC2vDPyQWD12s6Y0OK3KuSKs2IISxw3c
         tbePyZ3kAzKKsdclgsAGHMa/QSwGe5hjK5vHjbw8EongnWyfHj5XUMghMMagBWt18sNP
         sAIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=/i2PXc8K9/bBmN2WN6btvKZz76tQ4FFvMfoMddNa6J4=;
        b=cLnkoxbRHuU6mOjH/mMvWEKzvuLEuC9ysxhC3pWYSqVD+zrfsx6jFRRvFCZiK9Aaff
         q7HKWai9Y4KO7+R8N34+5lIj/wkF5XlkW9JBexzjH+gj9giCnrwT3uLr2HGpsqSNnbUx
         FvCPT2UuQCSXnL1tYOem7RNdy99Og/pF+0FRZ562oO9iGY8pasBcSG/lyWOnreZbcHpf
         Nc8SnnLDPG3qJsolfeGQse051X6IxD+KTtElM0bvBY9tlBne3Ng6JcqmnI4iclEVKC6u
         kwNsN1l7+G7ljJ4jmwh7IgcEsK0bBkGPYhoN8YiWkKH7CVUU1nNkkiu/CY/Mf2rJUcqZ
         AWgg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=dULL+aM/;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.120 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=dULL+aM/;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.120 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH v2 04/12] mm: Assign memcg-aware shrinkers bitmap to memcg
To: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: akpm@linux-foundation.org, shakeelb@google.com, viro@zeniv.linux.org.uk,
 hannes@cmpxchg.org, mhocko@kernel.org, tglx@linutronix.de,
 pombredanne@nexb.com, stummala@codeaurora.org, gregkh@linuxfoundation.org,
 sfr@canb.auug.org.au, guro@fb.com, mka@chromium.org,
 penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
 longman@redhat.com, minchan@kernel.org, hillf.zj@alibaba-inc.com,
 ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
 linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 willy@infradead.org, lirongqing@baidu.com, aryabinin@virtuozzo.com
References: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
 <152399121146.3456.5459546288565589098.stgit@localhost.localdomain>
 <20180422175900.dsjmm7gt2nsqj3er@esperanza>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <3e8cde1a-e133-8c09-a23b-388965f56f82@virtuozzo.com>
Date: Mon, 23 Apr 2018 14:02:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180422175900.dsjmm7gt2nsqj3er@esperanza>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0206.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::30) To VI1PR0801MB1343.eurprd08.prod.outlook.com
 (2603:10a6:800:3b::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1343;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;3:v3cKabsFgvGhhIPaqYORSQ+r06dt6ljcRz+9Bj/oampjT3DgzbQF7cgAX/mek1vy9oMJSXf3ta4i69khdNIc3bY6HtafuySke6alo3Ppv4sD3JMBHRZP3Uz43WdTug57GAmKri65h80i9/QUC26Zg5evZ+CrWnYozOK/tXPCj/S5LWtyFESwa55jpnc/vWI3DdievbmDOn0pxzILwVOIhiOZN2t/MJFOuTaZOPgBaUXTJJHA21ADk2gwtzHGdWQA;25:SwzI2BS8o6a2IWuyNH6OxXHZ+R/MmFk2UiMVQhOJIxs8JdSZO3tn04kx+VcwFfnpawdSdOwrknRswJua7sYAsWXHLU082sRzloFmw6YY9y7iTuj+Lt9+OOzPdU0L2w9QhRNUGnLA9CquDWmgkWbziiMT+awmjuo+RlwkTiXqsaZXE25PZPg24SbYs+vskhfZx+uNJxbeQRkIndNGGzxTzwmNVYIhATEc85dsyR9r6aaXpT2OHQGaZ+D8Xaya0Kw5kJ/JK3a+Ws4+aWh1UyZAY0lvEFptXjCwbkv8byBbgzRC8HWp2eCb+0oh4UeXFqzakue0uQp6Hz869tUdpNGEhw==;31:iLOErPB0FtRhojuj0c2LeuhUqEVBIacTUtYbS13BMCCpXK5ReyjMfMPShttKxcYWBU3VxC1tikJf7ZY0Rw1iYXex4OOCjeTJ7CRM773+fSu8oYqeJPbKlLwZSQtl8hX7f3nRFmFm/fWYJEGacvnsij6h1YJzmAQg0KWjhqnizGOoxcl07H+m6W5KlurrnX/vseF+Dt7A97chehWfSURxQ+Z5IM+Mm7T7bEe0ZLWC4Gg=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1343:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;20:3yuSRzOdQ2qKpv2UGUQ444B/kcGYZzx/b0949/FymOIv87pFf8RVij1leOv1BPyP2Vydh/BU4qNy8jGaBOtmhoXdKQsXic4bW1DcRZtcrOyk+MfEg7gSkvxZm3isqdY4KhF0R0IIIcLD84V3lF5dWRQhldyKZREjnX3Q/k2lsn3aS/sAb9O3aoDa31JB3dsg7ZJRnVvoD7j8N+jbcXrC6/ruZLAUUsj3mQ6O60kyq3iD0oWqqYTb2efwi1lhhE+3fghwKYqovFoGM3a/FmrrEkZHDEXxcN0eAT6Oxud1BOPJxy9Ky1dcZ+t/iafyi/+zLD3uvc0fHldsFKuSSiI8cTXDCDyzhvMHMMOidM3Ks7HPpW927HtceNtCXrvGvwh31GJTQZiprlnsr87OJk0RnQyi+Bbsw5bpmAbDRME4aS+YCRvsGfkUOAleTFCdUKD9YtLxJQoUp+cVCEWqxEDRNGP9fOXjxnJWflOQ3xgcSlX2fZcP8laUBrE7bE7jroCt;4:gHU8PikTLRtUJ38SkqO9YcXq8hMtF5/04IWa+8Ac26VKqzfovbpWgWHDsxT205+xaY7L9R+79q1ag/rqqw5jcaCbwor/uk9pGLjYfhfMkY8QtyAyo3JNZ5cCy8LvuexK2JdbVE9lg5GIemQmB/KIe2k9NA3vdoNdn0UJsn94Jwnsmx0Kbiw1OIw0Gy5q9sFqfpNZ2S9WUq8yAGYGpBxR5QIn6PIAfpM5gRTyaKEZAPd/Rcly5osTOAUcxtLWanJgJ4fy/q1Gg1zRVpilXdtVq08PzvxKW0gbea54m7RitFbl+rbZBd5vRtPwBu0QWAXT
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1343D90BB687C0A8ABC4EB2CCD890@VI1PR0801MB1343.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231232)(944501410)(52105095)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:VI1PR0801MB1343;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1343;
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(39840400004)(39380400002)(366004)(376002)(396003)(58126008)(7416002)(7736002)(305945005)(5660300001)(6666003)(6916009)(65826007)(478600001)(16576012)(316002)(76176011)(31696002)(8676002)(52146003)(59450400001)(53546011)(386003)(2906002)(52116002)(8936002)(81166006)(23676004)(2486003)(4326008)(77096007)(229853002)(26005)(11346002)(446003)(476003)(2616005)(956004)(86362001)(16526019)(36756003)(6486002)(107886003)(65806001)(65956001)(47776003)(66066001)(6246003)(64126003)(39060400002)(6116002)(3846002)(230700001)(25786009)(53936002)(31686004)(50466002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1343;H:[172.16.25.5];FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDM7MjM6WUZpUjF5VWpaRlZNYmFTMGRPbk9TUFI4?=
 =?utf-8?B?Q2N0YmJvSXpBVGI0R3RBYWFDcW1Ednc1SHcrTjc2RTVBbEhCb2hmOHRqK0Fp?=
 =?utf-8?B?QjQ1M3JJVThUTnNRcEJiWUttR20wTG5GSmIvY0c2dkVxV3FSQmkvRVljL0JH?=
 =?utf-8?B?aWVyRE5BeWxpUWIwMjU0Ym5iY3AyeWh3M3N5YjFVbUZVbEtEc1NDb2Vpc2FW?=
 =?utf-8?B?QmVZR0dHQjBWVmo3N2RCaGFqaDZzdmlHZzZLQmpGZStTNVJLYXd6ck1kVWdY?=
 =?utf-8?B?MmtTMUNPcURHR3hLK29oOUpRSEg0dUlkMU0yQncrbXd1bTl4RlZHWGRqKzFi?=
 =?utf-8?B?c3JieGhNT2FsODY3bHhCWFJYS3RVZ28va250R1FRWk03YksxQnMyN2xqWlBQ?=
 =?utf-8?B?dU9uekdBRmxWdmpZNHdRYkhtZmFpQTF5aWp5MHJTay9waUJRODdTZkw0SFEw?=
 =?utf-8?B?R0RaZjMxdTZROHRBeVd3bjVRdFQ5S3cwb2dOa1hMVS82bHkycXg4TWNYeUN5?=
 =?utf-8?B?QXNFalB6OHU4aXNvNC9WNFRNYy82andXNG85YjI3UHE4TFd4RTR1aFRRZmJR?=
 =?utf-8?B?QUpLb2NkMnFxNUc1T1pTSTUxN2NpcG1ubmlJc1QvcEdrdnZBeXVJdHFSUTdi?=
 =?utf-8?B?S29tcmpDeWV3azNTb1NqbHY4ZFVLYnExS1htNzZFWkttLzZ5Y1QzTkxuWW9G?=
 =?utf-8?B?eDFkNm9OZEs1S05HWUt4bjc1cHBheWxVNS9STzlUOUYwUitSTytheFFmdGlx?=
 =?utf-8?B?RjVvcWFjUUI5NzF1K2IybU05SnZoSTZFRGY0ZUxVN21MR2JUdmpydFJCY3Vq?=
 =?utf-8?B?d2pjRjRIQkdIU3VEVm81WE15T3Z6bGpCeE9HRFhkTElxV0xIRXZsMFJuTjRp?=
 =?utf-8?B?VVpWNzNWczdLOFFFbkJjQkcvL0dpUXlyU3UzcFFoL2VQNEg4NS84aXE3VklG?=
 =?utf-8?B?eGl6RkF5VWUxTDMwZTFYSFI3SDhKMXdPaFc0WVRkUUE5TVFEa0RBTStNVnBD?=
 =?utf-8?B?NE1EelBaYTlRN2txM1hPeU0zZ2ZhTDJXR1NoYUljWXpPa0ZEMElKQ25SUkFB?=
 =?utf-8?B?SHh5UTBub2ZjeWhOd3MwaXpTSE9hc2JZV080QjB2YjV6ZXVMdDBvUFYwRVFG?=
 =?utf-8?B?MjM5M2pJem15YjBzMk80Qk9JeVRrQmRxUG5vWFFxdnRCajRIRHpxWUpDR3Rh?=
 =?utf-8?B?ME1XVFRGcE9neVZQWU12QjR6ZERNakNWMWh3ZTAxY1FsNGNjYVJmUjQyYU96?=
 =?utf-8?B?RDY3ZG5pVGZ4Qmg0M3JyOS9YTS9ORU8yZlI1UmQ3K0RCZzJtUGxsKzBuYTBT?=
 =?utf-8?B?ekZMbnRuUkNmUE9iUnlPR2QxcmVqR3FpNWdkcjZaMVlqUGZaNWYrdW44WkY4?=
 =?utf-8?B?dyt4MWNIUjh3dDNrNkZlTmdSV0FYSTJqMFI5ZXJWUnZOTUlhandQditIOTdy?=
 =?utf-8?B?MWFOaDFkODlWVGNZaTFLMFppTi9YRmZKVk5BTmw4dDB4M01TTUdncFBUMlds?=
 =?utf-8?B?OU9LSDFzRHRLZ3hDSzFUdW81azlNNXNRMWl5Y0VlWjF1WDFDNThadkplb3Zy?=
 =?utf-8?B?RFhyWnpWblplNy9vMUpidXU3YVR4TCs3WC95U29vODJnRWs5TUZZUjJCTUxh?=
 =?utf-8?B?SDViQlFWaUNURndRVU9WdC9pVGllL1ZXRm9oSHpWV3NMdlZnczQwYnQ3QVBY?=
 =?utf-8?B?a1pvZ0ZyQjBybU5ZRlpFMHp0Q3BmZlBqdERrbnRxMk5ZY3FJb3VsRG9vWGpv?=
 =?utf-8?B?OVoyQWpZbWNKSGh0UDBselhYY0lZQi94OU1ydWppQ3B4NVN4dTNtalk5SHdO?=
 =?utf-8?Q?OjM1hgiCZT7ARj/?=
X-Microsoft-Antispam-Message-Info: 7BTtU2U+w8Q2bGGwwT6Fr0aicu8SpQCmILn5w+8ASyPyi8vqLJjyFf9QcsxKZjXmQ0NyVwJ4tbJrcIKdrP0OKdoSb9lAWrWizYmQjrfNbU8rOExN7oR5BNy2w/CaHD80JSIhfVRuEqwSR3NHT+iUiELz/nOshf78gz7BXVv0INCHLrR8wqxPDmsmfsqpLZd1
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;6:Bdkla5wiY5TxCaqcPWsvgc7iYDDRtG+RYtiFd6i7PTBtHKfu133qzrsbN4j3vRzfkWoPj1piCSUdz8NoQHTSBXYbOU49KdV0e5KJkxL1MIDIIiKSTeXk0N7qXe6/VRlTuSMHlO3d0FZMh5tFap+ealAHbvpuf4KVFqu/1PtXif08LWZmw9aevfGdMtqsbgnbHpHJW3DR9chnbGLosiJ4JF/ZHdJ8gUjBTe3CY1w+7BEoLNZs+fXIl3LbALSYb5DZCwUNWYcPUjbJmKoUTKumRiyo4En4BJ2tbt6qIFu9182HHr3vqQimJMav/S8SvB6B1K+QHq8iMP/VCt8NG+tI3L+AK7BtHgi4HCQqWBoWfMhZTpS2AFmGpT4RVHh9wsQqh0IwOORcveJ06kP5ApLnErpVdlbEZdAo0Akpt+Li2pGndy4fS6oKWd/nhwoIqYr79vX6BrNcl4ScqASkBNH2HA==;5:5a1HsokBHqpVkRTTiZAtUbYvQOEW6XeiQ5aEmTCRyWOFyEv50zZROt9j88xBjqSgozID7PQ6h+69y35GjRlTMDUR/0UtiQ+veU6Oi1gLPTE3raB5myTsDrWINv9HA/ytBbDsOEVu99UKk4f+sVHlRklZC4VPD7jnhbx2I0cTRoE=;24:spdcns7jczs9Inuby+o6jm9Hj2E9PGRbe9SfluF0y7ye+LSwWZ21j9Bll2owcoxpsD7W7OvfxI/MZhEvzn1J+gaotfy4/fkzW7iGRn41GDk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;7:1ONne352PPxsR03363/qkbczTRopw5d21ohYLDrctp9Dar31xAqqc973hJQZM5Ep/43Vqs65VV8cIIXlI+da9OMBAymLXNzQFGSCc9KooD2sw8lFZCaXcIZfpsQrCkq9jFRs4hbxDEwPAWl/BEU+6Dxn4XwU5zC/kRCgT7DC4ZwB0abt8zavOY4ZoA8sW/R9uTNIfvU+CHOC5ey+oSOlh90BaTsXGHRHdUnDOcGfYksNogK2wnLVL+J+6IHujLfR;20:LkMzyKP0l43PLxZT46zVmyRTEqHGuix9IShdu8d7oKl1gUEZyiBM43QaTNqiVQBxOeQyxy91wnTJACNVhG5yEXfG/rr8jLvjqBZ9XYQM6WXA7Kd6cHnrCUMB4txhvmiFcoCuU46/95hVl3vea65VtBaHrhqLqYq1n/N8b040iWY=
X-MS-Office365-Filtering-Correlation-Id: cb621ada-98d6-44fe-e68e-08d5a909c3c7
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 11:02:52.6625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb621ada-98d6-44fe-e68e-08d5a909c3c7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1343
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598009310068873507?=
X-GMAIL-MSGID: =?utf-8?q?1598534589085368483?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 22.04.2018 20:59, Vladimir Davydov wrote:
> On Tue, Apr 17, 2018 at 09:53:31PM +0300, Kirill Tkhai wrote:
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
>>  include/linux/memcontrol.h |   15 +++++
>>  mm/memcontrol.c            |  125 ++++++++++++++++++++++++++++++++++++++++++++
>>  mm/vmscan.c                |   21 +++++++
>>  3 files changed, 160 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index af9eed2e3e04..2ec96ab46b01 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -115,6 +115,7 @@ struct mem_cgroup_per_node {
>>  	unsigned long		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
>>  
>>  	struct mem_cgroup_reclaim_iter	iter[DEF_PRIORITY + 1];
> 
>> +	struct memcg_shrinker_map __rcu	*shrinkers_map;
> 
> shrinker_map
> 
>>  
>>  	struct rb_node		tree_node;	/* RB tree node */
>>  	unsigned long		usage_in_excess;/* Set to the value by which */
>> @@ -153,6 +154,11 @@ struct mem_cgroup_thresholds {
>>  	struct mem_cgroup_threshold_ary *spare;
>>  };
>>  
>> +struct memcg_shrinker_map {
>> +	struct rcu_head rcu;
>> +	unsigned long map[0];
>> +};
>> +
> 
> This struct should be defined before struct mem_cgroup_per_node.
> 
> A comment explaining what this map is for and what it maps would be
> really helpful.
> 
>>  enum memcg_kmem_state {
>>  	KMEM_NONE,
>>  	KMEM_ALLOCATED,
>> @@ -1200,6 +1206,8 @@ extern int memcg_nr_cache_ids;
>>  void memcg_get_cache_ids(void);
>>  void memcg_put_cache_ids(void);
>>  
>> +extern int shrinkers_max_nr;
>> +
> 
> memcg_shrinker_id_max?
> 
>>  /*
>>   * Helper macro to loop through all memcg-specific caches. Callers must still
>>   * check if the cache is valid (it is either valid or NULL).
>> @@ -1223,6 +1231,13 @@ static inline int memcg_cache_id(struct mem_cgroup *memcg)
>>  	return memcg ? memcg->kmemcg_id : -1;
>>  }
>>  
>> +extern struct memcg_shrinker_map __rcu *root_shrinkers_map[];
>> +#define SHRINKERS_MAP(memcg, nid)					\
>> +	(memcg == root_mem_cgroup || !memcg ?				\
>> +	 root_shrinkers_map[nid] : memcg->nodeinfo[nid]->shrinkers_map)
>> +
>> +extern int expand_shrinker_maps(int old_id, int id);
>> +
> 
> I'm strongly against using a special map for the root cgroup. I'd prefer
> to disable this optimization for the root cgroup altogether and simply
> iterate over all registered shrinkers when it comes to global reclaim.
> It shouldn't degrade performance as the root cgroup is singular.
> 
>>  #else
>>  #define for_each_memcg_cache_index(_idx)	\
>>  	for (; NULL; )
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 2959a454a072..562dfb1be9ef 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -305,6 +305,113 @@ EXPORT_SYMBOL(memcg_kmem_enabled_key);
>>  
>>  struct workqueue_struct *memcg_kmem_cache_wq;
>>  
>> +static DECLARE_RWSEM(shrinkers_max_nr_rwsem);
> 
> Why rwsem? AFAIU you want to synchronize between two code paths: when a
> memory cgroup is allocated (or switched online?) to allocate a shrinker
> map for it and in the function growing shrinker maps for all cgroups.
> A mutex should be enough for this.
> 
>> +struct memcg_shrinker_map __rcu *root_shrinkers_map[MAX_NUMNODES] = { 0 };
>> +
>> +static void get_shrinkers_max_nr(void)
>> +{
>> +	down_read(&shrinkers_max_nr_rwsem);
>> +}
>> +
>> +static void put_shrinkers_max_nr(void)
>> +{
>> +	up_read(&shrinkers_max_nr_rwsem);
>> +}
>> +
>> +static void kvfree_map_rcu(struct rcu_head *head)
> 
> free_shrinker_map_rcu
> 
>> +{
>> +	kvfree(container_of(head, struct memcg_shrinker_map, rcu));
>> +}
>> +
>> +static int memcg_expand_maps(struct mem_cgroup *memcg, int nid,
> 
> Bad name: the function reallocates just one map, not many maps; the name
> doesn't indicate that it is about shrinkers; the name is inconsistent
> with alloc_shrinker_maps and free_shrinker_maps. Please fix.
> 
>> +			     int size, int old_size)
>> +{
>> +	struct memcg_shrinker_map *new, *old;
>> +
>> +	lockdep_assert_held(&shrinkers_max_nr_rwsem);
>> +
>> +	new = kvmalloc(sizeof(*new) + size, GFP_KERNEL);
>> +	if (!new)
>> +		return -ENOMEM;
>> +
>> +	/* Set all old bits, clear all new bits */
>> +	memset(new->map, (int)0xff, old_size);
>> +	memset((void *)new->map + old_size, 0, size - old_size);
>> +
>> +	old = rcu_dereference_protected(SHRINKERS_MAP(memcg, nid), true);
>> +
>> +	if (memcg)
>> +		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinkers_map, new);
>> +	else
>> +		rcu_assign_pointer(root_shrinkers_map[nid], new);
>> +
>> +	if (old)
>> +		call_rcu(&old->rcu, kvfree_map_rcu);
>> +
>> +	return 0;
>> +}
>> +
>> +static int alloc_shrinker_maps(struct mem_cgroup *memcg, int nid)
>> +{
>> +	/* Skip allocation, when we're initializing root_mem_cgroup */
>> +	if (!root_mem_cgroup)
>> +		return 0;
>> +
>> +	return memcg_expand_maps(memcg, nid, shrinkers_max_nr/BITS_PER_BYTE, 0);
>> +}
>> +
>> +static void free_shrinker_maps(struct mem_cgroup *memcg,
>> +			       struct mem_cgroup_per_node *pn)
>> +{
>> +	struct memcg_shrinker_map *map;
>> +
>> +	if (memcg == root_mem_cgroup)
>> +		return;
>> +
>> +	/* IDR unhashed long ago, and expand_shrinker_maps can't race with us */
>> +	map = rcu_dereference_protected(pn->shrinkers_map, true);
>> +	kvfree_map_rcu(&map->rcu);
>> +}
>> +
>> +static struct idr mem_cgroup_idr;
>> +
>> +int expand_shrinker_maps(int old_nr, int nr)
>> +{
>> +	int id, size, old_size, node, ret;
>> +	struct mem_cgroup *memcg;
>> +
>> +	old_size = old_nr / BITS_PER_BYTE;
>> +	size = nr / BITS_PER_BYTE;
>> +
>> +	down_write(&shrinkers_max_nr_rwsem);
>> +	for_each_node(node) {
> 
> Iterating over cgroups first, numa nodes second seems like a better idea
> to me. I think you should fold for_each_node in memcg_expand_maps.

This function is also used in alloc_shrinker_maps(), which has node id argument.
We can't change the order, since maps are stored into memcg_cgroup::nodeinfo[nid].

> 
>> +		idr_for_each_entry(&mem_cgroup_idr, memcg, id) {
> 
> Iterating over mem_cgroup_idr looks strange. Why don't you use
> for_each_mem_cgroup?
> 
>> +			if (id == 1)
>> +				memcg = NULL;
>> +			ret = memcg_expand_maps(memcg, node, size, old_size);
>> +			if (ret)
>> +				goto unlock;
>> +		}
>> +
>> +		/* root_mem_cgroup is not initialized yet */
>> +		if (id == 0)
>> +			ret = memcg_expand_maps(NULL, node, size, old_size);
>> +	}
>> +unlock:
>> +	up_write(&shrinkers_max_nr_rwsem);
>> +	return ret;
>> +}
>> +#else /* CONFIG_SLOB */
>> +static void get_shrinkers_max_nr(void) { }
>> +static void put_shrinkers_max_nr(void) { }
>> +
>> +static int alloc_shrinker_maps(struct mem_cgroup *memcg, int nid)
>> +{
>> +	return 0;
>> +}
>> +static void free_shrinker_maps(struct mem_cgroup *memcg,
>> +			       struct mem_cgroup_per_node *pn) { }
>> +
>>  #endif /* !CONFIG_SLOB */
>>  
>>  /**
>> @@ -3002,6 +3109,8 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
>>  }
>>  
>>  #ifndef CONFIG_SLOB
>> +int shrinkers_max_nr;
>> +
>>  static int memcg_online_kmem(struct mem_cgroup *memcg)
>>  {
>>  	int memcg_id;
>> @@ -4266,7 +4375,10 @@ static DEFINE_IDR(mem_cgroup_idr);
>>  static void mem_cgroup_id_remove(struct mem_cgroup *memcg)
>>  {
>>  	if (memcg->id.id > 0) {
>> +		/* Removing IDR must be visible for expand_shrinker_maps() */
>> +		get_shrinkers_max_nr();
>>  		idr_remove(&mem_cgroup_idr, memcg->id.id);
>> +		put_shrinkers_max_nr();
>>  		memcg->id.id = 0;
>>  	}
>>  }
>> @@ -4333,12 +4445,17 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
>>  	if (!pn->lruvec_stat_cpu)
>>  		goto err_pcpu;
>>  
>> +	if (alloc_shrinker_maps(memcg, node))
>> +		goto err_maps;
>> +
>>  	lruvec_init(&pn->lruvec);
>>  	pn->usage_in_excess = 0;
>>  	pn->on_tree = false;
>>  	pn->memcg = memcg;
>>  	return 0;
>>  
>> +err_maps:
>> +	free_percpu(pn->lruvec_stat_cpu);
>>  err_pcpu:
>>  	memcg->nodeinfo[node] = NULL;
>>  	kfree(pn);
>> @@ -4352,6 +4469,7 @@ static void free_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
>>  	if (!pn)
>>  		return;
>>  
>> +	free_shrinker_maps(memcg, pn);
>>  	free_percpu(pn->lruvec_stat_cpu);
>>  	kfree(pn);
>>  }
>> @@ -4407,13 +4525,18 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
>>  #ifdef CONFIG_CGROUP_WRITEBACK
>>  	INIT_LIST_HEAD(&memcg->cgwb_list);
>>  #endif
>> +
>> +	get_shrinkers_max_nr();
>>  	for_each_node(node)
>> -		if (alloc_mem_cgroup_per_node_info(memcg, node))
>> +		if (alloc_mem_cgroup_per_node_info(memcg, node)) {
>> +			put_shrinkers_max_nr();
>>  			goto fail;
>> +		}
>>  
>>  	memcg->id.id = idr_alloc(&mem_cgroup_idr, memcg,
>>  				 1, MEM_CGROUP_ID_MAX,
>>  				 GFP_KERNEL);
>> +	put_shrinkers_max_nr();
>>  	if (memcg->id.id < 0)
>>  		goto fail;
>>  
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 4f02fe83537e..f63eb5596c35 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -172,6 +172,22 @@ static DECLARE_RWSEM(shrinker_rwsem);
>>  #if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
>>  static DEFINE_IDR(shrinkers_id_idr);
>>  
>> +static int expand_shrinker_id(int id)
>> +{
>> +	if (likely(id < shrinkers_max_nr))
>> +		return 0;
>> +
>> +	id = shrinkers_max_nr * 2;
>> +	if (id == 0)
>> +		id = BITS_PER_BYTE;
>> +
>> +	if (expand_shrinker_maps(shrinkers_max_nr, id))
>> +		return -ENOMEM;
>> +
>> +	shrinkers_max_nr = id;
>> +	return 0;
>> +}
>> +
> 
> I think this function should live in memcontrol.c and shrinkers_max_nr
> should be private to memcontrol.c.
> 
>>  static int add_memcg_shrinker(struct shrinker *shrinker)
>>  {
>>  	int id, ret;
>> @@ -180,6 +196,11 @@ static int add_memcg_shrinker(struct shrinker *shrinker)
>>  	ret = id = idr_alloc(&shrinkers_id_idr, shrinker, 0, 0, GFP_KERNEL);
>>  	if (ret < 0)
>>  		goto unlock;
>> +	ret = expand_shrinker_id(id);
>> +	if (ret < 0) {
>> +		idr_remove(&shrinkers_id_idr, id);
>> +		goto unlock;
>> +	}
>>  	shrinker->id = id;
>>  	ret = 0;
>>  unlock:
>>
