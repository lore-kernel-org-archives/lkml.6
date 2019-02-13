Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1883C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764FF222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="NADGN5hu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392742AbfBMQ3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:29:30 -0500
Received: from mail-eopbgr10091.outbound.protection.outlook.com ([40.107.1.91]:22848
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732888AbfBMQ33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:29:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZhvUM45OG1B7SDrxt9GEDPPGu3oaYIHcZPhVyFXlQ8=;
 b=NADGN5huDds3tCxB5tgsjVy9WGToJ2/UKvMbke4agaDJAgyD2o4tKvmjhQqkazcIeIKIdlgydDSngl8phDu0UOO/T1KMSPUfxgvIVT1xqgCcqqpmEO6qT36yMZnkfvVQsQH5BI9svpNQ6oRNNtDyX8QaW5P9/6/ZEL7pzNVoyso=
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com (52.133.6.141) by
 HE1PR0702MB3721.eurprd07.prod.outlook.com (52.133.6.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.13; Wed, 13 Feb 2019 16:29:25 +0000
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::b49f:d20e:88d4:128]) by HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::b49f:d20e:88d4:128%6]) with mapi id 15.20.1622.016; Wed, 13 Feb 2019
 16:29:25 +0000
From:   "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hamish Martin <hamish.martin@alliedtelesis.co.nz>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
Subject: [PATCH 4.14 1/8] uio: Reduce return paths from uio_write()
Thread-Topic: [PATCH 4.14 1/8] uio: Reduce return paths from uio_write()
Thread-Index: AQHUw7lImrBZ3UkRk0ujAMLK/tquyg==
Date:   Wed, 13 Feb 2019 16:29:24 +0000
Message-ID: <20190213162845.11688-2-tommi.t.rantala@nokia.com>
References: <20190213162845.11688-1-tommi.t.rantala@nokia.com>
In-Reply-To: <20190213162845.11688-1-tommi.t.rantala@nokia.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-clientproxiedby: HE1P191CA0019.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::29)
 To HE1PR0702MB3675.eurprd07.prod.outlook.com (2603:10a6:7:8d::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [131.228.2.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e54046f-526f-42c5-c0bd-08d691d06a9d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:HE1PR0702MB3721;
x-ms-traffictypediagnostic: HE1PR0702MB3721:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;HE1PR0702MB3721;23:C9X/YTtSFqp6bvxY7qyHYeLLKMSB0veQnc0gH?=
 =?iso-8859-1?Q?/JWv6aH1bHSA15pt18lUlPLHiPEFVf9EuB/jmN2l4Bejpv7xsK5GgoPztN?=
 =?iso-8859-1?Q?GrNR2LMO4LoqRW7riG31pKIijHRnB/ax2qH+vH6EBawAyMj1rsXh4B9Arp?=
 =?iso-8859-1?Q?lEXI+ygbHBU547ewhRfpp8b+nFdMsEKvUy7EjYP01Eg/zXO/NWRNomWtvO?=
 =?iso-8859-1?Q?TgOHMd7iCdqAm9603GWKNhZbVHzZMlyskdnY22NbpdHFbUJGad2VCIMVsZ?=
 =?iso-8859-1?Q?5XvLgkpLi8OdRCHxV/utXGnAGuW4iFZEP3KcHTo/4kaxwsO7CUQmc+1wc4?=
 =?iso-8859-1?Q?APwYbH62eXH2siCAJu6JN+x9e2InvhGMWD3aHwepYqakYE5NFp2SvXNy28?=
 =?iso-8859-1?Q?OVUdKHzMfHT2irCz7Nsg+ySzAR1JzCjqZPDJQ0rMhVY9XRl9LZwHAINcwg?=
 =?iso-8859-1?Q?8zVtYSa7oAcJsW004XVN6xuL0rFzsHy7+Yy3rWA7QkmuudGeNXIpcx0Bfj?=
 =?iso-8859-1?Q?pKVrxPA/Mun5/S+tcB+r5TC/QNFcIBr20SvGO/Z2chVJXLLlQUPKyRfXB/?=
 =?iso-8859-1?Q?IpQvnijnhNHCzRfMmNUqO9Flc9ed3hL0AZ9C24zIymojkwpyrDaltGcXMc?=
 =?iso-8859-1?Q?b08Bvolk7NI3Zou8FpnBfJlDmqvo9LsLApwoGgxVBn4ngHiMd+fKBNaLsT?=
 =?iso-8859-1?Q?/OqX/ahGMqEcbYCu34taB+pCae5wuBZUeoofXc4K9dnEs+U0RHrhQ3K1tf?=
 =?iso-8859-1?Q?3+6K69Q/m1BCit6euAFQOK+adh9BFX12X/2K8emHIrnz70QHlXvbwnYy0G?=
 =?iso-8859-1?Q?T2yOsL7HdQk2Qrmcq8ZsAJ3KwryjPGaEhLYUBRo0FxF1JIJMPBDp4AsRx9?=
 =?iso-8859-1?Q?uDnzO5mO6PKftyJOFWj8UnVgzYAHw39oyfLyHTHRbwaeX7fwIOAzDnWQL9?=
 =?iso-8859-1?Q?JGVL6DLlweDAolIL7t0ze7ASSZilujNBAN3nFCJxtDKRpNEzSJxZS4bBK5?=
 =?iso-8859-1?Q?Ox0JYzg35QHESLU2JyciZqRTL4pTtCuVUvdkrfQhZrEu+Yelrbehhbk2c0?=
 =?iso-8859-1?Q?rrPRoe/DBf46gJmoxzPZN2vtoE1jS/rqhAfdHA90J/jbiJaf2OlM8z4Epp?=
 =?iso-8859-1?Q?D9uDhMsudER9I8dizvcLlf9wY7uQDE4/hwiwM7XaTMniSw4L6dzV7gEz+7?=
 =?iso-8859-1?Q?cRqPP0WnHVUAdoKLDagYRtRRPG0r14fXjKn4p6kyzOG6uXJXPVwJ+I7X3i?=
 =?iso-8859-1?Q?TkQTK9yccOzOYC/bZVqjvL6BytHAu94DPqPtQttQr6FBQ86qRvAEBicEta?=
 =?iso-8859-1?Q?MU03Mq68F62Q5pYP2voaQGNmrPQhCdDeJcIsSDFHCU3hP01ZcoYypXRY+z?=
 =?iso-8859-1?Q?7UKmbxfwgI=3D?=
x-microsoft-antispam-prvs: <HE1PR0702MB3721AAFF1FB4A701B5BC28D6B4660@HE1PR0702MB3721.eurprd07.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(376002)(396003)(366004)(199004)(189003)(2906002)(1076003)(68736007)(71190400001)(71200400001)(446003)(486006)(4326008)(8676002)(478600001)(5640700003)(81156014)(1730700003)(97736004)(6512007)(81166006)(11346002)(105586002)(6486002)(2616005)(476003)(6916009)(106356001)(6436002)(2501003)(256004)(36756003)(99286004)(186003)(386003)(2351001)(66066001)(50226002)(14454004)(8936002)(54906003)(3846002)(305945005)(25786009)(53936002)(102836004)(316002)(6116002)(26005)(76176011)(107886003)(52116002)(7736002)(86362001)(6506007)(103116003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0702MB3721;H:HE1PR0702MB3675.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AmI/brlC7M/wljzfJLMlyJfxlyrqBv071fP3uoj/uTsbJnWt+ZHthJWxZl65/2X4TRPLpBtIDqOA8GbDRwtFR3bSqekeNcltP0Box3Dd8rgguOVaYUPQxLcGqDSeSG2ntzG2+gtldU/ruBAiJZJT1vA9GJ2kZuzXhgtP7ihMCObNhkCG3JYkPxc0uQImZe9Tnq37VIuVN0XpUgDejopWROGyolrDtDetPGY5vx8jOD89y9N75AZ1yN+YW737HqyXNeIklmFFyRfl23x5V7qdrrCoFq+rFZpIKTzb3fojFeu1XT/c+vV5PHjzTleb+uMiYv4O3nZwc2g7Y0TPeRG4hin5x+mQiOu78Kd6MbBa3gKeGBGjChmiFpaapFgOA/wkUeLOgcJusY0tUZ05XmLxCMyg+Hc+pe/pHVDawBRtw7Y=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e54046f-526f-42c5-c0bd-08d691d06a9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 16:29:24.1458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3721
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hamish Martin <hamish.martin@alliedtelesis.co.nz>

commit 81daa406c2cc97d85eef9409400404efc2a3f756 upstream.

Drive all return paths for uio_write() through a single block at the
end of the function.

Signed-off-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 drivers/uio/uio.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 654579bc1e54..10f249628e79 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -570,20 +570,29 @@ static ssize_t uio_write(struct file *filep, const ch=
ar __user *buf,
 	ssize_t retval;
 	s32 irq_on;
=20
-	if (!idev->info->irq)
-		return -EIO;
+	if (!idev->info->irq) {
+		retval =3D -EIO;
+		goto out;
+	}
=20
-	if (count !=3D sizeof(s32))
-		return -EINVAL;
+	if (count !=3D sizeof(s32)) {
+		retval =3D -EINVAL;
+		goto out;
+	}
=20
-	if (!idev->info->irqcontrol)
-		return -ENOSYS;
+	if (!idev->info->irqcontrol) {
+		retval =3D -ENOSYS;
+		goto out;
+	}
=20
-	if (copy_from_user(&irq_on, buf, count))
-		return -EFAULT;
+	if (copy_from_user(&irq_on, buf, count)) {
+		retval =3D -EFAULT;
+		goto out;
+	}
=20
 	retval =3D idev->info->irqcontrol(idev->info, irq_on);
=20
+out:
 	return retval ? retval : sizeof(s32);
 }
=20
--=20
2.20.1

