Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD648C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B2012168B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="Ny78XuY0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B2012168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbeHXM3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:29:01 -0400
Received: from mail-ve1eur01on0102.outbound.protection.outlook.com ([104.47.1.102]:7584
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726842AbeHXM3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUHazAjb+AZ6xewRIlaKIdmlsDhyO5hSQEZ6mcjpVyE=;
 b=Ny78XuY02XKgMHBVYajB1uFDTwG9VYa0y0515KSadagYAXfxyPfz1FU7KBf4Gnk9/YzNFXptS7XrVuFETLnhJu9bTBRIHv7XNMcDYUGL6c+YQg7f3Q7RHwnX/4YFzD9jGYYsgAxdfoQJDwg6/JppOVU1elXNHDEmz+IhFZdvyHI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 AM5PR0201MB2450.eurprd02.prod.outlook.com (2603:10a6:203:35::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.15; Fri, 24 Aug
 2018 08:55:16 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] drm/atmel-hlcdc: prefer a higher rate clock as pixel-clock base
Date:   Fri, 24 Aug 2018 10:55:00 +0200
Message-Id: <20180824085501.9740-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180824085501.9740-1-peda@axentia.se>
References: <20180824085501.9740-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: VI1PR0701CA0070.eurprd07.prod.outlook.com
 (2603:10a6:800:5f::32) To AM5PR0201MB2450.eurprd02.prod.outlook.com
 (2603:10a6:203:35::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40eb9bda-5b0b-4864-3e0a-08d6099f502e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2450;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2450;3:gm+hSH2AgdiYd4+DAsCRypxOhcwnp/45SXq7ylgQp3GdhVxDg/EP3yq6JgRHyIoK91F/yY+4HlBayTjx+d812Yu4l36fxRMeso9LhZoXHBCOCZosnsWYpGsjSdknHXaHVvH1CC/8UNxI17W04HloW3TowOdlSbjhOBuvr6bd7IAAKn6CP5IiptirsMI1qd2h0M8J4him9Udfym3tlPqalPswDmgyIn1a3i+LOKN8bkp2/aBPzYkfexqQWGqYiA+n;25:N8bJUhI/ruszqh+SahIP9zD5QvLqzL3XHHj6D/OquNUfUxNG+LsyCbuxhDVaiuNn6fcEsQQRVeru1fBJIeqNaHfjUWyMO9QPtcYr+dzhL+LcMICifT30StljU2Q7v+ANkKJeeYGM/higWh79BO3q70s/Y1s9Qjj+/aRUCc91K2BG2HxSVdRAVnGNKuT60NmIs3sotEHQ/e0gReBCujvP9ymagOdHxc2o7im4Q8GGDmXxtfX6Llz9qtq/ydCAyQpleSMYRJU992X/byoDvuknqimCcgIJf9L2udqNWKre5SWIf5VynUz/Z0etAgb0Kr+qepZPHmsAawffwfiWagdNXQ==;31:GhoprdQFd2LiRN2isZyhYkWaZfI8QT1CmSl7a+1dS2Uniee1twUhmf+92sFQnlgaCLhd+zdcoTgVW+1hcWOi3bfBPxB6w+K6xlNWxaLCl6l69ncK86d8s+JoUCKAKsdIozcKC3RCXWjvqNboj3BYU9NFqVsLltqLaKbFRmTvjkmDEoZQFW9qfWIiajSCBpwNzK3SQzbt8ClsDBflWwCPtubYc/lRNHida/HmTG3HpD4=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2450:
X-Microsoft-Antispam-PRVS: <AM5PR0201MB2450BEA5AE7AD240B5715216BC360@AM5PR0201MB2450.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123562045)(2016111802025)(20161123560045)(20161123564045)(20161123558120)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2450;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2450;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2450;4:4ogDoinr9/pY2z9dPnldiAQHRjcrvAGcZWXY2CuGypfNqCtk2KzoFzWRkuYE8sI5TsbVwcL19FjnrCPfqmRt7C2WFas7QMCkuQ04VBRCht0mdYsiMjk92Sj/JP4erUK/oN+tlpQ5lmfDeJ62I4KFokgohvoX8fYUktfgpQ3XjRVvRuDdkELHYzrY94BHHu/iym0hPIHohUK0qHJXTwYQB1VGE/yCU080hNGU1c24NpiUXM6yiBvKQyTJnSidpSTJgylu34ajpG2EhHYPH9Ip/g==
X-Forefront-PRVS: 07749F8C42
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(346002)(366004)(396003)(376002)(39830400003)(189003)(199004)(16586007)(5660300001)(8936002)(2351001)(81166006)(81156014)(8676002)(26005)(186003)(50226002)(4326008)(105586002)(16526019)(106356001)(68736007)(478600001)(2361001)(25786009)(74482002)(6666003)(305945005)(476003)(6486002)(6916009)(446003)(11346002)(36756003)(53936002)(76176011)(51416003)(2616005)(52116002)(7736002)(66066001)(50466002)(86362001)(956004)(486006)(54906003)(6512007)(48376002)(1076002)(316002)(386003)(6506007)(3846002)(2906002)(97736004)(47776003)(6116002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2450;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0201MB2450;23:d5VL1zZBk+XlawO+mZezL/Tyw3sQpUCvmBAdrIb?=
 =?us-ascii?Q?+MRPQGKXGMDfc8/+y4mOK5nMZx+3WfPXEEl8tXclOVy3csl3oY8KXOKr+Nin?=
 =?us-ascii?Q?LoSfxfmY3uq1lQ+ouoVRs8UqXnQA3cCZpkqEC/+oADEP8Li/FBKEdFeI8//S?=
 =?us-ascii?Q?u4M10kBNNPkyLgNNzipuRXMfOhxSgTJiIKEbzxCv5jXjiFYI4van+VM2L6x1?=
 =?us-ascii?Q?Sm2y7Dj6IILfZ8hpAoCJ+f8VbOaVUPT7bQg4WNfCm2BkSmAdvR0inmdHn+KE?=
 =?us-ascii?Q?GE1vlZXud4IUMM+asaVDarPIOJodqUFx2rdN66q5nbyLB6mf+fMvWBrbZRh9?=
 =?us-ascii?Q?Z9KwvzzMtfoHdSgLwrTLjro3dbDTOgFI95WvooGkK00HIUDyfkAhtIBlqdMK?=
 =?us-ascii?Q?SndokemDVwVr8jVeOsu295KXEglv3P0088jUJJBO5Tz2LRdw9gVLVaXB5jUf?=
 =?us-ascii?Q?r4d7RxoZBd7P1BSRiHibjKSoc3R6W2astowaid99cfwYmgewa8VnLYb2lOex?=
 =?us-ascii?Q?N2cd5XGSRsBl+M7YX+bZOlPchYH+FdLyJxiyKgkhu7ELGtlPreVM7fVmKLBt?=
 =?us-ascii?Q?aFIHNGI6FTfJUPYuwZkNtFd+8mPSDgcpzj+rwuHUvqcIusDs/Aqk1+LzOkDh?=
 =?us-ascii?Q?WFvB2k9KcfpWiKqxgZH+XDkTo2oKHHVm0gqkI03vWRIdOXy6zlbgABVTabfM?=
 =?us-ascii?Q?s1sPs6JPLQr64QqJq4KRUs1N81rlmh2MFdbRGgTS94pCsFpHozuYkqStCFyS?=
 =?us-ascii?Q?GC39o7ctamC7thIID5OdnhDyKDHYojjxovFb/mf7pRTBkiXqwGDtv3LfItLK?=
 =?us-ascii?Q?wa/TUtbFKuOCIsBWpfxA7sDhPKZzGWovhkwQZnU4Ne2UjNgIbv1PnDtb2rpr?=
 =?us-ascii?Q?bZzk4eBYzimS1XWTbAhb9f9NMtDTkiBdv5COCuB/JH0yarezEVvIro815D/E?=
 =?us-ascii?Q?1WUI2lHNSZp7MiZrJV+A5jV7MT0PPYBmD3rkWZGVbD09yRe4NKB5/Im6QJhG?=
 =?us-ascii?Q?+Yzy42QO/EZNW+LHoBFlqcb5F8DEObPkHYM7VcbNYrPSHdbjF3hfn5IxdYmP?=
 =?us-ascii?Q?VJWRZx23dR1Opyu5K80drqVAvCprf0m4BGkASWRB47N1tKKjSQ34MGOfe7VH?=
 =?us-ascii?Q?hGUNBk7uPeN1u/FyINqzbSPfEv4aA2nLpCmZ2NPY29oBg/tTDzlpdMK66dmt?=
 =?us-ascii?Q?8kli4S5Yj+RHzqNTK0IQOYnLy2X7WyvqL07LOOe3MHrEbY+tdiRNBHNUuztf?=
 =?us-ascii?Q?jaVEEfDJf3Wv/3HpCQPGC8sIugydNJQk1z7tMqTySJ+V6oiHSBJvjFzR4Tl/?=
 =?us-ascii?Q?LOA=3D=3D?=
X-Microsoft-Antispam-Message-Info: SgMW/UFo03L3nLYSGPeDHWTau/VQd5tRKTkWgWvb5FAP4Oft13IL8e7xTObkYCQ/Hcgtorq+YSOqpJS8safJKSoJdAc8+AXtLehlFU5WxGzmUXNG2jXFc4nR0gnx+08vldZQEpmF5qWI5W1C5DZ7cSZVfHN/p0RUi8z2LW6ICagr2voAd2TcgMwmtADReUGXDccD4orZJ+tSiY3A3htFwmgMoKCbwbBvL9fe8+8FYHjdEYJORx+vFgjgwLtRh8NqcbZXfNlyBlR8R+u145VpzV8zs7nstvBsm+5tMYoVnGLNGl4z8oou+V5d648EZH2UYlDRyVoHiP8r/iYsWp5JsNOEhXdaioKXxQJijilUbCY=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2450;6:XVZry1sj42TB7kWwBZ86L4Why8ZD1+9iblVbv4ckKByTK/XHfcDBTFFUIUAXYmj1Ckh3IvtLOwGbajCmdBgKTomy6nqOht9lsiy8IXBnkkJpYXExWCT4XzOFVQ8vxLRhgCIkjic7jdpiiaBIqgCWryPw7LYa38f1JEjew22U5mtZvda7/R25D6zyFyDIioCGtikBX/6ngiVgvhm9Fzwk5++1S39CxqVd1/Gp7aNQHOL5mKO6AlqYFsFjTrj+zxK/PiszrwAdF78WmevTDsGZbma/Q53rtoyv27yl0VlzyZiRP59eRozi+a6l94JiTJo4tWEv4otoKvvR1Xe4e9rrTYPBy89JFNCdgdQqlcq0BLXxka97f8fXj8vVaflBi14a780zw/lfdmB2PTUqomKtasW0jGWljB8mNrBcuOQmaDeqIEn96nd/uycQZ9zxxFZLHEgrxdiL/STq1beCMAcPTQ==;5:Macboi2SGlvrRz52xyn7tmxA5GWXglWD19DPvAIbDTBde/T8HpuQXEIsjRcOx4+mrxRyk0l0w7V0nQCN5aHFSqYABFLBFcD5OSzz57JsMQD9UeEtdr9QjFty9E5yXTqswBTISpQVN5DzO/+fr1SQNLTntuvf+VVMc9E/rEjUWds=;7:WgyzC0MUGCrQx5/2nQw/TYWPGoawBScHET5+9Jk53TNM9oGk8sP6gs9nWnkJjtJvfSq/QDtLGQbuZVkjFzd6wIhBtbBj5m9pEiCLEo/WihSI5zaAK2BJ3VKrHp2VHe3U22ffhXiECDfwSz9atf5bErGdUVJbqsGltPvn+KGK2eapRKFibaD8cJVHx1ZHR+H1s+IyNd0jfvcX8jciyEkxoqY+66pq4gQtnaCbyCndTBTpgdD2uauXVTm/DruAd7Cv
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2018 08:55:16.2911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40eb9bda-5b0b-4864-3e0a-08d6099f502e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2450
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the divider used to get the pixel-clock is small, the granularity
of the frequencies possible for the pixel-clock is quite coarse. E.g.
requesting a pixel-clock of 65MHz with a sys_clk of 132MHz results
in the divider being set to 3 ending up with 44MHz.

By preferring the doubled sys_clk as base, the divider instead ends
up as 5 yielding a pixel-clock of 52.8Mhz, which is a definite
improvement.

While at it, clamp the divider so that it does not overflow in case
it gets big.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index c38a479ada98..71c9cd90d2ae 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -101,18 +101,22 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
 		     (adj->crtc_hdisplay - 1) |
 		     ((adj->crtc_vdisplay - 1) << 16));
 
-	cfg = 0;
+	cfg = ATMEL_HLCDC_CLKSEL;
 
-	prate = clk_get_rate(crtc->dc->hlcdc->sys_clk);
+	prate = 2 * clk_get_rate(crtc->dc->hlcdc->sys_clk);
 	mode_rate = adj->crtc_clock * 1000;
-	if ((prate / 2) < mode_rate) {
-		prate *= 2;
-		cfg |= ATMEL_HLCDC_CLKSEL;
-	}
 
 	div = DIV_ROUND_UP(prate, mode_rate);
 	if (div < 2)
 		div = 2;
+	else if (ATMEL_HLCDC_CLKDIV(div) & ~ATMEL_HLCDC_CLKDIV_MASK) {
+		/* the divider ended up too big, try a lower base rate */
+		cfg &= ~ATMEL_HLCDC_CLKSEL;
+		prate /= 2;
+		div = DIV_ROUND_UP(prate, mode_rate);
+		if (ATMEL_HLCDC_CLKDIV(div) & ~ATMEL_HLCDC_CLKDIV_MASK)
+			div = ATMEL_HLCDC_CLKDIV_MASK;
+	}
 
 	cfg |= ATMEL_HLCDC_CLKDIV(div);
 
-- 
2.11.0

