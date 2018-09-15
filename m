Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A6CECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D35208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YlmaxTYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6D35208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbeIOGxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:53:38 -0400
Received: from mail-sn1nam01on0126.outbound.protection.outlook.com ([104.47.32.126]:8380
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728990AbeIOGwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rL34QdyXweb6H1OD992oFwT65VdvgQ6U738O6f2tPjM=;
 b=YlmaxTYke0a1jflls9A4PSMXoqK/Pug1wU3HTm6QI/QupgZJEinjyaZDgIvsab8SxkwIkk5QC7xzjjY6Ngrb9teNaWAYY6mszLZh0f0hH0g4BL92KOSaaH4mwsm8u99irmMGWA9HQi3P4RwhOg5uOWagS+roYBWxYWfTmrJIutY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0280.namprd21.prod.outlook.com (10.173.193.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Sat, 15 Sep 2018 01:35:27 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:35:26 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Paul Burton <paul.burton@mips.com>,
        Huacai Chen <chenhc@lemote.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 04/11] MIPS: loongson64: cs5536: Fix
 PCI_OHCI_INT_REG reads
Thread-Topic: [PATCH AUTOSEL 3.18 04/11] MIPS: loongson64: cs5536: Fix
 PCI_OHCI_INT_REG reads
Thread-Index: AQHUTJRhvqRzDhjlN029EPsyzudlTA==
Date:   Sat, 15 Sep 2018 01:35:26 +0000
Message-ID: <20180915013521.180178-4-alexander.levin@microsoft.com>
References: <20180915013521.180178-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013521.180178-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0280;6:2Q8pd6OYIJcnV+5F3vPEQoSsDehZTDcb0G3wbDA1zhTWE9lsauNyN/pjElBAgdbnqGa0NHYaw/pTXWk0jxuKvTKN5T94alwPUVoRq6Cv7MQPgZq12pWW+kTuI38i46kYNJgq9SZE8fxYGcuQ1XfWAOHynjl3nFdaodhG3EdkVDVrGgQ5fdnR4RO5yO/PlMzjiFMMqtiLbTFH7qm9miZbJqLHOEzLPTr3QXcD+G7IbMdTvRJl95iwwAj0XoZwl/f9YW34iFhj6OizTREh7T0fP/ZfWR3AtvXIc2FWGoEh8Qncy/vRDcbH58WqV8zPWYAout5+1F0ZHXbZwwAEw7Qw5r5MSwtc2K3sqBorPUrGkn+Ux8qltvzRRS2kC9WIybU8OyAidIiQWmY4mMG/6baO8CuQenduyaw51GFQj2rA3QQF2ko//cEyIHyyfSxOR8r7WlxIzt9Zs5ttMTRGejUKBA==;5:pAW2EIW2k3ymR3TIG6/GYxt+J2bFEB8yAcQ5c4wSEZbGubmpxfPIE8ZjMNSS4O3lThY4Ujjsxg8DywAaWoYdrsFRPo7vNB+4eCFDJqp+khJANrUUXJYBc9+SDJratAOzpc7dtCL/JPOPfNXkHeVP9SVCvKjtBzySN7Rq+KIM+kw=;7:qK5GXnDUoPMyL0MbQRjSplfBK735IiMMtz4NhCluB92i7cHZvcRiS/APGIafPBJJqCaosM3Tsl745Meszw7Vwq6zVLEdpGZos187ddcSNlj5mFj1KmP4GdWs/resovvsUJ06LlNvV9+QiGAAFo64ff1fET2OtHtoQdZ7SB0VqTrpS4V2+Ts9Bp0K/MLSzK8ydBnZfbHu2DmtbPsKbzC6bwYC2IwwAc6kFWjf6NfG64IH3Ui5HdHY76K1dGydGkxH
x-ms-office365-filtering-correlation-id: dcf57f31-47e7-41a4-46c0-08d61aab83a5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0280;
x-ms-traffictypediagnostic: CY4PR21MB0280:
x-microsoft-antispam-prvs: <CY4PR21MB0280B0F22758AD06E2A55AF4FB180@CY4PR21MB0280.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0280;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0280;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(366004)(39860400002)(396003)(199004)(189003)(966005)(25786009)(14454004)(10290500003)(2906002)(4326008)(6436002)(107886003)(72206003)(14444005)(256004)(217873002)(478600001)(5660300001)(6512007)(5250100002)(2501003)(6306002)(97736004)(53936002)(6116002)(3846002)(8676002)(7736002)(305945005)(1076002)(6486002)(36756003)(105586002)(10090500001)(106356001)(22452003)(11346002)(2616005)(476003)(2900100001)(486006)(446003)(66066001)(76176011)(99286004)(316002)(54906003)(110136005)(6346003)(68736007)(26005)(186003)(86612001)(6506007)(102836004)(575784001)(86362001)(8936002)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0280;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: f2k3XD6P3Q1rLLOeCk2r3JKgNRP5nkhlZcLR64DA02orBvS3ACznFlQsBRkTPQQtsv5CXVWmP8xa2SIfdVnbVx2UPmgAPp5mqvOTGhgeEbyun4ZMPqpxQNHb4mu6gwCgOZS2AxbmOTbtQVD6R/gaIfFisyitW8XxrzDct+sqlqfYR46cqbuj66w1xnxzD8aTDNcMtlep/fQBlvAGWStfP5vuisFN2tA5t9ZfjF/T0kdOnSdZUjMEy4FRRcYi/jNzrmH2LRaYApt/IMSMl/zGVMsGSWydrY887OjKNjjVKqTkRJNh8XIgOlKeVS53+l5Ko1Zbbp6NynG4t5HDk+V0GzvfUq+2Prb9LaEAoBtqYCc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf57f31-47e7-41a4-46c0-08d61aab83a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:35:26.8943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0280
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
 arch/mips/loongson/common/cs5536/cs5536_ohci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/loongson/common/cs5536/cs5536_ohci.c b/arch/mips/loo=
ngson/common/cs5536/cs5536_ohci.c
index f7c905e50dc4..92dc6bafc127 100644
--- a/arch/mips/loongson/common/cs5536/cs5536_ohci.c
+++ b/arch/mips/loongson/common/cs5536/cs5536_ohci.c
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
