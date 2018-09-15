Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D34ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA54208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XO3gIlV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA54208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbeIOGwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:52:22 -0400
Received: from mail-dm3nam03on0128.outbound.protection.outlook.com ([104.47.41.128]:36672
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729829AbeIOGwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zZkAIEOc371En72sjUd4lhq8KJ1SAJaTrhxgjNRnA0=;
 b=XO3gIlV6Bz+Rk2Xe3+ykcE9h2bN+twwqd7VQPIb4HwmYp6ug93uw3WcYOiAep7Kni335uhZailUeo2phwZ7GmBfGo4nrMrmlPVbLX2nXkPxSJZmn1tetZ/POJAjJP8dAmZZyui1SZTcCt9sdg42Nkbrjt6eGgtU2pYJIb5BaY+M=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:35:17 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:35:17 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ronny Chevalier <ronny.chevalier@hp.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 02/20] audit: fix use-after-free in
 audit_add_watch
Thread-Topic: [PATCH AUTOSEL 4.4 02/20] audit: fix use-after-free in
 audit_add_watch
Thread-Index: AQHUTJRVWf8KJ6IotUmYADWl0yowjw==
Date:   Sat, 15 Sep 2018 01:35:06 +0000
Message-ID: <20180915013502.180110-2-alexander.levin@microsoft.com>
References: <20180915013502.180110-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013502.180110-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:c4WjBM+mf5CCKYp8ucQwNUAhice+I+/HI2egtIAmD08RekH3/o7PSkDCoki6yoqBrmIAxLWnre50Y54eUdyzOKw4wOGLEVRR11IyBVn4VbvvPHrGvRVl2Jt/yO0nT2gW4vIk4tepyujYagzNFeHfNEcaqbKKl1MNm1PbephYFDWWTkfwxYR0tjmFBD/zXGqKpVYizX9aJMajD1AejYUNV7SLvRnF8I+KWyGKzP88JnI+O4VRrphFh4HZONJ9QxzUJxh1sINAe0w7UlzIekAlKNFUYN9F3xWJUtsuHFyUWIqiZPqHB5beO4zt+hIAZC4t/4LqSeqz9QPkaL3/dQtkFzDenTT9qIWLBBtLCDlr5JoXQSanyOkOjtN0iMgurNtI8z0uWXeN7oP6WBUysscTJsAWmomALpvLdP1tO6YLfHYUd+vlFKuttQoE8tz3A/VZLBxxyuKcqZhpkKCqqOxGzA==;5:GhrX+rHKJ7bKDqXqUFK9iOMEpWgUVdYnbaczcUGYesH79KM1ZI6QDgmeqC36kYobClklROidMlaoJW6ZrSvztbhu243ZVaNb/IutUKiwgLvzO57K3zcryoKpsZlEdv48go55G2hDTAB0yDYDW0bbWSozhdAS0FOU/3yxidAoLvg=;7:CvWr3uchx4T8IMplxCShffSBuaYFW9p0eITaxZsfviwFxSNCFP/ATkudabx8pc0k1XeLcquKQtPIFGGh+owjR2+bAHpsWuSjmdMoRTdz+DCOTsnpk5vXJmBaSK0NcnAN6HqMViipOiyhKSD9ZtCmzOL8yxUke6fHiFmAPHH54gvLQZQI5I1J7MHccZvz97q2JJdjscJ6l6sZ/1O3pVBrba49aYslLXSfZphnzaJA1LKvROf6xBF2klUCo86pjmxM
x-ms-office365-filtering-correlation-id: 0d38f159-87f8-4e58-08a7-08d61aab7e0a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
x-microsoft-antispam-prvs: <CY4PR21MB0181B8D89C38A6B3130C9EE7FB180@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(73583498263828);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(136003)(376002)(396003)(189003)(199004)(66066001)(68736007)(6346003)(186003)(3846002)(26005)(551544002)(1076002)(6116002)(25786009)(97736004)(110136005)(54906003)(6666003)(2906002)(72206003)(316002)(10290500003)(217873002)(476003)(102836004)(478600001)(22452003)(2900100001)(36756003)(5024004)(256004)(14444005)(10090500001)(4326008)(2616005)(76176011)(14454004)(81166006)(11346002)(2501003)(81156014)(305945005)(5250100002)(6506007)(446003)(106356001)(105586002)(5660300001)(486006)(99286004)(7736002)(8936002)(6486002)(86612001)(6436002)(6512007)(53936002)(107886003)(8676002)(575784001)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: zuH6T1qOE4DtRdPnDZrJYh4jUcPYQI7MZOstb36M9AcBaXhkvqojk+2Zr6r/li0OI9go0qYODBE0jQ4d2bflGJk9B2ufBXadtRlWX7MIKVkw5mMVLiQ/D7B/kIsWMcjYdzRZO8/rtcske79x4+Jc/ueuN1jlz93zPdjkN91BcVdDJT6yY1Ojyb5VL2CFcxquLyitnOq/fCTz++hYCIdnW+DHz3WHGCZy+/I3sbz06ciUeJRvKI+awMxcztn30r2a8mceQluNZIffql6iEaERy40doMPk0eJwPIkAbFIf+Ez81RsCzY9BA67OTHJ8TE6Vc+W6/gj/lab3i06I37of5/CyDw2WiofmD/9wguTYJwU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d38f159-87f8-4e58-08a7-08d61aab7e0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:35:06.6917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ronny Chevalier <ronny.chevalier@hp.com>

[ Upstream commit baa2a4fdd525c8c4b0f704d20457195b29437839 ]

audit_add_watch stores locally krule->watch without taking a reference
on watch. Then, it calls audit_add_to_parent, and uses the watch stored
locally.

Unfortunately, it is possible that audit_add_to_parent updates
krule->watch.
When it happens, it also drops a reference of watch which
could free the watch.

How to reproduce (with KASAN enabled):

    auditctl -w /etc/passwd -F success=3D0 -k test_passwd
    auditctl -w /etc/passwd -F success=3D1 -k test_passwd2

The second call to auditctl triggers the use-after-free, because
audit_to_parent updates krule->watch to use a previous existing watch
and drops the reference to the newly created watch.

To fix the issue, we grab a reference of watch and we release it at the
end of the function.

Signed-off-by: Ronny Chevalier <ronny.chevalier@hp.com>
Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/audit_watch.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index a162661c9d60..f45a9a5d3e47 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -419,6 +419,13 @@ int audit_add_watch(struct audit_krule *krule, struct =
list_head **list)
 	struct path parent_path;
 	int h, ret =3D 0;
=20
+	/*
+	 * When we will be calling audit_add_to_parent, krule->watch might have
+	 * been updated and watch might have been freed.
+	 * So we need to keep a reference of watch.
+	 */
+	audit_get_watch(watch);
+
 	mutex_unlock(&audit_filter_mutex);
=20
 	/* Avoid calling path_lookup under audit_filter_mutex. */
@@ -427,8 +434,10 @@ int audit_add_watch(struct audit_krule *krule, struct =
list_head **list)
 	/* caller expects mutex locked */
 	mutex_lock(&audit_filter_mutex);
=20
-	if (ret)
+	if (ret) {
+		audit_put_watch(watch);
 		return ret;
+	}
=20
 	/* either find an old parent or attach a new one */
 	parent =3D audit_find_parent(d_backing_inode(parent_path.dentry));
@@ -446,6 +455,7 @@ int audit_add_watch(struct audit_krule *krule, struct l=
ist_head **list)
 	*list =3D &audit_inode_hash[h];
 error:
 	path_put(&parent_path);
+	audit_put_watch(watch);
 	return ret;
 }
=20
--=20
2.17.1
