Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11EFC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6043A2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="RjsNysh8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6043A2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbeIGFhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:37:00 -0400
Received: from mail-eopbgr690129.outbound.protection.outlook.com ([40.107.69.129]:53565
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725926AbeIGFPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ludkxMDujeA96ZMBEsBBzo6vS6+4+atljtWEoPKADKk=;
 b=RjsNysh8un9xakdI0VzwRI+nSN1vPskZcigjjPC0xy/02PIhnSXoQnRw/MVN8CBqkNm9bnN2uOdIk0XTf/CAEHKzhMgUYWulIVU+XtciFb1+tIRzk8MG0AGcfyO3R09MQ9gIQzDK4XgnT6t4/f2b5mu0q/6/PTf1bVzUTozUEIo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:36:50 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:50 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Imre Deak <imre.deak@solidboot.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 42/88] fbdev: omapfb: off by one in
 omapfb_register_client()
Thread-Topic: [PATCH AUTOSEL 4.18 42/88] fbdev: omapfb: off by one in
 omapfb_register_client()
Thread-Index: AQHURkLNBI7xBbQcBEmd7X70SoAiyQ==
Date:   Fri, 7 Sep 2018 00:36:23 +0000
Message-ID: <20180907003547.57567-42-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:pGwInXKefuNu1BsD3cblVcPISY/H7p+R79OQeLt1GeNUD2zx6hqyAZaStTM6Q74N+PTmUgj0JHKNe0IjWebR531WGBGWIai85WMh5eaul2NiSaizaDJ3m6I3sKj4pqIH4I5ihkObEAZj1fdg3bXTwKYCQRwttHNRpOowa16rd324macuvN7vcf0ztwF2BHpp9nGORztTBQdd6l5n9U38UYJAkujs2L0cD6EaXByXjJ6yJ1O3tdEvz64HnsG9fO2c/Q38gTCuzcIBiZOhtfyZJCG7NDatuze0pTW6fO3ipfS4YlRn6tLBATpL/6KGHqGHJMbtBKT7jC8liPyIB4bbVv5N+Iabg5cYs4KRDCjZMggT4CCg+M4KhYrLdkysdGkqCflk3syO34SBiEpzFPlLszhEeM0MAzlAKg9HJBYYkuyg3fHMIf+bS2CstWC0PhfASaCoGTUPTzFeVyyp7/c2gw==;5:bXFWafNTtY5nEdN0VEdfEzXbWb9+59YM42uFit4G1LEdzz9SPWC8oqFkL8WFCeePFNqGIOYNkZSs+Br6uygvQkJH5zqn7gVyvYSArLjSbmLr3k5a054HTDefGm+sdV3D90Gq7bQyJCoCwD4hxKGtzRjlj14jyqH/zQFaNJLlevQ=;7:ABt9bpbf3UQNOZqhorPziL+56jVHzq5a16xBMoTTfRL8Rhd3M8Kr99ev/dJi1uFuwpvepBWCopFdPdGf8JIh6bDxrH5YkVZLH6EtEmLvyTwY4BnhkuSoZNSz5SUxq41apUPAIWuzhxKCwearTCXWkH8hqV7CyGeDPf6+tU/POI2rIYgQksthKWsHc9wrZTac0FoeXl5chcjNORLWJbxuOkgfMfgssKo/c81linp5NMMRxI+GifhLn4K/VhEWEjeX
x-ms-office365-filtering-correlation-id: 530ee5f5-3a9f-4055-ad48-08d6145a0053
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07739D89BEA096C3AF0E0CD8FB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(131327999870524)(146099531331640)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(2616005)(476003)(4326008)(6666003)(11346002)(5250100002)(107886003)(2501003)(86612001)(97736004)(6512007)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(14454004)(1076002)(66066001)(26005)(575784001)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(14444005)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vhmLNbJHW8Fg8N8NF0wxs6FfSW3/t+/bIdFrZPONJ0fg/oVl1y1arq+M7eh0XkIBs5uKRP14tnqk2+mk2tuThmLT2OPSwuDzAuOl5qIEP07Ii+nDU+pcWNQYMOjI2Nw8RoGxMxFTZQ4BLCkKpo9dqkQ9W0qpmB/+uTt93ZMGbO2JXUtmAdZM6rgDH7FEK+aezHqfhQ3+Y4qap+Fa9Y4aq0XhIfBiOgoHvU8rj28oKzGecDP044McbCxFatzMmv4et275wFR/UMwvMp6d/JUFioiHpQ2YlGIApuyRA3fsRSfJIWzPPf2VZyII2b9PCkfCkVoRyRvkW+7/Td7XXLnza0Egr/Zf/0hs6M+RoZqWXGg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 530ee5f5-3a9f-4055-ad48-08d6145a0053
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:23.7748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 5ec1ec35b2979b59d0b33381e7c9aac17e159d16 ]

The omapfb_register_client[] array has OMAPFB_PLANE_NUM elements so the
> should be >=3D or we are one element beyond the end of the array.

Fixes: 8b08cf2b64f5 ("OMAP: add TI OMAP framebuffer driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Imre Deak <imre.deak@solidboot.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/video/fbdev/omap/omapfb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbdev/o=
map/omapfb_main.c
index 585f39efcff6..1c75f4806ed3 100644
--- a/drivers/video/fbdev/omap/omapfb_main.c
+++ b/drivers/video/fbdev/omap/omapfb_main.c
@@ -958,7 +958,7 @@ int omapfb_register_client(struct omapfb_notifier_block=
 *omapfb_nb,
 {
 	int r;
=20
-	if ((unsigned)omapfb_nb->plane_idx > OMAPFB_PLANE_NUM)
+	if ((unsigned)omapfb_nb->plane_idx >=3D OMAPFB_PLANE_NUM)
 		return -EINVAL;
=20
 	if (!notifier_inited) {
--=20
2.17.1
