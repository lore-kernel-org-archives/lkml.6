Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AG47ELtTihmyVqmEe1K1wKJfBSjKU4mr7x7q8C9ShkG2B8Wi8cUrutfP8ukuRdV4igkIoBzEO/3R
ARC-Seal: i=1; a=rsa-sha256; t=1521650565; cv=none;
        d=google.com; s=arc-20160816;
        b=OkLEhZuGR5BoBb5mKdHE0smz2dksQIaZdbb6o0flmkMosIKOh0o+MmE4Sl77qMQ5Vx
         CYfrf38P1cfGX80J+oFfYLFDP41Mo/eKgNe9kBPvwrz7yKPKw8/DGXw2Tj0eA+x9jUjd
         fFa5/72lV33Dt0nvSciAc38JIbpBMn14FJWDODvn2xlxrJ/5h3MFNDR/j9nBHCUIodO/
         7Ams/mQk3GpqEfYGqzxuQ9eqRWTu6ilnaWPY1ElysE6Fo/CUq4KRn2SHqz3xDvh/kFha
         MM7mwiA5+CfHZS1rG5Os1ZQae9ZAFBwV2rsHjMBp1F4JytlDonc675jMHXzZHiFAEYP2
         5Fug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=ITwxWdJxNXZdqsPn2CGsz+Yuie/c2AE5/ilVAv6lAc8=;
        b=CgP75dmDmDSEYXE9YHhlZjsjgBlgz1NZgZ/KXyMD/4fyngrq9KZYk3N+mTFsttR+cy
         A+1+Bx0y3U09KuS3HyYRZHnFlYk8w00njriPiBNcfxXzWJgSGGfQxoOhnzQMqCil636V
         Dd5oUm2WnRCcFyLfZNZLFarfGQuKAEb69ON8aLEns6tjpDrpbUElFZlwiXHrXZvZQnfk
         Xh/HDhBOEk1rwc5YqLB0T78G5UjP4Gy5Sr+R8IPb3nuYLbeGsal0A8Xg1EUx6qyIgBZk
         UnimB6PeMIv+eio5XHpJwEwTnxtmE3vCsaZNrvZuVVRm5CWAFAQzR7gQyw5YwbnfQXmv
         +ZtA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=DdhFvYpj;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.103 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=DdhFvYpj;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.103 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
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
 <eda62454-5788-4f65-c2b5-719d4a98cb2a@virtuozzo.com>
 <20180321152647.GB4780@bombadil.infradead.org>
 <638887a1-35f8-a71d-6e45-4e779eb62dc4@virtuozzo.com>
 <20180321162039.GC4780@bombadil.infradead.org>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <d738c32f-78fd-7e95-803d-2c48594d14e2@virtuozzo.com>
Date: Wed, 21 Mar 2018 19:42:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180321162039.GC4780@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P192CA0007.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::17)
 To HE1PR0801MB1340.eurprd08.prod.outlook.com (2603:10a6:3:3a::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d3f58d0-4097-476f-630e-08d58f4ac3f7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1340;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;3:cGounfFW28s3MBi/jitmhq3jpjg1FuDNBeCA9YLtUW1CMLkDi1KbDE9e/FHtff+5nejqsmra1PeYJ+dscUqM3mUwj+xLwa0ug2NA5FwVIExCXGtKnLn/vI6CVgjQz07iYeJjkOQUtIRLfYk9GFZTJ+XaEYwTo9zbDAr2ZAkDhqtrUvLbTpYnA3Z2cC+N+5RbrV8FPZJ9QWuSfQsaDQ/6lcNjQzJFKcQvxm14gMKi+5zkWW0dv0tRBjgEBjNmGSwH;25:2i8/G7hkj2JL4KOUXZgyHWb+VVXOBPDXUy73aE9tOECavz09KuRmNlBLG4IuGelSI/vZH1/YEh1Och/lWEdpXnveA7esBdc+s2y4vvo71j8fscX0Ls+LQ9h0XXiswugvBI7+AQbAQirzypMcP9Rjd422wtKYMvIDZMsVLE7Rw0/EcMrAx0uSXfGREwOAb9CF/iaWX9RT7CprZj0pSuMe6gbUHIgudAUUlOhmAL7hFNR/i6OEsF+chaH6UIpkMX0nVualSrVbHq3jygDxwqyC66tzra0MkzImKBgB6Y9bNX49XvNRS4WK3yx4h/TN7dJ7KDrQUt346jgfB3V4Cj2wdw==;31:SHR2gSuOuEDoCV2nyz7OLc1enZHJMSQXLksFxqcA+I6BvobVhJFVXrMmKZaksJiMQbkLLMWiFsv7DOCF+Z7pdhuOrrHmr/uxY1qHA+HuB+oBuD3A4rsi6xZGhih+liuov4jb3ZQf933w06e5v+l+auTGG1D6WgwxGDKGLF7Xcw4XCKk4i2kYdKPkehkHb1pce1ZlUVMCrY2WduJ5DFExaVdVXwLitecjNb064geArw4=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1340:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;20:SkTHpl5i9Spmmf3xQa6M+fh7gLMuLKyQvD6n+iB5g846YqPz3HYWn2ZopkWsNsWSamTH+2Zw4g5/dHorcKrfvaru+ZZ0qoyPSK+3mDl3ZeKpNswTC3TzqYhui7XgwGanRoYAEPnX5WPzQ+GFE/eW9ajwcdcWR8s6BAR0Go9HJ2KDcJXfBr3z8tTfezkxhLwU/YRtPWTlbpljn++MYWA7udkLa7hqfvXVuJ7SgXhxlXCrlca5anX6Kw71sj/tRkU09T6yfriIdDm6wTwtRGm0sqz6CgKLlcz4Xg9bUY1ZU2WOfZRbvHmvfS+tQ9lzUoyIxB1plNAS7y0i4BvKq+TYStfDoLtsfefDuH/LGlY8pJ2F+CFsyDOd8PHLKsZxscTGGsr2drlP2DyAbXzSCgeew7t5zRqWIqTFRzGpqW+gycJP5kwhVKPs/YcZ1NgZHCGu5RBI/gO3SNv4CcGToDx9y7B521ZKqLVkvctA9s6jdmQxfYxAYvk9GiOQXZUMPXmR;4:6qIdepoM7esaj1STcRQlz4+CFEhP1PtsN0pZ9Jc8tb9H5cFRQa68JKHdF0TrCNmw3YehvIomk4KGSvp0k3AIv2poYcWwhiAi0IZ/UrQmP0kwjCw3g9REPsBofXOb/5i/rOxHgBHvmZsioSWgFdtlkjjPF7DJa25d8BhthfOKgZJTONeQ8r9iCKoHDMnfvfWKVN52laFKNjOBrHFebFrXz0F+5ZW9G8BJ1xLpaGP1qScxZF3vK6CnXiyPPxy0hgTRjI57EIut1yUlhHb6X5o6/A==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13407C153383DE90240FFD8CCDAA0@HE1PR0801MB1340.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501324)(52105095)(10201501046)(93006095)(93001095)(3002001)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR0801MB1340;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1340;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(366004)(39380400002)(346002)(39850400004)(396003)(189003)(199004)(105586002)(39060400002)(8936002)(316002)(81166006)(86362001)(230700001)(229853002)(8676002)(58126008)(2906002)(16576012)(106356001)(31696002)(4326008)(36756003)(50466002)(386003)(53546011)(25786009)(6486002)(93886005)(65956001)(186003)(66066001)(55236004)(31686004)(47776003)(53936002)(23676004)(52146003)(2486003)(7416002)(81156014)(16526019)(26005)(65806001)(5660300001)(52116002)(6916009)(305945005)(59450400001)(65826007)(6116002)(6246003)(2950100002)(64126003)(76176011)(478600001)(77096007)(68736007)(7736002)(97736004)(3846002)(6666003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1340;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzNDA7MjM6VGVVaEEzTlJYODZZb2UwYmJWVHNjL1hJ?=
 =?utf-8?B?a2VMV09iYUh4cWVIVTJ4WXpkWlgzTEVOckFNZHFhUkZUdityamFuaSswZTgx?=
 =?utf-8?B?Y3JpSk9lbkV3Q0YzNFp1bVJCMUlIVUFDdjB5OG4yNVk3K1g2SWt3eWNBNWxK?=
 =?utf-8?B?ZmtpT3ljM3lZcG9iOHV3R0VWT0pwS0hCQk1LcS9FaE5pZENRQlNZZk8zbVdB?=
 =?utf-8?B?eVdSVGFLKzVjNVNmSXM3YmIyT2srYnJNWGRjZjNWNXhaYnZUbmh5WXNtS0ZU?=
 =?utf-8?B?MWFoNENjWDhPeUxjUkwyd1ZRSE5EWWcrTTZoYTd0UTZNTk9CTDdQeVR2WE8x?=
 =?utf-8?B?QkFwcEc3YU9FQVZSLzVFdXNpODlRZE5NM2lSYVdFOVVrM2pUbC81Q2lRK05O?=
 =?utf-8?B?TXgrR2Z6YlJwL05HNUhCSDJKU1RjVWlXM2JhM3l2ZHRybko3VlpTYTk4VURn?=
 =?utf-8?B?QXk2K0dWK1hUZFlZQXhLRktrQldSRDBvWWRGWWpxWm9pSlhuaDFhOHhaN1lv?=
 =?utf-8?B?bXIrTy8xa2VrZ1poTWRIdGFOZC9QeVhzNm5VK2NMZk1Xdm85cmVSbUFvOGIz?=
 =?utf-8?B?UVdYRUdSbWFlOFhUWFRTWUpGWkppQ0J1WEs2UGcwaXdLRFdYbEZLSFpzMGFj?=
 =?utf-8?B?WitFSExxRUlxSEhIV3RYUkNoVFk1QVVDcEZEYjVlckRhQ3R1OTQ3akdSV1NI?=
 =?utf-8?B?M1UveFF0T0tzaG8xN2QrQTVsVlg1K3B1bjYzb1RJRy9sNFBmK3RHRUFNRXMx?=
 =?utf-8?B?TVZWRTZYWDlKTjVaQ3dsdEpGMjFEbGs2ZHFCT1VTUE03Qlgzby93N0J0enlP?=
 =?utf-8?B?NXd2MEhjcDF5Z0ZHaTdGZXBXZGQybkxETEVCdnd2ZjZuVWkyaEhSZUVVZHhT?=
 =?utf-8?B?ZnBDeWw4cUcrVTduZzROVlpWbHliTENtNWNzWSt5N0lWT3J1Y1ZVSWw3dVc5?=
 =?utf-8?B?aWRBNXhLR290T2FicDM2RnNDVUNiYmliVzByemxaMjhjeENZTFV0eWpZU0Yr?=
 =?utf-8?B?WE9xMGdKWm5aQlgvQTcrY3Fsc2trTXVXTVhEYXdneVdlazZRMFgyRE9Bbmx4?=
 =?utf-8?B?QmM4R1RDODNBTGJhN2RJZWlMTUJwYkxXeW8rdnI4bUxHTzV4N2hlcGIvSVRM?=
 =?utf-8?B?T0l0YnhUdjVXaU5XWWFmWmhSNHB4ZDBKVmlzNXhTOG5IdnAvYXU3QW1paStz?=
 =?utf-8?B?SXNCUGNuWUdScGdXd1M5aEJTbFdvdno2V1VDWnFmQkRZbzNqdDFNYVpybGxU?=
 =?utf-8?B?NTdsVXRtK0g2L2U2U0ZnS1Z2WkVHRnBwVlU4YW5EYlZuaDVRRXVOWW1nMmVV?=
 =?utf-8?B?WDZtMENMQzhNTDh0bkU5enhNa0hneml1aFpFUWVpWnJER0piNCtHNjIyM1o2?=
 =?utf-8?B?OENYV3VJNFR6NVNtSWJqSGtrcjBNU055OVErdHp3anhhclFFazNtR0ZzQ2lU?=
 =?utf-8?B?cmZaV2xvZ3h2b3hySkYrS1VrZm9rZXFNTm0yNWJaSUdQSU5RNVVHUThRdHdW?=
 =?utf-8?B?a3p2Y3FnNnhWQ2xHQUkzNEVvclBYZmMyQzlqVWdHN3FvQS9LaGVBSXJuUkNN?=
 =?utf-8?B?NDdPYkc3NGYydkd4RTlWdE5DL2tVbGsxT2gzYkc3emZEN212RUwrYjcwYW9G?=
 =?utf-8?B?WDZYeUE4K1JPUTd1VXpOQWZibTMxOUdGSFJJS3N0alpLUStGYWViODJTeUFv?=
 =?utf-8?B?aUJsaWxDby9sNVh3bDdkVCs4RnJhaW5uTm9UWVZVekEzYTZsYXpOTGpuNTNJ?=
 =?utf-8?B?SW1IanNwSWluWnl6bFpObXNOaWhYOXdLekd5T0ZzcGRKa3NiUi81QUloLzJD?=
 =?utf-8?B?SDM5SkR2UElHck5YNzRwSHc2alpPL0NIQ1VNbjdqZTY2bEUzd1FTU1MrMFVO?=
 =?utf-8?B?OGJwN0Q5ak5qaXV6MW5xVEU4ZlFEeHBoR0xIRHJTeitHRXIrRnROMmRWZ3hD?=
 =?utf-8?Q?owui4SsR04gjuGKqJoO0BtwtTa06Jm/8=3D?=
X-Microsoft-Antispam-Message-Info: R5i85Eee/97LQIjE5hPCydXN1DeeSQvR/5udBQhNVJhUO7CplfrqtcHIIXttCL3gAz61kaaDz66rN5rrWj7IFGSyLju/WVOwBxJdwbhieuONEEOrg3YLJg9OBDP1XLR/z3LZ/pvgBhZR5V5fumqD5CyHKfRgCJ8KinrRaBg8oxqcf4JLsZcB4SYqNGOxXo5g
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;6:D2CZZClIEq4BubSU/DbHwijXPWMLORWBdeK3Y16zOKnHb0tQ3MvR+8STzcUbWJB82Zc55+THzMl1qb+NVYwZBHG8fl1nSdJ/RsXnUAQ2qtpbks8+V9RwgMKpd5sokJ51KLbs3jC3SXPqsklsNDGxqTSUD8Tu0+IAa5oZE+L0FxLu2C/SCJVPVA+EK/6s5fcodxd1xwCI6Dk2qtQHT65MeovGM6R9H5fiv1zXq2nyv3rEmsXHku2boE/xs8437um/Ye2Rmyq0Jnfzzg5DCyWcBgXNPPnSVeEA6At4fQa+Z1waEFgqNjXJM5ZCwZ0Q4xsmsj4qrZr3hUFk++bYMN5dU7BPi8YqV/Wz191Rz9h/L3E=;5:o/fKCXRnEqRruWooyk2WRsw4zH4mUZy3sW4gDrvkVxhcZRNRaUbM+fv5irf4mOrhmuz41nP6vk3SW7zDIvqT2IN59bIhEJnJbbbIh8PiifLBQPG8uuJVroM7OuHdKOp3rN+j/g5fnCKiEpaAogikckFo9sMo0H0+fBId6ROxAaY=;24:yf6B4eSpJ/7xPJqz4I2160OuTtcjhDFh3tfP+igQbVTtgEuVQcKq9XICWEUBUYJZZE96t0EN7/h0DfnOWkbLFh0qM177Z9p0rU/6e5mj+PM=;7:sil64yKsTGXQIi5MbusP5gi2TMNSzLmQXYo6qiwEP8j2B2Oi+qxS8lb3SoyoqdH/kXQrBeU1FcddbaALDDIT5bzzvdlLslRAzcDomqMJgcyeTHlI2yvBWhHLF2t3JEJlVsW2WhIKMmhn5ggPsnNRK5OMLOxB1l+pguKrLZluVFuIVy54WKABMMom4TMLYVIfC/c9TlL5oN+xq3seXKa5MrydS6yvLcMSp5Mx1saYtIYVHGKpOAgtUmn6MYH7j/DY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;20:/ZQktqf+cI1g9P/4oEqDSlsPHr8VyNmvOomoy+6FPJm8Q4FrubZ+y/PmxYZ6XBD/iGRvI5GtNCnRLNXjyqB/KnQ/5KPTj6effSTkt/7LBoG2ffAaYTgcICVjY+SexXIKRoae9HnFDdwNOMojW6sss/TdnFxh93davfV5s5r9dUs=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 16:42:41.2320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3f58d0-4097-476f-630e-08d58f4ac3f7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1340
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553622756842955?=
X-GMAIL-MSGID: =?utf-8?q?1595566263221747415?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 21.03.2018 19:20, Matthew Wilcox wrote:
> On Wed, Mar 21, 2018 at 06:43:01PM +0300, Kirill Tkhai wrote:
>> On 21.03.2018 18:26, Matthew Wilcox wrote:
>>> On Wed, Mar 21, 2018 at 06:12:17PM +0300, Kirill Tkhai wrote:
>>>> On 21.03.2018 17:56, Matthew Wilcox wrote:
>>>>> Why use your own bitmap here?  Why not use an IDA which can grow and
>>>>> shrink automatically without you needing to play fun games with RCU?
>>>>
>>>> Bitmap allows to use unlocked set_bit()/clear_bit() to maintain the map
>>>> of not empty shrinkers.
>>>>
>>>> So, the reason to use IDR here is to save bitmap memory? Does this mean
>>>> IDA works fast with sparse identifiers? It seems they require per-memcg
>>>> lock to call IDR primitives. I just don't have information about this.
>>>>
>>>> If so, which IDA primitive can be used to set particular id in bitmap?
>>>> There is idr_alloc_cyclic(idr, NULL, id, id+1, GFP_KERNEL) only I see
>>>> to do that.
>>>
>>> You're confusing IDR and IDA in your email, which is unfortunate.
>>>
>>> You can set a bit in an IDA by calling ida_simple_get(ida, n, n, GFP_FOO);
>>> You clear it by calling ida_simple_remove(ida, n);
>>
>> I moved to IDR in the message, since IDA uses global spinlock. It will be
>> taken every time a first object is added to list_lru, or last is removed.
>> These may be frequently called operations, and they may scale not good
>> on big machines.
> 
> I'm fixing the global spinlock issue with the IDA.  Not going to be ready
> for 4.17, but hopefully for 4.18.

It will be nice to see that in kernel.

>> Using IDR will allow us to introduce memcg-related locks, but I'm still not
>> sure it's easy to introduce them in scalable-way. Simple set_bit()/clear_bit()
>> do not require locks at all.
> 
> They're locked operations ... they may not have an explicit spinlock
> associated with them, but the locking still happens.

Yes, they are not ideal in this way.

>>> The identifiers aren't going to be all that sparse; after all you're
>>> allocating them from a global IDA.  Up to 62 identifiers will allocate
>>> no memory; 63-1024 identifiers will allocate a single 128 byte chunk.
>>> Between 1025 and 65536 identifiers, you'll allocate a 576-byte chunk
>>> and then 128-byte chunks for each block of 1024 identifiers (*).  One of
>>> the big wins with the IDA is that it will shrink again after being used.
>>> I didn't read all the way through your patchset to see if you bother to
>>> shrink your bitmap after it's no longer used, but most resizing bitmaps
>>> we have in the kernel don't bother with that part.
>>>
>>> (*) Actually it's more complex than that... between 1025 and 1086,
>>> you'll have a 576 byte chunk, a 128-byte chunk and then use 62 bits of
>>> the next pointer before allocating a 128 byte chunk when reaching ID
>>> 1087.  Similar things happen for the 62 bits after 2048, 3076 and so on.
>>> The individual chunks aren't shrunk until they're empty so if you set ID
>>> 1025 and then ID 1100, then clear ID 1100, the 128-byte chunk will remain
>>> allocated until ID 1025 is cleared.  This probably doesn't matter to you.
>>
>> Sound great, thanks for explaining this. The big problem I see is
>> that IDA/IDR add primitives allocate memory, while they will be used
>> in the places, where they mustn't fail. There is list_lru_add(), and
>> it's called unconditionally in current kernel code. The patchset makes
>> the bitmap be populated in this function. So, we can't use IDR there.
> 
> Maybe we can use GFP_NOFAIL here.  They're small allocations, so we're
> only asking for single-page allocations to not fail, which shouldn't
> put too much strain on the VM.
 
Oh. I'm not sure about this. Even if each allocation is small, there is
theoretically possible a situation, when many lists will want to add first
element. list_lru_add() is called from iput() for example.

Kirill
