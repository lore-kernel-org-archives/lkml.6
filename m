Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4555DC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 19:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BB424076
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 19:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lenO0fcl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4BB424076
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932096AbeGETlk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 15:41:40 -0400
Received: from mail-he1eur01on0063.outbound.protection.outlook.com ([104.47.0.63]:17248
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753828AbeGETlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 15:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mV7Y738kdYYXbhCChSHt9qZfO9Pim7t5Hj1YpllD3A8=;
 b=lenO0fcltrCQBlYFTjT8rjZ7yBoGeG2IpA/pJrLatSJJYB+cVOo8GcwrphFeEly78YJ0fcKfaFzqzI/1lvMALBxsIBxDLFz0sm4hl71tTbqr74tmObSBgnuF1sL2qwjUlESH3r3rhpUPERsqcGOH/g+isFeQhWbuXKebinDb7g4=
Received: from rhuath.am.freescale.net (64.157.242.222) by
 AM0PR04MB4482.eurprd04.prod.outlook.com (2603:10a6:208:73::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Thu, 5 Jul 2018 19:41:31 +0000
From:   Roy Pledge <roy.pledge@nxp.com>
To:     devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        gregkh@linuxfoundation.org, leoyang.li@nxp.com
Cc:     laurentiu.tudor@nxp.com, ruxandra.radulescu@nxp.com,
        horia.geanta@nxp.com, linux-kernel@vger.kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, robin.murphy@arm.com,
        Roy Pledge <roy.pledge@nxp.com>
Subject: [PATCH 1/2] staging:fsl-mc: Move DPIO from staging to drivers/soc/fsl
Date:   Thu,  5 Jul 2018 14:41:12 -0500
Message-Id: <20180705194113.16256-2-roy.pledge@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180705194113.16256-1-roy.pledge@nxp.com>
References: <20180705194113.16256-1-roy.pledge@nxp.com>
Reply-to: roy.pledge@nxp.com
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: SN4PR0501CA0057.namprd05.prod.outlook.com
 (2603:10b6:803:41::34) To AM0PR04MB4482.eurprd04.prod.outlook.com
 (2603:10a6:208:73::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edc3d660-01d2-4181-db1c-08d5e2af5011
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4482;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4482;3:IPP1xFkum6/8CFuqwNIAMEmYDhrh+sYEoZ08Lrpk+YMfdh32cLYT+n406juKoaYCEavSFom9ztqu1jLVtCZdzAcrmWsqi7I3CQV5gAmFZx4rfHXLY64dk2VZj+nvynOs+b+C1mISE9erzjiZwKAVfduZpgamBr5h6VeVrQkKUkGjhIL4z+it28gdwtR/nC/rRa9Vz8J7WQgNZaV2PliYXBuqwl3sUqcrjPd4QclIT0/1+4zJdDHRaeplRANknqTf;25:p4jBVd7/ex91ejajBUVTj1SgDfkAwfXNH/iV453qM98sjZ3H+tcBRVI3NvkhUezEfw6vfggU6gcWqlJx5KXRrpkcel4Rhf6PFZu2t0HpswDGTABnWQqRqkC3+ajmwZITNxSBhpDYeTX4rh5nxd7xkjNO5PtcgOIebVCg8mt4opC9omZCV5YIXppScFBlfnAX55zJrgjaMbiRt5AaSgelZY2ajpNF6Gf4jMhV3VK/hUDAM+FR9dq5+dZxglsNLhI1spZLixUFKEllWB5sx36fxHY23I+BNxxj+8jiEuTKovnT2HmpDkuWqJf96TT/HFB5jXeasPWugtSafMsOZAGv2A==;31:YUsdZj42Od1SnFdpUM5EpVQBUTC6kIZXM/hyM0VfOsgqhG9moKxK3BEpa9TGAppF+oLwNPgVmZNgfM9E50KOhop/zoDs6fzT1PWoUZSwAcx5XEja/AZaNWzX1jLFAY8uQQeyBtB9ARJv09A7Vf3TMXBtDVuth6oIEHj3S3RcEGWa6lxvxrifSkm2nVOsqfsPBAVSO9LW5OI73YgYCkfM6awnegzPbXSooJeVAyW00A0=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4482:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com; 
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4482;20:vsuYH29aQAw48R80rSit1jUrgUdaF/B8/mWChNBwY8Khua1h/rYqeJT0fxcyvs/zmAzj88DL1yeE4Ofivl2Ld6FOgm6x9LHwu8vweZZcYDWKsoRylgXoisk5JhQLGpIXCSb/ZGTWcgMPMANio3Lgf+gjvJXduywzNQXhWmdJAVu1U+sg2doyeCil4G2AMCaqAgxdZ1nIYabiElDNIZAy79LOYjwvzzt9f7MTik+kH4uymhGAzxe8EPcHwYc/BadXGOBMyQpH7dQJHx5JFz7MFHTmYjCsy/WM6jEDI65x74b4XrgegDyVpBq3nYWRwDuAMFOwDVDaYQrhE27uG7Er6A3VbgguXXFhY8C5UuWSiKDGm0OwyUn/bh3owRXl3CS4dKVDM2W16cJnA3ZGTuzwKk1+XEMEStrDGrzlmAgXQNJ8MCclWLf6vRoF0cjL9vfXIDg1KxppzemCoE/RPKfkJkTrfPTe7gNHPBfn+f6qBitAbCvmvTslKRRbJQDSLcEK;4:hDB1MLvbSqcOl/dxh63CAMcDQDdS3rJlxL+bMH2gJPXsknguZTmGnf241cxRQVJHC3rRy2RlgAU/MvYN2uf0zcT+Scm7yVz7LqsLwtne7DEv91CnixzTE8F06+tX8EgfoxSpnjIhdUxW3Ki+u6AHyNEJmPfjfedobWTd0lIckcSFEK1by5Ln847YD8efPZw6PLaR0c7hRA1EY4+IeHoOGfIGLlCUluXPbamc0iSx16D265Omvr805f8/zc+NxqhHGVa8HdiYUFHvil3aDJ9A953GI2ZP/hZO7WHJDgB+VFbVKAAao7FeGD++40CQsQ0COihP5H+20BhsMi9dRxDaVqfuBl6QvYNHFn6t0J+y/5lffqhOdCE4uPsRKttylsTs
X-Microsoft-Antispam-PRVS: <AM0PR04MB448297A385EA4CFC176743EE86400@AM0PR04MB4482.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(35073007944872)(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4482;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4482;
X-Forefront-PRVS: 0724FCD4CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(136003)(376002)(346002)(189003)(199004)(575784001)(76176011)(51416003)(52116002)(3450700001)(6512007)(386003)(6506007)(48376002)(1076002)(66066001)(2906002)(47776003)(5660300001)(26005)(97736004)(36756003)(68736007)(316002)(86362001)(16586007)(50226002)(6666003)(3846002)(6636002)(6116002)(106356001)(105586002)(4326008)(486006)(53936002)(14444005)(305945005)(43066004)(6486002)(50466002)(7736002)(16526019)(186003)(44832011)(476003)(11346002)(81156014)(478600001)(8936002)(81166006)(446003)(8676002)(956004)(2616005)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4482;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4482;23:8ekegpPFq/OHREJk718xEVPLZZdki7e9Ydns7YUAm?=
 =?us-ascii?Q?GPpyPznzgn/dfMspkjS/0LlNamAl/vUMPcby43WTnECNQYesMrVeoCTAGo58?=
 =?us-ascii?Q?oclFh+DrTGcWqizhU2SWKlCdSCX3LIqZgTeTniLz+8dj/DCa7a0djtkClYIx?=
 =?us-ascii?Q?AIwlR16TUa7maag5tfd5zz/bH/WLchidRVV9KxfIXdv8I7ugHp2aZR9+EqoX?=
 =?us-ascii?Q?FlUC0go2M9RVMA72pbEtUV2MF4VA6IG96a5hv3qpLYqBJwZKaFmhQ5yClMah?=
 =?us-ascii?Q?ZZ+KCpFeziZOLhjENjES0VwY4MjzjLbc1Qrll4vsPi0TkjzSRWKfvVUNOB+9?=
 =?us-ascii?Q?3YkITbMMxwx3j6nwVG5vjPKGeMOoEX3PCZAvAualYZvncM0grUf4cD75Ru9P?=
 =?us-ascii?Q?GeiW/sFSi2TG5+UaAWEZbqxVUiluW8GMh83oUPQ6v8aCcp9YUqBhh8svy2Rm?=
 =?us-ascii?Q?VOZ/a0s4DkqcLyYnEG6D3N8mQ4vCiiRT/spGXQr5EsumFbz8ptIfTvsMvWfI?=
 =?us-ascii?Q?inDIUCw6pnh32wvEpmFFm9EltUQDgLnVevihkPpFyCw3OgLFvYNJeVjYQeTT?=
 =?us-ascii?Q?WLx4A+c8n7JLlpyzdpr2kFWw80aNh53W4GwzLEUrmwGF6gDjmEECcaXFZ86u?=
 =?us-ascii?Q?jKSa3Ma0fsRyUFeFvtn7VbrxaJk9u5Nq3VMT6+M44VQ+DBw5CziFI7/Ssqjh?=
 =?us-ascii?Q?dt8x1x3GGq0v9vcSKQxg0I98d2wZYwfU2xGYHw/xopR0m73rkb8SXhJHG9XF?=
 =?us-ascii?Q?WXE0+i2+Rr0FnXZLnWIt+B+eYSPqK6d+r3OqihD286PNT2JuCLVy+E+W/XA4?=
 =?us-ascii?Q?iJKfCsOBB5cXY41nHtpW3kXzz9WwHeZyvLtK4c5BJkHfqO9NXxlu/HfvruMh?=
 =?us-ascii?Q?CwQU23khyNU1lThantZl/+L6kXzcXIPz6YB6Le2cih30sMkA396xqVUUTTm0?=
 =?us-ascii?Q?vTVC5pumK1gsgJK1pZxPKf2eGoxm2i8cMrVucN2tWCacvK+6j+IcwTWf7Opx?=
 =?us-ascii?Q?kv8xC1yWkPMrOyWl6w13MadiEunqpAqGNXfbBTnCMfcR89f4RmWIQz736QSi?=
 =?us-ascii?Q?Iz3dj3wmrL3yJ+aHnre6v13C9BnyT3yqT36u/fb5KAvrAIcMvseQ38Zi+cxU?=
 =?us-ascii?Q?6qaQ1whEPmY48IFyCBImbQ2GWzEmpAm/XmZ/6RzIYBM9fmcBI2dPhURvgigM?=
 =?us-ascii?Q?QFZahdBN8L7Z2qKJk37QLlaZ9Hr/MBVW48JhM1NQwt1UumabDI0SKdtisr0h?=
 =?us-ascii?Q?Vq2FPoHTxm1HyxIlvY6XcOzJQ8gIddfBC3XG0w5AZFvQjBs6J8AKLVbKsW2T?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: 2hB1k8eYVef8KZqJlDcWQKSkEU2TzEGDl+70wL0cTzWMn8WNLtGtL/LkTA+jFYG6oiglNX02rHti0yKpxicggp+hVHib4bP5eibPWcoqkkQ7He6o5ZdIZN+GlnVWN+qNakM1VzyKn7vCBa+S15fiR7MJlsmdMcB4zYQL32DtZF2vYOPBT25P0+gK5/VB0FngN0A+NJa8XBaLa7acCKBxQ7HmQRfJ39leWACWFVL6cnydezbCh8jRFJSMePWswGmF7k6tVmTTPUs+xqZoXAzChJDDdBuWLZLnuGJb7mjcSwAD2vjh6UBEv5J3naZ0Q2WMJzEhvxXb8tHRRX6JFp4Pk5g0u99wcR+w/FnCZYLQmsI=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4482;6:pcsAO8MUN+OLu3AFsCZfx4pNdU9I385Jnq5mrbeAyJoF/lq60B9M9JUQAksve1beuSusL6Bl1HOX0nqGmtgVEnk23dhZIYbAPM8HGMy0Zxap2Vj9syrGZM8sFyIa1NrpgUdMGDsTgMb90yJkMR4KfeVQf/lt25JKA7gdt8OXIUmSqDRG9wxIR0VuH9ea5LqkGAqVM985kwrrmtD8CtB6WyAYkMfnulpTYeC9xVsgoLAMdumpqS5attFHtnpoZEa4BJMB7T0pVPcV6o22AY7/YcADiuVpSfwrE4T8O90HIp+8adhQHy6vkeIZRIqJLE1oisPU6wEtF82Bch6HnEQnoe3+eU+jxOyuxezBin83TUaRN8Ma3sV2gDj4V+SwzJnE1b6fjw7kGnU7IbzYTOrjxJGcOjH9ntDKdZJWNkUkhKeoxUM0yVZPstaco5SdykeQZh3+TrylUHIQutSId1ZMQQ==;5:FESqwm3zfSifTE8XOu5PKKr6ZXRWjB0+FPq+35/rnWUQ2q5WIrYbr9PLxuVrOKODR8yVkEe9FoshVriaHAfMsg5pdXoSVS1ufQGD3TxQ/4WGASsGRpXTj5/453SI/a7JifezP7/+oM+b55JnIT2FEEJDGU2n/SWv9UY2iSPf700=;24:atOWOk8DoL1aNqm8FEg8AZ7H9kh+0o4Ac7P2sex+xcj2QY8vI6rDFs6oeYnfXMebRfM+cfvhpuCgJcyi3th7ZEKnEPzHoLXrv/Gqzfuljms=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4482;7:360QA/huqEyQq3NBD3OTqoGDrZN2rOvcpniSF4p7RCOgfHaXsN0m4lfp+wmIECaFv3Ilhb3uD6fts4Wn4HF2shoa8vTPHkDNZJZ3MevwHEgMI344WecInYhbYp0wmPOsilQJBSUDHvRuak5WYX8ayHPyyvYEU1yaAY7PyPwwhBbfD8B1iDMs61kkoxzRVmdY/tpl7e4StGqdrqUuTFQm+t1s/KKNjokZ/WJcWVv3biEOfOLoJGoECmzHqZRxh4pK
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2018 19:41:31.4171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edc3d660-01d2-4181-db1c-08d5e2af5011
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4482
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the NXP DPIO (Datapath I/O Driver) out of the
drivers/staging directory and into the drivers/soc/fsl directory.

The DPIO driver enables access to Queue and Buffer Manager (QBMAN)
hardware on NXP DPAA2 devices. This is a prerequisite to moving the
DPAA2 Ethernet driver out of staging.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 MAINTAINERS                                                    |  2 +-
 drivers/crypto/caam/sg_sw_qm2.h                                |  2 +-
 drivers/crypto/caam/sg_sw_sec4.h                               |  2 +-
 drivers/soc/fsl/Kconfig                                        | 10 ++++++++++
 drivers/soc/fsl/Makefile                                       |  1 +
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/Makefile          |  0
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-cmd.h        |  0
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.c     |  2 +-
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.txt   |  0
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-service.c    |  2 +-
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.c            |  0
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.h            |  0
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.c    |  2 +-
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.h    |  2 +-
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h                 |  4 ++--
 drivers/staging/fsl-mc/bus/Kconfig                             |  9 ---------
 drivers/staging/fsl-mc/bus/Makefile                            |  2 --
 {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-fd.h |  0
 .../staging/fsl-mc/include => include/soc/fsl}/dpaa2-global.h  |  0
 {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-io.h |  0
 20 files changed, 20 insertions(+), 20 deletions(-)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/Makefile (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-cmd.h (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.txt (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-service.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.c (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.h (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.h (99%)
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-fd.h (100%)
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-global.h (100%)
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-io.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index f771ec1..5b41d0d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4442,7 +4442,7 @@ DPAA2 DATAPATH I/O (DPIO) DRIVER
 M:	Roy Pledge <Roy.Pledge@nxp.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
-F:	drivers/staging/fsl-mc/bus/dpio
+F:	drivers/soc/fsl/dpio
 
 DPAA2 ETHERNET DRIVER
 M:	Ioana Radulescu <ruxandra.radulescu@nxp.com>
diff --git a/drivers/crypto/caam/sg_sw_qm2.h b/drivers/crypto/caam/sg_sw_qm2.h
index 31b4407..b5b4c12 100644
--- a/drivers/crypto/caam/sg_sw_qm2.h
+++ b/drivers/crypto/caam/sg_sw_qm2.h
@@ -35,7 +35,7 @@
 #ifndef _SG_SW_QM2_H_
 #define _SG_SW_QM2_H_
 
-#include "../../../drivers/staging/fsl-mc/include/dpaa2-fd.h"
+#include <soc/fsl/dpaa2-fd.h>
 
 static inline void dma_to_qm_sg_one(struct dpaa2_sg_entry *qm_sg_ptr,
 				    dma_addr_t dma, u32 len, u16 offset)
diff --git a/drivers/crypto/caam/sg_sw_sec4.h b/drivers/crypto/caam/sg_sw_sec4.h
index e586ffa..dbfa9fc 100644
--- a/drivers/crypto/caam/sg_sw_sec4.h
+++ b/drivers/crypto/caam/sg_sw_sec4.h
@@ -12,7 +12,7 @@
 #include "ctrl.h"
 #include "regs.h"
 #include "sg_sw_qm2.h"
-#include "../../../drivers/staging/fsl-mc/include/dpaa2-fd.h"
+#include <soc/fsl/dpaa2-fd.h>
 
 struct sec4_sg_entry {
 	u64 ptr;
diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
index 7a9fb9b..c17bf38 100644
--- a/drivers/soc/fsl/Kconfig
+++ b/drivers/soc/fsl/Kconfig
@@ -16,3 +16,13 @@ config FSL_GUTS
 	  Initially only reading SVR and registering soc device are supported.
 	  Other guts accesses, such as reading RCW, should eventually be moved
 	  into this driver as well.
+
+config FSL_MC_DPIO
+        tristate "QorIQ DPAA2 DPIO driver"
+        depends on FSL_MC_BUS
+        help
+	  Driver for the DPAA2 DPIO object.  A DPIO provides queue and
+	  buffer management facilities for software to interact with
+	  other DPAA2 objects. This driver does not expose the DPIO
+	  objects individually, but groups them under a service layer
+	  API.
diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
index 44b3beb..803ef1b 100644
--- a/drivers/soc/fsl/Makefile
+++ b/drivers/soc/fsl/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_FSL_DPAA)                 += qbman/
 obj-$(CONFIG_QUICC_ENGINE)		+= qe/
 obj-$(CONFIG_CPM)			+= qe/
 obj-$(CONFIG_FSL_GUTS)			+= guts.o
+obj-$(CONFIG_FSL_MC_DPIO) 		+= dpio/
diff --git a/drivers/staging/fsl-mc/bus/dpio/Makefile b/drivers/soc/fsl/dpio/Makefile
similarity index 100%
rename from drivers/staging/fsl-mc/bus/dpio/Makefile
rename to drivers/soc/fsl/dpio/Makefile
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-cmd.h b/drivers/soc/fsl/dpio/dpio-cmd.h
similarity index 100%
rename from drivers/staging/fsl-mc/bus/dpio/dpio-cmd.h
rename to drivers/soc/fsl/dpio/dpio-cmd.h
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
rename to drivers/soc/fsl/dpio/dpio-driver.c
index 11a90a9..b60b77b 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -16,7 +16,7 @@
 #include <linux/io.h>
 
 #include <linux/fsl/mc.h>
-#include "../../include/dpaa2-io.h"
+#include <soc/fsl/dpaa2-io.h>
 
 #include "qbman-portal.h"
 #include "dpio.h"
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.txt b/drivers/soc/fsl/dpio/dpio-driver.txt
similarity index 100%
rename from drivers/staging/fsl-mc/bus/dpio/dpio-driver.txt
rename to drivers/soc/fsl/dpio/dpio-driver.txt
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/dpio/dpio-service.c
rename to drivers/soc/fsl/dpio/dpio-service.c
index 14ed2be..9b17f72 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -6,7 +6,7 @@
  */
 #include <linux/types.h>
 #include <linux/fsl/mc.h>
-#include "../../include/dpaa2-io.h"
+#include <soc/fsl/dpaa2-io.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio.c b/drivers/soc/fsl/dpio/dpio.c
similarity index 100%
rename from drivers/staging/fsl-mc/bus/dpio/dpio.c
rename to drivers/soc/fsl/dpio/dpio.c
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio.h b/drivers/soc/fsl/dpio/dpio.h
similarity index 100%
rename from drivers/staging/fsl-mc/bus/dpio/dpio.h
rename to drivers/soc/fsl/dpio/dpio.h
diff --git a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c b/drivers/soc/fsl/dpio/qbman-portal.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
rename to drivers/soc/fsl/dpio/qbman-portal.c
index 116fafb..cf1d448 100644
--- a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
+++ b/drivers/soc/fsl/dpio/qbman-portal.c
@@ -8,7 +8,7 @@
 #include <asm/cacheflush.h>
 #include <linux/io.h>
 #include <linux/slab.h>
-#include "../../include/dpaa2-global.h"
+#include <soc/fsl/dpaa2-global.h>
 
 #include "qbman-portal.h"
 
diff --git a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.h b/drivers/soc/fsl/dpio/qbman-portal.h
similarity index 99%
rename from drivers/staging/fsl-mc/bus/dpio/qbman-portal.h
rename to drivers/soc/fsl/dpio/qbman-portal.h
index 69db3c8..89d1dd9 100644
--- a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.h
+++ b/drivers/soc/fsl/dpio/qbman-portal.h
@@ -7,7 +7,7 @@
 #ifndef __FSL_QBMAN_PORTAL_H
 #define __FSL_QBMAN_PORTAL_H
 
-#include "../../include/dpaa2-fd.h"
+#include <soc/fsl/dpaa2-fd.h>
 
 struct dpaa2_dq;
 struct qbman_swp;
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
index 905a4e6..824dcd5 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
@@ -37,8 +37,8 @@
 #include <linux/if_vlan.h>
 #include <linux/fsl/mc.h>
 
-#include "../../fsl-mc/include/dpaa2-io.h"
-#include "../../fsl-mc/include/dpaa2-fd.h"
+#include <soc/fsl/dpaa2-io.h>
+#include <soc/fsl/dpaa2-fd.h>
 #include "dpni.h"
 #include "dpni-cmd.h"
 
diff --git a/drivers/staging/fsl-mc/bus/Kconfig b/drivers/staging/fsl-mc/bus/Kconfig
index 3424530..90f234d 100644
--- a/drivers/staging/fsl-mc/bus/Kconfig
+++ b/drivers/staging/fsl-mc/bus/Kconfig
@@ -5,12 +5,3 @@
 # Copyright (C) 2014-2016 Freescale Semiconductor, Inc.
 #
 
-config FSL_MC_DPIO
-        tristate "QorIQ DPAA2 DPIO driver"
-        depends on FSL_MC_BUS
-        help
-	  Driver for the DPAA2 DPIO object.  A DPIO provides queue and
-	  buffer management facilities for software to interact with
-	  other DPAA2 objects. This driver does not expose the DPIO
-	  objects individually, but groups them under a service layer
-	  API.
diff --git a/drivers/staging/fsl-mc/bus/Makefile b/drivers/staging/fsl-mc/bus/Makefile
index 21d8ebc..2141e4b 100644
--- a/drivers/staging/fsl-mc/bus/Makefile
+++ b/drivers/staging/fsl-mc/bus/Makefile
@@ -5,5 +5,3 @@
 # Copyright (C) 2014 Freescale Semiconductor, Inc.
 #
 
-# MC DPIO driver
-obj-$(CONFIG_FSL_MC_DPIO) += dpio/
diff --git a/drivers/staging/fsl-mc/include/dpaa2-fd.h b/include/soc/fsl/dpaa2-fd.h
similarity index 100%
rename from drivers/staging/fsl-mc/include/dpaa2-fd.h
rename to include/soc/fsl/dpaa2-fd.h
diff --git a/drivers/staging/fsl-mc/include/dpaa2-global.h b/include/soc/fsl/dpaa2-global.h
similarity index 100%
rename from drivers/staging/fsl-mc/include/dpaa2-global.h
rename to include/soc/fsl/dpaa2-global.h
diff --git a/drivers/staging/fsl-mc/include/dpaa2-io.h b/include/soc/fsl/dpaa2-io.h
similarity index 100%
rename from drivers/staging/fsl-mc/include/dpaa2-io.h
rename to include/soc/fsl/dpaa2-io.h
-- 
2.7.4

