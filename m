Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229C0C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA2021884
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NvZYqm3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA2021884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403826AbeHGRxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:53:17 -0400
Received: from mail-eopbgr40116.outbound.protection.outlook.com ([40.107.4.116]:10284
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388677AbeHGRxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHhaKK0koKcZB5yc5yD4q+dXe27lzN4IMJnbu8sfryo=;
 b=NvZYqm3R5ZRyUy/fhsA7+bAZmeal9lo6kN5g7RnWoNlBNxFSELkWKbUxGb9E4Lh6EhC46j8NQXIclX/wcqC0Ay0SZfSuKmQqLrqCA0dqmsyJ4I49SQO1nFTWei0qzEtVafHLC3B7TtbijUhId8PYessrW29JUPOBR6l0QyRxaNM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 DB6PR0801MB2021.eurprd08.prod.outlook.com (2603:10a6:4:76::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.14; Tue, 7 Aug 2018 15:38:15 +0000
Subject: [PATCH RFC 04/10] mm: Split unregister_shrinker()
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
Date:   Tue, 07 Aug 2018 18:38:12 +0300
Message-ID: <153365629257.19074.5257843346605031007.stgit@localhost.localdomain>
In-Reply-To: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
References: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM4PR07CA0006.eurprd07.prod.outlook.com
 (2603:10a6:205:1::19) To DB6PR0801MB2021.eurprd08.prod.outlook.com
 (2603:10a6:4:76::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf64a4f9-e62d-4738-0b7a-08d5fc7bcc24
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB2021;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2021;3:Jjhg9hl0PGi28VW6MlST5xLkv/Ty7ADCqvbMngxBQu84Vwzr5Zaera4aOmMK8iAJJ29Sk7G8HXByex7QxY8L7BhwxZcF0IRm1iaYMEtfrwaqwEN3l6ZuFTrYY5zG4YY5ZJVJynqYXNOcW7hZk4TeaE3q95gGt//1SaCDIE8PHHojQ8TrvXs4cC7wQ9niW+6zRoTKKuxuK4mYC2mo8pNaIbC+fgEMUe8Nlm7ieVWO7fiyGyZVeI0c9cj9qrue3LL+;25:KFMPtMMXE3FX+W0mdlXXrY/w7UqtEt9D86fJsKvfYGbUP0S/nzJQ1qDuuSdqAmKojfuVBe29d9zFuWCDQabz32/97+WwyN2n299boCE+KuI6InZ6avMpm/+Dpo2ReeBW24SHv2U5iO58RVoPWOSpOinvEuMjzHc40y58127oMjDbmJNMQzaj73A+hBLI7o+ZmHekMUej5eXAqHYiQcwMk15yQSV54rPGWu0VAKO4uaQiQ+qEG+OhKzz0UWk0NXaDAvJ5p/uiYDNzo1hSPvXEeh0tG+T4K1ORbKMhjrB70BXVF54OHzR8AY787g0ZJEBVZ1TiuyUQX8sngpvGjiH8pQ==;31:SudW5iZls7TBUlcnMc+NFnHwZwAtVxvtq+Pz8g1MYV4Wu9/wNIQZYXphpb+Ko43gbAi6q8e0Os11MHV0QesWBlclYYtmJ44/oqd/M6DvRmFTRRsLsZFVzMaHVo5HH1vmoH5QvZCF1JfG/Mb0yObU5tmfW7Qk3yIfZWLlRoBRgVATjV+s4Zo4XeHUkhnqzJrpqsSpOAGtj95RPS9fDEA6ld6Y02Ew3XQ6i85mv8W8ME0=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB2021:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2021;20:bixY5YPhwxHC7MZg/YJIqMO5o5QusYhX1IAYqL179vI737N5tLB9+XQtEDEsm3uatwc3gjYrD3sfx90319jcPkdFTDSu9oKQH0hPNZv9OEfbdQnT8OvW3Hv2yfqcNhxiqtbVJVKGNW00cpnEDU7H/unjUW9Ao4hiQ36+kWXrTtZO9rGj9tk2ee0S6WZqNQOnn7Pm1vg/8neD63PygcY50JsHAiuTJb1h6lyQkXdz5coN9DB94nAFvTXzUTBQ6NtiKlSpuIcg36+GidF/007LsaLwmxSDK6JJd6a4qY4/7kkkRPs+2I4cz4NuT/MYB25uiJpizCtJxiu9Cu2XdsVZsQ1xCRsN7WID+mND7VugMyoDcW+OHFOGURk40955fV4qeRFczq4pGEc71yGwiSCnBjgm32J41IUUOViZgKBwOgyKK81T4ixHOS+Nas0r546BBK91/xWPQbri4EWYGNfrbVpjyp1b8lCO47dwvPo04Fzn/yabAyT9gj8vCk3mry4a;4:11X7L1Le/UcOwOI8Tz0ypLJ0f0rc55hjZtcf19Z4ZiestZ/NqTNLLuSnVFARmJLbfkk9//k2fOX+7AVT32w6Hqdov3jt08vt8Mhf8voi4bUvh6GBslXsjzhtH/4KCChgYJFj2EOyntSMIWYwEtp6QlQAxqal9NcMIQzJLYEh7kgPf1rzyut1QIIDJSrjwCvY5X/T4C7WB6is/s5AoOGd9mAgsMlcD48V1awvR6Y+D8JLU6CeW+/eBICugFTF2AuRNJyVNln75jO3Bk6R1xgipA==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB2021DF6E8AB89F64DE41BA59CD270@DB6PR0801MB2021.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB2021;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB2021;
X-Forefront-PRVS: 0757EEBDCA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(376002)(39850400004)(136003)(396003)(366004)(199004)(189003)(230700001)(3846002)(7406005)(47776003)(7736002)(316002)(105586002)(6666003)(58126008)(97736004)(6116002)(7416002)(305945005)(5660300001)(66066001)(86362001)(61506002)(8676002)(50466002)(6506007)(446003)(11346002)(386003)(81166006)(486006)(956004)(2906002)(217873002)(52116002)(25786009)(76176011)(39060400002)(476003)(23676004)(68736007)(103116003)(186003)(55016002)(106356001)(9686003)(7696005)(8936002)(14444005)(16526019)(26005)(53936002)(81156014)(478600001)(2486003)(33896004)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB2021;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjIwMjE7MjM6TVpCYVlObVUwSXU3QVBuT3N4ZUgxelZE?=
 =?utf-8?B?NGZDeFh2d3FRckxqQ3o0Y1BjWnZGenczeUhnWEcrY09WNWE4WHVXRnd3c3A4?=
 =?utf-8?B?eFVPOVpRQ3ZFU3ZMdDg5NG9BVWZEdFROSXAwejN1ZG9VYVBiamJFY0VvQUFX?=
 =?utf-8?B?Sm9xeXc0NjZYOXkvYVFJbUtVTll3aHBMV2xVMUx2V1NXUXJWOWdKdHVEMWho?=
 =?utf-8?B?WitleWlUaVN5UjhGM1NmcVh1azJaUVpZcXF2OTZLK2Y3NVF1czJTNFkxY0x4?=
 =?utf-8?B?K0MyUFltS1B6bkN4VlBna0lQZVc3U0pKRlU1SFZrbWNJVE1tZStZSk90Y0k3?=
 =?utf-8?B?RUYzVFZET3MvR0djdVoxVDA3b3BjRFh3U2V3K1NLckFZK0k4N1FPVGNhRHhO?=
 =?utf-8?B?YVRENldiNUQvUlhuUzcwdUVwL1pRemw3a2R3MUZmUGdaU1FPa2Y0N0lIbXFu?=
 =?utf-8?B?enlDc3paTGJSYzhjQ3pVRVBaVG1KQVpoTndPdTJRVzhvQ2dYRkdiZk9hU0pC?=
 =?utf-8?B?UERHQVhUaVlwYU1qTkJmUWh0eFA5eGFNU1lqVDF0TkFXb0Q0TjloaVA5RzZV?=
 =?utf-8?B?SjdWOTIva3prUEt6YXVLYzZXMWdWdFFwMTRiemtTczJzaXo4Qk1vclVoNU0x?=
 =?utf-8?B?am1PMDdTWmtHVnVLWUw2TkpNcmNvT1YzcDM2N2NWeHVnamVPSEdaZGNGcUtt?=
 =?utf-8?B?UEF6dGxXUnI4VVNWdjI5RGtIRStRTzNlZTF0UTdpam5NR093azdNQmRWam9R?=
 =?utf-8?B?cVhGKzQ0OXZ4MHFyc3I2U09ISnVBdVpzNDZpay9JbnJuOGdRMDNiTFQrb3o3?=
 =?utf-8?B?dlU2ZlgrdTdveWRnTzI2ZFBNQXlKZVAxWklLV0VvTkVEdlZuUVdZdGlVZ3Ba?=
 =?utf-8?B?T3lSSUFEWGw0OTdWY3BTWDhVczQ5ajI4azFIWFhVcFF0MG1wcWxVQW9pV1R3?=
 =?utf-8?B?c3NicnZLMkROMVBuYnlzRzg0V0hydjlNc2lYR085cGpGdlJtZEF1dmNtZnk4?=
 =?utf-8?B?KzgydHdFcnFMeHFpa01BL0tScWNaeW1uNm44QmhYQWtBMERFbXBOWThwTnZq?=
 =?utf-8?B?UVM5Q3pZNnNzV1NCNVA1Y3M4VGJpUTJxdTVzeGtHMVNyK0ROdzFidExMQnBI?=
 =?utf-8?B?RFRkS05mQW94MTl5aVdaZVpId1J3RmxuNjhNbUNadHJFZXl0Q0h1UzBEaFhy?=
 =?utf-8?B?Yzl5RlI4S1hhNm1ta2NQaHYzdXVRYW9RdGRISkk5bUQydDFGWEtENGw3bTBE?=
 =?utf-8?B?TVB2ZGg5ZG5oRVhSalYwM1hjbDNmNllJbUJ0b0ZOYkJKelE0SFZBOWh2R3BB?=
 =?utf-8?B?ODE0djlmVzQ4bm9NV3VmVnhHb0lSSGpTbHNldGlXTWNkWFVkRXZ3WDd4QTlM?=
 =?utf-8?B?TWZwSlhuWHFmSFJaRk9UK3RaTW1vV1Q1bW15SWZRSytYQXBuZWMrRzQzQWtF?=
 =?utf-8?B?NHJmNS9VT0tZRTEwL1B1ZHZ2dmtpaFFtYUNmQXo3RG0zY21OSHpyOUNTWGwx?=
 =?utf-8?B?WHFVRHJXaVpDNFVTbEVTOXVuUWdEZkttWXVTaWN2SENtK1c5dGNkdGJMWmdI?=
 =?utf-8?B?UzJqN1Y3RlJBREhWWFhxMndNRDFXWjNaeTBxeWdOd283VWJ4REw5b0lSS0di?=
 =?utf-8?B?MXd0L1VSUmV4VDVSL0FjanE3K3lzZkVZUFIxSHNKNER2ZkFVbGdvMlc1VENm?=
 =?utf-8?B?RlRxblFORFBoYnU5SUg3YWhCdVdhRnVRaUVCVFhMaExDOGlZTzJtRWZudDNB?=
 =?utf-8?B?TElNUytzUWZZZlN1RHBjNnBUdGdzYlpSNEpsRUh3eVVXTUNkeFlXUUFtenp6?=
 =?utf-8?Q?DWQZZqCYv+lNJay?=
X-Microsoft-Antispam-Message-Info: OMFluMWMRcSl+wetwMsTxL/++GIyV0lHEYzw4/xHDbL3HsiofPcJXH59YAmihE6Yazf8DI42wJ8SsHEKL1SXyf+nTQB3ASw0Mw+jfmg8FxV8m8n/OdQhd3Ws+nBatRcf4NiaQX4aq3vM2Vasouv7yXVFF5g8eY5eJXSlI/cLFlE4494FZOi1vb3O7gvRRG3ZohNVwvJshpqRkJOcdlEag8gdljV1F8usXm4XDscc8Kbm65hASTBeW3amlaf34QpMAwV8wagG/GYrQGnHSRQ7RNgp2I0JVVKq13IiQzFuijhutn3VQKJOgZlD2cxj9WhMG1lYssd+2HqNR7CLCdKM3wDK8c9DsEQJPb7l8DDWwZ8=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2021;6:uLY8CQ7TWQL3m3jaeyY2N+ERUcJmZwU6SGO2aBjqOnGwvTtWn2goEw+vQ6KoTSFP/W/7WieQkWhop3oG/oiZx2n/S/0SvxhJi5BGEGIAtkjl5x18cnneMqDXLrX69tWyj0ZlAG9NjX/+wSKYfj4P17zrVCRtAMX7qJ6CD3OIjZVQWxbDxMJhZJdUusAwlPuduAjPa8ykhtt5TUK1Re17lLBvIZHZITmRHQzDeVXo8rwHgrH5plkQCGjKgJlQDkc0X7c2uFlYIxaekU/5omB6lAzB2oKsukJb4A6Hi/pUFUSCZyqvf81jglLrrQsgkpdXz+LZOWU1XdMr4xU9FHtvuUJdv2nCavXB6nO8Jn5pY/P+Pg+sVa00fZJ7TuHAwSD99pJzELy8d2u9F+8ySjj12JC2CZs+ZUznKAWmkHc4wapnejVLP7+y2V8E9MVzvyNu/+/GUXRMpbLB+HXhekJuqw==;5:nokdg+a4sJl05bXVoFbhB10Cem79XuOD+0vldx+yiPLLXPVsiYPue3KCgEyFwsPdB2bgi533FqIx0aCWjLKQSwSeWfc9XQ23h8DVBOy6arqKMWw2p5qMVpdU+OrPrzfxxiEDYXklQMVbfYv3DjaXN2SzB3cveloVgZMuQNFgHQs=;7:tfztc9dpudgYGMMFel6T9i/H91SzF1E0A/zhyTysCcX7IOwhV97qHd4KYkWTB3NcPnQCdT1oBh8P1qUuwG+GWUk2bNL5OcTZTNAYlHPUpNx7YjS4aQw5xZibRc9PljPw/3bH7ArScG/TgAnNcjnqGPFY7O1mZ29znRiXw9ruaNou3Io2hE6N+V75NAg3pap0o/Bka7vuImkUL0X7r0Q1VutOLP2Vpg1BAGNnZJPG9XvC+xqx7yEXNZeXte6HnMh4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2021;20:QV+9fHQEYBZUWbFr7haq41cnk9W3UpdOzydwRd5ttHkV+1R250GxwQ5r45YFvkaeiuqQKB2TB1SYr3Zf7EeZqQmfQMwWgl9xoBguDv3jhZmFM2DFhoiNBiUGHcEwIwzAoVbv70CaOu5RXisdFRo6DpLDta3ly/jXBloHlv1niEM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2018 15:38:15.4293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf64a4f9-e62d-4738-0b7a-08d5fc7bcc24
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This and the next patches in this series aim to make
time effect of synchronize_srcu() invisible for user.
The patch splits unregister_shrinker() in two functions:

	unregister_shrinker_delayed_initiate()
	unregister_shrinker_delayed_finalize()

and shrinker users may make the second of them to be called
asynchronous (e.g., from workqueue). Next patches make
superblock shrinker to follow this way, so user-visible
umount() time won't contain delays from synchronize_srcu().

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/shrinker.h |    2 ++
 mm/vmscan.c              |   22 ++++++++++++++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 9443cafd1969..92062d1239c2 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -86,5 +86,7 @@ extern int prealloc_shrinker(struct shrinker *shrinker);
 extern void register_shrinker_prepared(struct shrinker *shrinker);
 extern int register_shrinker(struct shrinker *shrinker);
 extern void unregister_shrinker(struct shrinker *shrinker);
+extern void unregister_shrinker_delayed_initiate(struct shrinker *shrinker);
+extern void unregister_shrinker_delayed_finalize(struct shrinker *shrinker);
 extern void free_prealloced_shrinker(struct shrinker *shrinker);
 #endif
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2dc274a385b9..fba4996dfe25 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -422,10 +422,7 @@ int register_shrinker(struct shrinker *shrinker)
 }
 EXPORT_SYMBOL(register_shrinker);
 
-/*
- * Remove one
- */
-void unregister_shrinker(struct shrinker *shrinker)
+void unregister_shrinker_delayed_initiate(struct shrinker *shrinker)
 {
 	if (!shrinker->nr_deferred)
 		return;
@@ -434,12 +431,29 @@ void unregister_shrinker(struct shrinker *shrinker)
 	mutex_lock(&shrinker_mutex);
 	list_del_rcu(&shrinker->list);
 	mutex_unlock(&shrinker_mutex);
+}
+EXPORT_SYMBOL(unregister_shrinker_delayed_initiate);
+
+void unregister_shrinker_delayed_finalize(struct shrinker *shrinker)
+{
+	if (!shrinker->nr_deferred)
+		return;
 
 	synchronize_srcu(&srcu);
 
 	kfree(shrinker->nr_deferred);
 	shrinker->nr_deferred = NULL;
 }
+EXPORT_SYMBOL(unregister_shrinker_delayed_finalize);
+
+/*
+ * Remove one
+ */
+void unregister_shrinker(struct shrinker *shrinker)
+{
+	unregister_shrinker_delayed_initiate(shrinker);
+	unregister_shrinker_delayed_finalize(shrinker);
+}
 EXPORT_SYMBOL(unregister_shrinker);
 
 #define SHRINK_BATCH 128

