Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1148518-1519980579-2-13595007940997781692
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519980579; b=Da8TyT6HWvk9fDyZ/ktWQIVqHgiBmFrUWR7LyekFa5PifX1
    h6YUlEseFjC6caWgxary4C1S42jqnDlEmfuoF/QX0ru3ilAvcOrLBgkNbdJ27/gV
    wU1p/zpp+ChL/Or2ks2jn4/dxw3vJBSfpjj29xp5wT0fvGPO4VRjy5OoXVXzP+QK
    6ASn2aSKGS1pVQv46D4ZR8y2LDYUjEOMKj5Afa49FMXD23iWDssNm3iwAVul4Xmd
    lLv6ufvZav2SpnjGEtzccTo+Y2XgEL4wu/nqUbi/DubYYetGMtnvGN4dqF3sgEVy
    lP3KI0LRdh3i1UJ0S6T7F4tFpy/yXjKg50ModCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1519980579; bh=liBKtyfUzGly2ErDeU29aHMo5vnseS7xe4q/VTfByPw=; b=o
    FzhRHAhc6pkHryDcEDhVi3B2GZkXIC7BNqBjzzAoCJwVxoDaIhds403r1yEWdqVt
    KTBAWkNLrQpb8/InYQtEe+YLmFNYlBXazBaM+pj93JIwfWAqvrr0pQ3Pj/QSJ/VE
    GI2d/MFWg97MA5Zz4UMaGuRnQc0QaWUTWcvKVpmAkYR7laBIOoUlD4DLTWR3tA8q
    7xwPCaT8iSQYmxL8fJzai+I81rC76FnAGEyPZedGB+P4vo25ur11ntGMaBhHa2mj
    U3WX1rqThbIUr06t1qnvjKQuo3IJnDxY8SkDPKrztTHQ1hU1nullX8socQKwe0l6
    sNnoNash/hn93aCCD6S9Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423135AbeCBItY (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 03:49:24 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:22694 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1422674AbeCBItW (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 03:49:22 -0500
X-UUID: 3539ebcbdfab49e08a446cf467e391de-20180302
From: <sean.wang@mediatek.com>
To: <thierry.reding@gmail.com>, <matthias.bgg@gmail.com>
CC: <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v1] pwm: mediatek: improve precision in rate calculation
Date: Fri, 2 Mar 2018 16:49:14 +0800
Message-ID: <72b74a30ced1c7e7549dcbb56d6123fc27fac405.1519980119.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sean Wang <sean.wang@mediatek.com>

Add a way that turning resolution from in nanosecond into in picosecond
to improve noticeably almost 4.5% precision.

It's necessary to hold the new resolution with type u64 and thus related
operations on u64 are applied instead in those rate calculations.

And the patch has a dependency on [1].

[1] http://lists.infradead.org/pipermail/linux-mediatek/2018-March/012225.html

Cc: stable@vger.kernel.org
Fixes: caf065f8fd58 ("pwm: Add MediaTek PWM support")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pwm/pwm-mediatek.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 796baea..98b0a93 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -135,19 +135,25 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
 	struct clk *clk = pc->clks[MTK_CLK_PWM1 + pwm->hwpwm];
-	u32 resolution, clkdiv = 0, reg_width = PWMDWIDTH,
+	u32 clkdiv = 0, cnt_period, cnt_duty, reg_width = PWMDWIDTH,
 	    reg_thres = PWMTHRES;
+	u64 resolution;
 	int ret;
 
 	ret = mtk_pwm_clk_enable(chip, pwm);
 	if (ret < 0)
 		return ret;
 
-	resolution = NSEC_PER_SEC / clk_get_rate(clk);
+	/* Using resolution in picosecond gets accuracy higher */
+	resolution = (u64)NSEC_PER_SEC * 1000;
+	do_div(resolution, clk_get_rate(clk));
 
-	while (period_ns / resolution > 8191) {
+	cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000, resolution);
+	while (cnt_period > 8191) {
 		resolution *= 2;
 		clkdiv++;
+		cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000,
+						   resolution);
 	}
 
 	if (clkdiv > PWM_CLK_DIV_MAX) {
@@ -165,9 +171,10 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		reg_thres = PWM45THRES_FIXUP;
 	}
 
+	cnt_duty = DIV_ROUND_CLOSEST_ULL((u64)duty_ns * 1000, resolution);
 	mtk_pwm_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
-	mtk_pwm_writel(pc, pwm->hwpwm, reg_width, period_ns / resolution);
-	mtk_pwm_writel(pc, pwm->hwpwm, reg_thres, duty_ns / resolution);
+	mtk_pwm_writel(pc, pwm->hwpwm, reg_width, cnt_period);
+	mtk_pwm_writel(pc, pwm->hwpwm, reg_thres, cnt_duty);
 
 	mtk_pwm_clk_disable(chip, pwm);
 
-- 
2.7.4
