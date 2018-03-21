Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AG47ELvwuHgfjQGZuBOH6CT6+tj4YM0diumTCby/aBtPRWxEky4KqCECnl7JRQDPLfO/a4vdLVly
ARC-Seal: i=1; a=rsa-sha256; t=1521646990; cv=none;
        d=google.com; s=arc-20160816;
        b=yUt5q76Mf8ourbDxvTqdBeFCbuxQFv8RYeoy0fbokKNd5xIxkLU7FQwwd1U+9hZu1w
         dBU3wHvy2l0L8GwpWZb3GUGyyjhpxmQCPlvw73rb5V4pxszogbhC/gORjKzL+anTOCm6
         YKMXhFRwn+dMODBBSrrY71SixbsMWFeCxhz10KDU2hHYAYd6mkGgmBYmwhUQYagIgyb+
         5XOwiNCQzXUtcXOvWQE5/miMrw0NtB6PaU2zRyq/Mx2gJ9UNF/pgHdm9/pQ8YjQyMrJq
         nH08QAb5So6s00KIpC0JDHL4mV9+RuaAvaCxsuite0M167mExyFzk64n8srIb1wjET9Q
         Hwhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=AQUk4ysoKR7TZHxhU0vlVz1f647BB093t+/qzj/cjdM=;
        b=X51yJPlxz1yi6t65mkwL8xxFl2xRa4J+dl3mh9XN8tSPHLcqHX29M6y0HFtMtNHx2/
         JQTKTYWD7je645LnAXhd0+H4Vv0NBace+wPizWIZrB1DHu2dzIX0lyw8yQXq2gKqMIzb
         OW6fnXXTiRVgNb3GW6IhY8b4kxCD9u7tz7v64CGPIGiJ8LhoP7k4shXMgGedcq8L9IM2
         70OGuCxud+Tr4h52Ko9pKcX9XbPaFpw5Ar7oHI1ziZZ48pIPbllnqbm04mNG+5GctaLe
         MUVFT0TtLakSsxe92YSiKrHx9Tv4J4x7DMwTHNqd006V1RgA+6KF/3Gcy3zYy5jgZCn5
         ceOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=DTDjSoCZ;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.2.136 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=DTDjSoCZ;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.2.136 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
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
 <eda62454-5788-4f65-c2b5-719d4a98cb2a@virtuozzo.com>
 <20180321152647.GB4780@bombadil.infradead.org>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <638887a1-35f8-a71d-6e45-4e779eb62dc4@virtuozzo.com>
Date: Wed, 21 Mar 2018 18:43:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180321152647.GB4780@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: DB6PR07CA0021.eurprd07.prod.outlook.com
 (2603:10a6:6:2d::31) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3952633d-2e4a-497e-ca84-08d58f4270dd
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:nYoXo0/Tu4HgZ1MLG6rr7MC+s3NoPE1GRLzesd1WHuTKKFMeQ5FdTaFJVugkPyP61MroBq/bXzJbADRtHDJli27vuzXGumtiOLFwkgKJtGDO6HeCbQK7rEY5aYrl8yGc+QzzT7iQMSWgxkVEm/a2spoWMkgK/Z/hy9w9T9zBmru73iEiiO8Gce16qARXT0LeIrMiCmN+NWHiyj8LPYqpSFgZIZJ8lt05nIqnVDnL9Jwqhxx+ZV3a4jNy3NIOJdhT;25:XDpfxkGgKZFnO9rQMy6coOMjLWj5Xxbwn3+GY+BV6cignQh996Rh9rP9n2j4szJpQFniKMuVLJbju1xhRg6YSrlxtrXzVZjZAYH+o36+0zTIcaP9T1XDYSMWZXPxcONdpeGfEjS6OjOvGZL5itJuAUNSD68/FFjbAm5QMRCvRml692tBq3Eb5cCq84c6+6VZyEPx4dGV+mFvzrWeEk4sHYYiRFF30YHFCT80mzOaild0Bez3/Y5zJ5nmx629fDjL1UF5sjQlnVFLqDASDLR9hLEOU8c+ad4d/QNados3IxaKU4p6LNAcge3LiTAT5fltjTAgQ7vUmHO2MyPuCPJH2w==;31:z2OGXBLR08rlLn9fjZMKjRkoQg2LA90NyjjuLiqVNqtURNEUwjD3Jm69ZXyJEe6Ue+1kkqxLZvkLegHnxDJHnFVfsYWC9I/LJu/GxG9iVKNfQHIIdHAf8Hwq8Y0/TNeSeCapFoIzlUIOYIjXJTz7YcuXzUOLnB48u/uD0ph4OkK2W/d6m4IuGfx8izsdrqEZSK9834EbgaLVPQuWoe78e1y2EXvy8V40ydKMINrX7X0=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:yXlFBVY2NL/9q1/vcFSBlHW27sD9qG/WSp1vp+sYUtNw3a+IIY9Ws8lUn7zphN7Uudg7nAf0ZphG7RZmYYReBs/jE4HN7lFSLwSDrk971uLZ1K1zcHa2kLcf4602aOP2+wFPT2kXHX8skkH9Xx15NawjZDabYywh7sOvydN5PJpCXUC7qq9CIn3HImL9FM5DV/Yv4PfkI2xPBlTa4vkUDjQx1jAAJWMeuzJx40qkLEaDPULgHvHLM8+yalSYQKZhvMNgLB/OjPmrEnSRL4ZQAOJ8Zqpr4xCM8pRhTZALzvPuRlvN1Owg0T90PWPCNlR82UJXjgDmmRTRFGyur0q0jPIf0X8OSicZol/YNwNYyjkG1aLbTpwoRRN3qPwde8EiD4h93nVxvpZ/zZmmLpYCVuv6b7IYJUNZsvbHXPBFDrSFX2ga56KgzN9kzASB8X/sYfEs3fJdx8KP6zct9tFyZcUlsR4poQJHQBeMDpFS1kX4Q8s2BK32p0aARLdKqt84;4:mrNtCBpHK2tEd8RaCC70T2DUdOf5o4mXq9JXqJ/XtRWgAmwngAWgX0Do7iNiPt81LAGaQH8xCZwIYXfl0h7rk9G+lt3ntzl2KYu6hF8t2Sj6BQ/HB4TNxj5eiIZdzi8pMjHar8Gm62KSVoIF7FDhle4zLwHoKWVCBjDgGBd6aW/S5sG4VeG3+TSyNDEsb4T2/NR8fMCDWM30NozdgnoyOWAGJt0s3HIW8AvQffSCAt6pcNFnI+HtWKB6kaMTpirkZGkAYqE6MgNfMWJHxj0OKA==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13385AEF5582AEFAE63010BDCDAA0@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231221)(944501324)(52105095)(3002001)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(6049001)(396003)(39850400004)(366004)(376002)(346002)(39380400002)(189003)(199004)(2906002)(47776003)(64126003)(106356001)(5660300001)(52116002)(478600001)(65806001)(25786009)(97736004)(66066001)(65956001)(31686004)(65826007)(39060400002)(105586002)(68736007)(230700001)(53546011)(386003)(3846002)(52146003)(23676004)(6116002)(2486003)(36756003)(76176011)(31696002)(8936002)(93886005)(16576012)(53936002)(2950100002)(55236004)(77096007)(58126008)(305945005)(26005)(86362001)(81156014)(8676002)(6486002)(7416002)(81166006)(50466002)(4326008)(16526019)(186003)(7736002)(6246003)(316002)(59450400001)(229853002)(6916009)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6SzJXQjZFakljelgrUHhUM0hkVXhVeGNW?=
 =?utf-8?B?MWZWS01zWGdRNW9UZXdpdzczWlRFa0VwbCtxQnhkRExFU1VDRkRyVitNaldQ?=
 =?utf-8?B?QXZVb0dWRjZkcVRvREUvSUxxSWl0T3pXK2RzMTJZL2NROFJwQVBhTWw1cDJZ?=
 =?utf-8?B?S3BYcUV6VUNHTEZJVDRzdFZQNktxbkhKVmZ5WVJRZzByY01GYWRlc0I1QmEw?=
 =?utf-8?B?QkkwOUlCbDhGVnl1L3ZId3NJeHhZM0Frb2FheTlqbUwvR29qa2JkRzZHVnYv?=
 =?utf-8?B?MnJMVkpteStqbktpeTVTSlpBWkxpQ0wwOWwxWlRnaXRXOHdFZE1qMm8wdXdR?=
 =?utf-8?B?ZTBSNlUxVHg5dGtLcGwrek4xb290a0hRRnR4Nk1nQkRyQzVUcnJoN0dpYVQz?=
 =?utf-8?B?UVU5TnFJQ2NscjhVL0RJMVVoSGtzT2JIc3NnWVpaRmsrVmpXcGQxM3EvQWNl?=
 =?utf-8?B?RUV2RkhKTitUcmFOdk1hSjA5M1BNZXFvVHdaSHlNMDVGQ0JPU3l0bmJNVkdp?=
 =?utf-8?B?eDRFTUJldmpoNTBuWFJFZXRhYUxudmxDZExRUVI4Y3VSRUNON3JBMTVsNXQz?=
 =?utf-8?B?S3dsQ2RZSzliRU1JM2Y4L251UzJWM0piVEc2ZzVqOW11NkFNRC9KTkI3bnlL?=
 =?utf-8?B?ODhTWTV3SFVvdVZOODNhQ0t5NXpRK0NrY2xzZDJLNDN1RzZiL1pHNGJRRSsv?=
 =?utf-8?B?Y1dpSDhZNWRrY0k4RUFhdi9JaElWcy9PTVp6SEdVVGhDZ282NkZGcUhBaHNq?=
 =?utf-8?B?RnhpZEpjR0V3aDg1ci8rTjNyYnBGR0d2OGRIMUo2bkRQTzZZd1dXQTdKSWVN?=
 =?utf-8?B?Z2RyWkMzQUQyS1JxVXFqVjdZOFAxKzkrU1RVZXBydFhPOTBSUkcvSEdsMzh1?=
 =?utf-8?B?TytzYUFPK2pZVlk2Y2pjRnk3YitTQXd1eEpPWFZubXlCUEpYbStBOUZKV1I4?=
 =?utf-8?B?WU55RC9MTnZWZ29GTHpzSWI5Ukx5SklTOUFKUlFQR1UydTlkRnVFWndjdTBR?=
 =?utf-8?B?ckRtdVU0N0ZCaDUvbjNRa3lZUWVTZXFHT2ZUbE93VUs3ZkFLYXhTU04ydXJr?=
 =?utf-8?B?V0V1UUMrd2dMZHBjRGxxcjJTSjlHVTF1KytCQVFXWG0zbkFCNDJDOTlIVkp4?=
 =?utf-8?B?bUY4N0Q0UUR5TFB4Vk80R240WFFPMW1tb2tKUGdNZ3JCOVBoeWx4WlBDNTFk?=
 =?utf-8?B?ellMNEhpdXE1YVh2RWh1WmVOYmxESVZiQ3R3azF3dDBZMGwxQzQrU1pycjFH?=
 =?utf-8?B?QVlUOVZJeHVrMjlPdVFsN0JRa3M5ek56UGxXSkp0QkZhQmNyNzFIRmZzUEtH?=
 =?utf-8?B?MTcra3dDVDYrK1J1QVlyYk5zUW1kSWxCYnpHTmkwMytURU5mUUpEQnpEeER3?=
 =?utf-8?B?Vk1NV0h3QURzRm1mVlp3dlo5elB6VGlDSFFDMVFwMlNJMnNSeXB6VlNOQWZh?=
 =?utf-8?B?eksvcGR2WmgxTGJmaXZ1RjVURXM4NHlsSUVyYzErNTloM0xtRU8xcUl3bWto?=
 =?utf-8?B?cEpKK1pnNnRCMWxjV0pGQUQzUE42ZTgwaHZJcm91MnRmYkwzZ3F1VStOK1Np?=
 =?utf-8?B?b1lrckp4eEJmckZhcXFjdXd5WThyM2FsWlk4UmJMUDlWYXp4S1RxVGlIbFVQ?=
 =?utf-8?B?R09pU2QrckdHWDcwYnE4Vm0zUFo0TTdlZlhDNDY4VTNmTnVmNzNiNjVJMTJH?=
 =?utf-8?B?RjNrZ09maE9sRHZmdGxKUCtWdEs3SFVnTXFvekk4OVNOU1hKWjVtWXFOSHlJ?=
 =?utf-8?B?R25sTFA4NmFLcXJJVXlMZHV5WGdhdU4zTngwREFtSzF2NTdzTEZaWUZzcFpk?=
 =?utf-8?B?TEpsTUZaSGMrM1hqZW56cXpTMUttRDNTR3J1a3duVWFEQWlnNjk2VEsycUkr?=
 =?utf-8?B?c2VVSWQxS1ExVEREQ1RwUDd3c0tSWXRWZGJFV0J6ZFVibHJIdHQ5dWY1WXNG?=
 =?utf-8?B?L1l1V2ZMQldXUXorZFhVZ2R0dkthN2lpQWRleS9wWnRxQnBzT3hpQ2Q4d0dy?=
 =?utf-8?B?RUpJSmkvcFdsMDhpaTMzUkNpcndobkZhM2w2dGppbGw0UTRqYkhhTVV4cy9J?=
 =?utf-8?Q?FWum37wDKrEP4LiysLKnNHE3kt6?=
X-Microsoft-Antispam-Message-Info: yhaykX45D13nj+wV9pj/QdR57+PY6ldEJbFnS5jVxo8vNyjiZGDJSXOn28wZB2TaTnuqCXnNwvGUnNfWY4tnZAijch/hPmOujN+E9crptyzLnP8eNY6Kv6qxWPf0leGASWJJN0rtsL9S0F2e3zApZon/6KWplNxziNmgMewYtKgRZ2z53SlnjZOYOEBI553K
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:tlOPQ2p7UE8Co6SSuaUUVSEUN5qcZ5M6d3UfsXiU9c1WtysAjrEcPqGvvhA18iGQa/elplzF0HPJFVbJSo+gbdgKl4qq6z2q7WQzoLDrODzBP80unraMgP4AwO1bVq2xr2yJcEnWAV3EeQG/9k+omswPMdJPAHb/TqZAlSDXzH+P/1aWTk5WrXtT+6TWTTVN2AmbwR0LvaPm+ai1FI9ijl4habntD6J3Zior9SM+fh5MTXYCAcytI1Yx/ckELFtx0dRcuIT9/AmkfRXj6hPwKNUhb7Nc3bE+E6GrA3TL3bftaYJ9UTFE7dg+K7x1hAtphUI7791rTLY6i+2dXTp0WTg/dfiZa9PYQAPKU1/qkSM=;5:Iym/IiqQJBYa51uBzhlrMmMEQNsdRCDyZDcG1RVgOI9SClUTxuTTvYDkCh+M+0Xcez7sJgaUru+PJpN3KuwMfPCJ2jIOitbd/Y4fdg0W+eZRMi/B6GYuAIL7Orb78ZScIpjBBswt04PjTrmQv6kngDZrc0MmKCZy9dDP4LfFW4E=;24:JUGeIPHm6oyzKFKTp2RED+P8tX/PicQRwrsYf/7x/cISchi/tGOTNAX9UseT4gN32wEL1Pbt7rZ2+FzLIjjzCUy//uz3QXQ1trccjBCeebY=;7:SIGSeagjUC6lCg3C9NPWYhNVIG4OR+5YBcJkJv1hRr6nPSncxiAjeqecvthTl3fjt+Pv3KQefwsSiD77WztnAMQDgK4u8IoCllKWEk/Qjz3tLpOePRkIHnIESkPLijHUubOrHoV8z/XAE5roZUad2FbhwmqZ6MQptRq+H+/9HWZUmoCDnT0DeRWSG5ySnl8prpg9TP2PM7/9gc6FCRc2wJDrBtr7Ceo1oFrRL7ja63gCz2qPicTDCi566J81Ex2k
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:7KuStK4oMIZmx60Ngts0AYs9BDR0/JzI6au+/lqxjwqTmDRiwgb4zvi8Gs/rXyrsgf3GVfedlq+KNp0FV/78BTrhG7nt49SdTN3zP0QwMVWPx43WvoC0xwy2bQ+ONH0a1T/+gkhB60bI7sNfBSDJf8dMwYO6+/jGOkHr2O6mOjI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 15:43:03.6676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3952633d-2e4a-497e-ca84-08d58f4270dd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553622756842955?=
X-GMAIL-MSGID: =?utf-8?q?1595562515047312089?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 21.03.2018 18:26, Matthew Wilcox wrote:
> On Wed, Mar 21, 2018 at 06:12:17PM +0300, Kirill Tkhai wrote:
>> On 21.03.2018 17:56, Matthew Wilcox wrote:
>>> Why use your own bitmap here?  Why not use an IDA which can grow and
>>> shrink automatically without you needing to play fun games with RCU?
>>
>> Bitmap allows to use unlocked set_bit()/clear_bit() to maintain the map
>> of not empty shrinkers.
>>
>> So, the reason to use IDR here is to save bitmap memory? Does this mean
>> IDA works fast with sparse identifiers? It seems they require per-memcg
>> lock to call IDR primitives. I just don't have information about this.
>>
>> If so, which IDA primitive can be used to set particular id in bitmap?
>> There is idr_alloc_cyclic(idr, NULL, id, id+1, GFP_KERNEL) only I see
>> to do that.
> 
> You're confusing IDR and IDA in your email, which is unfortunate.
> 
> You can set a bit in an IDA by calling ida_simple_get(ida, n, n, GFP_FOO);
> You clear it by calling ida_simple_remove(ida, n);

I moved to IDR in the message, since IDA uses global spinlock. It will be
taken every time a first object is added to list_lru, or last is removed.
These may be frequently called operations, and they may scale not good
on big machines.

Using IDR will allow us to introduce memcg-related locks, but I'm still not
sure it's easy to introduce them in scalable-way. Simple set_bit()/clear_bit()
do not require locks at all.

> The identifiers aren't going to be all that sparse; after all you're
> allocating them from a global IDA.  Up to 62 identifiers will allocate
> no memory; 63-1024 identifiers will allocate a single 128 byte chunk.
> Between 1025 and 65536 identifiers, you'll allocate a 576-byte chunk
> and then 128-byte chunks for each block of 1024 identifiers (*).  One of
> the big wins with the IDA is that it will shrink again after being used.
> I didn't read all the way through your patchset to see if you bother to
> shrink your bitmap after it's no longer used, but most resizing bitmaps
> we have in the kernel don't bother with that part.
> 
> (*) Actually it's more complex than that... between 1025 and 1086,
> you'll have a 576 byte chunk, a 128-byte chunk and then use 62 bits of
> the next pointer before allocating a 128 byte chunk when reaching ID
> 1087.  Similar things happen for the 62 bits after 2048, 3076 and so on.
> The individual chunks aren't shrunk until they're empty so if you set ID
> 1025 and then ID 1100, then clear ID 1100, the 128-byte chunk will remain
> allocated until ID 1025 is cleared.  This probably doesn't matter to you.

Sound great, thanks for explaining this. The big problem I see is
that IDA/IDR add primitives allocate memory, while they will be used
in the places, where they mustn't fail. There is list_lru_add(), and
it's called unconditionally in current kernel code. The patchset makes
the bitmap be populated in this function. So, we can't use IDR there.

Thanks,
Kirill
