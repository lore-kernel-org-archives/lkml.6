Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFA7C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0D8208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SlsTelIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0D8208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935937AbeFRJqX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:46:23 -0400
Received: from mail-he1eur01on0121.outbound.protection.outlook.com ([104.47.0.121]:37312
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932762AbeFRJqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDgGBmo2eJjnmVlU73uiwIVsw2prgfEKX1PzIFaqDBI=;
 b=SlsTelIQ+aqa4Sj1DEuF7BOf+KlBK6l2MJMMdOFsiYQ9RIDAOSjvM3VjR9Zt3FE19vCOqfBetTefJmo4pUu4eqYCiW2hUF32/9+4tZ1wg0hDPORU++TCTPJo0NbMo9x8vHLlq2PzY6ctUREn2iGwdRH8J+dV/7yxA72wHP3N35I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (195.214.232.6) by
 DB6PR0801MB1333.eurprd08.prod.outlook.com (2603:10a6:4:a::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.14; Mon, 18 Jun 2018 09:46:12 +0000
Subject: [PATCH v7 REBASED 08/17] fs: Propagate shrinker::id to list_lru
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
Date:   Mon, 18 Jun 2018 12:46:08 +0300
Message-ID: <152931516881.28457.17649784047022122337.stgit@localhost.localdomain>
In-Reply-To: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
References: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR08CA0066.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::37) To DB6PR0801MB1333.eurprd08.prod.outlook.com
 (2603:10a6:4:a::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5665cc04-85a8-43de-0d85-08d5d5005519
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1333;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;3:vG230BU4EfEH5vwCtar+713VC2WvgIaqR9O0apbhMqjH8KYJTHjBLBPgF72GkUm+Bzn/6g/GRd3kEO0W45vb+6UeRwCK9JAoW0n4zC0ULwyZ0YG4DDqqnXLp6NNEZ/hZWm0dWmd7ObVmfuJKKMgmCvCLG86n9s2EK+9ew9SP6usHgpBK1h0Vu7Zan1CieHCQt023CBrPVH0E71acJy/yZf2aYOTUfQogRS+hs7ILmfccvtS5PjPMBTfjYmxIVc/l;25:J0fFAwwbw477+Y1csn55FwRbHQ/Usjqy+v0//2FPU4U5c8O99xHQ0ftIo7ZcP2HCGOh4wpezOT6Gp5enDGhzjqMUl1TgdmSsFJmdue82+5GkZgvD8kIbdUkCjLu9uyVHz20prRcOpPnC53Hsp9xFVlSvHTZN5azXbwZbbvgLC/fTIabebcgLQrWrGJp/HoXIDUiRO8ZXogJx97/H5p3pI6kAwvauZy12UA8kIDnZz3PcLw2qwUHlTGSZ4fWVHhRkfOlqmDzIatGbS5cocZ3BJ5blBeNbiZxT1g1qSR5p/ixo2gXxWCwHxW6isa/hGJ0qAIqSpLzhcHZSDVdSjj0d+A==;31:ltdEvVSjCD6y4zEzk+yPlcYJONI5uwlGsvGrGMTSMoik4U5S6DNS+xamy8XiwFVZSAk7m8eXf2nb762+z98h0IPNzu+djpfKwiZbbGmGwoT04JgLG0W4Eq5oaYaA7aVDHQ6YqcQruMmEYHZs0N7jA9+18g5dtAsLPNDWJGlqHiV+uJZX43gIzBbh3zSKSgXOYcplTUyAW54iL1JttpEiCg0SV1zzCRXDgmNIiUEBnzw=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1333:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;20:P65K3FIyt9zbOYCn8yhcNOH7gQ5usqJs4k66cy4kf52/nhZ7lyFxTDcz7ycAe0lfAjP1e1CvrWSiRVRYBqGvlOkQH63TSIusY6fdiFGmaeqHGUlaZ6skYEGhNkdqLCzWJa4pThkK535zF6QWD0fwItiRVXnRCKkWSjzqfap56rcX6i+xM2NgRNC2lDfbINa8q23tCE3+/yf7988hQhZLmvLVKw+MIm2QTbD5YfNSLzSZ1wkciWYRFAvJctj+OExvcZxOl/kcG+yyi8wo/9fn5wswf/F0lPYsNTnddE8vZyvqOsWoDEr/0BYO05+RcOOvtu9DcE0C/vQyZVXPv2Lu4RsHRVVqF1OeM6NmuzN0ihQBv95uQDJw/ohavKEmqO6ycpnFI0gY6q0wx4fzidaGi5aKcdkyjrr7aeWmfNALyzaXKqc21HhMts5c08rgV6jwHjnh9xrkH5R2MbRBDLRbWJyqXW6/Njs6Ka5jjGUbp05b5+EZEuSZL/MeDsMARLom;4:1uPhKNqmllulzXnJIg4BCfETUhGG37hbH1ouGsUL7ie8k9H849qcxtVWs0txvCIrNP1rGz/8ZSnaLMh5AHRN4ufzGN3upkxmd0SrtiY8Xr4oOqndnhpvK3sO3gfq9GKFw+8lRB+ErHsmNordekuY6BZWFKPyPbGVf9J7WLLXisFn8++F1YAyTcYQ1535luJB0MQhgqD5V+wMKkb/7Ry/V/Gy7596zqqmEbTKQvzyAzCaDFxr7t+Hc3ZfLaNnYx44Jl9Ay8SfMImy2qkp38DrRGZ3ekgTzapeGdTbMJCO3bcMl0f7EhDW8bhJNo8IaVaEvl6opiOvfd10FmKj37Gzlg7lFNnjf3VJTv9R3DbUe6uOEaxdZygZ7/O0s+7Nb3S2
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1333199853BDCD7482432813CD710@DB6PR0801MB1333.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1333;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1333;
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(396003)(39840400004)(376002)(346002)(39380400002)(199004)(189003)(55236004)(26005)(7416002)(305945005)(97736004)(47776003)(66066001)(53936002)(25786009)(478600001)(8936002)(5660300001)(8676002)(9686003)(6666003)(59450400001)(6506007)(2906002)(386003)(103116003)(230700001)(16526019)(7736002)(186003)(6636002)(81156014)(81166006)(61506002)(33896004)(486006)(316002)(6116002)(68736007)(58126008)(76176011)(39060400002)(23676004)(55016002)(476003)(50466002)(52116002)(86362001)(2486003)(575784001)(105586002)(3846002)(106356001)(956004)(446003)(11346002)(7696005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1333;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzM7MjM6MzNabDZOZS9iaFhLWm9FUzN3L0NUR1Ev?=
 =?utf-8?B?M0QvVHdFMDlPVW1tUTNEZGRVWFB4Z0U1emtwTUlLeDlsYmJwd2tKSExJbnYz?=
 =?utf-8?B?QU1odWJWYzFscGh1dmtvS1ZweFN4T1d4WW5HWE9Db3JWRFVMSmpZK0V4emRD?=
 =?utf-8?B?Y3c5RFUzTjMzN2plTDVHN3BWQUQvOC84a3JZRjRJcjRtUzROZFN6bnhtZkhv?=
 =?utf-8?B?aWh1RHdReTJQcFFkcVAzNWlzeUt1b1B1R3AzZ3lVVkVwbFB2clpZRlBrU2VG?=
 =?utf-8?B?OEJkb1lIamUzT0ZBZ25jQ3pma3ZGalk4T3Z5bEp3aDBaUmFuenBkZWFEWk9Y?=
 =?utf-8?B?Zjd6SVhNa3VnNlBtRTlKMDVzSXh4czR6d0hGdEJYZFM5MlR4aTFqMHNPMXRu?=
 =?utf-8?B?STZ1elhxTXd2M3J3YVN3dWVhLzZiNWVzQ0JOU3RHT2duWktWSCsrcUtWK3pl?=
 =?utf-8?B?Ny9QV1lqTkxtdDZiWHhPRXN0dVVuL2o4cEYrY2Vld1VMazcrVXdCaldnSkhQ?=
 =?utf-8?B?M3RVWktFVmdIcHd4V3hpcGVVRTZNajcwOWVzVGdnWVZ3Y2gxVlRKZEo3L2RF?=
 =?utf-8?B?azllcE9JdWNkN0hiVWdDV1BFVlF1ajBWM3VuRmsyazc1aFk1NUlseERLNUVs?=
 =?utf-8?B?ckVxYWtmKzBDemJkbHVEQXdwNzhqelVtaUx1VmljeHVpa0dYOFVjOFRHZlBY?=
 =?utf-8?B?SWIvWERyWkVjcFlnRnZ2YzNVM05TUTBiMVJmYjlYTU5jdEpGaHhlWXU5bkdO?=
 =?utf-8?B?M2Y0THVLd2Y0N3BBMzdaYlVrTGRFR1dXemRsUTZHTTc1SmQwMjJ0eEVSN1h1?=
 =?utf-8?B?bFI4VWVleGszS3ZKMjlkSkxNbWdMYnRibndiMGNFYnpjNGdVdUdhbjNzNjkz?=
 =?utf-8?B?V3ZsUSt4WE5wWDc1NHlEWFE4cmlFb2pDVU5WYmY0NE1FQTd4WG1hNWd6MVBR?=
 =?utf-8?B?bHRFb0V4UURiWTk0T21RbTBueFFZVCtlYWh6dEY1b2hveE9mdkxUc0FOWHVN?=
 =?utf-8?B?UFdSeTBIYnJvbVBGUHdmWUI1Smt5R1Jwc3lxMGNVZE9RVGFySCtWemtZTU9i?=
 =?utf-8?B?VGNhUTFTZEM1R3U3K2N4V0tEbUpGVnRLSUF4OHlodkhWbTMxNVV3UC8wQ0tE?=
 =?utf-8?B?c3JjYjArbXpZVGZCamRrcytQL1ZmT3R3cGx2MDlpTUV5akF4a3JUSFUxR0Fo?=
 =?utf-8?B?QXo4OWNNcm1FUi9NU2RiQlgrVS81SWFRN0pGbmVPOXQvV1cvVEY3QWRkbW9s?=
 =?utf-8?B?VGw3RHg1blNlTmEzaTRnT0ZSR2pvV3VqYTNCL0JsR0JPR3VRa3ByNzZHZ2dE?=
 =?utf-8?B?ZUYzaTl1MGJ6ZC96SUY4VnFOU3MwR3dRbWJ1OWw0bTV6TmR1NU9JSEEwUC83?=
 =?utf-8?B?Z3lRZW43SlA1WkRjWnZMK2o2cm1sa1VQOUZ1OXAzVjBZUER2OFAyZGprMUxw?=
 =?utf-8?B?UndJRk5YMndHLzUwVjEzbzE3VnkrZ01MSDFlUHRJWmFzYmN6ckJWZERITy81?=
 =?utf-8?B?c0VDOFcvbkx3NWdRWjd6ZVpwYm1uNTlOS2NzVlFlalhDdU52OFBVTktoamgx?=
 =?utf-8?B?bFNQRi9BeGJLTW0xSmhJM2w1OVJFdnhucm1lQlpWSmpWeWtHTEJqOWZiUWpt?=
 =?utf-8?B?Vis3S2JnZ25jOEtkV0RQY0ZwRitZNHBqdm00YkdjTUlycHFIMkJYakpVVWN4?=
 =?utf-8?B?em9ubTkwY3FhVXhKTjY0K2JjU01RV1ZuSGJMNGFkWGZQYUpaVFgwdU5ZUTJK?=
 =?utf-8?B?RlB4RitBYkM1ck9heVR3NHg3bUtNTHlYQUpBWkZCZVRrdCtETGZaU2NJSnov?=
 =?utf-8?B?QldUeTQ2ZUovZVlrUERGanBkRzNPUFhaY1Y2T0p6N3NSSlZQNzlWVWZ2OEFB?=
 =?utf-8?Q?9oGfh/sPnR8bg=3D?=
X-Microsoft-Antispam-Message-Info: gTBHDTqKqFBdmXRH8bSfEo3vyLR8KVz0Yl4RF03Mj4W0Ptcu7R6sBdcSn2pArYv3AaYXfaRLjBTBTeYlVVztGaJsceuXYiXE+r6sHhA7wD1AmSFTD/VBJBbxA82rGNF2gJHAuETnf0iSrg5Zkor2VZXWDFPLx+3qI4B9OXKv5/JhuGzwQUojZZKNciA+b9PRO86S2qG845e8wZMwGNmW//1iDEZBR6FcGh2yhpW3QGDTzsUkShWf/zNa0xqV5tsbbXR5CqRYEjL43KpVUclIIuHRkQAYbe2H9MW3ECil2PQ2r2yqYJhQFNbabVVGBAccJq3d3+pPlakgbTQ6xK0H4Q==
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;6:UG6FRSKTKZKTVpsFDORjILanZ0gyWxs+AG64K+tco46ptYPxTDoGtf9Abg7vHsQP+H/qSgEC9BsjHrkXkDy/emHRXxg/E28ssi58gencOHIJrYXZkOT1+9oxUdOJguCwvA0eX7eAR8pIebxxVqwJ/IRKMZ/DQ4+QGTZCd2fWZNB52vRwF/zhkLM+ylZNWLGDTNFSAtkD3gRq2J+MLJxvGD8vEVMhl4yGe1hUMNp6TEp/zqQ/TtDZWRdVPoLV7q/wNkdzri+RBySakJwfEYISnzC5E4PsDu5fG8RQ5iXn5CFtE8Wu+gBO6luBD5EVDA05GSX8CwQ02ykfeHtNplxYFlehMzrmCnIXphiZDnnqjun9XZSJxZFzJU9nWgYWdEddG5OF1fZoxkcnwZfeLjJCo+djKn2VYekPtpYxCIHTpVsdQZiVKQGKEOIc1WgWBcWOpoFZ55Bd/vQ8pdjElDxf9Q==;5:JUSuFu+D27BX4ggtAaSJ+FYCh46ogNYUhMQGjthSTk2/CbI4t83piVOH51BvIPtsbasndTmIaUXXVkX/Dku/YWFXjrnzqlRHaWyI/cELJq9dJ9PAFglkBjWEMp6UBwgVrxQ4aneUc6O9oIhN1Ii+QBy3Z52CeSkw+o57LChJsmo=;24:ATOrxcuFJ0C4MT+yCwqflh3uAcvK+obwLNnOXkNa3pYf1nJxw32vlksik3thxGOKUfWvwucYjyC5KUt8gl7uqgDTe2aXvua0zHhX0VOFCPc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;7:V82RLmPNxYSkPwCgdHeYgndLt55KVLc8b6tqGuWwUJqZdwuaTdZbztGcX2e/mc7Jwmo7PSiG3EfUuB5YToMm5jrizCVij7pBZML1v4OU6zRdkXqZpQcyROISy1kYb6FM1blzqtvfVKl1dQVjb79wf7PfSJfXD51LOPd9TiTJ02+H2IT+gK+ouPEOiS8fpSQp4xaP07ZB7RJ/qcDO2zvp1DCoF5Yem3/JuL9qvxahsIrYlL4YS+NNGBOLZ+r+NnWk;20:8oUgu12e0ko2BMdCZIsJcvfXe9Vp7fPEw7jLH7hzRA7W6pPEMYhmF5s8/rcPu7GjDrDN49yCgDdE6TKqNlMIum8Oqqs6ZwKgOzIn2CATgu97DIIuJSl00/1Vgiyli5awQGchlZvCXx/sl6UsUNq3qQzqTHjiEnYP1szG0e1FbKo=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 09:46:12.6878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5665cc04-85a8-43de-0d85-08d5d5005519
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1333
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
 include/linux/list_lru.h |   14 +++++++++-----
 mm/list_lru.c            |   11 ++++++++++-
 mm/workingset.c          |    3 ++-
 4 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 78227c4ddb21..f5f96e52e0cd 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -261,9 +261,9 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
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
index 2d23b5b745be..9e75bb33766b 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -53,16 +53,20 @@ struct list_lru {
 	struct list_lru_node	*node;
 #ifdef CONFIG_MEMCG_KMEM
 	struct list_head	list;
+	int			shrinker_id;
 #endif
 };
 
 void list_lru_destroy(struct list_lru *lru);
 int __list_lru_init(struct list_lru *lru, bool memcg_aware,
-		    struct lock_class_key *key);
-
-#define list_lru_init(lru)		__list_lru_init((lru), false, NULL)
-#define list_lru_init_key(lru, key)	__list_lru_init((lru), false, (key))
-#define list_lru_init_memcg(lru)	__list_lru_init((lru), true, NULL)
+		    struct lock_class_key *key, struct shrinker *shrinker);
+
+#define list_lru_init(lru)				\
+	__list_lru_init((lru), false, NULL, NULL)
+#define list_lru_init_key(lru, key)			\
+	__list_lru_init((lru), false, (key), NULL)
+#define list_lru_init_memcg(lru, shrinker)		\
+	__list_lru_init((lru), true, NULL, shrinker)
 
 int memcg_update_all_list_lrus(int num_memcgs);
 void memcg_drain_all_list_lrus(int src_idx, int dst_idx);
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 7621084d5a7d..077956f8d58f 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -552,12 +552,18 @@ static void memcg_destroy_list_lru(struct list_lru *lru)
 #endif /* CONFIG_MEMCG_KMEM */
 
 int __list_lru_init(struct list_lru *lru, bool memcg_aware,
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
@@ -600,6 +606,9 @@ void list_lru_destroy(struct list_lru *lru)
 	kfree(lru->node);
 	lru->node = NULL;
 
+#ifdef CONFIG_MEMCG_KMEM
+	lru->shrinker_id = -1;
+#endif
 	memcg_put_cache_ids();
 }
 EXPORT_SYMBOL_GPL(list_lru_destroy);
diff --git a/mm/workingset.c b/mm/workingset.c
index c3a4fe145bb7..79099bc5c256 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -531,7 +531,8 @@ static int __init workingset_init(void)
 	ret = prealloc_shrinker(&workingset_shadow_shrinker);
 	if (ret)
 		goto err;
-	ret = __list_lru_init(&shadow_nodes, true, &shadow_nodes_key);
+	ret = __list_lru_init(&shadow_nodes, true, &shadow_nodes_key,
+			      &workingset_shadow_shrinker);
 	if (ret)
 		goto err_list_lru;
 	register_shrinker_prepared(&workingset_shadow_shrinker);

