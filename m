Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531DFC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE62208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AiOnHTYf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE62208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755279AbeFRJpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:45:11 -0400
Received: from mail-db5eur01on0131.outbound.protection.outlook.com ([104.47.2.131]:64224
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755091AbeFRJpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzrhUnLlfby1gTgUilKw9jqsZ/m1V4sHluMgVAMYm7Q=;
 b=AiOnHTYfkXY6BtfaWEoBRxR/SIdmMbKyXiKDozWCErSyk+U7jwRZAIacXBqf5hxZ5bGOHO2dWjCcWxAFeugJlA+hcTcyzbpMKZCzb+4Vlzv7EBuJPOxF07c/mNO9fpCq/g8naFEsb9J0poeTSBMETchU7vvAKABpsNI5lSxWcGQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (195.214.232.6) by
 DB6PR0801MB1336.eurprd08.prod.outlook.com (2603:10a6:4:b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Mon, 18 Jun 2018 09:45:01 +0000
Subject: [PATCH v7 REBASED 01/17] list_lru: Combine code under the same
 define
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
Date:   Mon, 18 Jun 2018 12:44:57 +0300
Message-ID: <152931509755.28457.5259293881050664963.stgit@localhost.localdomain>
In-Reply-To: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
References: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0359.eurprd05.prod.outlook.com
 (2603:10a6:7:94::18) To DB6PR0801MB1336.eurprd08.prod.outlook.com
 (2603:10a6:4:b::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a7ff551-c4ea-4351-563a-08d5d5002ade
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1336;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;3:6w27ADKVAXzDeLgOcuC6H6cUOkoJ2no7eAgQZgf+J4t70jdmUwJrSSl1TUOTbAaZlatzChzL6g4Ryt/S6zjZSCJC3Ot7vgFQw1FOkPJq+IvC3Oun4jGkTWtooqcAvqcbpAgmWyMMulI1WG0/krFyMncihJsiu8V6GfZrSdw7rC5MC/jcZlKROtEJofUR0vxpll3ANVUevy6lO583Bx/MYipdZ5cdwFBMzxUC7DIsGNsjFtOxBSMd/UgwMu7LLh3m;25:dzIxkMD1Lkvr1eu95gBX5vUigvwkKa4R+XU/i6GOlg8zacVVz/XFv60lFE/neddWzktheOp69tGSHzupVLgyh3yN27Li00bFEYPTJYSNnKoSzo1mAbYcn8vF7xqHs5uRzN6W+sR78XIcKvXIyRrocPytpAQqyzjWsE8w65bCxeMc08BophcK/rfmZAESkiUWmBeeR8iBUtIZP5wK0biWU23lGGZLnxJOKt/4RxnaCqpPtfK/Nz4mMsCk8oDWpdg92nod4ijgcvQev/e8qAQkq14Ogj1u+J7sNmVZljMlIFr8IANF/dWEFZc7Az7i5z0DePNYckdnd5HIgJ6G06YurA==;31:YwdpWMblNP2g3eyHYIk7Bdigb0jEoNVSbKkiT6h70xntDLb+bL5/r3z2otLmllPJzYw4d+0BrdLYP2PpFWv7Azx/WLF98nwX83FL40VH82xCrqoMTwG9qX1nlaFlOl1uDYxAkehmtVmLcPejfwCnr0fBF4EeKGoLDUh2usjCmfGTKhVz1inTJrho4JbKe5w1GABBHJ7zzFpG9OC9oBgvXUnz9pQjn+4EwDJvP9hemRY=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1336:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;20:v9R8QvEZiozLoG3Kbh+6gHnNDOvBD7vQTMS4Fmx4o7LBdpdXgxGinuxTbJeGLLs/NSZtrQUWPaCsdpPyfE4tirt1syvc7FE7SCDhqEwffcNpoBy5w2ZYW/OtuSdmR31TR61kgtwbGPFdkOAaP2n9gsr5AmVj7ywgxhVCgJaW44JKJOBdmfSNDEozIpWXpR3fYPkq6AFtNXsXPsfRJQZyAi3eVL724mvZ2SVHhuHVFyxF/bRW/du/B3XCg4C9in3QuCI6R5etk92E3M4sBxwkQdeyC5gfABr5fWgyhG1Zd5dLwGGU4NEHRQp9sGl3h4oo6Gz77zy7Ij0wU19B7NN0b1bm2pzUBj5wMS0Peuc7ltN6e+VepYj80q1d7tPCJFbABfOBqy8AVAXIwV2LPaVthfmf4Jvhth4eM8Emq0T4i8qVSDnfwngonvpGXAvdkvnICpte/RFfnfRhsIkwE/PfbkGpi0XbP/r+lOFpiUOkyS+/9N8lb6KRH7eKQmiVi/or;4:maef67mP37A7OjaOmt521H8h2eFDyPsfWUDWwn5NAD6d7CtDnqECrZ+61GJsNC0dZ83T2xowJa6FlHUdJZhCavfeS8OCLNl9Kr7a30uOEKZdlAd/AgzAciyeqba7a8qRwGJt0cCZJ667tjvk4BPsKkUm2VtZ4msC99rBMmEkFBg0VVdmWeVJe8RLSVabrHf6NT7l5LvyY1/Obza18+snBQ8XSUQk8eZve0UTP3dttCCPSYj6KgPIz7ECOr77ySPGZ08pGtnnfiqmO7vwH2qTDRQtaYgXRQFggcLm4CBZPM2BVWugkM8KZEVMY1VkzA5hcPZ9GzLb+7yBN4QP3fYOaIpbSrFLrMxDC6MEL/pxDL5m+lUXM0IwDJI37Ury5Aj9
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1336D1427E16E157A83928A3CD710@DB6PR0801MB1336.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1336;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1336;
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(39840400004)(39380400002)(376002)(346002)(366004)(199004)(189003)(47776003)(50466002)(53936002)(39060400002)(66066001)(103116003)(25786009)(478600001)(26005)(8936002)(5660300001)(7416002)(305945005)(9686003)(81156014)(81166006)(6116002)(6636002)(7736002)(86362001)(16526019)(8676002)(186003)(3846002)(6666003)(55236004)(58126008)(316002)(105586002)(33896004)(97736004)(52116002)(106356001)(230700001)(76176011)(7696005)(68736007)(61506002)(2906002)(956004)(23676004)(476003)(386003)(2486003)(55016002)(6506007)(486006)(446003)(11346002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1336;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzY7MjM6THhUU1BHSjM5WVpqQmVrRzZST1hKNjZD?=
 =?utf-8?B?dUxHbkpXMk9KMEthTUJIbi92Y0h4YytmVmd2UUdPM0lWNXhLeFhBT2pqajRn?=
 =?utf-8?B?aXp6Y0dJRENpTGREZE8vTkRtWEpESFNJWS8vcFpiYjNpN215RE53VnpyUWNK?=
 =?utf-8?B?elppV2hOek1ISmtGT1Q0MnU1NVhQdUg4YS8rbUs4d0VCc1lXMzkvNlBOWGtj?=
 =?utf-8?B?WjJiQk8vaXk0eHlycVdUZWhpKzBXd1ZYVjhaU25vazRSQ3hjM2dTMTJDM1Ji?=
 =?utf-8?B?YkV6VmpocTRJMkxaZUozYVpRUThSaXF5UGxNaDVIQUJvSXFDK0RkYmtMZEUr?=
 =?utf-8?B?RG0rd01QalJxUWprbnc1OWRNdHgzN25UaXF1Qm9TdUJBeUxEYkZMVHhiVTI1?=
 =?utf-8?B?aUVKZGNIRlJaR09SbFRrZFRBN09Va1NTL253YW9qaFRKMFNRVlJnc1VabkJD?=
 =?utf-8?B?T3pQNXBHOWltalJaU2NBTFRzdDkyQzhnUjgyQW5ONjgvS1dVS2RwVW9wN2FZ?=
 =?utf-8?B?b1h5eEpBTnNkekx2cW9Ga21DUEdMRnBWSVk0UG9iYmhzVWJtcFh5MVlUSy84?=
 =?utf-8?B?NUdyN1JCTnFNNFRscVo4b3hpOXE5dmwyNmdSWVI3S3EwSzNyK2E5b3NLWTIy?=
 =?utf-8?B?MXh5VW82T2VMWHNpN1lUNGhIQkg4dUo4YWRxRVB1TG9hSWNQOUdvSFZ6Q0JD?=
 =?utf-8?B?RmZtZ2NIV1NPTEQ4SSsrcXlVbnBKRitMdlVLK0c3andLN3R1ZGtNUU9CQzBQ?=
 =?utf-8?B?Z2tjNFZ6WjBpc0FWdTNTa0YrK3dTT2FDcDhHaFljSWU4MzB3RzEwSGRlT1NO?=
 =?utf-8?B?d0huMTNsU1NKdlFUSnFSVzJmOTVuVHBDWnZPZzBWN3c3WnREZk16ZDIrclFF?=
 =?utf-8?B?MElwNFVUR3Y0NlpobWh5VzJqdDNLWHJHUnVGNXRvaE9JbWxuS05GdTlMZWdm?=
 =?utf-8?B?UnlESTZiUjNUa3ZzR2ZheWVvTmlKdE5Ud0tRZkhSWWFWcEhFaWZxT0dJWE9j?=
 =?utf-8?B?a2Q4SDQ2TllIelFhaXZ1UURGdDVOOHFSd054SVB4QTNnaUFvczRXZWlEYXJz?=
 =?utf-8?B?TUxpSnRHdWdPd2srN1dIWTIxb3dzZmh3aUlHOW9PamN0ZC9IUllFRGtUbWlu?=
 =?utf-8?B?SWFmeWMyYlo5REZLQ1QvOFpDY0FLU0g0OWt5WHhLUGpGUmtGM2x3OWFRRGNh?=
 =?utf-8?B?bmpPbk1sRzB0OFJZa2NPenh4MjAwMHdoclRwYmUySkZFSFRJb0dDVGVydnJE?=
 =?utf-8?B?VHFHYTZ3Z0FKazY1eHltQ1lHOUx2SFRHakF3WFdJbWVxZ0ljK1MrV2RQbGNS?=
 =?utf-8?B?am1nSGRLbldYc0MyYWNwYm5xZkM4K3R3RkhqWDRtTERxL3ViN1hkU0RMUlkw?=
 =?utf-8?B?VFZFZ3UxRmNLN3V0RUFMaWs1ekZiZXo4ZmFWNWYyS2pVZlJzM01vUWkyR1Na?=
 =?utf-8?B?THBOTjE5MjJoeW9Ham16bG5IejZhOHZmSTh1em50T3I4cENHMWdtRENhZE1Y?=
 =?utf-8?B?azd3b0k3cGNmT1NkdDFiWmhGMUlpYnd4bjFkWXJqWDNqV2FHT2Y1UzdKL2ZG?=
 =?utf-8?B?TjJ0MHZQakZuNzl0eFB0OE9pT1B5VG9sSGVOdjBZeE4wNVcrUUljYUYwcXFq?=
 =?utf-8?B?eUZMSm8xZDFLbTVMMU56K1QvTVlOTzBLZG9UaWo5YkhYRno2Qm5IYTNPT1Zz?=
 =?utf-8?B?L1hJUVFaTWZFUlYxWVVMdWdhRVh2KytsVnB1WEVjbU1qR0I2V2NDT0FwanNy?=
 =?utf-8?B?VlZtUEY1SENWamlDaDI4cUM1RUdmNU9FWUZHYzFkemJ0aE9KZ2ZXNEpuRGZn?=
 =?utf-8?Q?8PEHWOdryW3ddNa?=
X-Microsoft-Antispam-Message-Info: SkfgEfo5RCeeQEIa1qQ8B4AEvABTZ2ox9Pqmc63PQVXYFSuoHgpVbnDIV1oa3HdKQhN/DYTwyrk38eTmjJfxWNy59aNfwsurZvPVNF9qv7D1UV4C0E/OgiIbzSTSkk/KclY2b7LzGlN9I7HLQAI64OYh9ZRN1G3H7GZMl6CEzuVRKVdQgm9SzcmlDaCNLFF6uKpW5qN9Q6L3GsqoFXowgps+wc7BPOTPAKKVT0cLNBeYNs59qs0qAcZvwT68rRPoM45V2BJ2iyanLEwP1xGI54fcUBGA7ZqfN3q0ZcPxaEkOLkBuW5nTS41UnhigSsKHNipw5KXiMGl7Rs644EpQCw==
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;6:D1HmTQVwoRJJjkec199YRedzugciriPXTJR1T7nEdBZ2fq1ZLTxZPlo9YRAsDaCcr0WJbTYvpSqWdLbKj74/63o/2cgmpOhW/ifecTzl8O5eeq51o4kCYJQZyr++RUcooMZG6HY9gB1IuRnTck8rywinPlk/XY+966zeTe/thPAwSzMBpY2A6CK2WF3oIA0P0glyRfy2BQGOIz85yXo6IVw8BxMrpp6BBeoK6vDZUivaSFHmfHH06RmfOj79Exbd3XRAw2k5KiWRobiAOXci/NzG5UbqIy24msgTBo5So+Ixcu7IVW0UokLyy9OSjKE6uK9gTA4RpUobE8wt3lr1PvFnCNWOu2bs67tO3f0mIA7J1tiqIIC4sjkqLiqc6Jurl/mpJYoZgvZFqExBlQ+WJQs9hiR4lJIUuO3b1mTsc5XXnDpgOAflMwh5BGm6VEjHPPk8Bsv5l5zpVtUDv8IpIg==;5:PVBc8t5HaP+x5fxJcUGEG/lCvErnweIi0wgvSNK3GEgWiN0YAi9G9nFJTjmEhrDFEmpepjOwo1giHQl08LYCn2faHBwl496SDXtN6lAB9RL6a/6xwB+vzdvVyemf7pcuP+0838gEznbJ49QUwaCT7HtdLl0U11uHaxTzpsAooIM=;24:D4iay+UziOcXZxPOuePM0DSO98O3xJZ7vm9y+r3JjKkg7fnw8ZHPkTeRhcDlJSKl2H6a2ieP/QqpLzpmLw3waXeub+PXsD9K8+C+jpk82Tg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;7:zhr7KpTbzc2a7dMeVZ6bCLFbp/UE4jZyMwpTLeayzwkkUtIh8XiTC9bBMv2StPDx888cDkZ7t3uqY4+NPSLVecC9r+nQsk/kEvo2wGaJHddWnbdkXhzE6BaQP3lf+BTKsLQk4A8UxskOVfttqHRJbPy5vgsKt9/AijlOxMRvSK18lMTHzj0qlxscAZ+JEu4eYUKSJDQ9kRhk8aFHsdOtyDT+uzaqMuQB3lVzqmAkilsDy5KpIwKhG+kh3IzRMUNa;20:OEfjnlTT4YnBV2zw00oU1tosoAn0cRTxFhStmK57kM0DbJ1T9k7LhmDz0oqJlOsx8hElmTzUAv+kwcHy0z0tfMAKyRsnWy5SyMRHYtDwNHlzcUF9ArNqT/nGj1VG9iyJ+C9Y/CusSYyAuIznzaV6YOoGGVy+SmVEJs3MqnYDMcs=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 09:45:01.8410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7ff551-c4ea-4351-563a-08d5d5002ade
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1336
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
index fcfb6c89ed47..1e3e2f3a2a64 100644
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

