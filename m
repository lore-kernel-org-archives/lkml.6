Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2879036-1517590970-2-2592059945401870965
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
    t=1517590970; b=r5j325/+lWFIaOxi7rXsDsiA+RaX2ubZfL3kCMKQ+53zRDL
    QjcqHZiYmrdAAIgVXc0BI7fqRQ3EFBW7Snj4NfwEgN7NZmboKgXsQ5Xi9Gmvj0yY
    kZCJOd9gFlS3Tf1cJw22w5/Z1X7/eXN2nJKEWNzA0uZOCr5foUMGh9MO4qDE+CQw
    /vzCHD7tzgaQR+4THq6p+ZfnUeHE+YytK8gYOdxdYQrgSg8YDPHNnzPVO4snhpsa
    R1yWGpqBZUawfSRDmZqru07qdXF7QaVFuXWI5wSJ85Xc9jte+hVTuIRnw0YcBC6v
    Ulkfz/DyT0hQzyPYpUCgYIxXiDMy1xMTZbqL1GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517590970; bh=8fRPHXBwQ2hjFq9IUG95M97mZe
    h5MYfwXsRWG3klTeg=; b=qQnX77AcWesIysPmYSYofMDQYRp5aktzspL/OkXjhj
    nZmSP6AcGLbR7MjfhSge9mL7UxPLyZgxAsxJkR2taQJ2W/OQ4hDV8dyhNIDQOsP5
    QOcvrEEI7PBqg4mcWByiU9g14n/xdsuKo+lDF0oGNDnuV71kxPDCw6U7HqDHOpWU
    U5Hnp2UvB4BS+dO1zV8dRAjy0D8bJ6CnbEaUFiTfQF7G2q/MlKC9MTCIalFrIsMM
    8cf/1pBcWSvp9Z6ysQ7CYGJqdv3bEFynnJ54cdNIb+u+wdofIZs5XDN25NAa0+aw
    NYkVaAVZF4O7dMJdUGcQsyUaVyRPecwJC1jZa5eCAl0g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752781AbeBBRCr (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:02:47 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35504 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752776AbeBBRCp (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:02:45 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.4 67/67] spi: imx: do not access registers while clocks disabled
Date: Fri,  2 Feb 2018 17:58:36 +0100
Message-Id: <20180202140822.554477179@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1228,12 +1228,23 @@ static int spi_imx_remove(struct platfor
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
 
