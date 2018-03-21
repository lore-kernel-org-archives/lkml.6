Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AG47ELuvUVn+4ScO+09PjisQG9XfFPzDAopg46KC/nzTIXrKE3INhZiHp/sYQb+t2hlHBotV2Yvj
ARC-Seal: i=1; a=rsa-sha256; t=1521645146; cv=none;
        d=google.com; s=arc-20160816;
        b=ixbcoYs0X9gf+D4Q8obLe17nkgPLm7o9P+V6K0Lw+x7FbQaAqrk2/Kn42IZjPWw3si
         mtCTE4dW9tpGl/KedtVNLmu3lz0PVtZoZqiOGfoPCMbyfW5UwaZgoh9BXt/oagJwhRV9
         1bNyRmedCE3H1I889JdhuQtgrpLjXTi/f4yOwilzHNbM4PqqqKowTZiz0S94S1lTouxn
         5YkfHdzS44RNhRNEQHsaCVypwHL3DXOqM6YYnp7u6H5I0c3CtjycYaBsAQg3tHY6K95i
         dFgG9cywt+TgMy+pB7CM3eH3O4LcjKiqXwt1to8wDWgAR9BJ/CyFc3ys+nBFNdLihVg/
         4QFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=lzHzdvusO6BmJqsUuou9gTcsGXXuAFUSTaZxwE0ggnA=;
        b=Z/MT1qzEIiUnto4xywa6/TMvucKHGSiQOhRwoa3IF6UqGlEANtjkrP6V74HUG5CvFB
         iVN2DMSgYDDVGIOkzh4JM9DIm0C7bGVGuc1JecdCn/gN6snIwiqG3ysOYyWUftlmQPJg
         DUCwe9oRI3WL5TqvhNmf+OJfSl+PIJs/0hZY1bUdPG1AUBP2f8mTuAB4fBA2C/DlAurr
         g9uUQ+2zD5YEPE1j7pvoWfPIhcHJQvI9BO7wfVv5GdsiBxwylWMQvUS+3JICMrlkzH7/
         ndJJfqZgWzWVt65DIqeIIC+kEPqYiUoy4XSGJxIG7vioHcYZohDVkvdT5LrAsRblC5UD
         jzpw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=IVxhz/x+;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.96 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=IVxhz/x+;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.96 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Subject: Re: [PATCH 03/10] mm: Assign memcg-aware shrinkers bitmap to memcg
To: Matthew Wilcox <willy@infradead.org>
Cc: viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 vdavydov.dev@gmail.com, akpm@linux-foundation.org, tglx@linutronix.de,
 pombredanne@nexb.com, stummala@codeaurora.org, gregkh@linuxfoundation.org,
 sfr@canb.auug.org.au, guro@fb.com, mka@chromium.org,
 penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
 longman@redhat.com, minchan@kernel.org, hillf.zj@alibaba-inc.com,
 ying.huang@intel.com, mgorman@techsingularity.net, shakeelb@google.com,
 jbacik@fb.com, linux@roeck-us.net, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
 <152163850081.21546.6969747084834474733.stgit@localhost.localdomain>
 <20180321145625.GA4780@bombadil.infradead.org>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <eda62454-5788-4f65-c2b5-719d4a98cb2a@virtuozzo.com>
Date: Wed, 21 Mar 2018 18:12:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180321145625.GA4780@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: DB6P193CA0023.EURP193.PROD.OUTLOOK.COM (2603:10a6:6:29::33)
 To HE1PR0801MB1340.eurprd08.prod.outlook.com (2603:10a6:3:3a::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e9ef4ab-4643-41cc-2245-08d58f3e2635
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1340;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;3:HjdP4Js3WGgcJmlw89LBN/3fve3gzPHi1/LzpfRYDmYcmgec1kweUGy1N2WvZZYipeUnl2umv1i6slyHol9dynEAU1kWVEc44Em8ZPLX88wUEZP3xyIy5kFuIsUP5f62Kb4mf6avgpknQ+CmzDo9UykQGpJJVneNYFlI1CQooH3DQyD59SGiD1sp2IIGTKK3Z7fz+zzrsRcogCJxKVDba572s5sknjDOUfpBo4/9USNPoXuYojrhnf4zyLHNq4N0;25:brcc0rTcX1eF8k46IBsGXM3NZlPc2TnXdI5/YnYbWD5K7V0ifcM7SB9k5igSgbAJP07SzF5dbFUHgx+qP3A78D/XYSGAx+D3vOUHUKs4U+fG0zoRZc2rDEtcWVSWqkBEC7w+0vsQT6tcoctvH9cCYQRXyVStl4FOJEEgcR6sV0rR9xg9hG00dgGt/58lCe2YCczUQyOnCGoo0AThy82aSlZc3x7HKduKY2P01B0UlY4+vXCS+HRXmtsteJQnwLi5RSZ/Yny+c1AbXHL9PBUeieggYqatoMSwlVh1tdWCPn72d6CNPSxOqeN8h/TBzwr7YZm5Fw6xY5tJevG5CTuiDA==;31:Brb+rVKm7jKhJfFCeSsi35NogV9j0mQ/v9p0H4bwMPOWlYCcWIBC6PvwgDlhf1oomSCTnOMpJWhMO59pFGgzYwlpBpAeCzoLjEmp0chA1tqau7Dph3N/gcZfuOzSZtMb4Uy8B5KGa+X3DYgHYH5bKYF+sfbiZo84o9vYdYE5qopeeytVSb6FB05RmCJLkouzS7U/pmlxemAVCreQDqIjPQVdGAe5dYxRkJfqLIkBwUw=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1340:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;20:QIabvcHJ4t8LQOhB84lKkdV1lQ35MSGlpypElTq5KDdgzs/hp8M9249/m1+CtaHeMYP7h7uMwqbiO/tIn3Flzxez0B0t59sYZyerLlb7tJKSLH/8C8Szz/IGVHYtiGVaI4w669IiW44tKznuANYZO9Fh0A/kSfnudrijLFufEZ/IvXP6Bi0+eB9TOM4nR8DHI08X7t+XItOr6xT04zbWOThvl5y/7Qmy78GzO04UEwWtgIaaAPbenegmmbwvDJCjuzE4Dim3pYs29P7xU8idDiTMiB2X8mT263Pm61xA61Lblb9DsL0hJbaWCsdpCJLECRQjUA/4Xv3Kr+6FU+bgpvbQrg4CxDRQBzYiMxSN0ysaVopfqs+8JJoO49oT/4w3qek0VM8+d2uRMUxLFBYPuNvvt23CZ9/K2+ttOKwk8PXdmDl0eQa5YOOlf28bupL9q0w70JOAiCowmD8gMWiR1xJeSJ6gySMDOBUghyVNFv1wxQJNKiWxxy5pn7gUjHE2;4:8O8EHCA/wsbd4eXaxRQxRRWtr6lDXTC8mOQE6LXiRuLMCV8dCusaAG0k073zc0rP4yB93+rMU+vAJxaC0XorPLzFgIItnZdDN9X4RUjvJ5KotjI8omYUbQUJnCFg/xl6ug4reUtylQEmEuW9lT6GjuT6K2I7gSkoGCuWRj+7v/b+QaLiWzpDFYEz2OsT6j+LkejrVAsDxflBx5pVp3TRb2kK6fmM+TsHYBL7lEES4jvAYXAsR1EUXY3GjnagN8VfGI7IiO/f7r37h6TCGS6qTA==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB134014EFD7AC16DC0A454D9FCDAA0@HE1PR0801MB1340.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231221)(944501324)(52105095)(93006095)(93001095)(3002001)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR0801MB1340;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1340;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(39380400002)(376002)(39850400004)(346002)(366004)(189003)(199004)(105586002)(39060400002)(8936002)(81166006)(316002)(86362001)(230700001)(229853002)(8676002)(2906002)(58126008)(16576012)(106356001)(55236004)(31696002)(4326008)(36756003)(50466002)(386003)(53546011)(65956001)(66066001)(25786009)(6486002)(186003)(31686004)(47776003)(53936002)(52116002)(23676004)(52146003)(2486003)(81156014)(7416002)(16526019)(65806001)(26005)(5660300001)(6916009)(305945005)(2950100002)(59450400001)(65826007)(6116002)(6246003)(64126003)(76176011)(77096007)(478600001)(3846002)(68736007)(7736002)(6666003)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1340;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzNDA7MjM6amlqZXVGdDl6dVVJdHdLOVN6bElkcGsx?=
 =?utf-8?B?aXFTbkJ0aHY2MGd0b2I1dlhSYkU1cjJjWlhzWlYyWDFhbzJmQm5Bc3VUb01U?=
 =?utf-8?B?UVk5Vzlia0Z0bkJ0RzFnTnVQaFBuOFJjQmtJVmkzN1ZObTY3OFo1QXZtei90?=
 =?utf-8?B?WWZFeTh4ZXFQSFFrZStHQk5oamVuNU9NaFUwaGYxTmtPS29KWU00a0JsUmtq?=
 =?utf-8?B?ckE4SmwyK3RCWmJhelJZQUZHMUYzdXF3NnR2eENZclZJV2w2VnJodC9YZkpm?=
 =?utf-8?B?QW82VW5GdW45eUh4bGRYUCs2MnM3RHVrZGRlRXV1alF4cEFqNHIyWlU1dmdm?=
 =?utf-8?B?Ym9yd01RalJ6eU9SYVQvZnBRMHE4dTZ3Qm5wUDdVN0l3UVZrZ0lRdEhPdTRH?=
 =?utf-8?B?T2hRc0c0aVp3WXBpa1N4dmxaeUFDaUk1SDNlbklVZDBFbXZya1NlZEJYZ1J0?=
 =?utf-8?B?am9RNmJFd0ptM3hQUFpSVHhBc2xUM1ZZUWRWZStOa3dwUVRUNytiZUVEeGln?=
 =?utf-8?B?U212bFo4SXVwcStybG1pQndvUDJIV1BST1JSTVZwNmVKbGZiaUdXVVBaK1VC?=
 =?utf-8?B?VlFDeGNURjdVZVIrTk8xV3ZvTWVEYmJiTmpiMnhRRG1qdUtMdWhrdldjdzNu?=
 =?utf-8?B?NTUySUNKd0d0WndkT1E3bm9PRzgzc21XWTkzSUR1bGR4VEMxUlR1UnJReG9q?=
 =?utf-8?B?L205K3JHRlkzSmhEMHcvelpMQlo0ZVVqTXl6VnA4cm9VRlk1STFIYmhJcHNZ?=
 =?utf-8?B?ZzFrc2MrYjFScUV3V0tXNlBGbXg1Yyt3REM5ak1kL1ZwQlVQOXcyeGRPYStJ?=
 =?utf-8?B?NzRWWlNweEIwZlJ6L1ZPZTlCaFNRK2krcXlIZWdQTlROOHhYTmxldkJWbHk4?=
 =?utf-8?B?MVpPRmE1cXo5YTZIL3hqZjZyVHpqeW1ROXZJcDNkdmlSQTVka21OQWJXSWhW?=
 =?utf-8?B?OWxaS3NXcmRyZFRaTVZZVU1ZclFjZ0FGa0dBdU1nbUdMbFNIbUtxNVhmdmlh?=
 =?utf-8?B?Q3RyalplbGI0dk52NEwyaitUcXpkUmN2NHlzMElwQXFoNXZwSkhHRXNoU1pO?=
 =?utf-8?B?QU1kNmVwUUJRRHltN1RvSXBheXZWeWhBQU9xRFo0czJUUGdrYWNiUi9oRHZP?=
 =?utf-8?B?VVJiOWZJRTlZUUwycm14RVY5bVBSSnZPYzNHRmdxbjVMVVJuekFtZE1uQUpS?=
 =?utf-8?B?YXdKcmY1SzRxRHVla290VEphTmlUY3A0VzRTNnhnalJ0eUlYdjMzQjhNd3Ba?=
 =?utf-8?B?VU9wU2lDUEVQaXFpSmdyWkxpRFhlSUQrUmhWR0pjOXN4eWNJVVJJckpqL1M5?=
 =?utf-8?B?RGZzMjBLWGFZRllVTEpybTY1OS81WmhYSUhqNFJVR094MzlvcnVIem10L1RL?=
 =?utf-8?B?NFQ3bEVKcXUwQm8yeVNvSEh0Tk1nU1p1YmNOYmxFY3BsYnNleGlIZTluOTd4?=
 =?utf-8?B?Q1UzckFOVTY1TzN6c2oxaVdmcnNRWEZkdkVyUUpNQ1l0ZUV3RUU3b0JPd3JW?=
 =?utf-8?B?bU94SEVnY2E2UTl1Sm8wN1pMMkx2bmdwVXZLYTZQMnljVlZjN2tqWExnRzQ2?=
 =?utf-8?B?dTV4ODRZcm5sVk95WUM4RnJFQ1VjMEtJQWlieENwY3FVWGtTMDQ2U3ZPWG9w?=
 =?utf-8?B?VTZzNGI3Uzl1dk1sMlNkeDlWdm5MVmhFQjZMOUxld0NHUDJuTk5Cdk9KUWFV?=
 =?utf-8?B?cER0Yit4NmVjMHo3Qy9VUFV6QUVvUTZ5N2t2ZjRyMGc3SUdnWlJrZUhOYWlN?=
 =?utf-8?B?MEpvWlNEQmQ3bm1Ubng1STVCTjdYUkdLVmJXNmNncFVxSFB6cjVNTWVzYWFR?=
 =?utf-8?B?R253OGQzL1RrZmxUV09iMDJreVpyeHR2Y2Z4NC9nZFVGUFQ1OXhPdHZoMjdS?=
 =?utf-8?B?emFrUWRhbmMyZG5yYVJIRnZPMmlSazVnNXdhc1JqVWx4MUEybkVqL2ZqTkpE?=
 =?utf-8?B?aTRtdzYyUTJmbEE9PQ==?=
X-Microsoft-Antispam-Message-Info: UhpYXbEDn4uzZTR0vl9Ul6psrclOPj+Av8tbEGvB3cU4fYE5qvSdgt0FlLr9VxqvWD+SXe2tgIELNLbzWw6YDS4F+7Ec4SRL3aeczUm+W8KfHH9HQAb1yAsRSVg7k6HR4E+vUtkgJm+6RWRAdGrB15zM/CVGRznnP039qXOmK9msOmNViQpzI2VCbKyrHXtB
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;6:dgpnbonBGQOCgiK+9c7YobuT2t0RaTfP0eKbgCsLcuur1tmboO20fP8D3dNdyUoeMLVT20HjwqyDFKO31mQCe8havo9EnjxsacWA67ooqDtYaY0sGj3YVKKeidQMo2XODc6dyyozTlIAnAwHR/ZuHb5ZRcphEnUd89kIp4iemb0r2EqGhUilFI9H86UotQSLZXaRyhwRT/gRiBYT9UwLw2WYkuFiu6YRChrYZp52+XaV/EJdo44S6NoJdIX0vFpDz5Nbelr5PZBfR3u/AmilQNWWYf86MJR2t1SDRcFX+ZwUaB5lTIvqr233JoVSjQd9UFUdS+EenFZRnw+OytXTwmYBCnuCIB5ewl2cIjyCytk=;5:wiVt0qXEz6+TdKQd3VBTXL3LUI9FUa5D7RpDmUFjLzqacha2C4WAUZemskKCgnrmk85GoREVntG3zdgH3Xp6dQFfnoiMYQH3x9s3tArTLo4BNbujcfeUeWKsmTcWFVZ5hNaeILhQvTDKhMPJSY4RQvhXTiJnftoOzYKq8vtCNMs=;24:7nHRRvhD9a8HVJ/8w3V17en3KrelgUD9/ZWc531HoQxNZyWGrAzZOyj/OwjmX94BFVQ5IIJHIEqIuZTPpkrber2fqZEJpC3nXFyzU/T0EPA=;7:yxgmp1EHn9k5fg7qVUifvpzGrJS1SOrPFXsy9NhNs1PgoyLbmdJuxlFbJpAhHE57QxShBIdHPVcGV5TseyB/2t1AKqGyK6f53syV/8ZJgbIqMkM1FHSIvOVDzu51y1Nw5FkNeJWd6S1lf11q8Bh7NX5leLX6N4nGpG94foh/ZvFr8a2p7rfjX6gpaRKQyPI1H4CkIrZhQwSVXF44ORXLgTCo7BmvqULILACp4LNdXjZqiusMy2GmDTazpI9Ivzcd
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;20:6gnn03zoB0/xn5NmGY7leE7Of4wnOmzo6u+dVYkbeETO35W195YGQE4l1ns1afK0/LDpqjIsuXr6rveHpldRE9bxa/4FI0QFfvCVjET4nfPHGoIzjJScsSEKaTT+qvSHQVS2ojZ82cqpLhYJw2U5Ymzwv6OzoD3V4Z2QluNlWHw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 15:12:20.4395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e9ef4ab-4643-41cc-2245-08d58f3e2635
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1340
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553622756842955?=
X-GMAIL-MSGID: =?utf-8?q?1595560581111551782?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 21.03.2018 17:56, Matthew Wilcox wrote:
> On Wed, Mar 21, 2018 at 04:21:40PM +0300, Kirill Tkhai wrote:
>> +++ b/include/linux/memcontrol.h
>> @@ -151,6 +151,11 @@ struct mem_cgroup_thresholds {
>>  	struct mem_cgroup_threshold_ary *spare;
>>  };
>>  
>> +struct shrinkers_map {
>> +	struct rcu_head rcu;
>> +	unsigned long *map[0];
>> +};
>> +
>>  enum memcg_kmem_state {
>>  	KMEM_NONE,
>>  	KMEM_ALLOCATED,
>> @@ -182,6 +187,9 @@ struct mem_cgroup {
>>  	unsigned long low;
>>  	unsigned long high;
>>  
>> +	/* Bitmap of shrinker ids suitable to call for this memcg */
>> +	struct shrinkers_map __rcu *shrinkers_map;
>> +
>>  	/* Range enforcement for interrupt charges */
>>  	struct work_struct high_work;
>>  
> 
> Why use your own bitmap here?  Why not use an IDA which can grow and
> shrink automatically without you needing to play fun games with RCU?

Bitmap allows to use unlocked set_bit()/clear_bit() to maintain the map
of not empty shrinkers.

So, the reason to use IDR here is to save bitmap memory? Does this mean
IDA works fast with sparse identifiers? It seems they require per-memcg
lock to call IDR primitives. I just don't have information about this.

If so, which IDA primitive can be used to set particular id in bitmap?
There is idr_alloc_cyclic(idr, NULL, id, id+1, GFP_KERNEL) only I see
to do that.

Kirill
