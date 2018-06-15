Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9BD7AC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C47520896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ffk3Jl4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C47520896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756175AbeFONvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 09:51:47 -0400
Received: from mail-he1eur01on0062.outbound.protection.outlook.com ([104.47.0.62]:24662
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755645AbeFONvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 09:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpHOM7iwnmq/Y9OZfYJzAy2AYU9G2eNH47MGFNhYEj4=;
 b=ffk3Jl4JTLOQccwODjR8iP1d0oBfdUjYSENH1fiDWmRgTjiIZEf7zLVz7FMFS1kZYkyce6UUlXzFIrrlD5NbVm5e4So44LdOySRwmfc+JzINp1PEUC0go70wSJrlqaCjfR6W/Ad1eGJEsxvrjPVmB5n8H9ZQxlCj+1l+hqJr4as=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
Received: from e113505-lin.cambridge.arm.com (217.140.96.140) by
 AM5PR0801MB1378.eurprd08.prod.outlook.com (2603:10a6:203:1f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.16; Fri, 15 Jun
 2018 13:51:42 +0000
From:   Ayan Kumar Halder <ayan.halder@arm.com>
To:     ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     nd@arm.com
Subject: [RFC PATCH 0/4] Add support for Arm Framebuffer Compression(AFBC)
Date:   Fri, 15 Jun 2018 14:51:30 +0100
Message-Id: <1529070694-21088-1-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: LO2P265CA0171.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::15) To AM5PR0801MB1378.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c92f08ac-8928-4141-8ee3-08d5d2c72030
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1378;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1378;3:9Ifx9pHUhtEngbPOB6TIijX+TfrhcSn+DxmhAWDI9pC0KXi887sPrbh7Gf50w4do4WG8+DDN9NrTOMP6+w+L6zx7fGCvMtSCP6RMxqlbHbAZwsxJC399dfHl9ce4ZgXfdzpRorjcPWFMaOQQn0WA6c4CvoLA1zU59+QJ/PnsAgfemYCEiwz/YSunmu78YAPgPZIwDVMdLaIUZUnzoDpjcvhp0hz0yRUnfxCBDMYU1qZ/t69jiJ/TvqzOXPOZ1QvO;25:vKyhBGwiN/d4GyHF8ZTdl2gt8BO3fW/rZ7JoUvXeTKLlyoy2jULc32Mh1zy92BJd1Tk0X0D7tHDl7I39TLqQPoB0fOh+n7+wl5iYp2Q6lRaeXbdHRaYQApFmiBf4KSe1fGwgX5UnflT33aCvaxVntysAEf1YikUoRtvEorKXNaJp898EdZRC5OXRkTGF9JrsNDWFKC50YCZE82A5JkRyvah3N7ohaxaT+MVDz54zpY9PQxCZj877MVgtLb/03m57QB7zAh7F6rCwB7McCAmq9kp8NKdZc6gno/cl/zqiNeI7wxGuA2NHDcDane/euRnjzpCD1YCjwe/wLtHbUvV6NA==;31:UZMGe2Rki9ygb29izeCe4rM/gABWFES9pZWQIwNH3THJsZ7E8qyD4oxLTenRfkcvPqPpZwMHaGLzdkUEZzmNex5OnPmybsazn59c/8Q9M2dBMph29DUyE1PwcW98R+FQQJ5Cs1XPpRnFoMvzPL/ezvOt1c+n3HyHd8ZrRSdmOCSfrTDj16JIS5fIgcI4ZD6X2ktuS6ZsI0cTl8mrOUCbjSx0QawnDO+aTM/ily8Bvy0=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1378:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1378;20:nMB3HfhPTYfgsi8YKW4h/nVee8mL/8wQyC91Xt5zyiBIQH11ny1HtmhpCmGr3kJVGRD5BiOXBh0r+n9hhuopKyBlL9O43voz3QTzS7UwDnfaQxhftOCzQT8/rcL+wpmNF93PPrC5z+lePjtMta+gXtSOUYmgF31S4O8oohrupjzwEk6YF91igE1NiAea4yQiuxHkzxzLNKoIJE5aIejgqxajva6IaE3M0+Ulp+ANS8L0B1NVfqL2XN1oGbRqnSbx;4:ggD4jMNKHgHb6q2kcBLtT564LlkGg1F+zM4VgRHUDHt7Lnvll1Y7UnaedK3WfTuvzr+R3BxCaL6tRf73slVH1ptezLFE+dkGC7zkNoOTecG82tsA6i+qVy9PVsqkRiwjezgDCkuxw5isHZByusTre6LT3FZh1eicCKxKedreZjC7C4fp4qLaczjdpThfxEoOCAM74tf5vySQ7WGzttH5M7wgtNLJbUhW/r8eaPilnnRFhmzCBsGsA9pCApQE81ZMvdukE7+r+z46I2OrG3tuOA==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB137830608C711B06B7A63CC8E47C0@AM5PR0801MB1378.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1378;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1378;
X-Forefront-PRVS: 0704670F76
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(39860400002)(376002)(366004)(346002)(199004)(189003)(2616005)(2906002)(476003)(5660300001)(47776003)(8936002)(97736004)(7696005)(52116002)(51416003)(7736002)(53936002)(386003)(486006)(66066001)(956004)(305945005)(26005)(3846002)(6116002)(50466002)(16526019)(6486002)(478600001)(16586007)(68736007)(48376002)(81166006)(81156014)(36756003)(50226002)(4326008)(106356001)(72206003)(8676002)(25786009)(86362001)(105586002)(316002)(6666003)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1378;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0801MB1378;23:lPtPw6Qc03wz4Aw6qyIPmSLXMy6w7nuGk5S5o/o?=
 =?us-ascii?Q?KPace8CyOgkmppFULznt/VpV5U8oNWeN2XSosYtqIqRTUU5j5oN95MdYJqfJ?=
 =?us-ascii?Q?ekpTpdlbxzGpm1n/eO1m7caaJAcT7zAX9dImr9/hjyxPdROjbPruSBkULiQg?=
 =?us-ascii?Q?wg1RzwtbPYzGOuzLuyGyCE7mPZJw2hCdwcU0XSCItMcVEIhgAb+c6WixQPhJ?=
 =?us-ascii?Q?TlxWDj7j7+QzJOiWbPvckAmusWLG+6IPvGirxTotykrF+kn86Xn79s7w5Kr0?=
 =?us-ascii?Q?B+0LL6nVeHDgCWKLcmX5ZySQMaeTjOhVLxhcz4WgegG9GLGsbLnsWJXbP/Pq?=
 =?us-ascii?Q?mRwhVXpx8xHgV2KIzkQklodVKuh8+ZqX2whBaDAPU9t83KxDdmyPAUD0IoUC?=
 =?us-ascii?Q?c0DRgHzAEpAXsyHiePqAazzF3iWlpLJ/x+bguozL4iUGqxx8c06JLXNlUG0B?=
 =?us-ascii?Q?C5eR8HgqRKJXR7C3pFobYdJIRvy74wITZB0hx019M+zZcbNyLhZWLSuFkVRv?=
 =?us-ascii?Q?4tNOaZ6cp/33hvd5QJPqHN4yF+AM2rTfk54VjYuAzbGZRQypukuaGqpqaGb+?=
 =?us-ascii?Q?gRRQAWwO+CdIdn+WaccMJ/UJfohuG9ZKP05I/+yOti97z7KAswVclitPLzv9?=
 =?us-ascii?Q?ttyBGf2Iq73BV++aT8s6+gjBcLlUpbf9SDXQ0zIDQGoLyCGNG+1POUZ/owNw?=
 =?us-ascii?Q?7AUtdAaDsuWuE0oc9bMIY1ryl9Io/Kx672NbuPKRGdVD2Vkwgjajaun/Ca2X?=
 =?us-ascii?Q?pFZXkQ8h9wbv4lCDANsAqpI+OQ/pPCA4cWweD0vxzorRMj9ft+nYk6MI3AmM?=
 =?us-ascii?Q?dzwcwD1w8D09i19ziW2f1HW4jLz4ZqM6KnArhFK8YkGCQF4dH6WpqWsSWD0w?=
 =?us-ascii?Q?kPzSuFhbHI8RslF2FNzLm/hGL+Qtexfz2wbCT014eJA55jhqqv40g72vmATd?=
 =?us-ascii?Q?QWwgsvSR43IPpW+mbHUxaEiuEvQZ0oDqoejFr31IFvcCyvnTDLtowPfKHgIZ?=
 =?us-ascii?Q?Qhfenu5+sgTbXokyIfL+dTE29KDLjnRQup3ocK6hCOKBex8T2AFwgCsFTBow?=
 =?us-ascii?Q?uLIBP+osOJIzdNZK58MFLcaEHl3fpXfLvYK/rwgz15avHs2Be8uhGByg0eLq?=
 =?us-ascii?Q?mNKX9d7xm+Dw=3D?=
X-Microsoft-Antispam-Message-Info: /bfXUN39LyXAf9Itwh6p4WCb9m1uobt4AGlfvKqC1bcVVNYQD0B/YwY/hEIL2CTIwj0MjzrCtG5LOM0GzBZOlL0ZI8On1paDnwixwsd1QKWPR2zyG9K4+9NQdnQTwNPqVycqBiDvo4CO+6j0dEpNeIKVn1pQZjN3rAXsYzX6+g0mByP+07HFV+5DvLkwJim6
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1378;6:dV0+GewATEPcjC6OEjjTFFWNoenkqnTCysBESr0qBZFaVWxaBZjs8nGguOX2/I/GW/guqpQhDDL7v0SA3lxND0qvePRkp662MZL/Uimz6YOoUbkAMJRQwL56VvSxkCgbrkRR7nU2vbjhrYBhw6WsY4ZS/RS4vkJSiFw4rcC5ej/1gmsZ+JtLhHTtxgP8IJxfFWWzWM5DpIsZPVlQUntN0I4pa7YJ5MyGHitWLZthIksCrU4iqaGfxPfXnDm+aGyefV1j1wnev3DvgdQHWWujEYgl2NIStM36jLyQClpDshv6nbZ5TaehPf00u3udTGRd0HGELuFrIdSk3WU5ORUC9d3J12mge+A9h98MzdxqwTpG2Q01/99vO+rxFy5yAeLdAwKZc7qz+KL3MlDfsPDU/rZdTnC3uyYix5vDraqlBgR2BDdjp5Cx2wsYZZ1YJ8jMBrrg2Rj7siBdimfnyED2SQ==;5:AjeL8XGpS29hD9YbEBjhmh1KgvD7pSSrpLCIwBC+zcb3ETk+IL/HtGb6vSFz/0y6Vh7R5l5m+aWcTUccEZqpEaPLMRJPzB7lCmyeQrHyYGoPHEYgoQk8So90G4wgmYEfXWR1Re7iPb8f9dULY3PHwZf/SoQuTakY597bNW7N84U=;24:zRz0H9gROU6GIxFGCW+bIhV+BMp4yTRfKinKZzXZFTX9K/RXawTTQ199v8S7AjLkpEKFK+/1WT34KBT3gaemqEpDyaVQW9z9Q6Ky6hJqLE8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1378;7:75eNXSWXbP9iQ8IHn1OOAuFPZsUW+iduWkPHEEHXeCJ0MksnzVnQF5q3tb5aZiMBTR2TW+OXqXwstIJ0+bqmVaUx9V5G7Pq18GqPm5wqActXRQhiUflbr+oDzYIfNmCAaz7p2Qox5uDx36jMogdJbr5HGaOS4vaZ9U3c/N/ew5RAOVlGior6XkCniiPt7qDambB/mt/XnNswutOtxKpDD6WySyzTwsk5EJ8BfTU9e3v/OTaYlJkBKUW/i1aOO2Ev
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2018 13:51:42.1289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c92f08ac-8928-4141-8ee3-08d5d2c72030
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1378
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
 drivers/gpu/drm/arm/malidp_planes.c | 127 ++++++++++++++++++++++++++++++++---
 drivers/gpu/drm/arm/malidp_regs.h   |  20 ++++++
 include/uapi/drm/drm_fourcc.h       |  83 +++++++++++++++++++++++
 6 files changed, 371 insertions(+), 22 deletions(-)

-- 
2.7.4

