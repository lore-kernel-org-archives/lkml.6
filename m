Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3E5C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35E520840
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MRQqe2TA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35E520840
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbeJAHW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:22:59 -0400
Received: from mail-by2nam01on0116.outbound.protection.outlook.com ([104.47.34.116]:2013
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729591AbeJAHPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpAe1l8z+PWe/d9U5hzWDhTFDUQb3brhQc1Xa5ba0Yo=;
 b=MRQqe2TAsbibUhFMiP0OGunKVd5SsT8u+I9GVHEtDsxCTBzXrFqnJGs//WFDA4RTwESm5CHwwVSUdNJ/ahtMK0frUpf0+QSZMvs6CX91es9VhUvWRAUFvFKXmpfEDrXx0TugFPxM6s9pR+H/gaRlnCSHRN6c8mH9FAX7J1xFMjg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0854.namprd21.prod.outlook.com (10.173.192.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.4; Mon, 1 Oct 2018 00:39:44 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:44 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Heinz Mauelshagen <heinzm@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 20/37] dm raid: fix rebuild of specific devices
 by updating superblock
Thread-Topic: [PATCH AUTOSEL 4.14 20/37] dm raid: fix rebuild of specific
 devices by updating superblock
Thread-Index: AQHUWR8oGduZsNNIVEmKrBcfUqTfog==
Date:   Mon, 1 Oct 2018 00:39:05 +0000
Message-ID: <20181001003850.147107-20-alexander.levin@microsoft.com>
References: <20181001003850.147107-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003850.147107-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0854;6:1FCvBwzKIvcy1lfgAVMGzkSQd1BS4SUSBS7MfytlFbZyCCRh2SyunjNQmG9qYG3zgeMjCETx0xXZgNQkNHyiuibjhkYTnABNBdkEuf7LgXMAhSRtOZowvaYREfQKdiEBSnE1lr+u3bZ/EevKozK5P3r/W+GBP8yN5eLaixsB1Hx18ELQleW7H13EbRoo8Ekb4JUf7IH//9RlLNxw/qyUlSB0KayCtooObobWTUuSM8eM2fqXRugav1JZ/QdEycihRsNcRnwjjGU/NDFAecJFg0MFyueXOs9fLC+ro7vlW6RV1tIHksAM/FJtXJ1HXwz5vavkpUw4DphhPiDzLNeJGF+V9UWjUj6xB9XGOhk62vey+oA2LFvD61wAC8QwLgNXl+coOsqLEytx7nNw62Q1goON5Ic+C1NHmhe4h/9Fzc8z1tS93UAQFOQjq59hVzXWKBg3FPF95K0LASiRASuV8A==;5:nwPEmj1qZlpW4t70nzGMYM9w8eJhv8GfriIhJjUXXCqSX/rwnBYEAKzWzf4Vsew4wTvpXeFNwRBTy8O8S+FVEVgBLX8t2vOqdUMbD7zdktQnUEir/2uyGF7xshsg1g/s3aPs4wD9ivpEzlMgEGo7W1rHiFhJTVVvDfQYmqz0NV0=;7:XZUrWrj8rMCXyOCr3VLj2RTY1lB8SgfZlwC0bmYk+/G4gd4Wlg1TxvqgZmKIhxYlIJWu19ol7bh2UiVxnRGnokPa2L1vrhGXX7prPqA0woP/QS0iEccCFFo9ASn5oV7UmIrvscQKGkfhpM92DFap/FV4AQsXeX8Zd3W6zWMnGlV0xYXXP88aSCNd8l9uD89828nynLyT11HSYpw9Lq61fyCrT8plbYEKMe6+fUpUm+fRHJgq9sMpcYujiNNiucDv
x-ms-office365-filtering-correlation-id: 78257a89-4790-4da2-8597-08d62736622b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0854;
x-ms-traffictypediagnostic: CY4PR21MB0854:
x-microsoft-antispam-prvs: <CY4PR21MB0854061478E3EAC79F1E7FDAFBEF0@CY4PR21MB0854.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0854;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0854;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(136003)(366004)(199004)(189003)(6116002)(3846002)(217873002)(5250100002)(1076002)(71200400001)(97736004)(71190400001)(76176011)(6506007)(99286004)(36756003)(6346003)(26005)(2906002)(446003)(86362001)(11346002)(476003)(102836004)(2616005)(14454004)(2501003)(10090500001)(14444005)(107886003)(4326008)(22452003)(486006)(316002)(34290500001)(186003)(256004)(66066001)(86612001)(305945005)(25786009)(2900100001)(6486002)(106356001)(7736002)(6512007)(53936002)(81166006)(81156014)(6666003)(8936002)(8676002)(5660300001)(68736007)(54906003)(110136005)(10290500003)(6436002)(478600001)(72206003)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0854;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: q55ATOOHCgmNQrkVXRG58UvvSa5afIWzybDuFzr5Coid+r9Htm1kS0ickG/28bNxu3D5R11zl5DALkejQ6y40CPrOmuKFkMrxn3+7ywLPnwIRs/b4E6ptbrSGNufqG9Bx9OdAkXFvtHWGrrQGFUzu3Pwp8KbZ+c1qpCRUotWnb28Cg9GoVSDyB2P3K2IUNjFu6cnlI4TTDcUvHAJ4UECrSRSeXokDOkKvG2IjMxGmya+SRo+LMcJsOJ9edpzUo2+f+ayOYVUe2O6wfqOlq4jXArCOiDbL2eYAksQfmOqQfavfZw7YVAwt+s0kx/s47V7swavywUgQr6WXwcftSb0EmC1LuEQ/fCilXIuMCl25fU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78257a89-4790-4da2-8597-08d62736622b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:39:05.6336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0854
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heinz Mauelshagen <heinzm@redhat.com>

[ Upstream commit c44a5ee803d2b7ed8c2e6ce24a5c4dd60778886e ]

Update superblock when particular devices are requested via rebuild
(e.g. lvconvert --replace ...) to avoid spurious failure with the "New
device injected into existing raid set without 'delta_disks' or
'rebuild' parameter specified" error message.

Signed-off-by: Heinz Mauelshagen <heinzm@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/md/dm-raid.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 38a2ac24428e..151211b4cb1b 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3061,6 +3061,11 @@ static int raid_ctr(struct dm_target *ti, unsigned i=
nt argc, char **argv)
 		set_bit(RT_FLAG_UPDATE_SBS, &rs->runtime_flags);
 		rs_set_new(rs);
 	} else if (rs_is_recovering(rs)) {
+		/* Rebuild particular devices */
+		if (test_bit(__CTR_FLAG_REBUILD, &rs->ctr_flags)) {
+			set_bit(RT_FLAG_UPDATE_SBS, &rs->runtime_flags);
+			rs_setup_recovery(rs, MaxSector);
+		}
 		/* A recovering raid set may be resized */
 		; /* skip setup rs */
 	} else if (rs_is_reshaping(rs)) {
--=20
2.17.1
