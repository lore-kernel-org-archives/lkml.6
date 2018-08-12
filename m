Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AA2C46464
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 06:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D48D21A13
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 06:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Fy0dDe8W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D48D21A13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbeHLJYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 05:24:08 -0400
Received: from mail-ve1eur01on0127.outbound.protection.outlook.com ([104.47.1.127]:63842
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726773AbeHLJYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 05:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYoD9uHiiMEkr2xrfkk8LsLf93SSCgTzK24kR7iSMek=;
 b=Fy0dDe8W4LK0XGIOlxdfo/+NPay+mTqc1Cll/avF7azPWzUq7vici8mRD1UoP8PIC6SJFWcgIgE6vCK4eRhMevuxE35sToGjj+vnmQlVHioWK3WfeGpDe9yNxnu3bt72oQbdSy5q2ZXLV2uEax0/r3hJgvEeQJ79gvpfiFiUHvY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vvs@virtuozzo.com; 
Received: from [172.16.24.21] (185.231.240.5) by
 AM6PR08MB3639.eurprd08.prod.outlook.com (2603:10a6:20b:4c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.18; Sun, 12 Aug 2018 06:47:04 +0000
Subject: Re: [RFC/RFT, net-next, 00/17] net: Convert neighbor tables to
 per-namespace
To:     dsahern@kernel.org, netdev@vger.kernel.org
Cc:     nikita.leshchenko@oracle.com, roopa@cumulusnetworks.com,
        stephen@networkplumber.org, idosch@mellanox.com, jiri@mellanox.com,
        saeedm@mellanox.com, alex.aring@gmail.com,
        linux-wpan@vger.kernel.org, netfilter-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Ahern <dsahern@gmail.com>
References: <20180717120651.15748-1-dsahern@kernel.org>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <dc9cd93c-61d4-dc8c-9ba1-cd8584908ba2@virtuozzo.com>
Date:   Sun, 12 Aug 2018 09:46:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180717120651.15748-1-dsahern@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM4PR0101CA0051.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::19) To AM6PR08MB3639.eurprd08.prod.outlook.com
 (2603:10a6:20b:4c::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58309312-6abe-4b06-7857-08d6001f6a62
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3639;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3639;3:+5Ucjgab90eOB0OadkAAhnO12cVbmf2ubrPsWtT6alXKdl3FGGlqLQsPZ5OYrpZaBY5PaTofDyOkzEVOkzJnCzXaH0IKhYEfoImZBgPeKQgfn80GJykmaTXqbM5h3gua15F9HjHB9iDg/pMGp0e2JI/JQZPE6sqwWyrDMtiuvqBlYdq5X/u91cfGKuTsmKDfo6fKGpUKE0YPhGociYbRmVmhOjQOyLWzxWchqseRtASLb4dyH1y4rmC04ClNqGMv;25:e+lUNadjDHUFoq7Uy/+jP4pVRwVF9fuN3iJswIkQPGdfKfNVkQtpjSoP82pQDOdA2x2wYDHfEuJBDnZ/gGLdippSE5UMJ5VSyd/rQB7Rm/+j49RGjsNQKbL655SJdEaxkocAJKE1OdkG858PnjVl9Zx79lm9xLJMzwN2ROvOm0X94XAZpjBSJRCxdiGXY8i7rRVvz3UB2SrCM1Ua3RTo3EBia3/GTQtchwj5EPWYTWeYb0Grgf1on4S91eJ0iMv6ae/4ry4xUTN+JO0VTmW/gtXflPh2Uf92UuAoiYnSgY+iNA0U7Tp9u0CiKlsWcfEYRO+eqTdq6+eCWV+3Nwi9tA==;31:5CPfRhmd2q92FQl6BJQglHaNp4LmHtyujzEmk20drt59Zg6pHczcKwf0rZ0tkpUr/iItuOPAtyHk6LKNyDLcDr1jFkJPSCFF5UZb0+rkIfNFRXofMQjQnojEbz1RYdkrUHf7lIgnByVEcjhzt81jX+74SNYRuxrNkXCe9rJ341MiUDNXtW7d9PJ2QAhfLvtXsNDTKcNpTUgKNlDTj9EPGSXu9X9ZlUXqvWgkxwlrNNA=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3639:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3639;20:N1WTGeiFO6tXsaU3SOU/kytPieMez17w++pNKWohe/+tR0uenrWl4hHFErqF4yKmIowXBQzcrHyA/N6vigfLyNa8m/BArdNdOgVUX6vTL5QDC0ss+uTQNUf8yZm4DBk049VZCHFX1ZsJlv+WxMRDSMvvVYAvZmMw9+UCiSRQxLzR/gg1xn6GYUmjR3lmRL4QRG9bnidf2yD7ZvEd0gS6r3pxpPWp0nWiWibuxATcSyaSrYKAMX5UzwQNNpUoOWv8J8PVFhHgbQ+X2XdtTw9MladXrto90+WZTPN9O+H8dQ9yEuP9tG+oALWjyQVyTpuDVo9C+b/AtnASg1+DhkrXl1ZeBq3g6wYI1C9s5m4OLh2pyqYUwu6m7E+Lsyo0TP7ud3DifiVnGWnYH/vvPf3WyG90/Xnusf+0hKr7yHiPzV6/XXZPxcDsTU69oBG9H+qJybRMO/7lEcqz8nHauF4ObFTPYXW4Zc7Zzh1Or6hv/hHC6mKql6ceIYVJp/Z6Y4F5;4:cmxJuVz5iiaIc2ndk7kw6pQuIUm4KwL+jEua0IX6D5dXrjgvD/RQUwvHYIznQFwlz5KMvjgn+aqSktjSHBEUHqr1wSahgvT3x9Cb9LVtwkzwEhuZFJpxglLWlMQ1VlE6SltDurTRDTBlvDI/yBv/RMDhKs6s9uZYNk75XKzan/rbkidMKQ8BIpZyF+bMhOX7XfPu3lxpyX2Yk9BXxPQKtHh27rFGc9Esj4p15lJK0e4sDUYppwQcG9n6SwtJ+Cr6UyjlrBvr7ymmD9wN/3D0iwS1MQ3f+jYnen0ssLUML4H7Y2Td+F2P/IaASajoUDY7dKCTx42vIsuIACmeuz5EuAXLmoh3TumeLJV7NhCLATk=
X-Microsoft-Antispam-PRVS: <AM6PR08MB3639E6A84C4CEBF89A4EB38EAA3A0@AM6PR08MB3639.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM6PR08MB3639;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3639;
X-Forefront-PRVS: 0762FFD075
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(39840400004)(366004)(396003)(376002)(136003)(199004)(189003)(8936002)(81166006)(81156014)(8676002)(478600001)(97736004)(7416002)(50466002)(106356001)(2616005)(229853002)(956004)(105586002)(64126003)(86362001)(476003)(6486002)(486006)(31696002)(2906002)(14444005)(31686004)(68736007)(11346002)(446003)(186003)(6666003)(16526019)(58126008)(4326008)(53546011)(6246003)(53936002)(65956001)(316002)(65806001)(386003)(16576012)(66066001)(6116002)(47776003)(23676004)(3846002)(36756003)(65826007)(5660300001)(305945005)(7736002)(26005)(39060400002)(52116002)(2486003)(76176011)(230700001)(77096007)(52146003)(25786009)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3639;H:[172.16.24.21];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA4TUIzNjM5OzIzOkdFUWZTT3ZVVk1LbGdkQkw5ekVvM1lqYmRm?=
 =?utf-8?B?anVDVkx6WmtwZW9YemNmNk5jdms0dHRiQUNoYnIwcEdldFlSZEd4dzBMZU9D?=
 =?utf-8?B?L0Q3WktrUFVubkFDemFPN3BKWjdqcG1hcmxsbUVaRXJ5Z1Q3Z3NxelBuSUY1?=
 =?utf-8?B?dzkxWU1BVUxxcjUyQ0kzODZLUkxVdVJhM2FxdHRJOFRxckxKNWFnbXRCNnYz?=
 =?utf-8?B?cS9RVTJVQ21MMVZKZlRPUnVIZFF0SDhpUWpKRmFxaTU4S3JIOEpLNUFuZjB2?=
 =?utf-8?B?WTFHeTZVMFdhSzZpQXVSNVBoMkZQVUd5NGZZR2lvb0NFa3MxcHJNYVBrQ0lu?=
 =?utf-8?B?QzNwdkZmWnZMb0lud1JQc2VucG9GdW1uNUJDODFmdlFTWDg3R25OZVhMU25j?=
 =?utf-8?B?a3ZzRmhhMlNUdlpROStaTUFjTDdPSmlxNWt1ZmVybnJNQTcvZWVNNXhORTJC?=
 =?utf-8?B?RE02a0l1eERLRGh0cnpKM3B2bWtzckxiZTFDOE9ScUxjMVdXZHgyVFZHVVZU?=
 =?utf-8?B?azFQR2Ftd093SFJtUWpqZDJ6MWdvamp4ZG5kN2d3cTN0ZjVCR1hLWkcva0p2?=
 =?utf-8?B?UElYbU1NSzBobmxONkJZQkovRWJ0Uk04b0NjSDZ1QWQ0TDdZR1Y1bVYybHA5?=
 =?utf-8?B?SDVVWmNHcnc2aDFLZ0hNSHE3Q3VrMjE2dWx2WmdKQlNxWTlZQ21mbU1QSUdR?=
 =?utf-8?B?enpENStUUkZLUU1KR00rVUNhMEJaUjgvNGFMK0Q3dkNOcmJzTjZ4SWd6c2l1?=
 =?utf-8?B?d256NUt6bzFBK2g2T2I5cUtaQ1RYZzI5U20yM3RDK3p3RkZ1MHg0cE5lSGFp?=
 =?utf-8?B?K0NpNlVNRjZnQ0JlQnc3RXVCTWRPVGdJQWtoQmNyS2Vxckh6UERFQXk3NEkw?=
 =?utf-8?B?eUJVbFdXWnNDTzhhT3FyRFhUa1dXeUROTlV0bHV1UE9Sa0Q1a2wydHNyS0tV?=
 =?utf-8?B?UHVLalR2R2poNndTL05FUDZORFRrWFA0dVVLRGhSam8vcktRTlFrakpqaTE1?=
 =?utf-8?B?K2Y2aGJWeng1UG1xUnRDWDFwUHB5TGJXY3A3akxKaDVNVFMxMnZjb2Y4S3E5?=
 =?utf-8?B?NEgzb05sMWcxSFBxcWR0bXg4RmNYQ05UZVh4TlZQYlU2UEtRaTF5aGhPMlNG?=
 =?utf-8?B?NmF6TnhZdS84aFlLaUQyU1NLck9HMFkvekNUZTRaNytwQjNRSE90MmRhNHQr?=
 =?utf-8?B?Y1ZIbnA0SkpqWVJJcVBPVS9YMkNRYTlvVXV2MCtuaXZPUk9sU0d3SkJiZW50?=
 =?utf-8?B?ZUNUZitJZk9VSmErMHRIWXJhZmJ0eWxudFdqd1RXbHpSKzB3UkcybWtKS2hL?=
 =?utf-8?B?TnVkNW9LRk9xQ3VaZ1RLeEFld095aXZXUGJiK1hYMFhrVjdYMjBWWHk5RWZv?=
 =?utf-8?B?VjdjOUxxOVhENFR3K1NQWkZCQmRGT0VFRDhpVGRDbWVpNjdITjVSaXJWYXFu?=
 =?utf-8?B?anlJU2hOWmxML0dwclJ3alpPOHJBWDd5TkxzZjhNWm1lL0dzaVlUdU5hL1k3?=
 =?utf-8?B?eE9ydzNCWkR5WDRvRkQvVFdVMzlDN1ZaVGxDcU5wQ1pFRlVVZ0NzTXBkWG9C?=
 =?utf-8?B?OWtXVE9XbU9VSVU5R0ZHQ0l4c2I2RkhOd2ZTSTJXMlJPMXh3ZjlYRk9oL1Z1?=
 =?utf-8?B?OWd3MmVBVDZ4dlluZkVrZ0FNampORm5ZcEJXY1pxZDg2OW4yeGlrMGVVcGRq?=
 =?utf-8?B?Zkk0UlNRWU5BQ0ZhSXdydVk3MGNsS2lGN3JWYzI1QWl2UWZiNnhTZ1FMU3E3?=
 =?utf-8?B?Si9HNkdmdGZianYxL09sd2o3S25DQkVKVHlzcm5sRlFPSVp1SFFMSk91TFZT?=
 =?utf-8?B?QW1ONDc3WUgrOGNsaS9LUDBQcDNjUVMwN0JUTlVNOWFYSDZnZm9paHQ0UDB0?=
 =?utf-8?B?QkNMV0o3aHN2cWhqUTZDNXRQaEVpa3BoQytxclFJdHBhbEYwbTFBakY1VC9K?=
 =?utf-8?B?VVErVm5KL2J6U2tQcCtLL09wYTNGdm5STis3Z05kNkJoeWpEQWVtWWsxdC90?=
 =?utf-8?Q?/BT9pn?=
X-Microsoft-Antispam-Message-Info: RKYb87NUOQAw9czguPhBWXHJCreQNVoAN7l3b5eGpBRV7aD/6KVx0uSXgBGpjE/As2nKKr+ZTbgVRWbfiiW+yUfH/947iVSR0hJ8jCql1jfG/zerx6NXvQ5WOqiiiPDhQAyD3QzKkPj8/Nc0+RBoYWj0BDLTT++8jGnGxQn98mUlHNSKIDhx16yxsz9wnKVSre1D3JRenzVifdQmzzY1hmtSctmI8/nDg8OcqvuM5bo62+zvegozsI3bImxeQwPifjMexsc95c69aiXeN27KGpVBZbLUcBaF0V/p/oZwfHTpxbeDgM6O6lDvdfgJQQ3uY2PPt3gd22+vabMl591LYuhDDxhcGxQzzQChXr7r9uE=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3639;6:fIMlhEqIRzMUcSAuynfntGZy9i27IVrVaqN6lR++bPSyrK+bz11j9msos9wI+OmNcCVwNn4vwl3PMS6fqyAq9arsJSnnlNZsc8JtYgS3jJsJEowxRNADtiYG5gg6ZdGsRsfl7hXqBb6OGy+nEqaGBS3aQMJXA8mBUay472Bt8KYiEv5Ye4Yt5XzrhmX90awOUXBHSx7zF0gqRReqYf/5al4ElfRGi+4IE/lSIZ3QOMmhIfnbp4ghXwRCwydE1YbvFFJ2fqsEN3yGsN4tUMAtPLf/VZYii2cFvhZqoVku4aLuJODHMuwqmEJ8uzSw0TQQ2Q8zSNdBhp3+QdAqdmorAkgvhinisbpK99xhzrVgL4ed23GjtpR3TG+ymxc4LduKR61Y6Zx5tF/21fv4PrcueXu41jlHqnO7kk4mT3aC9kbM9uWn2avQ1dlmALUBBfGGDBjLWiCJICqnXsRWVXrO+A==;5:6wdys2F8py2Cz2jdZ0S0e1mSgQVsmsO6Y/y99Ip2fdt7LxHPPwdrhSj8lVkPtevgs0iK4hYhCJr/ozj2M6letg71TJ/6cqB/AeBkrM/VfcIwp4HHn+Vg8Tk/RjZvcmXzGEkGg+JsTxLFmZxaOFCjRonC0CXBoey4m/cYahrYFrk=;7:ZUFUkGyfwIexYV/KqrQ1yIK8XNadU8nbgHvxBFoXtDmJedeOlorqzxfW0LNtS+bEoNvCbYcqFBtKlhDVR7yWwVNlOrq489eJ6haDfPKy7fywjcOm67uWHii/07KNQjvpYaoHpeUnbM+EEYQWzxqyp2q7NBx2FhcYf3nFKq925sqUf7wPu7NLuS3Dhu19faLbJgkgXsKmjQWdhvWEIlqcfqL/nr2GelcyywihZwn5Eab1Dd5YbQKPH84ijueKWamQ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3639;20:W0CW36E/lGLRQd6BfN8lEt2msqdN0TKuk5DXCB6Xqdi8VsrdRfD8vRutRTK909A2Bip9sDq87F4FbYFO+L/xeVmzL+v5UCi/gxWUIou9wuPdgAANbtOB8OPhU+8z5s+/KEQYZBO+ONddkgWvhQQ7kRHW7zjvlorsvgk7/mQEKss=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2018 06:47:04.0422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58309312-6abe-4b06-7857-08d6001f6a62
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3639
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/17/2018 03:06 PM, dsahern@kernel.org wrote:
> From: David Ahern <dsahern@gmail.com>
> 
> Nikita Leshenko reported that neighbor entries in one namespace can
> evict neighbor entries in another. The problem is that the neighbor
> tables have entries across all namespaces without separate accounting
> and with global limits on when to scan for entries to evict.
> 
> Resolve by making the neighbor tables for ipv4, ipv6 and decnet per
> namespace and making the accounting and threshold limits per namespace.

Dear David,
I prepared own patch set to fix this problem and found your one.
It looks perfect for me, and I hope David Miller will merge it soon,
however I have found a few drawbacks:

1) I know that if net_device exist it always have correct net reference,
so dev_net(dev) will be always correct.
However I afraid that device reference itself is correct in some places.
For example, 
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
@@ -376,9 +377,10 @@ mlxsw_sp_span_entry_gretap4_parms(const struct net_device *to_dev,
 		return mlxsw_sp_span_entry_unoffloadable(sparmsp);
 
 	l3edev = mlxsw_sp_span_gretap4_route(to_dev, &saddr.addr4, &gw.addr4);
+	tbl = ipv4_neigh_table(dev_net(l3edev));
 	return mlxsw_sp_span_entry_tunnel_parms_common(l3edev, saddr, daddr, gw,
 						       tparm.iph.ttl,
-						       &arp_tbl, sparmsp);
+						       tbl, sparmsp);
 }
 
mlxsw_sp_span_entry_tunnel_parms_common() have "if (!edev)" check inside,
so it seems l3edev can be set to NULL here and lead to crash inside dev_net(l3edev).
There are few other suspicious places and I think they should be carefully re-checked.

2) modified arp_net_init() does not check return value neigh_sysctl_register() and lacks correct rollback.
It was acceptable in arp_init, because it was called only once on boot, but now it will be called 
for each new net namespace, it can have real chances to fail lead to memory crash/memory corruption.

3) modified neigh_table_init() is called many times per netns but it can panic in case failed memory allocation.
I think it should be reworked to return errors in such cases, its callers should check it and add correct rollbacks.

4) currently neigh_table_clear() always return 0, I think it makes sense to change it to return void.

Thank you,
	Vasily Averin 
