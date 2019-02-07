Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF6EC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6352B21721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GIyWhPJA";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="csVZtuZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfBGW4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:56:00 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:4629 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfBGW4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 17:56:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549580159; x=1581116159;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=bAgIes9qzu/+Hic2bD4VpuITtCedzFPrpoMftcCUGlE=;
  b=GIyWhPJAUMjmVZgaoRFAEINTSm9Blo+sAL65mdy76/BtEf2I+V41t99A
   UZMtADAGoGL27l4bGFhw5P1zPblp3QXRPC/Qp5mAlbweFKTOC8oQnlHOG
   EgaTfUiwFKczmPh9qDV3YD8X1p9IOLuio3KhAXRcnrA97pDe4ReyULxIE
   J5Mi4hbKtkChvlZ8ZuGvB8Hx3BgUicFwdo8QNo0Yb1VrduwemUBrjnzF1
   q24BXlPzeOZEB7+p4L8mDV/pIuV9Or9dZGIr/XH5W/sdTVrTT3b7LKnRK
   vJWRJdVyvU9h6OjOBdwEMf5SoRqhN0kesfvBciks2JVfTPFr7wLtXopGr
   g==;
X-IronPort-AV: E=Sophos;i="5.56,564,1539619200"; 
   d="scan'208";a="102039759"
Received: from mail-by2nam03lp2051.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.51])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2019 06:55:59 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDmbPF/UGOkqKSQkLbPjz1bpI2WuEDsLAQjFl4GOf2Q=;
 b=csVZtuZmfiIYFNmKhZSWXmQ8IakblB+wJ4kAmF4xsgIMulWPXpmbJ0FXXy0jAWT4VjFi0qsTW0FIHVWJCtLGnkJlqpHcGN6V9W3psrgELn1BPTciw06R7ksAIs07GxKEJrKUuL3/b8dhqT6OZO2VQEblHkaWOmwTtIrA+Hj5mM0=
Received: from MWHPR04MB0401.namprd04.prod.outlook.com (10.173.48.18) by
 MWHPR04MB0480.namprd04.prod.outlook.com (10.173.48.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Thu, 7 Feb 2019 22:55:58 +0000
Received: from MWHPR04MB0401.namprd04.prod.outlook.com
 ([fe80::f55c:272b:6401:1b8c]) by MWHPR04MB0401.namprd04.prod.outlook.com
 ([fe80::f55c:272b:6401:1b8c%10]) with mapi id 15.20.1580.019; Thu, 7 Feb 2019
 22:55:58 +0000
From:   Alistair Francis <Alistair.Francis@wdc.com>
To:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
CC:     "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alistair23@gmail.com" <alistair23@gmail.com>,
        Alistair Francis <Alistair.Francis@wdc.com>
Subject: [PATCH] riscv: Partially revert "Remove stat64 family from default
 syscall set"
Thread-Topic: [PATCH] riscv: Partially revert "Remove stat64 family from
 default syscall set"
Thread-Index: AQHUvzhJp5Lyoz3DO0iX2Eth67GLnQ==
Date:   Thu, 7 Feb 2019 22:55:57 +0000
Message-ID: <20190207225531.19219-1-alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-clientproxiedby: BYAPR08CA0017.namprd08.prod.outlook.com
 (2603:10b6:a03:100::30) To MWHPR04MB0401.namprd04.prod.outlook.com
 (2603:10b6:300:70::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0480;6:Q1HSTVGbvySoqbrxQrSJ5f6F1/yGZ9UwjHkK9ID4KHTM/5E3/m4p83KquZ5aCXiPTL2FxtCx/IMLg1lj+DTgxmfYKWdcgE91sfah1bmiuJQdQs2aXiqqGJrwT+dxjJYQMB+yjquvBghQVCexEHFrYhhCvvkrv10qq7ukh1ypuNPdwb1ppOwyTeQWKkp+QXoDg91OdUOwMfdXFjvQUFC03FcSzF54hgpGTs2cHITCxe+XFcnraAzq9odpXFCmBRKb0ioxTKoShQYQI/naFXGRjQLeEfuo6aoL/QLL/nm4HkZLuSNB9TygO4L3lqjj1C7vof5vwCvQbR0v/f7xSVbG/mRlAnxBgPV59KBpvAlNPCWKE+YgIe0rk8bVzq1K9ZftBZtr+X4N1I4VFfW5aMVw6ZBLztf1OSeD55fh92/qdUyH6J3yphOcVXZlndKZrRx1BbD/3nPEGB3F8ENRRzkvIg==;5:JTEUj90M44dfMIudOrDzyfFGTVvO72EW7HozWHFgZ/CUSe4d+m5uk916NeHfIb48eFvFGueO3qz+MFR+lJHYVrNN0DhSlRp5c/yov1W+wPIrELZEuz0Yjf2grrhbscYR0srAbFw5jU2p4jbL0Id1XTYdDShgnGQoCawjSEMKaIQh2S/R9uebwip8U3U86BTvbKyR4nmjd1hQ2Xg+zonGzg==;7:rqT747W1Bdgxfh8NAntFZj8q+aR+RMDOQyD7LXKnFv5BoDkto5kJmgfBCAIcoCmY3aOD7QCZ+E+ufmpkmuUYspzpAnjqzUH/pBTWFQMyLf/ypgHMdnk97FE5al0gre59MqaM2yJ2UEOhD1SrjTO4wg==
x-ms-office365-filtering-correlation-id: 0d518c8e-6c99-4663-3d1d-08d68d4f6c08
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0480;
x-ms-traffictypediagnostic: MWHPR04MB0480:
x-ms-exchange-purlcount: 1
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0480F0A0391C9B46280DDA3A90680@MWHPR04MB0480.namprd04.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(396003)(39860400002)(366004)(199004)(189003)(8676002)(97736004)(106356001)(2351001)(26005)(256004)(102836004)(186003)(105586002)(53936002)(386003)(7736002)(2906002)(6506007)(2501003)(81166006)(81156014)(6306002)(305945005)(50226002)(36756003)(66066001)(99286004)(6512007)(8936002)(52116002)(54906003)(966005)(6486002)(6436002)(316002)(5640700003)(6116002)(3846002)(6916009)(25786009)(72206003)(4326008)(2616005)(68736007)(71190400001)(476003)(71200400001)(478600001)(86362001)(44832011)(1076003)(486006)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0480;H:MWHPR04MB0401.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dgTtLyzvGDdDKYGzaVKi2s/MXJrM0oAJxJKHhkLksKUxJ56fnkM+UGUrN0+AYEdimmAmf9QkSTp8m7IJIShV9oh4yHFwoSc5LTiHgOzasp53Q14w9YQtfWjbwMOuC/vubCtHtJvI8Lq29GBguBRO4HfmNmy1+fGzWaqmZP/wawQ7mnGEiq4cAVvKUzWr+0EdOU5xp5rdo7hbqVs5f6X4N4sKQ6P6k2BNP+5JYRzS+gojJPBSJG0cQs20Ky62fGgyhxU54vkJiaEMYiT/jAQYnWrmwo+Za3mf9rzOkrrOIELiRH1XCfmbkMvpPR0Yr1XJDdtZ2m9Lgy4lfZYyNW9dfn960mM1Feqi3NarjjNKiQEJAyweMzxr7ofx5SL9ngUzwUlWx3MWjjiSlHD6HQ/wCoyNiuWSVK04cLQK2q0NeNg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d518c8e-6c99-4663-3d1d-08d68d4f6c08
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 22:55:57.2064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0480
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To fix systemd/sysVinit crashes enable __ARCH_WANT_STAT64.

systemd failed to start with this error for 32-bit RISC-V:
[    2.833864] Run /sbin/init as init process
/sbin/init: error while loading shared libraries: libsystemd-shared-239.so:=
 cannot stat shared object: Error 38
[    2.933593] Kernel panic - not syncing: Attempted to kill init! exitcode=
=3D0x00007f00
[    2.934120] CPU: 0 PID: 1 Comm: init Not tainted 5.0.0-rc4-yoctodev-stan=
dard #1
[    2.934589] Call Trace:
[    2.934919] [<c0048a30>] walk_stackframe+0x0/0xa0
[    2.935243] [<c0048c14>] show_stack+0x28/0x32
[    2.935518] [<c05fa418>] dump_stack+0x68/0x88
[    2.935788] [<c004de48>] panic+0xf0/0x252
[    2.936041] [<c0051780>] do_exit+0x7de/0x7fc
[    2.936387] [<c00517f4>] do_group_exit+0x2a/0x82
[    2.936674] [<c005185e>] __wake_up_parent+0x0/0x22
[    2.936982] [<c00475fa>] ret_from_syscall+0x0/0xe
[    2.937673] ---[ end Kernel panic - not syncing: Attempted to kill init!=
 exitcode=3D0x00007f00 ]---

sysVinit had a similar problem as well. By enabling __ARCH_WANT_STAT64
for 32-bit RISC-V the problem disapears and 32-bit RISC-V is able to
boot.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
This was tested with this fork of glibc to enable 32-bit RISC-V support:
https://github.com/riscv/riscv-glibc/tree/riscv-glibc-2.29
commit: 04fdd476160a55792a75375ba2bf56c761f811c2

I'm not sure if this is a glibc problem or a kernel problem, but this
commit caused the breakage between the 4.19 and 4.20 kernel so I'm
sending out a patch. Let me know your thoughts

arch/riscv/include/uapi/asm/unistd.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/unistd.h b/arch/riscv/include/uapi=
/asm/unistd.h
index 1f3bd3ebbb0d..031b7d78e11c 100644
--- a/arch/riscv/include/uapi/asm/unistd.h
+++ b/arch/riscv/include/uapi/asm/unistd.h
@@ -20,6 +20,9 @@
 #endif /* __LP64__ */
=20
 #include <asm-generic/unistd.h>
+#if __BITS_PER_LONG =3D=3D 32
+#define __ARCH_WANT_STAT64
+#endif
=20
 /*
  * Allows the instruction cache to be flushed from userspace.  Despite RIS=
C-V
--=20
2.20.1

