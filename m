Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191CDC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B359B2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Xn1RLB7o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B359B2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754601AbeGIIjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:39:20 -0400
Received: from mail-eopbgr70105.outbound.protection.outlook.com ([40.107.7.105]:4522
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754093AbeGIIjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EU5JnIoP5txGP1gd4Vjokx/J7dKJ5CZi8v+wa69KAOU=;
 b=Xn1RLB7o4pwe3WCqtPrgiqREq80XmKee/kBXwAFDPzsSjC0T+7ec23mq4kvelGtptToSeP8JjaCYJmXXta7x2CeERYj/wDOdPtX1EBoYbyF90fHBqoNYfA23efbFplgsHFd9kByoipGBOSYsagzuJe7lOn4J5bAquSM7HnX1lyo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 VI1PR0801MB1343.eurprd08.prod.outlook.com (2603:10a6:800:3b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21; Mon, 9 Jul
 2018 08:39:08 +0000
Subject: [PATCH v9 10/17] From: Kirill Tkhai <ktkhai@virtuozzo.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
        aryabinin@virtuozzo.com, akpm@linux-foundation.org,
        ktkhai@virtuozzo.com
Date:   Mon, 09 Jul 2018 11:39:04 +0300
Message-ID: <153112554453.4097.12367687920458389659.stgit@localhost.localdomain>
In-Reply-To: <153112469064.4097.2581798353485457328.stgit@localhost.localdomain>
References: <153112469064.4097.2581798353485457328.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR02CA0111.eurprd02.prod.outlook.com
 (2603:10a6:7:29::40) To VI1PR0801MB1343.eurprd08.prod.outlook.com
 (2603:10a6:800:3b::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cd20dc0-6a30-411e-1b03-08d5e577714d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1343;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;3:9mZ3W0oCM0N7Matb57GyhOjaUSgvuLw6+jNtpxc+FNoAEsBV15JmZQb4dWku2g0j26mKjPePHShbpGLk67US+c0qW5qMYwkEuKZFnKmsDtdQ8u9UeFRi8ON4ZZAg01MawEc1q1pFv3Oj+JhtW1mvT58bmNgkvyTl1SsJ4ISPip3p1/i1IDReLSaRciGjoyBJbNBNBZfLXzoWKYThbSXCLw3Z64GPT1v7TR6DILcNInxDrpUqfu2zVSyFj8r377hO;25:ejaa8VMuv3Y70k1ebY88E+YGIfT5TTRjBauoW8bdqRGT6uOki2WgraJYktt6HEs94zbX3DNIqjplvPpg/pBr1XHo435V95qOPrGvYriWFFkKctScK6MG5Qf+hRiG0Hhh37aLcsAQqT/dAipeN2zx+QSE3q+MbqeIXJEdJ42PcHmDlZ6zF1DnkBj2uJTVuGv5spzJDZaFJ8CrA5Zp7Su2gEG/cRko9AIj+cSjEf/ywwc8Ti0oF/ZcpTSp+ZRM/KB5JPGkRzL6DBWnGBDuPEjK7jIRvN92L8+6otLb5VT3bhThDHzB5u9iAao9xo1/nwmw4PhLytuALvdDZfJGB9Kmcw==;31:bREc3lDZFzNkR9pA2bh9YyKTQLpxZkJ6Na93fem5VexnwalMawmybjrGy6Uy47Il/p1tRoMyBmsAqedWyI6T6nYr+Pzuo8DlfSk/hAJHIz61Mq817llRZQN2gmxodf6bPEjgLyuAn5grMbnZXi6ydXEbZShFg22wKPzLKJzJJ6fWPMSBk1ZftAtP69peMvC2nPbWIdSKq/FYNY5ybiVkG645VK8dDxBFEtsQ/MYKQWg=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1343:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;20:wvsG/pkaREfmuXOiYBhhCrsgYEqOsNa8f1EqT0SnTbc3h5Jl/pl1/A/pauLUpTO9QijzZVVYwk9cjL0KIh6XMinP0ielj0iC9AhkEbpl8UBdBO1YP1woV7S4ndxU0zp0MT0mwk7CsOGWY21m9sc9wGLjL2BNbv/zxqIVhxpE7abLCy6CiiOuFn4xmxmJzg0Xbydjql+AuIAEQoJs2ZF1WRqYxzuGKKM2Ld3Um9DpGNtzyVH9feZpwlnD90lcsVkP2chWlOU7HU7+hVbvOKgyofvTI6edCm+KgS715dV1PbQ3D65Wgmf6Opgm+YUSqJdNGB/GJuvE0iSgoZeMz4XUxQTgSEDoV0hqB0L6LHFULdxLxgUKkNttweUYMWjOe5iNYVU0z2MmcPoEJoRFa5cjSnmojo3m5F6WaKs2rTg6PKrzszCnFIyU+iu/dVteu/rVoq76uuEVUjYhAv0OILinYLbBZja4kx/nkhoYyaRxJ2Ham6vr0ZoF30T1ilJ//GE6;4:WAlibcr9ziDLdhcCEA8vD7I/fAeVyfxyM6bYxJAm/3HxNvZo1hCzXxzuG+mEVPn0fepuhdCNJrP1Cx5g9kqvqfpt7ahpN0EgpZsAYMEjeZQrVDq89HKr4FC8W3bU3DWYQN4bxTp8RZucJWSDsFhzvvfkHuVrgbGmtPZ9zfUJBjB+THjR2rE5eEHjPhYFimIydbv1kBncP30CqwNjL5z0OUmGxe3yzVcQ6j5U4kG+kRXz4eh2RQEqVxk4+OEAxbjKXh/8U0aq9CDU7pbexIvv9evsR3EdvXyYVEMMi4Yl45SP2h+pyNuvz1dGlYHbPoW7tb6OJLx4GPSvsV3KPxhIerBLi9QEj23J0u4g9dSlhKT/P39LJrQ3wy5z9lzJCEPV
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1343F7903503A7E0E63066ACCD440@VI1PR0801MB1343.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB1343;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1343;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(136003)(39850400004)(366004)(396003)(346002)(376002)(189003)(199004)(6666003)(50466002)(5660300001)(7416002)(486006)(230700001)(61506002)(3846002)(6116002)(476003)(956004)(47776003)(66066001)(97736004)(11346002)(103116003)(106356001)(478600001)(105586002)(25786009)(26005)(386003)(6506007)(16526019)(186003)(316002)(7696005)(23676004)(2486003)(76176011)(86362001)(52116002)(39060400002)(446003)(33896004)(81156014)(2906002)(8676002)(81166006)(53936002)(9686003)(14444005)(305945005)(7736002)(68736007)(55016002)(8936002)(58126008)(921003)(222073002)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1343;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDM7MjM6VURjcU80Ly9CVFVnNDV4V20rdmtTNU1l?=
 =?utf-8?B?VVFXSWs0bko5RnRRU01PMkc0QXkxaEN2YTlONit2UGUyOVlsSXllKy9FWlJa?=
 =?utf-8?B?RUxPT0xpeHJlOTNxVHlxQ084aDJBQk5ML1E5Ym9WMTdsT2NFaEhvd0U5dUxP?=
 =?utf-8?B?WnlMcy9rQ08zbnBMU2xCN09OOS81alhRaENvWm4wbU1qdzdBTFhMeUp0N0ls?=
 =?utf-8?B?My91dzdYS0ZORVJzbWo5K2dqcDIrSDQ5b0FyZXg0VDZHQ2dkR3JwcjE0b0t2?=
 =?utf-8?B?c2ZLTjY4bWtQeFBkaGFuVEJndlF1ZXAzZ3QvZ2dYY1VRSUZ4NjJQOGw3YVlH?=
 =?utf-8?B?SUdwd1FSSTVWK2xCY1RoZkt5TkFMSk0zSlBuTC9LaUtuMUU0Q3RYRDFnUDBx?=
 =?utf-8?B?UnluZ2lpamhqT3NWcnBodklVWCt2bXdLano0L3RkQlo4ZEJhQWpMQjlONG54?=
 =?utf-8?B?LzhVVUhlWU01UE5lV2JxNTVQK1VXY0d2M2pOYiszbmwvcjg5QS9iY1ZOeHlL?=
 =?utf-8?B?RU0wU0cwTk44bzVrVG1CNWlFTm1rbjBZZ282MUx2MnY5akxSTHVlc3pucm9Y?=
 =?utf-8?B?RDdieTJWa3pjcVZycytmQUVxclVnU3ZLUmhvcEtaTmpCR2NBK1cxYitVSklD?=
 =?utf-8?B?ZGJwRE5HMjFWam1PR0tHUjVrRE0xd290ekJrOFlRVlpQMjQ2S1ZyWWwwWi9S?=
 =?utf-8?B?QkxPTXliQ0VwTnEzYmw2azJUNDFseXFWOStxaDM1aDd6TW5udjJLYndkd3dG?=
 =?utf-8?B?OURlRWd1ekFoWE1qOFNNc1BUWWE0NTJ1aThMd0tjdzh6dlR3cm9RYzI5V0FN?=
 =?utf-8?B?c0xtMk5qSE1Oa1BPK1NlRnkxUm9jckgyM2xPUTcyam5iY2JHWnFzK0c4TUJB?=
 =?utf-8?B?K25CNUw5TVpTRW9QQlRzN2ZmQXVSSzczcmlJVWpBSkZna2xyWVR0bTRZeFJE?=
 =?utf-8?B?elphSHZOZnNNUG9CN1RHTkwvY1NqcjlkbytLZFFPdVIyYXA3anVpaW9Qa0JW?=
 =?utf-8?B?REU0RmFOZ2dkRmUreFRiaXlCc0lUMm1mMGJFdXJRaHpNVjRzSzJUWGdRSEcv?=
 =?utf-8?B?WmlNVnhYdUNRK0xjbjN0N0xvQ3ZVL1VpMmxvZW01SCsvZUlUYWZDQjhST0o3?=
 =?utf-8?B?YWtKbG5xbUdpa2tteTFHREhaNTkzWkhxZlpvMGdKOFIrRktTVEd6aXJ6KzdS?=
 =?utf-8?B?ZklVbm5Db1FzSnh3aVIzYkNDR0VOcGdwQWx6VW9UY0dzN1M1VmFWekVOL3lP?=
 =?utf-8?B?SkR6ZytVcVlDdEVNNS9PRzdoTEdDcHFGUDYzMXZTSWU2NTlvaDh1dGJobWp4?=
 =?utf-8?B?bFpwMGdoS2NTTnpVSjU1RG1CbkN6YmIrRXpZVUZqS3ZacDZ5d25mV0VuS1FN?=
 =?utf-8?B?b3BWcU1vand6aVZqNGlCRHNWNDljYnI3OXlQNFNBZWZ2VTNMaXFWeGlkVm5R?=
 =?utf-8?B?d0V0OEpDQ1lURXE3WHpQc0dnVm9JakZHbmtldm5YWklNVHJBR2JGUFBkK21o?=
 =?utf-8?B?VXNRaEljVmlLMkpEV3F4eVJkQlhmS29YNmFobGc0SGdlWXlMZGV4KzdlZitL?=
 =?utf-8?B?eWdiRC9BMVplOTI5K1FaTVFOM3ZkcGIxQ2R4SERFWWRscVVkSWk0c3QzRU02?=
 =?utf-8?B?N2QvWjdySFdqbUxqMjVucFkzMjM0Nk4rdlNoVGhJWWRueW1zSWdzVzZKU0JV?=
 =?utf-8?B?aFVJUlJRUGZ3VDRzNFVMTDljakkxekFDQ0ZDcnJqS1h5NG8weEJ6ZHZ5Sy9H?=
 =?utf-8?Q?JT7n++hSeQq2IKLII1Gr5w0kIgh7EnuSj0SEBho=3D?=
X-Microsoft-Antispam-Message-Info: X3QKCJfAaXWkreSZwQednSqhQz5Abs52qPcDM5oA8z33erg4xYexur0k8lX2380zFzZwNMd0kqweoDSKt2Yk93BIZQlR7PAXs7vaf2OxcZilJDFnT9PUN3G+SupwNZa1NHx4QpGjei+6fz/m7gaSFxGSejhNLCc3gkVOwy7LNvQrv1j4uEa/P3borZblPUlXLM/F/I6Vs1/xj4Cxiy2vjzUqRmNIl7+DHg3BmiAzFsWo9bi36hNA7/xt5IL34+zW8gDNlaGlAiXiopDoXNym8KFu+8P3Hv2EkCzA5cjQXC8+KhICsQ7rHb8tF89CM02/XZqJTJWpj4xltcXF5lGQDNwus/Wyc4zaCrn5vYI0xYw=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;6:0DETfnm3xFST0YOoi2e1sYKpkYDI+RzmwPf0cNbczRK/NadflvronFJEMUN4cd6qAQST41w/2QgjX5F/60t9kURswVMAK++hUxc6PHSZlvC9f4iYUV/1ul/9qX8+krA5AOvBllOcj9xE9UZOGYpdt5X/KSY6Ppr0aAJ4/a8goJtSmnwy2W3o2L/PQAFZgTf0c0fZeZkTWml/gDxGn8sOYPzh65B7AKGcQIKrCDdMjXTCpHT65IAp1dsRb1PDLPawBHo1RKxPLA7BtrxbNbxQUtxW0D4fB1OoYmSTKgDoJbJ8T51WnYl/OJCuC4vburGQQLNOo9j7i/3we5mDt6d1hl8KPz9sEZj/kVKbA/8fZ2dg+fkDWpbxC2AgOXJ+JQ9LqK88MlLafCO4a54ogVpjLMUWAnhUa/78J0W+uimgPiBNfl6fNRJl7JQRaPN5RYWg2v8+cTsV3IRfiouxHNXtzQ==;5:7dov+XmwYLJkZMAufbkyQgHvk2nxCwwqqBXywmu9X1BI9f9VHj6NGt1yt02rpDlyQtvwhIsQPIxqvNy5wu8NrV2IAEIXZgRRhB0+22JoWP5i8Rt2tudLOe5Z2E00h73XgQkgMT2WDKxScpRDVsVW+LAECbWKnKT0JL1GOymIdM8=;24:abJO5PoiAAJcL5SQ2XsCT1SAUzgC5sJjJknw+02iHP8qrQ/ZEUbbbXnaazIGtvz37kP1w3v0c2EDAX0ivtEwUwDhpczccEY7mglOurhJfwQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;7:aCak8TPNI7F6JP51rv9dosIUeKRTYRpszQgW2EcE4Xyz+5QA/VJ/fQqkgyeOylMimRYBLCbx8afdOA8j7t7RASqMBIDTdIIwt/Y1B2dlzniFUl2anMDwpA+gqSPALLCl4PjSbbUri2inPcJ6egQGLrQVuovO4xglexwWkx/toCRUGPIDg+NZVxiqSSA6QSjH3E8rHCWz2PFXiAOjaW2XclUC7cNCAzxnDg7nY65k5quWMeKsUi3miLnu+nN72DZa;20:RMZehttSVbSEbchqyDINYvwRQGeX85CdMPawT246vx10NEisRcYnwsXpu5a00aSZ9VKoabllj8kwuu6/rE/hJ/5MsuXWONGshbLVz6ikb/U9qBgnGj6kATW80x76zf4RABHw64QhbgY7B9vabygZ11KSc6jiFX6QYjN3L96pgz0=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 08:39:08.2330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd20dc0-6a30-411e-1b03-08d5e577714d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1343
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

list_lru: Pass dst_memcg argument to memcg_drain_list_lru_node()

This is just refactoring to allow next patches to have
dst_memcg pointer in memcg_drain_list_lru_node().

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/list_lru.h |    2 +-
 mm/list_lru.c            |   11 ++++++-----
 mm/memcontrol.c          |    2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 9e75bb33766b..d9c16f2f2f00 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -69,7 +69,7 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 	__list_lru_init((lru), true, NULL, shrinker)
 
 int memcg_update_all_list_lrus(int num_memcgs);
-void memcg_drain_all_list_lrus(int src_idx, int dst_idx);
+void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg);
 
 /**
  * list_lru_add: add an element to the lru list's tail
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 1fc5be746e69..5384cda08984 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -502,8 +502,9 @@ int memcg_update_all_list_lrus(int new_size)
 }
 
 static void memcg_drain_list_lru_node(struct list_lru_node *nlru,
-				      int src_idx, int dst_idx)
+				      int src_idx, struct mem_cgroup *dst_memcg)
 {
+	int dst_idx = dst_memcg->kmemcg_id;
 	struct list_lru_one *src, *dst;
 
 	/*
@@ -523,7 +524,7 @@ static void memcg_drain_list_lru_node(struct list_lru_node *nlru,
 }
 
 static void memcg_drain_list_lru(struct list_lru *lru,
-				 int src_idx, int dst_idx)
+				 int src_idx, struct mem_cgroup *dst_memcg)
 {
 	int i;
 
@@ -531,16 +532,16 @@ static void memcg_drain_list_lru(struct list_lru *lru,
 		return;
 
 	for_each_node(i)
-		memcg_drain_list_lru_node(&lru->node[i], src_idx, dst_idx);
+		memcg_drain_list_lru_node(&lru->node[i], src_idx, dst_memcg);
 }
 
-void memcg_drain_all_list_lrus(int src_idx, int dst_idx)
+void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg)
 {
 	struct list_lru *lru;
 
 	mutex_lock(&list_lrus_mutex);
 	list_for_each_entry(lru, &list_lrus, list)
-		memcg_drain_list_lru(lru, src_idx, dst_idx);
+		memcg_drain_list_lru(lru, src_idx, dst_memcg);
 	mutex_unlock(&list_lrus_mutex);
 }
 #else
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0cb2c7ca2086..cac30b4e9904 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3009,7 +3009,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	}
 	rcu_read_unlock();
 
-	memcg_drain_all_list_lrus(kmemcg_id, parent->kmemcg_id);
+	memcg_drain_all_list_lrus(kmemcg_id, parent);
 
 	memcg_free_cache_id(kmemcg_id);
 }

