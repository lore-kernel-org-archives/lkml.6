Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E73C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FFF42089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Ek4XCNgH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FFF42089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933352AbeGJNT2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:19:28 -0400
Received: from mail-eopbgr40043.outbound.protection.outlook.com ([40.107.4.43]:35472
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933132AbeGJNT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 09:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtlY//wcP5C2nkpU117AI9jibXJu0fJGIa4I+ubl7ws=;
 b=Ek4XCNgHuo4viqZP03e506EBm/VT/MDldVhnEfLClNOvj57n5y4wHjlIit7O7inNv4uNOGZN5ZMDW+KAQ/zJ0jAZUHbJ4s21J0bnKMWK7gZk0Z/MzBwqIYSqLDTlR7NgQxwOqCUiJW5DJZoL0O1aPIAl6mytVl3yLyF7DdQJDpQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
Received: from e113505-lin.cambridge.arm.com (217.140.96.140) by
 DB6PR0801MB1384.eurprd08.prod.outlook.com (2603:10a6:4:b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Tue, 10 Jul 2018 13:19:23 +0000
From:   Ayan Kumar Halder <ayan.halder@arm.com>
To:     ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     nd@arm.com
Subject: [PATCH v2 0/4] Add support for Arm Framebuffer Compression(AFBC)
Date:   Tue, 10 Jul 2018 14:18:53 +0100
Message-Id: <1531228737-5450-1-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: DB7PR03CA0037.eurprd03.prod.outlook.com
 (2603:10a6:5:2a::14) To DB6PR0801MB1384.eurprd08.prod.outlook.com
 (2603:10a6:4:b::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 775bcb8a-182c-4abe-beb2-08d5e667c117
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1384;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1384;3:JTaLFJMpVfGpOHNXtva7qG6AlajChrO0rMnMbP9RK0ZB19ygN5NV4aqRQ/vbTPTgllV+4OYxYXCM/phHLckgNdpODcO1vC6cbvt59wbqlCS6vGYLYqODUbJ1sIscQyjxQP8r9CxQGlL3qCe0U45qDz8BUWKJ8x/H9Gy5WJwftCl6pmomGZ8dNpT7Pqc9d/F9AD3mCoXRcQZdQ/5eIJTvpmxX+b/qf9r+HwbmThMDlwJSzZlaXvpKtPMtWjwUOuz6;25:/T9KVHMWXtdQj591vwAVXxuEAgJaUrV+O25k4Lzi2zWwiw+ss6aCdFO7t+01HZy/NUkeLKA3E4Qw85PwhiLDfTtj07aJF3LKhhdGlCCGs8EMGDhz1Ye4cUu1bskXYpl4sUPSjLiEbW93lEyqmyAQRJynBQTyKLV7Mb4+vflCbvombdGBw7Dks4nj5WrPM5URlxs/1bwF90bXnFUBNsIi6KS3dqlFTYegJ25LwegsXO9r3j6mHPGXN+xA59wABdoib5qr+qgXDQpOqNwTP/0HtqRfUzfMl3bzcabplwD9K3XD5qiMyEbyYZvQvGdX6GPrmTwFH3RohSMnxEZgmwMtjg==;31:vHILXwa1LSTQgVmc0+SfmEfVu93PbE91l5bnG96jqHS1aW97f7yb3eonXhSY/EnD4E/gYWETXudIzPCy7528Ir3a/sUn1Ur5W6PGy6mtY9Mt4KaHCDkQzHF7TT3k+xkssIG/V8Oy9R6tWlO8u8mPioYgegHOE3lXFSMkPq8nrOCarpvpjIt0RLKgAoyXl54T68BiBJvTRnCdbM0vqCP9baojDniyiGPMIQ+7LZ4X/Ls=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1384:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1384;20:RtA85nREcWTNG0XT6wlh217lAYW7KbEIqzZknhIywGxo30AkxZrIA+ieN0Bz2SPC99UvKDWRvq+LTxOhZs+rl8XYJSHehHaVdVcY/m12ilbyIoTsBbZ85JfLsgSaF9r/4+FftE0xQLdBbt8CQ1/MDTqU7pdM05DhLhhzj3D7EsI=;4:c8nCxV6sYvP87AFJ/hIblInfMm78NP1uItC+h+ffGgTwOtmnKmssjD+pzPNSnH2iGA72pI0hwTLX8S2xyyKdIj9q3LXxwB51sHJSZoOLgpCYL1d+GGr5KzZFBmSjuSvbGdu9U/WLmO/dbpclR0D5ccXD3tCYWaP96U8YYkkI/klxRbP4sZqEn02DKpA+Sk1oIhL4FOEBegs8jEVkOC0h96Scfrss8RuPswyvX6x8VQ97G9VvsFZWevy2WZzgnY1lHeHjtDLsLJsg8JqOX0TTSNuEVBEreQCKbAIi4Ku0O1530k/yixjhO43qdfjMKz9g
X-Microsoft-Antispam-PRVS: <DB6PR0801MB13846E360EE1FAEC5286E03DE45B0@DB6PR0801MB1384.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1384;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1384;
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(51416003)(7696005)(52116002)(5660300001)(26005)(386003)(36756003)(7736002)(305945005)(6666003)(68736007)(16526019)(8676002)(106356001)(50466002)(97736004)(14444005)(2616005)(486006)(956004)(476003)(72206003)(48376002)(3846002)(105586002)(4326008)(25786009)(2906002)(6116002)(53936002)(50226002)(81166006)(81156014)(66066001)(8936002)(47776003)(16586007)(86362001)(478600001)(6486002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1384;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0801MB1384;23:gNPvT1Mp91ecy65u44tX0IRgiNRWIRJ+KD+jYOL?=
 =?us-ascii?Q?+marK6aD3w73mzIy9EjEESw/qwmkadwCk7NJJ5UwZD8FjJGwZMymArQsdcjR?=
 =?us-ascii?Q?t23fxQGAZm+HQcpXr8A7l5fbU48rFOULiIcAp0dNGIxCJTkJPgmIE1usNwHh?=
 =?us-ascii?Q?iSf4daqbmNW1fNKnC/F/Q9E/Wv6FXnioxy4EVNVW0y5bzPnLo18C4TupDHj0?=
 =?us-ascii?Q?zItDZFayCEIJEjgW/Z+Y10F4JznASbHuAAoRIvt0oZHxtcmy47hV1o7keSdc?=
 =?us-ascii?Q?Cua5vwPJm3lpkx5MnQw6gOxbx142RxMfCOxerDMdvGuMUFo6QGbXhou5+wIa?=
 =?us-ascii?Q?A8zW0VINA0eYxCSEXi4qxhcvSRGAKabytRq4cpPX+3qhFiJpIHFrVo/uQy/E?=
 =?us-ascii?Q?CW3x6C2QVovjXdF6bAH2KA8v2Sncv8grCShCZscERQJ8sWgtZteBXBazByTp?=
 =?us-ascii?Q?uguXrUwk3+G8dV3gPIgrAXMgGa+VXgOYNuC3PogvOoQdrpSbLePDSxAjUfbK?=
 =?us-ascii?Q?8TxiB2peyKjbRfGOywCqgpj84vohLQcAgVkF9q2sDGS9UQ+jjRAEyBtFncks?=
 =?us-ascii?Q?C4RpgEChcwbh4qxNzw6DjtELKtE1YS0019W4LDYPUMWe0xFhfAyUXyua7saI?=
 =?us-ascii?Q?V/ETBIvIlpXyOprNfXceToa3Yth6dFpvP6HD7tsUTdMLL/NaEvVIf5Jm9fsA?=
 =?us-ascii?Q?3d0iS9/zjZr3Jps207jKsW/C3ZbsfsmXvGg9I7i3TVDeTjEb2EzPlFbk3790?=
 =?us-ascii?Q?OFqDUbJywBT2wGV8a4BsFoA5LM2q++5a8kHm/gns4I7CsZnK0Wr9vRDH1d6u?=
 =?us-ascii?Q?ag14+1bNNwVs0AVfHaYsQ26byg6noLBJipc+VchPvbJqL/uQDTTEskSd5iyN?=
 =?us-ascii?Q?65aXcW4BfU/n+evQ66HLfRnfWymy0bKuAzAMi8sbtx3dW/0JwfmlaWBn71jX?=
 =?us-ascii?Q?8yFpf4qq29sD3KL7+aayEG6eoPWSsWsx9AaxwvnEOCnZXZDzkZ1d9KFYfZ4J?=
 =?us-ascii?Q?Mn2jE23UiQXDugzWaM/xbABDU2TH+S/bZC/8KgrDYi9a+DLwwkXViZa70lk3?=
 =?us-ascii?Q?ffMxxs/Z6Lla7TjA7qx9UdrXnMmyo1Ov6gXz8JgPeq0TbbU1E0A=3D=3D?=
X-Microsoft-Antispam-Message-Info: K4dtkjuf7SFz/oOhqEf0d53mH7FvRnXN4LwZ2wQBdRf9TzMPZnHuSpIzfienycnBlaYZUwlO5TAlkxYsoNxAt4Kkp/3T26o4T0/VvKxtDirsf3jRIv5ziZwvTRdpvG4+tCNrzC/2/IkgMWRgMR1/dgkAfoI6Nth0wwGZT+BZS4qLm5I3vKnrSHwClC0zCv+GJ0eCaM9BG9zhaZuxpnXbskEsDZLY0yQ1CIA6Kll788bkGt6be51A2wJsL4ae6i9QNwQwPoDHvVAGdS9H8/+5749hHQ58Vxxq+eLiQ8VErgJMTvGS/cxtF7kcGjMBFKrc7ou56z1A10coeEp+N/1/Pwfup91SLZOwAEZEyOOM9IM=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1384;6:Lw+6FKmoU74qYkK4BX5uoCkCbVx+k582tGK/CGnOZMB68x0dJ/CT8/c1e883OLybIraP5TN6IvuSnTZ3DBmtkQR0ZshWHDZ4R10EEFXUwzfDTkaUEP52PMsPp/yviBBcp+TKs26O+UulP996emuhxzTa473tKTId7Xu+zcAG5cMu65kjLnksfhlTn/JSwLeIrSHlZx+roSp3jl2lANFzwDU/RXs7gvZtHATTpMxKMccJbs67YA0gTNHeFSCW0zb/qvCE5G+voso3laN2ifihulisSuF8G6uWFBFLQ4lrsbPrBjiLBojueRihHNet75GzqQT1Jny1DNOxoAgJhKi+cBPz/rngylTKRsPJQxQmzytk+zD4E5O0HdqudGTNTj1FL71UILCgRXJu5HeAKZqMeji2tbJ/iXkPCl0+5X3ohtpkr5y91nPff+vwCxD2b72FnV19D7Qg0bSXPh15Ak22nA==;5:jIGRzIT1IcTadKdgJp1UcQtw6yZXVfAzBP7O7OLstU31/MJLf3qA22nrQDSEH1aI89klBNKtNcpGc5GBNTMq1CWZOnhHo6llW1woQ0NHhS1vmFZzG27ycqN9yTm8zBhp/iK4Yz9/9Wph1n1dhyzdPGshvguP3prpjzGJ/cxq1U0=;24:0qkZhyHGS+mKi6rSK0Tq+79J+Cx5P4F7ul0gg0d46gMxw73QI361vzANcVkV7//cSu5Fc2YbMeBakyEGy7I1dTOf1puJ0rokzuENwN7rvJs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1384;7:ScwGTbdLvNYMzsnNCMzPvRXIBFEgDmC1Eqt8YzEMbIJ1bnnTwjmeHd1ybiak+V9gMza0pMDS4KMZeYENEuCeyCdaAITeGIgOL9a3pbR+Cu8ahsXesCoI5VBv7PutmDG8AcwfRvoGsZSFN0b+EufOwe8QA0swk74W+s5MImU3qrmKRDd+QpYoKw+T+J6GjDXsLRhSS2Jymk/uj7iIwwZZwaKqGnloZB2FTAcdq3+o8GeC8ylMb8svKFJDHjq9lq4+
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 13:19:23.6610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 775bcb8a-182c-4abe-beb2-08d5e667c117
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1384
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current series of patches, we are trying to add support for AFBC
modifiers in malidp. AFBC modifiers adds some constraints to framebuffer
size, alignment, pitch, formats, etc. Here we are trying to add support
for one combination of AFBC modifier ie AFBC_FORMAT_MOD_BLOCK_SIZE_16x16 |
AFBC_FORMAT_MOD_SPARSE | AFBC_FORMAT_MOD_YTR.
In future, we intend to add support for more combination of AFBC modifiers.
Currently, we are trying to enable a basic support of AFBC in malidp.

Changes from v2:
- Added ack by Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
for patch 1. However, this has been kept in this series in order to help
reviewers review the other patches (which are related to patch 1)
- For patches 2 and 4, replaced DRM_ERROR() with DRM_DEBUG_KMS()
- For patch 3, reworked malidp_de_set_plane_afbc() so as to consolidate
all afbc specific register configuration in this.

Ayan Kumar Halder (4):
  drm/arm/malidp: Add modifier definitions for describing Arm
    Framebuffer Compression (AFBC).
  drm/arm/malidp: Implemented the size validation for AFBC framebuffers
  drm/arm/malidp: Set the AFBC register bits if the framebuffer has AFBC
    modifier
  drm/arm/malidp: Added support for AFBC modifiers for all layers except
    DE_SMART

 drivers/gpu/drm/arm/malidp_drv.c    | 129 +++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/arm/malidp_hw.c     |  27 +++++---
 drivers/gpu/drm/arm/malidp_hw.h     |   7 ++
 drivers/gpu/drm/arm/malidp_planes.c | 129 +++++++++++++++++++++++++++++++++---
 drivers/gpu/drm/arm/malidp_regs.h   |  20 ++++++
 include/uapi/drm/drm_fourcc.h       |  83 +++++++++++++++++++++++
 6 files changed, 373 insertions(+), 22 deletions(-)

-- 
2.7.4

