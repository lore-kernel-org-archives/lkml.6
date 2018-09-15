Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E195EECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9041E208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="n9Y7m+nc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9041E208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbeIOGtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:49:40 -0400
Received: from mail-co1nam03on0116.outbound.protection.outlook.com ([104.47.40.116]:27616
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729115AbeIOGti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPKlESEbbukYz3qXnqYFQ3IXnBVDSQaVKEOnIHLX1T8=;
 b=n9Y7m+nc3ScTmxGa/UU/0Hrzm0tQbndz33VBPlTUOrU9dbAzQPDoPEp0v7qA35MAWE+9phLYioV77UwFT7hXQb63FQabmpc0Q09pzgEsIUxivcCDFfQQAlCNUwkeoDN0PHFKlRRZEoOlLUhyb3Avsmu7sLoIhOBA97YM4MprY3k=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:32:36 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:32:36 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Paul Burton <paul.burton@mips.com>,
        Huacai Chen <chenhc@lemote.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 13/57] MIPS: loongson64: cs5536: Fix
 PCI_OHCI_INT_REG reads
Thread-Topic: [PATCH AUTOSEL 4.14 13/57] MIPS: loongson64: cs5536: Fix
 PCI_OHCI_INT_REG reads
Thread-Index: AQHUTJP7e6w02UgWM0CXAG+g8R5yNw==
Date:   Sat, 15 Sep 2018 01:32:36 +0000
Message-ID: <20180915013223.179909-13-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:jdpdAqaiPjsgA9ilFUMiUrJSmxlrrIRxIxOmZJNgSkzGffZ+YJ8w4z+kZQ5kNxY3zn0+plBiSdAv2NPe9FXMgipMTq6a1+Ctcothoj5ltJUETM3wegAVIDwZOIG1bW/Xu78vmHxNnUi3JmTcOovDI5DIbn6qYm+yPhjFScDGvwcJZV30l9T/5xfE/ckXgkTyUYCPZIZEjDEo989BR0AMMOofc00H0U86XBcAEklEkqmQijFuAma0Lhk+1vVdG1vqFbj38+mJ3P+P+MXAzTXx1eZzWhq75IC5N3R8sOj1fE7FSnHTaJNJHr2GTeGzeKSR4Bh6lWpYwNs40Lsz8GrbL0RMtyDIe69zj24HKkAqdV4wHaCknPP2p6Pp4bzpdBlfHerzVq4S/d5KsmwzbtDFnrCqVBEgHu26Kma4VTBrGRHzUhAICOryXvjGIhWOuk6p5FxJFT4iYKEvkRsjDsmWuw==;5:/a4YDZRpdziGs+z3iOYPveZ4Ycf5jsTpE/AUnBLGikttVDAKDw8iFcGo8kVT4ajgNhbMESNd2qxHdmAj455vLyxbygOvKcx3Tj+PZvTzUd1yy4LvZwwXZrZRPttU3Mfaizl84JM9Y9nZKiTs60f6imtHm+3WXtrohBog77uibf8=;7:45os4Y6FmI1DC/3s6byfZqsjSoDLWElhKJUCA1kQYgoKnsbU3DBqael9ppf3jscix6qJqCuAQqw1ZVKR30/fRg1PQz0q/WfXUTJ1C8PasKEmCzijyABTU5ifNgyypsT7+b1noS5fr3jvDcRz7WYLjfHlf1MEINfL+D6pcKAmJLzTrst2rASG5M9rBv6xkIGHEjX8wrNWPZhDNl/AuX++xjBtyhqCuXoI4HQGfARPnhaH6vcw1k0QpupTnP0Tey+z
x-ms-office365-filtering-correlation-id: 893f9256-0ed8-42b4-cd44-08d61aab1e4f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0822C9F760D5B1DD0B90F986FB180@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(1076002)(966005)(72206003)(6506007)(102836004)(478600001)(8936002)(10290500003)(2906002)(81166006)(81156014)(5660300001)(22452003)(2900100001)(8676002)(110136005)(54906003)(107886003)(99286004)(25786009)(4326008)(316002)(10090500001)(97736004)(305945005)(7736002)(6116002)(3846002)(256004)(14444005)(66066001)(76176011)(217873002)(6436002)(14454004)(36756003)(476003)(86612001)(6512007)(26005)(6306002)(5250100002)(53936002)(486006)(106356001)(11346002)(2616005)(6486002)(575784001)(86362001)(446003)(186003)(105586002)(2501003)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wa7S5OyB/6lP/5FNixjufjFIA4HYNo6Nx6WkkYxi/YjdNj+Tkvw2lSVmFxEArDtR9h+kRt5q0rL9EMwtUg8MB+u22H47WdSiGziebLRVPZnspZPjC+++CJmoWzGP9Wr0SorTwpZq5zNkCF1rSOcrf7SZy6LBiIIV1TtOoV8XMlmabaPvUPdeBn50t9v167l0frgGaX3PqYD9vI6xzhzTeYbK9HEoyOkt/o11iL4sJ64HxPsW8kfyuVCqNU5mP/KU+TIJe7SGkV1lPLcmHwZP3UUtgjdhUQ+cHmiyDpBHVv7ld/KjuZMFPb8vIqjo1paflQ1cXdE7XRxZxKZhYvNIekkLbCRI2L3o6fbVsquIWv0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 893f9256-0ed8-42b4-cd44-08d61aab1e4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:36.8373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Burton <paul.burton@mips.com>

[ Upstream commit cd87668d601f622e0ebcfea4f78d116d5f572f4d ]

The PCI_OHCI_INT_REG case in pci_ohci_read_reg() contains the following
if statement:

  if ((lo & 0x00000f00) =3D=3D CS5536_USB_INTR)

CS5536_USB_INTR expands to the constant 11, which gives us the following
condition which can never evaluate true:

  if ((lo & 0xf00) =3D=3D 11)

At least when using GCC 8.1.0 this falls foul of the tautoligcal-compare
warning, and since the code is built with the -Werror flag the build
fails.

Fix this by shifting lo right by 8 bits in order to match the
corresponding PCI_OHCI_INT_REG case in pci_ohci_write_reg().

Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/19861/
Cc: Huacai Chen <chenhc@lemote.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/loongson64/common/cs5536/cs5536_ohci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/loongson64/common/cs5536/cs5536_ohci.c b/arch/mips/l=
oongson64/common/cs5536/cs5536_ohci.c
index f7c905e50dc4..92dc6bafc127 100644
--- a/arch/mips/loongson64/common/cs5536/cs5536_ohci.c
+++ b/arch/mips/loongson64/common/cs5536/cs5536_ohci.c
@@ -138,7 +138,7 @@ u32 pci_ohci_read_reg(int reg)
 		break;
 	case PCI_OHCI_INT_REG:
 		_rdmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), &hi, &lo);
-		if ((lo & 0x00000f00) =3D=3D CS5536_USB_INTR)
+		if (((lo >> PIC_YSEL_LOW_USB_SHIFT) & 0xf) =3D=3D CS5536_USB_INTR)
 			conf_data =3D 1;
 		break;
 	default:
--=20
2.17.1
