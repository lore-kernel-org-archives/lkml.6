Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA64C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739E820652
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LVrv00EQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739E820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936068AbeFRJqo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:46:44 -0400
Received: from mail-db5eur01on0129.outbound.protection.outlook.com ([104.47.2.129]:4989
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935940AbeFRJqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6leYxXL9iW3gR1cD0ZX1WFj206W8I3CyLplpPKLVeE8=;
 b=LVrv00EQI10tdCpDWd2BxyZTzb80+DL31XlzKYYEjfndy6rYk6JTYlbEXp8YXw2fPA099QD5QzSJOEQgCqmosiNIHkfwYPSyVMkqKMpX5D8YRN3mnwet3NUzEC/DGq2iGD15cRY45FSezLYzpzqwqgHC+AdK41V4KKm1nTIYzWs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (195.214.232.6) by
 AM5PR0801MB1330.eurprd08.prod.outlook.com (2603:10a6:203:1f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Mon, 18 Jun
 2018 09:46:33 +0000
Subject: [PATCH v7 REBASED 10/17] list_lru: Pass dst_memcg argument to
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
        aryabinin@virtuozzo.com
Date:   Mon, 18 Jun 2018 12:46:29 +0300
Message-ID: <152931518976.28457.3042342901552911633.stgit@localhost.localdomain>
In-Reply-To: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
References: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0902CA0036.eurprd09.prod.outlook.com
 (2603:10a6:7:15::25) To AM5PR0801MB1330.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6d2f81e-4ea7-4235-56ac-08d5d500612b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1330;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;3:NoScYBrFtiqHkhqFR5Yi5Mf1IpEkCzg2hP3yCQ/BFsSFrnnIEu8i28k3SI4mLU93sXTGUbqQ7UImAv4PaPoaZTYT1hbb63z3qVI0XwuaA07myxsBhzzHf0Si2lb80JAGRCI6zcd3Jqto+EOqxqG29E+I4O1URZV8cyry0j32KR+MTmB1IDQIG1ffBqfxGCWlLhrr4+Pivy4/YaWrJVpmfU+rZhF4joErqp+AF/is4dUUqmjNll6Me5CeGZK5LbXd;25:LZ9+IZ7qapJmlsgSGlGJj03BKWwQYN1EN2dxFXyVfd7Qmxn7DjcENFhRfaq89o9+BWIwyrJipfIVQr+XDhAdk782cCQ7DMcvNBBijh5uJvQ46aUcaFW7jgzdlCJFE4XQlu1YKkZKk5yzXMDW3zG09P/1dCh38prJBVk1D/hKqcQWZdmHRqfDpdXZLxkgVkhhPHtPrxAx3R5Z3oXl+ma8kD2AT/fxGDlrTP4YiCtk7D5hnQ6CQqGl9BL1U+6gJ8l/voyDbLyomTqh7RrTt3skaoSuGuFqpz8Ydz5/3MKOn0AXV9qJsZtzCpsplzJz0jLpu786mX1glwbjUoA2RKwEIQ==;31:RAVVMYgc0b+yO6U3jbeDVfdKl60xRfUv6cPIS+YFpsi/70a9R20I3oy9QrQUXHB8wcehXokhGc7RagBzAFhSX/I96pbWmWWn7A1UYYlPVmapToN7JWjJDwoB3stylskC1T0P5I4SQZpmpUwomlqYC9DBdDIS/1tsqeVtUeK4rSf8qnbPjgrIe+tKz5DOkUEjeK3K7v9+OXT9H0NRxoHJOH3tTcsPM8T2jEEWaW+DdH8=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1330:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;20:o5FgHMoh6JUsg+nbWSyXU5twT9+srNVvW2MS9MNE0DuICtmIpFY8Ljcu0fLW5FVNQcTERdt8iKtyfiw0a+1ZOPeuPEjy0UO9+lDq49PKb9NdpXlkCvLyrQP1SwSaVCcHjExhr7wkeNcWqC8oKmyO2AU98+sFspufVXAiCt2ixjStBo0yVO88xsHLJPdSnc/FucZHV4kLQp8/neqRHnNNDWCRkkHD3JmZPVsDQ8ebTSOmZE7nQFFErlf566867VoY3n8i3DPC9iHO7OnjTXdnLhw0mYxbad61lO7Cy+F3/8SG6T1wbIayCVgDaaoWByRLsoPl8S/+ijOOAredPabf/uBuUYGxuSKfEqJ9brFcShAbSWXQ7QX/CzpeI91l2DIh07kuTof43/RA8Ol8ou9/wgzuJGtdX5WSxlzp9mDqWEB4WD0Fwg7z6bTsM2Qz9w2KngDS4MoZhnfJFh3ssLwJNkHK7p5GpH2NotTH4rI6T4QTTUeI4m8HmRMt4d5DxbM2;4:eSEdyx0+EBVe6OylUi49ZYnVpizUNbu+IVQhyLaeOsYPSo6BD0A2S3Eawszno1LXtbVtaqJV5g2FrIo10hlsmOgr40TWqhEAArog0HZJkw83JKKW4bkPIDM6CaZxLana2X+hxay7PRqr2OAJx7+FUsfFUZr9PJsA43IRceNsrUiVB8A/0nPHmS6ZUmuxjirf7LyfGgBVm50X08UTpNs0jQwenZK+k4XkF1eILKnBReT2feXUo2/hYup/DWMRr2rkwH4CEX9VOkTIhf3HW6Ymfda540dlhsFrG5yiGU36J0WGu0pFk8hgUMczE7Rp9rD+yvACTLlX5JUXL7advZSwN/U7sDFB/62SYbxgVzTTE0yxPY7vGbd+MgxJ6t7PVr7n
X-Microsoft-Antispam-PRVS: <AM5PR0801MB13305BCDDE78164F11094B03CD710@AM5PR0801MB1330.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1330;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1330;
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(366004)(39380400002)(346002)(39840400004)(396003)(199004)(189003)(3846002)(6116002)(305945005)(86362001)(50466002)(103116003)(2486003)(97736004)(47776003)(8676002)(81156014)(81166006)(8936002)(478600001)(23676004)(7736002)(230700001)(66066001)(61506002)(76176011)(106356001)(16526019)(186003)(316002)(105586002)(446003)(2906002)(386003)(26005)(956004)(25786009)(39060400002)(55016002)(9686003)(53936002)(7416002)(6636002)(6666003)(58126008)(6506007)(33896004)(476003)(55236004)(11346002)(486006)(59450400001)(68736007)(5660300001)(7696005)(52116002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1330;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzA7MjM6N3hVd0ltbWZpVUEwVTJhWC9leSswd3Az?=
 =?utf-8?B?eWxGUE5GVHJYYUg4TEt3bStvYmU4eEo0K1owclUzUVJrVXkrZ1Vub2JhcjM3?=
 =?utf-8?B?OUJrQllxV2kwb09Oekc3SnErKzlzSWZBemFnUUFncFhSQ0lNTlRHZVVGQVln?=
 =?utf-8?B?RkxWT2FUV3VzVTlsMnVJcUpmbVB4NjhWVUpyUUcxekxMNEd6NUpGU09EUlp0?=
 =?utf-8?B?Sng0RXZ6SFZ3R2NXMTcrWG4yczNJeWxqMGdGT0FmUEt5NzVKUlROVk5mRTRM?=
 =?utf-8?B?YTFGV2xUbXVDSEVuZ1ltbTdFaGlMQ3pIMFluVzdUZDJxZkpoQzM3UEs0cW9N?=
 =?utf-8?B?MG9NYkZXODIwOUxURlJ6dUVnT1ZmWGhOU0pZbmRoM2cxVHlnSGpQaEJUNGxn?=
 =?utf-8?B?VTY1czA1UXFlNU10Y2xQaHBveDZDQ0MrbXNxaXJUbWZBckZyK0R5MW5XNWZ6?=
 =?utf-8?B?SWdWVHdSMlhwN1FnRVcwZHViQWFHQ1hpVHVDZlRYT3RrV0JEcjJsWlEyTytm?=
 =?utf-8?B?QUR4YnpGM2E0MDRLaS9yWjY2MXJ0NG1aTVRCTVc1UnRuSHBpUHN4RWo2alVK?=
 =?utf-8?B?b0dNOWhrRU1mR2dXak9FR0RYK0JraEZFMWErL1VlOVdubXFXZzQ3a3BXRWNF?=
 =?utf-8?B?cEZKOFlKLy9ZKzcyc0gvcEVsbHY1bGN2YUp4Z1c5MDNoT0ZEdnFXS2lCempS?=
 =?utf-8?B?RzBCZjdHekF3YTJKTDZHUEZhelE1bHhZWkh4dEdCYTlqSFlTeUppVlBERjdh?=
 =?utf-8?B?a0NYanV5L2pmYm50M2ZBZkc3VVFoWkJaZ3VRcE51T0U1S0s0akdiKzBzVHk5?=
 =?utf-8?B?b2IzUTh1enJ4WHBBN2EwM0ZNV1gybmFZZ25jKzZhMUNOYWEvWUxuRnlHclcz?=
 =?utf-8?B?QXNsZE9IRXRXUFZWTDBQdGJLS0R1QjJPbnNibS9ldmhYYm93cFZsK3BqYi9s?=
 =?utf-8?B?RzNMcm14MG5mS1d2MHJ5b0F3TXlQeU5KMzlYREFsbUVaUGJrU3FqR1BoQ2ps?=
 =?utf-8?B?QVMwU0VYOXh2cXlJcS9xT2ozditqYmtNazJTRldZd0lIa3h3c3ZiU3JhQkZ0?=
 =?utf-8?B?eFVrSUVEd0hQZFVrT01Tc1R0aW1GeG1uT0tXNEprakFxditmYTFEUUdNTnZ4?=
 =?utf-8?B?TFozRXlUUG54eHdGblIwS1VQLzhDeXBUWVV2RFpuRlJlb0JkNjQzQlJZU1lX?=
 =?utf-8?B?b29oRnVsaVp2aUVqMU9JcVBVMjQyeGhvdGFTMjR3SFNpRmNkdCtXbTlOL2tB?=
 =?utf-8?B?L0o2cU0vdG5xdFlrNWhjM2VaWFBpRmc5NDNsZHdCcXJya3E1a1cwM3BiS1Zw?=
 =?utf-8?B?eTdMZDVJa2dkRTFjcWlqbzkyVVNpNUZxaldnVFlrYzZ3Z2p0TlZvZ2c3NzYr?=
 =?utf-8?B?RzZLMm5NQ0dNb1VNS0NYb1J3MkFEdGZnY2UzeHVPYzJ5NDVWZlFTSHNoOGsv?=
 =?utf-8?B?ODVYSnpTL0FobDY2a2QxRVlmTnd3eDk3V29UdDE1SXBRY1FjMExzZzRZRXpH?=
 =?utf-8?B?QnV1WXFhYm0rM3p0Z1dXMklZNnFpOTNTQTd6VVluNm83c25rQ28vL3E4OEth?=
 =?utf-8?B?elVMcVdzSk8wcXV2L0p5bkhuU21TeHAwUFBFa0RLbEx3ajZ5ZVo3dmNZNjBQ?=
 =?utf-8?B?ZzR5eFBHemVPbm11UnAvdFpYT01uNkorbzlzYlZqWjhWVzZqMFNYMERQN2JV?=
 =?utf-8?B?S25vMldKUDJIRW41RnVIYXZHUEQ3R0tuSnJmVkMxZHVqcUhtcEZQcFE5MVlM?=
 =?utf-8?B?WE1WZmZMSEFldlhGaDBZZFVJMzAzSFBaSDRvUXZxa0FtNDRmSVB5ZHhIcHhC?=
 =?utf-8?B?NGd4UG4rWnVJbTNHNFdobDIyWG5zVVdjYVRVSEVWelZEcmEvUT09?=
X-Microsoft-Antispam-Message-Info: hoUbYZDeqtmZnAZPmr+OIwuKiFeUhMN9uH/oNiuIrkzueNlEBb442CfWPMRvT7PuvI9YzDvagSdt21eS2vP9Cf/qDhzYdxylclAWM6k0NH+q1FKnB0bVkcFz4tmaEm6x/6g95jFwqx0dt7ohSho9EcjxJmQqmOL0QaBt4sDlJITWCQZXMH7DgHbM6UsssERK
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;6:gEuQGZ/RiByuRokX7y3rpL3pp4xWRLE80b08rl/5kU5yiCVePSceEg02E//4LDvALW4tyaY+5Fs1YxHGrMH67wkyajHMFT0XSSYt3BEa/RAg3yREoleb3pf0z96Ts+b6mqAtAbJRooM+zRpmEJMa8ONh7+qH8/QEeuBFKEjWrbeB5bW28R8ARj/VDtNk8obg0jfRIgM5l4f2Wzzy/LOtkhYkNh7DsSdQ7s3E9Fo9DsnaL431yrWlhFZ5v+Q6q4dKRC35q6JgwL1szUMUHg9yP0/2xGQjklGQra9yiY53pUPhmnQRg77Bu3DmJrOkRvBZHIiTU2UW2UaVXdB0Uyf1Xm5+miZZS6zJiuca8cyLw+hSnOkDfemGLoVYGnANbWpZ1zLc2SxKBttTC4n198Boc+evv1NsR6IpE5HsBhrDpUX5HPrlN+r5+5JcFtvz9dXpuE6gvK8jUmaKiV5kTlpCbA==;5:zOJrWu8ssePkbat3+Vd7IIU5sv8cJ/SCsdG5yp7c5wKkjThLG91uQ4G0JU83BLRh/r3VzJKWLyB/M2I4KNzkX7qaXpe8K5i0AULMTql5kkL0iRe+W+6igVkiQ7PK/2EhKGCyFdLIJ3cIl/qBpeHKinQZbOvOIGuAl0QkJ0W0LlM=;24:Qf3v341158RJVNv3n24pN4mEpzkVLtrPK5fexe679ugCuJ0yNBYoxUDdFiHyF2EcibakDnHvJx8/RbQuWe5BvfP7HRLrEDYxf9ONjjM7IDM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;7:upKs2MfteLhECxeMTBClbTGYzHKc2o2JbX9swfhHXXLbpyiheesYOCgGVr5G2QPLGkKJjeI1ocFc6xlu7lZoZ+oSs+qUJ0+FL79bzTi4b4DPK145UjeyDJtDBxxpQDj1gdcds9lhrtMCvt8tJIJcnQyU35M/gjQxYELU6ox9+A2bJedplMBhFxVLbJ3PHCBdHJv5mizvopNvo3I7quX8MK4ahKfbX7nSLtJpWikriyum3Hs0vX1dE7wKcoK6fJtv;20:gKaAbvco/D7Mm9b5N/rJvKuDUSdIHjYkJW03f202E4TfmiuKp2FmCC5aI67HPIZUKOp1GnsYmkJ7OhIRh1tecEMkSlQhg4+gis0VeS5hzl3ue0UnzCAuKhQV7Z1i+I8zMNwptT9NGTq1QRwjzmUkKmiaoEavae0jZO6SXKwPQgM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 09:46:33.4270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d2f81e-4ea7-4235-56ac-08d5d500612b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1330
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 55a76465f7a2..a66d13b16046 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -508,8 +508,9 @@ int memcg_update_all_list_lrus(int new_size)
 }
 
 static void memcg_drain_list_lru_node(struct list_lru_node *nlru,
-				      int src_idx, int dst_idx)
+				      int src_idx, struct mem_cgroup *dst_memcg)
 {
+	int dst_idx = dst_memcg->kmemcg_id;
 	struct list_lru_one *src, *dst;
 
 	/*
@@ -529,7 +530,7 @@ static void memcg_drain_list_lru_node(struct list_lru_node *nlru,
 }
 
 static void memcg_drain_list_lru(struct list_lru *lru,
-				 int src_idx, int dst_idx)
+				 int src_idx, struct mem_cgroup *dst_memcg)
 {
 	int i;
 
@@ -537,16 +538,16 @@ static void memcg_drain_list_lru(struct list_lru *lru,
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
index f80a2d1cd880..2b703c4130bb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2965,7 +2965,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	}
 	rcu_read_unlock();
 
-	memcg_drain_all_list_lrus(kmemcg_id, parent->kmemcg_id);
+	memcg_drain_all_list_lrus(kmemcg_id, parent);
 
 	memcg_free_cache_id(kmemcg_id);
 }

