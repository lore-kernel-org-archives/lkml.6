Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C863C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D9020841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LljbHKSg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0D9020841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbeIBRUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:20:10 -0400
Received: from mail-dm3nam03on0090.outbound.protection.outlook.com ([104.47.41.90]:39552
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728020AbeIBRUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sk9CIC8zbcoOCYKyduy1hybqMQY82zT8Aii1Se3QIvU=;
 b=LljbHKSg/dSoWMtBlre+E2jnvw89QQ16DuyPGZRbd/jNtOlvpHit0Y/0M6kJUEetEcloU3JIA7aXUIDiWP+PvLNeaYRrzSXyRXL5d46P3Je104uYZSYebf/oMLQPegQmdon0reZ+rWu/pSS+YIiLdv9TO56J7vvecX9e6NfblsU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0135.namprd21.prod.outlook.com (10.173.189.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:14 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:14 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sam Bobroff <sbobroff@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 050/131] powerpc/pseries: fix EEH recovery of
 some IOV devices
Thread-Topic: [PATCH AUTOSEL 4.18 050/131] powerpc/pseries: fix EEH recovery
 of some IOV devices
Thread-Index: AQHUQr1svtGsF+WsOE2oRdLXwT4iHQ==
Date:   Sun, 2 Sep 2018 13:04:04 +0000
Message-ID: <20180902064601.183036-50-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0135;6:RYCZFZy7intP0Cifi9WbGa75q0bSQwmDXtcrQwU6nixeOVO2+3QZ6yY9TLwY2sTvvzdKMd0zJ+HDBMyNB3VmU1NNXDBgxTFRnFnbrvliWpwW0qor8qogpBOKJmX+lmKUksqzX7yW3VsI6/ol+lRAE+fJjr9wHKTh2pKpCGfcOt/vggKkarkVlGGWtUsMCEW/Agg8lx9E5hQLRx7Bo0yzWlR8o+EAxkQ3JTxj3Zg12sgzSVPAuwLSny74N2PkYGdxyT14dKP1ooGTOnjOsooqAiYEERA/XoR2dB+UoTcFNLyQXmA8jNwvNOIjigC+wDRuo+qf79JQjbAWlaJVTZ6nMZELA87gKDh1l2/rTst7ei8uRo244nZP4N1sUj2bmM9uERWDVNOpnzuokc+BC7FXAmtuke9YQTcxD1ai5GcaQAiUAAtiYwOrl1WeZZGQ/RGVPd2KtfOS3aYUfh25ZiX5hw==;5:W+gD1EDa10ho7anwnXfQ9ef81wjOrxKkZxyZvMO3l5pR3G1lMq+CA19At78N9Q3Fdw9Mc72LCAyjlkNhDxzKkBzNMyI3hlyygZG/RdKhf3wXu/F+Gp/ViKBYUKoYdBQjtZmw8wASt+BN7unbr0gPBl2kclOgDiuWnPoHOnnNgGY=;7:ssDIqrvU/eqDXdb1+YllAQwZ+E7V1wYACE2egwLctHpC1bvot8oHy7kt3TvucpeX7D4HTZxoF1cIdsFVvMMsMjsMwWH3vIfBIzrDhNw1vijnS9L/WXYq9NyKVXgJHAzT2n5V6ol23oN1KWFK9vieEjq3M5MaA0CxTmO6F02Xi5Se0I8pt2/YxBW17LtnQydpWrnS9C+GBnnV+ivXna6kL6zvVVmu1oquEg6f2LIU9WdDHocQS+e6GcA5v9Zx9otu
x-ms-office365-filtering-correlation-id: ff0e9ced-f2dd-4e03-5795-08d610d49568
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0135;
x-ms-traffictypediagnostic: CY4PR21MB0135:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01358FC3680BD798274AD8E4FB0D0@CY4PR21MB0135.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0135;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0135;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(376002)(346002)(189003)(199004)(478600001)(76176011)(53936002)(2616005)(6512007)(476003)(446003)(11346002)(36756003)(486006)(106356001)(305945005)(6486002)(6436002)(97736004)(102836004)(6506007)(5250100002)(2906002)(14444005)(256004)(72206003)(2501003)(10290500003)(14454004)(86612001)(186003)(26005)(217873002)(99286004)(86362001)(2900100001)(22452003)(81156014)(81166006)(10090500001)(316002)(107886003)(8676002)(105586002)(6116002)(8936002)(25786009)(4326008)(7736002)(5660300001)(6666003)(110136005)(54906003)(1076002)(68736007)(66066001)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0135;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MmsJjVhQnQ+WpM6oaNfq3QNISIuwbFqAHajLF5o4zzcA0UuN5qp4ny12P0KldyUKuqPEJEYLvHjJcdkGPx7yqb1Kapdy+pFRE6pWU1dwQ6y6UQcnfhjw88tcy8Q1S8rOegxJUFMBLUFm2Ni2Z2s9zAtBi5LVUdYCPEtnSzrW1uiDfstlCgrhYDPdLLnmqjGoamnnuC55BHYPx1EN5PnPH5sseA4rV5W1/vnQs5JWry+Zyonj/mf2VnWkcrenWcnaSs5gG17bK5Vp3oIKSbus5dePj/2CZY/qR3rLIV9hzTNP7Ne133TSnrs7vbWuPUkVVJayQdfHS+JZFv4hX9usXcw8Wt3v7TU90KM2EhAJOac=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0e9ced-f2dd-4e03-5795-08d610d49568
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:04.0371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Bobroff <sbobroff@linux.ibm.com>

[ Upstream commit b87b9cf4935325c98522823caeddd333022a1c62 ]

EEH recovery currently fails on pSeries for some IOV capable PCI
devices, if CONFIG_PCI_IOV is on and the hypervisor doesn't provide
certain device tree properties for the device. (Found on an IOV
capable device using the ipr driver.)

Recovery fails in pci_enable_resources() at the check on r->parent,
because r->flags is set and r->parent is not.  This state is due to
sriov_init() setting the start, end and flags members of the IOV BARs
but the parent not being set later in
pseries_pci_fixup_iov_resources(), because the
"ibm,open-sriov-vf-bar-info" property is missing.

Correct this by zeroing the resource flags for IOV BARs when they
can't be configured (this is the same method used by sriov_init() and
__pci_read_base()).

VFs cleared this way can't be enabled later, because that requires
another device tree property, "ibm,number-of-configurable-vfs" as well
as support for the RTAS function "ibm_map_pes". These are all part of
hypervisor support for IOV and it seems unlikely that a hypervisor
would ever partially, but not fully, support it. (None are currently
provided by QEMU/KVM.)

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
Reviewed-by: Bryant G. Ly <bryantly@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/platforms/pseries/setup.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platform=
s/pseries/setup.c
index 8a4868a3964b..cb098e962ffe 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -647,6 +647,15 @@ void of_pci_parse_iov_addrs(struct pci_dev *dev, const=
 int *indexes)
 	}
 }
=20
+static void pseries_disable_sriov_resources(struct pci_dev *pdev)
+{
+	int i;
+
+	pci_warn(pdev, "No hypervisor support for SR-IOV on this device, IOV BARs=
 disabled.\n");
+	for (i =3D 0; i < PCI_SRIOV_NUM_BARS; i++)
+		pdev->resource[i + PCI_IOV_RESOURCES].flags =3D 0;
+}
+
 static void pseries_pci_fixup_resources(struct pci_dev *pdev)
 {
 	const int *indexes;
@@ -654,10 +663,10 @@ static void pseries_pci_fixup_resources(struct pci_de=
v *pdev)
=20
 	/*Firmware must support open sriov otherwise dont configure*/
 	indexes =3D of_get_property(dn, "ibm,open-sriov-vf-bar-info", NULL);
-	if (!indexes)
-		return;
-	/* Assign the addresses from device tree*/
-	of_pci_set_vf_bar_size(pdev, indexes);
+	if (indexes)
+		of_pci_set_vf_bar_size(pdev, indexes);
+	else
+		pseries_disable_sriov_resources(pdev);
 }
=20
 static void pseries_pci_fixup_iov_resources(struct pci_dev *pdev)
@@ -669,10 +678,10 @@ static void pseries_pci_fixup_iov_resources(struct pc=
i_dev *pdev)
 		return;
 	/*Firmware must support open sriov otherwise dont configure*/
 	indexes =3D of_get_property(dn, "ibm,open-sriov-vf-bar-info", NULL);
-	if (!indexes)
-		return;
-	/* Assign the addresses from device tree*/
-	of_pci_parse_iov_addrs(pdev, indexes);
+	if (indexes)
+		of_pci_parse_iov_addrs(pdev, indexes);
+	else
+		pseries_disable_sriov_resources(pdev);
 }
=20
 static resource_size_t pseries_pci_iov_resource_alignment(struct pci_dev *=
pdev,
--=20
2.17.1
