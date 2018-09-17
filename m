Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D9BECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A95214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PBMQUjnO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A95214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731240AbeIQIkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:40:09 -0400
Received: from mail-sn1nam02on0129.outbound.protection.outlook.com ([104.47.36.129]:32192
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730417AbeIQIbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gN9VuNZlAd5kP552wRTyIkUXeqw8VREw9YoJhQFm1k=;
 b=PBMQUjnOB4qaUPSqFNgkr1iE/2Zw4gvBmnCkoRanX3BMy+Jpl7nP+4vmoVNkrZNpqTzFAAMMzA5dZTIgwjl2GFsCBow4XrZJ9ZdHJxX/FECvf8OZvIw0bwyPXWietPoeHNpxBIAFTr2ZHdDGqz6+E4LGi6XnEN4N/M2w77CQBMk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0166.namprd21.prod.outlook.com (10.173.192.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:06:32 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:06:31 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Colin Ian King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 05/43] staging: rts5208: fix missing error check
 on call to rtsx_write_register
Thread-Topic: [PATCH AUTOSEL 4.4 05/43] staging: rts5208: fix missing error
 check on call to rtsx_write_register
Thread-Index: AQHUTjMzD+n7K1kJYkiQExSZjU6U2A==
Date:   Mon, 17 Sep 2018 03:04:51 +0000
Message-ID: <20180917030445.484-5-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0166;6:96e49YgIEGa9cktN5/kAxRx0Ggj7tJ8Y4kimifkQ+RvwRaTSjIZnZYfqpz8AamVZUbJg4isjwgyHTHe6znIGxpmphLuDTKAH9IoqrhWC2uOdSw8V1oEUtaeQmSuIMqFKp2nh/ksJXU3BnE1UI+DmqCxc8nBl9l8EvcAvn4Tjr5m6R5sdmPktd9nXKdm0N8jp3iTqG9YmJ0mM23PRpMunXwY9VKJqJUuDiZCvuqdeufTgO+3FAPR3QfSYzClrU7kvfSJF7fTPF1SLmF5p0RblqFqnMBxRXxwtrj6htj8lQtYZnfPFScoElOhVYUX1U1MNsOdSUKkbYx9AUITVDIz0wsLr0t9ckF5uITQ9xIYR6NhPgQpF/LXxuozPN69FcnKIJ6Xx9fBAsITFC2ccmtxUDMQL6rhKH1vkU2C+BRv2tOXZTpGsRkTKvbXVMZQCV3Ebls0qOgZn4twZn0mJ1FedVQ==;5:ndyYVaiBgObpzaxy+LPURbyKc4pGkZG79gd1mOuWTEC2Cd6NmUt9R2h/k9kFXkvam8lTBeiIyRersRpPe6DDdxrFuEsrRl3j9s3GLjOiwJPobLqZl4bQNmu+awrPRi6EiO/bv+5ZKPEkz4CKdWqkdkB/0zqwhnd0fc+audOGQ0w=;7:xYTnu8fvQ4ZQyvMhIaTS3bSXG22ypdtnTglWDInp5+H4u6uSxrv9Dxwb6zeRFe9pS+8b5MQjlcA1vusb2mNuwtqXP5u6+K+UCPqjjZ2ZVUvpa0W4NTfJa+6H1ATosJdO+dXuLhw3VtDBPC8vdYQKdgF4LkKmwXFqsDpIlQbuBAmr/0gIuywkmL2dz2ke/dc2VSuPdOlaWY77m9K+l/hSX7+BeQqolIrsUoMRIkaefuJZ4abXw1LvagqhXpVar7kZ
x-ms-office365-filtering-correlation-id: 79a04f8f-07d7-446d-7aa2-08d61c4a91c2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0166;
x-ms-traffictypediagnostic: CY4PR21MB0166:
x-microsoft-antispam-prvs: <CY4PR21MB01660F6413F68461F8300C82FB1E0@CY4PR21MB0166.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(198206253151910)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0166;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0166;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(366004)(39860400002)(396003)(189003)(199004)(305945005)(256004)(14444005)(217873002)(486006)(186003)(86612001)(66066001)(7736002)(6486002)(102836004)(6512007)(2900100001)(25786009)(14454004)(6666003)(2616005)(476003)(1076002)(97736004)(86362001)(6436002)(5660300001)(6346003)(316002)(2501003)(6116002)(76176011)(6506007)(105586002)(8676002)(478600001)(3846002)(106356001)(53936002)(68736007)(72206003)(446003)(22452003)(5250100002)(81156014)(8936002)(36756003)(10090500001)(107886003)(4326008)(110136005)(11346002)(99286004)(81166006)(2906002)(26005)(54906003)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0166;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: p5hJMYmB+39qEXUHFWB6QwWG8qRGccGsvVEUhbTha+1YmlTIZl61dPRCHxkGtIISVUeYeLiRnVGmrjrs6yQnSbyhU4+y/Mz7sb0mIEGMctfFEW/Uw4oXWaesNF9CJpvxAQItjUktd5nvoInkCeuBdHP3CWLbexMAAkGa/0ZV3CBO9bwKyTVUQV9OwyIrozEyzHf0bNDRKGUQ1z+3zitpKcQ03zwNhVbrrPm1ew402Cn8cBK97KlnjpkjsLeUagKJi8J9cdbeJnXnDir2lDTUA5vKxYa/BE0Lkbkyg6zeZAdiw3FPjWOZNs9zRrgvKy3cOT8NBQTIfMb0XK+qmZGWNKlbQEqe53g7ZSrSipkjh1M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a04f8f-07d7-446d-7aa2-08d61c4a91c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:51.8518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit c5fae4f4fd28189b1062fb8ef7b21fec37cb8b17 ]

Currently the check on error return from the call to rtsx_write_register
is checking the error status from the previous call. Fix this by adding
in the missing assignment of retval.

Detected by CoverityScan, CID#709877

Fixes: fa590c222fba ("staging: rts5208: add support for rts5208 and rts5288=
")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/staging/rts5208/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rts5208/sd.c b/drivers/staging/rts5208/sd.c
index d6c498209b2c..9a876ce92dbd 100644
--- a/drivers/staging/rts5208/sd.c
+++ b/drivers/staging/rts5208/sd.c
@@ -5031,7 +5031,7 @@ int sd_execute_write_data(struct scsi_cmnd *srb, stru=
ct rtsx_chip *chip)
 			goto SD_Execute_Write_Cmd_Failed;
 		}
=20
-		rtsx_write_register(chip, SD_BYTE_CNT_L, 0xFF, 0x00);
+		retval =3D rtsx_write_register(chip, SD_BYTE_CNT_L, 0xFF, 0x00);
 		if (retval !=3D STATUS_SUCCESS) {
 			rtsx_trace(chip);
 			goto SD_Execute_Write_Cmd_Failed;
--=20
2.17.1
