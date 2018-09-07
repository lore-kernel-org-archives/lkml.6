Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AFDC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E532083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="eUg9PFyZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E532083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbeIGFPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:15:40 -0400
Received: from mail-sn1nam02on0135.outbound.protection.outlook.com ([104.47.36.135]:30237
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726596AbeIGFPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sla+9hif14j3GQ8pT1yfE3pIxRTbGMO0Ifo1iBSBfo=;
 b=eUg9PFyZqScDaI/8ilBuAhMH2VNfufmiusEJL39hWC90BgMyWHP6EyMOcRdfD4/Ffv0hFe+UTHyTX4aBeGdV0Qgq+VoXNWcZWd82sCBOoQwbapl0pddyimjqkIg7zVkdatEUtZ//W415hhrHYKiiQd42gY+RD6LVxRCfh//4LJM=
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
CC:     YueHaibing <yuehaibing@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 63/88] wan/fsl_ucc_hdlc: use IS_ERR_VALUE() to
 check return value of qe_muram_alloc
Thread-Topic: [PATCH AUTOSEL 4.18 63/88] wan/fsl_ucc_hdlc: use IS_ERR_VALUE()
 to check return value of qe_muram_alloc
Thread-Index: AQHURkLWgHrXLXy9xkeWr0JV98e+7g==
Date:   Fri, 7 Sep 2018 00:36:37 +0000
Message-ID: <20180907003547.57567-63-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0118;6:70MFovKogfWfw/owzh/IXz5N4l+7WFm0kt1IrnOwMNqL55EE3j7iVCaFr7VQgvWN44VO7RpdjfyF9lpsAGGqweaxFSJ50gMnzS7krdtzAz/w4RfUZ5G55iGVnFvVpCH/8Ku881LBDOBd22snX3lVHKA1RxLRvtUj0BQMzZwuQCyngAjkGE7whqi5Ern/zZy7lXXW0DV2S4GeozeF1a69t5EHkk5z+TKvnIzQjSj9U0DndJX15FUivvpGnfY6lKmOemz5x2r6uh2QMOzDyf6/NodZ8jKhoAFrUvgIKYjAdhT4svdAEpUOAtdhF6OqCPUQLqFzTJh6J2NBVKhTqKdmJCYUSToVfDqneSlnEePe5szrHrD00sFzs977reLUwmdT+hCtRb2vaMC1UKwySmha1ChVMnpHo4kQweX4LSFoH7/megNxTepWz9tIgB7iaT3F4NjMtva+CiAWtSqW5/bMIw==;5:siAv9HLcHvwbIl46RJSqHKV7WxCx0FS446n1D0N6y1+MtxeyOz8y7y1oykPKd29DJ6kTURGfSkT3iE+5s1PAI+VRG/BCaCKEgsxu90SdmnnsmlUw53tvbZIglPC/JtOEoWDOYMErMkIcH/N+bSk6FA82uxXqmaTVEC3kzjCv2T4=;7:yUUA9jDPX75xZuMvJKj7xXbDZcu43fzqgmuw+tQLYz+1rMqIxDCEaP/Kgrhwp0Zjx7Sz3t8rGjcs+nZcbI8gDJySgcrTeM0up4A4HJcqMI45UI+gjSwb5/rtsSTqLTrT1jDd3Ae6wq/m/CXom9CrCwroX+cWvzYaE1X3qsY9PCSNNcEkSKGsdGecZkF4/zARzxgxyt1N45KwVvmeDt4t3gkZGZQmBFXaTky0kNiWdTEYM1yILZEsHOF2igPHBMNG
x-ms-office365-filtering-correlation-id: 7067a0ed-0f4d-498d-f209-08d6145a1899
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0118;
x-ms-traffictypediagnostic: CY4PR21MB0118:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01186D36959D93334600BE3EFB000@CY4PR21MB0118.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0118;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0118;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(136003)(366004)(189003)(199004)(97736004)(2900100001)(53936002)(316002)(86612001)(25786009)(86362001)(575784001)(2906002)(6512007)(68736007)(110136005)(54906003)(107886003)(4326008)(10290500003)(14454004)(81156014)(81166006)(66066001)(8936002)(8676002)(478600001)(6116002)(3846002)(72206003)(305945005)(7736002)(1076002)(106356001)(105586002)(36756003)(99286004)(186003)(26005)(5250100002)(446003)(256004)(217873002)(10090500001)(76176011)(5660300001)(6436002)(11346002)(6486002)(6506007)(102836004)(2501003)(22452003)(476003)(486006)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0118;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 72XFrCfmvrtMHII3/rBbQetKBo/478ptlDvgqdj2PPgHrM5P34EQbhnrxhASdiTN/hBq++E8zarnaK9ZgijDqUdRpL/TN/uHV08nQFWP9zRnMaZ7tX65lEjkmEDG+PolJ5z9DIaAi3GMIWeWjshQtGYE64NZnGIjO82W7QOeKrJtLj5Zf62zBYVSqUMdL134zULGchSFU/imt3IS6C6o2xkTQYo2hOdKnXXHco1EqbC0ZFnMHTJQJrm80Ezox3rVhv8ohQlNhG2flV/9dXnvjxBsZNkfdfQbtzBjpD1A4hZkQ4Qajs/b+lF9+X/6wHBcI6swXv1aoodmQ4MDBbKgQ1HL8f/z/3duzRYeleHiMys=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7067a0ed-0f4d-498d-f209-08d6145a1899
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:37.6403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit fd800f646402c0f85547166b59ca065175928b7b ]

qe_muram_alloc return a unsigned long integer,which should not
compared with zero. check it using IS_ERR_VALUE() to fix this.

Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.=
c
index 9b09c9d0d0fb..5f0366a125e2 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -192,7 +192,7 @@ static int uhdlc_init(struct ucc_hdlc_private *priv)
 	priv->ucc_pram_offset =3D qe_muram_alloc(sizeof(struct ucc_hdlc_param),
 				ALIGNMENT_OF_UCC_HDLC_PRAM);
=20
-	if (priv->ucc_pram_offset < 0) {
+	if (IS_ERR_VALUE(priv->ucc_pram_offset)) {
 		dev_err(priv->dev, "Can not allocate MURAM for hdlc parameter.\n");
 		ret =3D -ENOMEM;
 		goto free_tx_bd;
@@ -230,14 +230,14 @@ static int uhdlc_init(struct ucc_hdlc_private *priv)
=20
 	/* Alloc riptr, tiptr */
 	riptr =3D qe_muram_alloc(32, 32);
-	if (riptr < 0) {
+	if (IS_ERR_VALUE(riptr)) {
 		dev_err(priv->dev, "Cannot allocate MURAM mem for Receive internal temp =
data pointer\n");
 		ret =3D -ENOMEM;
 		goto free_tx_skbuff;
 	}
=20
 	tiptr =3D qe_muram_alloc(32, 32);
-	if (tiptr < 0) {
+	if (IS_ERR_VALUE(tiptr)) {
 		dev_err(priv->dev, "Cannot allocate MURAM mem for Transmit internal temp=
 data pointer\n");
 		ret =3D -ENOMEM;
 		goto free_riptr;
--=20
2.17.1
