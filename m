Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C76EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021F92083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bwVgCdSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 021F92083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbeIGFPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:15:41 -0400
Received: from mail-sn1nam02on0135.outbound.protection.outlook.com ([104.47.36.135]:30237
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726361AbeIGFPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEvL2os/yH4h4yrCGqcq1U4fMbK7ai1iQdhIai/6bbg=;
 b=bwVgCdSFMGqmzpBxyKiNTVQwLQXX4/M9dWsFDGrY3sY+6pW7932RhavhEbLQx5RFJ0+YPEP2+Y8St/ZLxrY8XehiFv3l0d7y/UjlniBDdr/PHZKadmeETHdH2yjqgLrGXaNbATf1+S6cqLuAKuJ8yrGTiqXJNQCkmyFCyDrTK/8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0118.namprd21.prod.outlook.com (10.173.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:37:31 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:37:31 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 64/88] arm64: fix possible spectre-v1 write in
 ptrace_hbp_set_event()
Thread-Topic: [PATCH AUTOSEL 4.18 64/88] arm64: fix possible spectre-v1 write
 in ptrace_hbp_set_event()
Thread-Index: AQHURkLW/HYPrPib+U+tJvUbuYzdUg==
Date:   Fri, 7 Sep 2018 00:36:38 +0000
Message-ID: <20180907003547.57567-64-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0118;6:yxZO+iojknI+RZrSnilOMNQjxyk82dAXURHxHLdG1d212RjI2KILoBEaI11tudm+6+tCxEJjGZChpfN5ux7WiDnyWDcPa/uoBXv9NpTqNAzPTC49N+50TLZm8kqXioR25z4FFqAxDALj+53+6JjlGADH09IU33F+QEDmgkROS3XrNj0ttlpj0fcOy4KO0jjLBUipnkdWKYRjR3pFPAwn5xGtz5dxoSiKw/ZZNCzEYFcJDdZn1e61dNltOQ8ZmJJhAx2bir8wRdm2SlqXBdVMbq3eMrDeBe+b46eikW4HiMhiibQLihEtzmvKui7wQa+obJbl+ajQixUebEYMvT9oAp1Jh4ocIcpQPXHY7UrtLcdqVtZguN5exTwkGgqeq2nrHzbJT+5/7QUSGh3PSzKgggyxdZHic1WdO/cyRXsM72N6tQS11V67zlewE4pawuhHwTE8sYQF2A5Us929O5v4Cw==;5:cIMxqTBAub+H3Ap65Zr/bMmpa6s9LUgESXbhKqHbw/Kx9ZDc9GPSgdR2BZS2xxtsxlvdfJJ88q4qCnhOMoFfiIxHBO7PS2mF8fn1ftN71IEleVKCIg7uqpOlEIm5fHUfNrkva8lVIKD/zNDNzcE0RVC6wTg4lk1XOgAAhFjsWiw=;7:8tuCsXOKqOoGqfcqb18UZGeeOoJwUXtvS60FEK7KQ/i3h4vvW8lInhvO3el0MhpTkYUgh11/rnvPOgNtGLPBJPmerb9+cy87nzQ7umYYWUWCj2i1nnCwvnPJJ6dEIo6fTNdkS1ehNt6akIXdfMBCmPD4nVUVcZO4kL+S7GHslPdutQ18QMW6hQemeVGbi7PGHNP9gHrvwmPzyy79UwiOltGN28JmpgiUqXkqIueWSwQSoPC8PeHl9o65vOjCuWi6
x-ms-office365-filtering-correlation-id: b4918cdb-3872-4fd2-eaf9-08d6145a18d0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0118;
x-ms-traffictypediagnostic: CY4PR21MB0118:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB011882A5FD19B6DE3DC44131FB000@CY4PR21MB0118.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0118;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0118;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(136003)(366004)(189003)(199004)(97736004)(2900100001)(53936002)(316002)(86612001)(25786009)(86362001)(2906002)(6512007)(68736007)(110136005)(54906003)(107886003)(4326008)(10290500003)(14454004)(81156014)(81166006)(66066001)(8936002)(8676002)(478600001)(6116002)(3846002)(72206003)(305945005)(7736002)(1076002)(106356001)(105586002)(36756003)(99286004)(186003)(26005)(5250100002)(446003)(256004)(217873002)(10090500001)(76176011)(5660300001)(6436002)(11346002)(6486002)(6506007)(102836004)(2501003)(22452003)(476003)(486006)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0118;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: atEvpI6INJnqK4awUSDP0DRZf2pn5YKBlhBsqxf0IDRKYevf3L6rvj5FaK+EIQ+8bvAvSZta+THT08aeo/rlcwPKbOpr1XTZJOnb4uZ6q6dfMdpGSHMDMWy547ZVQrBXkD76dNiiRSR0/QQ7rQIjdXGgYzmpnCnWfUVjnlV3gvLd00OwyBxnsSR+96sgKtjnCgxVJ6CoTUQmsqgsHzf+Q338zTt3lxOgBKzQqV97gPxsx+FNR7IUynsdwB94jFzLVc5vqHujWcEulGWdZaliF9NyoOjsboYan3KDaJQpc0cwMMsi3YRYrqH7G51nu4tkHwKDntReJyE1cOmIhGws/QzJBlRSNnP1JfbS4/drSdk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4918cdb-3872-4fd2-eaf9-08d6145a18d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:38.3259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit 14d6e289a89780377f8bb09de8926d3c62d763cd ]

It's possible for userspace to control idx. Sanitize idx when using it
as an array index, to inhibit the potential spectre-v1 write gadget.

Found by smatch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/kernel/ptrace.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 5c338ce5a7fa..db5440339ab3 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -277,19 +277,22 @@ static int ptrace_hbp_set_event(unsigned int note_typ=
e,
=20
 	switch (note_type) {
 	case NT_ARM_HW_BREAK:
-		if (idx < ARM_MAX_BRP) {
-			tsk->thread.debug.hbp_break[idx] =3D bp;
-			err =3D 0;
-		}
+		if (idx >=3D ARM_MAX_BRP)
+			goto out;
+		idx =3D array_index_nospec(idx, ARM_MAX_BRP);
+		tsk->thread.debug.hbp_break[idx] =3D bp;
+		err =3D 0;
 		break;
 	case NT_ARM_HW_WATCH:
-		if (idx < ARM_MAX_WRP) {
-			tsk->thread.debug.hbp_watch[idx] =3D bp;
-			err =3D 0;
-		}
+		if (idx >=3D ARM_MAX_WRP)
+			goto out;
+		idx =3D array_index_nospec(idx, ARM_MAX_WRP);
+		tsk->thread.debug.hbp_watch[idx] =3D bp;
+		err =3D 0;
 		break;
 	}
=20
+out:
 	return err;
 }
=20
--=20
2.17.1
