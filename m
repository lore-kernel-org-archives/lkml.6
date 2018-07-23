Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4476BECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28F720880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TGvzBJzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D28F720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388723AbeGWSDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:03:02 -0400
Received: from mail-eopbgr40041.outbound.protection.outlook.com ([40.107.4.41]:36744
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388187AbeGWSDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxzbPgs9x4stLnwRTIgJqxMpDHpIEc5EhnyZMoQr/0c=;
 b=TGvzBJzFFrt3hlLYkeIStOauMl23zPLTk5FrH0p63NQrCL9Cml96qbBIrhI/eB3XZHW9ojObgKlKtiG2IxdoRLxlh6HXFajJ4+WoFhUpsc5CncMGyye/XO19Q9QABtVrByk6VZJefqjNJSLhN6+wsoqEm3Hgt6sTYu5HvKTHPtU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com; 
Received: from rhuath.am.freescale.net (64.157.242.222) by
 VI1PR04MB4494.eurprd04.prod.outlook.com (2603:10a6:803:69::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Mon, 23 Jul 2018 17:00:44 +0000
From:   Roy Pledge <roy.pledge@nxp.com>
To:     devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        gregkh@linuxfoundation.org, leoyang.li@nxp.com
Cc:     laurentiu.tudor@nxp.com, ruxandra.radulescu@nxp.com,
        horia.geanta@nxp.com, linux-kernel@vger.kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, robin.murphy@arm.com,
        Roy Pledge <roy.pledge@nxp.com>
Subject: [PATCH v2 0/4] staging/fsl-mc/bus: Move DPIO from staging to drivers/soc/fsl
Date:   Mon, 23 Jul 2018 12:00:21 -0500
Message-Id: <20180723170025.2259-1-roy.pledge@nxp.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-to: roy.pledge@nxp.com
Content-Transfer-Encoding: 8bit
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: SN6PR1501CA0021.namprd15.prod.outlook.com
 (2603:10b6:805::34) To VI1PR04MB4494.eurprd04.prod.outlook.com
 (2603:10a6:803:69::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78773fc6-8f8b-48d6-89f8-08d5f0bdd56d
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4494;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4494;3:08LCikoipbl++r6norOTIJiFeOjGdDTJfTdD1BdFkkbb5CIoQ1ncgS+IES437GGLOSgq7CXk87n6tqF6bbYmfRXReqetT0WNgUgsaJera/Gb/uuU9XdmuNtEx3VRoGlKj5GhQ1kP5Hm1DiwbtwaI/LLvZ8mRlpafuwb1rM69M8avap4oZ7pvlkoRmkujNHxehnQ1fDOjJa2sXMynDDYcsxP+ixwx37Plc5ZNkSgaCv+Bp4oWJjm50P9dVKaG6XkE;25:+cY3mis7E/0AXDb4kIPa4CCQHm41Ah9buc6RFByS0IiauJUXvHupzFKf4UqFrPKp/54WJ6oKy9DXD9/nxJtvkF5df4mYjqtgwc+VuRa7430uS/d0G98jFA3JOvrYZd17QqxFW6gJx2M6ivjjHWZFeN43wSRRKSLG2jWVC1FyLZi908854Upep7Gt/SUFzKqcaOK3Ae+F/e3KpUHOm+N+ATG+dEjIYZ9XQXskII6DUD7f1ZM0/+VFaH/1Z5ByleSsGG7IWrW5UVmUjNMHmCB4G/UgajNdhFEUwJbmd/jveze4lsr5EWeDZb/LalW6PtdgD392286kaYIURlXA134FUA==;31:ArRLHgFRvMfv2sqdYpG+3By5hUB3A9a223YMpvOB3xGLKgOcv9tiyKts6ePHEMePcgMxT1ERNPY7QlYXAKa/kwlNoyA5XHpwmr3MzH4MkDQEp65CjTXT+NXiRju2RK49KXBv272/Blnd1b77gh9wg/iXqfUjLcNrxsVQh7DDOKNR5XSINEZxjRZXx03DLiikKkIRonYbfNtFeeytrPfUIHysv2FricIw0fgZBiYWzSM=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4494:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4494;20:DDlsncwbnkfWn0qMhVDZeFeQT4BagQTKmP1VvHO2iGQrtYUEb12G9mSmENE9/qimQIh4Bm7yoifcV69jOy87HIkH8cO9NJ65mb7+aRAb34NLHP8Z/dxt5YXdbpbMJso81paUOzfCjvwSSjpfbtsPv+86IlxFEcWsheBSSKTA+/81qhRbqWaFkqim4apTgUT12o/02ijeZnedwmCJglKxy7QX2NIO3o3VVrKp/vMzjeR3x8ktvbqObalgJNc3gmAp9AcxohGOgeHzwNKMd0jl+xJdvC1SaOB392PO5zBcn28Mx3jSOyuPyam/EU1OWzfTyXKQyX0daRg4iJ4jSQ3DmDAMK11iPiUaFujGSBWqtSssCweO59grSeSNK1IzinT7PWYZjpe7RCMOImNPMh4xYb2Egv33myR91OXWx8pD/43TGX/VpGZ83GeOCy7fEKtkJKajkKhq8PTaKikWvKHA/eTHnhOLvSrgnxaikUCs7nQbmOxCWAriD37+Ck+Odym2;4:mB5o/pI9UbxvuQEtpM55jy9Hv8qEngiTioJxNhF6cO8M1m6qtdTczvSXGdYv0Rhh9LM1SBX3cWdD6wNGRcMjpfvuSogejAwjohBhWcAW587N1BRsgZLnG1tMkVhPBIbFkGkpyzE3+Eac+OBFDQ0VxqgAKBN6aEEH6rczyeEdDAGXYfRHxGMS4eGBX3ym50Q7UNQ3MbLQlwxgfSkrn9Q5ufS/IAGMemKQKFOpmC454shARIFLd/myd7SKfw7q8vZctNbP8cZcdb267e21Sfvg+Q==
X-Microsoft-Antispam-PRVS: <VI1PR04MB4494DA41D34988A7B5C58F1286560@VI1PR04MB4494.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB4494;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4494;
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(366004)(396003)(189003)(199004)(7736002)(386003)(6506007)(105586002)(5660300001)(6666003)(186003)(2906002)(16526019)(6636002)(26005)(47776003)(8936002)(316002)(81156014)(3846002)(6116002)(50226002)(53936002)(476003)(4326008)(68736007)(106356001)(956004)(2616005)(25786009)(14444005)(43066004)(6486002)(50466002)(66066001)(52116002)(478600001)(8676002)(23676004)(86362001)(2870700001)(3450700001)(1076002)(44832011)(81166006)(36756003)(486006)(305945005)(6512007)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4494;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI0NDk0OzIzOllGalZBSjFnWWZzTzA0enhFSHBGTnlTdDlL?=
 =?utf-8?B?SWdvMG16VWhjQzJ4aFlJaHhUMzlXang4MDRMZ0RmWFpNY2JoRFhlcDV0aEgr?=
 =?utf-8?B?b0xGN2J2SGdRbUM0MXVsbkN3c211djNueUtYdG83MEJCdkwvOG5zRzFZV2hZ?=
 =?utf-8?B?TUg1cFpZNXdFeTZ2SnFTakRHOXhJbWNYbjFQWDRqS0cxNVlCeGVzQlFUb1Ns?=
 =?utf-8?B?K3ZGOGFjZytTUkR2SmpHZE9OemMrTUd2RENSVnB2aUVwcTFYQnN3NXZYRDAw?=
 =?utf-8?B?blR2bG5MUUFyckFYNlZCZGFyNnExdlVzSVhjek5lREw1M0prVXVESkFNa2ln?=
 =?utf-8?B?RGpHWTVKc3cydW9MMFBIQldSYm82RXFGTUU4UlVMWjZEV0xIWFZSL25VaW9y?=
 =?utf-8?B?S0lqN3NwbEU0MG5kSStjek1DWVdiMkdNT0lPemRtMUpiQnRMZ0FFdVJiVjIv?=
 =?utf-8?B?b1ppQi9XbXcwN3NyVUtPZkhwcW56Skt4Kys1eFp1VUVOQS9oSEFUUnMyTWdR?=
 =?utf-8?B?cndMQmxRdWNSZ0JCdWQreUVKdFB6NFNlY0xHOTJzMkVpSmFzQU93ZFk2YWxE?=
 =?utf-8?B?RnRTWSthcHFRTzR5eFdaSUlDTUhJYlIvZ0toSUFibHkzS2JtMlBaQkZZNkpY?=
 =?utf-8?B?NHdwTEVpb0VRalpsWE5kYUg3VjBYWmxxaC9ZU3Q1bTNWNk41WjNTVElvejFK?=
 =?utf-8?B?T3QyT3NrbkRMaGg0RXZJRnBNUUErR1JrRFcxQnVtTFl3a2JIYWR0aHowSVNC?=
 =?utf-8?B?VHM3TlNFK0FGcXFTVEFVcG9memNXbTRlei9YTCtVTytwSlpwcDVOd202KzBJ?=
 =?utf-8?B?L01PbzdBeUZTUlhLQ1l2MzhzQ1ZGcy9RYmNKVW1CSkNVdkRvVnBEalVtajQ4?=
 =?utf-8?B?M2kxaUtxMy8zMW5zalBzYWZsSk5Sb2VoV1JYQXNoekdjUUZIN2ZCeEtRZUhT?=
 =?utf-8?B?YUgzN2lFN2c5Lzhmd0Z3M2tpL2Z5TGwzMDNRc0Z1K3hYdDJOZDExUkhoRmhI?=
 =?utf-8?B?MmsxZ0lUdWlJZDc3S1JZdmN5eE5VdGVjQWs2UzhQeVRRdGVUSHNib041cHhN?=
 =?utf-8?B?ZHdwU09vRHRwU0luOVdkZjdEVXhmaExQV1BrckVpWjI5UWg1SmMrdE9JTXFp?=
 =?utf-8?B?WXJZSjNmbldubCt4YXBLZ1pyQjFCQ0JHdXY4OEFYaW9NNXpBOHM4UUlhcWgw?=
 =?utf-8?B?bW1KN043V3ZOdzlKNFk2WkNWcVUrMkZOVURtMlZPSGFUdlZhSFF5TlRvYUx3?=
 =?utf-8?B?UTh2QmRaWEY2elhURDNZOHlMaHU0YVZRS3BieWtDZ2hXNjdjenpRZ2dYRVIr?=
 =?utf-8?B?bk5LaURFdzhmeXMyWjE1M2RBWjRLZzdLSGNrUmttdm5nSWxVSUliczd0RWdL?=
 =?utf-8?B?NnJDVFdmY3d0eVQ1Q1ZNRFh6OUdXYytsckdsTFNVS1NZNmI2YjAvN2pmbW8x?=
 =?utf-8?B?YjBONk9hMUhwNlNOS1A1UWpPMDduZEI4S2ZsQ3hTV0k0d2VmQnNURzMyc2tm?=
 =?utf-8?B?dkhuV2xBRWRhUG1rNE16Nit4QmJLaUcyaGJjTW1nVlNleWZJcWl3YVJZRmh1?=
 =?utf-8?B?L2hBdTMrellWODdUbEl1a1pxTnkreTRBQ09rUUcvV3ZBVFBlc2hpc0RRMXIy?=
 =?utf-8?Q?Kb2WskgPnJtj5zk7XSWU?=
X-Microsoft-Antispam-Message-Info: 6xiOOmF0sLa9gDN0zSk46kaUsah4edooVF9hjrbLwDFHpbcXfhHngg7jJcuw6P84QC5J8nkI4LAE1MpluQCXxyz3Eyo+b/ldAXsFjB5tEo10R/t/lqMPLi/cF+T7ALGbeMXVYiAZJMhSJFRbwYds8fBgJLjYAlAIQXlCoDjJUu5W80vHNC/gOCuTaz45owbHpNKZmiP9RlRWn9apw+SDu8eJs36COcFRiV65faYmeGFJ6hrr2UznHjaMcQ4EkEMcveYD1vB82yy1PJDQ8UJAKTsVvWW5H2k/eaPvdgq8Fz/kr1b6hDxuKKl+otoLE9Mn4g4pF0LAC3K5Ff4C6Uf68r9+G9WG6zfhrKzvSP03KV8=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4494;6:zQ/ivowGwoUCvB8x/tc9IFDHuW7NVDecj47Y7bnclap64A1ClxJAMioP0c3vtFV0UwybncCGsPJtwoLF+Gj+KXc4Gom/MGFzMLMs94lPMS+o+y71d5nJV6dadJHMpAU97YQ8ct0ZhiVBodmOldAswthXFfVESjkKIGXYlk9ZvGnyGcQcIDylDo7OB2gX8DXYc7m/1bxiRPl82+WbFQHwcORXE2RcgrZQ/6SUz/caahWjDQLB/HH7Ek697Umeksq7tgVOoLR9Dy7SPdHL1N9ASiGSsGiDqrSrH0oHA/YjOhdP6xDOb6BuK4ZcqdrCbAwHGSN35AV2hqduDNLN0M6kUJIT7PMeTq87/PDwAlYdnngAZhi829YXWNkHcJ5tCYEdEkJ7fRlSi44vl7EEEzgCw9CqwtlCXiNPPPkTB69GC/a5oMuPbd+PBbO81g6JJUPveSeQ9nfkNKFclrf3+CQ+DA==;5:xvLFAkVub3OycZR7NNGNmoKPw3nRNcHAauwRF4tvAabRZmaU+MHr9g8Ll5t7smafrlZsdtGuohyxjhz0Kd5aBfuX+pB9urnl+WInCJN3V5M68lpVytMowbtihX/Bi5xSkptd14i1/da79nj/JaF3uJAxlwsovQJ6ENy50ZDyNN4=;7:Ht594IFl29G084oWIPX2/yKQZONqoJrZUFkRkiX+l8MI2uLcb9Lf8v3/1BQzzDDldlVSp0LYFG0s8SmWUu1s3AdzF7qWYJua8yKfFNzRwIYF0YmyqHXWP+MBQc1X/onvG6LRES7WARDtmat7SY97dKvg0dmuMtIEJXe6iwe+IO1IicljxaPlEfaYrjlHZRPUZZ0KURJH9kb9v7ghL74opgrpxyUBqG0IO1TwUC6r64Wmkzwb1I6PyeZBJrmxu7OV
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 17:00:44.2691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78773fc6-8f8b-48d6-89f8-08d5f0bdd56d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4494
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the NXP DPIO (Datapath I/O driver) from the staging/fsl-mc/bus/dpio
directory to the drivers/soc/fsl directory.

The DPIO driver enables access to the Queue and Buffer Managemer (QBMAN)
hardware of NXP DPAA2 devices. This is a prerequiste for moving the DPAA2
Ethernet device driver from the staging directory.


Horia Geantă (1):
  staging: fsl-dpaa2/eth: move generic FD defines to DPIO

Roy Pledge (3):
  staging:fsl-mc: Move DPIO from staging to drivers/soc/fsl
  drivers/staging: Remove fsl-mc driver from staging
  drivers/soc/fsl/dpio: Convert DPIO documentation to .rst

 .../networking/dpaa2/dpio-driver.rst               | 30 +++++++++++++++++++---
 Documentation/networking/dpaa2/index.rst           |  1 +
 MAINTAINERS                                        |  2 +-
 drivers/crypto/caam/sg_sw_qm2.h                    |  2 +-
 drivers/crypto/caam/sg_sw_sec4.h                   |  2 +-
 drivers/soc/fsl/Kconfig                            | 10 ++++++++
 drivers/soc/fsl/Makefile                           |  1 +
 .../{staging/fsl-mc/bus => soc/fsl}/dpio/Makefile  |  0
 .../fsl-mc/bus => soc/fsl}/dpio/dpio-cmd.h         |  0
 .../fsl-mc/bus => soc/fsl}/dpio/dpio-driver.c      |  2 +-
 .../fsl-mc/bus => soc/fsl}/dpio/dpio-service.c     |  2 +-
 .../{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.c    |  0
 .../{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.h    |  0
 .../fsl-mc/bus => soc/fsl}/dpio/qbman-portal.c     |  2 +-
 .../fsl-mc/bus => soc/fsl}/dpio/qbman-portal.h     |  2 +-
 drivers/staging/Kconfig                            |  2 --
 drivers/staging/Makefile                           |  1 -
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c     |  4 +--
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h     | 22 +++++-----------
 drivers/staging/fsl-mc/Kconfig                     |  2 --
 drivers/staging/fsl-mc/Makefile                    |  3 ---
 drivers/staging/fsl-mc/bus/Kconfig                 | 16 ------------
 drivers/staging/fsl-mc/bus/Makefile                |  9 -------
 .../fsl-mc/include => include/soc/fsl}/dpaa2-fd.h  | 12 +++++++++
 .../include => include/soc/fsl}/dpaa2-global.h     |  0
 .../fsl-mc/include => include/soc/fsl}/dpaa2-io.h  |  0
 26 files changed, 67 insertions(+), 60 deletions(-)
 rename drivers/staging/fsl-mc/bus/dpio/dpio-driver.txt => Documentation/networking/dpaa2/dpio-driver.rst (94%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/Makefile (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-cmd.h (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-service.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.c (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.h (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.h (99%)
 delete mode 100644 drivers/staging/fsl-mc/Kconfig
 delete mode 100644 drivers/staging/fsl-mc/Makefile
 delete mode 100644 drivers/staging/fsl-mc/bus/Kconfig
 delete mode 100644 drivers/staging/fsl-mc/bus/Makefile
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-fd.h (97%)
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-global.h (100%)
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-io.h (100%)

--
2.7.4

