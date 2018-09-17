Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D8FECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C35214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gqUOvuuR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C35214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbeIQIbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:31:08 -0400
Received: from mail-eopbgr690131.outbound.protection.outlook.com ([40.107.69.131]:27472
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730114AbeIQIbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=juRtVTK7AuApLJA3Re0fRd3r6zi1POASPmLgH/tuKp8=;
 b=gqUOvuuR45oDNesnWwCVXOWTbFyQwJJPiny1u+rdRE0jP3TwrHd3L+59v+E6Ne+/VY6d9dlOprjTFY7bAOgYb+7c29RK1zyPRz0m+/ySYYfZabBTa3YbLFlBFIqR20zwHDj0xHnXnrkYXYs4RywcWf6phV3ciGkLeBB8jKCF5dE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:05:40 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:40 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Guoqing Jiang <gqjiang@suse.com>, Shaohua Li <shli@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 14/57] md-cluster: clear another node's
 suspend_area after the copy is finished
Thread-Topic: [PATCH AUTOSEL 4.9 14/57] md-cluster: clear another node's
 suspend_area after the copy is finished
Thread-Index: AQHUTjMQAQrzrxiZPUyLBQz1CSpM1w==
Date:   Mon, 17 Sep 2018 03:03:52 +0000
Message-ID: <20180917030340.378-14-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:TwZmKn+/4+t0d0DmO6/GCxgzh0LdKWe76T2p7rctetI0Sx3nIo2Cqk5vtEaIhs1QMyTl+/fjd4IcF4ZBC6BJN9SaKyFES7ai7eWBWFsq12ryzrPuGKNnluzaAZkjetIc4Feo5CdX6U6niweRU8qv7cnPVgJOAzF/Ai3LhwL581D63Vx+3dfJQoZxx9LgeRV2ujuPn0jj8nztcHD/SP24MoncKLt2nVdcdIyKA8U/RoFKf3FS3RkAwqDrLGLZ6R69XXvvGNmZZuoGSnBrv44YAUqo7H+lG5Lb/bpwac+8fwoe6wj215GEOCLcaqlep9CQfy5oys8gaz5WNaCYq/IpfI4d+l8mWRfE0vZJRjMw/yYyH0UAO9eXTwSjWWLrFkjewYOOt/GmuM1egGxuVYyn//WcKkNerhyboj4+ZsJ8EURlYoG22ibKRvqLrXa6J+F3DHVvY+1DaOrAL6zw8Q5sTw==;5:jsPot6Y1u2I39URVQYNl3Nkbp3wBXulWtNSRLXWFsKof8bMv/j69V0O1hD2W5EW+6u6FzMD/YfkurbJTzhMVzK3BJin41/rlCmxCsEIsjEccOn67AflhENUgaxzvxn+rJgt419bGlY08dcjLGNAXqEp86jG/0lgOaCAzY0TfWNM=;7:SwTMRQrkGZcPlRnKZz7bvMtOe0Uba6z8RRf+bDI9q8zazVKyLvPFlMrHqI2snbkrcLG4YxSAQnC+fWWHVJVJzxPxJlNOZ7yedKhhC+yE3h/PyFIiCFgMfMXaP5B7h4lCbwYDWQa4XIIiIe/9Vf7C6Iicc/YCmCPL2L5yMthVkSofpiLylPAl7xtKxI5chm8NmMcpPc1PAMuHYy743TXbL0zvqJUt1zEBLEYadLXM2e08XnzjKCUbot/RjsYaaik0
x-ms-office365-filtering-correlation-id: f0b9e735-ddfa-4e13-6039-08d61c4a7304
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-microsoft-antispam-prvs: <CY4PR21MB012015FFD6AD7E13767D82C2FB1E0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(54906003)(26005)(110136005)(446003)(2906002)(6346003)(99286004)(316002)(86362001)(25786009)(102836004)(10090500001)(2616005)(2900100001)(76176011)(97736004)(36756003)(11346002)(72206003)(478600001)(10290500003)(3846002)(6116002)(1076002)(22452003)(107886003)(5250100002)(2501003)(86612001)(4326008)(217873002)(105586002)(106356001)(6486002)(14444005)(14454004)(256004)(6436002)(8676002)(305945005)(8936002)(6506007)(81156014)(81166006)(15650500001)(7736002)(476003)(486006)(68736007)(186003)(66066001)(6512007)(53936002)(5660300001)(6666003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: RggULQlntjyg8PcqdXcL3iF4f7WZF2twamJMiacIvVTQK3+DfqHrkQ5vukE3Fmi+N1JO8kKgj0OMeOu+qJh0bMkL/rwfz9bXAQgFbxcxe1mlgMtWEYVpuUZKJynI6GC0SwlCLAhs6udJyF647u0qlUTsMXWDgrWEb13A5NU8uDmZruBNk+3IsKpQlaHrus6CHCxciq41nTmb8iGybCC1wVyUn7+w41uxYmzdKjqipgQnG+xEnLOTZafdtpTxiSjp+ABj8bOg7t7xZiAVQedsFl+Cp4OifTF0GtjpU9BcfhCGYtR1JfB9oQ4PMcBhiIluS5P35pIiRBUaH0kKWnLfaeXfmA+Hy7CivOCnb4Bn3t0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b9e735-ddfa-4e13-6039-08d61c4a7304
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:52.0710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
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
index fcc2b5746a9f..e870b09b2c84 100644
--- a/drivers/md/md-cluster.c
+++ b/drivers/md/md-cluster.c
@@ -302,15 +302,6 @@ static void recover_bitmaps(struct md_thread *thread)
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
@@ -329,6 +320,16 @@ static void recover_bitmaps(struct md_thread *thread)
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
