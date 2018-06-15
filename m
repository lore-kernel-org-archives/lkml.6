Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1C5B1C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 12:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB18208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 12:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="OxmZdK5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB18208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756203AbeFOMyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 08:54:52 -0400
Received: from mail-he1eur01on0041.outbound.protection.outlook.com ([104.47.0.41]:6016
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756117AbeFOMyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 08:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmzC2PCr47i1O24uWhuJny2zh8gLLRkQpSVTb/gP4gg=;
 b=OxmZdK5Q/5MGsZRBy6h0qMX8QRW2gRkaFBOaXDRV7RBPIPZP6CXIxfliFAqttLEdNLjLBmbcOAYyBilL0j5liDAMcKwgSYFA5EmsL3hdWotG8YFhUeBzyNlMNJTZmIXcxoWgHbSj8kNUyMwhA0aQxeE9FrZQQYO3KHiJ2f9Owjs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
Received: from e113505-lin.cambridge.arm.com (217.140.96.140) by
 AM5PR0801MB1380.eurprd08.prod.outlook.com (2603:10a6:203:1f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.17; Fri, 15 Jun
 2018 12:54:47 +0000
From:   Ayan Kumar Halder <ayan.halder@arm.com>
To:     ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     nd@arm.com
Subject: [PATCH] drm/arm/malidp:- Rectify the width and height passed to rotmem_required()
Date:   Fri, 15 Jun 2018 13:54:36 +0100
Message-Id: <1529067276-18566-1-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: CWLP265CA0251.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:25::23) To AM5PR0801MB1380.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b9e62f77-aca5-42ae-f07c-08d5d2bf2d2c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1380;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1380;3:xS13nOqiJNajzC6ltgmOuKGOVZ3B1Vahf2HdgZOtccATXE1ccFf5KaWVK34zZIuOUr6cnZPTodL8stRsX/0NYYxo9KMhQiMuYBNCQ+rCYr/80EQR/GJQ6HMLXpVhbVOohHK5Clhb9edyOj6G6GQ6ExF0YSEiBncavpqjYIuPrljxShE377eq2QchroCe0JLiDLJPvcVyAbgUydT9wbol/HuU24tm3fzsAfLUpbjlauYh+WGWFwDftu5W1qprcbqh;25:vV4yyZwAd4pbMWJT6pKxoiG5oflhXwVF2w2AIpMCyZ5scxhnevHeFgfWIuEtXYm4TtGSg7SrosZTYDtet7xbbRZMwB1hX0flM+COjNXw4zPUx3ShMmIqe1ZxvLeCrJzzr/917YtWfTFHK60WhJNsljVh2owxltSyQXIureOgNH5+/wxy7rBAk5X0cCMZL8ChAAXDmAF4ix5oLNvR4M/U8eNKMLZqamha/MEmc14aJpfa0caRkwQTWG5TKwS1vVp75tD7xxCU5UQo24VBG39C9UQ+IaOMHAscN3HHGsHfxKgAuFYiLnPVegeCi87YYBO5clFhyubNmDn36tnnKUnVIg==;31:5ajnle5gyP1hFGpRGA/7lKw/pqKRrHXAbdAjzTd3vJqD4jOflSXI9jv7tdeWsgGoWF3pVSG+KjS0ruw74C7U7o+WEg1tVicXLEf5A2rMQ/fKhJUvyE68xPxsaXYWj+1qiiUlBeGBwIdQ+jZ/qEW/1KqYnStbdQWGf1mcWoU2wUVgDjqq9WMBNdLm+dx9FqjsItzcj41sAF63FWZkvm7rZsdEhePEaBGME99sAEIvgMA=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1380:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1380;20:RC9N6uSb1lP+vpKaeWT3fqR6cf4DBRm9Jqwe4ryjv+1q9meu7jVcho3eR4RQSS3GmLVijVpPUZLN3YGHKeABVFD4wFfszHCe8qCOnHF4hoTm8PNLNyf22l88JqGGKNsx5jL69o2sMAY4pO+porVTBpgVN9yzj7Sv+6ImuU+wg9JodLc+ErWcflFIBC1579jaev4/VLPUGRiDDivN4AztqLS2m6mQm6RyFw7AgRbHlcpbN+W+tvZ9owV/QVdm8eWP;4:ivFTrID2XSCF1Gn2nhSwNDbymGuuOxqbtmxxdpBQ4NeFbCSFkFDActVROTlqnDI2Z+heZg5DDt+TSeFGKmrFf5jaYNng8JhhdhXWJ/tGA5rWJYJ+ikZfpPyD/E1hYtdwxyZ0U+GDKXGkf8Xj6sACHbt4wKeJv9MDUeibJU107WweisM2KeA+p3ZXfnRKX2ZISOxX/xPOGbu4aluyo6T92773vxBmc2Xhw589Fz4SX5gJPePV/o3jR6PmmW0x6JxbBWmqVpSoC74UIdlrf6/G3wSNln67iepRuscmJ23tbe/TpQIZj1mpn1Zof2QS8QN8
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1380F87AF439580448528503E47C0@AM5PR0801MB1380.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1380;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1380;
X-Forefront-PRVS: 0704670F76
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(39380400002)(366004)(346002)(189003)(199004)(36756003)(7736002)(8936002)(81156014)(105586002)(478600001)(6666003)(97736004)(72206003)(47776003)(106356001)(6486002)(68736007)(48376002)(50226002)(66066001)(86362001)(50466002)(8676002)(305945005)(81166006)(486006)(2906002)(51416003)(5660300001)(7696005)(386003)(316002)(16586007)(476003)(956004)(2616005)(53936002)(26005)(1857600001)(4326008)(16526019)(3846002)(52116002)(6116002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1380;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0801MB1380;23:wHnlI+7L4LnJwvKRoryRtPbrV79YzgW3pm+blfe?=
 =?us-ascii?Q?mjvICcukdwbcyM7ve9jjO1G2BBsHv+dKZbKj+WxxVu/FP+Ic+J6IQQBGThNr?=
 =?us-ascii?Q?VgPxBj17GgZLR2jJcCWMT+mZjn1Cp7jIMdVJ8OXbJ50w4g+Qqpynwvpl5trO?=
 =?us-ascii?Q?PV4IGP0CVw8QEY/rTjXv0KfTLwFG1hbnaEfaSV9h0BtPKW/v4bIM52vN+eng?=
 =?us-ascii?Q?r8YFJFz57fZ8wXBOp9PBo/nbLTVXZUl1EpK7OjM/kJFaiKckRr48wfm6s4N6?=
 =?us-ascii?Q?kuhKZ2Y/ANJ0KOu8b0LIfUYwRIKIP3WDTfrS2w/Op5ay+uCCluP0J6NkAH2x?=
 =?us-ascii?Q?jaWrZ9niLq7HjWGgygT1dygymsZ6/alscIeAnHSctYmQpaVNcha6ZNv3WSSd?=
 =?us-ascii?Q?Ba1yFwdlF/Tmep9fSrH8stShb4Z+vPkPHeXv+bzZP60T9G+fRfTmO2jBciIr?=
 =?us-ascii?Q?mZhPb33rxFYXe1Vvzm8ee5kQlMaK/5kAZwA+uC+MnDYWRmngDcbZrj5toiKh?=
 =?us-ascii?Q?MSAQODV6XO4fJHO1aMYpG5FgTlzyGSBVcU/qemMi6X5lPsT5yEgV4VXLWAzd?=
 =?us-ascii?Q?2csExpT8bZqpBqkE8RmyHCP0tdOyj2GsmoVJFWgIeHHk/Wqfb2z1WBSeVOfb?=
 =?us-ascii?Q?rlj9qdDLo9yDCCYx9MOYZx3hdmy0LrC0ZS02xalW9KdchVlQ9G7j2Q5Umxbq?=
 =?us-ascii?Q?mREJmomVoZW16p43Em+HBeF3EnILwY8JK3ouA1orpsyDY/yU4+8lGJVynJ3V?=
 =?us-ascii?Q?6lQV9QHL3dhUJmYHJvj6fs8ludtUWGIoxROJQldB3IMPVCS+hqaziy5GGz0L?=
 =?us-ascii?Q?0DEppDH+ozjoV0tbRDvbgqF5NVa645ULWaiaCjj2A/rYHK3RZT3v0fHXrISK?=
 =?us-ascii?Q?YlZi9WBqSjhOUjP7/kxQrp+NjfeRIJ8EElrE0kesnPBfa1tDekrMLoCqueQt?=
 =?us-ascii?Q?ul/9NN3RPI7XyeM77Hth4jHf1rTpnWF/ZwsyiQMHsIdPArUSULmzBAo8EAdm?=
 =?us-ascii?Q?956GJvldi5iOedresaOVueZRK+5WZ11FnAedp99dle3fFeAtWkFM9t2dF5dy?=
 =?us-ascii?Q?RARq+lZKY5aQNhdwuNZUAUE97WcD5pGYp8Fm4edBEZt6KceFK9P07IC72puo?=
 =?us-ascii?Q?r26Cj8PcxvbM=3D?=
X-Microsoft-Antispam-Message-Info: k6hkSO4da1TF6jHRTigvJ9y/csbfyLmgVs7mtS/B2IzpLJIcOL4g02HfGf6oTI7s0ZqxGhJeUWwQwe/3amFbM7X4TauN3ZwYPJyQsrmIW0VrLmPK8RSDUdyTrc4aSYNmcnub55KVo+2yT2Z2xWpo9qB7FvBA8cBvV5qXZtliUJlANSNwMdehy1jOV+RBx4Eh
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1380;6:bjnuTyrzDLJOpcpQEQDm2hI/FMcnwEGaDGd+V94DpS9f7ANECuVLvFZ1TwxArydYKE/2+JQQ/SjI+mYPTDJ5NmTjvfzSUBOuuY3vYjFP1KeYC3ie/GEtAWSAycG5snhTr4KfoSgHIu6SSnPjFbsuFsjPKSAO/Nm1fFOCkxpcQ1el+etd4ahRmnIo3f3F5lvEZ2czg89qZmGm/zav025mHGSD+nem92ENPEXME3ZUP7c7/I0cebWyejb4bq3td/5DTgIf5n3h+nOl5x67g8mwtY2G+cFuX1EtRyNnnq9XcTDR1HPjcLQPX64c9nsQ2XQsg2yl05EEGyoC0E719xJOPdxEfeAmFWNb8bfrYFEgV0+XUeneyknoXWeNeUSTISeQwPEwRhe8OYb8zRnJSx/0e6qaYevipZTSGjMuaWfacNjtoHXuc/PBq3hQoe8Nz7K65vYnf8B8vx3NqNlPJ0S1MA==;5:/Jy7FmLp0G2HrebGvP4Elnz5ycUqYF505SLGN6pLKkjMQvRiCuwrIYOsBPPuqdRyFdSV8I2gtQNmvulhQf+1GuB1LFb84gGshvqxt4yI1B9aS4xixjobJkaeOd4sJvzPVuP1WGpjJgMSUofU7c86b2QNjoNwWftIyxp3bc8HN3A=;24:6eNCBjBs1rLpx8UokMYrVUslvamDhYTMRZby0VLyLvf10m05kO22YpyRbbqOXa1ENpjklCO+4Jy0cgf/6a3/gtprCiEG78J43p+0Dt7HKU8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1380;7:7+DSZyB3ALvBaeQsXuPNtzhVbEx08SXQSxuXbQts9Mtqd1SRA2KGqcQ6Zqrxl3J3FqV3jGI9e7OyXuvgH6j5lfaXPcA172Osr8G7zChBLIYYl3r6HnmxOBol0d3OC04U6dJxzmUW3Bk9IdnM4jSu13LYU7KvFa1hFFbuC6Z1EQDkywQKPoyG8y1Tl7eEo9QoFbxZznzzfv6JzGiJD5kZJUskdSYsZSRuSEuLBYV3ryOiSY2LV7JI/ZXokEZ7GRty
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2018 12:54:47.8547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e62f77-aca5-42ae-f07c-08d5d2bf2d2c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1380
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The width and height needs to be swapped

Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
Reviewed-by: Brian Starkey <brian.starkey@arm.com>
Reviewed-by: Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>
---
 drivers/gpu/drm/arm/malidp_planes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
index 377382e..533cdde 100644
--- a/drivers/gpu/drm/arm/malidp_planes.c
+++ b/drivers/gpu/drm/arm/malidp_planes.c
@@ -244,8 +244,8 @@ static int malidp_de_plane_check(struct drm_plane *plane,
 	if (state->rotation != DRM_MODE_ROTATE_0 || fb->modifier) {
 		int val;
 
-		val = mp->hwdev->hw->rotmem_required(mp->hwdev, state->crtc_h,
-						     state->crtc_w,
+		val = mp->hwdev->hw->rotmem_required(mp->hwdev, state->crtc_w,
+						     state->crtc_h,
 						     fb->format->format,
 						     !!(fb->modifier));
 		if (val < 0)
-- 
2.7.4

