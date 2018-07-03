Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BD6C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B8A21A89
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="eoRbMdGL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B8A21A89
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933739AbeGCPKK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:10:10 -0400
Received: from mail-eopbgr60125.outbound.protection.outlook.com ([40.107.6.125]:65255
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933177AbeGCPKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMPtzsojoekgXneCfcFzOGmVnQ9EeB+30PcBR1e5KmA=;
 b=eoRbMdGL8I5zRW6y4Ab0vH0w+Di1Y3cH5n25FQGiOAAk3CtaAjA3iZZ9Vcq3y7ORh6qKqpurIYQKUIL7flRLlyIMQDED6QqhNccuIdoVECay3ncC2qZxKxKhjKwr89t43r9wdNsPcAU/Mk/BZYcoEZg3pv0n/TV2HopfWiw4jQs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 DB6PR0801MB1336.eurprd08.prod.outlook.com (2603:10a6:4:b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.24; Tue, 3 Jul 2018 15:09:59 +0000
Subject: [PATCH v8 08/17] fs: Propagate shrinker::id to list_lru
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
Date:   Tue, 03 Jul 2018 18:09:57 +0300
Message-ID: <153063059758.1818.14866596416857717800.stgit@localhost.localdomain>
In-Reply-To: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM0PR02CA0028.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::41) To DB6PR0801MB1336.eurprd08.prod.outlook.com
 (2603:10a6:4:b::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef02d6d3-15bc-4efc-09fe-08d5e0f70c66
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1336;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;3:8kXYxEFNpLoFlh6wE66Yth0sbqeFIehJr/fuj4cEfA0gkFklCMgSmIPdKolS3mpVF9rt2N0zSy5EhPpTtFgs+J0RNfva5xtLYLoqyWlpWYf9zei/YRgKp4rMDWONDxlk2pUdh5ox7acba0vbhv/4h5Wg0xS9NSy0oQolGnefmFcg6rcQWTCRQ9HfxYU/rfMbll+N3soNZRsBW+ADMDw2hVsoRRewCqVmo76LxHcMjgQ7mUgAjXb4JrtRRRbAkgQU;25:EpEnoxcAZMcxXL48K8rL0vBIJo75aa/S8U7e1qThu1+bhov8dbyoNKTaGzQ5f6A4UOMlviGpwOPwjLhE6jErtMZOnLgOABtX/cujnNjqBAKQFCmj4j7jBIFekUIJzmZW6RHLYVJ6TlHiyL2hHPKsCraQAknSDwSIq0FjCBAD0OvTyArX+xB40CIcqCmMUFjB4TRaNG5afSnPiHIKNeg59g244acDAPkSPQWvv27YhlPD9MwlBWB1CXyFlZWyty/BSl9hARmaNWqmsPZ6q2U+D1J9wd4PJLfujHO86jUA1VLsP2NIebUU1uoSxbYLTPbrSDfJI6VW7051YfcCocx8Yw==;31:h20K/1Rc82hxYPGvy0lej3Ua6WWaBb3w+q3AOXh2RLbmsl3wgmTucWRrQtgibyH0ssIpCrFwVPAiKGonhLntoHLAZXnrvRuRXzJGwUdSxH72WmdM93LO5xC1ujK+YLLaQ0U6bNA1iJowTRqCU32N+nuxIFqeyTH4LE4YQF+rett1PDLR4YDdCixMTrlcx8k0C74xXomFsfoAJir0krZTeZSLzfbcA/XalRwJ2nQ+dKM=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1336:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;20:tDIoR3oaX1uKzV+zOXwx6DmKHVt4NboDRMiNyWCtXQitF7juVLY7XbhO3jj8/5kXemaqI9KRxLzunDqWBMxTMqaTkZwykFA8B88dfJRcsS8wKmAX+1BuwoAnRY38+/kpn8qK0Bh6SgHH2+Rne+sNvJRnQvzvK1V419DVI0N7CBUozLhLXePrLWet/xKncEC+ohwMwS88yHjJFkmrczbskR4khN2aeYxj83vR0AxjXl1t02G05QMHxYweVDYsC26YIK3iG41OaGspHEF44K1y2+/2i+tVK/sceD3lfMBtNyDBnC5+ejHmmZdajKcoKJilel1ryIenyH+NNkYT6TVZ1ZgPumowmxVFwbPUaB6syOxPVCmm0teayP3MuPGMVdG/wGSQRoEXrWo+JIh8OV8IFAEyE3ojkrSwEu4iVr5Pd6PVT11OLFrdAFDeojkjvNT8cGBgreeEBf8s+eqB9K726JCKMwGwrjvTY0cD/BOfV44daj4RfK/TTbUoYkhnUSMZ;4:j+s/ioJ79MGyI4ux/DpH5DqWhSMSpQB2C5YOdpFbqJ6uk0oxtT7D32yWfLNRjM7xieje9k4CHCQeCIaIppY3O5ZA+YYp0PCUeOSGrccz6I7vHDJKFcQeeeR3AqLjnVS/rney25bpANXKqIv7BRlcUoGx3ojYB2OOzbpNfbiO6xRBJM7my6OPpgKzoQZY65qm8WmIxBLN6oxp1QifJ9OMO3O+OlFiA6npJAhB/UwTf7JX2Cj39i42SzhTEgKAbZQiUcjSBdbBeMkqKzaP5Z176et8smtqtjTI1oEvRAi3kpPklJ4yOcM0LZMvkPvc14JKa5JPoLA4j7FzrdPXR/sL77dx9upkaNMtZnj8bJKwwEFfajH8AeH3+YDeND/h89C6VJ16UlycHSQgtK2gzj1jYwOIHmk8DbcspFftyIMT7WU=
X-Microsoft-Antispam-PRVS: <DB6PR0801MB13363E641EB6DCF1E3ECD9C4CD420@DB6PR0801MB1336.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1336;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1336;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(39850400004)(136003)(376002)(346002)(396003)(199004)(189003)(478600001)(26005)(16526019)(2906002)(23676004)(14444005)(103116003)(39060400002)(186003)(66066001)(47776003)(2486003)(7696005)(53936002)(55016002)(52116002)(6116002)(105586002)(25786009)(106356001)(3846002)(5660300001)(8676002)(97736004)(50466002)(68736007)(8936002)(316002)(956004)(476003)(7416002)(81166006)(446003)(11346002)(230700001)(61506002)(9686003)(76176011)(386003)(7736002)(81156014)(58126008)(305945005)(486006)(86362001)(6506007)(33896004)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1336;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzY7MjM6SVlCZnZ1SGdBQVdncnJUMGxGVjJtRlF1?=
 =?utf-8?B?aEJHbDVDbUM4WXgvdzRVVmszNWQ0OG13NFpvcTRWcmNHRlNpeU9ncTJINmMw?=
 =?utf-8?B?UGhIY3EyalNHN2ZrYUJZbTRpV3FPbVR6ZVQrekhPU0oxNmZjYjQwa0R5Wjla?=
 =?utf-8?B?Wm9oNE0xb2dQakQvcVF6US9WTkFnWUZuQUtqTmppVkY0MkdYWWVSakZxWmFp?=
 =?utf-8?B?aUNDTGUzOVZNaVRBamhnSTFyNGR1YU10VnFDZWlZUVI0WEE1YUE4MjhseGVU?=
 =?utf-8?B?MlFVVkF3Y3ArNVI1aGpxTG1jR2Q1Zyt3aEgxQzdiLzZDMDBIalBvSTIxemVU?=
 =?utf-8?B?QUZKTm00aGYzN1BZSFdRblZSOVRadnl1a0hZT2VUTjdURHZDRjlNdExmcnd1?=
 =?utf-8?B?MUI5djdyamc1dTVFeEtJSHFXTDVrOHpjcjVWdkROM0NVSlBUV0Z5SVQyUHNR?=
 =?utf-8?B?S1N2UHlKTDJxTGhZYlcwRkI1eGd3cU1QUWhXdVpNYXJvRitCU2tvVk9ENWJj?=
 =?utf-8?B?cit6SUYxN3RXSFpOUW92d2lTRm83V1ZoRFZXa3VkRmhNNUd0WTZHaTgyRlR1?=
 =?utf-8?B?T3RrbE5UQ0ZsNlJFbWxCaGN1dERNcmNYVUFrNDdVanFQNWZGOFJIMXVqTjBI?=
 =?utf-8?B?b1JqNnphS1cyaWlNZnBxdkU5ZmpqcTJ0R1ArMlBHU3NPazVnUkNkaDFtY1Z2?=
 =?utf-8?B?dVh4bXZzVVNYdVVaUmtFSjR4ZllVMG93aG9JRnZwSUZZRW5YMFMySnc4Tkl3?=
 =?utf-8?B?WCtJdk5JekZ5czBQTkJDWStDaHNudlE1YlRqYk9OSVFXWHUvOFV1ME0vdWIw?=
 =?utf-8?B?d3NEK1lRKzQ5ZWZFYUoyeUxDbEg1N09OQlZSaWVqbHJNSm1hRy9EazVtT08r?=
 =?utf-8?B?TnR0MEprZ1lpZUxwTkUzQ3pCNm83TDdQOWFXaFQwdmFhbEovc1B0Ly94TXA1?=
 =?utf-8?B?Y3k2WHB3Y3d2Z2ZXOFJzQ1I4M2VsZkdCOTFSY2hpVlB3SjRYSzlqZnkvMExJ?=
 =?utf-8?B?SXIxUWdQc0xYUDlEKytURjV6cnZxTFRIUFV1Y2RKT0ZwNk5hdVU3bnNRamFE?=
 =?utf-8?B?bXZhMW84dUNJS2cvdG1OVUtSUUQxU2NHMVdsd0FMTmtVWElob2tNd1ROSS9n?=
 =?utf-8?B?aDBmMTBIRUhqOFJWakYxVGRGR3FQZHhLWTRqWUptMnBPUHZhK1JEa21iSllG?=
 =?utf-8?B?TFVVczZyNTg0UVlXMmovWFVwaVpwb0FjVzVmV3NDMUdKL1VBeU5kUU9kQVZS?=
 =?utf-8?B?d29QUzdDTFhvWjRoYmJpcDZvV1pnUTlEMDFOaUtQYVFiekZ0WGdQTHowbE4r?=
 =?utf-8?B?L20xTm1vWncyejRsc2ZlR3pNRERlUlkzS2VBbDJxSVM0SkFQWWV1aXFkZk5U?=
 =?utf-8?B?bmYyQ1FUVjBzT2pVanQyS1p1L1h1dEptalR3MnkxZjlGaCtQRUpIRjNNSENH?=
 =?utf-8?B?UWozVTJGK1lxbHZIRzNYM2FmT3Q3RkJwRGp0b25HeWZIdU5UY3F1cjg4eXNI?=
 =?utf-8?B?akU0WGVWMlBtS2hoSHJTSUMzd2xpUk81OXRRME9BZFRxVWVEUi84NEhGMzZm?=
 =?utf-8?B?b3djVjExQWZQaG9DeE1TUlBNanAvUGpSbVRCTE9JSHNUMzhKZWlMZHN6T1dM?=
 =?utf-8?B?VkFOK3o5bFB2V05RMzlQRi8yb0x3SFZ4a0FHcWJENStSWWhsdVBraEJ6cmU3?=
 =?utf-8?Q?YxPIr5aQlCcyuUPGboPTcwFiVA4NNT8JlE24ZQTxq?=
X-Microsoft-Antispam-Message-Info: aldUBXyERtCmwFTkJca4beDhtJ+c0XsbJDWMfHElYqEArWLQkXxMjKENpE/A4bKQJKqpMblKisrfZ/uauzR21ZdtXb80EI1ZIdyf0qVuYuk96af6HOx6I4xVUC114BRvx8/gyo78tZhn+FAJd8rgL8XZSfUfpfedz4TuQxZnTzM/35mIHZ/NhlXO/E01B368rwcsrvi4S3pFcopgDBx8dyDWIn4yEh3bxpJswY7/NkCzq908io/zeceL/a4OBbOel6n23I1TFhHoQS4fLI8o1QG6h6EaXEB8KqB5b/kCvdxc1E+Nm1qKYSkHh3Ct0otLabjLMYheOBnf0+KAAAZeRhhUfRkJR2jgCtQm0aWO8rI=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;6:0baJFYSZ9Ff9trwG73kiCcSIlmMr0vACZSTcbskxVLX3o8oavyed6abDJHYnmA9r8ONGlYqWJBJHTI9/onNReeMbykxRW6s/ldFaJBHyjdx++7OqBXbTRWx0msQn4uSOzGZaE58GUGkCLK/ao+hTZab5ZXPpW5QlIGFgOwCgj89idEkg7IfMivSIuUuaBusDCqqtK3Ip6O1Ju5/EpRYPNtljr9F6r2pPtQbZHWGX0vteHKBq1GWs/X5PDCbC4gjZNoRSeWbT8C7tYXPkeTaNZLGAcExXExwJV9gz9Lref9xDLR7ouEC4N23OhM8vkXurxHjbXKsBd2ZPDsZo7jNrhzzSMMYkKqwASay8n0svw7sJWl8Td26IosYMVTQ7PQHZw6SRR1BdmR8loIPDc1izZLpiu6Je1pNkgY68U6/ThuphM+VUJ1QB5WYh6Z7Kt97WJULZp/fDtAoNy/qOrsST6A==;5:f/0YFjLDZPoPCdyrDvH12AzCsYDf7OfyHVJPeFlPAFGyFkkWasJXmyZ+/VA8/DI6poZdW9VE8dnoSL4wxA/Ho5UYQ7zH6u7QwRMm2oObnCdg3/zmnEd1CRj+eefbnJMwSUn+BrbjcnrChtwx9kv4uyddk6UvVFaVTmSTjpQDyG0=;24:oKVJUqQUzsKNxOjgjLNF1RghkKVxZoJKaNo5R6p8d+J8Fc0RXGsH4SCmohAdYSiuzuRlJgn72onvBIKxfXDdr/CbhT26qyrn5Iu5M8rc1+Y=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;7:sE6jyPDJfP3g+vqb4Q4TTIGDGZ1VQXYeIMvZtYdLcPSZMbtLH6t6USck6TsVUFJjQZESoYWXLpk+1pChBObHht4zFFgjzvy0ujwokQ5GsEG+GcAoFpxP4hZAZbKIxA16rYQoqZTSxh5p+c9NHks+YBvesx48lX0bRr6AyqeajQjDhXM9PVqojl5qBMPTqgBIdoFXoDxL67F9gIpxxrN3jFu/xyK6oOpciGxcRvbUelO1AM/Iso9h6Sa1ZQhK9YAd;20:VH5RY5uRe5D3pQeoA84yhnofNdeG5Mff9N729Hh1O7nr3M+kCbqLR/s0kozb81iyBGung+Tm9Uqi4ItsCMBrm+80T0KqbtIMzooFJtiLq34jJUhuKhlQSUcEouMmYsfvwdlBgO5yNiPSBdXVh4fHnum9FKQJnaAeHvJljhC2IDI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 15:09:59.3985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef02d6d3-15bc-4efc-09fe-08d5e0f70c66
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1336
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds list_lru::shrinker_id field, and populates
it by registered shrinker id.

This will be used to set correct bit in memcg shrinkers
map by lru code in next patches, after there appeared
the first related to memcg element in list_lru.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 fs/super.c               |    4 ++--
 include/linux/list_lru.h |   17 +++++++++--------
 mm/list_lru.c            |   11 ++++++++++-
 mm/workingset.c          |    3 ++-
 4 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 002e46d874da..f858178f74fe 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -260,9 +260,9 @@ static struct super_block *alloc_super(struct fs_context *fc)
 	s->s_shrink.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE;
 	if (prealloc_shrinker(&s->s_shrink))
 		goto fail;
-	if (list_lru_init_memcg(&s->s_dentry_lru))
+	if (list_lru_init_memcg(&s->s_dentry_lru, &s->s_shrink))
 		goto fail;
-	if (list_lru_init_memcg(&s->s_inode_lru))
+	if (list_lru_init_memcg(&s->s_inode_lru, &s->s_shrink))
 		goto fail;
 	return s;
 
diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 5d7f951f4f32..c4cdda4dffa0 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -54,19 +54,20 @@ struct list_lru {
 	bool			lock_irq;
 #ifdef CONFIG_MEMCG_KMEM
 	struct list_head	list;
+	int			shrinker_id;
 #endif
 };
 
 void list_lru_destroy(struct list_lru *lru);
 int __list_lru_init(struct list_lru *lru, bool memcg_aware, bool lock_irq,
-		    struct lock_class_key *key);
-
-#define list_lru_init(lru)		__list_lru_init((lru), false, false, \
-							NULL)
-#define list_lru_init_key(lru, key)	__list_lru_init((lru), false, false, \
-							(key))
-#define list_lru_init_memcg(lru)	__list_lru_init((lru), true, false, \
-							NULL)
+		    struct lock_class_key *key, struct shrinker *shrinker);
+
+#define list_lru_init(lru)				\
+	__list_lru_init((lru), false, false, NULL, NULL)
+#define list_lru_init_key(lru, key)			\
+	__list_lru_init((lru), false, false, (key), NULL)
+#define list_lru_init_memcg(lru, shrinker)		\
+	__list_lru_init((lru), true, false, NULL, shrinker)
 
 int memcg_update_all_list_lrus(int num_memcgs);
 void memcg_drain_all_list_lrus(int src_idx, int dst_idx);
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 6743cdb76ea6..f8ae4a04ef36 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -559,12 +559,18 @@ static void memcg_destroy_list_lru(struct list_lru *lru)
 #endif /* CONFIG_MEMCG_KMEM */
 
 int __list_lru_init(struct list_lru *lru, bool memcg_aware, bool lock_irq,
-		    struct lock_class_key *key)
+		    struct lock_class_key *key, struct shrinker *shrinker)
 {
 	int i;
 	size_t size = sizeof(*lru->node) * nr_node_ids;
 	int err = -ENOMEM;
 
+#ifdef CONFIG_MEMCG_KMEM
+	if (shrinker)
+		lru->shrinker_id = shrinker->id;
+	else
+		lru->shrinker_id = -1;
+#endif
 	memcg_get_cache_ids();
 
 	lru->node = kzalloc(size, GFP_KERNEL);
@@ -607,6 +613,9 @@ void list_lru_destroy(struct list_lru *lru)
 	kfree(lru->node);
 	lru->node = NULL;
 
+#ifdef CONFIG_MEMCG_KMEM
+	lru->shrinker_id = -1;
+#endif
 	memcg_put_cache_ids();
 }
 EXPORT_SYMBOL_GPL(list_lru_destroy);
diff --git a/mm/workingset.c b/mm/workingset.c
index b16489c60471..a682306db49b 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -511,7 +511,8 @@ static int __init workingset_init(void)
 	if (ret)
 		goto err;
 	/* list_lru lock nests inside the IRQ-safe i_pages lock */
-	ret = __list_lru_init(&shadow_nodes, true, true, &shadow_nodes_key);
+	ret = __list_lru_init(&shadow_nodes, true, true, &shadow_nodes_key,
+			      &workingset_shadow_shrinker);
 	if (ret)
 		goto err_list_lru;
 	register_shrinker_prepared(&workingset_shadow_shrinker);

