Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666EEC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7702081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="krkWxwwv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E7702081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbeKJAT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 19:19:26 -0500
Received: from mail-eopbgr680083.outbound.protection.outlook.com ([40.107.68.83]:34174
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727793AbeKJATZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 19:19:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amtkeFhGg9nnNYULCZUOaBjm+k57H6KhgnAQOPkKX48=;
 b=krkWxwwvEc5x+sprPv2TQxwl3X45avzk4OCL4e7z5dhmtRx/aPH++rPFePSMUOICMEygoFPNIcI9tVsWQIPLz+LX97kvpjcE0rGitbJRz8IKFS8t/J8Sp8HLZDJhsVZ5RTFCuHPrHqRtaVRcTGmFpihqaN6PQCbyT1RFVyp5BKc=
Received: from BYAPR07MB4599.namprd07.prod.outlook.com (52.135.204.25) by
 BYAPR07MB5750.namprd07.prod.outlook.com (20.178.0.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.28; Fri, 9 Nov 2018 14:37:51 +0000
Received: from BYAPR07MB4599.namprd07.prod.outlook.com
 ([fe80::1513:e267:a343:917]) by BYAPR07MB4599.namprd07.prod.outlook.com
 ([fe80::1513:e267:a343:917%5]) with mapi id 15.20.1294.034; Fri, 9 Nov 2018
 14:37:51 +0000
From:   Jan Glauber <Jan.Glauber@cavium.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>
Subject: dcache_readdir NULL inode oops
Thread-Topic: dcache_readdir NULL inode oops
Thread-Index: AQHUeDnKfcShvdBH+0+6hZ8Ik/l9/A==
Date:   Fri, 9 Nov 2018 14:37:51 +0000
Message-ID: <20181109143744.GA12128@hc>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0601CA0035.eurprd06.prod.outlook.com
 (2603:10a6:203:68::21) To BYAPR07MB4599.namprd07.prod.outlook.com
 (2603:10b6:a02:f2::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jan.Glauber@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [109.42.0.71]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5750;6:Efp33b8O8+p6nY8o6E5x0+YVBFKMRThqPjLb+xVnlWJNKU9++EMwEIHiqqX+Lj/aH5+Efu2I/A7HEmgK5up2N4txjr5iKssvpHRVjSvPtJ5wyQXCQh1PH+IxocDIaEytPyvt2kgmv3au1oKishNG+NHIS8/GMBpBjXWEw+HIRewKjS0KYK/S2NpYHNRxXH8xR9semB83kXVD/QWKIIv3FC2H6Lug7dCaZnNgfvmv5rS9MhCVkq3kh5l/DRn6YUN6vqK2Enn1fK48NFskGlFvZPaLfTNWbIr1nRl0HjcsQ/yX17tERhI7p7nkCBaujLuwo0P4kRSLcy0XQWSER5+G6zw9/zXQx4H6KWA9b9SXzkTpGj+APwof6UooO5+fRxaHYh002zVMlToE5kE8lVlVdTLcROOxfjs3DZrUg8wqsvJ5e6mTsMGApDXgQpOhUw39gO8HWpLrOt0jRbIRUzJ6rQ==;5:ANxgWLDZGpv/YzNDakGEnnflE5UADP8CuZWNlVVh5a1RrVlSx4IE4kQ9TvSNEDkSjzcTABOSZ6O1JxQ787cHvtQngQJgROzXoX8SLALKoO/KIvzwR8oK7UpQZrpN6xk6tVFGPEr8TowHnq9TIOHZpD5a+zgmd+cfZMVc4z6rCAQ=;7:jalij75UWZiafeOeA5lGPTyP41Z0T04xS8oqwcdbYPVFTMERVQ7kuLW5ER7LZTM4oXqXvqNptU4CGO/W/m0ocd2IXJJ+orEf3tJbvSPDBY/GZZFXvy+Oa/d1+EWCKdWyg7ImGbqpN5oOnzo/gCZmuQ==
x-ms-office365-filtering-correlation-id: 13f3af0b-7161-4214-8a43-08d64650ece5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5750;
x-ms-traffictypediagnostic: BYAPR07MB5750:
x-microsoft-antispam-prvs: <BYAPR07MB57504290C2177B8AEAFE001391C60@BYAPR07MB5750.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB5750;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5750;
x-forefront-prvs: 08512C5403
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(136003)(376002)(346002)(39860400002)(396003)(366004)(199004)(189003)(68736007)(106356001)(33716001)(66066001)(97736004)(8676002)(81166006)(8936002)(105586002)(81156014)(256004)(14444005)(2906002)(14454004)(5660300001)(72206003)(6916009)(478600001)(102836004)(386003)(6506007)(186003)(26005)(486006)(52116002)(44832011)(476003)(33896004)(99286004)(33656002)(2900100001)(6512007)(9686003)(4326008)(45080400002)(25786009)(1076002)(7736002)(6116002)(3846002)(6436002)(305945005)(6486002)(54906003)(71200400001)(71190400001)(53936002)(575784001)(316002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5750;H:BYAPR07MB4599.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7vpt4jiPSwaN+2ogHn8nImaCQ+/Mi8dUxhSdp7uUpub6ZcnmoGDog3C1cGHQUxAMmZoD3lkBAHKL7/gBrgB5Y8x25VWIL01/xF2qp33/X98f3+F6YLuTbdFPZyRQ6PxyMGTiSIK/xXe3zeAlZfZ9StZWARxv/oBClK6kPS0FzCcYsCiTm/gky2y5AF4j3jibYNJ4+aaMRBs9Z3PpHJiTP6a96/Fu1aca04Yi+OexkkFQNkJTqtcCt+nHH5krSYEbokN7HENQr3XV2OHMXWoTJfeoDjVowUeKj50n/0aWcJKlx4HbREIXMgo23vCJg7p6T/p2rlII9mbJOXTvCz1WnPsAZ8/RqAuo32SrPRCW+po=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D1F0B9718DD93E47A381D0B3EB00A962@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f3af0b-7161-4214-8a43-08d64650ece5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2018 14:37:51.0331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5750
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

I'm seeing the following oops reproducible with upstream kernel on arm64 (T=
hunderX2):

[ 5428.795719] Unable to handle kernel NULL pointer dereference at virtual =
address 0000000000000040
[ 5428.813838] Mem abort info:
[ 5428.820721]   ESR =3D 0x96000006
[ 5428.828476]   Exception class =3D DABT (current EL), IL =3D 32 bits
[ 5428.841590]   SET =3D 0, FnV =3D 0
[ 5428.848939]   EA =3D 0, S1PTW =3D 0
[ 5428.855941] Data abort info:
[ 5428.862422]   ISV =3D 0, ISS =3D 0x00000006
[ 5428.870787]   CM =3D 0, WnR =3D 0
[ 5428.877359] user pgtable: 4k pages, 48-bit VAs, pgdp =3D 0000000052f9e03=
4
[ 5428.891098] [0000000000000040] pgd=3D0000007ebb0d6003, pud=3D0000007ed30=
73003, pmd=3D0000000000000000
[ 5428.909251] Internal error: Oops: 96000006 [#1] SMP
[ 5428.919122] Modules linked in: xt_conntrack nf_conntrack nf_defrag_ipv6 =
nf_defrag_ipv4 ipt_REJECT nf_reject_ipv4 xt_tcpudp bridge stp llc ip6table_=
filter ip6_tables iptable_filter ipmi_ssif ip_tables x_tables ipv6 crc32_ce=
 bnx2x crct10dif_ce igb nvme nvme_core i2c_algo_bit mdio gpio_xlp i2c_xlp9x=
x
[ 5428.972724] CPU: 45 PID: 220018 Comm: stress-ng-dev Not tainted 4.19.0-j=
ang+ #45
[ 5428.987664] Hardware name: To be filled by O.E.M. Saber/To be filled by =
O.E.M., BIOS 0ACKL018 03/30/2018
[ 5429.006819] pstate: 60400009 (nZCv daif +PAN -UAO)
[ 5429.016567] pc : dcache_readdir+0xfc/0x1a8
[ 5429.024903] lr : dcache_readdir+0x134/0x1a8
[ 5429.033376] sp : ffff00002d553d70
[ 5429.040101] x29: ffff00002d553d70 x28: ffff807db4988000
[ 5429.050892] x27: 0000000000000000 x26: 0000000000000000
[ 5429.061679] x25: 0000000056000000 x24: ffff8024577106c0
[ 5429.072457] x23: 0000000000000000 x22: ffff80267b92a480
[ 5429.083248] x21: ffff80267b92a520 x20: ffff8024575e5e00
[ 5429.094029] x19: ffff00002d553e40 x18: 0000000000000000
[ 5429.104805] x17: 0000000000000000 x16: 0000000000000000
[ 5429.115553] x15: 0000000000000000 x14: 0000000000000000
[ 5429.126332] x13: 0000000000000000 x12: 0000000000000000
[ 5429.137096] x11: 0000000000000000 x10: ffff80266b398228
[ 5429.147849] x9 : ffff80266b398000 x8 : 0000000000007e4e
[ 5429.158580] x7 : 0000000000000000 x6 : ffff00000830d190
[ 5429.169362] x5 : 0000000000000000 x4 : ffff00000d7506a8
[ 5429.180123] x3 : 0000000000000002 x2 : 0000000000000002
[ 5429.190890] x1 : ffff8024575e5e38 x0 : ffff00002d553e40
[ 5429.201715] Process stress-ng-dev (pid: 220018, stack limit =3D 0x000000=
009437ac28)
[ 5429.216828] Call trace:
[ 5429.221855]  dcache_readdir+0xfc/0x1a8
[ 5429.229459]  iterate_dir+0x8c/0x1a0
[ 5429.236561]  ksys_getdents64+0xa4/0x188
[ 5429.244357]  __arm64_sys_getdents64+0x28/0x38
[ 5429.253201]  el0_svc_handler+0x7c/0x100
[ 5429.260989]  el0_svc+0x8/0xc
[ 5429.266878] Code: a9429681 aa1303e0 b9402682 a9400e66 (f94020a4)
[ 5429.279192] ---[ end trace 5c1e28c07cf016c5 ]---

It happens after 1-3 hours of running 'stress-ng --dev 128'. This testcase =
does a scandir of /dev
and then calls random stuff like ioctl, lseek, open/close etc. on the entri=
es. I assume no files are
deleted under /dev during the testcase.

The NULL pointer is the inode pointer of next. The next dentry->d_flags is =
DCACHE_RCUACCESS
when this happens.

Any hints on how to further debug this?

--Jan
