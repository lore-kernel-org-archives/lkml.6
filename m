Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FFDC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876A0217BF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FXqBnciJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 876A0217BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390024AbeHGRww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:52:52 -0400
Received: from mail-ve1eur01on0103.outbound.protection.outlook.com ([104.47.1.103]:21464
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388677AbeHGRww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOgHna0IjgNaMkcfTG3lH2LiLelmPRrnFUp70X32rg8=;
 b=FXqBnciJoI192137vBDlbX128rGMK68+IF9JW+o8GdPomPVZmQiUbXOkEvJAyoJrF2CfUMxrcdGiHA5r0u+R8WCNiOzr8rOwfNwDbjEYbXwa4h0G4HljOIBO5iNdMUzOctjgnGpQj+PedxzeR2xcuPwMb/rvrE+NhEqer9iTAKc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 HE1PR0801MB2026.eurprd08.prod.outlook.com (2603:10a6:3:50::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Tue, 7 Aug 2018 15:37:50 +0000
Subject: [PATCH RFC 02/10] mm: Make shrink_slab() lockless
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, viro@zeniv.linux.org.uk,
        darrick.wong@oracle.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        hughd@google.com, shuah@kernel.org, robh@kernel.org,
        ulf.hansson@linaro.org, aspriel@gmail.com,
        vivek.gautam@codeaurora.org, robin.murphy@arm.com, joe@perches.com,
        heikki.krogerus@linux.intel.com, ktkhai@virtuozzo.com,
        sfr@canb.auug.org.au, vdavydov.dev@gmail.com, mhocko@suse.com,
        chris@chris-wilson.co.uk, penguin-kernel@I-love.SAKURA.ne.jp,
        aryabinin@virtuozzo.com, willy@infradead.org, ying.huang@intel.com,
        shakeelb@google.com, jbacik@fb.com, mingo@kernel.org,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Date:   Tue, 07 Aug 2018 18:37:46 +0300
Message-ID: <153365626605.19074.16202958374930777592.stgit@localhost.localdomain>
In-Reply-To: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
References: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: LO2P265CA0164.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::32) To HE1PR0801MB2026.eurprd08.prod.outlook.com
 (2603:10a6:3:50::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 679832a7-3215-43b5-fe22-08d5fc7bbeaa
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB2026;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;3:SGApD3x/zPMVBpLYc2HjeYF1T9qt1J58SZ83TLV2FOa8bED4wE9QuUuwL6ZY3g5bH8hq0eOt+t0p/lGIndvxYiYXs+0pSbYrcQIem18kuqpVgo6TKrz8ai6LS5GNAGLGIDsJcv9o6E78c2BgxM5szuestHVE3vXV0sHyfpLzq206Ft8LG+Sk4kQpxQlmQX4EvdyxcMs/wq3NUT7P/yYqcHOL1iNr75eGuyug0wgp5rrIvpsrCdpFQa7DDVvoZXLx;25:DTMTrlSl/4trqRgA6h0vG75bXkH5Nt4Gga5sB1mGeH/slK5A/aEIuOH31eMhaLQTjBzcrOu5HYo4tkKHE7uQV20xz6sAnPVAZnoM3PPASYn0ez04keffS0y5VQaW5ca9+E5lFhkGTiulZh5Mjqv2PFDO2plLjKUjc+0c53M+gnl9/glhGNNzt7cl0g29+zywp1+9HDVSkeJcBolQM8xuGPjf8YU45+79wkWzsnwhWK0dwpLmTR0AyFoPcOtO2UlW3CgfcJqilhmMCi6yI3zcyCnszs7YMPFxvnoGioH+jIyd90p2A/OkO/JqRjdYaNyr695bVg6YuYdq9yciDsQtuw==;31:6dGbsOQbxf7P2y9yJ1ZpRWVs7Ehy2GJEOUCVn5tPlIyExISRz6sL5rn/gJkDhwAZWmAEXqVH98bfpqBVCPWOyJ6K54jVKknP8O8ad1wzKah8gJLG8h0iWcubL3vsYKS92i8f8E0rKBm/aplTubkRpFJfau3GR2xr07SnF4vCFM9c6bhcUJVIEaEMoJgjwWLYh7BFov2O4GU38nooqKVBYYiHV+PZeCvtsXvbiIJQUNo=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB2026:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;20:Sztlz14lFFUdc0cIE9eINNcqJp0eKEsbCXmDbbdDXc72V3IVDJ/rlPZsArYUhdmnXqQtZSoZwt3I1ZPBQIpEVfVtbOXNstdjJZZ2+lvRiQpyUQxBp0YNpg7OqJIqX+L2PYTKTC2CaBPPR5pIcDXrUnZA5MfhM/M5l+pmQVVVXz4X2Ov4GDkUrXg2ut3GbfRnkN94fo8Dqtrum6Pp34duzsuCYT0A8PVOucaupJdAwt2SFYu/I3M0kIVi7nhj2X/00ONZCaxF72xvRFcr1T2w/zaox3wOjuMyOOoVbVLgMkUkucZHCesy2uC6bzCyAksPIZOBqU88OXBN2ni2XcAMaAtz4mos62DxWfU/Tdp85ld88axaj/SCvUnEscc99HT5KjzcXUeOoCH62QQL9nNKqkBJ6/mCpAYp2qOasbOmRI9Ftkp+KKLhF+TdpC1pm2HSKeJ21ogKZ9o1QfEZ/kWPEgw2N/IhlNOzl9SoaoM5JtVZ/NLK5OKipCphc8a/+b9u;4:m8yV8XhbFiyl9ZCqI66IDfQriCkHTYRJjx5roZ6L53Wg/EG3TxnTgZYH5pljYlD+7c6SIRhleBdo6ckMAdJbW8shaKkxMS/wf+i3hvKOIxuGNwsQFD7s7ltK8JbDrzRxsmLDLiIT8v0x6sBf3uzHRTtx+/VyuOFZXo9tBQDJLitSZRpi6BCOlWrmFXhzL4caX0L+xHhsxzIJsMez/A8jAmX2i0FbmVNmfGZnQ3qtOupbGAelAAz3bYRzsDiTNGiefcO7B/wiMZQadEWKuSdaJA==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB2026B108394B5A91E099E139CD270@HE1PR0801MB2026.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB2026;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB2026;
X-Forefront-PRVS: 0757EEBDCA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39850400004)(396003)(376002)(346002)(366004)(136003)(199004)(189003)(55016002)(105586002)(7696005)(97736004)(3846002)(6116002)(23676004)(2486003)(230700001)(25786009)(106356001)(47776003)(14444005)(66066001)(52116002)(81156014)(9686003)(8936002)(103116003)(8676002)(217873002)(81166006)(76176011)(6666003)(61506002)(316002)(53936002)(305945005)(5660300001)(68736007)(476003)(2906002)(386003)(6506007)(39060400002)(478600001)(26005)(58126008)(50466002)(33896004)(11346002)(486006)(86362001)(446003)(956004)(186003)(7736002)(7416002)(16526019)(7406005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB2026;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjIwMjY7MjM6TnQyT1ZndmZvVWV0UEQ0ZjhPTE1veFc1?=
 =?utf-8?B?TloxYm50VjY5VDNlbGFRcTJXbXE5ZW9CUWFhQkw3YzZ2dWltZU45K1E2dDN3?=
 =?utf-8?B?VmUyNFVaQk1OSysvNkthNWJhc2lJWmd4bERkUmluZTk5T0w0TGoreVpBZnZy?=
 =?utf-8?B?eFZRSUJaYWxRUWRTOVd6dWwxbHo0MHE3K1lkc2IzWHVqclNOaitZVGJBNEJ0?=
 =?utf-8?B?VndyVFY1U0dhSVBBN0xNeWhCcVFmQk1OWHhXbGMxYjBtc0txKy9uamhlZGd3?=
 =?utf-8?B?TWZwaEsxSmszNDZYYlNwamZJREFMcUg5U1ljcGU1dHU5UUc4N2JTcDg0cDZw?=
 =?utf-8?B?YW9FZVZHTHZRUmRENXlsUFJUeFcrZlRLd0tudVJIc01pTlhQNXdzalBxMFNS?=
 =?utf-8?B?WU03WW42Vnl3TUU4NUt0TytVSGlOTjIyUVVjRUxIai9jUjViTWFweGNiTGs5?=
 =?utf-8?B?ZUFIdnNJWm42Unh5bml2WHRKRE4weXRRMWt3MkZ3cy9IckR1a3MxeTg5KzFq?=
 =?utf-8?B?N0tUWXR5bUgrZHNKWmdkeE9RT3J6ZHpaaTUzaFltYUpTb1l4elJjcXU2dEVP?=
 =?utf-8?B?SFhUbmdDSWdZTW1vLzg4UVVFMHIyRk9IWnF5aFF3QVkyUEVTTUVzMWxNZHRR?=
 =?utf-8?B?WVJNMHFRdWlUZ0J3T0NpRWo5cWptTGw3MjBEc3U4MW84TmtiUVk4TjlEb0g1?=
 =?utf-8?B?eHcxR29BSkVSL3U3Rk9BQnRuUFVMcVpBcEdDZzVBU3gyWENieUlqTmZmZXp6?=
 =?utf-8?B?KzFJNlhndGltS2gyQnB4Vjg5Q0xzSkRQTWdRZkR6NTBHQWJ1TlBQWDVITEhv?=
 =?utf-8?B?N0RCWS9vZmFYS09qcWM3Yit6UmZUQkN2TjNxbE5BT2NLdFdDd3J5T2d1WFJy?=
 =?utf-8?B?Z0Q3MmZVdHRzdTdhMW82REozOGU3VmNweXoydjgvNFdzS3B4ejE1dHRoVkpt?=
 =?utf-8?B?dnB6aFZHMi8va2Rod0t0Ti9zcHhJbEJRdHZmanljRzk3b095TDBJSE9ZcWRx?=
 =?utf-8?B?cklIU01vK1A0bndFRUgrVlllMmxxdEtuYnhDS1JzN21OTk1xb1RYZUpmOUJE?=
 =?utf-8?B?b0hlSE1aMEE3b21aS3R6djRJUjBBbUdpRVI1b1REbDhXdjNDWW1HZnQ2RUVD?=
 =?utf-8?B?Z1dtZmZ3ZzlMZFpIdUZkdW1SaXNYaE52Q0VhWUVoWFF1TVIxckdUQU1PZHJW?=
 =?utf-8?B?bnFkUHp3VEdwRzVHbk9kaEdsOTd0anNGZnhUM3ZSZ05KbFUrcVdHZVd6eU1a?=
 =?utf-8?B?VXZBNlZMd2RObndPRkE5RmlYYXB4aFJKM3NaV2xLb3NuQWlzNXdzb29YSEZ2?=
 =?utf-8?B?QlFPKzZMbnBad24xTmt2aDdKL1hkQmV3TDZ1LzgxZ2YxTEtrSS9aMmpGaE8z?=
 =?utf-8?B?UXlzZ29lRHlBdDdSMFhYSUNvb1pINGQxckR1U3duVThxazZoejNrOTFPTmlo?=
 =?utf-8?B?WkhaN3FHSm8wN0VQWWhwVHJwbjNrTStVS2hZVDI2anBZM012RjEwdTVIVVhz?=
 =?utf-8?B?dVhuNzFRYVJ2RExVa09IRmFWcldpNW84ZTJsTVp4ek00SGw2Qko3ZXd1YVlv?=
 =?utf-8?B?YlAwWVg2eks5OVpaMTc3K2xhWU9ZaStEVTFNL0xIRzZLVVh2eXRTc0lOeGRO?=
 =?utf-8?B?aCtkdmlYc3RSQXRzcURsYUtqalNyV0VpaGJqU2pCT3NLSm1UTDNzT1p3QTd6?=
 =?utf-8?B?dWFMM0k2ZkluVjN6VGxQSCtmV05yY1NtYWM4bFpzNXovUWtJRXJtRzhwT2p0?=
 =?utf-8?B?Tkh6RmZlSG5JdXBvWDB2RFdiaXcyMC94T1U1c2wveWdRYTI2bm1qUjJzYXEy?=
 =?utf-8?Q?mdPekXZSApERC6A?=
X-Microsoft-Antispam-Message-Info: t6SsDwYzSB/qZcDLge5Me5omNiYNVnZxg5fHVL2LJlPOACO/qDA21wYBZJGeZXDiwV542UYYbZDOko/VkCXoESRG0KKAoMZDpzoEkeIHqvDRucWwMjvNLN1ZuDr0JotGxbr2nqH0ctrs2wGubWR00xi6ElHNpNmIHwlcYrvDMmPZcKtTdL1qYrPd2IXhmo+HrA4smhc02ReabFN5FTk4oDUajNzz8Q7dXYgtZOF2Md7Is014AA3sV1LQt7q+o1OYJ5cuK+CEfd37w8DLQe6srVBVvLpda0lmsatf/ZKvzCoTk6kQB3fgn6QZPgeKh4wH6dbUaqbtLIwGr2bbk8aZr3POzEAY2TgOmtgHzz8GWd8=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;6:TmH2zm3pj+UI4+hY2/qSzlGCSpAzDwzDwtVGuIhxv8ErXl1/v8A1nvDy94nQdZsEfKs3GPBWAdRx5FRABcSWxPOHj9YW0qito1BAZsPt6v6kEUC6nk7zLDsO56H0vWngau30EQIkRfLOfyTNRiXzIMWD3sVuRSOfHBr4EcI7i3QvXegaK9x75NOph/mzHOtkCBKRjGBEo0DIuixhGm2sX1OwR5uCeHtGP53xMshc1QCXeCWU4j0FEdMvaeIgEccBmKUlHV/4465FCsI3WGp0QwtqLiLAFjl31RytIxz7baDRHFJm6+/wRUoMm9pToFVwWbZbftwsENu/75SAvjNxedM7slQjlGNS4yWOMKdeQuaLaHWi+et4HjTkiTwzxKyi1wXYQWJea0RZzQyfPa5Qur9tOINI/CJlcORpTKoik+DIh/zD4I515WPeGXDJ5Yf3wMAUqgrKWDJ/ezmHeIpDXg==;5:3/5oEI5mYlVishHMDob4xCj4k2lzh9n3VQLztb7xjjsIe7WBMwslFq4zMwfPgR+tCXQkaIfi4TAW0woYyVgaWQdntEZaM51+7JLUuCFyn83YpI26viVKCM/q1OMzRzCJTkbMTUYRJpDmr2LN1wHeDNQHxRw3dhX7QvuRloxc+tU=;7:C8tZiZRNhi/DyMz2yN4GOcupIPloblHlpZaH8oLIEmohrq/tFOHWqWn2iUnuRbuArz/ngWg0q51AgrUcx6xOeUwhttIxNCsEVB/v6mgPKfNy17NZDAKyTon7REi02HDu9V2OR2TLN4HF+y1J/GVMiVfUO7trpbiRSpCs10rz2q9ZZjF7JOSz6ylZ6c3ugeTRoEn6aGxhwlAwzrWJnsJrDqgazsPis1YuK9SnO3lu5/zLGtw7DbUfM8D8M03QoHM4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;20:LrQHlzuO4ScRNp+WX0KrOLhI3m17GrFfUcUmpJgpeH2Umo2/L1+eSWmRGeDp3BcbId7L32gt3I7inGyOavULUXGFiihsz6xzGcx5H91AE1fsk1zPqNreXeAlll6Q0hncBrYQeCiQ5tSXtIZid8nAqapkk0X9wmiNl7O2YV3F/iI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2018 15:37:50.5971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 679832a7-3215-43b5-fe22-08d5fc7bbeaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch makes shrinker list and shrinker_idr SRCU-safe
for readers. This requires synchronize_srcu() on finalize
stage unregistering stage, which waits till all parallel
shrink_slab() are finished

Note, that patch removes rwsem_is_contended() checks from
the code, and this does not result in delays during
registration, since there is no waiting at all. Unregistration
case may be optimized by splitting unregister_shrinker()
in tho stages, and this is made in next patches.

Also, keep in mind, that in case of SRCU is not allowed
to make unconditional (which is done in previous patch),
it is possible to use percpu_rw_semaphore instead of it.
percpu_down_read() will be used in shrink_slab_memcg()
and in shrink_slab(), and consecutive calls

	percpu_down_write(percpu_rwsem);
	percpu_up_write(percpu_rwsem);

will be used instead of synchronize_srcu().

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/vmscan.c |   42 +++++++++++++-----------------------------
 1 file changed, 13 insertions(+), 29 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index da135e1acd94..9dda903a1406 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -168,6 +168,7 @@ unsigned long vm_total_pages;
 
 static LIST_HEAD(shrinker_list);
 static DECLARE_RWSEM(shrinker_rwsem);
+DEFINE_STATIC_SRCU(srcu);
 
 #ifdef CONFIG_MEMCG_KMEM
 
@@ -192,7 +193,6 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 	int id, ret = -ENOMEM;
 
 	down_write(&shrinker_rwsem);
-	/* This may call shrinker, so it must use down_read_trylock() */
 	id = idr_alloc(&shrinker_idr, SHRINKER_REGISTERING, 0, 0, GFP_KERNEL);
 	if (id < 0)
 		goto unlock;
@@ -406,7 +406,7 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
 void register_shrinker_prepared(struct shrinker *shrinker)
 {
 	down_write(&shrinker_rwsem);
-	list_add_tail(&shrinker->list, &shrinker_list);
+	list_add_tail_rcu(&shrinker->list, &shrinker_list);
 	idr_replace(&shrinker_idr, shrinker, shrinker->id);
 	up_write(&shrinker_rwsem);
 }
@@ -432,8 +432,11 @@ void unregister_shrinker(struct shrinker *shrinker)
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
 		unregister_memcg_shrinker(shrinker);
 	down_write(&shrinker_rwsem);
-	list_del(&shrinker->list);
+	list_del_rcu(&shrinker->list);
 	up_write(&shrinker_rwsem);
+
+	synchronize_srcu(&srcu);
+
 	kfree(shrinker->nr_deferred);
 	shrinker->nr_deferred = NULL;
 }
@@ -567,14 +570,12 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 {
 	struct memcg_shrinker_map *map;
 	unsigned long freed = 0;
-	int ret, i;
+	int ret, i, srcu_id;
 
 	if (!memcg_kmem_enabled() || !mem_cgroup_online(memcg))
 		return 0;
 
-	if (!down_read_trylock(&shrinker_rwsem))
-		return 0;
-
+	srcu_id = srcu_read_lock(&srcu);
 	map = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_map,
 					true);
 	if (unlikely(!map))
@@ -621,14 +622,9 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 				memcg_set_shrinker_bit(memcg, nid, i);
 		}
 		freed += ret;
-
-		if (rwsem_is_contended(&shrinker_rwsem)) {
-			freed = freed ? : 1;
-			break;
-		}
 	}
 unlock:
-	up_read(&shrinker_rwsem);
+	srcu_read_unlock(&srcu, srcu_id);
 	return freed;
 }
 #else /* CONFIG_MEMCG_KMEM */
@@ -665,15 +661,13 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 {
 	struct shrinker *shrinker;
 	unsigned long freed = 0;
-	int ret;
+	int srcu_id, ret;
 
 	if (!mem_cgroup_is_root(memcg))
 		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
 
-	if (!down_read_trylock(&shrinker_rwsem))
-		goto out;
-
-	list_for_each_entry(shrinker, &shrinker_list, list) {
+	srcu_id = srcu_read_lock(&srcu);
+	list_for_each_entry_rcu(shrinker, &shrinker_list, list) {
 		struct shrink_control sc = {
 			.gfp_mask = gfp_mask,
 			.nid = nid,
@@ -684,19 +678,9 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 		if (ret == SHRINK_EMPTY)
 			ret = 0;
 		freed += ret;
-		/*
-		 * Bail out if someone want to register a new shrinker to
-		 * prevent the regsitration from being stalled for long periods
-		 * by parallel ongoing shrinking.
-		 */
-		if (rwsem_is_contended(&shrinker_rwsem)) {
-			freed = freed ? : 1;
-			break;
-		}
 	}
+	srcu_read_unlock(&srcu, srcu_id);
 
-	up_read(&shrinker_rwsem);
-out:
 	cond_resched();
 	return freed;
 }

