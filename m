Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61859C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02376206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="o+E5bZmI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02376206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbeIDWOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 18:14:35 -0400
Received: from mail-eopbgr00070.outbound.protection.outlook.com ([40.107.0.70]:32200
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726437AbeIDWOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 18:14:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpg1fqhFzKmCN2xaIWoHVjT8ISI7+ZnGeLUhOHsVUIA=;
 b=o+E5bZmIVFqYJH7ymWLtBuQAOThjlD/ynQ62Ry0j7aPzKl79VPCnqM2V2VZLKurMjehb+/Zc/G41WLmHXv20CcYVz/q9M0YdhRpO0VR2o0PLwfF8TbAbjkYLOdkUkaFbfRK00OJRTJ+toYkGLTAjxiz4T/TcqFhL/Q2KoGncvs0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from mlx.ziepe.ca (174.3.196.123) by
 AM0PR05MB4449.eurprd05.prod.outlook.com (2603:10a6:208:5a::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.17; Tue, 4 Sep 2018 17:48:21 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@mellanox.com>)
        id 1fxFQu-0007gx-Hg; Tue, 04 Sep 2018 11:48:08 -0600
Date:   Tue, 4 Sep 2018 11:48:08 -0600
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Regression from patch 'tty: hvc: hvc_poll() break hv read loop'
Message-ID: <20180904174808.GS335@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: MWHPR1201CA0005.namprd12.prod.outlook.com
 (2603:10b6:301:4a::15) To AM0PR05MB4449.eurprd05.prod.outlook.com
 (2603:10a6:208:5a::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8314b7c6-02d3-4df4-989d-08d6128e9b31
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB4449;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4449;3:Z+TFqC/pnLA8oTA9aEar7XuUuZcVITUN+R8D8DISunmOsxnqeD3SrmzZhkO4cD5czOrlTiVYzg/W2ZuXERxH5GAVejb+YvEgP16GFzcTz6D2Yl2670qWLnSMrt/eJmEKLEXE+E84OZQRfsaTV57iFPkZ0SDALHX1OE5tuR8u3pPaWDahpKJ2Lq8btjJ+HX1jZj9XAN+hc46UnOuM+qVdTKESrKdoYZuBqnNMHAr44UEKRACUqV/N1S2xWo6kuXlh;25:sgil653c4czqaRcuvd3PHrrCjyFAovD2eke8G+qMHEzmOipm7Lwdp3rPl11lUAb2+VlIHHJq1YmUeIz8MV+zp4kXTJV51m/fWurdpluFhe0qlmyPrwKw1AMjLh08/0KEFsYatLqm8+eJGEXcokJpIhRsguND8q98Cz+6SP8agBVfNXoZSZ0Q+38PogaVuSQYOIm2boecGl7+oBcqAHbGfuFGb4fE1i3gEZ92BwIr7gO1xIwxUrDM4zNxD9Hm6c2OHwWundIZwPSBBqCCwFN4lBdcUvDEXPUc6skLEJ+pmUQAMzIyKgFqr4jy1NPMhGPM+dGGexHSK2J/jG6Enq6rNw==;31:Y5t7R1ti/ReIpNXIPgn2S2Y/HBFciFTI2B8sCEJaxO3EPqfggtSjG7mQWsQiLChS4L0H5kPlB9EHEj3F2FL22S8GlWIUnPvQuwei8q6unrW0O4Cgff90DFiICkyALXRisqjD0u+dwjZpqUOluLFk+IjrHQBih1gDhF5F7mH9l0zSUU9hvux3pX8MDIGRSGcnFWp1BrQ1Ctpfyq/EoXq4lRhx/HqTufWFtqI29LqSY2w=
X-MS-TrafficTypeDiagnostic: AM0PR05MB4449:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4449;20:5qWKOiRSQb21DF9Tzg6hgXXGuRIDmF9iqd173EuVzurswkHGZx8+u+tjNHoBIYSgLjCTj9RANoJLdKyCtrlKk9qV8VUgLHNH99V0iC9Ur209B/q6SBX61DRh6AUyfJqr7Q5MasYbVvfaq0RrZUT48KkSpbWGwXDbnlL2x6hfFyuO/3JLh78cLwZOjA0EQv3VVjOW/cIx8H8RLKwRpoykIMfGLkU4l4NaLMHxPPLTuRmOWm0MOZ03igmf4eNeJ1HuKKqSpHqgCJFIWMFy+0tkMOp2DxGKBFQo6vjHQetcbH3wYMAFZboO11VUG7ZKnitsBtVMN8dt/N+2FqxiivLQhvNHt5U5kMETSvZFTm/TqHlW30ThBEw7CxDYceWZ8C9LaPbJxBJ5m6YsuV3EF4xzkLKP4XlbMb3n9HzQ3Voz0Z7rPNM97QoAf+krfUzChD9HmAMPnUvkYv48wDUjRHqNkpgL/GHQbq/OhmKtPFJLtboPbIu2dWgzjw5oSfthKoyU;4:HRht+FlxMf2H3Oeg39XK0p8EHK4TchdPmE0lJZIN92UL20NFTSFpfzZvbCBtrjDPiqknCqgxHyAlJAqj9IKJxdtnKjdQD+XdeEPKxVYdml0mv3uh/ap2kIzZ80jQd+/4wFX6R7nLiwteo20hizRuag6aYeH5zVVjT0NrXlZfASL0KPv66qinyTjw+Z/rglzde64GNpuYtC+uGbkmDBDPZT2rgis/x81U+fuPM0GkhgdstLx89SmqizCd1fOzkFMy9rE0n8qTLpJqQY3knHZOKoFLsPJVydQOH7hzC+T2gzlNfF0H33pXIuMof7LVDNF347OjR2rgNyOOSk7eDfvWaC6MtC1DraTKJOCdj208Vg4=
X-Microsoft-Antispam-PRVS: <AM0PR05MB4449426F55DC98D6EB1A3300CF030@AM0PR05MB4449.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:AM0PR05MB4449;BCL:0;PCL:0;RULEID:;SRVR:AM0PR05MB4449;
X-Forefront-PRVS: 0785459C39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(66066001)(97736004)(3846002)(5660300001)(6116002)(110136005)(58126008)(316002)(33656002)(186003)(16586007)(26005)(50466002)(53546011)(386003)(52116002)(305945005)(122856001)(39060400002)(1076002)(23726003)(107886003)(7736002)(4326008)(46656002)(47776003)(68736007)(8676002)(81156014)(81166006)(2906002)(53936002)(2616005)(476003)(14444005)(36756003)(575784001)(86362001)(106356001)(57986006)(486006)(105586002)(83796002)(9786002)(9746002)(69596002)(478600001)(8936002)(18370500001)(21314002)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4449;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR05MB4449;23:s8NovBGC0QeuLgcTDLQnrXuQUfzQwAw0nYq4lumwb?=
 =?us-ascii?Q?EC4FNJi9Ujr7wUimH6NTIKdfymBhZvAKcEnGVyliWfuuvsi0a+fddR8JuUjQ?=
 =?us-ascii?Q?8oTHQrd5ye7mIDanAE44Lh5wdLGmBtAoHFGqDoCedhrEszBOfImOOD1/sOe2?=
 =?us-ascii?Q?zVJFIS6pskgiouVcpGE4DIHnk0Sx7GIyKas05Bd5roj27Z+AudZio/jhAPLp?=
 =?us-ascii?Q?HFh56gGnM6cALMagrAwjDVijU68sChtFmoBwfDzg+AoRre9R8Y70iQrpxQyX?=
 =?us-ascii?Q?vk+RHw0GghLojedGKaV9aN1UotdCWPSWFoQjVNH2F0J0y5YOSPYSV8O6ZfBp?=
 =?us-ascii?Q?URVPRXKFNiM3GZQ20WPjIWmY9PwosKo2qi80A5HVmmlW/d1ir4kqZgMDR9x6?=
 =?us-ascii?Q?ZX3ehRyO1gJpWgJcqpJtE9L87U/gLcQoG1s+DXJ+vSBYNoNYXTYZvyLWCfU+?=
 =?us-ascii?Q?qnhUJvEJHJ1vh4wMlUv86PrNnyBrhMpe8/uySzKiywtmjEigYF+tBxOivpzS?=
 =?us-ascii?Q?HHlLo+tnOcj6TCckcTZwuThaPRTCOrKlyuTkCQVxhGXWotqY9/UsUYT3TxWM?=
 =?us-ascii?Q?1kD3Ms0C/I+qS09pmolakUOIkYUtp3TygTAkk44FFx8TxILWsKh5Rzn5kVrB?=
 =?us-ascii?Q?1gzLmXky4g2c1/dr7anAM3etUNFCZSN/koIOL5Lv94192rUiZW7esLWwUS1d?=
 =?us-ascii?Q?i68lhkZkxLlS1jERTJ5eF0vhuGxaSxokyv9V/gqHyZyq8fTGeSUpuWsjrk9n?=
 =?us-ascii?Q?O7UxmVaCxsTJjM6XLNkaKFn19YcvVU001B/ZnSpkO4ztcMXrV99eiJmKG6iG?=
 =?us-ascii?Q?s8/ZgxG2nqE+5TcoBPHqMT8eka6ML86wAjX1O3k2HWzsPyIjMbbhDEe9K+GG?=
 =?us-ascii?Q?VNxCVW3okUfkPfPt3DLINRHuzriWcNgF5kuV4n+gGsSX5GQ3PbY2Ft8waCYC?=
 =?us-ascii?Q?VuH497osVPuPCziNKuVEfrDqqo392qLbpAoI46DOqD2NC7YV5JFJmDSX5008?=
 =?us-ascii?Q?vSNfcQEAvgVW0L1Dm/5qrqL74dRkurPS88APP2ZQx12355Z6W/33Dz3t6Vzi?=
 =?us-ascii?Q?iiLHk9h0ueBB2yKIvsS3ROTRf9dU2yWnVfU9GsvgLBZGz3h37dOSbPhVzjQQ?=
 =?us-ascii?Q?WnhR3Ms3ll8MdSjlUdDL3Z+Yt5AUUzH8kQxunvfKS+4WZ7EYjP1aeKIuCo5g?=
 =?us-ascii?Q?giGUSOxmo25CvmPBYIr6SugUReZ6IaHXIy+g+etLf7rEiFAb/w/UV6w1C7LX?=
 =?us-ascii?Q?ZvcFGmwNkciMBzNvWCobLk2jB9arON/LA+C4jiCk4eB+jJD9PfcGvE2vz8iZ?=
 =?us-ascii?Q?noMHLV6l+ef42TTwu/nLcqhbJW0bY9yDXR88hYV2cZN/XWfrCL2R89tj3/j3?=
 =?us-ascii?Q?xSryg=3D=3D?=
X-Microsoft-Antispam-Message-Info: EE9KrV8yACwWtbs8IhtI8Wctk5Hiwz8r35C6CYRtAm+sA8s0CbqqtT30aP8+21XY7coye7bmgeMiKK3CYdWwfK30nEWnS++oK3PockOWCJrSpwoFJLPnH5hQK5TWYV8k1cFFAhlVS+prQ96WSSwcFJT/auECqT6AaZ3zWIccDQCaorZFF+Cp54/DATqxYII6Ty/7K4T+ON6ILCGrocG+B4gFhhVzlgNQGXc8ZlZwvz0KRpLDZufk7K6NbDlKnCdlEazuhLVVfF7FtMvtilguW9NIzDzLYuPc/ArC6U/qqG7ymrNvO9TZVrKtU7e/mB4cYq1f3VBG3Nz+Sj6ZUxXSJYVmvd2YwITiETBr/Aa3QZY=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4449;6:8v8vOsUBJwpG+LJHtqljy5S5ZS9LQMEOMoipfgP4GJU5zXhCjlvp8EElcF04/sIf8ViPLUsklS8XIMyW78YxKiAgdLLU+5zpxLo4Gae4g1S3f3YA3C8cNS67CYlIZf2Xd+NQvx2Mo/GZ41F67R956gx/A7hQVAf+fwUJ4AXjZtWV2EaI2Vvtll0HGHCKy003iMkiA6BoQLQ7EZsqXLcdqB49n6aPPrIjsKVLxcrPlWaRDKSp42bvziQeRdZh4pyRAkBo00ygNkrfmYbNQly3hHFz0LYmQ32v8ogyAKaUnQVbkXUmLSCCo+64JlmgeJaR4jlzZZ8wxOqXP/HBjQn2+NcZjVJV13fYj133zYQ4B1LRzB2Ol7J5y1fkzpm1vLtLgNtM/J4eqdr0JVK+mJLLTafNFoqZwUOA4ueSoCe+txOxPKZUwQFxKahvWIckoPOboCZ724wdSLInvBr6qInNPQ==;5:s2pqU6pSUkbYLHnclMuwtuOSp/xdfdd0cXqJUc6Qo7tdfJtxExA40VPh/kHf4lXD9qxaj7PJ36MP4Z1ljHGlgbdEO+/2nfgodTECpoTrrW9/6qIWPd6+rIz29S3azEZH28zBSZXmGBpFOt8RMv5fDH+jO7VxDZxXHrv64EqBhsQ=;7:vhZ7ucn/3rMgmotfOcEcbI7YnrW1MGqaYOc3Sav5kEBkQYwuiSsZ6yFCSTI0X2w2Q95VNmosPN6pO7x7ftF0tTUKTYzbLM0l2ipsXg80oC2i0AsEBnXgnD8TAbdyUrmD/oNS0Q+5X8mTTA304NAyWPPgaZaMtkMlskzZBtLFyuZKdQQqZZjoN9Y3CXGaCEykvcZQA4BHHpTcbmbWl/UEyepd/gX8qXbXDCPAx/wJ+nSAODBu7mc6iWPbEDQT9AC5
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2018 17:48:21.7868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8314b7c6-02d3-4df4-989d-08d6128e9b31
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicholas,

I am testing 4.19-rc2 and I see bad behavior with my qemu hvc0
console..

Running interactive with qemu (qemu-2.11.2-1.fc28) on the console
providing hvc0, using options like:

        -nographic
        -chardev stdio,id=stdio,mux=on,signal=off
        -mon chardev=stdio
	-device isa-serial,chardev=stdio
        -device virtio-serial-pci
	-device virtconsole,chardev=stdio

I see the hvc0 console hang regularly, ie doing something like 'up
arrow' in bash causes the hvc0 console to hang. Prior kernels worked
OK.

Any ideas? I'm not familiar with this code.. Thanks!

git bisect says this patch is to blame:

# bad: [5b394b2ddf0347bef56e50c69a58773c94343ff3] Linux 4.19-rc1
# good: [845b397a7771f2d3504beff5521f452be0d22eec] IB/ucm: fix UCM link error
# bad: [60c1f89241d49bacf71035470684a8d7b4bb46ea] Merge tag 'dma-mapping-4.19-2' of git://git.infradead.org/users/hch/dma-mapping
# bad: [1290290c922fdcefbce8984e6e44b8f4e3a169b5] Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma
# bad: [6eaac34ff30e189fda28110298ca9fbfb2f51e28] Merge tag 'linux-watchdog-4.19-rc1' of git://www.linux-watchdog.org/linux-watchdog
# good: [e4f6a44c4aeca9eda153302abb0c14d053914f72] staging:rtl8192u: Remove unused macro definitions - Style
# bad: [5695d5d1970f975de059bb6dec76941440f62488] Merge tag 'usb-4.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
# bad: [f80a71b0c4111e26433744721ad68f05c169ad39] Merge tag 'drm-next-2018-08-17' of git://anongit.freedesktop.org/drm/drm
# good: [cf175dc315f90185128fb061dc05b6fbb211aa2f] powerpc/64: Disable the speculation barrier from the command line
# bad: [a2dc009afa9ae8b92305be7728676562a104cb40] powerpc/mm/book3s/radix: Add mapping statistics
# good: [d6690b1a9b0dd95a6fbd166d9657e0cc80afbf99] powerpc: Allow CPU selection of e300core variants
# good: [f2c6d0d1092e3da2bd36c768777e883fa3908548] powerpc/32: Include setup.h header file to fix warnings
# good: [b3124ec2f9970c7374d34b00843d9791fca66afc] Merge branch 'fixes' into next
# bad: [70b5c4ee8e3bf7ce107d6926d9c7d8ebb68578c2] Merge branch 'topic/hvc' into next
# bad: [cfb5946b55f1dfd19e042feae1fbff6041e25a98] tty: hvc: hvc_poll() may sleep
# bad: [ec97eaad1383ab2500fcf9a07ade6044fbcc67f5] tty: hvc: hvc_poll() break hv read loop
# good: [a9bf5c8a271b9a954709b7ada1bd258f5cadf7ff] tty: hvc: use mutex instead of spinlock for hvc_structs lock
# first bad commit: [ec97eaad1383ab2500fcf9a07ade6044fbcc67f5] tty: hvc: hvc_poll() break hv read loop

From ec97eaad1383ab2500fcf9a07ade6044fbcc67f5 Mon Sep 17 00:00:00 2001
From: Nicholas Piggin <npiggin@gmail.com>
Date: Tue, 1 May 2018 00:55:54 +1000
Subject: [PATCH] tty: hvc: hvc_poll() break hv read loop

Avoid looping with the spinlock held while there is read data
being returned from the hv driver. Instead note if the entire
size returned by tty_buffer_request_room was read, and request
another read poll.

This limits the critical section lengths, and provides more
even service to other consoles in case there is a pathological
condition.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/tty/hvc/hvc_console.c | 88 ++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 43 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index fddb63322c6786..745ac220fce84c 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -592,7 +592,7 @@ static u32 timeout = MIN_TIMEOUT;
 int hvc_poll(struct hvc_struct *hp)
 {
 	struct tty_struct *tty;
-	int i, n, poll_mask = 0;
+	int i, n, count, poll_mask = 0;
 	char buf[N_INBUF] __ALIGNED__;
 	unsigned long flags;
 	int read_total = 0;
@@ -618,7 +618,7 @@ int hvc_poll(struct hvc_struct *hp)
 
 	/* Now check if we can get data (are we throttled ?) */
 	if (tty_throttled(tty))
-		goto throttled;
+		goto out;
 
 	/* If we aren't notifier driven and aren't throttled, we always
 	 * request a reschedule
@@ -627,56 +627,58 @@ int hvc_poll(struct hvc_struct *hp)
 		poll_mask |= HVC_POLL_READ;
 
 	/* Read data if any */
-	for (;;) {
-		int count = tty_buffer_request_room(&hp->port, N_INBUF);
 
-		/* If flip is full, just reschedule a later read */
-		if (count == 0) {
+	count = tty_buffer_request_room(&hp->port, N_INBUF);
+
+	/* If flip is full, just reschedule a later read */
+	if (count == 0) {
+		poll_mask |= HVC_POLL_READ;
+		goto out;
+	}
+
+	n = hp->ops->get_chars(hp->vtermno, buf, count);
+	if (n <= 0) {
+		/* Hangup the tty when disconnected from host */
+		if (n == -EPIPE) {
+			spin_unlock_irqrestore(&hp->lock, flags);
+			tty_hangup(tty);
+			spin_lock_irqsave(&hp->lock, flags);
+		} else if ( n == -EAGAIN ) {
+			/*
+			 * Some back-ends can only ensure a certain min
+			 * num of bytes read, which may be > 'count'.
+			 * Let the tty clear the flip buff to make room.
+			 */
 			poll_mask |= HVC_POLL_READ;
-			break;
 		}
+		goto out;
+	}
 
-		n = hp->ops->get_chars(hp->vtermno, buf, count);
-		if (n <= 0) {
-			/* Hangup the tty when disconnected from host */
-			if (n == -EPIPE) {
-				spin_unlock_irqrestore(&hp->lock, flags);
-				tty_hangup(tty);
-				spin_lock_irqsave(&hp->lock, flags);
-			} else if ( n == -EAGAIN ) {
-				/*
-				 * Some back-ends can only ensure a certain min
-				 * num of bytes read, which may be > 'count'.
-				 * Let the tty clear the flip buff to make room.
-				 */
-				poll_mask |= HVC_POLL_READ;
-			}
-			break;
-		}
-		for (i = 0; i < n; ++i) {
+	for (i = 0; i < n; ++i) {
 #ifdef CONFIG_MAGIC_SYSRQ
-			if (hp->index == hvc_console.index) {
-				/* Handle the SysRq Hack */
-				/* XXX should support a sequence */
-				if (buf[i] == '\x0f') {	/* ^O */
-					/* if ^O is pressed again, reset
-					 * sysrq_pressed and flip ^O char */
-					sysrq_pressed = !sysrq_pressed;
-					if (sysrq_pressed)
-						continue;
-				} else if (sysrq_pressed) {
-					handle_sysrq(buf[i]);
-					sysrq_pressed = 0;
+		if (hp->index == hvc_console.index) {
+			/* Handle the SysRq Hack */
+			/* XXX should support a sequence */
+			if (buf[i] == '\x0f') {	/* ^O */
+				/* if ^O is pressed again, reset
+				 * sysrq_pressed and flip ^O char */
+				sysrq_pressed = !sysrq_pressed;
+				if (sysrq_pressed)
 					continue;
-				}
+			} else if (sysrq_pressed) {
+				handle_sysrq(buf[i]);
+				sysrq_pressed = 0;
+				continue;
 			}
-#endif /* CONFIG_MAGIC_SYSRQ */
-			tty_insert_flip_char(&hp->port, buf[i], 0);
 		}
-
-		read_total += n;
+#endif /* CONFIG_MAGIC_SYSRQ */
+		tty_insert_flip_char(&hp->port, buf[i], 0);
 	}
- throttled:
+	if (n == count)
+		poll_mask |= HVC_POLL_READ;
+	read_total = n;
+
+ out:
 	/* Wakeup write queue if necessary */
 	if (hp->do_wakeup) {
 		hp->do_wakeup = 0;
-- 
2.18.0

