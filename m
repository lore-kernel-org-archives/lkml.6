Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40C5C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 18:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B16C217BB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 18:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="d5w7nLgd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B16C217BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbeHDUoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 16:44:32 -0400
Received: from mail-eopbgr80115.outbound.protection.outlook.com ([40.107.8.115]:43085
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728054AbeHDUoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 16:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mun58nPOA3NdaZDzO0Vn9YIwc2Rij3XsYB1lS5+z5lM=;
 b=d5w7nLgd7kxGU2BTWnLMMFfR92vmk2nPEb+QPNdfAOAEMeNgLR10q5yTzi3CBTSgDiUwT2DmoYbvTR3tnmGi0e3IojyYGPJYCjfWmSXcDUROMxjukIdPA+WCSEb+phzbDFN5NDlPnSLmyV7LkAxLSDTLIkBOJDviK14sz77Nf+U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (128.69.177.17) by
 DB6PR0801MB2023.eurprd08.prod.outlook.com (2603:10a6:4:76::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Sat, 4 Aug 2018 18:42:38 +0000
Subject: Re: [PATCH] mm: Use special value SHRINKER_REGISTERING instead
 list_empty() check
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     vdavydov.dev@gmail.com, mhocko@suse.com, aryabinin@virtuozzo.com,
        ying.huang@intel.com, penguin-kernel@I-love.SAKURA.ne.jp,
        willy@infradead.org, shakeelb@google.com, jbacik@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <153331055842.22632.9290331685041037871.stgit@localhost.localdomain>
 <20180803155120.0d65511b46c100565b4f8a2c@linux-foundation.org>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <843169c5-a47a-e6cd-7412-611e72eb20ba@virtuozzo.com>
Date:   Sat, 4 Aug 2018 21:42:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180803155120.0d65511b46c100565b4f8a2c@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.69.177.17]
X-ClientProxiedBy: HE1PR0102CA0036.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::49) To DB6PR0801MB2023.eurprd08.prod.outlook.com
 (2603:10a6:4:76::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd6044ec-c547-4adf-0217-08d5fa3a1485
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB2023;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2023;3:wnAlo9FDUnMMAVVAIeJiaKgIZdaR9KsIqtHA4kelKFXIytSoxOCUJVcT/hqd0lgzRyIYbXzaNKpoqa6/GVh4qcV0WLQqye7Ar4ywm9KjWy3zE2siaKvLNuSHLcAqJVzlRbHhMuDEYWAXfpzssgVJJbEn4CalSlJwQBFGSMbgQdpSx3tfY9gbELTtR6whA8FbPTNALFe220bLaMggJyuQT2gxUYDDP6VUxk39xbzC/xe5bLHdjSZl0z3RHsit2Ak3;25:e104Wu/5IyQDrARIaYyHxLVZ5c6QI1ZKq1hybWKtS5sEUJSIO3QsMvOT52h5lHxCch7SxAZvjzPBfsdq6IdZ0ygkO7Q5N7TNz0o9GgH9xKY3eQ/5OkDHpx+Tb6XUVkDA+nWUH8FZu6Xu3DGr4rDyqSLm24S9FYnYe1fgatJoIYxlNEAO8YWBJKuWGjb/2H8Go1hCnY7rnnUm1+9rDfJy3s07nhUWpTJ3aYpZJ/OQD8F8EKy0BfgDfze1W96/X7+uei3+60xfApgiKbd3UEONHSTf9SM6RjbCbYGpvo3TLmpfWq7IPWWrdBrwNxWpq2jnuiG5MdyUqPbEgmHTy5ZlYw==;31:bJeV/Q3QOLmoQobTRGb1UjCo2gXcXVt54L0LXtQ5n20cDiyuvTvL7qihxayptslRM7yVGL1OiWBz3IKavb7MQ/BgZjL0pg5GKLn8h1RAbTBmtEaJSDdkc6Zo1MI6Q8ru0OpqIM8RDl0T6xsdwo4hSrv6lKNYwz6wNMcP+RKwn+9+XRy4r87fCcw46wMUYNOuqMvUsRYWt1yZ1J41v6pWaOv8Mq6SuQ4LAeEXleNM97A=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB2023:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2023;20:huz5AmrrdpHsvYxTBPRm18DrR+NobkjE7rJN6Q+qyip1V1t2skrp/2+VI5ofeSYArkYt7m1Q1u7ZY16O6Dpqs2AouezdF4PXJ92a5J3hsW03z1FBcL8bFCxKrDT0yWBbF/9ylczW9lrrj+nbs3YyDZu3Fsb0XNZXDGyFX8AHKoz5iurP1kd1I8jLyrk0UrGG5vgsbcbI/IPcgNDtnPvisIK76gVVUV0DCEVKV8p+KcDkqveGHO+b1jHYVC+viXilm7h/EJC5GVN+WKpGIKb1iEMq/rbCub6FJjjk/xgPDxW0wvYaq9QTKiRpGkSnOLCJ3R01cHuw9t1F5yfzxFrJ/xQJgVGvm1mrL3GytrwfiWj8/nPUNmo8Olme9uAN2eJnKMxMSxoGvKh9mNVJbsS56/lMh0mE+/2cnzakBPLeLYRTKX4P7baKA7IqhL13iwZTq4bXZxZEyA3/d8TzGhesFfs87tDJZOMY+DF8JSyLcKESBydiD0gMn+kagPhpnKFz;4:ATmkZckeM7jdMBUXC5QGgugHQnSKZelw2IV3NzFlVfuLZCEVAaZAqx96Vdy/fqMNd6fofL+OtQDn1DCjmez+azK348QDMdiVMcLS7SsVAxjYbJ1cl+GXQPuX5d9+5BFJtr9dA2PQTd5BO6m5Ti8OuiBEYOqQDv8Y3CBq0xJz7k2oyei1ZIu3p5SZdkRe74v6XHZe/sjklHMV2v+LoIa3AVJH3W4K9K9g7qlFNqe07EhFvS1AYiyiF5xL2UVmHYYmJeBGS2t7lDkiml2rvQHmrQ==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB2023D65639133C8757D7B938CD220@DB6PR0801MB2023.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB2023;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB2023;
X-Forefront-PRVS: 0754F7E325
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39840400004)(136003)(396003)(346002)(376002)(366004)(189003)(199004)(305945005)(3846002)(7736002)(16526019)(6506007)(186003)(8676002)(6486002)(26005)(2906002)(386003)(5660300001)(55236004)(229853002)(53546011)(6666003)(6916009)(7416002)(31686004)(8936002)(65826007)(105586002)(52146003)(23676004)(2486003)(76176011)(106356001)(52116002)(6116002)(230700001)(58126008)(47776003)(478600001)(68736007)(316002)(64126003)(66066001)(65956001)(81166006)(81156014)(6246003)(39060400002)(4326008)(65806001)(50466002)(25786009)(956004)(2616005)(6512007)(53936002)(486006)(476003)(446003)(11346002)(36756003)(31696002)(86362001)(14444005)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB2023;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjIwMjM7MjM6UTJHNkFSMU94andiRHV5cjRCblE4ZzM0?=
 =?utf-8?B?dDJzekJjc2JsL3RGQldWTDVzNlA0SGN5MUFMM0Z1bGZhcDNZN1NyOURWQ01j?=
 =?utf-8?B?Ulo1UzFhWFZvYXVocVBKUnZrUjIyeGVIZGx3MG96TFgzU0x1YjVreTRpWFVW?=
 =?utf-8?B?d0NEU1RzZXd4OEllNjNkUnRtUmxJdzQydW91NWFDZUNPM3pYcWFIUE9abE5j?=
 =?utf-8?B?dG1peFlvWE12OGZVN0pDTEVjclV4VTdhRUxLWGgzaWdMT2pDbmEra21OYk1x?=
 =?utf-8?B?T090Qk9xWEZvTWtUc3pKVEhPbzJtZ1VkL1hPeURjWWR5WTh1Y2Y3MXlEWmZo?=
 =?utf-8?B?bkMrMExQak5CYUhWY05vZ0lxMlh3VW9FL3VSTmhZMUl4VzFIdm9wcFd5RWls?=
 =?utf-8?B?RXlGak1xekc2VXlOdUQrbTN4ZnpWUkRDN0RpUkFNb2orYWR1UG9FZnFGRCsr?=
 =?utf-8?B?dFBtNHZhU2FjUVphbFdEMk9Lc1FMOXNGUlM0NFkrandJenZoby9XMTYxN1FT?=
 =?utf-8?B?RTZuaVBITlBqU3lkdFFCY0hqWTdxUnhERTJ3M1d1QVg5aDBud1lTUGsybmxS?=
 =?utf-8?B?aVZxbjFYNjBKV1k2eSswNWRyYTE2VDhFUm9WWWRkSm52VWxPY29vS2dvUVZF?=
 =?utf-8?B?ZUxPMWJHbktpZHJya3VLVGhtc015WGVJaTlsc3paTXJ4UHQxRVJlbWQxcG1z?=
 =?utf-8?B?SnFwc2t1Ni9EQnY5aE02MnZIMy9JYVJGS2IxY0FhaSt5a2kvS3l1T1ExVlg0?=
 =?utf-8?B?VXBWcytybGJGUFo1bTBVWjRqSWdRb1RsRk1MQXhFakE2Y3NzeURqU3FtTkRi?=
 =?utf-8?B?U3RRMjRMcm9TK2t2WHZoNjhORDhQZWF5L3NDbEtTZjlTdXpNcEkyR01iblpt?=
 =?utf-8?B?NmhhUXhPSG5nemxkRlZnZDB6VFFSM2phOWNHazN0SGY5QndLSzl0U2xBTzVi?=
 =?utf-8?B?S2FIZVIvWnR5Ukx3SHFqSFFrMTNHdFNKYStHNTBoT2crTHVFcFl3OTFSV3BD?=
 =?utf-8?B?ZFZmanpGTk1WRUVKY0ZFOXBleFkxZlZZelI4c3VLeDBvOU44dGpwa0JjbUpG?=
 =?utf-8?B?a0c4ajdlTGNnSzNRbnVlRmgxSlhkdzQ2VGthRmNmMUY0cm5aczBCU3ZGNXRo?=
 =?utf-8?B?T1lUSDF3ZWw5V0FHSU9TVkZUZWUzMGo0akJ6enBCWnR6dFFDYURmZWQxZmJy?=
 =?utf-8?B?RGZTQ2RyeGptWFQvNHV4eUlrQ3ZsTXpJbStydHY5dG1BMjJwbEQwcEp4b2JG?=
 =?utf-8?B?TmVxSThBVmVySkVmQVY0MUxtbmNOb3oyamFEOEg2WUd3QjdjTkZNZlIzeWFC?=
 =?utf-8?B?V0VXaVJBNTdFOWN0a0xSdFJ2U0gzY2k0TXQ3d3NsZGJDall3TEIyTTBQdXdy?=
 =?utf-8?B?NjFtaTZBN0tWMG13NUY4U2duTTkrdHRoUFRYUUMyMHZTMHhrK3RsK3I4MkZM?=
 =?utf-8?B?UUZBRTNuTnhvTnEyQ0pwYlVaQXg5NzdNQW5wRFM5UUgzQUs5dDAvV1gxa3dw?=
 =?utf-8?B?MGdVYmR0V01BY2ozL0xxUG96amdCcm00MHdtM1Vha29LRm10U3FUVzFGVmxw?=
 =?utf-8?B?c052cmNQQmQ2Y0p4aTNjcVk2V0ZhWnhKNzJ2bDB3U1NLZ2lLc05HdktVeUx2?=
 =?utf-8?B?S0tnMWdaQVVVc0k3d05ja0FjaUo2SnlNVXlwN256YWl5WVd5T3RHMHY2cFVh?=
 =?utf-8?B?WXdMNlFOVmlHYWpWME5ENXgxNGtobGRMUE83SnNyYWhZRnltYnVmRUtNUThG?=
 =?utf-8?B?bXFwb1c4QkhhWjNJSmN0bTRYbWhvNERSNFZDM0c1a21xSHEycE5oM1g0dE1m?=
 =?utf-8?B?KythY05ZaHF0bWRtcHV5emVKaUszSDhLaGdEZXFOMHQydEdPcUltTlA4QkNK?=
 =?utf-8?B?R0p4a3BLbzVEYzBzREZ0enVHZythKzhRWWY2YlB4ZUEwT0tPU2VUL3grVnlq?=
 =?utf-8?B?NWhwbXJzSktoZjlqS2h5ZEpFK3JuczhPMGhwWWFpUzREZGduNWtLN3pwbkFL?=
 =?utf-8?B?TkxybVhXblQ0U3o0WjVBY1NEOUtqOEFTczJVaGpnPT0=?=
X-Microsoft-Antispam-Message-Info: g7rze+WAh65KZKIMrK9qUVHosaNcA5WOKHFHtdirWNwCnu1YZNHLFTRL1Qy8bFG3POxFIB2bFAPIHNddjtxO/mq9gAwgqWjNRDxOY3vmAZlIT0e0DWuN4wsZ7CnBDI5mFhB8d9Pj2xFPl4PSBwEnIJMl1P6k7L+JeSdCMSvrZk608tJTe0k83/Yl+d8x+1XcG2f7OeNXKTWkrxsmUyeAGR8QH8AhGmU9/KilknSNum4U+xn1EwwJmIXD6dYv6Qc+q4DSE4168nH0OSlKsmEliFOw1eBsiyiiSJQZHHtwKLkSyutx/wexni3BQa5wkbq5wL9qxGzlHEQAzkJ2S6HLzsTdQFX7LqmHLh6+YRdOm6k=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2023;6:fQuMWRlELcbitTZ/obONYbRXqhUSjmmYnHBffkhoLAmrJqUqHoULYUS65fPD779HhYgQNgJSactzCy0VVUuJTXWLg7/vl4K/FG373eyMz5uqw+P8Jerr7six+wHqSLwPNE3sywUzzE7H4RhgS532Wi6T1HaHbphEE/kGIhRv6HF3WzpECpBfTt6xdQrJWk48enz8NVWmZvu9ytOjeX24mW3elUOo8GvQmx1Dt6k1ATl4G0nASWjRAY0w/bmVx5wFx9MQAkzFkes4Tk588HwikrEAGw/fJLUIyJJOH7CfnJ6I5B3t59tfPDgxarYKJGa17lQZTgMVvcmVKBFhbvgEAKrP/zEzVav6TnGJjGFO5kIy42aW+28oyASZG+xlyceVDhfqqWZUV7YJGa4frZM3x4R47toztNnUdxtB1hu9mnNrfno8OfG4yl7okbzMJJjMEdEszdc21kddhlf55l4pOA==;5:Ox0Rc2HhAVMJLvVHsWZBYfxDP+rkfTINZRLeQOX2dCRg5LkPh4nWaoKDUMRwJYvQDR+nCdqG0RqJkyT2KCDN9sAbc6sj6GtyQpDaCztD0tIVjQjPTHFwTXntRIJuJk1bSzUeD/IOhbDVcuD7mdKyw2c/uLQpmjXb85N9ZX1cF34=;7:C9m8fkLeqPNaJHJnIvazuNH2FZXEnEoty1NWkvA79B/Os4lhf6uIK6zqzZGE4vcFyz8FUEp4qyFKZVyUpJNcherUIpp0qEDJ/lOke+lGZQRJSGa1GprJdlNSM0N4Et9rvPF5EAieZMxzaskb88ypkl0Ygt4f2Vj4vIFKIKKlyB57XqWx8n3KN8Gu7EQiPfeSKKSJ6qCuMRKKgRa99m9fE5tl+SDTsS/LDV1VtWMpVzxhqiJrKtcgyAZsb3Z8XVVt
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2023;20:W4Hjd1IqPPci4lLIzbe5IVFrN46RNpP3tk/tp0FYm3lF/5SzI/ARIqpeMPMzME49ktvzsYbzJiji5+LXQDUapL0hap60K9UTRPyaaTM/XwaryM2wnUVM4GLQTqruGDZWEl2eV5d1LF/m5CUmGjD3gt4j+bTU1zuiCf35nf+316k=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2018 18:42:38.7665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6044ec-c547-4adf-0217-08d5fa3a1485
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.08.2018 01:51, Andrew Morton wrote:
> On Fri, 03 Aug 2018 18:36:14 +0300 Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> 
>> The patch introduces a special value SHRINKER_REGISTERING to use instead
>> of list_empty() to detect a semi-registered shrinker.
>>
>> This should be clearer for a reader since "list is empty"  is not
>> an intuitive state of a shrinker), and this gives a better assembler
>> code:
>>
>> Before:
>> callq  <idr_find>
>> mov    %rax,%r15
>> test   %rax,%rax
>> je     <shrink_slab_memcg+0x1d5>
>> mov    0x20(%rax),%rax
>> lea    0x20(%r15),%rdx
>> cmp    %rax,%rdx
>> je     <shrink_slab_memcg+0xbd>
>> mov    0x8(%rsp),%edx
>> mov    %r15,%rsi
>> lea    0x10(%rsp),%rdi
>> callq  <do_shrink_slab>
>>
>> After:
>> callq  <idr_find>
>> mov    %rax,%r15
>> lea    -0x1(%rax),%rax
>> cmp    $0xfffffffffffffffd,%rax
>> ja     <shrink_slab_memcg+0x1cd>
>> mov    0x8(%rsp),%edx
>> mov    %r15,%rsi
>> lea    0x10(%rsp),%rdi
>> callq  ffffffff810cefd0 <do_shrink_slab>
>>
>> Also, improve the comment.
> 
> All this isn't terribly nice.  Why can't we avoid installing the
> shrinker into the idr until it is fully initialized?

This is exactly the thing the patch makes. Instead of inserting a shrinker pointer
to idr, it inserts a fake value SHRINKER_REGISTERING there. The patch makes impossible
to dereference a shrinker unless it's completely registered. 

This value is used in shrink_slab_memcg() to differ a registering shrinker from
unregistered shrinker.

shrink_slab_memcg() clears a bit, when it can't find corresponding shrinker.
We do that, because we don't want to iterate all allocated maps and clear the bit
for each of them when shrinker is unregistering.

But we don't want shrinker_slab_memcg() clears a bit of registering shrinker
since it may be already set by a subsystem, which uses the shrinker, and we
don't want to introduce restrictions on subsystems design.
 
> Or extend the down_write(shrinker_rwsem) coverage so it protects the
> entire initialization, instead of only in the prealloc_memcg_shrinker()
> part of that initialization.  This is not as good - it would be better
> to do all the initialization locklessly then just install the fully
> initialized thing under the lock.

Current code (without patch) uses list_empty() as an indicator of
shrinker is completely registered. And it is changed under shrinekr_rwsem
in register_shrinker_prepared(). list_empty() is just like a flag.
Currently there is no a lockless inserts or races. The patch introduces
another indicator. I'm not sure I understand what you mean, please, clarify.

> 
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -170,6 +170,21 @@ static LIST_HEAD(shrinker_list);
>>  static DECLARE_RWSEM(shrinker_rwsem);
>>  
>>  #ifdef CONFIG_MEMCG_KMEM
>> +
>> +/*
>> + * There is a window between prealloc_shrinker()
>> + * and register_shrinker_prepared(). We don't want
>> + * to clear bit of a shrinker in such the state
>> + * in shrink_slab_memcg(), since this will impose
>> + * restrictions on a code registering a shrinker
>> + * (they would have to guarantee, their LRU lists
>> + * are empty till shrinker is completely registered).
>> + * So, we use this value to detect the situation,
>> + * when id is assigned, but shrinker is not completely
>> + * registered yet.
>> + */
> 
> This comment is still quite hard to understand.  Could you please spend
> a little more time over it?
> 
> 

Ok, I'll introduce better one in v2.


Kirill
