Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91156ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE4D208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fdoEeR0l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE4D208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729970AbeIQI26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:28:58 -0400
Received: from mail-eopbgr680131.outbound.protection.outlook.com ([40.107.68.131]:11025
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729890AbeIQI24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAOVIozYlcg2+iicfNBxgngCrlUpCV3MPpnZ8GJazPA=;
 b=fdoEeR0lqoWggggO9BkBAbYTBeMJ5GdaJtlF4c6NMUknEfTBzk0cEYWRskO4D4c20IiMGhUkSKQb5VxuTijXGXljjoX679l9BTUT6Qz+7EdFywAMAu2Xk3Kd+z8QBJISMCJnJjyY8KlwHJ9mgIJSQxm7edOpAdIrLm9BscjE3QA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:03:36 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:36 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Guoqing Jiang <gqjiang@suse.com>, Shaohua Li <shli@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 19/87] md-cluster: clear another node's
 suspend_area after the copy is finished
Thread-Topic: [PATCH AUTOSEL 4.14 19/87] md-cluster: clear another node's
 suspend_area after the copy is finished
Thread-Index: AQHUTjLi2hb4CFkOq0W7UHYNEARdDw==
Date:   Mon, 17 Sep 2018 03:02:36 +0000
Message-ID: <20180917030220.245686-19-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:igwUeyqWQc18O0o6sZ9MwOVy59hWIkTkMzk+6jPOhdK0fFThNq4sx//Wm+h800wSOSm/Ufi2NnipinxKfIw0RMQBAFIOaopwpLkwDKdqNPIY5qwBO0NuzIYOjEnTd4LWb+w7Eu6c+2N1tONNdny470Bc+GnE2KqB2ZCENne5NhbPZTOCxPtPXyD4rhzpfhhIPoS2YjWihyZgqeIUtriY1m78VuR7PIBRZmDONb5QbKTXl430KdhIK7552hl7XKWRxBQxh4VC4yM6YMlwntjShBYKnnauvSfsUsoyYCK9xAbSWbdNysIhWQArrPyLK6ofQbnt8M+c33wHfnH0h/Knp9nhCrI/cGlVOBLoM0kpWE5CqQH3PqB9g1JZ4KHeif5ZqVZtqXdLBh3RsGPamfVhMuEymcaWqg7WLG5X2367T0yUNpBkUSfpxN4JI8WvbqPLnssJqERfjBUu3G+p7Pjviw==;5:O1Ng1nAxCsfdg1+r5vmm5EHH8EaMkBmkeFhy6FyOfejRopagQsLFD6h7O2CEdEpQLVp234zCOjsQlHFo3C11fE3oQ898NNNYu1NFvAhrErU2hZ2FT1HrWsDLeGENjbWdmmEz/4wywzmUoSpAbYE1kGNLldo633fEHjLEjur994Y=;7:DycjCqoUHdCEjK9hVNeFXl24ltzunNdOJP7HBUiluuUnmgI1fRK8okcHvTl0nWWCGsHc5o0NyN1+jVJ4v4Lx8NDHVMwi3Esuc84/CUExaRzZLvcj+br9QX12WUUJDjb4yKnuymVZ1zpjwE6mRs18k5kr2fwaHTq1Yi9A6QyF0Fpgp1qfhgoewqkasccx7mtjMfIljNaZuSmw3N+12AzF+FyxYbKzdtWCEmeS/KBQi6mUa6W6unsZc7Dr77AzhgQ8
x-ms-office365-filtering-correlation-id: 7da422ac-5536-4c2e-9742-08d61c4a2926
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
x-microsoft-antispam-prvs: <CY4PR21MB0470EFA960C5CB60E69C8F45FB1E0@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(366004)(136003)(189003)(199004)(15650500001)(1076002)(25786009)(4326008)(107886003)(5660300001)(3846002)(6116002)(54906003)(110136005)(22452003)(316002)(86612001)(76176011)(53936002)(6512007)(68736007)(7736002)(305945005)(86362001)(575784001)(2900100001)(256004)(66066001)(8936002)(11346002)(446003)(10290500003)(6486002)(14454004)(81156014)(486006)(6506007)(2501003)(99286004)(26005)(2906002)(10090500001)(478600001)(72206003)(105586002)(6436002)(102836004)(186003)(8676002)(2616005)(476003)(5250100002)(36756003)(81166006)(106356001)(6346003)(14444005)(97736004)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Z+QJEoZ0lX0pwNWPRKNDUQvlAya5a1mkLx0VUQmKTsOf8FMoVnIbNHwrxnJrrkDy2Qa7A7XHoHEXjIqI48N+AlTHhzVzOYCSc9ql2Y4ltYF1aUYXwwIxCSH6mcL2N7zVN+ntbA+TtCpmTw1dAbcfJqcTADIflgtOhwcFYvY9ixaW2f2Np00oIMadbzbQcfq3mvIzL6RavjkyF3ISY8g465ZO0wAB/qXUV9op1XvWPEoHVCRvKGieg0mw4E10q9Ih/YaYaTUZl47hryqc8P29sKwn1NcVKVcVJ0ChuiLDnzNu0jhUIxk4FQx6KdaW8uz9RzIc53RKsvnUdsP25hxg/oCEaLmSxHY1x1VQMcjx3z8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da422ac-5536-4c2e-9742-08d61c4a2926
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:36.1969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guoqing Jiang <gqjiang@suse.com>

[ Upstream commit 010228e4a932ca1e8365e3b58c8e1e44c16ff793 ]

When one node leaves cluster or stops the resyncing
(resync or recovery) array, then other nodes need to
call recover_bitmaps to continue the unfinished task.

But we need to clear suspend_area later after other
nodes copy the resync information to their bitmap
(by call bitmap_copy_from_slot). Otherwise, all nodes
could write to the suspend_area even the suspend_area
is not handled by any node, because area_resyncing
returns 0 at the beginning of raid1_write_request.
Which means one node could write suspend_area while
another node is resyncing the same area, then data
could be inconsistent.

So let's clear suspend_area later to avoid above issue
with the protection of bm lock. Also it is straightforward
to clear suspend_area after nodes have copied the resync
info to bitmap.

Signed-off-by: Guoqing Jiang <gqjiang@suse.com>
Reviewed-by: NeilBrown <neilb@suse.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/md/md-cluster.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
index 72ce0bccc865..717aaffc227d 100644
--- a/drivers/md/md-cluster.c
+++ b/drivers/md/md-cluster.c
@@ -304,15 +304,6 @@ static void recover_bitmaps(struct md_thread *thread)
 	while (cinfo->recovery_map) {
 		slot =3D fls64((u64)cinfo->recovery_map) - 1;
=20
-		/* Clear suspend_area associated with the bitmap */
-		spin_lock_irq(&cinfo->suspend_lock);
-		list_for_each_entry_safe(s, tmp, &cinfo->suspend_list, list)
-			if (slot =3D=3D s->slot) {
-				list_del(&s->list);
-				kfree(s);
-			}
-		spin_unlock_irq(&cinfo->suspend_lock);
-
 		snprintf(str, 64, "bitmap%04d", slot);
 		bm_lockres =3D lockres_init(mddev, str, NULL, 1);
 		if (!bm_lockres) {
@@ -331,6 +322,16 @@ static void recover_bitmaps(struct md_thread *thread)
 			pr_err("md-cluster: Could not copy data from bitmap %d\n", slot);
 			goto clear_bit;
 		}
+
+		/* Clear suspend_area associated with the bitmap */
+		spin_lock_irq(&cinfo->suspend_lock);
+		list_for_each_entry_safe(s, tmp, &cinfo->suspend_list, list)
+			if (slot =3D=3D s->slot) {
+				list_del(&s->list);
+				kfree(s);
+			}
+		spin_unlock_irq(&cinfo->suspend_lock);
+
 		if (hi > 0) {
 			if (lo < mddev->recovery_cp)
 				mddev->recovery_cp =3D lo;
--=20
2.17.1
