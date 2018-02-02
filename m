Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2943005-1517591228-2-10427360555529902123
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensvda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591227; b=qe4+JyR9ooOWZMntuJjFXYgLHa4Ziy/u3McPQ+Ctmo2LNSb
    qQBxVZRWjHpKNfOhweHo8yMClAK4N509LGNH+J9EncWCCkD7Z1Tj+vjx4YJlCmFW
    swNLNmTWOhfRAxlsTQeHHIRvQq9/iPKRSNN3+Ky3ts1FAUpuWOWvQkErYXeJNyGm
    inwaTQrG+jDtawyPPbTek2C3dEBzNfqHz2nxmw9UKFOiYb3ZH01xmsSuq/MdMoud
    kAUod8eI8rkLW6k+w+/M37aBEXFdmkNc2JUFxWWpJwhy0kK1C8918wX7WnwOiFj1
    K9RFFAt24w0zTVRRTwpInT0R+dgj3V8HuzXcAkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591227; bh=2Ro1e1ymrtpudPzM0811ZgVC7f
    cytNwNKj4OJHfkxRo=; b=J8cSsyl5LI7kQckmq+oznYu6n3m+dKhpp09MQAcZPT
    XDHI8d/kqmfiJ4oGzRwmLuZKZGlyppWqsVOFi7eNyRnerG57GE0s0b0aRj6SY8Pa
    s22rGamJ5SEQAhqy0cR5vzuHzxCAOzPjD659GCmjtNlddjNNCuAsUoutPfY6mBPs
    kmsP5DywYPsNLif7nqh257fWoCQG8lSfh9HWJKqFqrSPJMxBBMohTReNgE7kP6ha
    BJZbJFRQG6Pm48XwxCX7GNAK6zV/A2gSgvjjv+4iT+8zABDuGQfDhbvvng/5Ui7k
    vfXTW0l7CZaJpx5OP0lK40QBbgIKgEGHZQ1UZsb1pHFA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752949AbeBBRHF (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:07:05 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36918 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752910AbeBBRHC (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:07:02 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.9 86/86] spi: imx: do not access registers while clocks disabled
Date: Fri,  2 Feb 2018 17:58:46 +0100
Message-Id: <20180202140830.666019664@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Agner <stefan@agner.ch>

commit d593574aff0ab846136190b1729c151c736727ec upstream.

Since clocks are disabled except during message transfer clocks
are also disabled when spi_imx_remove gets called. Accessing
registers leads to a freeeze at least on a i.MX 6ULL. Enable
clocks before disabling accessing the MXC_CSPICTRL register.

Fixes: 9e556dcc55774 ("spi: spi-imx: only enable the clocks when we start to transfer a message")
Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi-imx.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1307,12 +1307,23 @@ static int spi_imx_remove(struct platfor
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
+	int ret;
 
 	spi_bitbang_stop(&spi_imx->bitbang);
 
+	ret = clk_enable(spi_imx->clk_per);
+	if (ret)
+		return ret;
+
+	ret = clk_enable(spi_imx->clk_ipg);
+	if (ret) {
+		clk_disable(spi_imx->clk_per);
+		return ret;
+	}
+
 	writel(0, spi_imx->base + MXC_CSPICTRL);
-	clk_unprepare(spi_imx->clk_ipg);
-	clk_unprepare(spi_imx->clk_per);
+	clk_disable_unprepare(spi_imx->clk_ipg);
+	clk_disable_unprepare(spi_imx->clk_per);
 	spi_imx_sdma_exit(spi_imx);
 	spi_master_put(master);
 
