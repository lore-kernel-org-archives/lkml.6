Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6ABECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15648208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PqITphVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15648208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbeIQIxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:53:06 -0400
Received: from mail-cys01nam02on0138.outbound.protection.outlook.com ([104.47.37.138]:10368
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728729AbeIQI2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+MVbHzNLAth8gkg3TZNbGw391DVf5Xf2Hc4Z9qoc30=;
 b=PqITphVFEiRDKUayw+mD26t9A6JgITh03u3w0yaptawMZehRNPhLmQvKy65nMwo4sTCdyzcQ4gxyhinQf2CD3veD9L0+rqqTyTrxQr1ddV9mLdZhCI5yBD3WgZAMO5AeptKogj3pyMXfQ3AaGThKdZBG777tYZQFgiiD62j3Hdk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0118.namprd21.prod.outlook.com (10.173.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:03:22 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:21 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Konstantin Khorenko <khorenko@virtuozzo.com>,
        Jeff Layton <jlayton@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 127/136] fs/lock: skip lock owner pid translation
 in case we are in init_pid_ns
Thread-Topic: [PATCH AUTOSEL 4.18 127/136] fs/lock: skip lock owner pid
 translation in case we are in init_pid_ns
Thread-Index: AQHUTjK872QKClWVSEqFODLTeigUDg==
Date:   Mon, 17 Sep 2018 03:01:31 +0000
Message-ID: <20180917030006.245495-127-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0118;6:FWIxDBEWGWtrIZMlwBAtcJZNefaMK68nXFyt0bVe1an0JSsD9X/szgKV/9j1WJetdReTlnK6z4Xt9iA9xcDuVktx8U32cJJcdFmxOHI1V5ntvregReME7l3aTWz8t35me/LIGL4VVSOreLYbdwkBrynn2+bC0b/uymyL3T6D+JRAUNTEBs0jNxfWnAsUpTEngfGVxzG8DF2aXNUAQaOAwFJy0HlH/UnQCI/Dq96o7mHJpTsRxHuUl+EQNYDGxpfvwYHpPIbR87/fnFn8YH+imJjUSOn7jxcgtDOjjFrPek67B2auCv1N7tc1/qO1FmKe3/gjGzNPT7frWLEGIo/4nOsH5yoWJKBzm+7tpYj3MzdbEWWUwHbYFjgKmqFBQC6stHdSSgIgwE9UB0mT5omvcYX9tXBT/12rizIFGo2xMoOo9VOH/hgGhMGjxe6ry8skeqZDS43nMopsssBhZK1Lcg==;5:YkWOk8uF23IjFd8llIg4ewYFhtveOO7ncDasORt1odWy+0rierhSFrPOuepsAlxgg4O4aaK6L2ocUlaaviqeVlM3ojTnPOdyQq1oho5heajzhK47zDtAAQrc/X6bBbEkmwL7+7G8onkInOwmpDxhVKWFwoVl8Go+TIz/es6rXjo=;7:VngquMVvx+bots9tFYq69dlH7oJZKTsucGVpO0tZ5ROl2WOFOkUSi7sh3MYeuM8/lujnCie/ycYV2Jd1Yf+GTgI+5+aw2YUNEwlq3pE85GuxNKSnfNl8udmZCYvfoASw1st1LXzqP/iocg4a5cZx5nZT9USFPwqCUSXge2qiL2nJT6uAD87ov5Ko0WAWKA4XKNyRAL0LCXCSgTL2cLjAbtweWBcb3cPX2tcRbFufCamNUKHpGv+amrkxCQmziD/9
x-ms-office365-filtering-correlation-id: 8cad7b98-e2fa-4408-68d0-08d61c4a2052
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0118;
x-ms-traffictypediagnostic: CY4PR21MB0118:
x-microsoft-antispam-prvs: <CY4PR21MB011851A2D448ECF970E48D50FB1E0@CY4PR21MB0118.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0118;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0118;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(136003)(396003)(39860400002)(376002)(366004)(199004)(189003)(2616005)(186003)(8936002)(10290500003)(66066001)(97736004)(102836004)(36756003)(5250100002)(256004)(3846002)(6116002)(2900100001)(476003)(2501003)(14454004)(54906003)(446003)(217873002)(110136005)(486006)(11346002)(6346003)(8676002)(575784001)(86362001)(26005)(72206003)(81166006)(81156014)(86612001)(14444005)(478600001)(25786009)(105586002)(2906002)(99286004)(68736007)(6666003)(6486002)(305945005)(7736002)(76176011)(6506007)(6512007)(53936002)(22452003)(1076002)(4326008)(6436002)(316002)(107886003)(10090500001)(106356001)(5660300001)(414714003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0118;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ff6/mRTWq8xRD61o9ZhfiH9XJ6LWQxINvUTtxFpvgBxGyvc8kjP+vzK1t3Y7VzG3K/xZnjMdPd/emJsqyhJz6/Nq/NfapuzGfelHkie8uSy2QHZjfmPd6IBPRHVrv69eg248AcKxCMNbQg17RMYbK0HuFILZVX35ht1AXhbewdNEFcxBjFC0F+R2Uf+Eol1FjPePb+oR/b3hQujrzwp0uoIUs4ZVXvEGfhzUQYxEZlsgpH19MAbjG7QoweI7g5TCK56dpdLGhuuBaHIhg2Nta/a5L3wIX2zLvmFZGJwW+7Zl5XR+Rt8OlDgbuL/plV0na1lZEV1zs6t2ZDq+1EVcSUSiVR/bhP++xZk54trJhlY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cad7b98-e2fa-4408-68d0-08d61c4a2052
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:31.9946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0118
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
index db7b6917d9c5..fafce5a8d74f 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2072,6 +2072,13 @@ static pid_t locks_translate_pid(struct file_lock *f=
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
