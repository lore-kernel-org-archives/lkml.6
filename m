Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62858C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF7D2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cWAw8PZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF7D2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbeH2NjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 09:39:11 -0400
Received: from mail-eopbgr40056.outbound.protection.outlook.com ([40.107.4.56]:17666
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726858AbeH2NjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 09:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oXTQWu9Z0RYLl0okq2/kbvpTT2D1WdMvk92T+xbi7o=;
 b=cWAw8PZjTTkHgifGMe/zn5Wu1NpTkA+UNH89YvGBAmjYcJ9P6Hdfmgw0H/FP5Ubf1G9174ZWRdLK2C7ndG0aUW6YWeZMAJaLADwy1yN4IpHZo4ynqX4hrmhwKR+NEjGWgdX8r4IYh61NGo2Azh1kl4VA3sv3dPhTA43Z8NE5Aes=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com; 
Received: from rhuath.am.freescale.net (64.157.242.222) by
 AM3PR04MB337.eurprd04.prod.outlook.com (2a01:111:e400:881e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Wed, 29 Aug
 2018 09:43:01 +0000
From:   Ioana Radulescu <ruxandra.radulescu@nxp.com>
To:     netdev@vger.kernel.org, davem@davemloft.net
Cc:     gregkh@linuxfoundation.org, andrew@lunn.ch,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        ioana.ciornei@nxp.com, laurentiu.tudor@nxp.com,
        madalin.bucur@nxp.com, horia.geanta@nxp.com
Subject: [PATCH net-next v2 0/2] dpaa2-eth: Move DPAA2 Ethernet driver
Date:   Wed, 29 Aug 2018 04:42:38 -0500
Message-Id: <20180829094240.27242-1-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: SN6PR1501CA0011.namprd15.prod.outlook.com
 (2603:10b6:805::24) To AM3PR04MB337.eurprd04.prod.outlook.com
 (2a01:111:e400:881e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6879dd9a-a757-43c7-1c70-08d60d93d0db
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB337;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB337;3:Km30NgybqvVHzG5RUAnzMTMdoSeZYGjf56HqfdKIvnL78ihm91v7oknsdRU1gxaLnwB9zZGNVcw38k9LKGZjtW1PIbyXINeo2f/iMR4s7TPYQZtx6DaSJlvM0AhShEoA31KTD86lavGWcdN96ZzLz0dkRi6HJzIhJ/d4FCnsIF0MTBB7Ca1EkZKi3NiFM5h+/H4Am0MxlVnxOeQkEFKF5z9Cpsa+6eJFAuaKschsXUHEsd86dDMLKcHuOLO90ZV+;25:KrMIx1ZvOXhq/5SsekkGsBfOHF/JLWeoYzsTb56XovLEf2ZEHckaRHdlQohAkWwmyR/pHdnwBSG2HACTBXMjrwyJaUbbxcG3x9396f1/5qIiWVRurSoQxANoCF+b2Fw/Qnq6kqc/mYScgVBGPzTRdB0L/0w9ZwR8olxF0YZhYInrBPei7fYvFjU+n/Z54NS+W31pMtI56YC9v6tkR/aIDLEbTzWR+p0JnL8QP9r+NeIYU0vryW1lkE7DEncK1hldP59rRvI5Gv9OqKuX/zOJcayYVt9CD1SUiO6+jg69xnm7IXuzG/xclUOjA1a7T13OyKDboUl0c1TIZmTtBy30QA==;31:r9EDaOcCIMDPUtCjsZRbaKopc91W097HXQPPaYOughu1yC3KRXtpS8G+iRKEGk0n/FMKb11W+Va4RU6wOsfr5Z5LogwdWlbfNKuN1eCAA0J8tdGzIwi0JL/mAM9Z47GFsTU8keuX72m64IlFYazg1/LEcpf6j4Q+00F7sBVPqyiuJDWRDk0sZ8HgKQ+NSrYqyWtedrudybjmcN56gdpQN+3IhseR3P+y3p+xOQiFBxg=
X-MS-TrafficTypeDiagnostic: AM3PR04MB337:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB337;20:8C69FakD/kmb8UAg6zSP0NF1fViw1uJlIhpRmWdVRT78AhLsTKfU24shVeKm36V4+vfii/eVB/0kIn5WJUAy66JJcQX/y4AD5OVOecUs5iqwwuH7F18HNyqhYH8zzRIPVp0+UlBVtXWiMndXZOPwWX+K5IgsewnRoOj5mocnUhTBjBf5Fjox5SWdV6pWpJrYSzcVPnyMXBaQ8LAXCd34toC8BCMgLoJGehpJc47p1cnPbeUvAA0ajcaAWgkrbsQFJxMM9p7NteouysUX+cUXj/uGeb1f2b9PdC6L9NiQnSfLHWwV5lw8vsIbMHDkjqfJuoyPwNw/SSYakRSdQ+ScGHTff1YSP+KIkWGlEutRGN+y8tBtUhBTMtzNtpPl3QDrq7tsmJx/uLpcp3rO8V/qwiXzNNaN7gJLi+RwyEgMaAbC6J6FuwfjHTvD6YBfdgVRakpbcFr6Wa7epoOp0STi7OasIJz0y3mjFFPvuR0Hxxk8sXxK2lwdhych9dZQH1Pd;4:/pA7j5lqnTdJtIqo/QYeUtr3g5H2qaWfxiuzYPESHQujJxSH3rYWUACFfQhwWss+xWIGP9GuHJOw0TBHK87xoHygPEBp2I1Vu70f4HRA5KhwxihdamEyOMjZ8ezA746gz0KEdKMic4GF93ZCeSV4o/qnbXeGHd+LSwM4mntdsrh9EcDIlaxEWUFaj3z7wAK7ClSnMldTviHPAja3eZWvqg6kgUiuDwHtNBD/w9W9YGqNJPGnS5vMB0kWfrnnT4JMgBlG8trNbUZLblPYt/qrzA==
X-Microsoft-Antispam-PRVS: <AM3PR04MB337C236183F01C5338D920194090@AM3PR04MB337.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699016);SRVR:AM3PR04MB337;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB337;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(39860400002)(136003)(189003)(199004)(25786009)(16526019)(16586007)(316002)(7736002)(186003)(50466002)(305945005)(86362001)(53936002)(66066001)(2906002)(47776003)(26005)(97736004)(106356001)(48376002)(478600001)(4326008)(51416003)(52116002)(105586002)(966005)(6116002)(50226002)(3846002)(8936002)(68736007)(6306002)(486006)(476003)(2616005)(6486002)(81156014)(14444005)(81166006)(1076002)(956004)(6666003)(5660300001)(386003)(6506007)(36756003)(8676002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB337;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB337;23:ZeeaDIWIGuBn2b8lDz8ZBr17FMSGexO+KhVn1IBPwJ?=
 =?us-ascii?Q?DyRKG5z1tPQ7DXk722Kr1iQdSvYHrNPgExHt8p+LeehezLOZqSFzYK12VHX1?=
 =?us-ascii?Q?bZSvzYWchfrs6Qyli+so32ekgAIreDHkWlRqYuoVRgTPIueYzBrdnongq7FJ?=
 =?us-ascii?Q?nhUiW97Le1zVhkvzoNW4JQ+wJNsBXJxOaZCuC3sSCbteyGjXbm8P0kNkva7D?=
 =?us-ascii?Q?VaV77R9N/CcojaGebOr2Sc99hn4cTZmqZyBrNk4EaNvPcRKtWxc+u2IKe5sc?=
 =?us-ascii?Q?LZxMNzaBxntENqbFxKGu0j1Dq4yFMQ7OceqDUCd9cMsf6g4NCtu3tsS8z4eb?=
 =?us-ascii?Q?SPjv04B6jVtSSumiVNPgCqSFL1BeOYQkaWEQpLQH5fhZbfVfaZv2xS5cMMhq?=
 =?us-ascii?Q?IPS53jS2GpnrQi41vxREq4ofpisvwxXy6Ssv+875N90XGWMQ3l50Q6rF2cfl?=
 =?us-ascii?Q?gejhaqfOD2z8nheD2Kc2pIOSxHC97/En3YmlnDpCes7iynvvyM069TF0boxD?=
 =?us-ascii?Q?0vrjBIEtaeWt9khzf6OTPJxOLYXd4qS3/xXOyM8uIMx6IDm+/51B5yEDR7Ca?=
 =?us-ascii?Q?pmWK4oIMMhRVr5MkoZ73E3f1YLT5fvt3+ntLaU/wiZLND/tKNKehl9m+a/Eh?=
 =?us-ascii?Q?CRKBUUs29BDTOnEFT5GAEEFjMjkNXWqwbgadKiNhIBpl9uuAYt3t3SMDV22b?=
 =?us-ascii?Q?H0Kb2cxIxjZrAROxPVURKpBib/V3I/IgZyxwSNnrfbbxlyRMEgKprLlMIVrt?=
 =?us-ascii?Q?GqrxGHz48DKuWKAlhAA7PyzZaG+JzPSrWS/DnPV7uOkh5ir9UDbkaZqeqowp?=
 =?us-ascii?Q?++GhiYZRp+y/ntinsHgUQ3NqHUPhnVxgdRbGUKCEsiJNDN2aZ1YqxRUNxs7D?=
 =?us-ascii?Q?Hs/PzqVBgu8+lGWFxNeter6AQuZX9xWwxDiQ9sMQkbE2mk2EniH2lBq9WJd2?=
 =?us-ascii?Q?ZTr04m3m+tsocvKef3PoouwDWboesG4mocbxAOe3kSfJ+8unWk1/KkVmEyZW?=
 =?us-ascii?Q?BILRmlCNLqu+2LqSFBmlYn3Z2GVW/mdi/S/PHhULB5lbo6oFZrVVqbwSYFg7?=
 =?us-ascii?Q?+LjT8OIWzuTUpzePZodUs0ubNT+IxrYN4LUbgVuvagwF9QJhWme96si8dxrp?=
 =?us-ascii?Q?YkCZvXGQk1uFAE8UM428mloRBdbwUCK5tyQNHed8xdlMxC6H8sKg=3D=3D?=
X-Microsoft-Antispam-Message-Info: hCtEiIpzZn3zZqVPeRTFflMEENUWs344nljzmF/ovzvNSzk+apc9LcqwvItTK2p7K2jkifKF5nUWtPepGOvblzyx1vzzRPh3OsViUgrH3STiggOnOY08rufr26+0Zx8i5QmFmlrL450NbCTBChQIrwkMHu9t14qpfd1nAVN8oAwVZnenAtyEpvx0iXkZRt2VFTUlDR7y+HUhQLa/1I3gksFNhL8pCIe8b1/kCBncjBMMXzGoLyWiBpDKDkZxs92PTK8SCP0FCfDLY0DFvO6qNvO/YKU5Ha3Rb+UQJFiWCx7DZs4/lEt2c/FrhfY8XuKOHvGf5ySKq6+JINvkC+4c5TR46JUW9miFI4cGa0UN8iQ=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB337;6:oSkw4vK7fzexlen/bf6Y2c6PMrDtC6IOjQR84M0fuEWLT1ZdCfuZsVWeqy/WZO/jlPXhR/32aHbls+ZqqEy9yXz70L2EyEXLsv3RRpRchoMWNkDWXHcOAN4hIYT01Vzo7o90a3LewO55uUScspy+G7p3YOWZRLOTBY1qvkEzf6Uy2Mbyv8ztfOlnKrekFAaD3VDKor8ScyG+2mgVTlwtmqhB38miz5OxGhzlXRlfQei40uN2dNMhHqnMs15LIfdjQtlRAYbGCRGbCSzQQvCjGDu0sG9c9OhViM3uiZusLA9keKgG9IasfFt8Ff2QEohwPcrkSoB4gMkHNXU2fZhqEswA5IfHd6tJecuH+edxBm6H+T4HUoMyRSLUGNuSmvtHS0Wx8Fl5oAtEChY+lCnguPofvvB+3r1KPmnnBYoWM+hYCkcMb1Gxq1G9ISuvQksh78jLBqD/+r9K8oxW05XzwA==;5:qc2AaI3e7PKpvn3L1gp2/r2efuiW39d87guDKB/I7nQWY70DCrHB6FZOauSmlNzsyF3qCeBAJIoQnlQPLKHi1zG5No/5hT0Gf+0GXmeqcPQijcqFziIYyKYj/hc2LXemPAZuu/IsvNxZrYKSiwToXkXJ054V6PZDyH1wIJR/ZxI=;7:vsZi3iV0a3eMUXo23XpM47m70U0b4AdrYQiQ+03OpRUbPCbLMvpl0KVoQWNZfxX1Wqq1jv0nnbrHZ2eLaj0tvC5+j/JOKWJlO0T7yUkmL3FW9EAE5xo25WUdI45JFUHnyTn6pHj4TA5cGx2UaXGM0Up8tBAZneVX60znRVdQtgCwQIefj+NsfU+EnfEpZpyOnFu1BQ8Hms672+EcDX87m5u146N/raGaArTImW3/QFLG8Bp4OMPe0IvvqaSaOIvi
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 09:43:01.4877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6879dd9a-a757-43c7-1c70-08d60d93d0db
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB337
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Freescale/NXP DPAA2 Ethernet driver was first included in
drivers/staging, due to its dependencies on two components located
there at the time of its initial submission:
* the fsl-mc bus driver, which was moved to drivers/bus in kernel 4.17
* the dpio driver, which was moved to drivers/soc/fsl in kernel 4.18

More information on the DPAA2 architecture and the interactions
between the fsl-mc bus and the objects present on it can be found in:
Documentation/networking/dpaa2/overview.rst

For easier review, the patch is generated without the -M option,
although the driver files are moved without any code changes.

changes since v1[1]:
* remove RFC label, since dependencies have been merged on net-next
* add patch fixing a possible race at probe (reported by Andrew Lunn)

[1] https://lore.kernel.org/patchwork/patch/971333/

Ioana Radulescu (2):
  staging: fsl-dpaa2/eth: Delay netdev_register() call
  dpaa2-eth: Move DPAA2 Ethernet driver from staging to drivers/net

 Documentation/networking/dpaa2/ethernet-driver.rst |  185 ++
 Documentation/networking/dpaa2/index.rst           |    1 +
 MAINTAINERS                                        |    4 +-
 drivers/net/ethernet/freescale/Kconfig             |    8 +
 drivers/net/ethernet/freescale/Makefile            |    2 +
 drivers/net/ethernet/freescale/dpaa2/Makefile      |   11 +
 .../net/ethernet/freescale/dpaa2/dpaa2-eth-trace.h |  158 ++
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c   | 2654 +++++++++++++++++++
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h   |  412 +++
 .../net/ethernet/freescale/dpaa2/dpaa2-ethtool.c   |  280 ++
 drivers/net/ethernet/freescale/dpaa2/dpkg.h        |  480 ++++
 drivers/net/ethernet/freescale/dpaa2/dpni-cmd.h    |  518 ++++
 drivers/net/ethernet/freescale/dpaa2/dpni.c        | 1600 ++++++++++++
 drivers/net/ethernet/freescale/dpaa2/dpni.h        |  824 ++++++
 drivers/staging/fsl-dpaa2/Kconfig                  |    8 -
 drivers/staging/fsl-dpaa2/Makefile                 |    1 -
 drivers/staging/fsl-dpaa2/ethernet/Makefile        |   11 -
 drivers/staging/fsl-dpaa2/ethernet/TODO            |   18 -
 .../staging/fsl-dpaa2/ethernet/dpaa2-eth-trace.h   |  158 --
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c     | 2661 --------------------
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h     |  412 ---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c |  280 --
 drivers/staging/fsl-dpaa2/ethernet/dpkg.h          |  480 ----
 drivers/staging/fsl-dpaa2/ethernet/dpni-cmd.h      |  518 ----
 drivers/staging/fsl-dpaa2/ethernet/dpni.c          | 1600 ------------
 drivers/staging/fsl-dpaa2/ethernet/dpni.h          |  824 ------
 .../staging/fsl-dpaa2/ethernet/ethernet-driver.rst |  185 --
 27 files changed, 7135 insertions(+), 7158 deletions(-)
 create mode 100644 Documentation/networking/dpaa2/ethernet-driver.rst
 create mode 100644 drivers/net/ethernet/freescale/dpaa2/Makefile
 create mode 100644 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-trace.h
 create mode 100644 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
 create mode 100644 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h
 create mode 100644 drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
 create mode 100644 drivers/net/ethernet/freescale/dpaa2/dpkg.h
 create mode 100644 drivers/net/ethernet/freescale/dpaa2/dpni-cmd.h
 create mode 100644 drivers/net/ethernet/freescale/dpaa2/dpni.c
 create mode 100644 drivers/net/ethernet/freescale/dpaa2/dpni.h
 delete mode 100644 drivers/staging/fsl-dpaa2/ethernet/Makefile
 delete mode 100644 drivers/staging/fsl-dpaa2/ethernet/TODO
 delete mode 100644 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth-trace.h
 delete mode 100644 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
 delete mode 100644 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
 delete mode 100644 drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c
 delete mode 100644 drivers/staging/fsl-dpaa2/ethernet/dpkg.h
 delete mode 100644 drivers/staging/fsl-dpaa2/ethernet/dpni-cmd.h
 delete mode 100644 drivers/staging/fsl-dpaa2/ethernet/dpni.c
 delete mode 100644 drivers/staging/fsl-dpaa2/ethernet/dpni.h
 delete mode 100644 drivers/staging/fsl-dpaa2/ethernet/ethernet-driver.rst

-- 
2.7.4

