Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19020C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9CE82159F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="iGCBcX5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9CE82159F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeHXM3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:29:06 -0400
Received: from mail-ve1eur01on0104.outbound.protection.outlook.com ([104.47.1.104]:24404
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726842AbeHXM3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIIZYXqauK0zE4jEcg6L5XKiP5luQMgclEu2MXyvWPc=;
 b=iGCBcX5LZUjgAFpOIdyRV9zOaAtQxbdrx+vdn9Dvto+OxOZBC727/YZQtfCzWIMsRBxaIHkhLOicsl6uE+70J4jMRnRFbgPfFRnrX5R9JYg0g9mKN2MsiLg3Kpw/r0Jpc9vvSeR3x50npUGneKZsvaVp4wSo9z0m7kiCsPotfPw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 AM5PR0201MB2450.eurprd02.prod.outlook.com (2603:10a6:203:35::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.15; Fri, 24 Aug
 2018 08:55:22 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] drm/atmel-hlcdc: allow selecting a higher pixel-clock that requested
Date:   Fri, 24 Aug 2018 10:55:01 +0200
Message-Id: <20180824085501.9740-3-peda@axentia.se>
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
X-MS-Office365-Filtering-Correlation-Id: 46304afd-f185-487e-7336-08d6099f53d2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2450;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2450;3:iSVlE8QtU/oMjS9LMhMfQfrquUtDFWL7y23imUR8d46onREaVLSkZnvny12NC0bRufnrPSpM2GNXRlslwTNSsFPVyArJxk2DT9lreMe9ltrCDX/tJPUNqkPHSlM05muGYRE3Io5YNYBtnWvfwa9NoJDwEBepVHlQo5rQNn4Dfv15bbJT32s7aUJQ6SRWZf+4yPge68DXloMNR3ImRHaf/tyO02f9W00xzCZJCXJTTjiMSoSs/fwLtsj0LF3iG95o;25:poyXCrXfS1PLcSJi2BxwZbggK91+h2zmsaWc1IXUbCA7lppf+8AWn3K5iQCxuSHOy8Q5UALUfbVbH8TiWk22qOOYmkhGvzlaCDf8PkwC7uOFzH4elcjfrZEhhWOoO0nP3y+DkoH9kydemJsusA1pbbp4Rsr64QyIgqYmNwbFJBMNiE8gINNYkNd77WemFVHPGWdMjU+I62/KsuHNYMCRTxR0/mtlUf3Dx1K091Lji25SXvGZ1F8Cdw+XT2lNfuZFUp57Swtyp7mQXF2NYoulp8YgsW2gYJfV+LYOAk18UjannqbtZYZbGtqb7Y4XFjvB5SQtxFTsd4tzccnhcKamNQ==;31:O5bVgzASy+IEewz4D0bLJEg4Adr3KUkFqmBPI4UXQTRWMwRu74qs1onBNjk3G6/N1k+qBmfc68iiiT74vqf1cu8486G2Bh3rd3nAhSk5wcwIrQf7iJVxQrbBu/Ptukpd/3B1TEHA9TVBiOARxmG9hTV1wblH124lAO5xgKkUoOXx/ifeWOadIuPpTy81Jj0BVaoAGMRrFLGpbVOdzzt8LfaSCyWtnFt4g7xFz7fds6o=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2450:
X-Microsoft-Antispam-PRVS: <AM5PR0201MB2450B671DE18A421EC8BE026BC360@AM5PR0201MB2450.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123562045)(2016111802025)(20161123560045)(20161123564045)(20161123558120)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2450;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2450;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2450;4:/UC3Z0nFhEx4dortupxtwjMO5asAwe+HA0oGr100TFIr9Cn++kb15gxojHduWuA7Bc0hj0yk/cyJypFCdCsA+sZWdpYT7EqW17s2BxOQCDzAeCO/wUc4T8okd7FwMJS6GLS3+vIqo6hUuaMUKnyrfSg0ucEJC64Hf2g51YUJZkOiwYKygHUPx9P3GH4SUAVfeQ3KLkWhw0euLxJj3FvIc3w0YPSlLfHWmhkfIwpTIcyyAY9EnR336/tshcIHHAfQq9YZ7uOOlC/k+mxXABDIxA==
X-Forefront-PRVS: 07749F8C42
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(136003)(346002)(366004)(396003)(376002)(39830400003)(189003)(199004)(16586007)(5660300001)(8936002)(2351001)(81166006)(81156014)(8676002)(26005)(186003)(50226002)(4326008)(105586002)(16526019)(106356001)(68736007)(478600001)(2361001)(25786009)(74482002)(6666003)(305945005)(476003)(6486002)(6916009)(446003)(11346002)(36756003)(53936002)(76176011)(51416003)(2616005)(52116002)(7736002)(66066001)(50466002)(86362001)(956004)(486006)(54906003)(6512007)(48376002)(1076002)(316002)(386003)(6506007)(3846002)(2906002)(97736004)(47776003)(6116002)(42262002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2450;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0201MB2450;23:phEf8SlCmls0pMrksshx0fe+PizQzgyODn7fyce?=
 =?us-ascii?Q?83Y6F2zw6iGXeERKsMQVvctWBmQNRsICJKwzYDhK1vbs5kyUcLoN87eRM1Lg?=
 =?us-ascii?Q?+jU7IRF8tKno7damY2krecNuy9MvwWc6wxEqicmF7KqPP6coW+uDAYrU/XOH?=
 =?us-ascii?Q?2wdFwgLWqxgdGb/nuZ3Pu30xB0eHWoGI3HiREnr7a+bUpRodK0DPxjxolJP4?=
 =?us-ascii?Q?Ba52ZmEkV9PKC5RgEMszgjU6GW0BBQR7w0QZe19uxqIqfLvIo30K1ZG/NVZr?=
 =?us-ascii?Q?fIVhb+jhOvbmjnm8leCRnMFPiCkzVUx7nmwkS7rK0FYDsB42uxCe7bDYFOIo?=
 =?us-ascii?Q?HyC672zlePdczhge/0033qMogOCGgiQkufbgbguBfVSUkvP4IXCxJy6s4BGb?=
 =?us-ascii?Q?ooel7fjJ+QB2YNLyVQam125dsOMrroyr3rynHmTcr1gXW7WcNCi+hHp0NmBk?=
 =?us-ascii?Q?5gqeJvDwIkuRcTeWygSDJXzP5292jXfRhsg2CNFMlaBfC9VIQH5WLVsq54Xi?=
 =?us-ascii?Q?gL7Sq2L6SPKIn8u/TzZd9NkfF5M182hW19597OzdpVWaufalOL/ioTunxKeo?=
 =?us-ascii?Q?H+rALalDX+LD2ulvz0iBcs1cq8cw8z+FFgeJJJ2eh/R4avIRUu4yvqDgKO98?=
 =?us-ascii?Q?sdq9LAmqFHD3TLfzFqjtKH4vdZL8X9OTh0XDAVmMs/4N9NVoyOWbEd5tUEd9?=
 =?us-ascii?Q?dDq2w7kpvpYpR8OpVVjnXhxJuyIg6cQNEW8iKgzCrjG7xWBheDVkoHC/glOq?=
 =?us-ascii?Q?0qmMVplnG+TDv32gYU5tXcD4ok9N5RgG0tQN/lk2jP8IajzcJBplDjalO7MQ?=
 =?us-ascii?Q?rbSe2b/HJP/SicdHBb4sxS097CiKu/zhOvAy60TR+OojQDvdhMgv3j12REAb?=
 =?us-ascii?Q?apJdmO0vuMNnp2hLfR+6nWzXXzT8nUNwMVLVQVYxutBwmrV9S37s8UFszpiX?=
 =?us-ascii?Q?zSI0ZJZLsqFMKqDmSXhJYZiNteFC+LCMOuPYtvU/slSUszcPMygAMkZgAi+j?=
 =?us-ascii?Q?eAEsgeyJ8js8NzsKcEG7sALfRmA+fEMSo9QtWl75VmCbSMlkqXNzDRxMVEA2?=
 =?us-ascii?Q?9EXC29ifJXxEt+iJ61BKel8xeE7wcYct3VOnPFQcOVf62QJ9yl/ohP88bxkT?=
 =?us-ascii?Q?paWvl6zOZJGn58erSIJbSFmgq7OMBbgA3GyswUp726fAOMiMGFdq6OPCXUun?=
 =?us-ascii?Q?rivS+T+cwdkN+jZpnUuRfhUf8uPVwkmw5hCSDpXA5gad70zrhIQZ/lOBTZa2?=
 =?us-ascii?Q?rn53j3v28FjaYTd+WoA0ZWa+7pL40TkbsGBn5lqo/jrXxSFbHGB+dJyWvsgF?=
 =?us-ascii?Q?pGBCbV6c1D4F1ck1tGEDJgi5su8dTUIlh1JvfuvPF777hMeLcdCKNVB0+Xab?=
 =?us-ascii?Q?+UJVSacsZXRm7zLTtdQ8zac28LKs=3D?=
X-Microsoft-Antispam-Message-Info: K6HgcjuBLf+ODtSyR6v2jJYQaw0TGgiAtv9iQo3ERRjY5PAzwEwEZcuW2hjK7oIIHXbym+PgDu2XHAUgh6flFj5Hllu+bzH2apoXWr1SxQxkl1nq09+0PNllD/1/SWWqDjjd1WHYGdgi8MUGHVPNI5PDlHPiteIjc1XujfKVP+WjurRd3+aRVauo+vRIK5ww7Dhn1/HY5vODj3G++JX6Qz/WB13/dwSE1CF1ysRgPajGgnA71ZeuO2CzHkXaQsgVgVl3pQCgXWxJlkBylVJ7a2P+W2mHn0GoakxdSqmt5RPFJ5d+nqWXIelkpvj+tmXBrjxhH+nhhJCdst5lnOqcjR7zJJX9n6sk27KrE31DQO0=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2450;6:3H43+bBGd2g3koD7+WwClSG+wRls3oAjayLUckt8KqXlX0BA2IyPf6pvqs2tJU74wR4ws07GsPGojrb7WXMr0z3Mbpoy27mZdP+QhHe/VD2sm3OVz5XKBH4fs7dRWDb07ZZ5D9OofHp/YiWIaA9MuPiQYF5fzFLs1zbLVF7c2p8SV+QbVX81XpM5rJ+zUiw9ZmVwpnPLmQwgVLSbOLwYfwIrSS5UN6NEyhW+21bQpKfpYFqWu5n022/JXl9QDltsoAkRACA1ztwGAmWSuI76LFuvITVuVGoCNpwFdwQYmgXQdx5pYRsrdV3Q/JVmD7yQmNvRFidKXTq98y/E4Nk50V+PzhQVc2u8JRBnnYZtilUNP46x0XPp5tO97WAUfQ9OPrs9kZdjC8Sj5RAhxxexUT9Sq5kxfVickNLhv+VuXHO4wnfpQ9pq/nIIbjQKCS6vx51B1Kd7IYkzHDefXYNKdw==;5:0qDLdXtF7Jbaz/Me+1kjOcrrGwT4jgWCTMavpqhN6YM0bFN2+0NOuKmuwSKwTmJhAxQZhE8aZ0mwFZACi9LFNJV6aXu8JVjzThWsVy6OhZH/oyIQI+qACxg4tNXYL5yic200Ry0Qz1H2wgdYH41XpmMCrX9BNlsK6xEcSq6gr4k=;7:JtWW54Abt0gznvcHqZRP+4y/mAF0rdtN737ke3SXJD1dgzSzkvCswptg9mh16xYwUUhCKWCcVrhV8SLZty6NCOj2bqpWDlEHwqhCCrb/GXFz3tndVgLvKTNQ5i1PNOmnzBw8oaWLQ8un8Hvl2ahqUY18EkRdgCY16jBr4ofROloJS41hkh9kiTpONmsYT9IgltBEUs1GHm7L6QdmMBKX/NRgB0ZiUOvjECiupfv8D06whyHAmh5XdSwF/o8JmOO5
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2018 08:55:22.3848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46304afd-f185-487e-7336-08d6099f53d2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2450
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

But only if the highest pixel-clock frequency lower than requested
is significantly much less accurate that the lowest frequency higher
than requested.

I pulled "10 times" as the discriminator out of the hat, and went with
that.

This is useful, if e.g. the target pixel-clock is 65MHz and the sys_clk
is 132MHz. In this case the highest possible pixel-clock lower than the
requested 65MHz is 52.8MHz, which is almost 20% off (and outside the
spec for the panel). The lowest possible pixel-clock higher than 65MHz
is 66MHz, which is a *much* better match, and only 1.5% off.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index 71c9cd90d2ae..0c2717ed4ac6 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -116,6 +116,19 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
 		div = DIV_ROUND_UP(prate, mode_rate);
 		if (ATMEL_HLCDC_CLKDIV(div) & ~ATMEL_HLCDC_CLKDIV_MASK)
 			div = ATMEL_HLCDC_CLKDIV_MASK;
+	} else {
+		int div_low = prate / mode_rate;
+
+		if (div_low >= 2 &&
+		    ((prate / div_low - mode_rate) <
+		     10 * (mode_rate - prate / div)))
+			/*
+			 * At least 10 times better when
+			 * using a higher frequency than
+			 * requested, instead of a lower.
+			 * So, go with that.
+			 */
+			div = div_low;
 	}
 
 	cfg |= ATMEL_HLCDC_CLKDIV(div);
-- 
2.11.0

