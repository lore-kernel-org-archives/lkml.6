Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F218C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E41EE2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CIjsNnUa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E41EE2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbeJAHO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:14:26 -0400
Received: from mail-eopbgr680138.outbound.protection.outlook.com ([40.107.68.138]:20182
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729265AbeJAHOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2aUmbKTZ1B6KLGbOek+wT+KuJEqO9aLsioUQbeN9nU=;
 b=CIjsNnUaQA/+k/54OQg+jaYoWaQ3lx6yqRUo7plGQL5fc2lFHaG8owry69nIRPVaQkUSsTiYCOdnxUpPfPLuWgiAGKeSZ8tlhzNU5RvY2l0QARNoRgcQArbbwYMbP/iBBP44c8nlolCFIwX8v7/x++UMVfEj1VnFdL6FBKtOvdY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0824.namprd21.prod.outlook.com (10.173.192.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:39:00 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:00 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Netanel Belgazal <netanel@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 45/65] net: ena: fix missing calls to READ_ONCE
Thread-Topic: [PATCH AUTOSEL 4.18 45/65] net: ena: fix missing calls to
 READ_ONCE
Thread-Index: AQHUWR8T+ii+W29pC0i0xF6m3u3xRw==
Date:   Mon, 1 Oct 2018 00:38:30 +0000
Message-ID: <20181001003754.146961-45-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0824;6:kRb3ysaV9li4do4ylO+M1zcMuAhx4OLQQU09PmX09bcBTht9WlVS8eQg1BTHLCsZcuQ58Tfn+K2GiE6SUnBiiCKW9SoWhv3PoRw+U/kokDkBRU7a2qNbS0PLQbZXCrNbh1W0IDwJekaN9RzX8AG5ZCvOVobZF0/dQHe52w+q1maaR07DazlfQcWGw+B0Z1dd3gGgc0emziz2t+g2gsPpv9nGEa7fjAw/07RIcZqMx5dbA4EpFtV88BZXRFe9aK5Pf4+68H8yCJqLa0Tnod306G8KFq2pacwPjDXlltu5Em20Pscb94rLLQMiQf9IBGY3X+MQQLxOd/onvpNeH0ANCeXdFcFOflOK+1QZ7pZbsJ09MrFjEmAm7Eadq9sc92PqdB3ue2y3HBMoVdsetgUbxku6RVKcjiIhrDG1RqTy3hQ4HDD6kAedFB39jPxR5cJSZIEQmBqnkpUuQjBIwmchsA==;5:0xo0U9KXL8uuYWx+MESZG3gfUD6brieN24bzwFMvC9yvWbaJccRCZiMcFhSUs0+dKcvf9rEvnT2Do5D4Nsvy9UtcN+VFi2Z2+gBV8zg4fgeq2YYxirgusHVs13DowbMOjJa2CT1oTISO8UtZYgQEQWLvqrNwlrn8XRXCZl8iwBQ=;7:rKiawvspwnBV+hqS/Y9EibmhVM4DJDxGlweLx8mTy+f864ERMpB/PBHNVnnf23zeNkR0qtazIP5Hu3Lvoayu7iEemvBPe0ZlNwNM+dT8BuGzO9f96JeBh765ezgptfpJ7KB96SCHxq3WY87W+ndqiuEq5z96/sH9HO4POJxZsZIybRc1nS4e9PN3/N/vOPCEaROlTgsvUoZKM12Q2/2NkJq7ZjUKTMWCJ0EjsGfESNrw0cBdAFSAxyuwGiY9DbM2
x-ms-office365-filtering-correlation-id: 422a7779-d0ad-4412-a7f8-08d627364795
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0824;
x-ms-traffictypediagnostic: CY4PR21MB0824:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0824D23089ADE01ABD413E02FBEF0@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(47284530071512)(33061846794335)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0824;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0824;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(396003)(376002)(136003)(189003)(199004)(256004)(99286004)(86612001)(22452003)(2906002)(25786009)(2900100001)(8936002)(14454004)(5250100002)(36756003)(10290500003)(76176011)(2501003)(478600001)(316002)(68736007)(8676002)(72206003)(305945005)(81156014)(6506007)(110136005)(54906003)(7736002)(10090500001)(81166006)(107886003)(66066001)(486006)(86362001)(6486002)(105586002)(11346002)(476003)(446003)(2616005)(53936002)(4326008)(1076002)(6512007)(217873002)(6116002)(3846002)(6436002)(97736004)(34290500001)(102836004)(6666003)(5660300001)(14444005)(26005)(71200400001)(71190400001)(186003)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FTgqkFSagbFSCbrWXy8PocLsEmgfI1S1qrAJvJtgJud6hocc499lDslhlbqBnXVDU+KuhlBqdie7tHSZ/26+/eznke4mBgoUdWqLcchgLt4vsAPJ9A7D8cEqCyxrUIYYdDB+3KjIqRRky1qTqVlbb4/aq++l0fYosbmL/gEHc9j6M1rmYSDKCO8kOea/99iofR85BWW6hh2Ue46AoJVinCeBbk53RRHDCi7d4bmV2Kw8xuaIE3vg/x0TTkVtg3UMF7k3nIJ4Tw7VS/UvO3sfEiuws4u+vWyPamCdKcCaqabOdmcUYpghfBakB1BPvg0FGdWHOR8L9xuEa012356FSP09Zu2xqJ+ll+8+VxBYR8Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 422a7779-d0ad-4412-a7f8-08d627364795
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:30.3744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Netanel Belgazal <netanel@amazon.com>

[ Upstream commit 28abf4e9c9201eda5c4d29ea609d07e877b464b8 ]

Add READ_ONCE calls where necessary (for example when iterating
over a memory field that gets updated by the hardware).

Signed-off-by: Netanel Belgazal <netanel@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/amazon/ena/ena_com.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethern=
et/amazon/ena/ena_com.c
index 17f12c18d225..c37deef3bcf1 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -459,7 +459,7 @@ static void ena_com_handle_admin_completion(struct ena_=
com_admin_queue *admin_qu
 	cqe =3D &admin_queue->cq.entries[head_masked];
=20
 	/* Go over all the completions */
-	while ((cqe->acq_common_descriptor.flags &
+	while ((READ_ONCE(cqe->acq_common_descriptor.flags) &
 			ENA_ADMIN_ACQ_COMMON_DESC_PHASE_MASK) =3D=3D phase) {
 		/* Do not read the rest of the completion entry before the
 		 * phase bit was validated
@@ -637,7 +637,7 @@ static u32 ena_com_reg_bar_read32(struct ena_com_dev *e=
na_dev, u16 offset)
=20
 	mmiowb();
 	for (i =3D 0; i < timeout; i++) {
-		if (read_resp->req_id =3D=3D mmio_read->seq_num)
+		if (READ_ONCE(read_resp->req_id) =3D=3D mmio_read->seq_num)
 			break;
=20
 		udelay(1);
@@ -1796,8 +1796,8 @@ void ena_com_aenq_intr_handler(struct ena_com_dev *de=
v, void *data)
 	aenq_common =3D &aenq_e->aenq_common_desc;
=20
 	/* Go over all the events */
-	while ((aenq_common->flags & ENA_ADMIN_AENQ_COMMON_DESC_PHASE_MASK) =3D=
=3D
-	       phase) {
+	while ((READ_ONCE(aenq_common->flags) &
+		ENA_ADMIN_AENQ_COMMON_DESC_PHASE_MASK) =3D=3D phase) {
 		pr_debug("AENQ! Group[%x] Syndrom[%x] timestamp: [%llus]\n",
 			 aenq_common->group, aenq_common->syndrom,
 			 (u64)aenq_common->timestamp_low +
--=20
2.17.1
