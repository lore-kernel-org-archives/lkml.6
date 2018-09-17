Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAB7ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A339214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gAMXkWZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A339214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbeIQIaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:30:30 -0400
Received: from mail-eopbgr690116.outbound.protection.outlook.com ([40.107.69.116]:54124
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730540AbeIQIaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrvTibS4sTRZNHnbIJFyuaI3UaJmEoH5NO6xC+mnGbw=;
 b=gAMXkWZucAr55P0iBXrwlVaK++DSVgF5Qd8CTP9vNrdbk2mhBEOx0wqoarghMHlK9D6c/BBz2m+8j/hzDVGm0ahKsNDvMxOm0qnSsQ+a8/l7QavLN8LvyQiklP6QROmoF8oE5gi3vA81lGkhRB98UOvODei8p0wD/81cdnSrDtc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0133.namprd21.prod.outlook.com (10.173.189.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:05:03 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:03 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Konstantin Khorenko <khorenko@virtuozzo.com>,
        Jeff Layton <jlayton@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 83/87] fs/lock: skip lock owner pid translation
 in case we are in init_pid_ns
Thread-Topic: [PATCH AUTOSEL 4.14 83/87] fs/lock: skip lock owner pid
 translation in case we are in init_pid_ns
Thread-Index: AQHUTjL7B20MhIK0pUijYZhbcu8PdA==
Date:   Mon, 17 Sep 2018 03:03:17 +0000
Message-ID: <20180917030220.245686-83-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0133;6:wFGSzJd1vrpXezb9eV4JSPQhLSGOmS7sZwDYrNsa3LjiqRBssmcAcrQMElmRCQ42RWAfEZcx6eaFVRq+Uj9gqnND26xKg9Bs3O+IWTvsibOTFe3T8OOH+tjf1YIbvx1TwdNY0toldBi09yYpEb0reWcoCBTBWhkN9W5yDf6KJUTwAkKC7xUVdlNCEZ6WMoFfjCz2NR8GOTfHfA2Fy3pqiZ6jNwT4Sgal+20GsY1EL4Lb+uoN99cRvw/L53cD3AHhtXi7Zj5QZS4vjMmObJbVl8jf4esUw7icCI7epAf0jN5MKf0Kpz24/3mSsHdxx8o542ox/7rMPSoJOUVhtStERlhaCNeno8zuKZciHSQP2z0SNikWv18m3oBv1N41JQfkWxFs/eB8AqL8qzlpLj8AXVWyHq+auNr22mYzACu+u7tjFsuRU5vKgi773hwPLu6AuheovoTGZR+AHLoU1atPMw==;5:Q+n8SEpAJN+AijATUVOtTZNZllRHrigTIA2S1PFTH5MsYvbLqiPLCn6sspaYxoh3rz9MJhtQDYbwTVfDItuFUku9PMhRhBBNEjQCWYQ7QKY6Pw4ZQugmvo7jYhMWnsGc5Syzvbj9t0O9F0PQ2s/k58lMTdPkZvR1rMTF92HFJyk=;7:zpCuum+IdO73HjV5Z/GgLtSgBIz5hNRItyk/qSSsjLiJ+WOOcEhnLyD2luHNUC8l79APdc7C1HyLxiokj+DK8BCV5fZyClc+h1xRUsPX8L8cnwxh9hMmtlzOrFMMp9zZMYqow+MtcErDO/dSlMpkJa141Ja9ylvY0qz/R58Ijmmxu/J/qB6FvHgPzhCCCBnNLptgfkXQMcIXxmv3fqAahlsYtwukv0qapif1TbSXaq2jEbG4BwkTgH8DBBW2ul8r
x-ms-office365-filtering-correlation-id: 385e2e64-5b73-47d5-e976-08d61c4a5d2e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0133;
x-ms-traffictypediagnostic: CY4PR21MB0133:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB013389A26B8567A899A404EAFB1E0@CY4PR21MB0133.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0133;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0133;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39860400002)(376002)(346002)(189003)(199004)(102836004)(53936002)(8676002)(486006)(476003)(3846002)(6116002)(76176011)(10290500003)(97736004)(217873002)(256004)(5660300001)(107886003)(6506007)(478600001)(110136005)(2501003)(10090500001)(14444005)(305945005)(7736002)(446003)(11346002)(36756003)(2906002)(1076002)(22452003)(5250100002)(2616005)(26005)(316002)(106356001)(25786009)(68736007)(86362001)(575784001)(14454004)(72206003)(105586002)(99286004)(6486002)(6436002)(6512007)(86612001)(6666003)(81166006)(81156014)(186003)(2900100001)(54906003)(8936002)(4326008)(66066001)(414714003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0133;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UQ5Ap9a+fElkDoIGWPp/aYWUU69pHU0kfdNiBmBAhuzoO/Ha6nWaHmgF7iMiC0qpzEjZPgBFHQZHBWYZKiXEswAICLKrL6Ux253PzzoprE9gPZd/TSTLCwVXXwQXPaTJt6U6LWFcvsftw01YQ4YyjH1JRA0eNO2yn978gPlS7vwBL0Z1OuBRp1SQYU+RwIYLSlEgjVe9AKNZ68rrf4zLUA1BYADnoVCdl3pN74uWlfA80qWgIKjcnhhs9Frr1KVxuOg+XGD69Lw7ReBWs0H1ll9Fs+nITDVcjyN9t4GuwYfh+cA4l1//2J4UcLz4vo1Eh2mcwsOKbrJel7sdisIPJhRAYaCPfL3076OCnnmYrTc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 385e2e64-5b73-47d5-e976-08d61c4a5d2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:17.6027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Khorenko <khorenko@virtuozzo.com>

[ Upstream commit 826d7bc9f013d01e92997883d2fd0c25f4af1f1c ]

If the flock owner process is dead and its pid has been already freed,
pid translation won't work, but we still want to show flock owner pid
number when expecting /proc/$PID/fdinfo/$FD in init pidns.

Reproducer:
process A	process A1	process A2
fork()--------->
exit()		open()
		flock()
		fork()--------->
		exit()		sleep()

Before the patch:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
(root@vz7)/: cat /proc/${PID_A2}/fdinfo/3
pos:    4
flags:  02100002
mnt_id: 257
lock:   (root@vz7)/:

After the patch:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
(root@vz7)/:cat /proc/${PID_A2}/fdinfo/3
pos:    4
flags:  02100002
mnt_id: 295
lock:   1: FLOCK  ADVISORY  WRITE ${PID_A1} b6:f8a61:529946 0 EOF

Fixes: 9d5b86ac13c5 ("fs/locks: Remove fl_nspid and use fs-specific l_pid f=
or remote locks")
Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
Acked-by: Andrey Vagin <avagin@openvz.org>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Jeff Layton <jlayton@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/locks.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/locks.c b/fs/locks.c
index 1bd71c4d663a..665e3ce9ab47 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2074,6 +2074,13 @@ static pid_t locks_translate_pid(struct file_lock *f=
l, struct pid_namespace *ns)
 		return -1;
 	if (IS_REMOTELCK(fl))
 		return fl->fl_pid;
+	/*
+	 * If the flock owner process is dead and its pid has been already
+	 * freed, the translation below won't work, but we still want to show
+	 * flock owner pid number in init pidns.
+	 */
+	if (ns =3D=3D &init_pid_ns)
+		return (pid_t)fl->fl_pid;
=20
 	rcu_read_lock();
 	pid =3D find_pid_ns(fl->fl_pid, &init_pid_ns);
--=20
2.17.1
