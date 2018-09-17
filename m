Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8831EECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E502147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CwpQqpMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E502147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731400AbeIQIeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:34:46 -0400
Received: from mail-bl2nam02on0116.outbound.protection.outlook.com ([104.47.38.116]:52292
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731540AbeIQIdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdpdctwA5SpcAWfIytqXmntsYzDGkmBANOvn3vULeF8=;
 b=CwpQqpMJwHqEfT1gjoTECL/o99E5PR9i44B9n78f9YWCjozTxTewuB+fZkgCx0m0bGxNXVr/Vab+ijbAWOQiZRWphZBWKmYND0VMm3nKytpoBw744ys138iAT5dRISXpvO/njIpQo6F/LVvi1EwEHYOU+D0NZT7t9xnpxq8B/ns=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:07:50 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:50 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bart Van Assche <bart.vanassche@wdc.com>,
        Mike Christie <mchristi@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 09/29] scsi: target/iscsi: Make
 iscsit_ta_authentication() respect the output buffer size
Thread-Topic: [PATCH AUTOSEL 3.18 09/29] scsi: target/iscsi: Make
 iscsit_ta_authentication() respect the output buffer size
Thread-Index: AQHUTjNRZI7QOe5BnUqwkxtKO4GtKw==
Date:   Mon, 17 Sep 2018 03:05:42 +0000
Message-ID: <20180917030533.592-9-alexander.levin@microsoft.com>
References: <20180917030533.592-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030533.592-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:3VJ60Vg4Hf5EYPqhNbFltedxP0NHEjP93kYQiPEXHmG6mXHInjSRg1NWwSgJfiJ9Y4Babvlu2C6Rc9xfBx7DbhtGsWMiJzxJ3ELBZdbFa4pXiLf3uX0lWms4zDvuzD/DQxSj0BxKSIkxrfjBbzBp+z71LR93nzQRrzxn+XMsAOg3wEDk7QjN8Lk6+2WinBSR8BvenxcaFmnkXypB92dxAwpIZPI2FFkNnOSG+cSkknnGFOyxsGmMTzwSyUqmHCOGeCaf4/ijJblfbgmitucuisDRV5jRT3TM3nwq5lPUdkTKNuV+23fKgTkCYLMi3n5Ao5l9Ic5/37ik78F/h6ae0/cESCM4uXujXpT8AoaaNQ2rqAZj/t6Toxc7NTrJlJMN1dBSUJlWzISA6l5gp6Avl0SejvdIfeoa4cq0Keg47eS+jTxlzGZAlIY9Cno/vwoB2IzTOKRPOezVFHMJ69acpA==;5:vHx0g9cQ/XVgCXG0ZFr2eSBA/1g+jYoxXQF7alHrAbRMePG8D6xmL/oXvS2No7qfq8VwSVenxhgEKr4KfSz31QXcS/tlTdfnnbgt8erNy+9cXu7kAs2JFk5I+dbbZ3l4PFZmzS+91bNmwP39kfxRQIQvf++lYm5X0kOdbp/Z2SU=;7:lqWoqgXBFdM9hCQIw6INQXab8u97V7EIht5yk6KXIWnJMDHjw1kfPCRtiTr7VQ6EcrtuHQqL4tLxiQvpjO9nMrtMKgyHOo5rV4Q+XtmWsiTPZDX/eYaUB6qoUjH3ujVC+/Wnzq4Czc8jeVOZnFLMmDWDaT+EAYS+GoGW/HLqHcqiqAuoM3w5NXtj06tV6Bt4w06qpCeKs7xFTKOXImS+vsO6f4cHk4fJdSrKr6baomTJFBaCll6mZ9duM8KLFRDj
x-ms-office365-filtering-correlation-id: a678f9f8-b46e-4ead-b1e0-08d61c4ac0f0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB08398F972B0D0BD80177DEA9FB1E0@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(136003)(376002)(396003)(189003)(199004)(8936002)(6116002)(86612001)(3846002)(575784001)(53936002)(81166006)(25786009)(217873002)(5660300001)(68736007)(5250100002)(6666003)(107886003)(256004)(14444005)(305945005)(7736002)(2900100001)(1076002)(86362001)(2501003)(6506007)(4326008)(22452003)(10090500001)(6436002)(11346002)(446003)(76176011)(102836004)(6486002)(186003)(105586002)(6346003)(26005)(106356001)(54906003)(110136005)(316002)(478600001)(6512007)(2616005)(476003)(486006)(10290500003)(2906002)(81156014)(36756003)(66066001)(72206003)(8676002)(97736004)(99286004)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: exLz51I92Y2+CvmB8AtThNkVPsRSB1ZIzPFe6Zse6sXT+9ZpibSHwGYXQuhDjwFhUNCL+rzF8mbnfQNKIkxoLo8/Wesx24dIsCHkENBsbZHt9WFHs4NPYQDPzcAwuGUbwjJ1vQGF/LL0RoQp+yl9F1Sn5Piuz/2ZtzcqbSTqrPVlFvVeh7FWL5WMDGUxTFPW9Grx8mLXkIbacU6fbmDraRdcYITmK0T3IoSv6hzf5yfaWj9FEm4nolv+LibbkmDT0jPJX8fqqhxcCmAttCn+Omr6Ux2GjuKiyqbWUPbYPS9EqEE8Vuo/4k/6mSvwd34N6wINV9pgkXveogI6sW6SEWHEs7YY3ds7Y58/dg7D/tc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a678f9f8-b46e-4ead-b1e0-08d61c4ac0f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:42.3421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bart.vanassche@wdc.com>

[ Upstream commit 35bea5c84fd13c643cce63f0b5cd4b148f8c901d ]

Fixes: e48354ce078c ("iscsi-target: Add iSCSI fabric support for target v4.=
1")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: Mike Christie <mchristi@redhat.com>
Cc: Mike Christie <mchristi@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/target/iscsi/iscsi_target_tpg.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target_tpg.c b/drivers/target/iscsi=
/iscsi_target_tpg.c
index 5530321c44f2..afef70b1aaaf 100644
--- a/drivers/target/iscsi/iscsi_target_tpg.c
+++ b/drivers/target/iscsi/iscsi_target_tpg.c
@@ -651,8 +651,7 @@ int iscsit_ta_authentication(struct iscsi_portal_group =
*tpg, u32 authentication)
 		none =3D strstr(buf1, NONE);
 		if (none)
 			goto out;
-		strncat(buf1, ",", strlen(","));
-		strncat(buf1, NONE, strlen(NONE));
+		strlcat(buf1, "," NONE, sizeof(buf1));
 		if (iscsi_update_param_value(param, buf1) < 0)
 			return -EINVAL;
 	}
--=20
2.17.1
