Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AB6C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A81020878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Fl2FbIcQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A81020878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754684AbeGIIj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:39:29 -0400
Received: from mail-eopbgr80109.outbound.protection.outlook.com ([40.107.8.109]:49765
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754011AbeGIIjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:39:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLRI1ZbXDIsM4mT3fqIl8zagslsbg5/wFjDIaSeuzfk=;
 b=Fl2FbIcQcG+Wu0+AE5a7p9WrAOTSIEqrYzhVHNq1RKugtP/u5I4bGuTyTQXuJBRY3eike+DxxugYBmaAqNutdGekJQu52woQxjyZe5yHMuPOeu1ASfUfuUMu+q1v3mchQ1OjralfJ62KI4OZUVkAhk4OtsS8ZozDiS3ZnkZbDYc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 AM5PR0801MB1331.eurprd08.prod.outlook.com (2603:10a6:203:1f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21; Mon, 9 Jul
 2018 08:39:18 +0000
Subject: [PATCH v9 11/17] list_lru: Pass lru argument to
 memcg_drain_list_lru_node()
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
Date:   Mon, 09 Jul 2018 11:39:16 +0300
Message-ID: <153112555610.4097.2305461097830154246.stgit@localhost.localdomain>
In-Reply-To: <153112469064.4097.2581798353485457328.stgit@localhost.localdomain>
References: <153112469064.4097.2581798353485457328.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM0PR01CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::28) To AM5PR0801MB1331.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfa4fa1a-a3c3-4f5d-de97-08d5e57776f9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1331;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;3:Iq3WQT3WBSPQnizCsF8dcoswdh+kbdVvOhrHhlQXC1/Ps+NK8uwFU3/yVepn7NlAP+KGSIA3DR77nIZ+nDg3Y+Uvh47qgDr9e+5/0oFP4bU6hja+GJakPRVnKdMZKt6gon6rjZPu58pPNbsZJg9LPaRhr/Vk9CvBndXYbB6R8+keLQZflioKc3EmCBRKkadDPq6kAzgOe02XvX6fJp/p/s6Ol0EBBV6GFedJYyk7tSpc1j7QFAFbKW1ktRIrISxt;25:6jMgWqWsanUymqbpkXE9vrjXvaDNMmnfSSUgC6qBr41mFYFuya/OHZxzJqy8nPkeiPJYSdYvMMdr0IGuQ9NFK5IpQieAegjWF2z7d3WcRS7bamHUlWWh4GkqyDHOuj3oVFX5Yl1ESs5ZjC96DAz9HvVREFMQJjOEuOVjfXrYg/Bibj9BvmhaqXc5nc/BO6eQLTkGNlKsvQ7o82DsSUZed2P3pxW/+ID4lBfxW+YBTmMxIlOWbqLM9k38+QtPkfeAXG8w/HpMhH/wQsB8uQbYImfpFuJ93whH5Nt3uUm8xpF/UvrUpMV7Vt+rt1sA5WHwPTK4B/NzE76a5fTLvUZkqA==;31:MFgoRI3TpBoiEUZ2nkd95MOlgiegTOyrNlc5Icn1UoUhdtUuWNbB7ZKYR6QPj9xQiG7F8wjHKfizm1yii9P4PhSSn7NdY1gSqAnjAx1AFJi+xw78gRhAEWBPzUWdqoEHzRw73AeL1xsK7ga0BawuAT34WLN/hzHBAPQAfsRyqas+HrqBosXRbXKrYgvIpzrAI2niaDmjjkC+ojeiMqM0ey9f9tMUB0dR4gWbXrfNclA=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1331:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;20:nDm1Smmsb07bkrwdlu4BpZZ5CZGCaJ4q05KZXEmtZbqui50GRU0QmBwMDP8befIkVr8lEmcg16XJeDFqqerDN2h05c6HpmNH3QgTofza3VG9Jq/l93NMjjgiAFcbIzzxBFdrwdRc3QRlqGpGSTnBtingxVYFehl6IoGsdUk5SJycU+KJaTTL6PbIGy3EGxWQZzfXUBf+JzZUx8MDtosUNxfGj5meU6Zc1liL176srCTHKzMbp4+9kyqfhKjGkh5VQJOcUclTPQ9lMLy9PfandOkoMH8gDGt5bxNjzSvF8UfsVs/3SjvewlVyOnNJs8ogpcnSdP48c8dLXqqDOBjtsIFTWjAgCLIpmdiu70EUSnySSnqZGzngMo6mNFRL0bJulQL3pFBCZUx6sc0K/rn9gT/nP5XshCs3XbyQhxpF23lLbkn1o0vPtHLQglxhsRINVeHKL7AqdrGx+tMF3K0meW+9BBgAjflXZAxx+mureQWkjl92VXWVFfe7h9cLolI4;4:Q9Urfiw9ZxfuzQFU4/0IoOuQsfEyrGZq8s6cB9/iJXkLth3AoYDNZxG9pR4IuNvIyUCbWY/JJXi5UfCELwXA1Exf5NdLR44CWCs7oU7e8cFk/cn2wUTJZIgGW1vXsc5Le8QIFX2AR4tDLMaGBRESitHFA5i7y2QLV29O4WM9rG0tJujxw2my+qttXEzk6va8Elu4bCotg9qITotNIVyyeZ+V0S1PXzA20410Cn8ybYXwGJeNxowtI1LQxW/WJGi90bZjsMF64mtdk/3kjhNk9907VhRbZFUBhjhOjW9oIFp/Fk+ir0iaUIl8aKfV4HxtjEJPqnaph+rIy+FnWKB8pUGofBQNyUwxbxNpecgGFhUTIQ0kWHWt8LtI+3+Qi88Y
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1331DE89FA69D163300DC6F4CD440@AM5PR0801MB1331.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1331;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1331;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(376002)(136003)(346002)(39830400003)(396003)(189003)(199004)(81156014)(14444005)(81166006)(61506002)(66066001)(8676002)(230700001)(97736004)(3846002)(86362001)(6116002)(9686003)(25786009)(8936002)(47776003)(316002)(58126008)(7416002)(476003)(53936002)(33896004)(386003)(6506007)(52116002)(11346002)(446003)(2486003)(478600001)(7696005)(23676004)(39060400002)(2906002)(55016002)(486006)(103116003)(50466002)(305945005)(7736002)(105586002)(106356001)(26005)(68736007)(5660300001)(76176011)(16526019)(186003)(956004)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1331;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzE7MjM6YlNjejRIRU50L2x2NnRlSUNRbnVGVTNZ?=
 =?utf-8?B?VGdMSno1Q1lXalB5QmRyUU05WFFXZ2xiUDA3bHMwYzVSRGlHR0pwMEFSejRy?=
 =?utf-8?B?ZkRqYmN1SnJQTlNyam41cnBMbm51M3orVVdxSkFlc2JLMVZzMmdYSXpWUzZT?=
 =?utf-8?B?OVJPUDNOR3QxRHNOaXlWYWs4Qkk2N2NJcFdzREtpQmtOUHhUWWxIR3VzNmpk?=
 =?utf-8?B?QWltcng1NXdPSkhkandTQTROcndreE1KVnZrZ1V2dGZJTHlDelZra1Rva3pL?=
 =?utf-8?B?RTgzZWZUL1Y5TFdEZWRZRlhsRzRkMUM4Sm1xT002NkNRY1Z1WUtqaUtBOG9m?=
 =?utf-8?B?K2FYVXlTRzA5eURMMTdsYVBIN0NobEVtaTI1MTkyaDZndFBjb1VHR1EvT25N?=
 =?utf-8?B?N0lHOERuVVNNOWRSRnFhVjlYMmZ2U2VOR0tMT1g5cFB3QmJvdXpITk11THNj?=
 =?utf-8?B?R2lzTUp0bHE2aXN2aWppRDlrT3ZtMUlyUnpWQ0dPWktKczNnTnRWSTJwK2FB?=
 =?utf-8?B?eUJxaU9oR2FVOGRhdU1adlMxS1p4Q3hqRmpUM1AzM1FLSTBRRUVnVjIwN0pG?=
 =?utf-8?B?Rk9TUTI3amZKUkZNOVJoKzk1VVM2aGRMWnErQjRWNTBXcHBWUU5HQlRGdWxy?=
 =?utf-8?B?RXZmZlkyVGFNeTJKWnFLS2NEU0ExQUJHTFhUTVpwZ3pQL1BTUlVtUWE4VDBD?=
 =?utf-8?B?TDFaeHJIdFoyQUZ5MGJWckV3NVE1U0w3eHFVVE9UR0xITVRXaTludzdReDcv?=
 =?utf-8?B?d0hrcXJkZ0lQSkdKdkdoWStEZ1VyaWZ1alZhL05BRDE5M0g2TkZ4OHN0MU5o?=
 =?utf-8?B?SlZiWmw2NkpOdlJhOFpFR3JpUXBMa1BJQnU4cHZFSU5vakdkbCtCYlVHVCsy?=
 =?utf-8?B?NUtTRG1KV1dZVmhsc0plY3Y4MStUVzJjR2p3ZzVrYXpOOXk3U0MvQnNkbmVG?=
 =?utf-8?B?cXNZTXRiMGY5NGRpQk9rUEdKVnJldzc4Z1RON0hxbTUvZnBaRFQ5K1lTMmRP?=
 =?utf-8?B?K3dNem9HZEtIaFB3cDJIZHNrWHhZSGJxZGMrS1dvbHhCakRSU0RtZDVMZUxW?=
 =?utf-8?B?cXJEd0hCVFA4RVExbGEvc0tUTG96anF0ZWNzS1h2ZTQ3RGV3K0ZzWDhVSDBJ?=
 =?utf-8?B?Q2wwY2NldDloU2ZDUy9SOEJ4S1dFbzFHSTN4ZVZ6U2lRMTQ1MFAzUEU4OUg5?=
 =?utf-8?B?Z05PV2pPM1VyQ05WTG1HbkR4MWtuQkt2dlpEb1JWZTBGLzhTNlczNnQ4Nkhp?=
 =?utf-8?B?T0lQazVFZzR0bEUrb0RGQWhQcXVFSmFmWEE0T3pWYmlEYVpSdkRoQVBINzVz?=
 =?utf-8?B?L3NMQ1YybkxIUkhHOGdRemhyK0NvT2ZBL3VlVFZzVzZGeG0xaHUyQ1prcGdo?=
 =?utf-8?B?bGt4WldUMDNMSGV5Q29BVHZwN0tXM0oyMEZ1TkYyNE5CMytWSWJvVVYzeHda?=
 =?utf-8?B?Sll1YjkzWmRyczh2YkNmVWRVczVKNXV2TTY5eE0vWnBGZkk1UWpOYzJGak50?=
 =?utf-8?B?emlxR2hCaG5vMS96S2lQd1FoWTBQdzJha3ZpaU1LL3VoSmlsMnZDMHZtaXVn?=
 =?utf-8?B?NGVjcGxPOEF2cTRCalVib1F4SnRqWkkwN1dJTHVPVmJLNm9kYjc5WGpKUVZR?=
 =?utf-8?B?YTZ0ZllhMGJMMFlad3p6ZW1nSFI3ZnNpbEw4ajNaR2VrNGhpRk1TU1BSSmFr?=
 =?utf-8?Q?jVMYN7dkbCZ+851qf3+E+gBTVa4hzXMW6brcDauwW?=
X-Microsoft-Antispam-Message-Info: uRZyhZJr1Whc/s1Io5epQV9mYSsMn9IyTjx/IRMUWijIMyMBtSu5LrB5FyWOppdna2/2LR+s9gmNRp7mR0j0+rkHILgSQ59d3NWJAiCRFqIgo1wd70dCrCkJDsMHBM/8lfmsR8uIRdlsmw2Lcfd/i9ruohsdqMeJr/HN8KG8bw57z93bkwtG1yg6mTPEPfF4IxNQsuvphUdYBF5SP5dsbiI3a4jACfHCPf0aUZPzgleiKlaQOtPUxpYurVP4O9M5piRc4GLrtugJ7SMqzXxhSScNjScXJOjzYK0e/a2Iou0UAMkBz1b8Z1XYjtItPjAmQl28PwkASTwy4tWfjopzkJR7HN4F0m1K9uZptuZGJIw=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;6:ewDS6+StegMmhlCJwVDd3iVZ/uYT3evTC+giOiXP/Zhbf3NlyXE/XG71X2qoc6fGZppWWSj4+urlXr3NNJLq8EkayI3bHmSMP2CopT56BcBxZKozbnBwLGmfkAgOW+WWCvnXJdslEIeYng4dp3uPG7I2qwgJAJqOevGhAjCceFoZx2ePCXjvLYYUE3SsI/o9wiariAM9Rbxg5vJ9B0s5hQD76ha89wj7L/Kp1vXBkLDX46kps2FF0IrYCnv7KRhejT/XCeLH3khMWs8rAZWz39nIZBbZ4NdYgYUBNByvXM/G0JOkZFML3oim2gkYO66Kk/VZj1va8vRebLy6pA9u5A0dz++Vi0DYWl3OOAf5hjl/fJlaQk0oj4NTuPLD/hswDAw4lS/2EBzE/KWK48E7bYCmSm5PaR5BNnBEWEj+hBaHca3zg31ctn3t1sk/L6IP4LsuUKlfE1OqhWA2RLfhsw==;5:xJwywPuExb3Yq0JUVgIYpAm/Xt/EBN5Ecrgiu8Kg9YPYv0v4a8b3vMQ7+dwk14UKbpXQR2Okk//zT6v4IekILJYNKbSwWdLCxxRPapTtRoR7TcXCBKq02aNBr570vPoS1k5bBUWy35dXOM5z2Nl0sBX2NMvEZU2x37WvXO5wh+Q=;24:v9V0nlylC8XMfrLtEimrTqq8kJnL47EfMvlOi5CUesaIdXAy5IObPQVaawwTuHjLSDJEFrhlUvo9xIdFW3NVIeer/7oT7gOHvLUCrsbFj5M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;7:g3iIGp1VWqfua8vh1hC8GnVfZMtISp2/nLxuALcFjZqBubWSxscLSYqy9pFhI/xe+qnAcnyGDTTn+x20NA/Tno+baonbNksKuGU0ufyPTJuamrkUJLtfdhkG+JaHYwopyuUt3U9I6Y8zhSsk6BtxR8+ohO6kAUgaiF5R2pP6w6cRCvN2hXECRnwYuIZdTpRKuUlvJhMfgJuQdHcyKs/CkPWtAYyTpT/L7oOwyVs99zdsH+FFbTvlGO2Gk96LpEuD;20:lECMZqkmxiPf4nOtGIYqvsDieZ/4PlZHR0sU+hz+BfXz1o4KPj7sJGVPEao+poJiL9XUCtWJjWTnnlXIcUcrOvtNcZAsYIlyBDcMa5bzm9oTLAV40wYZT4ywgbbp457TLghI0lta7kEmp+VpgNsxo/bDy767AuPJ0uQI1TEa7o0=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 08:39:18.8197 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa4fa1a-a3c3-4f5d-de97-08d5e57776f9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1331
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just refactoring to allow next patches to have
lru pointer in memcg_drain_list_lru_node().

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 mm/list_lru.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 5384cda08984..c6131925ec76 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -501,9 +501,10 @@ int memcg_update_all_list_lrus(int new_size)
 	goto out;
 }
 
-static void memcg_drain_list_lru_node(struct list_lru_node *nlru,
+static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 				      int src_idx, struct mem_cgroup *dst_memcg)
 {
+	struct list_lru_node *nlru = &lru->node[nid];
 	int dst_idx = dst_memcg->kmemcg_id;
 	struct list_lru_one *src, *dst;
 
@@ -532,7 +533,7 @@ static void memcg_drain_list_lru(struct list_lru *lru,
 		return;
 
 	for_each_node(i)
-		memcg_drain_list_lru_node(&lru->node[i], src_idx, dst_memcg);
+		memcg_drain_list_lru_node(lru, i, src_idx, dst_memcg);
 }
 
 void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg)

