Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6959AC61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 13:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267F42087E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 13:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZVlIE08K";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dd4RsWsd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfASN2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 08:28:10 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:42141 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbfASN2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 08:28:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547904490; x=1579440490;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5clvEc+EFgdK4T/Iczm91gdzvaVtM8VoefDnldveq20=;
  b=ZVlIE08Kj6ncFBrvq4NhaPDsI9K4W5x0YcHkGTy9OtF34/tyXeSpAviy
   iLOZKUIxF0GIUNHqUdfhthNeEfVrczpnvrcX14zfxajuI0w4rghQVxQVm
   QE5xJJVnNbnkzvRpVqDM3/Q05NeoaSwLCVIMXkIw3D90XSQ9VeAgaNTWx
   u2D8m+SL5rtiFPKfHrroBxTIt9fciRu+cDOZmuovyf/eZfS6JJ+/JBkCT
   aKpcUiJdFSzspf6ohSL18kCmEgrMiJxj6d6g73P4o/jpnKEwLFGtDFphF
   OLIYBUuiX7PMw2xxiOQ00FTUSo/sdYXaXBDjlUR5pXAzBa0So5P4zCek9
   w==;
X-IronPort-AV: E=Sophos;i="5.56,495,1539619200"; 
   d="scan'208";a="101011291"
Received: from mail-sn1nam04lp2054.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.54])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2019 21:28:09 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zF6hu0fpdA9VC4UYtqAme+z5ny0ToEpBQrWwrYwzbq8=;
 b=dd4RsWsdrbFlgvSgkgzm/GKU/QNdkIilZal3nyANrBW1tPehwPcbDwR5UxUWFPAGv2J0yx4WubH6ac06mtL84Xbvhjq2+z/wxAHxX+nhsU7XUK3TifTUBDD1V3fgQcpKLo+Ekj8Uel8CJ1NicoDz/sr41lng5AicWDo9rv5vUPk=
Received: from BYAPR04MB5303.namprd04.prod.outlook.com (20.178.49.148) by
 BYAPR04MB4678.namprd04.prod.outlook.com (52.135.240.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.28; Sat, 19 Jan 2019 13:28:07 +0000
Received: from BYAPR04MB5303.namprd04.prod.outlook.com
 ([fe80::add1:92cc:65d7:5d94]) by BYAPR04MB5303.namprd04.prod.outlook.com
 ([fe80::add1:92cc:65d7:5d94%2]) with mapi id 15.20.1537.028; Sat, 19 Jan 2019
 13:28:07 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v2 2/6] RISC-V: Setup init_mm before parse_early_param()
Thread-Topic: [PATCH v2 2/6] RISC-V: Setup init_mm before parse_early_param()
Thread-Index: AQHUr/rQF1FzZ43LWUiaqt7t2ByYrQ==
Date:   Sat, 19 Jan 2019 13:28:07 +0000
Message-ID: <20190119132650.9978-3-anup.patel@wdc.com>
References: <20190119132650.9978-1-anup.patel@wdc.com>
In-Reply-To: <20190119132650.9978-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0111.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::27) To BYAPR04MB5303.namprd04.prod.outlook.com
 (2603:10b6:a03:c8::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [49.207.52.191]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR04MB4678;6:wHARZ5lD5c78P0tGEplzDd+NM43s1EmXqW6x5ExToJ0uqpPKRI8/CkY9TqM5GIDUS7RsnEk+52IfUjM/6X6EeNqHXFv7o2yAnXzkxGLCUUcW1/CB8JSlTv4Tfd83s1e0tOI9oftj8/wvqkjs7z5HcaZvLhkhjbxD7k7O2TgVzzYQUVq018jh0E1qc9NVbLMRRhtVSra6o3myEOcZXIrB5CcJbcY5e8xAveWXIEHwYcB3LVz5syHsI/poY9SFZsCYuWcysygO4HwdmPEQaIJat5W1ufhfC9s/RgUxMb4Q+bhiDUwz9gikgUYAz9nswmubLN8KFaoTj9w0ZPQ6QYqzfELGU3CKq+e2owbZKMJPFefZzQrRRgI6RF5qO8iZYKkZWF+aBP24NZmZEh9rsjmLnhebaD20oFD8Xv8DnHR5l+PS+sYNIscnWPky96CoNq31WBlmZvHFzZ6aVI+42WhmVA==;5:kCOkwqzlv4T1Jycv75g1URtWa1kHCTzODvV2bSwjIz0Sz/x3bQMEX8aPRPJqZYFWz+EZF8jR8RNyAY8VvC4g/eeFH01yYblkegjPYXcq6rjqRCyJFjTAwKdyLvLSQXppZ+4qPRxxHB5I7z1BRa63xqZNgnS/gjACbowPg5u1wmZsQQsV9iuZE6TDk//+ExX0ExV9jX1o2EcQZT9AX4W5kQ==;7:VhCxm/smzWRUl6IQpPrUd5gFGL2o5Li9wQQHhnqtyZhYrGPBdXk+nM1rt13E7a0nPJNI4ttgdbCoMmjvbURV3kre/9OBSP06SmngIr/lDfLqu+SMFDIC0AJhzENHUDUnFBcGKfHV6JP4ZlPc/Tq9yg==
x-ms-office365-filtering-correlation-id: 11324407-63c3-4103-1654-08d67e11f2ab
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB4678;
x-ms-traffictypediagnostic: BYAPR04MB4678:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB467836A72C34F4F07A9520458D9D0@BYAPR04MB4678.namprd04.prod.outlook.com>
x-forefront-prvs: 09222B39F5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(39860400002)(366004)(189003)(199004)(50226002)(7736002)(2906002)(6436002)(72206003)(5660300001)(106356001)(6486002)(478600001)(68736007)(8936002)(256004)(36756003)(44832011)(486006)(71200400001)(71190400001)(105586002)(97736004)(52116002)(66066001)(14454004)(54906003)(6116002)(3846002)(1076003)(110136005)(25786009)(446003)(99286004)(26005)(76176011)(8676002)(2616005)(476003)(4326008)(86362001)(81166006)(2171002)(305945005)(81156014)(11346002)(53936002)(55236004)(186003)(386003)(102836004)(6512007)(6506007)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4678;H:BYAPR04MB5303.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jL/tsS2PK4IbTSzQ3z0jIYNO4nO4wWxcZsLe5zFEo4CyDmjYih1AJEemOb7C5tuuBHrJCVTNDsWis1ooTVIa6jyJFtxcl7NMhhzxfdSQEo7iMu5tOo1wkOqw+5PBvFU79nIVhAKXgLIjrfXpOtxfssXw0SKC1OrwH8m39PAuFJwJYCqd6QsaUFyFFwd/yCvGP4lIBkIr7AGOH+pHVYLWzj9ONUkx/Cqpym9jV3q+UsNPPkYd+l2IWzVEABA35omEGgWHqT6ANqpL7ydDCuOKVxS1C69xMU9hiU1CRQRbUrhTXo5hths658UzvBPRGcry24+vAoU9V2qzfbFOq96wGywBor6moKoEwtkCQR2cRGneScY/9XBe171cxbn7L4D3JtyWa0n9B3JrK4U3W3KzQYHN/uJl9Y4vEzFpCAgc5DY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11324407-63c3-4103-1654-08d67e11f2ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2019 13:28:04.8470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4678
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should setup init_mm before doing parse_early_param()
in setup_arch() to be consistent with setup_arch() of
other architectures such as x86, ARM, and ARM64.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/kernel/setup.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index f270adcc678f..577d8460d141 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -208,15 +208,15 @@ static void __init setup_bootmem(void)
=20
 void __init setup_arch(char **cmdline_p)
 {
-	*cmdline_p =3D boot_command_line;
-
-	parse_early_param();
-
 	init_mm.start_code =3D (unsigned long) _stext;
 	init_mm.end_code   =3D (unsigned long) _etext;
 	init_mm.end_data   =3D (unsigned long) _edata;
 	init_mm.brk        =3D (unsigned long) _end;
=20
+	*cmdline_p =3D boot_command_line;
+
+	parse_early_param();
+
 	setup_bootmem();
 	paging_init();
 	unflatten_device_tree();
@@ -235,4 +235,3 @@ void __init setup_arch(char **cmdline_p)
=20
 	riscv_fill_hwcap();
 }
-
--=20
2.17.1

