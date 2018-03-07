Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4098462-1520453180-2-11281971478977834842
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520453180; b=fS51YhSQwfuAcOf4Fud2+t+z6YP1WHwdXGgx9SsxQjsAu2Q
    zU12aKvWI6aYmC3uzLyT/nTrHasp3+CBV0BgUTPPd5IiNrOlV8vhJ8FM0rohxDgW
    iL3WIS28ZhKqXR1pegHnb1+lvTR655XwAL8bMtN737Lk1wQUKa6Ffpn67rdxuGYF
    pOtbIHZ8gulnHKGPu3TEZAucznb+Ta+12HlkW/V4ceProThtXl90DtYj6OrSWGw6
    JYO0UrwvW7GKzRCTVAuoddDvsSlncE8q/DWnKtpcj6GxbqNrc1xm02s1Y1giZ5WA
    sGZwWl7GqN82KPpxrvq5ppOahLiUIvfuGrUN3qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520453180; bh=qEZsKuboQtkXW+kbTKWIde9Owq
    lLojrYZdjUucCZ7f4=; b=MKjRLRs/oMs5MN7LdDllbXHivPc9UQNfDrSTb3iVcp
    70r3BJ4iVWvny8cu/i82TmDAhI/W9vLXORVRlF0yrjeXyg8EdE1wfJ5PwxJnJoPB
    Dbe+K7q1hcXB5DVn0Mm1EJJ3w7Spg4UBx2pke2t5tP2Du8jx1rWgRyo7nVIbo3xl
    isfyRXBy/mn3DeqoYG2NftXq8PUVPYpMEsoCi7WskPV8d9UaQrzRWp6PLI5X4lJX
    TcAQaafHY8bNE/55Q1KTUVhyV9cJT/XeGiNgwaFgf1yy4uA4yeefJvohmRp8qUmo
    kzPnyD7T7KEV0L1B103LHqW8mfFtRP4FwcYKJ3SdhxIA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934899AbeCGUFq (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 15:05:46 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44504 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965482AbeCGTqM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:46:12 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.14 019/110] mmc: dw_mmc: Fix out-of-bounds access for slots caps
Date: Wed,  7 Mar 2018 11:38:02 -0800
Message-Id: <20180307191042.182346451@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shawn Lin <shawn.lin@rock-chips.com>

commit 0d84b9e5631d923744767dc6608672df906dd092 upstream.

Add num_caps field for dw_mci_drv_data to validate the controller
id from DT alias and non-DT ways.

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Fixes: 800d78bfccb3 ("mmc: dw_mmc: add support for implementation specific callbacks")
Cc: <stable@vger.kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/dw_mmc-exynos.c   |    1 +
 drivers/mmc/host/dw_mmc-k3.c       |    1 +
 drivers/mmc/host/dw_mmc-rockchip.c |    1 +
 drivers/mmc/host/dw_mmc-zx.c       |    1 +
 drivers/mmc/host/dw_mmc.c          |    9 ++++++++-
 drivers/mmc/host/dw_mmc.h          |    2 ++
 6 files changed, 14 insertions(+), 1 deletion(-)

--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -487,6 +487,7 @@ static unsigned long exynos_dwmmc_caps[4
 
 static const struct dw_mci_drv_data exynos_drv_data = {
 	.caps			= exynos_dwmmc_caps,
+	.num_caps		= ARRAY_SIZE(exynos_dwmmc_caps),
 	.init			= dw_mci_exynos_priv_init,
 	.set_ios		= dw_mci_exynos_set_ios,
 	.parse_dt		= dw_mci_exynos_parse_dt,
--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -210,6 +210,7 @@ static int dw_mci_hi6220_execute_tuning(
 
 static const struct dw_mci_drv_data hi6220_data = {
 	.caps			= dw_mci_hi6220_caps,
+	.num_caps		= ARRAY_SIZE(dw_mci_hi6220_caps),
 	.switch_voltage		= dw_mci_hi6220_switch_voltage,
 	.set_ios		= dw_mci_hi6220_set_ios,
 	.parse_dt		= dw_mci_hi6220_parse_dt,
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -319,6 +319,7 @@ static const struct dw_mci_drv_data rk29
 
 static const struct dw_mci_drv_data rk3288_drv_data = {
 	.caps			= dw_mci_rk3288_dwmmc_caps,
+	.num_caps		= ARRAY_SIZE(dw_mci_rk3288_dwmmc_caps),
 	.set_ios		= dw_mci_rk3288_set_ios,
 	.execute_tuning		= dw_mci_rk3288_execute_tuning,
 	.parse_dt		= dw_mci_rk3288_parse_dt,
--- a/drivers/mmc/host/dw_mmc-zx.c
+++ b/drivers/mmc/host/dw_mmc-zx.c
@@ -195,6 +195,7 @@ static unsigned long zx_dwmmc_caps[3] =
 
 static const struct dw_mci_drv_data zx_drv_data = {
 	.caps			= zx_dwmmc_caps,
+	.num_caps		= ARRAY_SIZE(zx_dwmmc_caps),
 	.execute_tuning		= dw_mci_zx_execute_tuning,
 	.prepare_hs400_tuning	= dw_mci_zx_prepare_hs400_tuning,
 	.parse_dt               = dw_mci_zx_parse_dt,
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2788,8 +2788,15 @@ static int dw_mci_init_slot_caps(struct
 	} else {
 		ctrl_id = to_platform_device(host->dev)->id;
 	}
-	if (drv_data && drv_data->caps)
+
+	if (drv_data && drv_data->caps) {
+		if (ctrl_id >= drv_data->num_caps) {
+			dev_err(host->dev, "invalid controller id %d\n",
+				ctrl_id);
+			return -EINVAL;
+		}
 		mmc->caps |= drv_data->caps[ctrl_id];
+	}
 
 	if (host->pdata->caps2)
 		mmc->caps2 = host->pdata->caps2;
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -542,6 +542,7 @@ struct dw_mci_slot {
 /**
  * dw_mci driver data - dw-mshc implementation specific driver data.
  * @caps: mmc subsystem specified capabilities of the controller(s).
+ * @num_caps: number of capabilities specified by @caps.
  * @init: early implementation specific initialization.
  * @set_ios: handle bus specific extensions.
  * @parse_dt: parse implementation specific device tree properties.
@@ -553,6 +554,7 @@ struct dw_mci_slot {
  */
 struct dw_mci_drv_data {
 	unsigned long	*caps;
+	u32		num_caps;
 	int		(*init)(struct dw_mci *host);
 	void		(*set_ios)(struct dw_mci *host, struct mmc_ios *ios);
 	int		(*parse_dt)(struct dw_mci *host);
