Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZpwadDdKYjl0nPe9tFb0tRJdJ2rR9vUJD0a73VTIUdyZVjYBmX9mTJwpan2jmuLpWFFkrKa
ARC-Seal: i=1; a=rsa-sha256; t=1525945365; cv=none;
        d=google.com; s=arc-20160816;
        b=rb/5Bdgn27MxVXSvsaZNVeNEUqeqczJ3VnvZxnwZxGNc2e7cByplJIV5cyf4skjiS6
         5SEdRV43cnc7WMU7Yb+H5uPKuq8lVprzPii1XXGMat1Kwc/gwSu1jB3L4i1ZeAEQ3yEY
         MJHZ4XTWEmPwwvoAy4BCxiDZC68giYAnPS1k1X3+ADDNqOm3doLv+/rFoObB6b39jJk6
         xUI3WK93W6GtF2UzAcTY1lVLeNHmZ/CIzaNTQd2yoAwSrPwU7fA23XHLpGpL/Su2iyJH
         AvcYdar3pSSmnw8fa2trTgpY36G0nMUhlqvlULvcXk72OwEvHd95Qyv1G6dY6n0c62WO
         tm0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=CgxH4EwjiTKGr/BfDQaRn2o73jdp4lO/pk/W0G021eM=;
        b=uRlMaNIvU/g/f2o9esJWkENauTN4qlbewbJl1900wOUrJXCK/qrbtCMcXeKgNS5N6I
         Phlv5IlLg1VsZi94qKD3tI+nojFd6KUFqdnuiKJ1QRtBV8qSK1Qlg0QtUqg/u/uDwb/o
         lDNuv8JwHzSkVV7PNm7NnGrDd9U8/kUoSXVu/HDf06DxMcOy7NJlpkUQQtasP/bZDRI0
         bk0CP+01CQWvpI1ezV1P1vHN4LPQ/lJierVL64nS7hhOOHVoowLsvrqhOz5ibVJaCCwP
         EiyHGDv1R+7qHaur1cDYqGupz078D+uSgDmLQDV7zos15lgZYygnweMYKRPKspTvB+Dm
         DwxA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=VKS5v9QJ;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.3.92 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=VKS5v9QJ;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.3.92 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Subject: Re: [PATCH v4 01/13] mm: Assign id to every memcg-aware shrinker
To: Andrew Morton <akpm@linux-foundation.org>
Cc: vdavydov.dev@gmail.com, shakeelb@google.com, viro@zeniv.linux.org.uk,
 hannes@cmpxchg.org, mhocko@kernel.org, tglx@linutronix.de,
 pombredanne@nexb.com, stummala@codeaurora.org, gregkh@linuxfoundation.org,
 sfr@canb.auug.org.au, guro@fb.com, mka@chromium.org,
 penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
 longman@redhat.com, minchan@kernel.org, ying.huang@intel.com,
 mgorman@techsingularity.net, jbacik@fb.com, linux@roeck-us.net,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org,
 lirongqing@baidu.com, aryabinin@virtuozzo.com
References: <152586686544.3048.15776787801312398314.stgit@localhost.localdomain>
 <152586701534.3048.9132875744525159636.stgit@localhost.localdomain>
 <20180509155511.9bb3de08b33d617559e5fb3a@linux-foundation.org>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <799ae1e9-1f16-baf9-6bfa-305f31ae2794@virtuozzo.com>
Date: Thu, 10 May 2018 12:42:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180509155511.9bb3de08b33d617559e5fb3a@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM5PR04CA0034.eurprd04.prod.outlook.com
 (2603:10a6:206:1::47) To AM5PR0801MB1332.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::10)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1332;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;3:A+f/UgGfEihxu6uUJ6KxD7UPw9z+mMtHRN3AegCcczCVK04HwzXxW9W8KLmDjMEBqqiWYyDoUH27uT20ft0JBROTBKDUhKDynkg3msu2ti2EBIiNikX1qZVqPL5raWl9auiR+zvT+gWjmKphV+fdI5eA/en5AbljuKoJRQ68Z1yJFW1Qz3l+xELJ/XM4xK9rFI22GLAXHVkrWfCQwMFXwTEIeIA92/HgRAGlzy1YSRoEBDXvDKsq79V+vk0EiPNS;25:TPisawrjWIdqyLiwBcf//CtlClb7z2R6zCBljX28ZXBlAi8YdejHycRjH9irdR42Ir8hbGp7RpQ65LGxuW4zrDfUBesa7AputiM6MWJS5PnFwF9IytPmyTcWMJYQ0lqXPt9OEPrz327/EDfFoaSevCgDKsozIgkfrk7RcoIiw2SHKCAuFEBeJVafIpS0alTqmVKlvpcg0xKg3bOIFnTzG0emiFdZ4HEaai53Ce+MvtpnU2PXqFM8RDgj5j4HztZwt+0/FciiSwuoA61hGPMikAt0Rcp67226tO1ZDEvjlyDvRHwNtn2ND3msM950h5IAugttMPzq9JRh4aqAWPoiPA==;31:ZIL2m42qXjOoJXuS4+oIhjd8oU5kHEnXHZfNJ8K+n49JDTyDLM41m2gK9twfT2aEAOPw/2pfwokT6xVTd8pTOG22xDV7mXDYIS8KnidzFfzLuGmECwX+ADbrWTHAwc3JT5ceR48qZzZ3SYhjn2A3Th6/P0fZ5CjblWuG4bCBwuQXJpVro6wV3ZNrJOrENvlPBMa9F1RJ7yJpgyMq26BA2avOy2/UdVovRGqdxJ4WdLw=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1332:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;20:+KKbsgmcIYTav9NUxyIv87paAm6QTlwNI5aESHk2i5GdM9mMwc5DdlQKRA+ALm9TotcPIQbSixHYuH7G0nhpvYfUoPfHTzKXH2Md0i6V29eGFwMzCbUMlDTuYi17jiAfOMBgvP+SdHkPH4XpB+tWuE8t+MhQn4JZ3PVdFd6FmC31Wz0WRm5DVHtCxOf2fHaDuQKntAOI6jPUr3cEU1W2bQBNUNuhTF+NDuYz5fY+oZW+Dq6ogGr/GHRIQUlt5EAY68WLFqHoGA/PTPhrPAYRoU1mNooQ/o1gteSiNGlhGIEH1QGRtpzl+jHbpzlhxGwcFcm+9kWwVG7jjEbvAvAnz11atIeixqGR7Fi0Aekr8kyZOwigearoDiHpbekmINI5QBEv+RkOtPStd+ousmZUKt3P2RBjk0eV9mxETyLrw/bhLPywnNPROFxxp55IGX3Koc0/07v2C9xdludK0xkNuxOXKVXI38XGbXRF4PlSNsrBIeI170urSWGIqgt+VaD0;4:HWGNi8kO8qVBC+OUylpTqUyy4CZzhfubhto8lDSnoHVtQJbOyo/thJyYrlDfhMl9aqH/Al6XACH4VW3BvB74VtaNw4dYv3VW9bMe3JcOK8OhsWutMjAroVUlW/n6sclMNn4zfvCBFe8mhEjbF/H0XVdDOk7gXZmaX0ZpWmR55LJSPJX6gjL6mOGCl+Z0QuB68eT+0pwL+efPN2VOA03OEEAu6q5ZRTPOAO/K9yQkr6q4/1LyuYiNEecke7TPEopbMqONJdorX8IKDxeo4+tJzg==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1332F2409505DBF974361F57CD980@AM5PR0801MB1332.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:AM5PR0801MB1332;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1332;
X-Forefront-PRVS: 066898046A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(39850400004)(376002)(366004)(346002)(39380400002)(199004)(189003)(54534003)(105586002)(68736007)(5660300001)(66066001)(3846002)(64126003)(16526019)(31696002)(65826007)(229853002)(6916009)(65956001)(50466002)(2906002)(47776003)(7416002)(6346003)(52146003)(76176011)(305945005)(53546011)(386003)(81166006)(23676004)(486006)(65806001)(26005)(36756003)(2486003)(52116002)(476003)(2616005)(77096007)(956004)(6486002)(446003)(11346002)(4326008)(31686004)(478600001)(106356001)(25786009)(39060400002)(97736004)(316002)(7736002)(6246003)(16576012)(58126008)(53936002)(230700001)(6116002)(8936002)(86362001)(8676002)(81156014)(107886003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1332;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzI7MjM6K0NlR01FRElRbFZNSGoyUjY4MlZqeTJh?=
 =?utf-8?B?SnkwS05RMWJMSWQ1WjI2L0hFSGhqejRMVWNCdkxiRHM0WVZjaERqNmFnbW5P?=
 =?utf-8?B?eXVNaFFPWURnTVNOUDNLMkQxREt4YmJRT3V3Ylo4Q1JwOEs1VXVraUVWaGlV?=
 =?utf-8?B?WmZzMXc3WHRyRHV2V3AvYno2ZXNDcXM3UXRlSTJJWXk2UUw1aXJ2dEJtWm1p?=
 =?utf-8?B?N2UvWGZYTE1QdUU4ZDhQbFZxOWVsQnVMTGR6NUNXY1ppRFRlaFhSZWw4OGhu?=
 =?utf-8?B?RVNSblNja04zRzJPeUFhWnk0UlJBalBabjZwOEtVaXFVM0E1MTlsS3VuWjZO?=
 =?utf-8?B?TjEzUmRlVDFmdzlJVldTVG9nclp5QldDeTJ5Vk9yRGQzKzBrZEFMNnJCMG5l?=
 =?utf-8?B?eFcyb0NjeUhzQU1tQjNneFBBQVp3N2Y3SmpmSEVkVzRVZXVVWDBjU29zeDFx?=
 =?utf-8?B?QVQ2OW9YQXRvQithaTBlYmh6bmppc3QrRUtCeVlWaEVoZGl1TTZzSXNpOGg3?=
 =?utf-8?B?TGpGd3NSamhZYzA4LzdZaTNjUFB3L0liSkd5VkJvbE41a09rWWJ3Tk1ZRHRT?=
 =?utf-8?B?d3krdkNCL0I2RkpTOGpqaXZVZEtnRDRycERBQW5aS1ZCRCtYWHRFYlNqdElN?=
 =?utf-8?B?emt4YU9pQ0lqQk9uU0Nrb2Jpai9tcTZwVmUwNDdqSWdyZmtXMjFsaUxDckR3?=
 =?utf-8?B?UTBoQkQ5OUhBVUNQYld0MDhwL3JyY2dQd0JBUWZnNHd3NjFIS2ZlZHpoRDIy?=
 =?utf-8?B?SlZnVXZzKzhZSlNsaFBtaFhLNzJscmpJcjNvK0ZJZ2djUUlCL1l0bmorcjRm?=
 =?utf-8?B?Rk5BeXpsUHpGZFh4OThGd1VQOThWUVJRNXVVK1pMd09JcFl4aGtqaWgwcVp3?=
 =?utf-8?B?czJQU25IOXMvVVJsMUhRNFVkQWUrY1hYUVRYSU9nQ1A3M3NEaXpFSnZ2bFIx?=
 =?utf-8?B?UTZuT1VRTkZKRFJZK3RCVC9US2Fha3FjYVVYYVprSVFQeGlKaDFLUGFKeXZY?=
 =?utf-8?B?OGw5bjM4ZFlOR1BGUnFOOXYzckd1b0JFN1M5V1VBQW5GL0VwVzdESDFNV0hn?=
 =?utf-8?B?SkxxbmhGRlNQTkNyTGJDWlZqMnQ3aFVhZmF3MnhvUmNxWU9YbmhSdy9RY2JQ?=
 =?utf-8?B?OEdiSW1rWWtBZ2psbVk5TUJMNlFwd1dlYWRBb1U3YWNHTWRUbGZ0SnVYVm5S?=
 =?utf-8?B?NnlTRUt3bXNqUnNQMEF4cmoydUR3NXN0cGVLK2l2cFIyNFZQZEZJMFJ6NzRK?=
 =?utf-8?B?ZGs2bDczbTBOeVRBSk4xUTJLQldhNXNlNW5nY254alQyOTBhVXRWRWw3eGFv?=
 =?utf-8?B?Qk5vT251NWdzZUxuV3hJM0ZHS1N3V3RwaCtoRjhRVmVXQ2l5dVhaanlxbXNa?=
 =?utf-8?B?b1UwK0Q5NmJOK0JNaXlvTDNFdlRMMllkZ244K05qWWFrekJjT2FVdkUwQ3Br?=
 =?utf-8?B?ZVpGd01DcjF2aEx4SG54QzdQNVBuUlVqVkpuaVphNXg5cUpPc3l3RDlucHFo?=
 =?utf-8?B?TlVvdWl2bWV0ZlZYTUU4UkpvdUlGM2FqNm5hbUtFbEpjbndLN0g4L0ZpWjE4?=
 =?utf-8?B?WE5PUVp0RUwvQWtuS21RYkFFcHoyMXdJSVpWY2QvczFRODNHL25EQWFJRnEv?=
 =?utf-8?B?SDZ6aEF0UUVPY0k3UGg1ZlJMeU1qVEVENmlSdkZSemtnR1NBSFZqT1c1QURj?=
 =?utf-8?B?eHVYZm1GL3MzclNTbEh1NDk2b1pHb1lSNDkweEh0OW5iclFOZnFSTnVjZVZI?=
 =?utf-8?B?TGdTRGgwTEJDSytyVnNGRjhmSTNPbGl2WWtlWSt6SlkzRmYrV0x2dS9mQ2JB?=
 =?utf-8?B?Wit0TTRHV2ZRSXRZR3ZadUNZLytvQzhjLzU4dHdZd1lWN2JhenhIMUErNW1t?=
 =?utf-8?B?Z2NxZDE1RGlJWG1QTzR2U0wxcTR4Z3piOFRwVjFzSFhjR1dhVExsdUVMMEdK?=
 =?utf-8?B?QndYWDZQcTlWY284THhVNzd2b2MxalBJeVdDcEp2YUd4MDFJcm10UnYrQ0FS?=
 =?utf-8?B?UU5TRTBiV2hLdkh0OTZLTDNHOE50a1NzdFd2NmtBPT0=?=
X-Microsoft-Antispam-Message-Info: sScl6Tvny7iZtaMDj/80QXEvhWIKLTmKVxsdCmHq0wuC9e03/XBVjYzgbTybqi5X6yI3dRLxV4t9/41HkGC0WciVQb505OWKXBheYhVA2e4rJxZ/Z/K8o0I+itCGoWSqe9+hTt/DAWo5FFulk1YrT33Hm+JwX5VVLgx6BbZA8NZbxK1ERoY5MdtFW02tt5EA
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;6:j7JZv5pvpkD2EDNMy/yhfOpqsEsrgyunjyQvZiiYKRAogpmnMiTe4BK6sITvUBl7jrmev0UyCk5NvU1nFED5K9cecQwWs0Ur1iWiJA4keSo9e1qhjAuKR3rTeR2JsUd/2mjtxGH6tmz0qi4FPPSKSd4NNECiJ1SFmBiVpB5D/t0Rm99cvZ4AgSMfHLoxiTgBwr7iLZmNUMClrSPdV7h6aevoP8HLY9IIMwkcGIa9RUOtCKNOC9ZaPIt9vSSaG0v9cp08rsOk7Yi75VPHguvjXvQZeXxsDamL3LMgR+qPikKOnuU1Vd6TLf7wUJZaOn932EeTNSEu4M685HT6rqstqjnG5f+13chjw3FdPCmhLvrP5IyglEAExtBmyt5LN/qbdRJ1eqIn+SHobyYXCpBGKcROgqMgOFwn4c9g+Y1z083myGVN0g3uLqaQOPQihmIRpHhJ9qjuYxvj4jVKB9dhcg==;5:A3/7ciF9k4pxHFGu3iRAKRcLkUnsaizBNQV9m/yDc7Qn4dR8gLQ74hkfqDuNJ/R8JFwhA+TXgwNzYwKDfEv9Yv5HysvyKvyl/XAe39Da2LVAHCiegvT0B/X9i+NMXpWo4TmGxgDQ3MHqxu4chlBSiCPLPUZrQf3UkVqAfKsErAs=;24:cF+oLdwFRM1ntiPKsulWfM2kkcgieLg0nl8qNJgVSO210n7nM2Wq+mzt/vZyUHZGg52FEfq9ydeSLgak6jzFKowalHKBZ3Vcr1x1NQu+G/U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;7:Hq7MjDjZS4xgXo7v0M4EofBs2yIIiXyLCYdwt5z295b7UMupvXrYerT2osHN5ubEX31gCNebtScstnL/kQYVrel8nNy3ibwLyXoRz48Lv5yCtFE+l5PTsZkFt7UR19NfZnI8ZqihD1IVhiVt+jeCl5ld/m0jX/qf8QZk50bu/iz5Ti3dAUjlPSfYQjfYxEnedzKpAJ5boCUUmQ/kvPWTN3nueRaAgiwfLJIBm+6Mp73k3n+3CuRdU1nW/REbMuWz;20:DScn/WZr6PGk1vTmauxq2croBxVMZfEkmpevYcszA7fpBedFxsEq9YMGVNrkJH401h5lm1sUwbD8lWr2Hq5Okfo8KWxnmtJZny8QCaX1mNWv1wEil41khph0/WONTSkI1OQzsC3cUkMvNA4TZUREbHA5AZ3qAJKJPKr7MQHqcXA=
X-MS-Office365-Filtering-Correlation-Id: 7beaaa72-0751-4029-6907-08d5b65a5f9b
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2018 09:42:39.5011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7beaaa72-0751-4029-6907-08d5b65a5f9b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1332
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599987539736036809?=
X-GMAIL-MSGID: =?utf-8?q?1600069687540226008?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 10.05.2018 01:55, Andrew Morton wrote:
> On Wed, 09 May 2018 14:56:55 +0300 Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> 
>> The patch introduces shrinker::id number, which is used to enumerate
>> memcg-aware shrinkers. The number start from 0, and the code tries
>> to maintain it as small as possible.
>>
>> This will be used as to represent a memcg-aware shrinkers in memcg
>> shrinkers map.
>>
>> ...
>>
>> --- a/fs/super.c
>> +++ b/fs/super.c
>> @@ -248,6 +248,9 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
>>  	s->s_time_gran = 1000000000;
>>  	s->cleancache_poolid = CLEANCACHE_NO_POOL;
>>  
>> +#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
> 
> It would be more conventional to do this logic in Kconfig - define a
> new MEMCG_SHRINKER which equals MEMCG && !SLOB.
> 
> This ifdef occurs a distressing number of times in the patchset :( I
> wonder if there's something we can do about that.
> 
> Also, why doesn't it work with slob?  Please describe the issue in the
> changelogs somewhere.

All currently existing memcg-aware shrinkers are based on list_lru, which
does not introduce separate memcg lists for SLOB case. So, the optimization
made by this patchset is not need there.

I'll make MEMCG_SHRINKER in next version like you suggested. Even if we have
no such shrinkers at the moment, we may have them in the future, and this will
be useful anyway.
 
> It's a pretty big patchset.  I *could* merge it up in the hope that
> someone is planning do do a review soon.  But is there such a person?

Thanks,
Kirill
