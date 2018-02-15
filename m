Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1906823-1518711272-2-4112621625420959093
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518711272; b=LmNxF2ZwMmMaoba2ft5pnO0VVLfIgLPNR1jfFsmf5pCUFRV
    BAjENFOG1ypaU2jokvRjbSqiaBUoV4YBkZbmJqooXUIoDkvwYeRfvad/VTSIL99/
    oyME8V8AlkPI00UFoM9UkwnC5Y3mw5U5LFmMlQQsp1KSsx+Ap7bjeU766FfPqJry
    afNBYSkxIWsqaFbsk4vmdQrRHlUeVW/YlAgDG5cEIuB1ZOK58W3a0TnhliIwTLUT
    UTt6nSt//06lzkpHFuWELUkAi5zfZpMO7yMgRjTpLO1SNBV0jUxuP2+sw1kxEgQM
    OzSB8ORR8vosmwgAh48QFfJbBC4ZxN3uGI+S6QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518711272; bh=Hu3heJrbyntDxC1KH1b2WpMiu9
    S0zqJcOp+sU9zdDKk=; b=uxJLACp6hpV1CWXGEuaKV5m3nspzb5GGsKMqcH6SEA
    XhpYjGK7mZtSl9TQln5eavC/s3fG0vdEZoYp3E/XfEx0fDQZwXsnZsoyijpIizWg
    tKmSdnVx9o3UJz3Tzpuc5iHL0xw4yuo9ALAGn8B+vxM5l2uIgois+gsReyPqT5+Y
    /VSfmDceK5fPxZBxH5fC5ZjJU1/dPIqDqw6LTYJYycZKjtIMpGNAdbv/S/pGEaG0
    znECSYbJajHbSf/pJCkILzsDO3hKykLIpRYD0YchhIbj+W+E0tW1hpe1Te1wIGCm
    baN/CSRDpWmCnZKtbvpLkaW3NVjvtolWlwPs1QVtH13A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034014AbeBOPo4 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:44:56 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34726 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033455AbeBOPoy (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:44:54 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Keeping <john@metanate.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.15 138/202] ASoC: rockchip: i2s: fix playback after runtime resume
Date: Thu, 15 Feb 2018 16:17:18 +0100
Message-Id: <20180215151720.321725404@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Keeping <john@metanate.com>

commit c66234cfedfc3e6e3b62563a5f2c1562be09a35d upstream.

When restoring registers during runtime resume, we must not write to
I2S_TXDR which is the transmit FIFO as this queues up a sample to be
output and pushes all of the output channels down by one.

This can be demonstrated with the speaker-test utility:

	for i in a b c; do speaker-test -c 2 -s 1; done

which should play a test through the left speaker three times but if the
I2S hardware starts runtime suspended the first sample will be played
through the right speaker.

Fix this by marking I2S_TXDR as volatile (which also requires marking it
as readble, even though it technically isn't).  This seems to be the
most robust fix, the alternative of giving I2S_TXDR a default value is
more fragile since it does not prevent regcache writing to the register
in all circumstances.

While here, also fix the configuration of I2S_RXDR and I2S_FIFOLR; these
are not writable so they do not suffer from the same problem as I2S_TXDR
but reading from I2S_RXDR does suffer from a similar problem.

Fixes: f0447f6cbb20 ("ASoC: rockchip: i2s: restore register during runtime_suspend/resume cycle", 2016-09-07)
Signed-off-by: John Keeping <john@metanate.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/rockchip/rockchip_i2s.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -504,6 +504,7 @@ static bool rockchip_i2s_rd_reg(struct d
 	case I2S_INTCR:
 	case I2S_XFER:
 	case I2S_CLR:
+	case I2S_TXDR:
 	case I2S_RXDR:
 	case I2S_FIFOLR:
 	case I2S_INTSR:
@@ -518,6 +519,9 @@ static bool rockchip_i2s_volatile_reg(st
 	switch (reg) {
 	case I2S_INTSR:
 	case I2S_CLR:
+	case I2S_FIFOLR:
+	case I2S_TXDR:
+	case I2S_RXDR:
 		return true;
 	default:
 		return false;
@@ -527,6 +531,8 @@ static bool rockchip_i2s_volatile_reg(st
 static bool rockchip_i2s_precious_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case I2S_RXDR:
+		return true;
 	default:
 		return false;
 	}
