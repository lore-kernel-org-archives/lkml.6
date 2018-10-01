Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD9DC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA3520666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SqLZ4WeB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA3520666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbeJAHOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:14:45 -0400
Received: from mail-by2nam03on0120.outbound.protection.outlook.com ([104.47.42.120]:46043
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728345AbeJAHOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfdcYUvoZBsH8wfFZ9yUYk+IR5ZtjJIeTaHXCw8Hzww=;
 b=SqLZ4WeB2sUxF9YVGcDGAcXuBCFbZF+MrCLyGJlYIU8JHZYcp1TFW/YhiDH1nmtb3NfWdXCvcfJg6k402UYQnRX5nFNg/LINSBzQ6kHtOe+OvqngFPadOCCS8g+4B5XAMIb3CG+Ws0md5lV+ZxoZouSWt7Lm1e1cWj48qL8INVM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0696.namprd21.prod.outlook.com (10.175.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.6; Mon, 1 Oct 2018 00:39:36 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:36 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andrew Murray <andrew.murray@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 61/65] asm-generic: io: Fix ioport_map() for
 !CONFIG_GENERIC_IOMAP && CONFIG_INDIRECT_PIO
Thread-Topic: [PATCH AUTOSEL 4.18 61/65] asm-generic: io: Fix ioport_map() for
 !CONFIG_GENERIC_IOMAP && CONFIG_INDIRECT_PIO
Thread-Index: AQHUWR8ZrTRycVXQA0Sgs3xjR1fIQg==
Date:   Mon, 1 Oct 2018 00:38:40 +0000
Message-ID: <20181001003754.146961-61-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0696;6:qr4UkH5whdr12/RXsufcFSQTZLKaDhuPps0yPmJPWlKJN4gB/S5kpUTRQbircHIkpTWjinPimaijS8dNI2k2OP+1mioHroTqRQ2xc9ZDxnFUU1gU2zaOFAnN/jWiKf/iBh8EuS7KwVPw23Xjm0ZDKOX1ViQH+6O+0wDG1sWIEQef5SjmT/GLkN0A6N6K5lvxGYujC9gBHXKj/MosT19vpc834JZZ87d66CPvQjfFbKG7nYdsq/auHZnp8RDeUpfo6mqfv3lG26Nu1CEWGUlasmPyJxy4piUnF42XOSYbleoofIuyXGpfPRJurpUwbdnzf75EVi/v+lrpWUkz3JZQb5MUdjnvi3wlZTX5te8Acd54jdyXUCVgwYJL+CJXG+lVvg6nZtJMhE7vQdiTL/DHzV4WOwy2S4EQ0o6P+cgbtuyYBpr1BtgyXM3irNGVjjbOivjHy/pKoMGVKA70FjELPg==;5:8Ss/RmmgsAWO+ZtNdY5KvrLTKF1TkH+KDDiftpDvWiAMHKf6Tfm6tp0UM+eH5wpWkdoZeBHnc79utykEGomcl3zYkVcxD3fh/NyFfoFGmbx+AsterDajKy14t3jYIhU5q/lyunRgq3OoTCBwyWj7wMcOTirtFvUnTQGlF0hWlqo=;7:flWf6h730gUKcrKGG7Ld4yRgmUn+fHIecjzKP8OPyM9Qs8lWMtx52q9N+afNHMYguMcRuBFbJ+q0pyCyAeJUzxo2EdqUqzrKtM1+R1J0HiWSJVuXMGPk/Mj3gdDQlfSXl3kDLyqK5VisTs+ZGBwFrFHLzx/O+VxKtQAJ7F5agMkmZqWjMxjf0iFv+LQkl8qXseBsiOXsnbjRSklKaAhSHbiTCpl55Tdn57jnMqSmVD+5bG2fMyQcmGJR+Wsx+F74
x-ms-office365-filtering-correlation-id: a00f7903-875c-4c42-55cc-08d627365d29
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0696;
x-ms-traffictypediagnostic: CY4PR21MB0696:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0696E895813D54AAC645D7C6FBEF0@CY4PR21MB0696.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0696;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0696;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(396003)(346002)(136003)(366004)(189003)(199004)(3846002)(6116002)(5250100002)(71200400001)(97736004)(217873002)(71190400001)(1076002)(76176011)(6506007)(99286004)(11346002)(26005)(86362001)(575784001)(36756003)(2501003)(446003)(2906002)(86612001)(102836004)(2616005)(476003)(14454004)(107886003)(10090500001)(14444005)(4326008)(34290500001)(316002)(486006)(22452003)(256004)(186003)(66066001)(53936002)(305945005)(25786009)(2900100001)(106356001)(6486002)(105586002)(7736002)(6512007)(81156014)(81166006)(6666003)(8936002)(8676002)(5660300001)(68736007)(54906003)(110136005)(6436002)(10290500003)(72206003)(478600001)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0696;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 56e91YG9BNwICcwcjftP5jJUIDQ9yRK8oO/EZseSmCsGxxX7VAnwRGrZi7Of1155DsevcyGtMzYOqSXZwHFm6BXP+qHWUJoNayUxMPFLpTqKytCMUI/GWkAHl41spoh8frz7hOlKLsHnasXWdKnHGUQ+VndAY5IynQbH/yVXyh4lDMOdOX037xWZtt6HXeEDmrmLL2gm8LdeEyWyEw071T7VEq+cL0gWlDDB4v18mdVGv+vJYvJRFJ5qBRduOHchiDuyJAHk31ckgqtn19qFrSkRekb7GbWtodkBsrxXuoHy48x0TOzYO6mktdJV1qHPOMoNBGBxtInKWqJkWcA1NZIuZs2rh6NVFkJ3IvbX7u4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a00f7903-875c-4c42-55cc-08d627365d29
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:40.9001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0696
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Murray <andrew.murray@arm.com>

[ Upstream commit 500dd232449e7c07500e713dc6970aa713f8e4f1 ]

The !CONFIG_GENERIC_IOMAP version of ioport_map uses MMIO_UPPER_LIMIT to
prevent users from making I/O accesses outside the expected I/O range -
however it erroneously treats MMIO_UPPER_LIMIT as a mask which is
contradictory to its other users.

The introduction of CONFIG_INDIRECT_PIO, which subtracts an arbitrary
amount from IO_SPACE_LIMIT to form MMIO_UPPER_LIMIT, results in ioport_map
mangling the given port rather than capping it.

We address this by aligning more closely with the CONFIG_GENERIC_IOMAP
implementation of ioport_map by using the comparison operator and
returning NULL where the port exceeds MMIO_UPPER_LIMIT. Though note that
we preserve the existing behavior of masking with IO_SPACE_LIMIT such that
we don't break existing buggy drivers that somehow rely on this masking.

Fixes: 5745392e0c2b ("PCI: Apply the new generic I/O management on PCI IO h=
osts")
Reported-by: Will Deacon <will.deacon@arm.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/asm-generic/io.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 66d1d45fa2e1..d356f802945a 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1026,7 +1026,8 @@ static inline void __iomem *ioremap_wt(phys_addr_t of=
fset, size_t size)
 #define ioport_map ioport_map
 static inline void __iomem *ioport_map(unsigned long port, unsigned int nr=
)
 {
-	return PCI_IOBASE + (port & MMIO_UPPER_LIMIT);
+	port &=3D IO_SPACE_LIMIT;
+	return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
 }
 #endif
=20
--=20
2.17.1
