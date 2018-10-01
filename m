Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C11CC64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0409D2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DGDCqW3L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0409D2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbeJAHOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:14:12 -0400
Received: from mail-by2nam01on0099.outbound.protection.outlook.com ([104.47.34.99]:20832
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729068AbeJAHOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34odUVjMf3GRGSabkufWwdig5VFUGCsUcno7ZY/Rrz4=;
 b=DGDCqW3LZglr6SWiNoVWZqD6Ytcs/nVtnVqcRAWRFZHbg+lZyW8sgrBlOIlWKxn2Z98u9k8CE+jAe1RVs/NLRk0NqZodgl1kpNq9HdESE83ukqhZJ/kwrq39yZ0VvWnTByvrqZf07OmdpVSy3d1AlMYzUFQ8OOkpQdl7rQuu/AM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.6; Mon, 1 Oct 2018 00:38:55 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:55 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Heinz Mauelshagen <heinzm@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 37/65] dm raid: fix RAID leg rebuild errors
Thread-Topic: [PATCH AUTOSEL 4.18 37/65] dm raid: fix RAID leg rebuild errors
Thread-Index: AQHUWR8QHAfIAZ/W/0W29P5S/9HaMg==
Date:   Mon, 1 Oct 2018 00:38:25 +0000
Message-ID: <20181001003754.146961-37-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:Gf7nobWb1fkby9a1McUyZ+eFneKK370Q7VwdM2N7odCurlSP3zGJL3iyr90Ymf10FFLpEq025ODM4LdH1L6SyIKzypV8ZGONDlYCLiBg0z0sQv/HBe2y25X0cUBcoTasW8FBIe9gfB9xdFPrK4Ciz/1sd526NC+wesHnvy2deYQU0xTIzMePJGhK1Wgz5nENhZSVTOqBD8tLYcnxxVJzQkpMJRzs6vqzqJXHm2ebURdulkfi+UEI3jlVIZs9VZc0mB7HOtKz2PIPof7R9rfpXlpcdcRqKod+ef9UPYA1N1fwLMwlL7l0N+2EUS0DtIeuLV5ACerTDOcPS/lnqOTYS+Wq23pY8Os2iysWJEaipgQ1yYag1++2f+p/8Vv2fh4y5Up4e7VnHZHPljgR515XMbSnD7ha1uEiWtrAdHb5zTxGHKMA/sLNWCu14RZHEiZF09x7bEKiwubZio5m7jZWMg==;5:sQt1bbtgyaQ+FWsSXkQ0MXF8zsaGLNn7ryr9lCfxXYeq3831gCe8hyCmYwLPbyoHf+Lb+wYHe+e5GwASCFJ0/XMkQR3JiPWeZkyJI6BZcnwzybpUwBwRJ6Y0khTOhKqhpizhAUpoqalzHgnLdsPandKIZi1U8ll2GiNdRny8WT0=;7:6dhigo7LEPpvhwV63IASu/++vM86NVryl7/OMdFXxJgd1aQB+jHlAeOcoKV15yLDe1JuatQqn/xWmiU5gPY8B8uj5IzJdOppXp6ZkdPg3hJnv7CQeQLZoV3uDsXq00g4B+89PKZVv5eDCdz8z54Zu8EJVgfO8AHHDRTDdrATL/sAxfE6dJI2dQtCL3yvP/d58nrwnJ+XXQOrhqTlNCcTpAnt/r9klt+V8A7TxMMXCn3GPuraHW6dgMUzxzfnriDq
x-ms-office365-filtering-correlation-id: f3e88635-90bb-465b-af4b-08d627364491
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0181FA8FD8B60611A9ACBEC1FBEF0@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(346002)(376002)(366004)(199004)(189003)(6512007)(71200400001)(71190400001)(6116002)(3846002)(2906002)(6436002)(1076002)(34290500001)(446003)(7736002)(478600001)(11346002)(53936002)(6486002)(66066001)(25786009)(2616005)(4326008)(476003)(81166006)(106356001)(72206003)(102836004)(86612001)(486006)(10290500003)(2900100001)(6506007)(76176011)(256004)(8676002)(217873002)(14444005)(97736004)(6666003)(107886003)(105586002)(81156014)(99286004)(54906003)(110136005)(5660300001)(2501003)(14454004)(5250100002)(22452003)(186003)(305945005)(26005)(68736007)(316002)(36756003)(8936002)(86362001)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ephrgEdAn7W79ufCvlieVprh2TeYpal0KiC3YxeoWgL6h5AfbDTLkWQXAz+iqoujzdT08wyb+ke8+pOpSiCPawhVmQ85RBhaAbwPvrOpRHJ8K1W41yNJr8c78QLq+amCpDAyfgPBZKdLd/+wbua4cTjT692Euuvp/LAckTe6RJpdTilNN0l5h3ASjjhvHho96pE8w6V5LswjWkOiaPinvrlFAInsQjbReOqB0kHA7mBSeGugszb31a+ygxGnZ75WL2MXRIpvdE/F/oCbW119iilyFQ/E4Yz1RjgSkn36w/Bb6kt0wy8MVWmJUyjn/pTZB3tlWzTT2G1B2n2LS48bnDQTQf/bfXqBTAirX/abY1E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e88635-90bb-465b-af4b-08d627364491
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:25.9717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heinz Mauelshagen <heinzm@redhat.com>

[ Upstream commit 36a240a706d43383bbdd377522501ddd2e5771f6 ]

On fast devices such as NVMe, a flaw in rs_get_progress() results in
false target status output when userspace lvm2 requests leg rebuilds
(symptom of the failure is device health chars 'aaaaaaaa' instead of
expected 'aAaAAAAA' causing lvm2 to fail).

The correct sync action state definitions already exist in
decipher_sync_action() so fix rs_get_progress() to use it.

Change decipher_sync_action() to return an enum rather than a string for
the sync states and call it from rs_get_progress().  Introduce
sync_str() to translate from enum to the string that is needed by
raid_status().

Signed-off-by: Heinz Mauelshagen <heinzm@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/md/dm-raid.c | 80 +++++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 34 deletions(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 3cd2cbd28758..1c7c1250bf75 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3332,32 +3332,53 @@ static int raid_map(struct dm_target *ti, struct bi=
o *bio)
 	return DM_MAPIO_SUBMITTED;
 }
=20
-/* Return string describing the current sync action of @mddev */
-static const char *decipher_sync_action(struct mddev *mddev, unsigned long=
 recovery)
+/* Return sync state string for @state */
+enum sync_state { st_frozen, st_reshape, st_resync, st_check, st_repair, s=
t_recover, st_idle };
+static const char *sync_str(enum sync_state state)
+{
+	/* Has to be in above sync_state order! */
+	static const char *sync_strs[] =3D {
+		"frozen",
+		"reshape",
+		"resync",
+		"check",
+		"repair",
+		"recover",
+		"idle"
+	};
+
+	return __within_range(state, 0, ARRAY_SIZE(sync_strs) - 1) ? sync_strs[st=
ate] : "undef";
+};
+
+/* Return enum sync_state for @mddev derived from @recovery flags */
+static const enum sync_state decipher_sync_action(struct mddev *mddev, uns=
igned long recovery)
 {
 	if (test_bit(MD_RECOVERY_FROZEN, &recovery))
-		return "frozen";
+		return st_frozen;
=20
-	/* The MD sync thread can be done with io but still be running */
+	/* The MD sync thread can be done with io or be interrupted but still be =
running */
 	if (!test_bit(MD_RECOVERY_DONE, &recovery) &&
 	    (test_bit(MD_RECOVERY_RUNNING, &recovery) ||
 	     (!mddev->ro && test_bit(MD_RECOVERY_NEEDED, &recovery)))) {
 		if (test_bit(MD_RECOVERY_RESHAPE, &recovery))
-			return "reshape";
+			return st_reshape;
=20
 		if (test_bit(MD_RECOVERY_SYNC, &recovery)) {
 			if (!test_bit(MD_RECOVERY_REQUESTED, &recovery))
-				return "resync";
-			else if (test_bit(MD_RECOVERY_CHECK, &recovery))
-				return "check";
-			return "repair";
+				return st_resync;
+			if (test_bit(MD_RECOVERY_CHECK, &recovery))
+				return st_check;
+			return st_repair;
 		}
=20
 		if (test_bit(MD_RECOVERY_RECOVER, &recovery))
-			return "recover";
+			return st_recover;
+
+		if (mddev->reshape_position !=3D MaxSector)
+			return st_reshape;
 	}
=20
-	return "idle";
+	return st_idle;
 }
=20
 /*
@@ -3391,6 +3412,7 @@ static sector_t rs_get_progress(struct raid_set *rs, =
unsigned long recovery,
 				sector_t resync_max_sectors)
 {
 	sector_t r;
+	enum sync_state state;
 	struct mddev *mddev =3D &rs->md;
=20
 	clear_bit(RT_FLAG_RS_IN_SYNC, &rs->runtime_flags);
@@ -3401,20 +3423,14 @@ static sector_t rs_get_progress(struct raid_set *rs=
, unsigned long recovery,
 		set_bit(RT_FLAG_RS_IN_SYNC, &rs->runtime_flags);
=20
 	} else {
-		if (!test_bit(__CTR_FLAG_NOSYNC, &rs->ctr_flags) &&
-		    !test_bit(MD_RECOVERY_INTR, &recovery) &&
-		    (test_bit(MD_RECOVERY_NEEDED, &recovery) ||
-		     test_bit(MD_RECOVERY_RESHAPE, &recovery) ||
-		     test_bit(MD_RECOVERY_RUNNING, &recovery)))
-			r =3D mddev->curr_resync_completed;
-		else
+		state =3D decipher_sync_action(mddev, recovery);
+
+		if (state =3D=3D st_idle && !test_bit(MD_RECOVERY_INTR, &recovery))
 			r =3D mddev->recovery_cp;
+		else
+			r =3D mddev->curr_resync_completed;
=20
-		if (r >=3D resync_max_sectors &&
-		    (!test_bit(MD_RECOVERY_REQUESTED, &recovery) ||
-		     (!test_bit(MD_RECOVERY_FROZEN, &recovery) &&
-		      !test_bit(MD_RECOVERY_NEEDED, &recovery) &&
-		      !test_bit(MD_RECOVERY_RUNNING, &recovery)))) {
+		if (state =3D=3D st_idle && r >=3D resync_max_sectors) {
 			/*
 			 * Sync complete.
 			 */
@@ -3422,24 +3438,20 @@ static sector_t rs_get_progress(struct raid_set *rs=
, unsigned long recovery,
 			if (test_bit(MD_RECOVERY_RECOVER, &recovery))
 				set_bit(RT_FLAG_RS_IN_SYNC, &rs->runtime_flags);
=20
-		} else if (test_bit(MD_RECOVERY_RECOVER, &recovery)) {
+		} else if (state =3D=3D st_recover)
 			/*
 			 * In case we are recovering, the array is not in sync
 			 * and health chars should show the recovering legs.
 			 */
 			;
-
-		} else if (test_bit(MD_RECOVERY_SYNC, &recovery) &&
-			   !test_bit(MD_RECOVERY_REQUESTED, &recovery)) {
+		else if (state =3D=3D st_resync)
 			/*
 			 * If "resync" is occurring, the raid set
 			 * is or may be out of sync hence the health
 			 * characters shall be 'a'.
 			 */
 			set_bit(RT_FLAG_RS_RESYNCING, &rs->runtime_flags);
-
-		} else if (test_bit(MD_RECOVERY_RESHAPE, &recovery) &&
-			   !test_bit(MD_RECOVERY_REQUESTED, &recovery)) {
+		else if (state =3D=3D st_reshape)
 			/*
 			 * If "reshape" is occurring, the raid set
 			 * is or may be out of sync hence the health
@@ -3447,7 +3459,7 @@ static sector_t rs_get_progress(struct raid_set *rs, =
unsigned long recovery,
 			 */
 			set_bit(RT_FLAG_RS_RESYNCING, &rs->runtime_flags);
=20
-		} else if (test_bit(MD_RECOVERY_REQUESTED, &recovery)) {
+		else if (state =3D=3D st_check || state =3D=3D st_repair)
 			/*
 			 * If "check" or "repair" is occurring, the raid set has
 			 * undergone an initial sync and the health characters
@@ -3455,12 +3467,12 @@ static sector_t rs_get_progress(struct raid_set *rs=
, unsigned long recovery,
 			 */
 			set_bit(RT_FLAG_RS_IN_SYNC, &rs->runtime_flags);
=20
-		} else {
+		else {
 			struct md_rdev *rdev;
=20
 			/*
 			 * We are idle and recovery is needed, prevent 'A' chars race
-			 * caused by components still set to in-sync by constrcuctor.
+			 * caused by components still set to in-sync by constructor.
 			 */
 			if (test_bit(MD_RECOVERY_NEEDED, &recovery))
 				set_bit(RT_FLAG_RS_RESYNCING, &rs->runtime_flags);
@@ -3524,7 +3536,7 @@ static void raid_status(struct dm_target *ti, status_=
type_t type,
 		progress =3D rs_get_progress(rs, recovery, resync_max_sectors);
 		resync_mismatches =3D (mddev->last_sync_action && !strcasecmp(mddev->las=
t_sync_action, "check")) ?
 				    atomic64_read(&mddev->resync_mismatches) : 0;
-		sync_action =3D decipher_sync_action(&rs->md, recovery);
+		sync_action =3D sync_str(decipher_sync_action(&rs->md, recovery));
=20
 		/* HM FIXME: do we want another state char for raid0? It shows 'D'/'A'/'=
-' now */
 		for (i =3D 0; i < rs->raid_disks; i++)
--=20
2.17.1
