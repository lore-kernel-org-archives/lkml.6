Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9114C64EB0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7344C2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WhJFqaFb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7344C2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbeJAHOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:14:10 -0400
Received: from mail-eopbgr690117.outbound.protection.outlook.com ([40.107.69.117]:44672
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726694AbeJAHOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POy9bh0CBqtS4jyjqoKJ3/hjD3kfOwOGh6PTe35daUA=;
 b=WhJFqaFb1BxAIEFTZGSc0YtJ0hgyLgMCDXhF2O3KLvZh4JD1vduPiEgzsYwh3pzqoHMH9Ye6jkXp7FwDKel97C4riZYGJHg5M5Ip382UJ7hM18QqGqghU6gjvjlvkfKDAZ4JSddck0cUqFg3RxVqnWoSZsaMJKAupK7SDxaxxTc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.6; Mon, 1 Oct 2018 00:38:54 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:54 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Heinz Mauelshagen <heinzm@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 36/65] dm raid: fix rebuild of specific devices
 by updating superblock
Thread-Topic: [PATCH AUTOSEL 4.18 36/65] dm raid: fix rebuild of specific
 devices by updating superblock
Thread-Index: AQHUWR8QQKL4L4SWn0mvJzoBwbrcyw==
Date:   Mon, 1 Oct 2018 00:38:25 +0000
Message-ID: <20181001003754.146961-36-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:2FFZKglx3n8TqYn1B3BAEXJRI90nljPUOtFPtRjo2865ME3fPgQEnSTr6wYHhnrtR2x9bWtB82cS/RIdEDc9zKXZn3LuThk7wmIo1OWEAvKYBf5IExNjFBzZ4LCrrnSn1xoOj8GLEEa2c/KhnXyDn0HHojWwqeViQU8FXkuSjnPySnFB/9vQj5NslAmNIb7I0xq0GCFPmeXNgscJJTG9KA8/I0NxEScaQ+ezvEQtwHxX37eQxO031gDq55AkUD1ZswZOj3ZeY0dmzBSdVsZHLttMOCX1TJtgjHvBy5fS16f93Lt30B3dtdcQSbIx2idPjTYit0UIfHMEZNrwR4O/h3wu1mZyysscNxHU2GRG5yUWKrBCfr3PkULAggusnKaCahWAX8zVPEhRT+ToxPjUnUQJP91sIzfzGsGc0uVIQwBigK2cwvEGedFW483IXlTWVrP4PXvKfyCPi3WhByTQ+A==;5:2LCzZ3x/K3iAvPxgZl5Aq4osmPFbt36UPl3T+2xdT9w9ESncCuToIxbJ+WXB2kIemoY6uMBPZbXylRseFd7LgDbzwpnLPD7Y4Z3FxvwYwbq+JgPK2nnkzIcb6JuwmAzQSdjmwFnV1Ly1G6gdRY/gVzEFa+FNTlHSEx/omiOGw0Y=;7:M2AGn+sFmHT8AwvmX1oq2E0kM4C2o3uLWubCfXFWr4Qnng4oy9lSr+Qj5m6zuyRqHkuczY65Dp4RkxclVS0agO9svfXdqwReKYZLkUVaBrY46HxrDACU7v+F0txd5ePzX6IFNxHnLvf+Hbl/Dp8Qs4VJKHG9jtgUgOlgQzntoBGOmn2Lm2H+I8GMFXPgfgGePXgvrISJsYECpYsrA2ynUjZARwI9tyXD3NBQ6YGe4YkxV2mW3A8BX1FoCf9ibBb1
x-ms-office365-filtering-correlation-id: 1e5a3935-e7b2-4470-5c92-08d627364436
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0181EBA91D7544CA03403AC9FBEF0@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(346002)(376002)(366004)(199004)(189003)(6512007)(71200400001)(71190400001)(6116002)(3846002)(2906002)(6436002)(1076002)(34290500001)(446003)(7736002)(478600001)(11346002)(53936002)(6486002)(66066001)(25786009)(2616005)(4326008)(476003)(81166006)(106356001)(72206003)(102836004)(86612001)(486006)(10290500003)(2900100001)(6506007)(76176011)(256004)(8676002)(217873002)(14444005)(97736004)(6666003)(107886003)(105586002)(81156014)(99286004)(54906003)(110136005)(5660300001)(2501003)(14454004)(5250100002)(22452003)(186003)(305945005)(26005)(68736007)(316002)(36756003)(8936002)(86362001)(10090500001)(575784001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gUmIHy90/I5umtGkGexopNPwGptAqv7CkwJs/TviqADiwsnTbjf4oz0hgUlopw2933/uWYIYAqDKedNmcAj2UvkbR4/veDePDjW/wlELV8dY0DHKSTXXczEJGIduo/8b5qT/s6+Mt6NAu8izw3H98ddiV4UyGzG62I3ghbw+A+r3QhlmVTuz59Fr8u4sO4ixKq+M92idKcrSYLEQQNgvvuS5JIeY3FERU3sZw80gFVEI9ujMHdfW4mIsFcgcMBStIJLnuLkvOr+AA2+vHn9APbvx8plPV/zkYKH3kj4/KTED/C9f7euZX+/I1ocXiVdPtrgNcvwuTtvtMQJdmMR8ZNLnHtoezb4q4GT9QgPwkxI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5a3935-e7b2-4470-5c92-08d627364436
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:25.4313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
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
index 2c0d8036fb66..3cd2cbd28758 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3126,6 +3126,11 @@ static int raid_ctr(struct dm_target *ti, unsigned i=
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
