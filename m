Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A1AECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001FA214C1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NdQ+P2pM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 001FA214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387695AbeIXUwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:52:14 -0400
Received: from mail-by2nam01on0130.outbound.protection.outlook.com ([104.47.34.130]:30464
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731441AbeIXUwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6Ynzesq3t0mdxk6H+uOXP2FGAqpnKPG3eU05DG1234=;
 b=NdQ+P2pMVH6p8viks4dXkT9jFYIuitc2Dt5FwOEBb4P4A48gy2fpJA612gky2F9ux2WF0R52TygJvh6v1mRlhGulHiThuNE+5YcL+PVrzIPYURWl+Ls+ISfbkE3J4U5QNE6NIbS/uYKtgy6gv/HApsccEyymZqltqiD4bfOauh4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:49:40 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:49:40 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Varun Prakash <varun@chelsio.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 05/36] scsi: csiostor: add a check for NULL
 pointer after kmalloc()
Thread-Topic: [PATCH AUTOSEL 4.14 05/36] scsi: csiostor: add a check for NULL
 pointer after kmalloc()
Thread-Index: AQHUVBW4QBhmJiyPjUuuo9ZcJm2QTQ==
Date:   Mon, 24 Sep 2018 14:48:56 +0000
Message-ID: <20180924144851.164533-5-alexander.levin@microsoft.com>
References: <20180924144851.164533-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144851.164533-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:fQ6V+MJmy1cl4mHVR5r+QEM7pnGW5GSIlBspVExNPlaefey43We+sTF6DXHKgaOeGm1OrDNllMWAHhCqtjLrvtDORtIr4GFco436zIxSUGNqK8bXIL6vLN6Pjgqcd4gPcqY8uTmWXIIr/QL7Y9oE9lVzPnJVVx+J0P5IrZbr1xZPkw9fKScyxFWGG5zOzlxm6E0BwlsZyDFYTOMhq66wF4gYlEtRGniqCCbcuT9HH7WifepPrkIYq67sHCbc0rFfXcSeOjdF72Q+9XmeC0kAnDWbdHZhpkMlETc0RZx/wnD+DPQYWEx6GDr2Lfe4pVeJZiYduVIaDEUFjJt4vH34hs+1Zsfo6RxZ5f71u9+Kfr/XDe6N+t9ibtQwqfjcuqbvf8qHgxukOorQCV6jvpmEPISPI8T1IU0ROwsKhCWRKiZ6vRU2ggjGf3zPgCmLTVGUFhChhB6x6kF8xAfCe9/qIw==;5:LIleJGUTUYa+GIGckLq4AEhRXQOTZoupwIi6R2GZ7uQUrtRqzEKj6YIBzv9Q0AZgIWeL2Y3yTQpbI2c2cdmUsqSPXzX/LI5bG/B7wUXYHlNm0EVJNR141qhvlcv7uyXoxai4Mo7wqkU7kFxrrILjBwzqB81LEdTpsbepks8OJbo=;7:f+fHStuwAN1tUJAtDTs6xPtdW1m+oE8tBTIYPgGMqIaswFYIQWl9iRoMzTX+l/G+8uLnFO95o38SvaMwda33bWMu0l+pcTVe7xt3GfM1n3mJ/hDiukWobimTPkvOBUVb5Ia+WhL+AXJ5cEgN6OkF/h/XPY0ebqxMJWJW0oE3deP8to0uYTFBi1BeJKisqDkHx7JC7095g+k+qBql1jzZSY/owH+nxF5FDwElinztltDMPvxrU2ratAI0ou/stNx4
x-ms-office365-filtering-correlation-id: b1635574-2634-40ed-4ea7-08d6222cf54d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB018158B8FD5E99CC16C15DAAFB170@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(198206253151910)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(575784001)(10290500003)(6116002)(26005)(102836004)(3846002)(5660300001)(22452003)(110136005)(10090500001)(8676002)(1076002)(54906003)(105586002)(186003)(316002)(106356001)(2501003)(6436002)(97736004)(6486002)(107886003)(7736002)(36756003)(478600001)(72206003)(14454004)(71200400001)(71190400001)(305945005)(256004)(14444005)(5250100002)(217873002)(6666003)(2616005)(68736007)(53936002)(81166006)(81156014)(2900100001)(476003)(86612001)(4326008)(8936002)(486006)(99286004)(6512007)(86362001)(2906002)(25786009)(66066001)(6506007)(11346002)(446003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9nKCz0TWkDPPRAaV9fMjbF35/AoyajiaFA/8LRdYN044t6ENFznz7zQ8uM5LO0cy+X+ERRU9Nh9nP7qVAoip6ADsIIaHwArOrICj6P4Gmc6pR0xQZQ/FF/8vqwdmMWu6cKoAa3oDKqSOmKiLcIHb10XZYz9uW8ztUtpK8quAusLIpuwP5KnWyb7Q93/U8m6h/Erli6nYC8xmxc7TAWY3RVZxwzIQMpDL1qlaF2+lBxXm5vjBexESl+ZMzjDmI62eGa5GoAYsg70dAwVdYEMD+3zsySYMC5YG+iD5sJE5P1Bq15Kj1rm4EWj0CXfVEBQ6Z5o5jKiSVXW334sMG2oMGALwpZjIZNhxzmmEtxFONHU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1635574-2634-40ed-4ea7-08d6222cf54d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:56.5778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
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
index 5be0086142ca..ab30db8c36c6 100644
--- a/drivers/scsi/csiostor/csio_hw.c
+++ b/drivers/scsi/csiostor/csio_hw.c
@@ -2010,8 +2010,8 @@ static int csio_hw_prep_fw(struct csio_hw *hw, struct=
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
@@ -2039,6 +2039,13 @@ csio_hw_flash_fw(struct csio_hw *hw, int *reset)
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
@@ -2052,11 +2059,6 @@ csio_hw_flash_fw(struct csio_hw *hw, int *reset)
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
