Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB865C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C7E2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LLMAJLBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C7E2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbeIGFQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:16:22 -0400
Received: from mail-eopbgr690133.outbound.protection.outlook.com ([40.107.69.133]:54795
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727862AbeIGFQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kKxDvu5+sZK79sc9PpnOFA3MYxB0uxOgYrauX5o4mY=;
 b=LLMAJLBA3TOQbcGViy3NDn98+RfkkHCz2t/frRzCxhPcSYgpv5uvWdvjWDErCN/ZDVjEiwzH6jma7l6Ku+Fl5wq71hrqOvgsYUKlvUe6pnVqjjkapk/9W2eMvrqQTfJRS9wnN9IZrbiAGs1Z3dwrhN/g+3kuXJnhgf0SbEZMmH4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0503.namprd21.prod.outlook.com (10.172.122.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:38:13 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:13 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Miao Zhong <zhongmiao@hisilicon.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 03/67] iommu/arm-smmu-v3: sync the OVACKFLG to
 PRIQ consumer register
Thread-Topic: [PATCH AUTOSEL 4.14 03/67] iommu/arm-smmu-v3: sync the OVACKFLG
 to PRIQ consumer register
Thread-Index: AQHURkLx6i0GvT6U70W6+LfjYtQoYw==
Date:   Fri, 7 Sep 2018 00:37:22 +0000
Message-ID: <20180907003716.57737-3-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0503;6:neki7T1mCBqJ9Qdm4k6GpHbDdY4kwASEWSg9mODhf1JZLfiz/5XCtfrGARt8CTne3MAG9MONCrXWS2Bupwvnw+/wpaqMtEr5hml7iIBSp9c47v0Fg4sF2h8yfJPO8DQl6QTFhqaamnTuKG4pgYPctcHds+8N9nx1lck69xCSK4EI3WNpP5+1KACwOxvTAjM013hNmDL2FR5/9q2fkjIDc+gbVWqbO2q5a2xOFHbazYTIo0NDMzR7wXLpywPr98N5+MLo5wuEj7Kp9/MoF+/7BeJWPU+Rg21ojJc1taLxVYrzEXMywqqDDdEFlKvPCwL7gUKFekZGqJss6bzMnRqDrbakXK3Lm9KqBNAsFk1L5oCzW3yAEtgi2u/OkS4bS1GnVyJKGuni1MUukoauUMUbP5v/eaHgoRIyvgfVcdLDERjAcAfEYMQejW3rRSIljAfpURzPcfeSKp3HPkvztWTDhQ==;5:sun/uNwbzarNtabeC0l0xRiaG2tan71EKnOrqmvM0ZnX/73SmRw7oAaeRW1OThVKz/aw4eUowDVN/2OXt4tgsiEkQ0Adq588iTo5W3rgCCK8uamVDz+2pbWqaUxVm0y5GMHxOuGHx8XHZh/zWIS34aOqFdQwDQ1y5PgmyMF3GIg=;7:k9tWNbywTrSyt22cne4g55ZwA6igMreVfXg6i2kBS9IbRoQXFg8oFu7zZiG3eioIS3OI9v3MwaI77c64BGvizZWwPqRjBzcn+I2BScnMQBOrY5b6g7c6uYWTIVLr4Ob/6cYuYuWMXdTAhAxPCMGMiFkxwu5ZaLPWoKNNVlUc0wJnktV4iJjOV8t/DzAtARBs9pOFUvG8+SJxHR/Wx5TU1YGFRubcgPnzOVhdnhDVEPlKop80ReH7e9tUnSvEb3L+
x-ms-office365-filtering-correlation-id: 00280b05-1f1a-4ab8-3599-08d6145a31d6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0503;
x-ms-traffictypediagnostic: CY4PR21MB0503:
x-microsoft-antispam-prvs: <CY4PR21MB050387A25E70BC67897C39B3FB000@CY4PR21MB0503.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(8121501046)(5005006)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0503;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0503;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(136003)(39860400002)(396003)(189003)(199004)(76176011)(2906002)(217873002)(107886003)(256004)(5250100002)(6512007)(22452003)(14454004)(86612001)(316002)(6436002)(486006)(110136005)(2501003)(6486002)(54906003)(81156014)(81166006)(14444005)(8676002)(86362001)(10290500003)(2616005)(25786009)(476003)(8936002)(97736004)(5660300001)(102836004)(106356001)(11346002)(68736007)(6666003)(4326008)(6116002)(3846002)(446003)(305945005)(7736002)(66066001)(1076002)(6506007)(478600001)(53936002)(2900100001)(99286004)(10090500001)(105586002)(186003)(72206003)(36756003)(6346003)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0503;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: WS6IdBzaAXcGtUZ3+J3MM80bUbbbl78DZPNdFakfbT2IXU0rlbjyL/NmHHDxJGjwZZkpuO/TCgRz0q0AA/FJKQcxu9WwUJQw8qGHUTt0UriqLGgEBmjlPNXCThfdnkB15yXQsaB1bz+ptJk6uvYmkU1Vuc3rojPjDi48QKW8Nf85AFzlDD3hsW44KdgpQLEank8MGO2OG5pHubmIN/4UttKLNoj9ZEOqvCrVeGhm0taraOZgmxU1/uCnrwmL7DgmzGVuhrWOiL/cZGekArpmBRWzwpvFlh3OBFSACMiNeO6mGWf9rBAnP1/jEWtwrxD2rF6o+pMSiSbtv3YAgDh0QxKzsLEsTe87PqOk/Ots7T8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00280b05-1f1a-4ab8-3599-08d6145a31d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:22.8956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0503
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miao Zhong <zhongmiao@hisilicon.com>

[ Upstream commit 0d535967ac658966c6ade8f82b5799092f7d5441 ]

When PRI queue occurs overflow, driver should update the OVACKFLG to
the PRIQ consumer register, otherwise subsequent PRI requests will not
be processed.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Miao Zhong <zhongmiao@hisilicon.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iommu/arm-smmu-v3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 8f7a3c00b6cf..26e99c03390f 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1272,6 +1272,7 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void=
 *dev)
=20
 	/* Sync our overflow flag, as we believe we're up to speed */
 	q->cons =3D Q_OVF(q, q->prod) | Q_WRP(q, q->cons) | Q_IDX(q, q->cons);
+	writel(q->cons, q->cons_reg);
 	return IRQ_HANDLED;
 }
=20
--=20
2.17.1
