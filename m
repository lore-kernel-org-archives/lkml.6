Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB8CC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE0B921521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hcI6eaAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0B921521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388436AbeITIaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:30:39 -0400
Received: from mail-bl2nam02on0106.outbound.protection.outlook.com ([104.47.38.106]:44649
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388397AbeITIah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyRyeSGD5Lnu7+aZHTRNDfGoCCoU0MUwTlvn43+99Gc=;
 b=hcI6eaAj5qRQ6JAxvnITRv06W5exc7ze3gTv35vpbrTDPWVu1k8jhvgkFiXwqDFy5BDiorlPtX/deQnSe60EVyueB4u4A960M51QTukkrXh7pyJnsOQ884OKqe1QryQiSI5xYDA/4cKd4Vishl7SS63pit6cP52RQD2BHsFtGfg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0744.namprd21.prod.outlook.com (10.173.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:49:22 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:49:22 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Huazhong Tan <tanhuazhong@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 04/14] net: hns: fix length and page_offset
 overflow when CONFIG_ARM64_64K_PAGES
Thread-Topic: [PATCH AUTOSEL 4.9 04/14] net: hns: fix length and page_offset
 overflow when CONFIG_ARM64_64K_PAGES
Thread-Index: AQHUUIxyzY824N2ex0K6yG0e6cX0Jw==
Date:   Thu, 20 Sep 2018 02:48:44 +0000
Message-ID: <20180920024838.58666-4-alexander.levin@microsoft.com>
References: <20180920024838.58666-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024838.58666-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0744;6:KSAmA0snA1dX9lhp+xfTuXhrPebUXvB7vE8hMRi9cl79LOQV4lrdev2nkPe9Odm7uoX4BQq2FDZkNIrsLlDfjx23+AvWQYMC131nbNlGowrM87EcukBNLbVqi5YJ3YoGh6sogN5jJWGIsD6zzEYHl4+0nBXzsWp/n/VBm63dBaVT9CeTZAnrluP72Lop/FODENLii/lyqBLhqAze1kimHqmBZnlN8opL8DGeL2SmmKnOttJruaPw0qNKg7M1s83k79f9H7HQm7viFiVDgaRKHMHub3R567OiaDuxDu1aeo7yaOBMFiXnP4ySuSyrKGip8GQqAF4BUt6CU7da7CHc+v24U8wQJ3xxgl28qf59CnJmbDcDBI3qeFfC7tAFSpeR77MYkdndN3Xi/EUe02qV59+aca5IUdCfQ/0S0bAH8GZGYbwRLOld74tVQTpDyOoB1OaQEgFxIAtg4hxe38dd3w==;5:gYHhLgR7BcqTUosyrJC3Qg5UEwiAJkT8DZpswuIdV/6ic8U6miPwAq07g5TBb3bME7T8VcABiiWJQJBZvunE+pI2gEMiG7eBqqRHWv3x+yKKrNqJJspDkMeTreWQdIsidlSinV2rm3uxlgUkoiQCQ2+jGX6ipr3hGg4oq3x99nA=;7:Pi0unGjjn60bUyT6CRJeGT0L7idoXkjPgtVHo+WPEmn0f0dldWvRDTq5tbXThMdXs0d2Z5fzckSRuKJXPFKpaJPv7lk7cd09WOgLatHcVL80N+NN1eZJYtXWQ1IBAzAJjDNdJI+8CzN27Q20wXNHH0GfK/t7OMM5IYtVCzjXxBTWIvlCyhauIlxRa/6JFGEyxQenfPK/37oAutGobUp2sv0iqWywkZWqObNHBiKmMU5JRb8bZsvn0mBLdszwJFVB
x-ms-office365-filtering-correlation-id: 78f52423-b327-47ec-3136-08d61ea3ab62
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0744;
x-ms-traffictypediagnostic: CY4PR21MB0744:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0744CCF705659511D6A43CDAFB130@CY4PR21MB0744.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(50582790962513)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0744;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0744;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(8936002)(6436002)(10090500001)(110136005)(217873002)(54906003)(6512007)(53936002)(68736007)(5660300001)(256004)(6666003)(71190400001)(6486002)(316002)(446003)(11346002)(105586002)(476003)(106356001)(478600001)(2616005)(2906002)(186003)(25786009)(10290500003)(486006)(71200400001)(72206003)(66066001)(4326008)(14454004)(22452003)(36756003)(102836004)(86612001)(97736004)(15760500003)(8676002)(305945005)(7736002)(1076002)(86362001)(575784001)(81156014)(26005)(76176011)(6506007)(5250100002)(107886003)(2900100001)(99286004)(3846002)(2501003)(81166006)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0744;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3mhMB1UwdbOaT7/O1V0q9f1ziQzIzawTghwEFae4OKEclkrhWYGOOMlEUmdB8Dt3P5sCu46F9VS5zGhVWPDuhKQhkEIOdv/iLy4l6wAGTIA9s4xOV+NE0fSFsUXE50kuz5kmGcWVf4x318e4z3sOLGiuLGJdfvRB11i1AJokI6G2SRNRaBSr+FLiiB6EsRMw1liNnlPio2gca32+nUrZ5VD0KAzoaSU6biKRMj1R3LQRIAXWcbrisSO7VAtUvH0HPYdEZQXWkJIJqUwBrwBGLuzUaw6Y6INU6jtdK88aadUPB3OqE2TgRrnYCp+ZHHvvYCKzclH6sRBK8zeZorEvhZebV4FM/D9k8tekZ6GUKeU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f52423-b327-47ec-3136-08d61ea3ab62
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:44.7568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

[ Upstream commit 3ed614dce3ca9912d22be215ff0f11104b69fe62 ]

When enable the config item "CONFIG_ARM64_64K_PAGES", the size of PAGE_SIZE
is 65536(64K). But the  type of length and page_offset are u16, they will
overflow. So change them to u32.

Fixes: 6fe6611ff275 ("net: add Hisilicon Network Subsystem hnae framework s=
upport")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/hisilicon/hns/hnae.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hnae.h b/drivers/net/ethern=
et/hisilicon/hns/hnae.h
index e093cbf26c8c..f9d68453c81d 100644
--- a/drivers/net/ethernet/hisilicon/hns/hnae.h
+++ b/drivers/net/ethernet/hisilicon/hns/hnae.h
@@ -213,10 +213,10 @@ struct hnae_desc_cb {
=20
 	/* priv data for the desc, e.g. skb when use with ip stack*/
 	void *priv;
-	u16 page_offset;
-	u16 reuse_flag;
+	u32 page_offset;
+	u32 length;     /* length of the buffer */
=20
-	u16 length;     /* length of the buffer */
+	u16 reuse_flag;
=20
        /* desc type, used by the ring user to mark the type of the priv da=
ta */
 	u16 type;
--=20
2.17.1
