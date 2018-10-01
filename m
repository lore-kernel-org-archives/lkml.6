Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852E2C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413D02089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ni8x4x/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413D02089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbeJAHP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:15:58 -0400
Received: from mail-by2nam03on0136.outbound.protection.outlook.com ([104.47.42.136]:2896
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728957AbeJAHP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7+0pRY0svB9FNfCSgP/f3OrEDCvM73X5Tp09FHOWKg=;
 b=ni8x4x/NtzeAJdFE+lAOdXUdi8kBr4WvF6v3DSHBG7L/pqm0rC/66xQmIk675JO1ARPqItATqVyGnHEMzSK/KTiwsCmcJ8vW58gr21CRL1P5/IucVIuJEOvqvHmE0Eq/Gvtl4Z2JgsCw1HbkuTkxkD2q2avj6zGMGFVYPTlB2M0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.5; Mon, 1 Oct 2018 00:40:40 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:40:40 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Richard Kuo <rkuo@codeaurora.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 18/26] hexagon: modify ffs() and fls() to return
 int
Thread-Topic: [PATCH AUTOSEL 4.9 18/26] hexagon: modify ffs() and fls() to
 return int
Thread-Index: AQHUWR9gCgOIrW1G5E6Zib5BUFZVHg==
Date:   Mon, 1 Oct 2018 00:40:40 +0000
Message-ID: <20181001004026.147201-18-alexander.levin@microsoft.com>
References: <20181001004026.147201-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004026.147201-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:QupLtZaGor5AI7G2vdzihDEN1P6BhGgBbaOY2L+j6ydH9FFVCb/vRcL3ZCy9yGzx1jHVeYuY6K0twctAMhmHcvDX+mii6+wIjasgiLqSWoJa/29u80RuhF2Ii23t6VYAwuqfStAQcKltllwQoryf6i0TNLgAunryPftePWx/3PtSqeM9D/hn0fPyrnVpMUkVP4HUstXZGqK/svZdmKMHlHmdMzFU1mNL2XfBmiXW1eeFYp4wAgmYd3UniL9T9HmOQ+5iSxxTjHm/7XGsZfy0yjBkIkyRg4ynDJyUwCtabEBrM3rSxlm0qtmr4uLm59jnNro8OmWBDgGBEMPn6RgnOo7OEGc3+BUpKhq3keBXrn7fA3Uj03V4fxq5QlMj0ighk5hKTITu+/7atcJmA1pq4eqFI6SrkGO233OfBXhr3DdMMKpIaFoLGU5Usvvt9reeDejlE6g0YIfELpSCMZsvng==;5:bozHGca39j9KIKoOQC8bFPZjlsVmAinpgPYCOGpOUiKgrVx9UwHfPs1KmYY5jTV8lt7aq7OSUcDnBGWJA4mhXLorSaYU8Xaxv0zMtekpF2wKGAtEOKDtNzAMYOgi68i6O94H7rmtYFgn2oX4VqSkibzZK6iOKDXc/ZdiYMc6fnY=;7:NB++oZr/H9nWwPFzvX1wt0LVJvUAqeZbR6DOIs4K1wyIZdysnbJS6fUCgXDUXi2ShOYx3qZL/2oQEnckAQQWsqYcdCKS6wscNJaXu21wroqBYJh3czjVwgR478aY5SXCCeo01MNswRxiaTyXccNpaFtvnSg9GxhoR86oJXZMzRHkVtUms5dDBuB58lATwAmfyxtGGCsS7kiwBJmshaGX0QIwunPJJ70Ohuxzpu3HZ7vrQqUgSsQZfMQwWThws1SD
x-ms-office365-filtering-correlation-id: 88032c77-d838-433a-f25a-08d62736833a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-microsoft-antispam-prvs: <CY4PR21MB0165834A072BF96FA6BBB77BFBEF0@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(366004)(39860400002)(199004)(189003)(476003)(2616005)(256004)(217873002)(486006)(6486002)(1076002)(11346002)(446003)(86362001)(97736004)(2900100001)(3846002)(6116002)(2501003)(110136005)(478600001)(54906003)(2906002)(5250100002)(6436002)(8936002)(316002)(53936002)(14444005)(81166006)(81156014)(68736007)(5660300001)(99286004)(8676002)(10290500003)(26005)(6346003)(4326008)(86612001)(6506007)(305945005)(106356001)(7736002)(76176011)(6512007)(72206003)(102836004)(25786009)(105586002)(107886003)(186003)(14454004)(71200400001)(34290500001)(71190400001)(22452003)(36756003)(66066001)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: yqpPXTqZiSIZsQKx80o0kLJ0H4uYQyE+/ud++uRl179SriS16x8PeIYjrzYRXGSqD5S/JJjKfvmuL6bT9+w7DtoH3XMCVzn15POsAQlTAbtoGHAxbwy8+De/Ne05j5AfiENvv/R6jk8z4eYrCnPmHFYDkXUWCTAMJt9lOTnzcl8vFmo9Ln6MegMfvD/u79LJWb7bpU7RY5llMTcRWYhCCr3KUmEgi1TP9dBAnCoebxGclcvbWmxUWRjlxV9cfyBLYeFeDNYTNwv6q5UNspHBeq7gvaIBRCZ0lbYxp9V7h0lF9EGkAtlT+XKSSRatPjUBDaCP2u1czmqF9+fh+w4brpghJgDpXQabeFPo9l1JU7U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88032c77-d838-433a-f25a-08d62736833a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:40:40.1718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 5c41aaad409c097cf1ef74f2c649fed994744ef5 ]

Building drivers/mtd/nand/raw/nandsim.c on arch/hexagon/ produces a
printk format build warning.  This is due to hexagon's ffs() being
coded as returning long instead of int.

Fix the printk format warning by changing all of hexagon's ffs() and
fls() functions to return int instead of long.  The variables that
they return are already int instead of long.  This return type
matches the return type in <asm-generic/bitops/>.

../drivers/mtd/nand/raw/nandsim.c: In function 'init_nandsim':
../drivers/mtd/nand/raw/nandsim.c:760:2: warning: format '%u' expects argum=
ent of type 'unsigned int', but argument 2 has type 'long int' [-Wformat]

There are no ffs() or fls() allmodconfig build errors after making this
change.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Patch-mainline: linux-kernel @ 07/22/2018, 16:03
Signed-off-by: Richard Kuo <rkuo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/hexagon/include/asm/bitops.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/hexagon/include/asm/bitops.h b/arch/hexagon/include/asm/b=
itops.h
index 5e4a59b3ec1b..2691a1857d20 100644
--- a/arch/hexagon/include/asm/bitops.h
+++ b/arch/hexagon/include/asm/bitops.h
@@ -211,7 +211,7 @@ static inline long ffz(int x)
  * This is defined the same way as ffs.
  * Note fls(0) =3D 0, fls(1) =3D 1, fls(0x80000000) =3D 32.
  */
-static inline long fls(int x)
+static inline int fls(int x)
 {
 	int r;
=20
@@ -232,7 +232,7 @@ static inline long fls(int x)
  * the libc and compiler builtin ffs routines, therefore
  * differs in spirit from the above ffz (man ffs).
  */
-static inline long ffs(int x)
+static inline int ffs(int x)
 {
 	int r;
=20
--=20
2.17.1
