Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC19C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3B5204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="n3yP/Oef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3B5204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbeIBRVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:21:02 -0400
Received: from mail-sn1nam02on0106.outbound.protection.outlook.com ([104.47.36.106]:31968
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728318AbeIBRVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVuRMVnTRCsGuZ410P+pNs77a0mrZkqxA/4frVpEuTg=;
 b=n3yP/OefNSEpCtv+djPUaX+fXDNaiaYqgl2hxEu1rgx9ABpjWu704iWmTykyx1gA+fZcui7Ex3jyGDHd7oh8uf+hHfAHmN8P7QJfgTNEvcxwJW29GHdfovg/CVCE84Yhz+hVQ4UtcNGOhg1AT/xEwCu1r4TP9LGrw5e8XbrkEWY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:52 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:52 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 070/131] powerpc/mm: Don't report PUDs as memory
 leaks when using kmemleak
Thread-Topic: [PATCH AUTOSEL 4.18 070/131] powerpc/mm: Don't report PUDs as
 memory leaks when using kmemleak
Thread-Index: AQHUQr17Saob0GWXWkOZgUIr0EwEug==
Date:   Sun, 2 Sep 2018 13:04:29 +0000
Message-ID: <20180902064601.183036-70-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:SYPoh24R77FGnf5WjgvLS5qaQjME2pfISVGuMRquOzMKl7A7kiaHYvPD0FxxG8LS9AP2ix1z7U6DDDJrW6imsEvxCfU435YNZwt+4BB9XtqAIG9N8pSC+5KOKzntAfWEBqbz7KOL37Vg68MNKPfzA6j7NlZcu3ThIqdBOx9nMS/vNX8xMKqk3F0bXAQr2BaUahUbGnKytKZ8J8WeaAY6M5I66SOMx1ZRRcYrgcUgvEgNj1QkCpE/KOT1rdmzIZw5iazkzXKh8aqZXdgtDYsUqm8nhGaVg31FEJO6gJKDK2DcpLWHUV1nR4GF7FMsumpSQaB93kDL2HPFkaHZI6J7zkg99tDan1sMkf8dadUI39RJniqCbPSPnBW2uidrYHkbE8MfkI7vTvdk9JjCqKA7JH3q6SBElhLM8Z+RySQjMFdF51NcQG/Ghu3twk136HTRHfQGgrjZ4HURvOcAB9ePQQ==;5:QPKRX8lF+20VXpngLLk7ugd5VMt7LO28xmER+oY8bw4NO3lqBI3jC+QhI/B20FN0ZRZ9rk4vm/kEWD2GHZq8RKA2rToldmb8A6LCPKScclpBqmAxKVgDjYoBV/ecRgVZLGrNdtsgRKrNcMlFRq1cH5RPq5jCbCYlsMNzjP0bx+g=;7:rGI8/lsbmfeVoXAKCjjR8Sc4iaxIBIXogv1fQX8+T2ckmmDnNOyVBPwWGtzyaLVCAH6Tv0f5iLCYGBUgdKPIxtMPHqli3iEVvHYhnTBefpls74M+r0WbwQkGT7eEpMApgfpMrqR94l6a8c6ngeG+C+aTcDO1DaJQwDHD4RpGFA51nB9/cTXcu9auwIdqNaHVRqg51wgu4EzxjNB5Kbj/7Gyb629LMLlCvo1Fbs9ZdBZtN1XAIMcOeQxhYAx7bXui
x-ms-office365-filtering-correlation-id: e18d6f03-5475-4cae-3b92-08d610d4ac14
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB012080A7318F6B261F34F9EEFB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(366004)(346002)(39860400002)(199004)(189003)(110136005)(5660300001)(107886003)(26005)(6506007)(6666003)(2900100001)(8936002)(68736007)(66066001)(99286004)(76176011)(217873002)(2906002)(1076002)(316002)(3846002)(6116002)(86612001)(14444005)(54906003)(6436002)(305945005)(7736002)(256004)(575784001)(86362001)(6486002)(25786009)(10290500003)(478600001)(14454004)(476003)(22452003)(5250100002)(97736004)(106356001)(72206003)(53936002)(2501003)(2616005)(446003)(11346002)(6512007)(10090500001)(4326008)(36756003)(105586002)(102836004)(8676002)(81156014)(81166006)(186003)(486006)(505234006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Pc+H3mZttMW/t38UpxQbq+zCWtkiE7n5//zcGTvaW1f31EJhHzb3U9Ptpr0FIMGHAFwGUT1KL1GcOEC+XqpwYGVlKp2HoW26oZz3nadZBkyOqnrhjOSZ5r4a7W8+k8LBCtyxgscqWVi1/NBYvUzFq7VRf4gNpvEbHcAwr5JRUB2OI7Gmiw4K2QDgCwwNOmjAstqJVKmEeVcxwH+MPuQRf3Jfj6fBKJyKcAKqnpKgnN2r8e1tbclB2QjWkA3+UMJdfUjDig4hxpZ6qnACTwRfVo4SOfyRxIb5Rfw5j/iGVKKcSSXdSGju34F8KOrYm2Ak0uVHfQ/61KD1suUFF6rlalM85rBeRwCrS8yIeRSqYkc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e18d6f03-5475-4cae-3b92-08d610d4ac14
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:29.2729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit a984506c542e26b31cbb446438f8439fa2253b2e ]

Paul Menzel reported that kmemleak was producing reports such as:

  unreferenced object 0xc0000000f8b80000 (size 16384):
    comm "init", pid 1, jiffies 4294937416 (age 312.240s)
    hex dump (first 32 bytes):
      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    backtrace:
      [<00000000d997deb7>] __pud_alloc+0x80/0x190
      [<0000000087f2e8a3>] move_page_tables+0xbac/0xdc0
      [<00000000091e51c2>] shift_arg_pages+0xc0/0x210
      [<00000000ab88670c>] setup_arg_pages+0x22c/0x2a0
      [<0000000060871529>] load_elf_binary+0x41c/0x1648
      [<00000000ecd9d2d4>] search_binary_handler.part.11+0xbc/0x280
      [<0000000034e0cdd7>] __do_execve_file.isra.13+0x73c/0x940
      [<000000005f953a6e>] sys_execve+0x58/0x70
      [<000000009700a858>] system_call+0x5c/0x70

Indicating that a PUD was being leaked.

However what's really happening is that kmemleak is not able to
recognise the references from the PGD to the PUD, because they are not
fully qualified pointers.

We can confirm that in xmon, eg:

Find the task struct for pid 1 "init":
  0:mon> P
       task_struct     ->thread.ksp    PID   PPID S  P CMD
  c0000001fe7c0000 c0000001fe803960      1      0 S 13 systemd

Dump virtual address 0 to find the PGD:
  0:mon> dv 0 c0000001fe7c0000
  pgd  @ 0xc0000000f8b01000

Dump the memory of the PGD:
  0:mon> d c0000000f8b01000
  c0000000f8b01000 00000000f8b90000 0000000000000000  |................|
  c0000000f8b01010 0000000000000000 0000000000000000  |................|
  c0000000f8b01020 0000000000000000 0000000000000000  |................|
  c0000000f8b01030 0000000000000000 00000000f8b80000  |................|
                                    ^^^^^^^^^^^^^^^^

There we can see the reference to our supposedly leaked PUD. But
because it's missing the leading 0xc, kmemleak won't recognise it.

We can confirm it's still in use by translating an address that is
mapped via it:
  0:mon> dv 7fff94000000 c0000001fe7c0000
  pgd  @ 0xc0000000f8b01000
  pgdp @ 0xc0000000f8b01038 =3D 0x00000000f8b80000 <--
  pudp @ 0xc0000000f8b81ff8 =3D 0x00000000037c4000
  pmdp @ 0xc0000000037c5ca0 =3D 0x00000000fbd89000
  ptep @ 0xc0000000fbd89000 =3D 0xc0800001d5ce0386
  Maps physical address =3D 0x00000001d5ce0000
  Flags =3D Accessed Dirty Read Write

The fix is fairly simple. We need to tell kmemleak to ignore PUD
allocations and never report them as leaks. We can also tell it not to
scan the PGD, because it will never find pointers in there. However it
will still notice if we allocate a PGD and then leak it.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/include/asm/book3s/64/pgalloc.h | 23 ++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/in=
clude/asm/book3s/64/pgalloc.h
index 01ee40f11f3a..76234a14b97d 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -9,6 +9,7 @@
=20
 #include <linux/slab.h>
 #include <linux/cpumask.h>
+#include <linux/kmemleak.h>
 #include <linux/percpu.h>
=20
 struct vmemmap_backing {
@@ -82,6 +83,13 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
=20
 	pgd =3D kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
 			       pgtable_gfp_flags(mm, GFP_KERNEL));
+	/*
+	 * Don't scan the PGD for pointers, it contains references to PUDs but
+	 * those references are not full pointers and so can't be recognised by
+	 * kmemleak.
+	 */
+	kmemleak_no_scan(pgd);
+
 	/*
 	 * With hugetlb, we don't clear the second half of the page table.
 	 * If we share the same slab cache with the pmd or pud level table,
@@ -110,8 +118,19 @@ static inline void pgd_populate(struct mm_struct *mm, =
pgd_t *pgd, pud_t *pud)
=20
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long add=
r)
 {
-	return kmem_cache_alloc(PGT_CACHE(PUD_CACHE_INDEX),
-		pgtable_gfp_flags(mm, GFP_KERNEL));
+	pud_t *pud;
+
+	pud =3D kmem_cache_alloc(PGT_CACHE(PUD_CACHE_INDEX),
+			       pgtable_gfp_flags(mm, GFP_KERNEL));
+	/*
+	 * Tell kmemleak to ignore the PUD, that means don't scan it for
+	 * pointers and don't consider it a leak. PUDs are typically only
+	 * referred to by their PGD, but kmemleak is not able to recognise those
+	 * as pointers, leading to false leak reports.
+	 */
+	kmemleak_ignore(pud);
+
+	return pud;
 }
=20
 static inline void pud_free(struct mm_struct *mm, pud_t *pud)
--=20
2.17.1
