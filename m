Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D40C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8872077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="COXPe2X0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E8872077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbeIBRjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:39:01 -0400
Received: from mail-eopbgr680103.outbound.protection.outlook.com ([40.107.68.103]:45024
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728081AbeIBRak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Bo0ZiQaoazggQZz/Xbz/7QMDx4zzkXghiAvQHGvBWQ=;
 b=COXPe2X0xBi8FNhC1e85Bxp+hqNcHRkPiXnlsr/wj9W02IIgypO+ELiEEg1H+HRCrWPEB5IwdgnBa/HpoamMNkaaA5aFnJqHFQzrseF68H9d1ic24yM6sOxWe4QAkbtWUB1IgcJbgsnnaFrX9ZzGXaI76Ik1gqry7W3iWEWD3jI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:14:50 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:14:50 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 37/62] MIPS: generic: fix missing of_node_put()
Thread-Topic: [PATCH AUTOSEL 4.9 37/62] MIPS: generic: fix missing
 of_node_put()
Thread-Index: AQHUQr7uuqqI9HOlN0WoOMAaeMWUMw==
Date:   Sun, 2 Sep 2018 13:14:50 +0000
Message-ID: <20180902131411.183978-27-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:yn01bNmmAorvctiUyYObueBBi/N6/7p4hrjT33FJrQHXi7k+lSNv2sl9F6cKsGVaZZvEhFaDsKgcU/E3IJY/4RO+EA51/XTOT+3wfWuZe36pHtizJ91VdpRyDncffBjaRdX9kDHEFGeSSEBQme37BJjYJXkd02UrTzXqZRdwVjXz2YsvQq4s3cyGpZyRldhvzF+h6zqqOqDMmf7k5kYFtwFodSNy3ZK+w/xxDMF2DrBdK7Wo+X77hO3rriGQvL0w/cyoI54cNPvzHruc3IEquaXEBiCF4ggKrbaop8DUmwUCym7DzxdOVRtZ/rH9JfVa84j+NWcWJtICR27Kl15UsezWX9F9I7Ar96Ae7kxioF8HN/i4ju50oTdi2vSH7uGpotOS2xYrjDPQh68CrgEl2MYbhY1TfsL70KPmy0SIxBtgWmD5H0UcpePPKh6vrHxv3dyLK9bzZ/GnBxEsbNvz5Q==;5:8fBiOyMziwKdYW9zfLBh8mEaTAOSWtr/orGnpXafLSMbv3mXDMSuxJHI7RalDTSGv9v1mK1dF0ItLbey0heVsi4pKL8uZgTbqtcHWCmZQ0MD5ZJ+yRvPZXCNiEjYdhvtH6zL7HBZRuZE2VZr5mlKlaZY+V4eLSQdB1vuT83OtCc=;7:KGQyfSteahUPOlrrP9udhjh5+5Eh2LY74IrmdmQItVvsVdjwA4em04ecaho29l2r+Wqp5p2WoGTcdmhzGAfMpgNW5904fGXLWpswm89+4OB9SJWiyDosQ1DgkAAcoNAEiVfh99WbiBFTTOw4wv/I9Cb9CCuAizRS/W/GkhL1iDStb+Q5WH4JXotnelMp1d3ESp81dSh2RbADZhr1REWVRwxcUfKRg7m990h6wsrCQUYrunuy7V7kAY4kWePQFDuu
x-ms-office365-filtering-correlation-id: 54d212a8-0655-4444-1c0c-08d610d610c0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07413BA8A0B9496671777EF6FB0D0@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(97736004)(2906002)(186003)(26005)(256004)(102836004)(11346002)(25786009)(476003)(486006)(2616005)(446003)(305945005)(66066001)(5250100002)(2501003)(7736002)(6506007)(8676002)(68736007)(76176011)(99286004)(6486002)(105586002)(81156014)(81166006)(53936002)(5660300001)(22452003)(478600001)(6436002)(86362001)(14454004)(54906003)(36756003)(106356001)(110136005)(6512007)(4326008)(6306002)(107886003)(217873002)(3846002)(2900100001)(316002)(8936002)(1076002)(10090500001)(6116002)(72206003)(86612001)(966005)(10290500003)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kiMqeJm2B/2glAOT5cW4r1TPK+Hjc+hGAAdvJFDJ3N/X6/fixCrEBBs2p6GjABjJzZ8l8RzXdNLW4AZgFBk8gtlpMC9FJtZR6/KsLdxb6weSvwbNXvpmiGKdEDgCDLbS8OvdUEJzuyJ9sgHLJOynvKLhBpicWeK2b5TCL1FtgMC3zY7gAwlTbE5WsFlcHZX5gDGEMgGtzTPzKyMEPuBYtdWuPOhp5/jNtaMFigBwW9MBbtoRGoEMbJmDJSWNDjfEym+3eu2sVhax1OugUavGtDyi8UpzVkuWFPvqjZwcxAttMMgwS79sTreeNWDBs4S2ERpYOzKyC4ISowzz8YD2mpUf3oKJ2UwbCP1ZaCCUkIA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d212a8-0655-4444-1c0c-08d610d610c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:14:50.7363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit 28ec2238f37e72a3a40a7eb46893e7651bcc40a6 ]

of_find_compatible_node() returns a device_node pointer with refcount
incremented and must be decremented explicitly.
 As this code is using the result only to check presence of the interrupt
controller (!NULL) but not actually using the result otherwise the
refcount can be decremented here immediately again.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/19820/
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/generic/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/generic/init.c b/arch/mips/generic/init.c
index d493ccbf274a..cf5b56492d8e 100644
--- a/arch/mips/generic/init.c
+++ b/arch/mips/generic/init.c
@@ -159,6 +159,7 @@ void __init arch_init_irq(void)
 					    "mti,cpu-interrupt-controller");
 	if (!cpu_has_veic && !intc_node)
 		mips_cpu_irq_init();
+	of_node_put(intc_node);
=20
 	irqchip_init();
 }
--=20
2.17.1
