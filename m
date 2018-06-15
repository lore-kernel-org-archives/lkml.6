Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AE6C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 22:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E951520864
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 22:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="n+snYxYs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E951520864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756719AbeFOWYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 18:24:10 -0400
Received: from mail-by2nam01on0068.outbound.protection.outlook.com ([104.47.34.68]:5600
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753572AbeFOWYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 18:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O41zo1UhG0/sHeshjIsBdKJPM64w11gd7XuDRnmvRtQ=;
 b=n+snYxYsMhcqHkOOo0vjQGYdW3oil3B23xQMMm0haCvnyOn91iMDNYutkhAi5gwqJK+xt/90yz6KtPBANnqIZVnIlchdZQ17/+okQwaX4YjjFVcMcQ55Uib2XqWTaHgaB1dcsuEE+mIpauSgJdCrfosQo+b8Q+2eBO2LHE6pztQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com; 
Received: from localhost (50.233.148.156) by
 SN6PR07MB4381.namprd07.prod.outlook.com (2603:10b6:805:58::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.15; Fri, 15 Jun 2018 22:24:03 +0000
Date:   Sat, 16 Jun 2018 01:23:46 +0300
From:   Yury Norov <ynorov@caviumnetworks.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com
Subject: Re: [PATCH v2 3/5] bitmap: Add bitmap_alloc(), bitmap_zalloc() and
 bitmap_free()
Message-ID: <20180615222346.GC371@yury-thinkpad>
References: <20180615132017.23889-1-andriy.shevchenko@linux.intel.com>
 <20180615132017.23889-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615132017.23889-4-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: VI1PR08CA0112.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::14) To SN6PR07MB4381.namprd07.prod.outlook.com
 (2603:10b6:805:58::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40ad2a62-e566-4639-df89-08d5d30eb45f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4381;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4381;3:OeR7NFmCq+91RfK8NJBWNtLHj9aPKm+4zfqyXgLrDWUdtRx2F5Dvtjq9CxErFAlzHREPi09j09FY7aErP2vAYHBK+V36s1q8/kyAholEhbNqQoEKFiHfpi2W3ld47/DKJQo4f/EcNyu4cttaWm1pJl8iU1q/H0SVPcUIZYs2P8YBGuZXs753ekyi4E6GxO1B5uNnWtemxWmU9hGL/KAao+oKECTSDipuy/0LhWy7w7fcE/91V8R44ULAF7ekqS/Q;25:ejduiVbTDIURt3Y8BIGShXq0q/46gPtiH6kIEg2v5Bj6EzI3nHWQEWZAikYy16i+y6PBG/+JjBxNJb7jBv1m38muBYUIOk8ou81kWZd0LiUnK2BqgiDlLTXlPYV/XnsTyFyc0RbcM+1vTucoDY9bvVaKQ4huYJAanDPBZPSC3IUwEmNp+27iYj3FxI5e7QFOp/g8ZRiEgEfk63KeeI57TQVzgVSj7Ajh/Ymcj+34AbKAudJYmOZtkyCAzOGrWI1CSzyXSb2mtg07K1zS2sY5Ec10CS8mY2N5nJLgqRmQw9Kd8+dINHbG2dZgY411bRryEW1XfurlLnSCR92o1mu1Kg==;31:fhuUBh7Pv5Xiq9xHp1xh44dcuDkp+HWba4OLYxBblyQmS6DKdASbrLYzorINYYpPdpdd2JU2l7JubN3lUPAz/TxfJc2yhvMtf7+2Vuut6rXdKDjykwiLKIUnr8cET1/LMqRdRVt3ZpCNbySpAdJVd55LAyn0I6JHu6tWnfC4PfKaG30x1iBHbztueJGoHjMdL2EbgmoQkWYafQGFRs2hN2SGtf+3RGWoxTi+cphYBbQ=
X-MS-TrafficTypeDiagnostic: SN6PR07MB4381:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4381;20:sif7CWWAwnYyGHSed1Xkyv5SpFWd6Tk8UJ/ztINvNd+QDCek0CgklEVbgd+6iCbAkyy6NUpD7dv4lqJaE715U3/zhB/dHaQwnvNFLdQ1MBI5v0vyrpeAsxBrHyNaLt7WSYD/MCoR3jcTGZGxijU1A1YJwZBQBzV3dJUCV/76Olx9JVAl4CHM1iON6mryN7nY7V+baVCg2Ou95xyzFvDe7Lu8l2Az5E0zAp+MaFWQ87vNW/eK3udTf/tCclqIPjrgsg8HgvUlJksz47yY3X52GiwCwjIuoCUqQbMvZNUVdzXZvwRo/BEAiJhDSpQlTfclGVfDmq0/ScV7ZgkJ3mP7Ye5713fjOj8SmD8u5ph0nrPaLl1c48Dc5ep/0vj9zNeBhuMidmRoUl5Xqs+Mk/Y+wHv83UfDEOTqmeRMYNMgJtnjb3wzjLT1CR1JIH7EpcQQfrZsHrXqM/ksmBrqhFQDLySijIv6T36wqrIh38r2wA9R/qhJ5kuG5bsplU76kyQp0PJZ7WKwVDyz3EjPQJwVOu+wiJpam7nmORIOQSB7m7YGLeyU5ylXNc5Iq25GMKn14nSONMRlhgWR+jXehdJIRYflymUuvlh6XgD6WJRVJ2k=;4:KEyMq7rGWlmFRXLH/le3CS88Mhylt657/ZuZmHNUiPdiOINXe1X9MLKsqG1h1e1eRfesyRF2WoUqGF3dZyea1YTw0OQm1OzgFKkx8p7/gvJncY4kzcb/hXbcHIKeuD2ET6/iLG7YjjxOy/sbkjHwseWsBJ+uiURUylBvLEvfAmzKQcaWJA2997XFurlWBsnc9X75L6joBRaPwzryPxEdZD2lF/GstRb1X5tFYvyuRzLP/GIH3A0Ip3pMwVEpQFUlmA9/a9rSeAs5oyqYULUQTXEN+POcxYcuWaWFp6CKKvgEZbEntLsV6FnWe6cTxTGH
X-Microsoft-Antispam-PRVS: <SN6PR07MB4381E51007F4D0E94200737FE37C0@SN6PR07MB4381.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN6PR07MB4381;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4381;
X-Forefront-PRVS: 0704670F76
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(7916004)(39380400002)(39850400004)(396003)(376002)(366004)(346002)(189003)(199004)(386003)(476003)(33716001)(16526019)(6496006)(97736004)(33896004)(68736007)(76176011)(2906002)(6486002)(52116002)(446003)(186003)(1076002)(23726003)(50466002)(26005)(486006)(7416002)(11346002)(956004)(229853002)(105586002)(33656002)(81166006)(6666003)(9686003)(6916009)(72206003)(305945005)(6116002)(58126008)(81156014)(42882007)(316002)(25786009)(39060400002)(478600001)(53936002)(4326008)(8936002)(54906003)(16586007)(8676002)(66066001)(106356001)(3846002)(47776003)(76506005)(5660300001)(6246003)(7736002)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4381;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB4381;23:niRS5jdSMEazfqp3ifzbNneF8zbJBMTdQp7l8Yu4B?=
 =?us-ascii?Q?g7hgoisy1C7PkXKNdXxKOqvoaPL1OZX+DCi2fxnaduL8b28fPLRaYnVgyjDt?=
 =?us-ascii?Q?haRunAszVghjFBZeOxyv0fI7P/tHqC8razYLZO3PsKDdYmRLuDB3NKOe9JAT?=
 =?us-ascii?Q?xSPBJ7M3xI8D4kHnygM+7iG3qnw6GCoX/nQBUNM4r1K0x8L63xDTCA/k/N++?=
 =?us-ascii?Q?5ltcj33rHGwnd7tMugplDRbNHZlokzL7BYYXJf7R8i/DR++KTEvMX1yz2lfD?=
 =?us-ascii?Q?s2Dbr7K+4D15vwuGL4+psHDnep1T3CbOEohZRj7yYmWeVUswwFQJ2y9cjG+g?=
 =?us-ascii?Q?G662BWxHwX57eyf+hXceJNEmcJ2WEQtOv1KBXCNrBEKLNBJnciFdLZFhagB9?=
 =?us-ascii?Q?4FPuNn0g8a0p2SWIaA+VSdi9wUXLRek7xHjgkrSU8wQTVNDc+3MSoVU9ksOR?=
 =?us-ascii?Q?MWsIYDrFbv0oSfec9w+eU/IH3D4z8K1zVk6veZ55HaHOf65I2Rnbc1joh2Sj?=
 =?us-ascii?Q?99ibHbgG7W86WL2rzwSjQTzKoalVgX5d9+wDURO2NaOuXw6zEniJi/Mk0o5w?=
 =?us-ascii?Q?roRkh0zoZwZFoUjJ453Onos02QhELt3TbnRbT+pMdwUQnexgRlC0k7KUGU+a?=
 =?us-ascii?Q?tdu217yrYvewPP4/UXImvZ7PuEhNw/yijhjTF7NUgIqMzXrrTtK9mJw0riKe?=
 =?us-ascii?Q?kivrJRxk8tWmsz0jjT1TT/RQfBfRjuG3LmwSNCtAyh95IcMewwzWuocgChK0?=
 =?us-ascii?Q?HjPKDShXibUkVCtbZr3LtBB7lDA+krruiu4tCIZ/3QpegNRaRL1R8T0cI6DY?=
 =?us-ascii?Q?0b9dFv7vAd9sWMbBPGZVtPM6mrKMFJXN4kpFbjdbdR1kKBzS1mxiR+oJ2xKt?=
 =?us-ascii?Q?mfGbiJWyeLsoTrS0Q35bHN0GbTjm7gSOnfDtT2yhjTRCvTmtiNGPHn7SUB0w?=
 =?us-ascii?Q?tVL59NhmgHLmYbVCchln3aQsJxoeAgwvQ1xZE2w+o3d0QtneA5Tfh5hKKJYa?=
 =?us-ascii?Q?xxp6hlFgRgkHX0pJrlmsKitHaRMVvjIv0tXFkJwaSCoX3GZr//YbJ2EVRH1W?=
 =?us-ascii?Q?JrhxNte7UXKvX9HzKTuLjR/85O+A6E1ifoThDW0jEMXa/uPMcNcqPRy4h8/n?=
 =?us-ascii?Q?heUHla/j/ONtklFd0RPK2PHkt5yPEg4yeBPck0gsZ20bn+wpxwXOg0LmHA36?=
 =?us-ascii?Q?zDQk/H/XBH7phxFO4w6qS1c6RUZL0CWiAvvEZdKefkLOFblZRLpDgIxqrtnL?=
 =?us-ascii?Q?PjgDx4pmYuziYRthfu4pJyd0Sxsou4Lv/GhqoPiVz5OLHayzZ5s3s6wCnax6?=
 =?us-ascii?Q?x9bjq1/ZLhvQtlYkkum/j0HcWcJGQPnkutCwNQQc0ssljCMx5y0LY7ngVEMi?=
 =?us-ascii?Q?4uwIEuBjnuxePfTatqe6bXA0kEsHQwb6Z+3M5duSWzjKw4bZPgzCVF/kEvJb?=
 =?us-ascii?Q?/Zet8gbAg=3D=3D?=
X-Microsoft-Antispam-Message-Info: vR4t9GR66DsO4sz2ZG/ytt3oMsF0HaH62ZbMgCnxWLfAjUL6cMOdzjEl7hsHWeczOVxFbIyA3oAh3V9mjFSt7FnrSAZkBNQsMWNRMCIAdQSavKOfSKGab6ki7YjJfTfUXgfzoAR2vircRMJiwB8tfYLWpn1fdD8YhV1OforM5IqxiwItr1U4xBK9sAm9patH
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4381;6:IJCA/7Z09xP6hotDeCfsqY3i/OktF/j3X0Yi19yORA0VaMRvXVwHVe8Orz6WWibrLz0D9ozOFV3/1EKeauVUiSSLe4WnvS8AcznSt3eVWUflt46ocdDGz3kSwAeuNaaSKytt8qlghIiYH3agpbUfDKPqtsV0dWoxl++/p9tn5ln7Kpt5W3Bfu7AvK7s+OH9pGGVWkeZr7SGssHUObFIkG/JwsidsDvSjhNwsm3regt32gVoUvNmOB1DSH4SzVX/DKL7URxj8ffINaMP2+S0UjPB288S9L/e+C6jiB+XUFqokSBcjhUwhfbzyUp9sj49fajoo3IISI/0KTpPI5KFTJP9UsCsEkY0wneIKdKicsQSQsdgDpEB3fWmEYC4S8hLfwce+SYyAiMq80Xxvw/58VxSIcGNh6XHvhiq0a3phupdCsU19g3yMjhX/HIkFKtQ+UUpbXrdYx86QucbcHoQ4QQ==;5:ZFdu2gVSrofNeTV23e6LES356/sxRV8Jv+EumJDl99jzXOLUdqtiIpfSQSzfU8AipMUQ/5UVD5CaB7ZPRwHdxjNTaWhSxLBvj5dGK6tITIt9cNjCUWqt5c1uR3JQzwJA02f4YZuVqxg9767yIRurI43DCZCggT+gOiiMFZcmyBQ=;24:oOf2UKht3iCAPqdnALMouZAi84XM/DJNXaTGbVJgyeuKfgizJGhwiIS8Zcn8KYa7FIqhHGZCO6MbrGDdZMIy8NpGJL3J8OmJkGXJgVh5BA0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4381;7:8d+/YeCtSQRzpeMLQhy1+pMp/vXZLbk9TK3YkE5uWZ9bbD5bVjpFOFUYQro/nOy4WinNubqivd3M/d7+Nn9eYqTef69IDZmBbZiDX5jzPgbUC3mOteq8/t2kQ640ft78vaYJVYyt0d8M/IWhZa0qk5BBvGcbMMaFq5fvLMQxznJvn2tDIz0W38S14RvyY9oIjGC/6dgHCIoJr2rl4satVGGmKVCX8+L1AgJSWKHH33EwTg7rfHl8VPEgke/eiqV8
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2018 22:24:03.7888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ad2a62-e566-4639-df89-08d5d30eb45f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4381
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Fri, Jun 15, 2018 at 04:20:15PM +0300, Andy Shevchenko wrote:
> A lot of code become ugly because of open coding allocations for bitmaps.
> 
> Introduce three helpers to allow users be more clear of intention
> and keep their code neat.

I like the idea. But in following patches you switch to new API only
couple of drivers. I think, it worth to switch more, especially core
users to make new API visible for developers. Brief grepping for
candidates showse only 17 suspected places:
yury:linux$ git grep BITS_TO_LONGS | grep alloc | grep -v drivers | grep -v arch
kernel/events/uprobes.c:1188:	area->bitmap = kzalloc(BITS_TO_LONGS(UINSNS_PER_PAGE) * sizeof(long), GFP_KERNEL);
kernel/sysctl.c:3004:		tmp_bitmap = kzalloc(BITS_TO_LONGS(bitmap_len) * sizeof(unsigned long),
lib/genalloc.c:188:				BITS_TO_LONGS(nbits) * sizeof(long);
lib/test_printf.c:378:	unsigned long *bits = kcalloc(BITS_TO_LONGS(nbits), sizeof(long), GFP_KERNEL);
mm/percpu.c:1109:	chunk->alloc_map = memblock_virt_alloc(BITS_TO_LONGS(region_bits) *
mm/percpu.c:1111:	chunk->bound_map = memblock_virt_alloc(BITS_TO_LONGS(region_bits + 1) *
mm/percpu.c:1170:	chunk->alloc_map = pcpu_mem_zalloc(BITS_TO_LONGS(region_bits) *
mm/percpu.c:1175:	chunk->bound_map = pcpu_mem_zalloc(BITS_TO_LONGS(region_bits + 1) *
mm/slub.c:3668:	unsigned long *map = kzalloc(BITS_TO_LONGS(page->objects) *
mm/slub.c:4435:	unsigned long *map = kmalloc(BITS_TO_LONGS(oo_objects(s->max)) *
mm/slub.c:4596:	unsigned long *map = kmalloc(BITS_TO_LONGS(oo_objects(s->max)) *
mm/swapfile.c:3219:		frontswap_map = kvzalloc(BITS_TO_LONGS(maxpages) * sizeof(long),
net/bridge/br_if.c:328:	inuse = kcalloc(BITS_TO_LONGS(BR_MAX_PORTS), sizeof(unsigned long),
net/bridge/br_vlan.c:836:	changed = kcalloc(BITS_TO_LONGS(BR_MAX_PORTS), sizeof(unsigned long),
net/mac80211/mesh_plink.c:465:	aid_map = kcalloc(BITS_TO_LONGS(IEEE80211_MAX_AID + 1),
net/sched/cls_u32.c:737:	unsigned long *bitmap = kzalloc(BITS_TO_LONGS(NR_U32_NODE) * sizeof(unsigned long),
tools/include/linux/bitmap.h:105:	return calloc(1, BITS_TO_LONGS(nbits) * sizeof(unsigned long));

Yury

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/bitmap.h |  8 ++++++++
>  lib/bitmap.c           | 19 +++++++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 1ee46f492267..acf5e8df3504 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -104,6 +104,14 @@
>   * contain all bit positions from 0 to 'bits' - 1.
>   */
> 
> +/*
> + * Allocation and deallocation of bitmap.
> + * Provided in lib/bitmap.c to avoid circular dependency.
> + */
> +extern unsigned long *bitmap_alloc(unsigned int nbits, gfp_t flags);
> +extern unsigned long *bitmap_zalloc(unsigned int nbits, gfp_t flags);
> +extern void bitmap_free(const unsigned long *bitmap);
> +
>  /*
>   * lib/bitmap.c provides these functions:
>   */
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index 33e95cd359a2..09acf2fd6a35 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -13,6 +13,7 @@
>  #include <linux/bitops.h>
>  #include <linux/bug.h>
>  #include <linux/kernel.h>
> +#include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/uaccess.h>
> 
> @@ -1125,6 +1126,24 @@ void bitmap_copy_le(unsigned long *dst, const unsigned long *src, unsigned int n
>  EXPORT_SYMBOL(bitmap_copy_le);
>  #endif
> 
> +unsigned long *bitmap_alloc(unsigned int nbits, gfp_t flags)
> +{
> +       return kmalloc_array(BITS_TO_LONGS(nbits), sizeof(unsigned long), flags);
> +}
> +EXPORT_SYMBOL(bitmap_alloc);
> +
> +unsigned long *bitmap_zalloc(unsigned int nbits, gfp_t flags)
> +{
> +       return bitmap_alloc(nbits, flags | __GFP_ZERO);
> +}
> +EXPORT_SYMBOL(bitmap_zalloc);
> +
> +void bitmap_free(const unsigned long *bitmap)
> +{
> +       kfree(bitmap);
> +}
> +EXPORT_SYMBOL(bitmap_free);
> +
>  #if BITS_PER_LONG == 64
>  /**
>   * bitmap_from_arr32 - copy the contents of u32 array of bits to bitmap
> --
> 2.17.1
