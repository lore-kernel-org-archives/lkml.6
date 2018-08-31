Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756F3C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09AC32083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gCTslJKx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09AC32083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeHaTOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:14:46 -0400
Received: from mail-cys01nam02on0125.outbound.protection.outlook.com ([104.47.37.125]:44998
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727599AbeHaTOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4evHpUcmADEhWHhKWNAlcPnCtBdySXqgpvgeX5FbOo=;
 b=gCTslJKxKxv3688cs9H/eQihVMybIFJ3sXCPGM/Cewm26PNHMuQ0kqbjX8oO5rt2CXdDz1nV7t9RdF08A8+sBibQzMDou84MhOf8LenH0DzBGq/eXI3eb6R+TWCzSs76FdFWDaWOhefUSvEl9xRLyEJWoF+Ih1wQ57Irx41sfUE=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0122.namprd21.prod.outlook.com (10.173.173.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.1; Fri, 31 Aug 2018 15:05:09 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5%4]) with mapi id 15.20.1143.000; Fri, 31 Aug 2018
 15:05:09 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "jslaby@suse.cz" <jslaby@suse.cz>
Subject: [PATCH] mm: Disable deferred struct page for 32-bit arches
Thread-Topic: [PATCH] mm: Disable deferred struct page for 32-bit arches
Thread-Index: AQHUQTwCg+mLq5HRaE28hICIYMUC4g==
Date:   Fri, 31 Aug 2018 15:05:09 +0000
Message-ID: <20180831150506.31246-1-pavel.tatashin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0122;6:sTUP9WQ4swXCnqTP8i1+JG29bLfR0HkNZTJ1Vp3mqrAh1zTquFdXoJuld5O340PKslnEvQqVXDv7kOMlb6ruPEBrx7Zc1k7u5WF/BliS0XUN61KWjhFawAW+I5PFf/FTO/1vlcxWfTmJqtUOWlwxpYusYghaUESV5+WwK66ElayjQfUD1hygb9mR4guPtT6IauT5OJJ2YCEJfuG5nYyCp/SSNCviCN33Tr187b+hkGY+bWbgx4UqRYfaj4B6UFMi+734BqLdrN1SQIPZngy1qUVmUXQUHdad3S3/nS2lT2MyNeyjXjoMblQkAksc11L/7ZpIixhX9Vj7IgIhLJnM8TRa7VcwccsLS3IcZT7unebZRF4PB906OrPlKsQigHNj8FeMwYpxW/osQpL6221BGsCpyLipCoAC4Oxvyr3jwiYEcyOtNcFjlI/aap7fkN0HrUEOnGEzbufJcCApbIiiUQ==;5:/MLbA7aZI/bMFxp/xhCBSNVET4CKyPkhR1+z+S65a7q2UAaJ90nDheRD32vM8cKTh9aPyAvFNv2GOx4ZKtkM/DOlqtkeGyvcT0mAZeUkh8I/ynVzL19blUzGNkDOEOUVQxYorZkSukyBxYnhskw3Nt9Ct1gyLAsO4j4jabv4g9c=;7:rdmGJD8wFcJtsnULK5y9yFbKCar4CttTK4lp0Sy+B6/RdoIn3yc9Oizr/jr/GpOmsCfIdf0HV4Zu6n0j2MbaTtAYeSypzjer/1Z7Ba99I24IvRmLfUpg595iQIN2hmIIamvc6ZjqxF7PhRRBftjybDmGbeGpxZOYzxi2OB2mXKBNEgig3GZtX3Q49TnNceOBXSkXRQvNWb9h6ZByAr5mq344mNzRH2g+9aDgc0BxeWlo1YKMRmvtDf+3lDNCLlxi
x-ms-office365-filtering-correlation-id: 56ab6f3b-118f-46dc-547c-08d60f5324cf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0122;
x-ms-traffictypediagnostic: DM5PR21MB0122:
x-microsoft-antispam-prvs: <DM5PR21MB01227224615D76107D7957289D0F0@DM5PR21MB0122.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:DM5PR21MB0122;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0122;
x-forefront-prvs: 07817FCC2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(396003)(39860400002)(346002)(189003)(199004)(2616005)(476003)(5250100002)(2501003)(2201001)(1076002)(53936002)(14454004)(26005)(6512007)(5660300001)(68736007)(86362001)(575784001)(110136005)(86612001)(486006)(6506007)(3846002)(316002)(305945005)(6116002)(66066001)(36756003)(97736004)(6486002)(2906002)(256004)(6346003)(14444005)(1511001)(10290500003)(186003)(72206003)(1857600001)(105586002)(8936002)(25786009)(478600001)(106356001)(22452003)(6436002)(8676002)(7736002)(10090500001)(99286004)(81166006)(81156014)(102836004)(2900100001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0122;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: /dY3efqhlTnz5ujEC0JMI75IFng0F2w4k/nT4pukktzksVrCOOA+GhWm0O83qsykUusc/goKwT/5eO5+2C5IQ3UTPRb/Np/Q2NEdKpUCC6OLqkw14aXM5YafAKg8RvKIK7VUhzi/xKv+A6HXT6j/fO64Id6Rq3Af0Pq1jq4GYOYya4I1gqZAze/F4ZzZZfl3ErtReHU+Ez5lhtUoIU+28WYO4imh4kY3oDm8cLBSUL1FaCJFg1yDpyuvoFlkxC2xmCgL4sVWJFBMEYVMUDs7WdcGbNDkHfF9aKNuruZbxqUcBe6dIHs+UjexgohfIAwAOINxVGH7DlX+PFs7F/7EDi2mW77muWGor5ty0BuZwFI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ab6f3b-118f-46dc-547c-08d60f5324cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2018 15:05:09.2679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deferred struct page init is needed only on systems with large amount of
physical memory to improve boot performance. 32-bit systems do not benefit
from this feature.

Jiri reported a problem where deferred struct pages do not work well with
x86-32:

[    0.035162] Dentry cache hash table entries: 131072 (order: 7, 524288 by=
tes)
[    0.035725] Inode-cache hash table entries: 65536 (order: 6, 262144 byte=
s)
[    0.036269] Initializing CPU#0
[    0.036513] Initializing HighMem for node 0 (00036ffe:0007ffe0)
[    0.038459] page:f6780000 is uninitialized and poisoned
[    0.038460] raw: ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff f=
fffffff ffffffff
[    0.039509] page dumped because: VM_BUG_ON_PAGE(1 && PageCompound(page))
[    0.040038] ------------[ cut here ]------------
[    0.040399] kernel BUG at include/linux/page-flags.h:293!
[    0.040823] invalid opcode: 0000 [#1] SMP PTI
[    0.041166] CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc1_pt_jiri #=
9
[    0.041694] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.11.0-20171110_100015-anatol 04/01/2014
[    0.042496] EIP: free_highmem_page+0x64/0x80
[    0.042839] Code: 13 46 d8 c1 e8 18 5d 83 e0 03 8d 04 c0 c1 e0 06 ff 80 =
ec 5f 44 d8 c3 8d b4 26 00 00 00 00 ba 08 65 28 d8 89 d8 e8 fc 71 02 00 <0f=
> 0b 8d 76 00 8d bc 27 00 00 00 00 ba d0 b1 26 d8 89 d8 e8 e4 71
[    0.044338] EAX: 0000003c EBX: f6780000 ECX: 00000000 EDX: d856cbe8
[    0.044868] ESI: 0007ffe0 EDI: d838df20 EBP: d838df00 ESP: d838defc
[    0.045372] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 0021008=
6
[    0.045913] CR0: 80050033 CR2: 00000000 CR3: 18556000 CR4: 00040690
[    0.046413] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    0.046913] DR6: fffe0ff0 DR7: 00000400
[    0.047220] Call Trace:
[    0.047419]  add_highpages_with_active_regions+0xbd/0x10d
[    0.047854]  set_highmem_pages_init+0x5b/0x71
[    0.048202]  mem_init+0x2b/0x1e8
[    0.048460]  start_kernel+0x1d2/0x425
[    0.048757]  i386_start_kernel+0x93/0x97
[    0.049073]  startup_32_smp+0x164/0x168
[    0.049379] Modules linked in:
[    0.049626] ---[ end trace 337949378db0abbb ]---

We free highmem pages before their struct pages are initialized:

mem_init()
 set_highmem_pages_init()
  add_highpages_with_active_regions()
   free_highmem_page()
    .. Access uninitialized struct page here..

Because there is no reason to have this feature on 32-bit systems, just
disable it.

Fixes: 2e3ca40f03bb ("mm: relax deferred struct page requirements")
Cc: stable@vger.kernel.org

Reported-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
---
 mm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index a550635ea5c3..de64ea658716 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -637,6 +637,7 @@ config DEFERRED_STRUCT_PAGE_INIT
 	depends on NO_BOOTMEM
 	depends on SPARSEMEM
 	depends on !NEED_PER_CPU_KM
+	depends on 64BIT
 	help
 	  Ordinarily all struct pages are initialised during early boot in a
 	  single thread. On very large machines this can take a considerable
--=20
2.18.0
