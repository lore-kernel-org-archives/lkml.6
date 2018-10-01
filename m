Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4D7C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 941FA20840
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KgiiT/2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 941FA20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbeJAHOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:14:09 -0400
Received: from mail-by2nam01on0099.outbound.protection.outlook.com ([104.47.34.99]:20832
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729049AbeJAHOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hR03Kev8FLTiwZR4G4C+PINsQiTN9TdNequqhrUB77o=;
 b=KgiiT/2CgYuu2SHEVtno2EhvITHbkiBncJ3E0Sd2sjpEALPg/kA9q2RozQV4H2L7OAIf01J48oHNUZiso4S4SHDOFMrWWVnnqGNaN/3sCTvq4Iop4aiasWc//5bveZCz6BKXVZi0tDdqA3K0wmK8U7ckgOkodx7W5eLnT5fcvSY=
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
Subject: [PATCH AUTOSEL 4.18 35/65] dm raid: fix stripe adding reshape
 deadlock
Thread-Topic: [PATCH AUTOSEL 4.18 35/65] dm raid: fix stripe adding reshape
 deadlock
Thread-Index: AQHUWR8P/mU4BSGMXEWHfuz5j1eK8g==
Date:   Mon, 1 Oct 2018 00:38:24 +0000
Message-ID: <20181001003754.146961-35-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:SA5ixKtld/F/MJ9JuXeFjHHjbmnYyNn6F02LFCqJeXuQFnimqdkS1vSyFCV+KKS+Jgi1VmTLZCd89UEjkeQjcjIKhnxtXI0m5xOz4sGlh1yRZUN1eCBMOsYnOhuhbjwx81QlmnBp4nBiSWzuUtrA2kqdD0iIf3TFvhsgrKucglfScfo/wpBk8tWpgC/nHbrbdutmVdHA8G5LGBjujFO0McwCD2P8H1CCy+ajNGgVsjWAk9NHXQzDqlN9ZecmGezbrE6HxTNZwf+hJQW8F+lUJwwBrw6iwobm0rfv/PyuGD4LMfe1N1qbcyQnK4Lpl3dgvnLe+tGbrT2HdxRyee3FsgUpEbWNlnZxC8nSLHF6gRtC+1FuqBhk1PYVk5D+1k1wkpwE9ht7zvwO2RM0zIlB8pd++3nuF+Q4Y6fEd3w+BP/y3Iy6E7tZXLwJtbHTXfPGWDf5QyJSL2V/cr5lMWdvMQ==;5:wKSBZqYB3gO0rXQsHxl0y71W4JyP9lUptG+R8v+kxsAEAg4Pn55VHwku+VBhDls0Gpwfgk2J3vmhvnpPj/ohAqGnJbqOjIHJu2tAXFDeTqa9NmNLA/3Wpf+J213EBRP3pNhSUY2moBe66vF/X5+4vJnRkbiSVM2MTWHQwTRL5zU=;7:ZI41fi2l9Kra1O7BuBW8UTz4+NJmkXEZ12trhfBGx97BUy1kv49CwZfFmjtZMWwPfJhjGWnTnN7kN+BumZ12IpSyFy7wLw33PFh957qlw/ww374syN8fwElGyVS3KQnj0vqg3Cg7bkODMk5DlcEgfe+mLmSkH8GAi+4X8TnozglgSlNqQU1n962dvPvgglJjecEQ2VO+e+LgGP701f1pidVWYc+CmZmQ1tyfDQgAEF+MUFD+SZYAif9jAbvvlYa+
x-ms-office365-filtering-correlation-id: 4722b281-e308-4125-638b-08d6273643f4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0181C4C602BE33B5D8FF594DFBEF0@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(346002)(376002)(366004)(199004)(189003)(6512007)(71200400001)(71190400001)(6116002)(3846002)(2906002)(6436002)(1076002)(34290500001)(446003)(7736002)(478600001)(11346002)(53936002)(6486002)(66066001)(25786009)(2616005)(4326008)(476003)(81166006)(106356001)(72206003)(102836004)(86612001)(486006)(10290500003)(2900100001)(6506007)(76176011)(256004)(8676002)(217873002)(14444005)(97736004)(6666003)(107886003)(105586002)(81156014)(99286004)(54906003)(110136005)(5660300001)(2501003)(14454004)(5250100002)(22452003)(186003)(305945005)(26005)(68736007)(316002)(36756003)(8936002)(86362001)(10090500001)(575784001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9FuHhlGMw+AxWxGOxq4mEmBUuv+f10x8kXgTTKNk34SHjd8LsTyW2O/wFap9yFv3Vijjw05MCyLxvAfONGH1ZUWmM/hyZgLhqMGcigwqM7njtHS3xu6ynjJVL0HJ72EHTZ9aaICekMPQ/CSZdzoxq0X2ZaT7jb95VulzRMdK5tbCENDGoM1i5XZRCV2BjeNAw4KZcIQ9mRs/6ZJENv8I/+oraqpzVc+kyECJx8Mgmqdjwk99Zm5wQ6sGQHHuJ5He+DWxEckGxQtDVePo/Ha3HALMTqN6iEBNdXlUOtHScfitlmqUZqQEbjjronjhEhhh3ben0aJ4qhNMYXN20SIK4MGhH4Lp20cXylUO+PldK9U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4722b281-e308-4125-638b-08d6273643f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:24.8278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heinz Mauelshagen <heinzm@redhat.com>

[ Upstream commit 644e2537fdc77baeeefc829524937bca64329f82 ]

When initiating a stripe adding reshape, a deadlock between
md_stop_writes() waiting for the sync thread to stop and the running
sync thread waiting for inactive stripes occurs (this frequently happens
on single-core but rarely on multi-core systems).

Fix this deadlock by setting MD_RECOVERY_WAIT to have the main MD
resynchronization thread worker (md_do_sync()) bail out when initiating
the reshape via constructor arguments.

Signed-off-by: Heinz Mauelshagen <heinzm@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/md/dm-raid.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 0d30958dc78f..2c0d8036fb66 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3869,14 +3869,13 @@ static int rs_start_reshape(struct raid_set *rs)
 	struct mddev *mddev =3D &rs->md;
 	struct md_personality *pers =3D mddev->pers;
=20
+	/* Don't allow the sync thread to work until the table gets reloaded. */
+	set_bit(MD_RECOVERY_WAIT, &mddev->recovery);
+
 	r =3D rs_setup_reshape(rs);
 	if (r)
 		return r;
=20
-	/* Need to be resumed to be able to start reshape, recovery is frozen unt=
il raid_resume() though */
-	if (test_and_clear_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags))
-		mddev_resume(mddev);
-
 	/*
 	 * Check any reshape constraints enforced by the personalility
 	 *
@@ -3900,10 +3899,6 @@ static int rs_start_reshape(struct raid_set *rs)
 		}
 	}
=20
-	/* Suspend because a resume will happen in raid_resume() */
-	set_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags);
-	mddev_suspend(mddev);
-
 	/*
 	 * Now reshape got set up, update superblocks to
 	 * reflect the fact so that a table reload will
--=20
2.17.1
