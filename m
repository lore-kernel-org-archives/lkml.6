Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D1AECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B852D214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cr1XoY8h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B852D214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbeIQIpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:45:16 -0400
Received: from mail-eopbgr690110.outbound.protection.outlook.com ([40.107.69.110]:61545
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730473AbeIQIaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRN3kjohMR/5Nsw3CwEafdk+bPVcwKBd8Lra9KizPWc=;
 b=cr1XoY8hydSKT5M4MaEnRPBRchjeRnwri4oB7w7NPgn/cuKVNazGuGMz3PhJfDg2jnf/46CNU3R72DMqsQlLkEh1EavF2Esz2xa6guhcnYtIvOiOrh1tB6gFgXA9CViLcAW/sa/S1jaSKD6QtUwRfayI4sDN3ctX9rIGVzVr08g=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:05:06 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:06 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 03/57] vmci: type promotion bug in
 qp_host_get_user_memory()
Thread-Topic: [PATCH AUTOSEL 4.9 03/57] vmci: type promotion bug in
 qp_host_get_user_memory()
Thread-Index: AQHUTjMMNalv85/kAkqWak3faG19vg==
Date:   Mon, 17 Sep 2018 03:03:45 +0000
Message-ID: <20180917030340.378-3-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:zybchS8s8T3J4glBf3xm/woqskI5GodkeZf5/++k35aM/hZu+9whGMXJ/KMhavqWMecAtUuYWcAlrZz8Eh/FljwXKk+aPwtBqAIqy0AajiWZFk2LQbjmiamytQRPnYhjM2acjApXE7hNapfkUCVRW9LUMkTM1BdXNUbGs/MeN0y9z/W77qI6VFAb235x7l4lFZwq0rR1eP9KDQixzDkoem3ASepP6lFVTG8VS1Wjq9+Qvhhe8UIaZ0KOOAm+zU1k+HSlMsvfVp4rvMLVDCiUbMdbMINO0wqM9c4dU4KGJ8fLpSiP3yBq8BIqeW9lgiKpl/kqzOQd6cgx92r2s5mUXcj1RuDdMUsrfwMqz2PQNf74gx6HKkQui0yzOhc+TItzB46K2ea/qLnlm5WRxASWHJaSD9wN3ZuLBSTqQ5lm0FYlwqwH0J2fYZ1MWF5A/24T8MnHtcxrgeBaWDslUF+qFA==;5:v/4NNHIxte4LL4hepMFkeQPUxyaA+YappIkd6S9z28A58YRgmWouwElGt1bJHdX3h2iWNb+9yc4NdkrFB0xcvX1bGyGVHqhP04hYnOfDFBH7BG4xh7yNwkeaMYq2kodIN5Py/8T3UAp/QsFug/7UNS60gS3SXEO8vSrpaqGEoLk=;7:WEgqHn3RRwpbMtwOefgd5DI/mrfPlgQOJM3LQETl+9AMHEqwnxy/t+FcQTz0rYmdbRsjF/I37HmH2AA/q9tLNVPmzfgpTQHpN1cZMZTgBP5BIYO1tg/8fW7sL8xAZDX0tnblC/LIKNm/UO1/KTA8Ps+j/lja3T1gjwM8gvA91ENd+/a/a2aNU9K64+0lykKuikU8GUwp/76IRirN3F5ssGzbqecwBTQBLvCr83L/ROZ3PeDFXbjuMIVzVDEkrHLd
x-ms-office365-filtering-correlation-id: 5abacb49-3755-4954-3805-08d61c4a5ec4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-microsoft-antispam-prvs: <CY4PR21MB012081D2C427B93A0135AE24FB1E0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(54906003)(26005)(110136005)(446003)(2906002)(6346003)(99286004)(316002)(86362001)(25786009)(102836004)(10090500001)(2616005)(2900100001)(76176011)(97736004)(36756003)(11346002)(72206003)(478600001)(10290500003)(3846002)(6116002)(1076002)(22452003)(107886003)(5250100002)(2501003)(86612001)(4326008)(217873002)(105586002)(106356001)(6486002)(14454004)(256004)(6436002)(8676002)(305945005)(8936002)(6506007)(81156014)(81166006)(7736002)(476003)(486006)(68736007)(186003)(66066001)(6512007)(53936002)(5660300001)(6666003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: u2bjYqG5NZwz6HOs7vcz+UbqCrM51+Y0FGX/nTodBa7JQtbQUHCNJIVDe6Ym/5xQeO+OGG+Bqn0nC8OlVYBmuNxXepODXrXtdc8aM54VKQ4nUPfSKxNcZGUYytF+chKRNmgZUDNsFjTBEI5xY6nI7gEe4TeCh3UR2VhQP85Kq86RBb0oqBHQCGhbJK0e5UAabOtgc3AifYCpW17phPil25hYYLO011/FXugZ5Q8CKyf/S7bf1EFFj9SMaM7FHsWnjf87MZB3wNoKxRkhv27l1SYlwV+Cd/PvZi5bXdlk374Ep5F1vJY51t9gYfW3/Q9ZiBUUCmtIYXexvCwvfSLmmVTHj1spsVz3NzN67DXAriY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abacb49-3755-4954-3805-08d61c4a5ec4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:45.7430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 7fb2fd4e25fc1fb10dcb30b5519de257cfeae84c ]

The problem is that if get_user_pages_fast() fails and returns a
negative error code, it gets type promoted to a high positive value and
treated as a success.

Fixes: 06164d2b72aa ("VMCI: queue pairs implementation.")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/misc/vmw_vmci/vmci_queue_pair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmc=
i/vmci_queue_pair.c
index f735ab4ba84e..5927db046a87 100644
--- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
+++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
@@ -755,7 +755,7 @@ static int qp_host_get_user_memory(u64 produce_uva,
 	retval =3D get_user_pages_fast((uintptr_t) produce_uva,
 				     produce_q->kernel_if->num_pages, 1,
 				     produce_q->kernel_if->u.h.header_page);
-	if (retval < produce_q->kernel_if->num_pages) {
+	if (retval < (int)produce_q->kernel_if->num_pages) {
 		pr_debug("get_user_pages_fast(produce) failed (retval=3D%d)",
 			retval);
 		qp_release_pages(produce_q->kernel_if->u.h.header_page,
@@ -767,7 +767,7 @@ static int qp_host_get_user_memory(u64 produce_uva,
 	retval =3D get_user_pages_fast((uintptr_t) consume_uva,
 				     consume_q->kernel_if->num_pages, 1,
 				     consume_q->kernel_if->u.h.header_page);
-	if (retval < consume_q->kernel_if->num_pages) {
+	if (retval < (int)consume_q->kernel_if->num_pages) {
 		pr_debug("get_user_pages_fast(consume) failed (retval=3D%d)",
 			retval);
 		qp_release_pages(consume_q->kernel_if->u.h.header_page,
--=20
2.17.1
