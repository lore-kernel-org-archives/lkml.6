Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71805ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CAF3214C1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NglrFrnA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CAF3214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730723AbeIXUun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:50:43 -0400
Received: from mail-eopbgr720121.outbound.protection.outlook.com ([40.107.72.121]:64608
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730352AbeIXUum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TZfR2faev0tnI7IkA3YVnEpFpr8/yPucu5Oy4lcbW0=;
 b=NglrFrnAL+9tQMR0h7h0p1lnNBuGABF+ZF1JTxcVT/oyAX/8nunkZwOMggfH0FciSD0UCO5GMSsdNKbmX93TxDBQcBSVjcRpHBAlr2AkIaxa7ETmNWifPJvuV2Mh+038f9ZiFVOF0jB/102avj5VlT0rN46rhxNmK6arSCX89do=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0134.namprd21.prod.outlook.com (10.173.189.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.9; Mon, 24 Sep 2018 14:48:05 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:05 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Varun Prakash <varun@chelsio.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 07/76] scsi: csiostor: add a check for NULL
 pointer after kmalloc()
Thread-Topic: [PATCH AUTOSEL 4.18 07/76] scsi: csiostor: add a check for NULL
 pointer after kmalloc()
Thread-Index: AQHUVBWZM7IbuSn+sESCRa6+6pKtmw==
Date:   Mon, 24 Sep 2018 14:48:04 +0000
Message-ID: <20180924144751.164410-7-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0134;6:Jl3EwVK70eFx1wBY61ucAxPPAuTaBuI9ev7DcKPhTLDQsSZFZwJcJOrJ8B9uiGZQZD39Qj1nBhov8opGvwn1E7ktVVQyw7im2ZvTpy9DzAYOKzbkXlTXdh81wWDjOnlIbO9EI9i8XcGzd7HaL4sR25WxLm0OMmaWYUOqllL3L/CmIxzR720POCOfvyINqpnTW3hghuFlHEFKMNqRFxnSNN0l+N2bDRIk1S6ZaotyJ/EFPbbCtYMK7kLW2tsCjShniw0YKR/1Cka56wnFioi1UHQtC2fXC/Qz6kIXlWeeJQvjwCHOUFyy+W4TcWyX03cYy6ACL9jz784YO9I754RjAjQgANXV67pG1nWJAEI2FwduugUiTiQC3FyqyvDSihmcr1DcMAEiAfE+e0Imyt0vG+ZShQMfD51Zbw76xtHfZsQVJMyeRQLgN+r05zJazSSBXUZcYxzXstjebBme6xAriw==;5:C2hyfwrovf7q4vdp+pYMX7rZf699EzIymH1tLk8Vq8Dn67yaivOYN2OhTE5TsI4SiuS8j4zTi6F0HNCuD1O/YH8a2VFFvHUsYbuw1JHfjYxx/uVrtCv/UjEKUcR9BYD6AN8Nz32rs1rD9fkSrd35QhRSloLlGwcQ013StQzX1Kc=;7:ia9vdxPeaPMwBD9ltZdUsvTJfbwCt6O9n0/8c7JIsS0HXtAuCxXo5LeLuZjt829/Z5K5eEhmJXSvy6su8PLm9174C43z3GI5RO7R3bwu2MTYCwsFhtTS8yVI1r8SF7CE7AQcIV1cta8h43jpaC2/NeqJYFfoy0OWE4LZgzJz+BjXfGBzHS9bHnhspG9xtQIkBAvoe13Un1ayw7ZPwcQmGNEepW/6/uznBfbaVqbMXui68QbD8sw5kax8K/I3wJNC
x-ms-office365-filtering-correlation-id: 1941e56d-21b7-4b15-8bae-08d6222cbca6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0134;
x-ms-traffictypediagnostic: CY4PR21MB0134:
x-microsoft-antispam-prvs: <CY4PR21MB0134AA1E56465CAD673B1B03FB170@CY4PR21MB0134.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(198206253151910)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149066)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0134;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0134;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39860400002)(366004)(396003)(199004)(189003)(2900100001)(86612001)(3846002)(106356001)(97736004)(105586002)(478600001)(10290500003)(36756003)(71200400001)(71190400001)(575784001)(6116002)(8936002)(76176011)(186003)(5250100002)(217873002)(2501003)(8676002)(2616005)(102836004)(26005)(81166006)(81156014)(476003)(14444005)(11346002)(446003)(256004)(305945005)(54906003)(486006)(68736007)(86362001)(6486002)(5660300001)(99286004)(4326008)(2906002)(7736002)(110136005)(6346003)(6506007)(6512007)(53936002)(6436002)(25786009)(107886003)(1076002)(14454004)(10090500001)(316002)(72206003)(22452003)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0134;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Xn+OXjybq8DM5LbyBvqYe41ZVBnlUUwrFCNXZZFrsPtamevU5XuhvU5bJZipnF9XvfNbh7TgDraOqrIpyTuDU/gn+t05Gyciqon1JF1+tBFNyRO2im+75sTMyKvte89Gt3+9qGQJH6px5LmAOnY+nMoWSDuCv0MYve/liXgTscBioHMSulloTvrEcmKSMf5WqJOUJHSy3+zgfAvbY8jgBNApp0Krr5VS58tAR6ngxz3EaiRb4/ns9jGx56jrQgG5xl2loGrrsha/zh3rN2T6cpyKmkhUkanF5xFx6K5JAsgQ0qs+Dtb5yMF3ilrvwqSgJr3LLfF4ND7WCfu+NWT+Gllg0ypLqiG4q6nUTo1d1y4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1941e56d-21b7-4b15-8bae-08d6222cbca6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:04.3288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Varun Prakash <varun@chelsio.com>

[ Upstream commit 89809b028b6f54187b7d81a0c69b35d394c52e62 ]

Reported-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Varun Prakash <varun@chelsio.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/csiostor/csio_hw.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/csiostor/csio_hw.c b/drivers/scsi/csiostor/csio_h=
w.c
index a10cf25ee7f9..1ee255a62f1b 100644
--- a/drivers/scsi/csiostor/csio_hw.c
+++ b/drivers/scsi/csiostor/csio_hw.c
@@ -2275,8 +2275,8 @@ static int csio_hw_prep_fw(struct csio_hw *hw, struct=
 fw_info *fw_info,
 }
=20
 /*
- * Returns -EINVAL if attempts to flash the firmware failed
- * else returns 0,
+ * Returns -EINVAL if attempts to flash the firmware failed,
+ * -ENOMEM if memory allocation failed else returns 0,
  * if flashing was not attempted because the card had the
  * latest firmware ECANCELED is returned
  */
@@ -2304,6 +2304,13 @@ csio_hw_flash_fw(struct csio_hw *hw, int *reset)
 		return -EINVAL;
 	}
=20
+	/* allocate memory to read the header of the firmware on the
+	 * card
+	 */
+	card_fw =3D kmalloc(sizeof(*card_fw), GFP_KERNEL);
+	if (!card_fw)
+		return -ENOMEM;
+
 	if (csio_is_t5(pci_dev->device & CSIO_HW_CHIP_MASK))
 		fw_bin_file =3D FW_FNAME_T5;
 	else
@@ -2317,11 +2324,6 @@ csio_hw_flash_fw(struct csio_hw *hw, int *reset)
 		fw_size =3D fw->size;
 	}
=20
-	/* allocate memory to read the header of the firmware on the
-	 * card
-	 */
-	card_fw =3D kmalloc(sizeof(*card_fw), GFP_KERNEL);
-
 	/* upgrade FW logic */
 	ret =3D csio_hw_prep_fw(hw, fw_info, fw_data, fw_size, card_fw,
 			 hw->fw_state, reset);
--=20
2.17.1
