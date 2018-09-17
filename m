Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F0BECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1AE420693
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="mmcrzgjC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1AE420693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731554AbeIQIh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:37:59 -0400
Received: from mail-by2nam01on0104.outbound.protection.outlook.com ([104.47.34.104]:36220
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731213AbeIQIcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WE/iCx03MmHaWblvh2S2qGrvodyn2PsrG8LxDZIC+5o=;
 b=mmcrzgjCPDYzRhZ2PUHcklL6IeryqpbLav1q27mnOQpSbXfdFU8rZRh6Oe+EQf1p8h945xRte/Ti11IUt4rjeVC+1aKmWLSuSUFz62xqLc/GOMZLFp7+w3zgpxy9lozJFWXlbHfrLGGfbtWLK96iTnekq2lYYMAWlK8aDqKyc7I=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0759.namprd21.prod.outlook.com (10.173.192.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.5; Mon, 17 Sep 2018 03:07:12 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:12 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 29/43] drivers/tty: add error handling for
 pcmcia_loop_config
Thread-Topic: [PATCH AUTOSEL 4.4 29/43] drivers/tty: add error handling for
 pcmcia_loop_config
Thread-Index: AQHUTjM9D22xrQXqSEmvSIlSTh+SIg==
Date:   Mon, 17 Sep 2018 03:05:07 +0000
Message-ID: <20180917030445.484-29-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0759;6:oX6+/mfx5TgJtu9v13iFJztliO09pgd+PkAxsbNkoxb56XPmjhFiFKKYgdIjKXUJe4qsMMp/wrDiKDb7mLkBSP+vgPUgLSph03KwMci05ca5km2V5GAicykZmA+40Hcvs+fDxL1Mma+sNH/xEPWPvBB+UjSED+ClltS9bBn3DETQlcWvrdEuBNgWwf9HS+YD15fh5NybzLi8UHax0u/0h1YhMCtCx8owGFomCOgbEgUTZRyQ6g01+hBlteb2pJ2R+dCg0Leh8aaoHVJDUaw6hd+CxNepIPSlOOPDE+HHY2N+jvn1Cq6W/UYrgT3hgKKb7VMl1bPeHm4fnFNY2e+9y+jEbIYeXLJV8rdVYLmsrYny1iF/YoQORrkAOOFZQCiSRK8oat98B7W2ZR+zGlkUK2Xn2L92KStYpIAunl2zvvMEVLDkZxafujavEr1x697MFooXqvUTRgPlG76Nkz/qJA==;5:ZVYgt8XobMFRUUhEXtHyMKK7EdRiDyXFarpml+ohz36PW/P/WjEszfGcwVS+3+xfGgsm9oYCOGRH0t/RSMpid8ZuWO+NLfxZRFhqufu6wOKlcEZfXxNeAnvyuIaYobE+lBY6vOdo2fwG9gVJJTIuEgnDPY2NroukgeQnOqaFd0s=;7:CCN/VgYEPTGcRoibAE2FB0MNjv8T7uUX0fNM3HnguDAUAy63PJ8zG3LZPQkUBuRh3+HRh5qPuv3Xdrbz4Aw5VyBrDZqFM8msMBUoowVZBQh65Ej6uuRE++8HTHypzVepcNiTjqTIua1LgSXg/IRNIF1umKyPbfv0jVB5d8u3ypBQ2ssTTaz67nMeLhMUgzig6UguYUV4drK9dE0sxXT966XyZAefsGgkfqdD9K9/w9uTAeDNxODvawX0UcF3nwlb
x-ms-office365-filtering-correlation-id: d435be44-04d7-4c60-2935-08d61c4aaa11
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0759;
x-ms-traffictypediagnostic: CY4PR21MB0759:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0759E525ECC14771E1A947D8FB1E0@CY4PR21MB0759.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0759;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0759;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39860400002)(366004)(189003)(199004)(2501003)(2900100001)(305945005)(7736002)(5250100002)(6436002)(5660300001)(53936002)(1076002)(86612001)(6512007)(2906002)(6116002)(3846002)(6666003)(6486002)(86362001)(97736004)(10090500001)(26005)(54906003)(256004)(106356001)(102836004)(25786009)(99286004)(105586002)(6506007)(446003)(478600001)(10290500003)(72206003)(11346002)(217873002)(66066001)(68736007)(107886003)(4326008)(76176011)(36756003)(486006)(2616005)(476003)(316002)(14454004)(186003)(110136005)(22452003)(8936002)(8676002)(81166006)(81156014)(39060400002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0759;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /WoXKEjUcUcnRKKdUg5C4EiJpD8amJ8wMO4i6IxT0vIxBYBD3DvV6juXAxK6iW1FyXSGVzm6PHeKL5rzpV+Rt/Ku5gmyHDosMPJfyRtcaQrIeoArG8Q9GFCt+l+44me4/EfN3TmkojpHRE1Rijp+wnyA6DgW7WiNYhhJIT6t9zWq5XkyqmmEW6qUGMdQKnONMSBCR1301dOBdHrZsT4+r6022bk8CGYfOOr1ceAY/fWT7si9xHUheewtS6Jk3nQ6AN1q/9e2COhXSdwrQzJqZwT5YFs5SJspqgp3W4cEgtRdgR4vIwY5Hw4L9U/nn6Xtfh83TZvJuXfrcCpeD+kLZuZ0ql1U3KasA3ed2aHpMi8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d435be44-04d7-4c60-2935-08d61c4aaa11
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:07.6485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0759
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
index 4d180c9423ef..1a14948c86d6 100644
--- a/drivers/tty/serial/8250/serial_cs.c
+++ b/drivers/tty/serial/8250/serial_cs.c
@@ -629,8 +629,10 @@ static int serial_config(struct pcmcia_device * link)
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
