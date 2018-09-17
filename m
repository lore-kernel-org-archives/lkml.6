Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A61DECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF0C2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UFzC9w7T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF0C2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbeIQI3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:29:45 -0400
Received: from mail-dm3nam03on0110.outbound.protection.outlook.com ([104.47.41.110]:11424
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730284AbeIQI3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFeoTuSV1M8Oix1hTAVao3AYpotwOgF8crShovtiGjw=;
 b=UFzC9w7Tu13u4BDpwKt3ag9jTtIMnThBzyzKNFLgB1lbC4joNYYWq76668ZIJkbtRhTvVQSh6xOn56tRSFI6WaSk4b0Bsa6Qi4lklYLWiGMHqqwvs8+pyAVYfr9c8HCUej4j08xz4SfANLdzUEEhFAxAcgJ8MjaXpnVdXunxAUQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0774.namprd21.prod.outlook.com (10.173.192.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Mon, 17 Sep 2018 03:04:22 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:22 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 57/87] drivers/tty: add error handling for
 pcmcia_loop_config
Thread-Topic: [PATCH AUTOSEL 4.14 57/87] drivers/tty: add error handling for
 pcmcia_loop_config
Thread-Index: AQHUTjLxC1a80fddnky58yjD/SlUuw==
Date:   Mon, 17 Sep 2018 03:03:00 +0000
Message-ID: <20180917030220.245686-57-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0774;6:vu4ftTJaNx9iKPG/G9fQC7wLBla2Z6S5q1siSp+QckahGZeO20tF8Mr9RfmNN58GSOkKUuVvdy85R+z3aETbiOPm4BAKyFm28oMaq+Vf48JcBvHNQfy6pLxL2XnWTCJqEaetOJmhbpUGnN8/anms3/pNBAe89stAD+56QXo1yJGOJ0TKbVKFBSwHB5SuY8i3UqyY+yHCZQWtoHOfLaGB9g+8m6mLkAaCQBh4R1B0Eu3ofMtynCDRiTRnHnSM30qnvMvd2SIknrRnmQrAHYVG7tsYrbJo3sw1Mdma9dbzHefb05S092z99OT/mWYLiIavZw2bEyGKGHFXJmjh9p18sDo/E2A8lo65A+5/EV/Db/E3jigxJUlyyqcPjWD8YXu556nTikIqUpS3k+lCM2HbFRdkB048Ku+UiEmToaL99XaGnfr+yWyUTmDN8cHwNGVC/OvWHBz8Jtutl3eItcXuyw==;5:dQU6EcQrwBLHYNrXoZhxkZX0eDA9GIpTx8cggGUfp31a70K0DgVDjzoU/ovWhnPFLbeix8sRw6YHFOOe5A7rWw6mtvF2wf/U5cmqCaFm+aF2eUQUXjaAqyPXlABxgycC2wmlzQvUumjm0JuRkypvfvN9XbxrAnyKp/7+OuoWGtg=;7:Ojduy7fPGMxthpBESz4Sa4pUM6d+1v+ofGbIPTvIK9j6H49YgBdmCwEcR8hQ3LDwjEufhCW0fD0oeU0sbhkgDQIgdvCTI862Hvlx36z8vsyuqXnDojlKSJUEqxX0k5MxJ+LMm0bBYkiZJVM43/MDJ7DUo8H+rGOitp2e7V7dlw2Jy0saXjFVSmc2JD+40OsbMtqnxYjGv/G2K2JEfc2YVj4S1rpl4rh/wCms5T0AZBwAWZH8DLQ44fZnuCclbRZ8
x-ms-office365-filtering-correlation-id: c4573508-001c-4876-07a4-08d61c4a44e5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0774;
x-ms-traffictypediagnostic: CY4PR21MB0774:
x-microsoft-antispam-prvs: <CY4PR21MB0774174BC841B5253F6BCAFCFB1E0@CY4PR21MB0774.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0774;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0774;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(396003)(39860400002)(346002)(199004)(189003)(54906003)(105586002)(316002)(4326008)(6116002)(1076002)(14454004)(305945005)(7736002)(22452003)(81156014)(66066001)(81166006)(99286004)(8936002)(8676002)(3846002)(478600001)(72206003)(53936002)(10290500003)(68736007)(106356001)(6512007)(25786009)(76176011)(110136005)(11346002)(476003)(2616005)(446003)(6436002)(486006)(39060400002)(6506007)(86612001)(10090500001)(102836004)(86362001)(6346003)(186003)(26005)(36756003)(97736004)(2906002)(256004)(2900100001)(6486002)(217873002)(107886003)(2501003)(6666003)(5250100002)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0774;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 4XBD8X11oLZOB1sOhisp4/1hOE+AGwVHDoKOb27HcV9WwsZREW/AHcX8dUiM9wk9zMYCH7ch7ZF8iOWnT4zKYBRT2jBpXNHpt+2ICi144yIWlh1OkYg8Y7nsxLchs8xZ064Iif049t97A0nJN/AQbSwl2/d9AGmyBgy7NuC4LHB94l8j5YhE6+yJdVtiW8dHzZp6mj/deb5zurphlOgpBOCTZsl8oAec4ucmIxyhrvaRUTqNAwiZOetO5a/ndrydLHI90KBI30LogxCYFSAl49OzMar89xbe7hztIrzKlOVwINJTSRwj1nkSkLdC8jpNT/pTsBhA5pQp3bE82ktg26UsNe0MCwdC2ChiTZ6deI0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4573508-001c-4876-07a4-08d61c4a44e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:00.5560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0774
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhouyang Jia <jiazhouyang09@gmail.com>

[ Upstream commit 85c634e919bd6ef17427f26a52920aeba12e16ee ]

When pcmcia_loop_config fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling pcmcia_loop_config.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/tty/serial/8250/serial_cs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/serial_cs.c b/drivers/tty/serial/8250/=
serial_cs.c
index 933c2688dd7e..8106353ce7aa 100644
--- a/drivers/tty/serial/8250/serial_cs.c
+++ b/drivers/tty/serial/8250/serial_cs.c
@@ -637,8 +637,10 @@ static int serial_config(struct pcmcia_device *link)
 	    (link->has_func_id) &&
 	    (link->socket->pcmcia_pfc =3D=3D 0) &&
 	    ((link->func_id =3D=3D CISTPL_FUNCID_MULTI) ||
-	     (link->func_id =3D=3D CISTPL_FUNCID_SERIAL)))
-		pcmcia_loop_config(link, serial_check_for_multi, info);
+	     (link->func_id =3D=3D CISTPL_FUNCID_SERIAL))) {
+		if (pcmcia_loop_config(link, serial_check_for_multi, info))
+			goto failed;
+	}
=20
 	/*
 	 * Apply any multi-port quirk.
--=20
2.17.1
