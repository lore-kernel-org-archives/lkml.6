Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF589C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ACFB2596B
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iCU4whqd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ACFB2596B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965275AbeGASWq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 14:22:46 -0400
Received: from mail-sg2apc01on0120.outbound.protection.outlook.com ([104.47.125.120]:47168
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964921AbeGASWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 14:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5QqAO8+Uv7V9FJA3rW4kmmiWL7uraysBqfEuphuOsY=;
 b=iCU4whqdlQ1JZHSH62SHU3C0TKCg9Rda8+MdN2+7/z4aPrqOwEVGK0rEum7bYsGNc+JThJe6qkJLPymDtYQA2+DHw+sU8dGwmNPI5+bYDhKKqu1QyJ+hVXi3DaQ37BY0UXXp/28QOM1i8HFqL0weY2yYXx2cJlN3LVJ4AWCs/wg=
Received: from KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM (10.170.167.17) by
 KL1P15301MB0038.APCP153.PROD.OUTLOOK.COM (10.170.167.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.4; Sun, 1 Jul 2018 18:22:24 +0000
Received: from KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM
 ([fe80::b9ce:51a5:609c:de90]) by KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM
 ([fe80::b9ce:51a5:609c:de90%5]) with mapi id 15.20.0952.003; Sun, 1 Jul 2018
 18:22:24 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>,
        'Bjorn Helgaas' <bhelgaas@google.com>,
        "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'apw@canonical.com'" <apw@canonical.com>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>
CC:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'driverdev-devel@linuxdriverproject.org'" 
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "'vkuznets@redhat.com'" <vkuznets@redhat.com>,
        "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>
Subject: [PATCH v2] PCI: hv: Disable/enable irq rather than bh in
 hv_compose_msi_msg()
Thread-Topic: [PATCH v2] PCI: hv: Disable/enable irq rather than bh in
 hv_compose_msi_msg()
Thread-Index: AdQRZ+8zPuSKPLT9RJW12qWmOo7nFw==
Date:   Sun, 1 Jul 2018 18:22:23 +0000
Message-ID: <KL1P15301MB0006BE5DB7C3C45386E4327FBF4C0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-07-01T18:22:20.3922402Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a27f:df20:f40d:b20e:4954:656f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KL1P15301MB0038;7:uYkGXOsMdfNSqBNuPS2TW7Ny0VGA2ZLtaL3b6RN+WCxnbilvclZOqXaU/gLFAbVO6VAkvaeJwaCNWRtTuDNSwgpUGVwOccSOsJ9LoAIvezWAw2bfqjPm5mCEskL02D+dJdbKeBU6L3UMIQl1wVBsLanSt6Wb84OgIfEsGEL9josus2rRLR6QfmUxDwV1u+LPptWVIm1uB4NCwxrhIKW1MtXLcDPoMu4vuOqZKiCCaBCkVSZVbcP8zEI8CDl3aaDj
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: eb7ec830-dada-49f7-44e3-08d5df7f97c7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:KL1P15301MB0038;
x-ms-traffictypediagnostic: KL1P15301MB0038:
x-microsoft-antispam-prvs: <KL1P15301MB0038A22424C6E17CC783487EBF4C0@KL1P15301MB0038.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:KL1P15301MB0038;BCL:0;PCL:0;RULEID:;SRVR:KL1P15301MB0038;
x-forefront-prvs: 07200C0526
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(136003)(39860400002)(346002)(199004)(54534003)(189003)(6116002)(54906003)(186003)(478600001)(74316002)(7696005)(81156014)(86612001)(86362001)(575784001)(305945005)(105586002)(53936002)(10090500001)(46003)(4326008)(8676002)(81166006)(6436002)(102836004)(99286004)(6506007)(7736002)(10290500003)(316002)(110136005)(256004)(14444005)(9686003)(8936002)(22452003)(14454004)(1511001)(486006)(55016002)(476003)(2900100001)(5250100002)(97736004)(25786009)(106356001)(2906002)(8990500004)(5660300001)(33656002)(7416002)(68736007)(491001);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0038;H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qk1BVQwsxAnZkcVq5rSxfj95EsVDrV3o5fKKCFVFmZqG/Hvp/9bWCVxZXiHTm6JXD5GbVcs6ipiXHv1+4OMLm2h5dUvr+m8bPAJ71pBEI2w9wfchJwhFyOxl2DW0BVcd+GFb+39X9RHl768oGxdO23RdDmNI4AtfDpS4C0diV6EjkvctGUEenHpHZMvIrIzPYGJkIuMBa+b0TBKyG17vjWOBhig446dXLap9GCbP6GZQ0H8w/ylxA4b/44n5sG2RRUBjzl26zvZVv4d+uwhE3L6KTwOi9NySJxcbbUG1HOtMrCAPC80hbBfbH975VdmdVqgBzleQVxQJ0Dlo+CHHDMjfBAnMI2Rw+ebBLMy1OQU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7ec830-dada-49f7-44e3-08d5df7f97c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2018 18:22:23.8990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Commit de0aa7b2f97d ("PCI: hv: Fix 2 hang issues in hv_compose_msi_msg()")
uses local_bh_disable()/enable(), because hv_pci_onchannelcallback() can
also run in tasklet context as the channel event callback, and here we
want to avoid the race.

With CONFIG_PROVE_LOCKING=3Dy in the recent mainline, or old kernels that
don't have commit f71b74bca637 ("irq/softirqs: Use lockdep to assert IRQs
are disabled/enabled"), when the upper layer irq code calls
hv_compose_msi_msg() with local irq DISABLED, we'll see a warning at the
beginning of __local_bh_enable_ip():

IRQs not enabled as expected
  WARNING: CPU: 0 PID: 408 at kernel/softirq.c:162 __local_bh_enable_ip

The warning exposes an issue in de0aa7b2f97d: local_bh_enable() can
potentially call do_softirq(), which is not supposed to run when local
irq is DISABLED. Let's fix this by using local_irq_save()/restore()
instead.

Note: hv_pci_onchannelcallback() is not a hot path because it's only
called when the PCI device is hot added and removed, which is infrequent.

Fixes: de0aa7b2f97d ("PCI: hv: Fix 2 hang issues in hv_compose_msi_msg()")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Cc: <stable@vger.kernel.org>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
---

A trimmed version of the warning is:

IRQs not enabled as expected
WARNING: CPU: 0 PID: 408 at kernel/softirq.c:162 __local_bh_enable_ip+0xb0/=
0xe0
Call Trace:
 hv_compose_msi_msg+0x209/0x462 [pci_hyperv]
 irq_chip_compose_msi_msg+0x41/0x50
 msi_domain_activate+0x1a/0x40
 __irq_domain_activate_irq+0x59/0x90
 irq_domain_activate_irq+0x25/0x40
 __setup_irq+0x3ec/0x730
request_threaded_irq+0xfa/0x1a0
mlx4_init_eq_table+0x3c3/0x5f0 [mlx4_core]
mlx4_setup_hca+0x1db/0x750 [mlx4_core]
mlx4_load_one+0xad2/0x13b0 [mlx4_core]
mlx4_init_one+0x578/0x710 [mlx4_core]
local_pci_probe+0x1e/0x50
work_for_cpu_fn+0x10/0x20
process_one_work+0x1d4/0x5a0
worker_thread+0x1cb/0x3d0
kthread+0xf5/0x130


Changes since v1:
	Updated the changelog only (fixed typos and some inaccuracy)


 drivers/pci/controller/pci-hyperv.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/p=
ci-hyperv.c
index ba1d4b5..eb20296 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1073,6 +1073,7 @@ static void hv_compose_msi_msg(struct irq_data *data,=
 struct msi_msg *msg)
 	struct pci_bus *pbus;
 	struct pci_dev *pdev;
 	struct cpumask *dest;
+	unsigned long flags;
 	struct compose_comp_ctxt comp;
 	struct tran_int_desc *int_desc;
 	struct {
@@ -1164,14 +1165,15 @@ static void hv_compose_msi_msg(struct irq_data *dat=
a, struct msi_msg *msg)
 		 * the channel callback directly when channel->target_cpu is
 		 * the current CPU. When the higher level interrupt code
 		 * calls us with interrupt enabled, let's add the
-		 * local_bh_disable()/enable() to avoid race.
+		 * local_irq_save()/restore() to avoid race:
+		 * hv_pci_onchannelcallback() can also run in tasklet.
 		 */
-		local_bh_disable();
+		local_irq_save(flags);
=20
 		if (hbus->hdev->channel->target_cpu =3D=3D smp_processor_id())
 			hv_pci_onchannelcallback(hbus);
=20
-		local_bh_enable();
+		local_irq_restore(flags);
=20
 		if (hpdev->state =3D=3D hv_pcichild_ejecting) {
 			dev_err_once(&hbus->hdev->device,
--=20
2.7.4

