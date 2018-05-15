Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZoNNoavBET830U54ERd1HlT5cTDVurD5ek0mJ7KHnpE4vpdoT1zc0EmSEqvm8pDQy/HsG6c
ARC-Seal: i=1; a=rsa-sha256; t=1526379150; cv=none;
        d=google.com; s=arc-20160816;
        b=pRreyoQEwBo2cuELyaJ3Sx9aIsnRb432ytaGI4Nn/e2XTrYutlwQoAGhFBLyS/E8Vt
         cQWXsGrYn95TJoNFMfBBdijU6FA7uXNZYekBZBmexlrEP6oCy7aW0uGjnyPZsRoLNzxY
         o6/A0P80REscxjHvFy5mKVXr9ySKJvt8WTOsiKfcI0TqhR8nwJZ/PfYtNk9cGSkeZQK7
         TER9hgjMaeP86SXuSZkHKFo8T9kp5ZbZbhbJR7oMhaAULCsN4fxAWhTenit+YBjgriEf
         jRnNjS2UsSi8Ln2VTvBo4a/fa0KICCC8veL7WFYkb2QxnXdEurcMvZOTGsNMq4DgcolR
         Hf/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=9FhXhmfvjP4JBj6yXPItPvkj8+15JJe1P11Ci3B25H0=;
        b=aGDCn34We93VcbAVKcloXpBTboyX7EAe5NzE+BtEhXKVfCSz8tThM5YQ6Xx7aIOakj
         0DdlUz2GyOi92zjCDmd4ozv7XZq6qMY4+O6H+11XJzPXLL1Va/PwFh3SaWFtVfoIM7zY
         JvsO477BMM11+7+FfBjb0chPskkmKMv5TtiVkrdVBdO0xLaM55vPxQzY1yO95IrI04yL
         qgDdKGtQ5rtJJba8o0yHz2ch53hhmaqegrqXGztpNe/jhQBtpAvLjzj5xZnySsSbGs7r
         MtQ+I4Efdk0mUBU/X4o/wihEU7jJj7j7PhoxSSAr/Y6SdrE2MP1low0SUp0GL2Xi+Bvh
         YbHQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=WFMe3szg;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.113 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=WFMe3szg;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.113 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH v5 11/13] mm: Iterate only over charged shrinkers during
 memcg shrink_slab()
To: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: akpm@linux-foundation.org, shakeelb@google.com, viro@zeniv.linux.org.uk,
 hannes@cmpxchg.org, mhocko@kernel.org, tglx@linutronix.de,
 pombredanne@nexb.com, stummala@codeaurora.org, gregkh@linuxfoundation.org,
 sfr@canb.auug.org.au, guro@fb.com, mka@chromium.org,
 penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
 longman@redhat.com, minchan@kernel.org, ying.huang@intel.com,
 mgorman@techsingularity.net, jbacik@fb.com, linux@roeck-us.net,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org,
 lirongqing@baidu.com, aryabinin@virtuozzo.com
References: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
 <152594603565.22949.12428911301395699065.stgit@localhost.localdomain>
 <20180515054445.nhe4zigtelkois4p@esperanza>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <fa35589b-0696-e029-4440-d91dc4c9ab2d@virtuozzo.com>
Date: Tue, 15 May 2018 13:12:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180515054445.nhe4zigtelkois4p@esperanza>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM5P189CA0014.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:206:15::27) To VI1PR0801MB1343.eurprd08.prod.outlook.com
 (2603:10a6:800:3b::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1343;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;3:wq6IbBeIIM7LsmJlS8z9KrPrWcB42hXtJP2CrFsGJXvlSgTXLzsIIvAVjbIcMd2ePihQFIsEg+6vI4RMlO6wJN5rC2Q8jNUzKbKfHM07YZyZHLhNi9D3GZ2U7bX/cRHGUKsTrCXnjnzbKB55OlZWm1uSKt6ZzlpYJBkFdQCO9j6feA3tE8UIL3vEVMDOEBEzjiwMlOI7lb7a5nVOZrgxmL9SVhEP1mAO4Jm+U+Z+OwXsImsLZDUN/f55oNRJSRPS;25:ZW9COfTUOKEGfu3cSKC/cfq9jAiDxuz0hOvzYrtVwHEYHPjlKRyKqLU1UNnoTZ/f8XzzRTWlPcJeWnEc+Vzgv7gDOAsIc6PHMHnNG28oKkQBGEcW+vcUWw2Gveluqqu3ykxRBBfOiK4ZyUgt1Zl5khr9zC9xFlocxzOfo39WJAsnLP8sXuQPpU4tNZsLd4Orr6Y0+L6Jakl/vddWjoulwC27Ai0xpvsdJJMLUXT4r9Zn+d/lZo7r70dPAdcFPJreleYzp4mWWScL82W+dODHahrUFmUodeewY8Kbbk0oTy67s5zhrUxaIRMp6QSn/PlJDq9KYHZ7xx3grqvOVBFBWw==;31:JNnWEpFSjVrtM7XKubFD1rDImYEFBA7D7KS3c5wo8Zv4Im/cKl7leAjK02wROTvCfLg6GxAhzMoumiiLa2cH8Usm2MlLUHkRHhv8sQPpe91iiIgjjY29LkPTQNKmzn2Jhz1C7E1uRHl0f7dNHpH89/ayysT8tgJbISzmvT2bF/vWDVbIiMHoK+fGCgxGRwFEvX/N2RmBXzy1pwcj5nFHRQRUwWSBDdmW0+HEZeYRNrA=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1343:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;20:5y0i8H4gPBxu3E5UquESLExispVlf+aeWICWYZGomHCYqYmvpDih7FTtfaNfWsQSjfFfEgVnqG1Cvp5jBEzgDs3ejPH47V3dZQQ1MtQgPgSc8yoY6RtSqkdUg0rVEQFcuaNcBYXG7ofWM2OsP8daSoL4mjG+O43yIW5kdZoHX7IbKM1MpugLjmB8gVHQ0Iv+UKQ2J5+okqc4KitosaVvflC1653M99CV5yDQWa9UITf6jU5zD/lFDqhOZCpz6MxDla63DuxFcdOkByfMuspTJghNgSCLePHPIMlIpn7/mQqhwMIJXRJeoobPbXBrVQFFx31G1RCPCjgb9srkbD3UEZ88vXjv51jIsUk5wRdbr/wUzVE0ukZHK69QCMwI3dPDlpOd+jM390TRFRw6L6+ZumpVol2zQs3SJxyHycaedZsZsX0szTU3xgjv8ZLoWvuBtURZTgzYjidz+oRcIFYiZ1EPx1oKJKRcpo7j7snBix1Vg/0tpVONARUlhgsL1JKb;4:9GYXkTKNUQjMB4vMEEkp1MHqnrtP7JVHwM6ky3WQLj86p4iJBsefjHxseEAdTKZcXoX+smd45gG9OkjmXSQ6DOhmyceNgwuBLS+aXKjIs9WxaWzg/t2ZhFhgP5zcfDCCgvZyLHiLx5hc0iaaN3Qup2OYKCUY+8ddOZbYnhitf9bBPAyLnoMRga3xKoc0GkTKfUyX15IWkuwC0wObPCpKMoojW+Zxv3ojg870mrzSmRvjWOZaYt53zSXJqyuJEUAW+vTARp/PMyC7sopdyr3IoQ==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB13433CF10D57031A74EF9507CD930@VI1PR0801MB1343.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR0801MB1343;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1343;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39850400004)(39380400002)(396003)(376002)(346002)(366004)(189003)(199004)(26005)(476003)(39060400002)(11346002)(47776003)(97736004)(230700001)(956004)(65956001)(64126003)(66066001)(386003)(25786009)(446003)(65806001)(53546011)(5660300001)(2616005)(8936002)(65826007)(77096007)(6246003)(16526019)(36756003)(31686004)(8676002)(105586002)(53936002)(107886003)(7736002)(81166006)(81156014)(305945005)(58126008)(68736007)(106356001)(6916009)(16576012)(4326008)(2906002)(76176011)(59450400001)(478600001)(3846002)(6116002)(50466002)(6486002)(2486003)(52146003)(86362001)(486006)(7416002)(229853002)(23676004)(52116002)(316002)(31696002)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1343;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDM7MjM6NGJjeExDUE5DSjB0QVdyUDhOTWhYb2dF?=
 =?utf-8?B?aHpGdEtqMUdPNXA4N0Y3UElBZVdxQVFUMFo0bHExbU9kZjIxSTJTNHMwTHlH?=
 =?utf-8?B?cDlFL2phY3BCQ1JzR0RqUlZ6ZlhUdnJMb05YWUJzSzcvNUlCV0Z1VUZJWTFk?=
 =?utf-8?B?c3Q0Q1NkalVXUGdkTmo1aEIwZ0Y4MGxLdXR0R0R1b1pLUWFnUjgyV0RiVnBB?=
 =?utf-8?B?SlJNcGhGNUpBZzBSTkZNOXU0NklVQ0hDdkU2Q0QyV29KVHBrVEE1cUZQbzNo?=
 =?utf-8?B?bmNXaEE1ME9URXQvMkdISzhUYVhBVzJrbXlDNzBpTkw2Wm9pT01PN3pOVHRK?=
 =?utf-8?B?N2Y3dTZIS1Q4RWcySDdydkFqSDNxeWNIM1BiSUQ5cVpuRHVabnNjM010ZWp0?=
 =?utf-8?B?eUdZU0wxMUpHQS9nTm9IdkV4R1NaTG52b1J6SHZXdEpXWm16d09GcXF5RDJY?=
 =?utf-8?B?MnFxN01ZdmdjUVNsTXBmNkhpWXQvL0tSM2RyVy96R1NHbzhscTVaRnZ1b0lD?=
 =?utf-8?B?M1p1elpVSWl6Z3JZWitCUnAyUlZwd1o0dEJucWNDbStMM0FLekRyeFlHc2F0?=
 =?utf-8?B?aDZJY0xtMVYzZlA2ekNqeDR0UVRTT3d0eS9XcXpNK2UrSkxYUGdjUW0rNC9X?=
 =?utf-8?B?Ny9hanBXZnZxdlo4MGljQ3NLQXk1YjcrcmMyZ1Y2UEN6Zk5CSHpvVHNFc3J2?=
 =?utf-8?B?amY3dk9Nc2Mvc3czd1gzTnNsRkNLK1Z4bXlHVmd0QmladnBpMG9NU0J5cEZv?=
 =?utf-8?B?dzdTOVlUOHlSVS9DSlN5MXlUYngwSnRiTkxXaCtVSDdrWHF0amI3VDgra2hU?=
 =?utf-8?B?RW96SXJKcnF3dHFvLzNXaStxamQyM2hVcE9IamIxWTZnUE9RRVRGNWlmaEJ0?=
 =?utf-8?B?VHI4bC9FQW50cGJGZm1oUnBycERLcFVyQmJSNHh2TGJ4TGxSQ05DUEZ2VFVw?=
 =?utf-8?B?bmI3Wm5QRzBKZklYMVVFQ1ltNTRCVHdmaTdEZE1XenBwTTJVQUlMWDlrOUY4?=
 =?utf-8?B?b3czZXhsTUtyMFlIUm5SOTlxSVJoNGFqRHVOUlpDaTlobzVIR1FwZWdLRUl2?=
 =?utf-8?B?SUFERDVSYVR2ZDNkd3RFWWVFbkp5K0JZMWxsK2hzM1NMUjcvUHp4bTlHZ24r?=
 =?utf-8?B?TjBySDl3YzEvN1FFaXdtZW90ckthbmxpTmpwMkFNaEJaTGxVcVB4MCtUSGIy?=
 =?utf-8?B?VW5QWkdubFBNNG1kV2JJYW15QW16ZkpETnc1RmwzcUk4ME5Nc01BNW9YVjZM?=
 =?utf-8?B?L2U5ZklNaTFmMkdmS0M1bENsMENiemRWNkw3QmR1OWZyb09UNFhuYjZwZ2ZN?=
 =?utf-8?B?ZEs2djJWVzl6Qnp0cW5oV281VUZDWUZEYWMyWE9zUEd3WDVzMktzVkxXcnlq?=
 =?utf-8?B?bmloL1BaYTJLbWc5di82c1F5RVFxR0VBbUhhUzR3Mk9keTNsTGMxbHRudncr?=
 =?utf-8?B?SVN1dE93bldmSlJXSlNycEVBYlZVYnBTbkNtdDdTemhkQ0NjdHpRS3lmbzF0?=
 =?utf-8?B?S3cvYVhmT1E5Uktqb1RLR25RNWk3aVJxWU1QQ1R2enB5S1NuWGxid1lEbFp0?=
 =?utf-8?B?TUVZMkwrUzhtUW1BakduWUpNR0dZMHk5TW9ReUJLOG1KL09LUlhHbW16L3Rx?=
 =?utf-8?B?M3FiMGJDZFhFdHpqUGpJMEhiRkhCN0pKN3hQaFVveGQ3THQ3aTZrcVJYNTBp?=
 =?utf-8?B?QStaUlNFLzB1em9BNk4rdm1PY0pieWpiTlc1QzV2dTFBUG1IWERyellVd1RP?=
 =?utf-8?B?VHdaTDNUS0VNZFhWUGM0aXJSOURneWdUcWJ0b1Fnc3FmTEpMamVrU2cwd1kw?=
 =?utf-8?B?UGp3eThLUEcyN3JHUjJCM2FwUzcyUERYYXVjdTRVYXlCd0NUb0pCQ3RtWGJy?=
 =?utf-8?B?Y3NMaGYwOCtjUVhoU2tNVDVGRFd2bGhpT0pRZVhZcFB4Ry9ZVUJlNlVOZVVt?=
 =?utf-8?B?dzlHNVVzaXJ1MzlmVUk5VjBzOHlZUVZhdXlSa3Fnc0kwSGV5SWl1UVNUYjNz?=
 =?utf-8?B?N3ByQ3NKLzQyWWlJK29FekI0VkF0VUJudVZlOU5BPT0=?=
X-Microsoft-Antispam-Message-Info: gVRLfHsR38GcTtd37jc93fPMrFt7NKZLkYH8kzpEfCVoD6keBswSvnlYWE/d1Rz39uV+p7R23WqRxebeXTV6o6mjbZuWQYqWbJhSfAeTVXbEnSZ9kGQkfV3zpPT7rL+ZWxWclMY4sl95KZzl0tfuU811+0guJWwP43czzuM6UmSBZ4K+fvzFZ4QHLMPsV+R1
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;6:8fzzusJbkQHEUx5K/Y0Y5hx6/lzssFJHvOku7CazDElRPvbf/AW5u6K8C+nQBT0ZYjnwzm0ytrLl6MjrD4ZeTqVP5KbQr+AmTY7eqJy6uqoP6N56ErqkqOJpCEYJkmFlMmIDQma8wPDz6QdJ7+VINhRzUKHdA4ugTV2tMtdBOWcZMkgI6EkuwxFYr9CAwmDYzqB+obRrK5rUrRqEmln4kMkXc488l06KfESbLtmIGbjDlXhh5MnaCTom92zAlHRPineEuvo83iflkHIliUQwQKKr7tCq4uljoGkb5+PkKmWKCF7ecn89HKcawbc3A3tXs0lutZiUhgVicn1yTLkgL7WSaC5q6y0qoGfC8Mi/tVvYtXucP6bLHGg7/6+L6rMFHlmEbhLgh5lUWQhccsqSrR+ZUREKmCPksZxGjlUW3SbIeFt5h10UsjCWDE2rJ0ba9jALOwMifPns2FF9LB4P/Q==;5:7cuC6OwoXs5CZcyek+OZbaQWYKL0jgXnq/lbf/Al/gUpLp4Xne2dH2A7x/paviQLa+69YTBj/1BLzodijGA0+D3ltM19UckqWdJ+3G8ZqTwEIz/Dh10txY2ZPDpIMhdAfWHEWvtjH52sVcEnnPbsHfW25aVu2KlD9NRMqABwq2U=;24:fz0UaIcvJgetQwwtg/xrwToWko6NQp2561Pr5S6KDuBSy8/A6BKniRrFq2g4+p1UKhqli+pSyvTTGQi12Usuq9n/HDyP911On3F6sNmTzHE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;7:M3sCWRaNbJVJHBmjrD51N2mINzuYJ5Xsx8OgLhFvqMT5uKtzdfNdtQmyMQkWDKWfSztqNKbsu8JDoWEPl8KuttS7HKD73oyNG9KOglQ+nYUpWF5VG+C7tKfDrB8eKa5vTnJH1DWgiavOQ8qHdTkpS89Gua5dEpwHYf7m2IivStvGHCbCyNmMk3GUldfz7v5vJ3Oqjjrswk0BMvy+UfSUsHTCurMZL8TbFPXDVY1FrFnn/dX243z3HbLv+ywerM/k;20:Vf0kl/azfuVGzoxkNjGTVA/1xRUQMFdSj5bWFyZ/3oFrH0SF/BADazkrtYka3Zy2kfVwmZgPULveNliGVEEVZM16e1a4gzpuNpFNx8wy527KI+DPxnNHJnj5yxyLAuZBmQBpLiXyItpnqq0qTjtGvHffbpMjcBhNA5BejtqCiaY=
X-MS-Office365-Filtering-Correlation-Id: 109fb88b-dcc8-490c-d9de-08d5ba4c5b48
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 10:12:23.6137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 109fb88b-dcc8-490c-d9de-08d5ba4c5b48
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1343
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600070396521697862?=
X-GMAIL-MSGID: =?utf-8?q?1600524543469898704?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 15.05.2018 08:44, Vladimir Davydov wrote:
> On Thu, May 10, 2018 at 12:53:55PM +0300, Kirill Tkhai wrote:
>> Using the preparations made in previous patches, in case of memcg
>> shrink, we may avoid shrinkers, which are not set in memcg's shrinkers
>> bitmap. To do that, we separate iterations over memcg-aware and
>> !memcg-aware shrinkers, and memcg-aware shrinkers are chosen
>> via for_each_set_bit() from the bitmap. In case of big nodes,
>> having many isolated environments, this gives significant
>> performance growth. See next patches for the details.
>>
>> Note, that the patch does not respect to empty memcg shrinkers,
>> since we never clear the bitmap bits after we set it once.
>> Their shrinkers will be called again, with no shrinked objects
>> as result. This functionality is provided by next patches.
>>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> ---
>>  include/linux/memcontrol.h |    1 +
>>  mm/vmscan.c                |   70 ++++++++++++++++++++++++++++++++++++++------
>>  2 files changed, 62 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index 82f892e77637..436691a66500 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -760,6 +760,7 @@ void mem_cgroup_split_huge_fixup(struct page *head);
>>  #define MEM_CGROUP_ID_MAX	0
>>  
>>  struct mem_cgroup;
>> +#define root_mem_cgroup NULL
> 
> Let's instead export mem_cgroup_is_root(). In case if MEMCG is disabled
> it will always return false.

export == move to header file

>>  
>>  static inline bool mem_cgroup_disabled(void)
>>  {
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index d8a2870710e0..a2e38e05adb5 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -376,6 +376,7 @@ int prealloc_shrinker(struct shrinker *shrinker)
>>  			goto free_deferred;
>>  	}
>>  
>> +	INIT_LIST_HEAD(&shrinker->list);
> 
> IMO this shouldn't be here, see my comment below.
> 
>>  	return 0;
>>  
>>  free_deferred:
>> @@ -547,6 +548,63 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>>  	return freed;
>>  }
>>  
>> +#ifdef CONFIG_MEMCG_SHRINKER
>> +static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>> +			struct mem_cgroup *memcg, int priority)
>> +{
>> +	struct memcg_shrinker_map *map;
>> +	unsigned long freed = 0;
>> +	int ret, i;
>> +
>> +	if (!memcg_kmem_enabled() || !mem_cgroup_online(memcg))
>> +		return 0;
>> +
>> +	if (!down_read_trylock(&shrinker_rwsem))
>> +		return 0;
>> +
>> +	/*
>> +	 * 1)Caller passes only alive memcg, so map can't be NULL.
>> +	 * 2)shrinker_rwsem protects from maps expanding.
> 
>             ^^
> Nit: space missing here :-)

I don't understand what you mean here. Please, clarify...

>> +	 */
>> +	map = rcu_dereference_protected(MEMCG_SHRINKER_MAP(memcg, nid), true);
>> +	BUG_ON(!map);
>> +
>> +	for_each_set_bit(i, map->map, memcg_shrinker_nr_max) {
>> +		struct shrink_control sc = {
>> +			.gfp_mask = gfp_mask,
>> +			.nid = nid,
>> +			.memcg = memcg,
>> +		};
>> +		struct shrinker *shrinker;
>> +
>> +		shrinker = idr_find(&shrinker_idr, i);
>> +		if (!shrinker) {
>> +			clear_bit(i, map->map);
>> +			continue;
>> +		}
> 
> The shrinker must be memcg aware so please add
> 
>   BUG_ON((shrinker->flags & SHRINKER_MEMCG_AWARE) == 0);
> 
>> +		if (list_empty(&shrinker->list))
>> +			continue;
> 
> I don't like using shrinker->list as an indicator that the shrinker has
> been initialized. IMO if you do need such a check, you should split
> shrinker_idr registration in two steps - allocate a slot in 'prealloc'
> and set the pointer in 'register'. However, can we really encounter an
> unregistered shrinker here? AFAIU a bit can be set in the shrinker map
> only after the corresponding shrinker has been initialized, no?

1)No, it's not so. Here is a race:
cpu#0                        cpu#1                                   cpu#2
prealloc_shrinker()
                             prealloc_shrinker()
                               memcg_expand_shrinker_maps()
                                 memcg_expand_one_shrinker_map()
                                   memset(&new->map, 0xff);          
                                                                     do_shrink_slab() (on uninitialized LRUs)
init LRUs
register_shrinker_prepared()

So, the check is needed.

2)Assigning NULL pointer can't be used here, since NULL pointer is already used
to clear unregistered shrinkers from the map. See the check right after idr_find().

list_empty() is used since it's the already existing indicator, which does not
require additional member in struct shrinker.

>> +
>> +		ret = do_shrink_slab(&sc, shrinker, priority);
>> +		freed += ret;
>> +
>> +		if (rwsem_is_contended(&shrinker_rwsem)) {
>> +			freed = freed ? : 1;
>> +			break;
>> +		}
>> +	}
>> +
>> +	up_read(&shrinker_rwsem);
>> +	return freed;
>> +}
>> +#else /* CONFIG_MEMCG_SHRINKER */
>> +static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>> +			struct mem_cgroup *memcg, int priority)
>> +{
>> +	return 0;
>> +}
>> +#endif /* CONFIG_MEMCG_SHRINKER */
>> +
>>  /**
>>   * shrink_slab - shrink slab caches
>>   * @gfp_mask: allocation context
>> @@ -576,8 +634,8 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>  	struct shrinker *shrinker;
>>  	unsigned long freed = 0;
>>  
>> -	if (memcg && (!memcg_kmem_enabled() || !mem_cgroup_online(memcg)))
>> -		return 0;
>> +	if (memcg && memcg != root_mem_cgroup)
> 
> if (!mem_cgroup_is_root(memcg))
> 
>> +		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
>>  
>>  	if (!down_read_trylock(&shrinker_rwsem))
>>  		goto out;
>> @@ -589,13 +647,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>  			.memcg = memcg,
>>  		};
>>  
>> -		/*
>> -		 * If kernel memory accounting is disabled, we ignore
>> -		 * SHRINKER_MEMCG_AWARE flag and call all shrinkers
>> -		 * passing NULL for memcg.
>> -		 */
>> -		if (memcg_kmem_enabled() &&
>> -		    !!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
>> +		if (!!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
>>  			continue;
> 
> I want this check gone. It's easy to achieve, actually - just remove the
> following lines from shrink_node()
> 
> 		if (global_reclaim(sc))
> 			shrink_slab(sc->gfp_mask, pgdat->node_id, NULL,
> 				    sc->priority);
> 
>>  
>>  		if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
>>
