Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBAAECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFFE221476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NeGvS9sH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFFE221476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbeIOGzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:55:02 -0400
Received: from mail-eopbgr730091.outbound.protection.outlook.com ([40.107.73.91]:18669
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729852AbeIOGwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4vC5/pTSEEJm/dHn+sIOfMu10/pnO3PLab+1BsY1V0=;
 b=NeGvS9sHvzQdCbU59bD9WJnl8qxEn0LPqAwtKyFexRVAlbUSap9usnHzHBK6FREGpazfWeIN+/gYikt5yQvZnVWVTmqt+Zv++gEl9ZSRzLiRKt0WXymxtRMAv+IqlfRA9gF3MygR+AUb26vyFx7CQDwJhvutoe15CNSXEZFxzSo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:35:19 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:35:19 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 07/20] ARM: hisi: fix error handling and missing
 of_node_put
Thread-Topic: [PATCH AUTOSEL 4.4 07/20] ARM: hisi: fix error handling and
 missing of_node_put
Thread-Index: AQHUTJRW1aVDSK3l80OYSaP/AyHTHA==
Date:   Sat, 15 Sep 2018 01:35:09 +0000
Message-ID: <20180915013502.180110-7-alexander.levin@microsoft.com>
References: <20180915013502.180110-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013502.180110-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:g3hKYr4s8UuRhWtesQ/F+wVMw0G+UapMAckjtpW8894VTIOst94iCZ5svQhE5w++iKmjBDhQotu1vleZ/hQc8o6qg1mIH8UfViPA+m/QHoSg7fCzUDtR3VqIvybFYABU/KZQcsOiuyKEMqYDbYqPaApQ6nH0/hOAnCv848eT38uinaRio1Dyc0anStAO2u4tEANJNv9bnICTJ5C4aCJ8UArnGRlUB8oe8YqIJOZr7YpDlPdNajd1QrObEOqaAepHofAiCA0UNs1jYmj/Pr+nAtsCg5abX6F0/NiajekFekXm2cUqxf73Xxd8R5rd545HT/OEwffUK7hgz+YcXRP7Vy3FSvGB9UNMoMgL/boOW1wgM4UCjuLly22v2p17mKIIHrr0Zd81rhqvfWWGOJtWFxAJibk96Bx5p7ELUqCqXXzUEXzADTUaICmKqaL2bONdao/oQWpgmjiy9vYvbQi9gw==;5:D69rxuWRg2gB8nug1SYeWQc0/cVt3b6KYfr6xnsD2JFkc/SBgNdH5OQos22Ybngm79X4gHt5aLd3TjjOe8zR8kEf297yt6AVf550SB5WSy4DG947mXHIZ9h2CRuIfeZgpCuPPRzJka3bY2RwaUPBgSGhOQiVLKzlEgR3C6xWWso=;7:0OiMFLjRVUHRXR9m3IiI5WZ3p8gmgk8pM8bufYF6ODiEC5M6JPc2UsS4jQr2JWG4haH+yABgiEAicP0CWTi0X+dsZEM+czd0fipPpnnPCM0DdyNn84ZpG9xCJl+OYPSu+Jbg4vsIB/u7lINaSDt6lGAaShAjkgZiGNZ4wrCX8Vqny/OWlNA1qurd6nuLiQshKqqh78e9p5LyfzOGS18lzDNm5QquRqp4ileQZIMCtxT0PdWDDms9fHmqB2iQz0G7
x-ms-office365-filtering-correlation-id: 4f4da737-dc3e-43e8-f852-08d61aab7f3f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
x-microsoft-antispam-prvs: <CY4PR21MB0181D02A72483226CF6A5B69FB180@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(136003)(376002)(396003)(189003)(199004)(66066001)(68736007)(6346003)(186003)(3846002)(26005)(1076002)(6116002)(25786009)(97736004)(110136005)(54906003)(6666003)(2906002)(72206003)(316002)(10290500003)(217873002)(476003)(102836004)(478600001)(22452003)(2900100001)(36756003)(256004)(10090500001)(4326008)(2616005)(76176011)(14454004)(81166006)(11346002)(2501003)(81156014)(305945005)(5250100002)(6506007)(446003)(106356001)(105586002)(5660300001)(486006)(99286004)(7736002)(8936002)(6486002)(86612001)(6436002)(6512007)(53936002)(107886003)(8676002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: F0DmsQE/VNQWCqTef/xMjTYakd7ibwwzPgPy9WCZxNFHLyQPDt47vR1bnW//WA5J9Fk0HVmC+Unc4al5unZV9cFg2Php1Z0MUw8AgRvErAuJtm2crbCWNnwQra0Imm+kPvL+I1X9wMJathjm2tlok1u3+kE3f/QL9hmSuWc9sTiH84aaEA8mi+uy8PDgTN/aGMDdpHPWyzmOmxVcsAGZH7Hk55LhFAdx/6Z1O6221oQ+UKAtdjOD9wcezr/caBuL756c4N63i/TbF5sDcMkyYhzy4lR1lb2l+1FByon7m5FaTJ9Ftwv65KCifHbp5KP6tysTZik/q4TOJdbEQpYKSNW1T08+TXCRk/S0DWurys8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4da737-dc3e-43e8-f852-08d61aab7f3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:35:09.7228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit 9f30b5ae0585ca5234fe979294b8f897299dec99 ]

of_iomap() can return NULL which seems critical here and thus should be
explicitly flagged so that the cause of system halting can be understood.
As of_find_compatible_node() is returning a device node with refcount
incremented it must be explicitly decremented here.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit 7fda91e73155 ("ARM: hisi: enable smp for HiP01")
Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/mach-hisi/hotplug.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-hisi/hotplug.c b/arch/arm/mach-hisi/hotplug.c
index 3f28c9141b48..32870560b280 100644
--- a/arch/arm/mach-hisi/hotplug.c
+++ b/arch/arm/mach-hisi/hotplug.c
@@ -226,10 +226,10 @@ void hip01_set_cpu(int cpu, bool enable)
=20
 	if (!ctrl_base) {
 		np =3D of_find_compatible_node(NULL, NULL, "hisilicon,hip01-sysctrl");
-		if (np)
-			ctrl_base =3D of_iomap(np, 0);
-		else
-			BUG();
+		BUG_ON(!np);
+		ctrl_base =3D of_iomap(np, 0);
+		of_node_put(np);
+		BUG_ON(!ctrl_base);
 	}
=20
 	if (enable) {
--=20
2.17.1
