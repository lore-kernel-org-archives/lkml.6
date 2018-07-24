Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050B0C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6A720874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=localsearch.ch header.i=@localsearch.ch header.b="lWQbP7eJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6A720874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=search.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388287AbeGXKIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:08:30 -0400
Received: from mail-eopbgr00090.outbound.protection.outlook.com ([40.107.0.90]:28138
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388088AbeGXKI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=localsearch.ch;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLk6Yg8NFfqnd+U6ql2ahSkWmuTbqO5oGlZCCieLLlQ=;
 b=lWQbP7eJVVNbe2xSxybJAo23NDrK1FsDC+6cSoNCQUlo8k4vuDd3KJ3ft2b+fjmF167QWoe6HYWFdpXhnyZCniSoj5tQVxqKp1perKXOBUxYUyrM6hyaWGKat4IagU0drqTZQL/HTeo8nBGlWDAe0l6gR0WORNvQ5z7jAC0zdfM=
Received: from cinnamonbun (2001:918:ff83:101:b5a8:3e78:6cfb:b14a) by
 DB6PR1001MB1432.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:b6::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.20; Tue, 24 Jul 2018 09:01:47 +0000
Date:   Tue, 24 Jul 2018 11:01:45 +0200
From:   David Flatz <flatz@search.ch>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: soft lockup on 4.17.y in migration on Dell PowerEdge
Message-ID: <20180724090144.ekdgufj56haqrxql@cinnamonbun>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-Originating-IP: [2001:918:ff83:101:b5a8:3e78:6cfb:b14a]
X-ClientProxiedBy: AM6PR0102CA0002.eurprd01.prod.exchangelabs.com
 (2603:10a6:209:14::15) To DB6PR1001MB1432.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:4:b6::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df461314-9192-4c25-9760-08d5f144165f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR1001MB1432;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR1001MB1432;3:6LjOEHD+fRukw11rkZh6VaB+F4+nVp/J2bfpHxRuy83NiBMBttF0hVCvX/4y9kHUe7Gmc93BBG7xlQ7NYfahCBvIUq6HPdRYO+wNmqrQNk2d8mrWlpLwSB+etomEsrvj4j45+pPhiGvc2tLwF789HVfazudy5COVEsPM33NN9eqKJk/UXSxz34pUUXcPAC1xv2kun0TwkaL8lzg9HdvwrEWqne+cRs+UVwNDts7kbKoQBkYeNLR24BymPEiB5e1O;25:meG8Ns15EKtPe0eno8UbV2dR8AsL4O+blkObSFE6JGHo+UqtPpWx2H24gOdnYnK9oimw+a9mH9I/x6JeqHTbumI5U2W8lGTjkBkNEKaM6SBMH0o8hziGINkT5D0KTm0fJa0CoJZMtiwya0cB/1p4olGhqBgpQ+sD49Xh4z69sP3EuWe6WtvNgisP0OcYuV8ejPJman0dqhpKEzzhzRMO4lVDadyMT2w833d8xmyzX1yaSfUGmuowLO+BLX00WM1mNp9ngN8R8wNL9l/elFpFbDaZGoyVhk78J+qhy8w2/Aiqoyekg6mfBAdwwmFAwbbv3Dh7RSYNJDkKZDnJXlvs2Q==;31:q2+fppGMsdrapdB4NN4GVCoNfByM4DA7sITr9imxgIREjBWMF4+q2LOC66OhmlKdOgg3kDNCxmy2ARBMaZm06lz5JM5d//vzztM8TDCVzKAnxU5XHIDiRbGgF5aHgueISgPKNjT54hv4BTpslY4Ka/rCBls3xtfmm5E4WqqnvgRQvYdOHjHFXgWULmGvbxfa8iSljZcTPXrZy88fcXoKjNnt0RH/O6F5ByE+d//7maE=
X-MS-TrafficTypeDiagnostic: DB6PR1001MB1432:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Flatz@localsearch.ch; 
X-Microsoft-Exchange-Diagnostics: 1;DB6PR1001MB1432;20:59f5N/jEKCA4kOxPAJvQ3pHWZAN+lY5wNGeSSAdV1wi3zDWUJ70Z2Wmpjqy6Cb0Kzi8x/vKydWlEROpcqggoLWQjGHy2AiFDS1aKFX3XlpOQLtM4N61m4LSEOsLMJ8szaNrVV/6ulXKoA5To6kGtEqqJmkgxPp87CjCBiTNevJabMvGlCV95EEH/cgjOvjOKs0GftDI9RaELdk0Arz0XcyXrJO//ISJDAED7tabhWp5knhd56eFFmWeZzDMKF29r1ZSp1Sc3IhNplkxrsAPHeS9aJN4qhFdADDiaYIN2wHaBWC93eVuYykCnwplZI13ShcNCs+rXQvR+wufubGEPjA==;4:EQzHXHK+8R2qwjSfyRrveGj7NLQd/kkK31oEU1NFQQ4FHoy61UXxo9N25WXq8NQHLyBtDtgkA4xyki3+bQoOJpzh4juYayZqHYFKTd3RuGVScPZJgCgAK7jkl3+YdQKaQiqEBWlNQJwxzEw5I+Ynhdpm+biON9XnSz3YLq6D28cHGlus68VKOKFwJ4ddzQXSVOG1L7xiiL4gXc47Pdwwojn1El34OtgelgcGDMgOiAq/ll+Sywc4c6hu2krRjqzrc+1f4tew1etCH8dg8abY2w==
X-Microsoft-Antispam-PRVS: <DB6PR1001MB1432C4B9C50B1A6B38077E6389550@DB6PR1001MB1432.EURPRD10.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(10201501046)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR1001MB1432;BCL:0;PCL:0;RULEID:;SRVR:DB6PR1001MB1432;
X-Forefront-PRVS: 0743E8D0A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(376002)(396003)(39850400004)(189003)(199004)(4326008)(486006)(67846002)(476003)(50466002)(46003)(186003)(16526019)(42882007)(33716001)(16586007)(74482002)(53946003)(6496006)(52396003)(25786009)(52116002)(105586002)(55016002)(72206003)(33896004)(386003)(9686003)(316002)(2906002)(45080400002)(68736007)(23726003)(6916009)(478600001)(5660300001)(6116002)(8936002)(81156014)(7736002)(81166006)(8676002)(47776003)(305945005)(1076002)(97736004)(106356001)(53936002)(473944003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR1001MB1432;H:cinnamonbun;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: localsearch.ch does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR1001MB1432;23:eRkhYnqq2a4FTjoJQZLigCW/8MoDZcPevuUpg+4?=
 =?us-ascii?Q?SKeBDSloo2sfDyLMdDtPNYl2tiE15wRgNFmgunTiUPeYiy3ScDV5BVm5odtU?=
 =?us-ascii?Q?eOZ4g9JeC86SneRW8pTUYTx2bE/dZWijh8azTz1i6YxY/pCYaTGZMnYwc8Ni?=
 =?us-ascii?Q?we7i8fmVlZyHzER/8rCm6JaARavJSNJHWaD8b3ZqqrsE9B5Rh59TpMaIJSyp?=
 =?us-ascii?Q?tw3ZubZ816mG/jxxDGVpQ6rJEYM4a9d795OiwYV0v23cjOCBgrN/CXkizNxZ?=
 =?us-ascii?Q?qquzWFTvW/dSC52CpWzeaM+JbLM33592DREcD+S/albH5sTEdsPB/pTbEHLq?=
 =?us-ascii?Q?V9jySQMsE9epEXMlFd4CNyGE6H0u44Rv394ua0NzCJJImOKHt6/IXcPmnVMP?=
 =?us-ascii?Q?ZRzYRf/EkLpRDbkoP2ldS9FWjOS/bT7Mqu9zbKgLeWxYNcz42xx0i8oJlWWn?=
 =?us-ascii?Q?Er3XT3nLx71EPRIV3T3flnYPicIJif5Yo9ZRRDZhGqkFrXytnOxhrsjI3sle?=
 =?us-ascii?Q?gEW/pPO0IgEBGlTN8rNynuzWcCw+9Jv98FscdemkUPBXCMhpH3umxi/4jWYo?=
 =?us-ascii?Q?9ssROVvOVmuUJ78w5Zr3TKXHm16RrV7KRdkN8JJCWt/U3tgFb036OCtwG65M?=
 =?us-ascii?Q?ZQB/HLp9GwHYGRKQwrdI/UTw8oGVwYEJ5LU1LeJC7y0yVsoEmuqtu/JY6tkq?=
 =?us-ascii?Q?zO3LOv3YTbgz0SUK0q5zmEBOTAozclQP5WIY00wdJbF1AV9P9Q8VSx4q/pmd?=
 =?us-ascii?Q?Av6tO7Qkd/wdujN/lYC0JADIqCCWuk+HA1p3b+ffKoXdSGApxwsmcOJX64OX?=
 =?us-ascii?Q?fTHz9nIa5VZ2fNKbko+BDO8vAAShIfJbp00gMiifiGBMBJ8fYjR2L66KViFV?=
 =?us-ascii?Q?otnNI99PrDdBtou52J3UCbiIFdE3ZT7Vr8M2d8QuLxDjw33s7MKSb3NcB/43?=
 =?us-ascii?Q?DgsW7eUsHT0uJLl+T4OnOadX9NqWhxcThrTYM/8dbEDj2jkJrLQryJMOcu5+?=
 =?us-ascii?Q?Qmn6UFWlGw+yP+W4CgzDd+78I8E1wu5ymnUNFG6JSVkzNxCFHE/y1F+mEM0/?=
 =?us-ascii?Q?FkpGpxaP6hlZJybHw7AvkuFKTBEtS1wvGDl83yTOPj7ROTdTGVZ7All1M54+?=
 =?us-ascii?Q?IRvMuGn0MB+0c/wNz4RWCqxv3G2JePJS44J6qWVxcHcy0BYcuvbkExlRROGP?=
 =?us-ascii?Q?9jS/6RK/CYjdLh20=3D?=
X-Microsoft-Antispam-Message-Info: e4wyMj/0HYwSDQ3Cp3CHShjE/NWb+iRHEkoMnwRVMVkn4z2GnCau79SCxw2gtzd2/HpGuz8ONmFh/Q5EmRyMzkEMiEjp2bXVlptESY/KCYTX451jFMJFScAvksQ7b1ViYgyg3d7Tlq7fBmnr5gk8N0qLnHCHRIclsXgb8EeYtfvOCwDaFui2YA9LAXr4rOo4bdYogzHcG1vKuHoT/+PZ/kH4jcJnTIURxESVKmP0bBkc0lX0rHqWLyya1yADg8hgDs91rmsEMm9WE2+o3o22lD4pVJFwCWRVvV8fbtgILRVjrsnouXYamzrzlu/a3yG7Ept/Nv8wI+Z7QXyJ0FTrmyWAiTUzOIlsBC+kMhxoFwo=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR1001MB1432;6:ZG8WsGzMzUoG8fY1Y5TbM1M+l6jv5UDzGVcuEPZRTr7C95+b2r6jGcorFKX6x/ZJ+Mj/5DluSAX0emPrsaURLzYvHccOAEhZs4WURrGmdvEDpvv64CpilUqaCQzBuGWLv0/tmlL1UdNy2TVk72KaWCLc5kHSa3NwuYUmZs6VSyx9XXZz7sHYGGWRnsuummuLW61hqHyUfnekxIi0sjtqAsfw47BoWjJBFMXe2NIzihOE+UtrMW/fXJpg5FTAqbpiGpUfSC/ixvGxOMr5nSWx6SBkGQ935fxRPqhmvTzSy7uHAc+WO6IbHzVmPuJbT0OqvKEN2FVFZYHHq3Q7d1NZbF7wosOy+06IKWq+hM8qwcO5+wSZV7B1ju4pqaDierQNLvb1AbfxU7SKbcuCy0ZRJPgF14bR1FlhpRHO5tDeZOZfwp9S/XZMwBQP+mMs8J3hhGvi0rWNvzR6nkQPKQdoEA==;5:/erZQKr3TpbmyE8K1WPXP2rstVXQpgz3C5VSf95GoJihQkLKd1Anwz854mdmRZzacdUsJBCubaTqurK+MFJGc3l2+TT4K3QBbn9YhKaNTObS1gCzC5qLfQQyiGSaCWeMt8AX10BO3i/kt4HaIeCZ4tVGq9+6yi8wMEEFKPKyQ3M=;7:5X9kmOVMYdHt2gRW6O9WZnZexLhRY+JdacseolyOhtvgKOyBUmULkTmOBf2AUsuZROm0GNDnIDOX95IgTaYze6T/eXrSjEhd+vFABzgahd0zUG24fqhTzj8nC/k/rPpeLaWCJ7OFdK4H4CPnnLu8mxo6a2vVmVYetScQ/PX5IWoW2UV4cZOpsdH9xWQr3c0Dt0iZKI81oHVN87AEn991mcjl7FXwNnP+yBgT3P5o00ZuhygMWYo8N8AaCprwxgHj
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: search.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 09:01:47.6815 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df461314-9192-4c25-9760-08d5f144165f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 23f54583-ad1a-443d-b243-76ab3c13ca75
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1432
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

We experience soft lockups with our workload on every tested 4.17.y 
kernel. I unfortunately don't know wether there are 4.17 kernels without 
the bug but 4.16 kernels are fine and don't show this behaviour.

Known versions with lockup:
4.17.4, 4.17.8, 4.17.9

Latest known versions without lockup: 4.16.12

I managed to compile vanilla 4.17.9 with the default config from 
opensuse and get a kernel dump from the lockup.  It looks like I might 
be able to trigger the crash more or less consistently in about 24 hours 
when I produce load on this machine.

Workload is elasticsearch + php + apache.

Here's dmesg output from the lockup:
#v+
[ 9984.422467] watchdog: BUG: soft lockup - CPU#11 stuck for 22s! [migration/11:79]
[ 9984.422477] Modules linked in: nfsv3(E) nfs_acl(E) rpcsec_gss_krb5(E) auth_rpcgss(E) nfsv4(E) dns_resolver(E) nfs(E) lockd(E) grace(E) sunrpc(E) fscache(E) af_packet(E) iscsi_ibft(E) iscsi_boot_sysfs(E) msr(E) nls_iso8859_1(E) nls_cp437(E) vfat(E) fat(E) intel_rapl(E) sb_edac(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) mgag200(E) coretemp(E) ttm(E) kvm_intel(E) kvm(E) drm_kms_helper(E) irqbypass(E) ipmi_ssif(E) tg3(E) crct10dif_pclmul(E) drm(E) crc32_pclmul(E) ipmi_si(E) libphy(E) ghash_clmulni_intel(E) pcbc(E) mei_me(E) ptp(E) fb_sys_fops(E) aesni_intel(E) syscopyarea(E) ipmi_devintf(E) sysfillrect(E) iTCO_wdt(E) iTCO_vendor_support(E) ipmi_msghandler(E) sysimgblt(E) i2c_algo_bit(E) pps_core(E) aes_x86_64(E) dcdbas(E) lpc_ich(E) crypto_simd(E) mei(E) joydev(E) shpchp(E) pcspkr(E) cryptd(E) wmi(E)
[ 9984.422515]  glue_helper(E) button(E) raid456(E) libcrc32c(E) async_raid6_recov(E) async_memcpy(E) async_pq(E) async_xor(E) xor(E) async_tx(E) hid_generic(E) usbhid(E) raid6_pq(E) raid1(E) md_mod(E) crc32c_intel(E) ehci_pci(E) ehci_hcd(E) usbcore(E) megaraid_sas(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) efivarfs(E)
[ 9984.422543] CPU: 11 PID: 79 Comm: migration/11 Kdump: loaded Tainted: G            E     4.17.9-1-default #1
[ 9984.422544] Hardware name: Dell Inc. PowerEdge R420/0CN7CM, BIOS 2.4.2 01/29/2015
[ 9984.422549] RIP: 0010:multi_cpu_stop+0x49/0x110
[ 9984.422550] RSP: 0000:ffffa8bd06653e78 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
[ 9984.422552] RAX: ffffffffa8c141c0 RBX: 0000000000000001 RCX: ffff94bc4ab5d850
[ 9984.422553] RDX: ffff94bc4ab5d850 RSI: 0000000000000286 RDI: ffffa8bd08fcbbb8
[ 9984.422554] RBP: ffffa8bd08fcbbb8 R08: 0000000000000001 R09: 0000000000022780
[ 9984.422554] R10: 0000000000000001 R11: 0000000000000399 R12: ffffa8bd08fcbbdc
[ 9984.422555] R13: 0000000000000001 R14: 0000000000000000 R15: ffffa8bd08fcbb00
[ 9984.422557] FS:  0000000000000000(0000) GS:ffff94bc4ab40000(0000) knlGS:0000000000000000
[ 9984.422558] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 9984.422559] CR2: 00007f4f501ce2d0 CR3: 0000000b5c00a002 CR4: 00000000000606e0
[ 9984.422560] Call Trace:
[ 9984.422565]  ? cpu_stop_park+0x30/0x30
[ 9984.422567]  cpu_stopper_thread+0x6f/0xf0
[ 9984.422571]  ? sort_range+0x20/0x20
[ 9984.422572]  smpboot_thread_fn+0xf1/0x1e0
[ 9984.422574]  kthread+0x112/0x130
[ 9984.422576]  ? kthread_create_worker_on_cpu+0x40/0x40
[ 9984.422579]  ret_from_fork+0x3a/0x50
[ 9984.422581] Code: 58 66 66 90 66 90 48 89 04 24 48 8b 47 18 48 85 c0 0f 84 b9 00 00 00 89 db 48 0f a3 18 41 0f 92 c7 4c 8d 65 24 45 31 f6 45 31 ed <f3> 90 8b 5d 20 44 39 eb 74 3f 83 fb 02 74 4c 83 fb 03 75 15 45 
[ 9984.422608] Kernel panic - not syncing: softlockup: hung tasks
[ 9984.422612] CPU: 11 PID: 79 Comm: migration/11 Kdump: loaded Tainted: G            EL    4.17.9-1-default #1
[ 9984.422615] Hardware name: Dell Inc. PowerEdge R420/0CN7CM, BIOS 2.4.2 01/29/2015
[ 9984.422617] Call Trace:
[ 9984.422620]  <IRQ>
[ 9984.422625]  dump_stack+0x85/0xc0
[ 9984.422630]  panic+0xdc/0x241
[ 9984.422635]  watchdog_timer_fn.cold.4+0x8d/0xae
[ 9984.422638]  ? watchdog+0x30/0x30
[ 9984.422642]  __hrtimer_run_queues+0xf0/0x2a0
[ 9984.422646]  hrtimer_interrupt+0x100/0x220
[ 9984.422651]  smp_apic_timer_interrupt+0x62/0x150
[ 9984.422656]  apic_timer_interrupt+0xf/0x20
[ 9984.422659]  </IRQ>
[ 9984.422662] RIP: 0010:multi_cpu_stop+0x49/0x110
[ 9984.422664] RSP: 0000:ffffa8bd06653e78 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
[ 9984.422668] RAX: ffffffffa8c141c0 RBX: 0000000000000001 RCX: ffff94bc4ab5d850
[ 9984.422670] RDX: ffff94bc4ab5d850 RSI: 0000000000000286 RDI: ffffa8bd08fcbbb8
[ 9984.422673] RBP: ffffa8bd08fcbbb8 R08: 0000000000000001 R09: 0000000000022780
[ 9984.422676] R10: 0000000000000001 R11: 0000000000000399 R12: ffffa8bd08fcbbdc
[ 9984.422679] R13: 0000000000000001 R14: 0000000000000000 R15: ffffa8bd08fcbb00
[ 9984.422684]  ? cpu_stop_park+0x30/0x30
[ 9984.422687]  cpu_stopper_thread+0x6f/0xf0
[ 9984.422690]  ? sort_range+0x20/0x20
[ 9984.422694]  smpboot_thread_fn+0xf1/0x1e0
[ 9984.422696]  kthread+0x112/0x130
[ 9984.422699]  ? kthread_create_worker_on_cpu+0x40/0x40
[ 9984.422703]  ret_from_fork+0x3a/0x50
#v-

Software:
Linux inlopp 4.17.9-1-default #1 SMP PREEMPT Mon Jul 23 15:50:05 CEST 2018 x86_64 x86_64 x86_64 GNU/Linux

GNU Make            	4.2.1
Binutils            	2.30.0.20180320
Util-linux          	2.31.1
Mount               	2.31.1
Module-init-tools   	25
E2fsprogs           	1.44.2
Xfsprogs            	4.15.1
PPP                 	2.4.7
Nfs-utils           	2.1.1
Linux C Library     	2.27
Dynamic linker (ldd)	2.27
Linux C++ Library   	6.0.25
Procps              	3.3.15
Net-tools           	2.10
Kbd                 	2.0.4
Console-tools       	2.0.4
Sh-utils            	8.30
Udev                	237
Wireless-tools      	30

/proc/cpuinfo:
#v+
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Xeon(R) CPU E5-2470 0 @ 2.30GHz
stepping	: 7
microcode	: 0x714
cpu MHz		: 1199.728
cache size	: 20480 KB
physical id	: 0
siblings	: 16
core id		: 0
cpu cores	: 8
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass
bogomips	: 4600.07
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Xeon(R) CPU E5-2470 0 @ 2.30GHz
stepping	: 7
microcode	: 0x714
cpu MHz		: 1738.137
cache size	: 20480 KB
physical id	: 1
siblings	: 16
core id		: 0
cpu cores	: 8
apicid		: 32
initial apicid	: 32
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass
bogomips	: 4609.35
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Xeon(R) CPU E5-2470 0 @ 2.30GHz
stepping	: 7
microcode	: 0x714
cpu MHz		: 1199.663
cache size	: 20480 KB
physical id	: 0
siblings	: 16
core id		: 1
cpu cores	: 8
apicid		: 2
initial apicid	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass
bogomips	: 4600.07
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Xeon(R) CPU E5-2470 0 @ 2.30GHz
stepping	: 7
microcode	: 0x714
cpu MHz		: 3098.979
cache size	: 20480 KB
physical id	: 1
siblings	: 16
core id		: 1
cpu cores	: 8
apicid		: 34
initial apicid	: 34
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass
bogomips	: 4609.35
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 4
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Xeon(R) CPU E5-2470 0 @ 2.30GHz
stepping	: 7
microcode	: 0x714
cpu MHz		: 1964.906
cache size	: 20480 KB
physical id	: 0
siblings	: 16
core id		: 2
cpu cores	: 8
apicid		: 4
initial apicid	: 4
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass
bogomips	: 4600.07
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 5
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Xeon(R) CPU E5-2470 0 @ 2.30GHz
stepping	: 7
microcode	: 0x714
cpu MHz		: 2868.466
cache size	: 20480 KB
physical id	: 1
siblings	: 16
core id		: 2
cpu cores	: 8
apicid		: 36
initial apicid	: 36
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass
bogomips	: 4609.35
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 6
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Xeon(R) CPU E5-2470 0 @ 2.30GHz
stepping	: 7
microcode	: 0x714
cpu MHz		: 1962.682
cache size	: 20480 KB
physical id	: 0
siblings	: 16
core id		: 3
cpu cores	: 8
apicid		: 6
initial apicid	: 6
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass
bogomips	: 4600.07
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 7
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Xeon(R) CPU E5-2470 0 @ 2.30GHz
stepping	: 7
microcode	: 0x714
cpu MHz		: 3012.649
cache size	: 20480 KB
physical id	: 1
siblings	: 16
core id		: 3
cpu cores	: 8
apicid		: 38
initial apicid	: 38
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass
bogomips	: 4609.35
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 8
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Xeon(R) CPU E5-2470 0 @ 2.30GHz
stepping	: 7
microcode	: 0x714
cpu MHz		: 1200.154
cache size	: 20480 KB
physical id	: 0
siblings	: 16
core id		: 4
cpu cores	: 8
apicid		: 8
initial apicid	: 8
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass
bogomips	: 4600.07
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 9
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Xeon(R) CPU E5-2470 0 @ 2.30GHz
stepping	: 7
microcode	: 0x714
cpu MHz		: 3058.737
cache size	: 20480 KB
physical id	: 1
siblings	: 16
core id		: 4
cpu cores	: 8
apicid		: 40
initial apicid	: 40
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass
bogomips	: 4609.35
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 10
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Xeon(R) CPU E5-2470 0 @ 2.30GHz
stepping	: 7
microcode	: 0x714
cpu MHz		: 1962.831
cache size	: 20480 KB
physical id	: 0
siblings	: 16
core id		: 5
cpu cores	: 8
apicid		: 10
initial apicid	: 10
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass
bogomips	: 4600.07
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 11
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Xeon(R) CPU E5-2470 0 @ 2.30GHz
stepping	: 7
microcode	: 0x714
cpu MHz		: 2122.119
cache size	: 20480 KB
physical id	: 1
siblings	: 16
core id		: 5
cpu cores	: 8
apicid		: 42
initial apicid	: 42
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass
bogomips	: 4609.35
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 12
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Xeon(R) CPU E5-2470 0 @ 2.30GHz
stepping	: 7
microcode	: 0x714
cpu MHz		: 1199.905
cache size	: 20480 KB
physical id	: 0
siblings	: 16
core id		: 6
cpu cores	: 8
apicid		: 12
initial apicid	: 12
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass
bogomips	: 4600.07
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 13
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Xeon(R) CPU E5-2470 0 @ 2.30GHz
stepping	: 7
microcode	: 0x714
cpu MHz		: 2997.811
cache size	: 20480 KB
physical id	: 1
siblings	: 16
core id		: 6
cpu cores	: 8
apicid		: 44
initial apicid	: 44
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass
bogomips	: 4609.35
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 14
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Xeon(R) CPU E5-2470 0 @ 2.30GHz
stepping	: 7
microcode	: 0x714
cpu MHz		: 1952.093
cache size	: 20480 KB
physical id	: 0
siblings	: 16
core id		: 7
cpu cores	: 8
apicid		: 14
initial apicid	: 14
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass
bogomips	: 4600.07
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 15
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Xeon(R) CPU E5-2470 0 @ 2.30GHz
stepping	: 7
microcode	: 0x714
cpu MHz		: 3065.470
cache size	: 20480 KB
physical id	: 1
siblings	: 16
core id		: 7
cpu cores	: 8
apicid		: 46
initial apicid	: 46
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass
bogomips	: 4609.35
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 16
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Xeon(R) CPU E5-2470 0 @ 2.30GHz
stepping	: 7
microcode	: 0x714
cpu MHz		: 1200.157
cache size	: 20480 KB
physical id	: 0
siblings	: 16
core id		: 0
cpu cores	: 8
apicid		: 1
initial apicid	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass
bogomips	: 4600.07
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 17
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Xeon(R) CPU E5-2470 0 @ 2.30GHz
stepping	: 7
microcode	: 0x714
cpu MHz		: 2991.382
cache size	: 20480 KB
physical id	: 1
siblings	: 16
core id		: 0
cpu cores	: 8
apicid		: 33
initial apicid	: 33
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass
bogomips	: 4609.35
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 18
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Xeon(R) CPU E5-2470 0 @ 2.30GHz
stepping	: 7
microcode	: 0x714
cpu MHz		: 1963.981
cache size	: 20480 KB
physical id	: 0
siblings	: 16
core id		: 1
cpu cores	: 8
apicid		: 3
initial apicid	: 3
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass
bogomips	: 4600.07
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 19
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Xeon(R) CPU E5-2470 0 @ 2.30GHz
stepping	: 7
microcode	: 0x714
cpu MHz		: 3100.262
cache size	: 20480 KB
physical id	: 1
siblings	: 16
core id		: 1
cpu cores	: 8
apicid		: 35
initial apicid	: 35
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass
bogomips	: 4609.35
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 20
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Xeon(R) CPU E5-2470 0 @ 2.30GHz
stepping	: 7
microcode	: 0x714
cpu MHz		: 1200.200
cache size	: 20480 KB
physical id	: 0
siblings	: 16
core id		: 2
cpu cores	: 8
apicid		: 5
initial apicid	: 5
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass
bogomips	: 4600.07
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 21
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Xeon(R) CPU E5-2470 0 @ 2.30GHz
stepping	: 7
microcode	: 0x714
cpu MHz		: 3095.427
cache size	: 20480 KB
physical id	: 1
siblings	: 16
core id		: 2
cpu cores	: 8
apicid		: 37
initial apicid	: 37
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass
bogomips	: 4609.35
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 22
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Xeon(R) CPU E5-2470 0 @ 2.30GHz
stepping	: 7
microcode	: 0x714
cpu MHz		: 1200.044
cache size	: 20480 KB
physical id	: 0
siblings	: 16
core id		: 3
cpu cores	: 8
apicid		: 7
initial apicid	: 7
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass
bogomips	: 4600.07
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 23
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Xeon(R) CPU E5-2470 0 @ 2.30GHz
stepping	: 7
microcode	: 0x714
cpu MHz		: 3066.873
cache size	: 20480 KB
physical id	: 1
siblings	: 16
core id		: 3
cpu cores	: 8
apicid		: 39
initial apicid	: 39
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass
bogomips	: 4609.35
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 24
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Xeon(R) CPU E5-2470 0 @ 2.30GHz
stepping	: 7
microcode	: 0x714
cpu MHz		: 1937.001
cache size	: 20480 KB
physical id	: 0
siblings	: 16
core id		: 4
cpu cores	: 8
apicid		: 9
initial apicid	: 9
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass
bogomips	: 4600.07
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 25
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Xeon(R) CPU E5-2470 0 @ 2.30GHz
stepping	: 7
microcode	: 0x714
cpu MHz		: 3063.036
cache size	: 20480 KB
physical id	: 1
siblings	: 16
core id		: 4
cpu cores	: 8
apicid		: 41
initial apicid	: 41
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass
bogomips	: 4609.35
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 26
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Xeon(R) CPU E5-2470 0 @ 2.30GHz
stepping	: 7
microcode	: 0x714
cpu MHz		: 1200.175
cache size	: 20480 KB
physical id	: 0
siblings	: 16
core id		: 5
cpu cores	: 8
apicid		: 11
initial apicid	: 11
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass
bogomips	: 4600.07
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 27
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Xeon(R) CPU E5-2470 0 @ 2.30GHz
stepping	: 7
microcode	: 0x714
cpu MHz		: 2008.811
cache size	: 20480 KB
physical id	: 1
siblings	: 16
core id		: 5
cpu cores	: 8
apicid		: 43
initial apicid	: 43
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass
bogomips	: 4609.35
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 28
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Xeon(R) CPU E5-2470 0 @ 2.30GHz
stepping	: 7
microcode	: 0x714
cpu MHz		: 1949.888
cache size	: 20480 KB
physical id	: 0
siblings	: 16
core id		: 6
cpu cores	: 8
apicid		: 13
initial apicid	: 13
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass
bogomips	: 4600.07
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 29
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Xeon(R) CPU E5-2470 0 @ 2.30GHz
stepping	: 7
microcode	: 0x714
cpu MHz		: 2055.774
cache size	: 20480 KB
physical id	: 1
siblings	: 16
core id		: 6
cpu cores	: 8
apicid		: 45
initial apicid	: 45
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass
bogomips	: 4609.35
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 30
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Xeon(R) CPU E5-2470 0 @ 2.30GHz
stepping	: 7
microcode	: 0x714
cpu MHz		: 1200.040
cache size	: 20480 KB
physical id	: 0
siblings	: 16
core id		: 7
cpu cores	: 8
apicid		: 15
initial apicid	: 15
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass
bogomips	: 4600.07
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 31
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Xeon(R) CPU E5-2470 0 @ 2.30GHz
stepping	: 7
microcode	: 0x714
cpu MHz		: 1832.669
cache size	: 20480 KB
physical id	: 1
siblings	: 16
core id		: 7
cpu cores	: 8
apicid		: 47
initial apicid	: 47
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass
bogomips	: 4609.35
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:
#v-

Please tell me if we can provide more info or try something or if we 
could help by providing you with the mcore file.

Best wishes,

David Flatz
-- 
Software Engineer, search.ch
