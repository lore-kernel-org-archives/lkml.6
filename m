Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx49YmMopeo7jHEYMRye5CGOGG2LTkd9jjyiCz/a6cTC+J+fx5xNCAPBtGLfA4kG1rzMNcCx3
ARC-Seal: i=1; a=rsa-sha256; t=1524480898; cv=none;
        d=google.com; s=arc-20160816;
        b=pvYeyY1/4035Y147Uzy8x6ar2YpbuS9QMifzz1/leyj8x8krIPtlfHPGj9RcWc3yxI
         Oj/wpxcjRwekebC8QiP3j3s1MJ3zteccTZLseMNWUg4s5mczho03b7J7H1uOZogjp5nO
         Fn7HB3zMCudWDt+isLPWiyMJPppTG7V/6Mw8xQGf3oDn/iyLkuJgUQkN8Gtv1Ew9F6EY
         gDzfAjX0wDvHmIevvHLa3Bs7ROsBbPp1UlRy2mc7KJ8GDCJITPer7XeyXfXvEzsHeLM3
         7ALasjaJfXWX2WTlotUmSU/wD+Hi7RCxXBGs+MeEvDijubsg9R9tOOWaCjvxuC/AGbk4
         +2Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=tYAMirhszCp3ak6wtUdOYMSVnIp2GqFdifq8OWh5Wd4=;
        b=vlHRIMtmn1hm4zbhIvpJC3CQYXvhiKreHLn2u3LGeD4Y4ZEI4RA6BNPJQxbsc7VqHN
         i5ve4Oxm975tZXie/ZclA/SN0flsA+tkkEtmPWhSGdWAjeFZ0TJk22K/EJ22FUpeg5PW
         M0RveWa2iNkkAo9+8w1csjmgw5/c4k/wWXgog1BVxlkA5r3QqyOUjk24DKNmdxrxArNU
         Id+UBcCtyLTrxAJ2t5W1Fbda81SPSvkmgRHAvsm3hLZAlpdaYsTODHe+5nNz+gXoxnCd
         ZsvQKksaYI+jIegfFqPX8TgEwYxqLxjTOCqm+Iunl5FwIJgc5cRUHbcJQj9pN4fUNuff
         v85g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=R7CgyOFm;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.109 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=R7CgyOFm;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.109 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
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
Message-ID: <14ebcccf-3ea8-59f4-d7ea-793aaba632c0@virtuozzo.com>
Date: Mon, 23 Apr 2018 13:54:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180422175900.dsjmm7gt2nsqj3er@esperanza>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR09CA0064.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::32) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:R1n3K83A3SYIKOEZBinzY9pIQWqi3FZ+AP9vAc7YUx7t25xIo9ZBe2HtouJVRM1AVv7zb+MDW1Yk3/vH6IOzrgpKX6rC0HFYobj4xhkqk5zPBZsVM9EXPBbNGS1aEiKFlVSi0fOO1BKSXD2TU2Ami2rnZgCXa8xONc0w7iMnDqzBPDVuStGwKTwjdtMSW1FcRwTBY4j4qFFbp7m+qBnE72eVdRrHjO98OrVtVIy9zv1TsA02lXW8ivkbJFFKIKxP;25:Ikax59xuNMo35Zr8Z6Y7szy7kvXY6VRqa2/qpS6RMr1ln8IcMZwGSDNsXh0sEJ4GoSDIo8el1S+E7e2upUFRgzIAwEaqV2VeyKkgTJxG/H2EZnw/e6ieqTCEzbGNcK18Wn5QZIx4dPg4QwlOxXm3cE7snj9Z5RSg+zdGnOj+IuyPIWHycWIK1pveTafMuoOsUBJyG6x+o+sB+2OdztBpabFsf0u+oHlrtyf/EsQ1KrB5dPR537wxf9gDejl601v3Sp5s6vo01jIQsnoqkYxy1+sq70M99pNDyVwIYvZNScDrKLLN01eRVVmZwfmCLqdWaJXv9WEM/tocKkioaUrxnA==;31:147yl6oot9xJ9d6NyXneMgSSoM+yhld1HljZ/y6sT/I6MKOyzAcp4v5MwKOB4q3brxOM2Z6mv9VldSdiM/cwGcbydrQANlAQD+Ypv6h1/QP0NVb1FbixFUbz9iYWVtF7GERyp2gxEgbKwklOor0G9ikMcL3K+ZqLN70rEU2wZNjGlLBghYL/+9Tlsqtc6Vgdh23Ijt0bA1wXWDurE1yiOxpyFzSGZHyG7aVYU1vPoaY=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:nA6AjMXvf2yraEF7nr4ZatPlyXq2X2y9Ws2/sxlPcyKPucsgn9JzquVgBcAOcYEW0p+I33IB+EbQZwkl2B79AQ4eN27woLLF4iSB5ycMGZ5N6IqIB9eH/bPpqHN7ruUm6Xxx++J76Tgrm/tNXkFlLKHHa089O+5/F/b6Pg0xR0ff5MU6qQA3ahqHr574e0HeGV++TWIcfPh2uQl7sDtc+BePJCVlUbYjg+gYTtNZyXGnRPFU5+ieLM2XK5AuxJFtm511bXTyOwxj2dt1Eg1artsStrtmViXYHJD4LZtbhirB3mnByWX6squZc4YlB0VWaUULHqxGJjOunJCsRcg09evEqPr07j1fL8A+8AhFZ134cG1h8KFCZ/LVFqWLx85TnC16re04BSEy2COYBHrd/6RTW7YXA33vQ+AvQf2d1+n5Oh3OW6qUjc0IA8WyhOXhiivzoFyzIsLRT6ih1QupvzHOexbXcTpdVeA1y2Rrp2q3ZibAhMHOxH5TEYwEGnje;4:NE+RyHwFnQ6NC2HWge9YkIb6UhDgQ5oCN8LsdxIb7Gh919biNl4OonXxODz7QfKGGZEMRxc855fGEDbg4Zwyxn0xt5H7VmwQB4F7WmXJX+7boAT6ksvcsUjD6+SdtMCAxkwxDg6LdcHVwuU4ccio+n/QZldunF4SvMCnQVS1yc2hKAuNuIhB28RTCY4G+1B898iE8BojQaW1ahIRxen1toH1MPXHfg0avfuaFXtfZik2lR+YBdWZLoSBzJbQHAWvfjGEZzcHOF278oE21l/iBqaqaUduF/xxcQQvnxkginlQKZPLU1gNVihsuE6D1DFd
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1338E8E12CCB0EDCC7991130CD890@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231232)(944501410)(52105095)(93006095)(93001095)(10201501046)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(366004)(376002)(346002)(39840400004)(396003)(59450400001)(6246003)(47776003)(16576012)(36756003)(65806001)(66066001)(316002)(39060400002)(386003)(58126008)(7416002)(76176011)(65956001)(64126003)(478600001)(52116002)(53936002)(25786009)(4326008)(2906002)(53546011)(107886003)(8936002)(31686004)(81166006)(8676002)(5660300001)(65826007)(7736002)(3846002)(6116002)(230700001)(305945005)(86362001)(6486002)(26005)(446003)(6916009)(2486003)(2616005)(11346002)(50466002)(956004)(476003)(31696002)(16526019)(229853002)(77096007)(52146003)(23676004);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:[172.16.25.5];FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6enlLTnV0WDZTNXpTWEVZdFR2TTQ0bWZ5?=
 =?utf-8?B?cyt1N2Y4dDUyQlRKREJ3NUUyUS9tMGJxdkpsaGtxUS9WaDNGQ1FXdHVFWUMx?=
 =?utf-8?B?bkZZTDIyTSs2VlNLWmZ5SEdRZjR3N1IxTVNZRWY2M0tkN25pcDNIaFFOM1I4?=
 =?utf-8?B?RHp4RmRFVVVTMWU4eEM0cTBvSjFYZmJaQmgwVDNoWElSaTA0RVdVRzRTaGQ5?=
 =?utf-8?B?TzNqMzJvUEZzWnR2bEV3NzlxMnRzajV1WFh3dzk5QmN2VkRNVVBGYStCek41?=
 =?utf-8?B?UHN1OS9vQmlPTVhWRWxCTlZIbW93RmxIWVBpK1B2TEE1TFlZMnpudXlUb1d1?=
 =?utf-8?B?aU1BcUN0b0NmZFNUUVlRZy9pdVk1bjlZNDFqVFVNNWJsWDl3a29ndkw4RlZx?=
 =?utf-8?B?d3ZMRHUwYTV0ZGUrS2pteFdsQlVIdkR5NlZPRnNBZHVndFpRMmk0WVVHOWN4?=
 =?utf-8?B?K2dmRHpMRlVZYUhGTDBzMWdWR00yM3FQWlBTdzRscGF1YnRUeVNuamh2NVZF?=
 =?utf-8?B?R2lhYjd4MHZXREozV1pDMmtCWjVRMitIdlZOZDFLL0VJZTc2enAzZVhBYlRi?=
 =?utf-8?B?dFc2dWsrdE1tcUtWR1FLcWpha0FlL2hGK0tUZTVSRXRzei9jWklPdzIzQXNh?=
 =?utf-8?B?TWdWdUVoalB5OUw5SDZEM0RvOUtJRk5vTDA5MXNmNzdSUzlJbWovMWNBRVVT?=
 =?utf-8?B?SHRhSGdWVmVSdkNCR0hJQ0NZUzlEOENOeG1qUW5CenRmcnA3SXY1bzZ4blFy?=
 =?utf-8?B?akhqdWg4dG9JNzhJR2hKL3E1SnZKbHQyTUFsaUVJWVA2ZHRBLzFEK29jWXlQ?=
 =?utf-8?B?WDdjUU9rY0pEd1RDQ2lmbTBVbGpPRDZINVFwMEZMUVJZSzNEUlJaTUdTeWZs?=
 =?utf-8?B?ZmFzaVNwbTVxMWIyTm15cDR2bW9xbXRobDQvYmxnb2kvM09KTGtnSkM4MVpT?=
 =?utf-8?B?TGo5QWcrcDJ5Ui9VQmVER3N3VDIxRFlGOGZRbDY0SWdha0lqZUZPMVU4eVl3?=
 =?utf-8?B?blF0SkRKS3MzUFZYbU5JS3FPWmU3N1JudkVHcEU5SDYwc1M1bkFqbTFORVNV?=
 =?utf-8?B?bFY1dGQ3RkxKdlRUcXZwVmk0VWNHK2NjaVE4a1NrYWdOMUkwanNmZFVXV3M5?=
 =?utf-8?B?bFlqWFdidVVrTkJmWUxlRFN3VXVJRjJNU1Q2OHBxWGRkbUFOZkJVelhuMDAr?=
 =?utf-8?B?VUw4V3dDSVNjTS92T2ptSEVuSklRRGJrMVRNSVlVUDdYbDlmUEtKTHZZbW5I?=
 =?utf-8?B?cFNUT0pObmtDeHFnUjQvNDdoaHNzeUlxZ1hpeDkzY1Uvc1doSE9KMktJL3Vx?=
 =?utf-8?B?NURKV21NRm9vZmpMaDFaS0ZRRVVOMUwrT3J0SVFqSHpLVlZQSkF2OWNSUUlE?=
 =?utf-8?B?UUpENCtqNzNhZkgwOTl6cnRrcENDMmdrVVNIS0VLVHVIbHdjS1ZvQjl1M3RH?=
 =?utf-8?B?dGdtU2daUkxhYmprWm9NWXhwM0UrVjM2T3lLM21yTDlLUmJsRlZKV2ZGSy92?=
 =?utf-8?B?SzQrenUveE1mL0ZXeCtBdXF5L2p6dW1tZ2ZnajJsZ0pURkx1SEdqM3gwL1Mv?=
 =?utf-8?B?KzVaRHlYZ2NraS9uMnRYWC9maXJxL2pJMWdYQ3d6SzlSSGVwZFVUVlVBUEVj?=
 =?utf-8?B?cWZBZUxYQmsrbHRBSzhnemVqMWpHTHRJbUptd2swS0NaWk9uV1Z0aUl4ZVlD?=
 =?utf-8?B?SUdVbjVoMnhEMWx4d2F3OTBqTFQ1MHdkZWFtRFFDTklHaWk2WS9qWXZDbEs4?=
 =?utf-8?Q?PhdlHzqSRsxMEWT/9kYSwW3WEUNhzWJ4yKEAleY=3D?=
X-Microsoft-Antispam-Message-Info: CQo9EVBUdjve6LZG/+IbiKsvX4GnhIErnWV4/yVGFxF7scjCdrv1gqYMnTtvLwxOqLCpyZynS12ViHXoqgC6CHPhs5iAigXVZDQLyMTkbyHwN14a1CFXTCMuif6sX7BDr8w0RdmDmohFCmfQZWhARbWHzNKk8Pn97/KvbVv/cUdbMnfnavHSXXfkDibF4UnZ
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:fFv7a8rGa338OrFTpbDMoX/kjcSqtOP4dKR+shSvWUbU78ilrCZLWeB+FH4/zSqIKtp0ezG3A9CA6zAw1EsOv29adr87OdBUug9l/+GdbmJ55ftXPpYFjcT7xen5AHpjg7gzjmHpXU1LDFAWmWjSwMc+D6Tx4d3Rb6o13XHECcaRKuvu5u/FiXW09S1CgLd1Z149Z20vLK0wTOGfbfIPIU181OzMxwTFCMckVYDhIQ+2SVKWCqtoYdrtvbudW7D8USfg2D0+1UhVSIBjh/35qlmExMa0MFsgNtbuBfORBWwzYfqYn7YeP/GosN218ZvSSHUU5hN2etkfmy/wURtznQl5mHyZCewd0FpgteqWUnMey5qiv1+lEmIY34CvzzCxUTIprW6zeijw4UhIw0oxqLrnS0Zwc1KdWom4l2pL3Iq2R9l6s77N0+SqXtHmaU6gTv7jMEBPiohi9Btvs8L90g==;5:KCYmoh/f9J1Pv1PllQ/9pV05AXVt3/FdnXX+V0OF6U08FLevCis5MtGmijKxPARiJUgE2z+b+5evBW2rLMYD444vt4xBT+aK86ifGn2CN38c7Nq60Wht3d8EPLzskvQVzTruYIgNk1XPNYIv0wX0Qozu0ABODlTFpJZkdc0hiMk=;24:obBntjjhJT0t/cFOX45jNQycz3lakvsRoARLxP33pj4v7nMWafCyDF+89bQiLQkhktga9uUvCzzsYwf7nYGov5RbWKcNaT1oXBAbOh+ldyk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;7:I7hu+FdjMwWVwGe1msGiEwrRoRW2l4mSkV7dD85mi2Aich5/jbOltMFuOTfgh930IcwdbZoSKuQADNTToXl6sS48y7f2gzsH69SswLS5C9JfWSrcaJIwQD4UUmgqFau7RQM+M9dFEY86LjF+pyoVHX7pJp6reYaMBUb3Lz4ZlBnYRRzLsOmjFn0TKzvhf0ppU9l5Wo6bTraa2bzayCHwqbF+apYFx76E9YtoydY6baZTs3j+J8JVNSuM3ZIKz3V8;20:4cnqv64z5vksnqfVt0aH56gO59UEfIzVoIpiMs2gVvCn8Ex3Ij3mO+1eTyzR51ydMb12ZKRGe4HuipfYMpCIFBJuH8bMj2jII4+uZa/h6Iv8tDoq3VjAMHeY3GoQmY2sapw2ZevB1TX6yB3TQAl+bZ4NHeGKFISRjlKR41pOPfM=
X-MS-Office365-Filtering-Correlation-Id: d2018345-52dc-4e56-c960-08d5a908a4ff
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 10:54:52.6164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2018345-52dc-4e56-c960-08d5a908a4ff
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598009310068873507?=
X-GMAIL-MSGID: =?utf-8?q?1598534082485823672?=
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

memcg_shrinker_id_max sounds like an includive value, doesn't it?
While shrinker->id < shrinker_max_nr.

Let's better use memcg_shrinker_nr_max.

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
>
>> +		idr_for_each_entry(&mem_cgroup_idr, memcg, id) {
> 
> Iterating over mem_cgroup_idr looks strange. Why don't you use
> for_each_mem_cgroup?

We want to allocate shrinkers maps in mem_cgroup_css_alloc(), since
mem_cgroup_css_online() mustn't fail (it's a requirement of currently
existing design of memcg_cgroup::id).

A new memcg is added to parent's list between two of these calls:

css_create()
  ss->css_alloc()
  list_add_tail_rcu(&css->sibling, &parent_css->children)
  ss->css_online()


for_each_mem_cgroup() does not see allocated, but not linked children.
 
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
