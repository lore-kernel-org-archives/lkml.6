Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0F163C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883EA208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Gzreyiu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 883EA208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965697AbeFOKzP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 06:55:15 -0400
Received: from mail-he1eur01on0042.outbound.protection.outlook.com ([104.47.0.42]:35040
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965590AbeFOKzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 06:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HD3U4PjgqAurxg1QdTqyU/SkupHIfvqQ34H+wkfCJ8=;
 b=Gzreyiu1PjxzGkioCdAi2xa2bWcV3J3djOLK/1MBH5ZygiDcwBkjGCbvrJDVMP6j3RdiOhgY9sMChAtMOg5cB2zwGO7yFIiVdcf5LNLrScjffIp++WvQ06/187I9xczeFQqPA3R4ooAJDN4VrefA05S8E15OeSuBew00ixgSWhY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
Received: from e113505-lin.cambridge.arm.com (217.140.96.140) by
 DB6PR0801MB1381.eurprd08.prod.outlook.com (2603:10a6:4:b::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Fri, 15 Jun 2018 10:55:09 +0000
From:   Ayan Kumar Halder <ayan.halder@arm.com>
To:     ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     nd@arm.com
Subject: [PATCH] drm/arm/malidp: Validate rotations for compressed/uncompressed framebuffers for each layer
Date:   Fri, 15 Jun 2018 11:54:59 +0100
Message-Id: <1529060099-12023-1-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: CWLP265CA0227.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:4f::23) To DB6PR0801MB1381.eurprd08.prod.outlook.com
 (2603:10a6:4:b::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cff8550b-d71c-4688-be91-08d5d2ae7662
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1381;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1381;3:pIs667CDWOqBmHv83e4JtTkDfShd4gQ4GC3MuueHVT1nN5BuEum79fOms79RekmFzTqXzxQnDh6Koq6j6XT1ScKM3EK9Ac8KZyPO2XIJORrnuY7DlKUqG93TbVW5RO9P8RXAINTxH09tOHKlMMuYyuEI3y/oxE6c2sepFOWrKOcOhMnvcp6qlnHLQSJRw81Z4rctT5W8TwX+jGQsd8nu+f9qOSMp4+avh6L1BzWfWq8ti6m/KVd7EnUuML2zvD7e;25:jVICQO/P612wlW6EofScAqvhsDf3QLr9geC786p9KeCpuxPNCDeKvVwNt2VqoOHLoHiJPQItfZKjWDp1yMRNLABhm5XrY4iT0Lt2acIGLzzAPg5d1r/mKHPTwl0tthhA917ClWD5/JNjhD18Grn5B8sVV2SrY0aVUlFCAGTtA6zYoEpRWgaLRjWGzIvi17gj5oLfdprd8ceoWzL+6RS75+Z/LBoD/PnxfiRH7qxD6au4Lr1KIvfMZAQcXMzlduOiQxX4+ZMQ6sKE2qM7s7W25lJ6uN7Tf907RieAg2UQNoGlbMS/luhO88mXalNINN3g8fkra8+bunx3cUsjnNO9Bg==;31:YQIS/Ci2QNBRvOJsdgNczTXcNI9UGi76WC7TsyPaoRUkF689dVS5viFrwISJVkD/dWWkJW5IJDrSEolqvKBVoB0N/aDSYvK1zqdPQJtAFnAqT916N3ZfkWVAgmEIRs3vj6U0rcacyBz4DZbIfr0/+E34oPt34Rd421IJlg8NWLSP4E/IL3TsH+VPpxJyQ3jUoulVO5XZbWiRYaA6yBBvA6Gm8NwvsCVyfIzjNrJObtA=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1381:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1381;20:yYsfdr6Iel3AaEUhMYVb4Ao6ma4aFP/gfG6Zjc3I5e1lBoqbSlS/1xnf/bcE1SEgulARRs4rYdJg7uBsKZlRrvvisBXyUQOxv4RZ5KtydQcUj9WiXlewVW/mdcMdxQPMc7klvtBBGh2yMckMpUZ+CwFHTBxB/xqoeaNorfTQMlDcKl2neo75fAX4MR+HopnCZI0cg+58J4HZIgh7ZOUs3J0WGeBUiU71bmdbdAJICKSBGMUep2lxRTkuJuJzHq45;4:9bkpxNtWi6H9tlwGliatBTtBJvCP5LAEuLuJUIC/peDi7zAhAIbw1MhhlFmBuzO4aPKcyu8JIXiCjir/RWS2Bly3q7CnbaKn+B4irn0klgHuMDfvIrlndkVl2tYRiT5BXU4VHwm5c16Vcx+KMQl+NDc4MvHNwURaASCxFEblVgfcOTNnwDyMgMo8EHwi9KnBaFWP6e6AWRKt/PJyYaQ2apO3z1jsQINXIJ5LrNIq/EsloaZRh4dMlwapjgyi4wJanLP4n4WCh5L6LFnCBI4NsF2C4pTtImLLVafcUx8NOHckTZ3LNwRL4x0ufrLn8cse
X-Microsoft-Antispam-PRVS: <DB6PR0801MB138152931BB59B89E88BD98AE47C0@DB6PR0801MB1381.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1381;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1381;
X-Forefront-PRVS: 0704670F76
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(189003)(199004)(97736004)(47776003)(105586002)(6116002)(16526019)(23676004)(81156014)(81166006)(106356001)(45080400002)(86362001)(8936002)(36756003)(478600001)(26005)(3846002)(68736007)(386003)(2906002)(1857600001)(72206003)(15650500001)(50226002)(59450400001)(7696005)(6486002)(52116002)(4326008)(5660300001)(486006)(316002)(2870700001)(305945005)(2616005)(66066001)(476003)(956004)(8676002)(53936002)(25786009)(50466002)(7736002)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1381;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzODE7MjM6TGowbW45T2hiWllrU00vVGF5YnYzTS8v?=
 =?utf-8?B?Q3lyN2VEVHMyR1RsaVZxQ29WMktMcmtzKys3UmJSWFdtWjdncGorTDNNOUd1?=
 =?utf-8?B?NGMzTE4zcXo5YzhSSHFDNjc4bXplTnlFbHkrUGY2QzRKZW1vMUwwWjZEVnpN?=
 =?utf-8?B?SlFMZ3RJWSs1TUFjek0yWHN5OWRlR3BaZzRReG5VZFBjRTMyT0lLVE5SNkVw?=
 =?utf-8?B?Q1ptR2NSejFRQWtFM0NTa1dyS21ZN3lBZDRWbGtjNjBwdExYOGlyekNMTm8w?=
 =?utf-8?B?MzlmT3ZKWFdEemovK3BIYi9MVGI5WWtQRUQ1WFBoODl6dHBaNzh6d29OSWJK?=
 =?utf-8?B?M2dvZ0dUaCtIelk0Q1BDWkwvUTBFL2JNUUZ0YTd1eGZmWFRYbVRSK0NLdFdt?=
 =?utf-8?B?d2NiNXdNTVRsOWhWUGovTzIzaC9mOC9zSGVyeHVkeTZubHYyNG1rcmhVVjhj?=
 =?utf-8?B?b2c1dGxvZWdXVWNJYUh5dk5ENW0xMnBxUjVwWEtLdHhGdnpSa0dhaitUelln?=
 =?utf-8?B?OE1nUlNHSld0VkZPNjgrWVZEc1VyU1diRDQ3a1M0ejJhUUtFc1BnaDQ3YnZM?=
 =?utf-8?B?WFh0cmo3WXdIZUhPVlRMbFRsZ2w5b1UrTUNMOEdJcE4veHN1Uk90VlNUeUVB?=
 =?utf-8?B?c2c0UW1sYXVmT3lPZmF6Y0JyUC9YbjhJbmFSeTZSUjNkMkhUU0paSUpKTDIy?=
 =?utf-8?B?Ni90Q3VZTjNiS1Rzb0FpcG0rUHJZQlpmSUh3ZmpNZ2dNTU5lSmlkemZJRWY3?=
 =?utf-8?B?UEJBeHQ5bFVMbVgrZURueEFrNjNDQVBPQ2k4SDV3TWlqeDQzVmg2OW5mYTI1?=
 =?utf-8?B?UjBuQUsyR0hhVHlGNU5aU3NGWHU2dy9iZ2diTVlGcm5Xd2RiSXJyUnRNM011?=
 =?utf-8?B?Zi9zVDlwVjRlWVJBZjd2amFrczBmdkhqK0xSK2dIbkpnSDRlWmJtMWxJMnRz?=
 =?utf-8?B?VVRkVTArTTI0OGNxRE5QT3p3RHQ2NVY4eDdJRmhOdjhNQzhIWUtsMTdoNU5J?=
 =?utf-8?B?bmdEMUN6ZWd0SURodVpCVnFBWFYyMUZZVXFkekNGTUg5cXFzUFl1OS9yZUJ3?=
 =?utf-8?B?SnVRUGZlSC9jbENNWkc3VEVqakllTzVJWjlxbHpCOFdXTlZQaFlFT21BMXR1?=
 =?utf-8?B?bk41cDZLL0k1R09QY0NFU0kvRXFmaG5JM3NnWDZ1RXBsRGU0Uzdzb2x3VGNT?=
 =?utf-8?B?VzBCZGl5U1dTUEJXQmhjaHBNTXJ3eTJ4UGxXd3N5RFRPTVptWS91a1dCSmJa?=
 =?utf-8?B?M1RvN283TTV6M2xMTENKR1RvL3VUdWZNUUN5ejU1NDBjaGVNQjJxcm10eURj?=
 =?utf-8?B?b3JEVVhGRDZJNmNDQVRHa0dLVXR5cldCRHhmZHI5VGdzUXQvT1Jxbmh6dHZJ?=
 =?utf-8?B?RkMzbzFHWTdZMWVzb21oQ1ZvWVgyMDh5NFY0Y3dlUlJVb2d5R1BNR0RiYmZ1?=
 =?utf-8?B?Vmd1S1hrWDBlOVBlSmJibzRUY2tjVFNweFRPczJDSUQ3SHQ3Nkw2cDhuTlR0?=
 =?utf-8?B?dWYzS3RXTFl4MFVObVp2Vk5qVmNTZ3djOU9hWE9XNUNaaHRiRm51RkNRcTNX?=
 =?utf-8?B?KzRyaDdTSnRMTkEzNG1RSytGQkdTLzI1V2I1aVJtUXU1eGNwNENQeWYrT3pn?=
 =?utf-8?Q?4=3D?=
X-Microsoft-Antispam-Message-Info: fYW80sBFaIwPtPA4vrCczxNhdMg1s+p7IZEhPdb943a3/aJdWBC0DVmOew2bFJbRuQpg7M9mMpm9dIJsV3RkzEDf56+d918oXYkFBR4v3r+kwi4Pj2c04VO3sjvaVvMct2F5tDUo+Dd1Le1lyG5svy+eunaFIMvyKTk8FF1PPicWW2ZAcpC3gmuhzyWluHHR
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1381;6:B4OeEqwpe0DLY6DPyeujd87pv4bKe4e3FQL4aAjjbBQnM28yiVkH5VZF2ab7NVMMu+yGe23h4ri0yetZh0XKmeF0qOwncMupoBASZQACiP/4pJUAll5S6wc8Z7G0ALJW2WLFIgdLZuAYbojBTacI+VMHyZA6LF4IOztPjo3ns1zEYZJm2RVN/OxTB0eHBqTNoUnjgsDUTInp9r/DBOaDAL1Z6wmbtFDJpwUzkNAmK4hBN70T7ZN+eOVApba5uYKKG8X5fwg2n8hBL6Q4uoF/mzrRLZ+3IVOxojLfcEZHhpx+C4cUSlAU7+IpR42ABlrCOecqItuxbQal4c9GQFcrAtDaU8oPJA/bL/uqv8/mpWrjkI6KAr+xgSTqM+OV7ikCcNzne7LmwFpmHBq8ybFknZESvWecpW8WEN4d9tUk6ZdwSerjelokGoIpiJOjETPF93vRO6kUP3pjk6AFad0lMw==;5:voH2tXdqVcjj3YmZ2Gb+RY8iEJsrSVXjpoG6Won71NsoREFCrt4ILKDPXrh3F9v+IzSE+1eYAmmmCmCGnfmW9lV6PTWMmx0EIBUXO3WPcvTTEH+GhTlCxjO7u2mpfYKqVoz2QYwO0cRUPO3XJw7Bz0BFlX1XgBaunDqnDHwrIds=;24:8XCW9045u3cWVDYDO2M4I1QZYQ3hiuCgv/DFfwR+uFgLb1LNkSYQjbXfjH84325xXuw92GYJ8QIYVFQ2mXrS6NN03nvIDciPzf7cErjX6Z4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1381;7:un0f5glyoMC5ihbNXcaFf4BR8WfVX/76sn4anSGhCJNAEQAiqt+BfZzwVqLErPbkAqoZXfieCZnfZyVALgrWY8s9gacCBoyx/SYjT+0BY6WZMyrE3wSG888IReFcyUayFn+NqhUQ/mdqv+ZL5gBq6ijuJVmskSQIwTh+2INPcZ0VnXpfFl2F+G6HfZ6syhEG2RhOmD2yZFfYN8KU1y6xwglZ4OuNNbyayj93zaIUbmR9TddcWWtrxxOQc1KuQ0yH
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2018 10:55:09.2416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cff8550b-d71c-4688-be91-08d5d2ae7662
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1381
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mali-DP 500 supports rotations for both compressed/uncompressed buffers
for all the layers.
Mali-DP 550 supports rotations for both compressed/uncompressed buffers for
VIDEO and GRAPHICS layers only. The SMART layer does not support any
rotation.
Mali-DP 650 supports rotations for both compressed/uncompressed buffers for
VIDEO layers and compressed buffers only for GRAPHICS layer. SMART layer
behaves similar to that of Malidp-550.

Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
Reviewed-by: Brian Starkey <brian.starkey@arm.com>
---
 drivers/gpu/drm/arm/malidp_crtc.c   | 31 ++++++++++++++----------
 drivers/gpu/drm/arm/malidp_hw.c     | 48 ++++++++++++++++++++++++++-----------
 drivers/gpu/drm/arm/malidp_hw.h     | 10 +++++++-
 drivers/gpu/drm/arm/malidp_planes.c | 24 +++++++++++++------
 4 files changed, 79 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_crtc.c b/drivers/gpu/drm/arm/malidp_crtc.c
index fcc62bc..21c5d05 100644
--- a/drivers/gpu/drm/arm/malidp_crtc.c
+++ b/drivers/gpu/drm/arm/malidp_crtc.c
@@ -348,19 +348,20 @@ static int malidp_crtc_atomic_check(struct drm_crtc *crtc,
 
 	/*
 	 * check if there is enough rotation memory available for planes
-	 * that need 90° and 270° rotation. Each plane has set its required
-	 * memory size in the ->plane_check() callback, here we only make
-	 * sure that the sums are less that the total usable memory.
+	 * that need 90° and 270° rotion or planes that are compressed.
+	 * Each plane has set its required memory size in the ->plane_check()
+	 * callback, here we only make sure that the sums are less that the
+	 * total usable memory.
 	 *
 	 * The rotation memory allocation algorithm (for each plane):
-	 *  a. If no more rotated planes exist, all remaining rotate
-	 *     memory in the bank is available for use by the plane.
-	 *  b. If other rotated planes exist, and plane's layer ID is
-	 *     DE_VIDEO1, it can use all the memory from first bank if
-	 *     secondary rotation memory bank is available, otherwise it can
+	 *  a. If no more rotated or compressed planes exist, all remaining
+	 *     rotate memory in the bank is available for use by the plane.
+	 *  b. If other rotated or compressed planes exist, and plane's
+	 *     layer ID is DE_VIDEO1, it can use all the memory from first bank
+	 *     if secondary rotation memory bank is available, otherwise it can
 	 *     use up to half the bank's memory.
-	 *  c. If other rotated planes exist, and plane's layer ID is not
-	 *     DE_VIDEO1, it can use half of the available memory
+	 *  c. If other rotated or compressed planes exist, and plane's layer ID
+	 *     is not DE_VIDEO1, it can use half of the available memory.
 	 *
 	 * Note: this algorithm assumes that the order in which the planes are
 	 * checked always has DE_VIDEO1 plane first in the list if it is
@@ -368,11 +369,15 @@ static int malidp_crtc_atomic_check(struct drm_crtc *crtc,
 	 * place, under current DRM version things work, but if ever the order
 	 * in which drm_atomic_crtc_state_for_each_plane() iterates over planes
 	 * changes, we need to pre-sort the planes before validation.
+	 *
 	 */
 
 	/* first count the number of rotated planes */
 	drm_atomic_crtc_state_for_each_plane_state(plane, pstate, state) {
-		if (pstate->rotation & MALIDP_ROTATED_MASK)
+		struct malidp_plane_state *ms = to_malidp_plane_state(pstate);
+		struct drm_framebuffer *fb = ms->base.fb;
+
+		if ((pstate->rotation & MALIDP_ROTATED_MASK) || fb->modifier)
 			rotated_planes++;
 	}
 
@@ -388,8 +393,10 @@ static int malidp_crtc_atomic_check(struct drm_crtc *crtc,
 	drm_atomic_crtc_state_for_each_plane_state(plane, pstate, state) {
 		struct malidp_plane *mp = to_malidp_plane(plane);
 		struct malidp_plane_state *ms = to_malidp_plane_state(pstate);
+		struct drm_framebuffer *fb = ms->base.fb;
+
+		if ((pstate->rotation & MALIDP_ROTATED_MASK) || fb->modifier) {
 
-		if (pstate->rotation & MALIDP_ROTATED_MASK) {
 			/* process current plane */
 			rotated_planes--;
 
diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
index d789b46..4dbf39f 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -75,16 +75,34 @@ static const struct malidp_format_id malidp550_de_formats[] = {
 };
 
 static const struct malidp_layer malidp500_layers[] = {
-	{ DE_VIDEO1, MALIDP500_DE_LV_BASE, MALIDP500_DE_LV_PTR_BASE, MALIDP_DE_LV_STRIDE0, MALIDP500_LV_YUV2RGB },
-	{ DE_GRAPHICS1, MALIDP500_DE_LG1_BASE, MALIDP500_DE_LG1_PTR_BASE, MALIDP_DE_LG_STRIDE, 0 },
-	{ DE_GRAPHICS2, MALIDP500_DE_LG2_BASE, MALIDP500_DE_LG2_PTR_BASE, MALIDP_DE_LG_STRIDE, 0 },
+	{ DE_VIDEO1, MALIDP500_DE_LV_BASE, MALIDP500_DE_LV_PTR_BASE,
+		MALIDP_DE_LV_STRIDE0, MALIDP500_LV_YUV2RGB, ROTATE_ANY },
+	{ DE_GRAPHICS1, MALIDP500_DE_LG1_BASE, MALIDP500_DE_LG1_PTR_BASE,
+		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY },
+	{ DE_GRAPHICS2, MALIDP500_DE_LG2_BASE, MALIDP500_DE_LG2_PTR_BASE,
+		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY },
 };
 
 static const struct malidp_layer malidp550_layers[] = {
-	{ DE_VIDEO1, MALIDP550_DE_LV1_BASE, MALIDP550_DE_LV1_PTR_BASE, MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB },
-	{ DE_GRAPHICS1, MALIDP550_DE_LG_BASE, MALIDP550_DE_LG_PTR_BASE, MALIDP_DE_LG_STRIDE, 0 },
-	{ DE_VIDEO2, MALIDP550_DE_LV2_BASE, MALIDP550_DE_LV2_PTR_BASE, MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB },
-	{ DE_SMART, MALIDP550_DE_LS_BASE, MALIDP550_DE_LS_PTR_BASE, MALIDP550_DE_LS_R1_STRIDE, 0 },
+	{ DE_VIDEO1, MALIDP550_DE_LV1_BASE, MALIDP550_DE_LV1_PTR_BASE,
+		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY },
+	{ DE_GRAPHICS1, MALIDP550_DE_LG_BASE, MALIDP550_DE_LG_PTR_BASE,
+		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY },
+	{ DE_VIDEO2, MALIDP550_DE_LV2_BASE, MALIDP550_DE_LV2_PTR_BASE,
+		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY },
+	{ DE_SMART, MALIDP550_DE_LS_BASE, MALIDP550_DE_LS_PTR_BASE,
+		MALIDP550_DE_LS_R1_STRIDE, 0, ROTATE_NONE },
+};
+
+static const struct malidp_layer malidp650_layers[] = {
+	{ DE_VIDEO1, MALIDP550_DE_LV1_BASE, MALIDP550_DE_LV1_PTR_BASE,
+		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY },
+	{ DE_GRAPHICS1, MALIDP550_DE_LG_BASE, MALIDP550_DE_LG_PTR_BASE,
+		MALIDP_DE_LG_STRIDE, 0, ROTATE_COMPRESSED },
+	{ DE_VIDEO2, MALIDP550_DE_LV2_BASE, MALIDP550_DE_LV2_PTR_BASE,
+		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY },
+	{ DE_SMART, MALIDP550_DE_LS_BASE, MALIDP550_DE_LS_PTR_BASE,
+		MALIDP550_DE_LS_R1_STRIDE, 0, ROTATE_NONE },
 };
 
 #define SE_N_SCALING_COEFFS	96
@@ -272,10 +290,11 @@ static void malidp500_modeset(struct malidp_hw_device *hwdev, struct videomode *
 		malidp_hw_clearbits(hwdev, MALIDP_DISP_FUNC_ILACED, MALIDP_DE_DISPLAY_FUNC);
 }
 
-static int malidp500_rotmem_required(struct malidp_hw_device *hwdev, u16 w, u16 h, u32 fmt)
+static int malidp500_rotmem_required(struct malidp_hw_device *hwdev, u16 w,
+				     u16 h, u32 fmt, bool has_modifier)
 {
-	/* RGB888 or BGR888 can't be rotated */
-	if ((fmt == DRM_FORMAT_RGB888) || (fmt == DRM_FORMAT_BGR888))
+	/* raw RGB888 or BGR888 can't be rotated */
+	if ((fmt == DRM_FORMAT_RGB888 || fmt == DRM_FORMAT_BGR888) && !has_modifier)
 		return -EINVAL;
 
 	/*
@@ -496,12 +515,13 @@ static void malidp550_modeset(struct malidp_hw_device *hwdev, struct videomode *
 		malidp_hw_clearbits(hwdev, MALIDP_DISP_FUNC_ILACED, MALIDP_DE_DISPLAY_FUNC);
 }
 
-static int malidp550_rotmem_required(struct malidp_hw_device *hwdev, u16 w, u16 h, u32 fmt)
+static int malidp550_rotmem_required(struct malidp_hw_device *hwdev, u16 w,
+				     u16 h, u32 fmt, bool has_modifier)
 {
 	u32 bytes_per_col;
 
 	/* raw RGB888 or BGR888 can't be rotated */
-	if ((fmt == DRM_FORMAT_RGB888) || (fmt == DRM_FORMAT_BGR888))
+	if ((fmt == DRM_FORMAT_RGB888 || fmt == DRM_FORMAT_BGR888) && !has_modifier)
 		return -EINVAL;
 
 	switch (fmt) {
@@ -700,8 +720,8 @@ const struct malidp_hw malidp_device[MALIDP_MAX_DEVICES] = {
 			.dc_base = MALIDP550_DC_BASE,
 			.out_depth_base = MALIDP550_DE_OUTPUT_DEPTH,
 			.features = MALIDP_REGMAP_HAS_CLEARIRQ,
-			.n_layers = ARRAY_SIZE(malidp550_layers),
-			.layers = malidp550_layers,
+			.n_layers = ARRAY_SIZE(malidp650_layers),
+			.layers = malidp650_layers,
 			.de_irq_map = {
 				.irq_mask = MALIDP_DE_IRQ_UNDERRUN |
 					    MALIDP650_DE_IRQ_DRIFT |
diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp_hw.h
index b5dd6c7..41f4521 100644
--- a/drivers/gpu/drm/arm/malidp_hw.h
+++ b/drivers/gpu/drm/arm/malidp_hw.h
@@ -54,12 +54,19 @@ struct malidp_irq_map {
 	u32 vsync_irq;		/* IRQ bit used for signaling during VSYNC */
 };
 
+enum rotation_features {
+	ROTATE_ANY,	        /* supports rotation on any buffers */
+	ROTATE_COMPRESSED,	/* supports rotation only on compressed buffers */
+	ROTATE_NONE,        /* does not support rotation at all */
+};
+
 struct malidp_layer {
 	u16 id;			/* layer ID */
 	u16 base;		/* address offset for the register bank */
 	u16 ptr;		/* address offset for the pointer register */
 	u16 stride_offset;	/* offset to the first stride register. */
 	s16 yuv2rgb_offset;	/* offset to the YUV->RGB matrix entries */
+	enum rotation_features rot;    /* type of rotation supported */
 };
 
 enum malidp_scaling_coeff_set {
@@ -168,7 +175,8 @@ struct malidp_hw {
 	 * Calculate the required rotation memory given the active area
 	 * and the buffer format.
 	 */
-	int (*rotmem_required)(struct malidp_hw_device *hwdev, u16 w, u16 h, u32 fmt);
+	int (*rotmem_required)(struct malidp_hw_device *hwdev, u16 w, u16 h,
+			       u32 fmt, bool has_modifier);
 
 	int (*se_set_scaling_coeffs)(struct malidp_hw_device *hwdev,
 				     struct malidp_se_config *se_config,
diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
index 7a44897..377382e 100644
--- a/drivers/gpu/drm/arm/malidp_planes.c
+++ b/drivers/gpu/drm/arm/malidp_planes.c
@@ -197,12 +197,19 @@ static int malidp_de_plane_check(struct drm_plane *plane,
 
 	ms->n_planes = fb->format->num_planes;
 	for (i = 0; i < ms->n_planes; i++) {
+		struct drm_gem_cma_object *obj;
+
 		u8 alignment = malidp_hw_get_pitch_align(mp->hwdev, rotated);
 		if (fb->pitches[i] & (alignment - 1)) {
 			DRM_DEBUG_KMS("Invalid pitch %u for plane %d\n",
 				      fb->pitches[i], i);
 			return -EINVAL;
 		}
+
+		obj = drm_fb_cma_get_gem_obj(fb, i);
+
+		if (WARN_ON(!obj))
+			return -EINVAL;
 	}
 
 	if ((state->crtc_w > mp->hwdev->max_line_size) ||
@@ -225,19 +232,22 @@ static int malidp_de_plane_check(struct drm_plane *plane,
 	if (ret)
 		return ret;
 
-	/* packed RGB888 / BGR888 can't be rotated or flipped */
-	if (state->rotation != DRM_MODE_ROTATE_0 &&
-	    (fb->format->format == DRM_FORMAT_RGB888 ||
-	     fb->format->format == DRM_FORMAT_BGR888))
-		return -EINVAL;
+	/* validate the rotation constraints for each layer */
+	if (state->rotation != DRM_MODE_ROTATE_0) {
+		if (mp->layer->rot == ROTATE_NONE)
+			return -EINVAL;
+		else if ((mp->layer->rot == ROTATE_COMPRESSED) && (!fb->modifier))
+			return -EINVAL;
+	}
 
 	ms->rotmem_size = 0;
-	if (state->rotation & MALIDP_ROTATED_MASK) {
+	if (state->rotation != DRM_MODE_ROTATE_0 || fb->modifier) {
 		int val;
 
 		val = mp->hwdev->hw->rotmem_required(mp->hwdev, state->crtc_h,
 						     state->crtc_w,
-						     fb->format->format);
+						     fb->format->format,
+						     !!(fb->modifier));
 		if (val < 0)
 			return val;
 
-- 
2.7.4

