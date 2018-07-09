Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7353C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F3DD20864
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Ol4IvZ7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F3DD20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754632AbeGIIhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:37:37 -0400
Received: from mail-eopbgr00126.outbound.protection.outlook.com ([40.107.0.126]:7462
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754492AbeGIIhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkhzQkcrbZYjtD5s7eYBhzQLK0cdV3MzjcjxvwZuIos=;
 b=Ol4IvZ7y6HdZwkzRk79GkCEl5E97QJgO4pBwGccwp/ZTXXwEjNOJHP/ezbOjXXQJCPPoD+uD1JpaupRJdu4FxomSX2/UL7F6dn3d6Hz1pzC89oHtAg7anLb+lNlmINyFfOMo03xS1dO+wejE9fCYRQLr4xukYrtqH7YwAumgoLQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 VI1PR0801MB1341.eurprd08.prod.outlook.com (2603:10a6:800:3a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.19; Mon, 9 Jul
 2018 08:37:26 +0000
Subject: [PATCH v9 01/17] list_lru: Combine code under the same define
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
Date:   Mon, 09 Jul 2018 11:37:23 +0300
Message-ID: <153112544321.4097.774414812050671572.stgit@localhost.localdomain>
In-Reply-To: <153112469064.4097.2581798353485457328.stgit@localhost.localdomain>
References: <153112469064.4097.2581798353485457328.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR02CA0114.eurprd02.prod.outlook.com
 (2603:10a6:7:29::43) To VI1PR0801MB1341.eurprd08.prod.outlook.com
 (2603:10a6:800:3a::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0118a1a5-e603-414e-2f73-08d5e5773500
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1341;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;3:bz9F9uKJPj/6uUXmEiUT9BM9CTCfC9SWLdPF5Gs9Jziq2pVQyydFPWKHtY3OBewm2rwVFoOFItG7oUCceCTZ/4CWSmryl7j3VQKBoGrdZmsQ1gzePUS4rGDZP8DEzA0als6XVHvxyLYp5mUFX9XhQRTr1MDlfgVF4noKboD+2H+Wbgd1d1uchc8vqATTBCmU9DC6219iBrHp9W+JDMfMJq6t+rrBthtzKDSz14FdjfOwQAwkv2/7+b47IG1xQW+S;25:zzmvWtp/IGyJnb2ohBw0ylKDQsn5CllC5XtnebXNIJlLDPPV2+TYyfALA92OuJ4ageVgnw4229ZvnGCFEaxdI9R9rf+rY7/7tDI8Dpt7O1Ao6PgKOIYeCwPkueL8wP9Kcp4usZTyBFFHqbjly95Uz1XKQdiSXoP2vZQdAzQY55AXfBLqCo0PR2uicKEe8W+ioGq0wjg9QTSqGC5StxIvEgH/YdR0ZRG6Dtdz5qsmC2hd7BzwScKM0ef1ZIf+Fq4V6g65SvkKGTcMA0pv9QYyqCw3DQr83gSfVFqDpEUmWyizjItk8n2DBqCFObvBwlWmI5eO4kwXJcudGNv1UvM3eA==;31:Bx+bapAWuRBXkm3EC8ndtQUnBOu1OCKA9Ovri3veyCblwJ/WP2mTMK32I0gNzk+54MV5od81GlbdYYHnv5qTZu8IiuHdtwEz/889k5T8Gf5UpLwDQu+zf7gn1srPAqXnF5a9x7lX/zE0xjXoWJf9SGHdsZRpgMFlXjJ80rXNLCmMJg6ogfJC3PVOaetvHFmJJUGQM6rhM1oUMUQNmxxz0+JjdzXV/b9gjoRrAk1QCUw=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1341:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;20:rsm1PYz7hrvH/DaQ6Kxruezkew7n2M3ylaeSw++r7uJLIGoSA07muzfAGxD/LbzH/VKUDWP+9d2+NewAagzSzShrzAzBue2Xbwm0Ig6FP9PQL7j0TEIf/sbDmrSMrylyBfHKRAHTs5Sg1SKKtmEGIAEpTNEQkX0MsGvtNeo9YZ80ztBv8OQzuzcY1xffroEvMSBkhz2HB7B6DcEiRP7w+gA5GnEugMx7J0JKwHrruGw0/5BdvtavP2YO27kh8GwPQ1tCSRJ4oU0Sh6eke9CX42EkwfwVYW4zEyD3Z8kZS+TtmrornegNvk8vWBw4CcwYaCR107zmqqKSGNcKIXkJIHNLI1PSyKR2tIgHo5XY0hmohNuySnsiKa9rKl+qnLZEX09hOpRkaaxF+HYT6KREtjFAmviIbL5B7QbCDim7uHE5S++MnSHcRvfRQXq0ptVUxyFfoeRkc2NAVUeCsVMuFgV9E7/kwKUt0UDf86GbZiFNHSk4nYwhVsDEPv56iHWM;4:VXc5aUF/Bd27aJdVwiAAguRKoFAO23nuChrTiH593XIpltaJDaFRgdGQSWZKhPhzE0IdKfOjoeAejvKQQ/XtN8EKccowl23rr3O+Y7oRRDBZ06ig/+X6bQdAX8fgaUpYjQuiAbFijXHvR8bzk4zKo82AdPUnmHojJw8YdtbwiFAIerp5CkrdAMd77uFMBto/xH9rngDx6wGF8md8Eb/7jn/88qEajri4IhuBjADoLOaJFTKymcUnbhPMpXxnvritMkvUmwuCFpqnifR2yLYueDAWBaLCygs/xdAWp9yAN3s/tTQLyb8rfhb86kxMwLXpgcFJwsfuCa2RLQ8YHiacSX2BI8WLD6Tig40Dk08igzGmtk1J+Ysb1485YOmKo4hq
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1341932FFAD5F45BC10CF28ECD440@VI1PR0801MB1341.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB1341;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1341;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39840400004)(396003)(366004)(346002)(376002)(136003)(189003)(199004)(52116002)(8676002)(105586002)(7696005)(33896004)(575784001)(81166006)(86362001)(76176011)(106356001)(316002)(81156014)(97736004)(305945005)(6666003)(66066001)(47776003)(50466002)(25786009)(2906002)(103116003)(68736007)(2486003)(23676004)(5660300001)(61506002)(7736002)(478600001)(6116002)(8936002)(476003)(7416002)(446003)(11346002)(3846002)(486006)(53936002)(9686003)(186003)(58126008)(55016002)(39060400002)(230700001)(16526019)(386003)(956004)(6506007)(26005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1341;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDE7MjM6QnJneWhQZS9wS3VpY2IyZ21UdE1qRjRY?=
 =?utf-8?B?bTVzMEZRMWZPMDVPV1JrbWhydmFjUWV6b3Fra0VTYy9nQlAxdzk3UGxWWnB4?=
 =?utf-8?B?UnErVDJ0ejcxUklBaVBUbVhhVXErRGVkUjFIVVVHT1l4NldBMTJKRTFBWUk1?=
 =?utf-8?B?elZDMTl3elREMkNSQldCTm5pTWczS0FsRGdkT1Bub0ExWHRVZzhxckRsbFli?=
 =?utf-8?B?ZFhra2NLQWdLWTdHcmZLblk2NzVHR3g3YU5zdnlLajFiY0c2a0JjMVNtQUlR?=
 =?utf-8?B?dEFIa2gvSzBvNS9EejFRL3Q0N1J2TS9lSVFkdjVjNVA2bGJyZlBWZDBpdFJl?=
 =?utf-8?B?eXVTODJEOVVlend4TVhxb2lrbW5xRmhPSkZ5VytiblF0eEdwN00zQ1h3STJh?=
 =?utf-8?B?b0ZwdDVnc3NTZWtyUGMzcTNHTXc4VWZxOWxiTUgwQ0sxdkpHZDZhbCtDazNj?=
 =?utf-8?B?RnVUZFF5elVoS3cxQzB6Mmo5NE1YL3B2TElOWFIxNWJqYnA3ZmFUcnh2NXAx?=
 =?utf-8?B?RUZlSTRpWHEzemJjcXVIQVlGTHlvMzN5ZWJxa1hHOCtKeERyb2tWbUVoblov?=
 =?utf-8?B?NHcvSFZOc2g1MTNTSUQ4WXZEY3NCUmp3SHdCU2YvcUx0ZTRBQm54OE12L1I0?=
 =?utf-8?B?cEVpT2c2Qjh6VjB1clpieVQyeHhmWTlGYktQMTRHWUJWbDc5djVIcHQ5Vk9Y?=
 =?utf-8?B?YU8xT0FPMXR6U05hRnRTSmZObXgwcXIxTG5qRWVOTDd4d0hXNlU2L1NHV1hw?=
 =?utf-8?B?ZDNGckxZWGV2YW8vdmVZa2F1ekt1N3BTdnZvNDZwMEpZK0Q2M1V6MEg0aFhW?=
 =?utf-8?B?a3pVUWlHMGxnek1uU3JLeWRUekRXSlM5dktkZ0Q5NzlINVBWbURCUm9QcXVB?=
 =?utf-8?B?eC9peWdYY1YyS1J1NG9oTkNEc2d3Q0RFamM3RkFRYkxPelN2MFE3WHRxOFpv?=
 =?utf-8?B?UXJxZ0l6OWN6RXZHcUhYcyt6UThwQ3hPVTFVanFhOFNKWTJDRm1JQy9yM3NX?=
 =?utf-8?B?SW9Xdk9NRmUvNDRSbHp6SFZKcGJuWFR0UXcyOGE3Z3pnRmxvbGdidW1SbnF3?=
 =?utf-8?B?R21qUVR2aC9TYk4yUnFNRGttcGp2bnpJdzdLNWZpaCtEQWhkRjR2TC9JTjhU?=
 =?utf-8?B?U1A2ZjNRM0hWNlk1Z0lpd1UwOHRqSis5TFUzRHpVZGNZZ3BaZVl4d0V6NkZ1?=
 =?utf-8?B?MDlVOTJaazlWTnV3ckhzUmRsQ2JiRkl4SHBmOWdYM0Y3emprQU1WaW9Mb1hI?=
 =?utf-8?B?RFVmOEdZd0hxb3U4YXVzWW01ME1WSjgzM1pDcFZSd3pkNkdYQ0dCWXJnbHpD?=
 =?utf-8?B?R3g0NEFyWnFGWVNkb2tDSHg3LzBnTytVWlA3cTAwMThaaXh5bC9BcWVKaEF6?=
 =?utf-8?B?SUpLYWNnQTBKQ002dWdqcnl6bE9qYUo4ZjMwZmJKcDVMT3p5MmRVVFFtNHo0?=
 =?utf-8?B?aW11QjJ6RVhJZkx2Y2NXNnpwRVNCT2NTVk9NTjk0NnpGQ05ML1NuWHNGdnJC?=
 =?utf-8?B?TkllVm5IZ2NYMVE0d1U2eDNKZDJIZ2JodE1sSGxUMll5UmxCREZRSFI5VmEy?=
 =?utf-8?B?ZTBJRGljQ1AvdG1ubTZuK1VPZFdZdG9JN1NuK0M5TWF0YTNXd3dabWZDN2Qw?=
 =?utf-8?B?UURkR3RCUnpXeldNK01sdVRla0FrbVcyUlc5cHlGb1FldVNZY3czQXhJZFE0?=
 =?utf-8?B?Q3lHaWYzbDJzNVU2OVRqRWtCdllaS1VPR2dMeEFZYmI1ZTFjMXBocmRaQ3ZU?=
 =?utf-8?B?bVZVaHNqcWUwMnFqeXVaYUhBPT0=?=
X-Microsoft-Antispam-Message-Info: U6ZJNCjULMypgwZN374Qqk8rBiqW5PID80dfhPvi3FEedjTRucZgVeZASe8O4kLj2KfnJcb/tuZdZe11j/rRgB2+njQicN4nlsc/4+PvWNkh/hkuX/ZCK4Nz4PDLVnFbKV07U9Bq2VB6B28f272YbvlpqPemtFlRf4BR/Vfse4z/9HZr3IRm+P+N6wZV9ECPfm4Es+c7PKm5Au0ogEsVS8cBnICAldtsrW7zthIHkSjophrvauw2vxhTg7fDT8GDIDEllGhff4M1EoZu8KeKEs+V/cKVX0/PeYTQP+W+xj7EavZLrhq2SDGY536Bmregg4SwNmq/qGRuap4EqaDLaJhlub664nM7kFm3Q6geDwY=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;6:xSN0WpPqCygPWwPEZiqvmMmpRAdrgd2tKxsJsOoVoOnTrFjAqrNezCG7Yau568/7JEwv6is8Mra/EIK++Lwzd35N8cJcjJabCcv2yAqbAT0xi5Q3s0GTjDlhTgvVyND6otbHRMtEkYtrpxtVdlNVyy4OJRIYz7EuBkzM0ETWzM+33EWypbxoqK2l0+EYLaUri3Y6HonsIUa3PS4UG38TgEUvbklwQFrutd86v/Pe9HjAnLzJrbhScRe3+U1RqlVDZCx/qK396l27MDX7SbaVC1ysOXdn4t6nzBXNM9T0aXEnL84ulJHQbJHwR1CjNhQtaR6fWXTly7DMspHkXIl8HWK8O8nGcerDqwRK9rXoWR5Ce7MFiPr00MmSRFsplTzfQQmZI8llzty+uKrAQkiqdJxjokVHBgQ4XNJ27lglLZulST9ejdvnjVpEqjWvVafDHaiGulZRK+1uPGSfE3p32w==;5:QdPtVIHHsPA0RAD/tyQ3y+BYsCMB758QVcxnJ6353INmM+jcMNuaN45eirX9AXy5fGuYG98X8GnXsPGM5HmjQq99qpe3s/ZBFdx1gm3bbtHE1l5WGvhGop/SxfegjYy9DPuWHTwwBR34NUGoFgOSpYaXKQpVZiPFTlyCcgWS+aw=;24:uPTYWMaYLRAibUKOJCBfTq+v68lj+hLQx5oQQ4grVrdpXmSAl/oQBmINMA5hTkVCfud2K6k79bqwsjswA0/RjK0Jc6EmvHPcC6653MI7kT0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;7:V7/DbN4T36yDYsWi8YDUeXhVYuCfbCv04PMW2EHacz6JBb+QBNjBnGw1MMtX91grf+iut5QE1t5lSo93ssbaT0TnRlOMkR+jqtT0maDCdgjYgaM4Lx1CiRVGiaXM624cTx128qoDbmLXxxwZ+VhPMbXWbtgMVM9E28L+IpCXT7xjIzLG8yz2YNBbt9zfvudx8XA1Pbz3UXeWYWhF6a4B1K6FuhKl+4hCVZBmOz+2bXiT6zN5mGwvak+ZVOSOQ5VH;20:aomVwYJPvj9cxaZC6yC56rPHJKQ+8YFmwiZODSD/btQ1/qcpSwiKI021rDD5CvdGxVgxVUvcIULJY8vPrt1vH8c0rqPI7DvTpUYNoOjGuXGWWqMdbZ/ZEMUKpNELZmX/7+ByeAo2+mBHHsqnyXdqxI/nFXmuZO+fQ2hzlMjS6VM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 08:37:26.8444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0118a1a5-e603-414e-2f73-08d5e5773500
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1341
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two pairs of blocks of code are under
the same #ifdef #else #endif.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 mm/list_lru.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index db679a057f46..b65e0b9b0646 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -29,17 +29,7 @@ static void list_lru_unregister(struct list_lru *lru)
 	list_del(&lru->list);
 	mutex_unlock(&list_lrus_mutex);
 }
-#else
-static void list_lru_register(struct list_lru *lru)
-{
-}
-
-static void list_lru_unregister(struct list_lru *lru)
-{
-}
-#endif /* CONFIG_MEMCG && !CONFIG_SLOB */
 
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
 static inline bool list_lru_memcg_aware(struct list_lru *lru)
 {
 	/*
@@ -89,6 +79,14 @@ list_lru_from_kmem(struct list_lru_node *nlru, void *ptr)
 	return list_lru_from_memcg_idx(nlru, memcg_cache_id(memcg));
 }
 #else
+static void list_lru_register(struct list_lru *lru)
+{
+}
+
+static void list_lru_unregister(struct list_lru *lru)
+{
+}
+
 static inline bool list_lru_memcg_aware(struct list_lru *lru)
 {
 	return false;

