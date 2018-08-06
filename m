Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B49C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 06:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF05219DB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 06:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="ZMG20aGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF05219DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbeHFI1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 04:27:06 -0400
Received: from mail-eopbgr60107.outbound.protection.outlook.com ([40.107.6.107]:37280
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725735AbeHFI1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 04:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJiRPGcq/TXCn6LuAiRJ8Ru16DoMGais5tmtIH2xYHY=;
 b=ZMG20aGGqVyc2HV4ALoXBMF0iyjyipnFKAzRHch8tDjZhipjSRd3JX5IZY2DH6/6Yg1bJde+/ZQBchw2VkZah3JRptiNfCZ4tKIHkwb19aoDioIPLy6XqA5Zt76QleU1C7ovA/vxiRsNiGBB9FoalpK5FBCkAJ/wXoM9GFpe6dQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 DB6PR0201MB2455.eurprd02.prod.outlook.com (2603:10a6:4:35::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.18; Mon, 6 Aug 2018 06:19:28 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 1/2] drm/sti: do not remove the drm_bridge that was never added
Date:   Mon,  6 Aug 2018 08:19:09 +0200
Message-Id: <20180806061910.29914-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180806061910.29914-1-peda@axentia.se>
References: <20180806061910.29914-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0334.eurprd05.prod.outlook.com
 (2603:10a6:7:92::29) To DB6PR0201MB2455.eurprd02.prod.outlook.com
 (2603:10a6:4:35::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24bbea72-9ecf-4345-be0d-08d5fb649132
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600074)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0201MB2455;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2455;3:E1zvlA8xzgh1Vp2n1B/OLp0pMFd/OsZt0/LHbbnaSV7/KRSs4fk0Qs/jxFt0C33SY72TZgH6SSb0BF8R2zpnSaAWCCyiD+3sSWJY4hrsmWxbZfyW4cmiO194ynopRaRkaxlZikfDo6YUBnUBOuLyAj3J3nxJAj+MsI935T2Th3PwekSCbj5eg7KHI2/WbjrBHG+L3oWBrhWOXYtXtQtLOxSAFiseZdvzVQnalKxkbHL80ynjuP1GjIvgrolj4YMj;25:JjJq28pGOj1dY5muSUDO2mULrW18LYHTMwGRmi5Bm02nKO1K+oap/nV6Gpdt1sJSY0MwPJtXBg3m85hovP7lfHQoY2zw0gRwEJEb8OMuXwe8L+xcYeLNHTKRGDHD6paLOQXmQHrs2JAoLi39tnEUL5gcBimBjhaN2jvl9ETmGb15drvDnZn0X/kKcQTGtUaYUUvXNsI7wt5rFyCt6p3t9Evs6f9WxGZC82SFHLbv2yy+WN+CepGfi2YuzcpWyi02Z1rHg9gU0t+EiVe/N9ZAZf3WZqkFhVyVwoh1k+FDRnK+hPzxzT620dgn2NNOOhmadIt5nRSdRB+XvN8Qp3KHxw==;31:bhYxh1uCniDuqIS6hCcgFg0L6VC+PLGAT7SUCnosj1VYJJIjknnS2QPCgeD7L8NL6UKxVboq8GxW7rPJhmrPauoJ4+7hngvXb+CIen0XDitfJO8BOwr5MxiOjQVzBu/z9X0vz0koyQ9X+umd4oRdzyiFmaH8DOAAtFijB75CsizCdwn6b4m8ea13r0p95VcBT6JZnRvVh8eU0W0PSGlMqPGN5XmOWIZLRv7xIB1qavc=
X-MS-TrafficTypeDiagnostic: DB6PR0201MB2455:
X-Microsoft-Antispam-PRVS: <DB6PR0201MB2455DEC156169EC41583C292BC200@DB6PR0201MB2455.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(20161123560045)(6072148)(6043046)(201708071742011)(7699016);SRVR:DB6PR0201MB2455;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0201MB2455;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2455;4:w/26OB43hSZpOPtptSkQHh2qo5UxX7tuxOyDluOqob2UnHJREN8BR3/EH9sNtvIjAWIWVO58uvZHiU0LIjz/CyM7jgYagcxAQzkoOxuogREm6YtHTJfnPpsAa2bUTU7gYtyoE+qMT2jQ73QgBo5799h9tp1rDYHxPHeE7mNvI+rAWstSsIixheGrt3Qw1MQ94XfFP5UY6RpTrNw7Q8ikyS5QKBZ/PX16ONBq9tleLeOvJ64gngzlEZTy9TXWSaguHNnqE0geWz8kCMnH6hgBSA==
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39830400003)(396003)(136003)(346002)(376002)(199004)(189003)(2351001)(11346002)(106356001)(446003)(74482002)(105586002)(316002)(4326008)(47776003)(6116002)(386003)(66066001)(3846002)(25786009)(6506007)(16526019)(186003)(1076002)(97736004)(956004)(50466002)(48376002)(2616005)(476003)(68736007)(486006)(76176011)(2361001)(26005)(16586007)(52116002)(8676002)(53936002)(478600001)(6512007)(36756003)(86362001)(305945005)(5660300001)(54906003)(81156014)(8936002)(6486002)(2906002)(6666003)(6916009)(81166006)(51416003)(50226002)(7736002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0201MB2455;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0201MB2455;23:5fXkhIlo7+XJUcBHdihQs+NdNRKBdVXs6wBwvaW?=
 =?us-ascii?Q?75l47YOw7dD/hyQtaWUV58AK7zJ5gUO8HbJ/7p6JwEaHMEinWBErioaT3jEp?=
 =?us-ascii?Q?/D97c9lA4CGiJaVKBGE97GmXjXo6+/IWoybEaLoXNl7VeuDH2ZT1xEKS9/fz?=
 =?us-ascii?Q?o3KMjzQjlbefZsDCp2yqE6h7c+P4o4a/wPajEwQlt3kQCNXEEETVaW42Qt+g?=
 =?us-ascii?Q?BOM7tM+eAVxOx1HTVGFuQPGGCN+ouI0X14frLb02VXUxaTdj5F4hWg6uSY3a?=
 =?us-ascii?Q?w94FibH53Jx9GkU3M2aNs9o5BrBcbeIYrJBOLSulP/B3i1xYgLGzHZ/vAvtQ?=
 =?us-ascii?Q?iOOt1jba1a5Zu+Zp7YexhdTNnFV1A/RpozuktTXvIlHpatQ2DDEBTj4diDu/?=
 =?us-ascii?Q?ppeOQgRqKr+x9ICYYDpPW7HDqUF8P2t6fxQbC2uPO/XVwg0Ut5F6wijAPkjQ?=
 =?us-ascii?Q?7IazIPu5AYMZnc9T8ntulGOlI2W1sZjpqqLbQINHfKQF3WzbZ1WthiAJ6b9y?=
 =?us-ascii?Q?IPevNzi4vNCeVbVD47dL1V3ZlYvPYrLENyqrRqXzKu6jdvURiShXuwHjTOAr?=
 =?us-ascii?Q?LXfhhbZ4Zkft6AdUPgyor5zkSVEEqbKGeMkwbxsaesVlY5RHGmGshZAtVrPG?=
 =?us-ascii?Q?9447hQKna11HOC/reOXtWRw4HhAa10KJzpbQTNXQ9LIh+DFnoYMslHwh3tUO?=
 =?us-ascii?Q?dwTfnQr/U29OFbYYhEvT/JLtESYy+d4tL2UNzr0sBfwMhDdOlnZA3u42KzZZ?=
 =?us-ascii?Q?7W4l1HO64I0EE/LF8Sruv3L3YIZCDUKTwJuALd5Y6CsFwzPDbUH+b4/U+YIM?=
 =?us-ascii?Q?xiVV1ZsC3YTIiIK6QjXMV09VOZRWzXLWu0HnpZiCpynGX8VeQEhJse3iWYLk?=
 =?us-ascii?Q?imcle/LJDSNiv+FIQpc1oW1Zc9vEZh+Nhe93NC7Fwf8kAYUAreDGrsn6G0G2?=
 =?us-ascii?Q?bJU+Q7Kija+F3udIcrNOby+3MEEzh6NtIK/Jlnc8xz5HK30i3CIulOSVLDU5?=
 =?us-ascii?Q?QwNTbni6Yyn57BzZhPLLSDb+a4xVTuQDI2uMx9EiwNLhp8ojIiIR1eP6y+nk?=
 =?us-ascii?Q?phUbHMu2QcHIfqlgqbX3ZBawQI8GW+/jdNwgmEkKTkuiWcbcfFEHZkUten06?=
 =?us-ascii?Q?XtEwZkFQHvsuTQ7v27E5La4KXma8rG7Uf3QqqkpahPUa4OLbQ0yka+W/kg2i?=
 =?us-ascii?Q?i8ohDbr2FFO7Rn/jV11HcTFCiWSRMy3dPwmcfCJ4fwc7mRHIM0E7s6yaNx15?=
 =?us-ascii?Q?4dY4+e87+Fvq4NrIgNY0HmGN4dhfip1UoD7TrJ4cbC19O7/CoZfs7uxsMYgc?=
 =?us-ascii?Q?Usg=3D=3D?=
X-Microsoft-Antispam-Message-Info: IW1cEhofaaTdMD7kftFpPR/UjV/C/BKIc/uAmlPVq38w6Bf7fWeCqzxEJBa0gvJCmCPqy6REKOrhJav4B13uZAbk7KV/+Alvx0IK6tZRrH/ePBNLVivkbf5eSwgkRjloBRlsC1on3BZizyKMwtCif4MOdXHt+YuurdACNIEE2MCnsECkjPVVGM0lPgYpPGiuoGwEvKQOT/R302DJFW8cTHiWcFd11vBXpIN7B8nPzf2KUn4O+Mq6afw3tn3krWENhmCtmSkfkkFVmhMsRA+ixMGK7cB/hjDgv+40NiNUKfREb8ztxTfEWXRBtUFdimjOVsQyRTywnl8lFZ2MHPdmOCSF53dgnFj2/d1GHvwQSAk=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2455;6:XxYR44QL2IWtWUBltYEm1nJRejRIx9sjYI8GXVmtphyNpuZ80A9gmYKnCYyK0JgILDK2cErf9yoyEpLvzxLx3366Q+IHe3k5x4mN5SP1Rby6/lJnxNlbsqe49EYp/pMmmB0iobftl+yoImj4z03sDuUoES2GmE9arLkur0UQZ+NREl0tCbR7WUSFKwiiQ47Xs7CoIT+vXPHdVx5TL7CxHW3k4BQCrbjYREpdHDKjINO6QsSV7+Ohq0AkJkgiZm1AtIpbJ505PwM2kt/6gku2yV5UXUszHBEFjwFNU/iPlN9PaaZ0vrBvCBIReBjAkEX8zB7FTuvf8oZwfogd7yhZm8nKJrWtBzZTLxE+DrCx2jSyhd1B/Javlf3BdpybgrPVCol5oUvksuOZ7kYwl6QgE7BXjEe472Utzmt0FCH7BLyrZNejkkgNydTxTAcpzXnPqIAMsvXIIhMjj1FHwTQdAw==;5:mTgttTS/P9yQ6kwV7hf4s1P7siKzyyyhktgB8UmGQ5n4UBHUW/C3/FQMDvcSsoBgARCUup0KTMNPA/KeuQ+dhCCDLen5vvzlmCSCmyqN6GZChseXHQasa5KYyexoeqH3JgPlZdLa6qtQ1yDiseJWuFyfEUt4PAA5mQ2iC5Lv6+c=;7:Nx6cG15AD8rArLKBS9HK44ddo2fH6/xrC3RKHaG28jejuv33MJTqYkM/mrxPA+ZfHvamFw65s4R5lzPosVZJv9Epl6CVLiLVoYf+mTVvbzGr8ptTko+5Jt1sUa/8AxYqffLlbVfHoZeWGD7Fqrw1eDUT7hPoMx65vJ846CvkCTegJ8xr9u7MfISKukcE+mOOmzpLcnppgS5aeCvmsHyk7lCEtSMtXtKZ6+e3MVGvvdZGs/VU/FPE3YdoumgJcIcP
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 06:19:28.6299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24bbea72-9ecf-4345-be0d-08d5fb649132
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0201MB2455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removing the drm_bridge_remove call should avoid a NULL dereference
during list processing in drm_bridge_remove if the error path is ever
taken.

The more natural approach would perhaps be to add a drm_bridge_add,
but there are several other bridges that never call drm_bridge_add.
Just removing the drm_bridge_remove is the easier fix.

Fixes: 84601dbdea36 ("drm: sti: rework init sequence")
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/sti/sti_hda.c  | 1 -
 drivers/gpu/drm/sti/sti_hdmi.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
index 67bbdb49fffc..199db13f565c 100644
--- a/drivers/gpu/drm/sti/sti_hda.c
+++ b/drivers/gpu/drm/sti/sti_hda.c
@@ -721,7 +721,6 @@ static int sti_hda_bind(struct device *dev, struct device *master, void *data)
 	return 0;
 
 err_sysfs:
-	drm_bridge_remove(bridge);
 	return -EINVAL;
 }
 
diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index 58f431102512..932724784942 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -1315,7 +1315,6 @@ static int sti_hdmi_bind(struct device *dev, struct device *master, void *data)
 	return 0;
 
 err_sysfs:
-	drm_bridge_remove(bridge);
 	hdmi->drm_connector = NULL;
 	return -EINVAL;
 }
-- 
2.11.0

