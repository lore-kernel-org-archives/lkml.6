Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3704313-1519413927-2-1834885000173008394
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519413926; b=plZ35UYgOAmOMdJKuQG9JcSapK23wCwlSCxgceq/779v+tE
    cmZePNGKbKovjWLrdLotP5YnUjc7mhr920yn8uQ0iVCBEuxoPV0hqOx1/kxZ2whN
    de6/ILgg4Rkln7jwY70X0i7fbWeIhpx2JZAjwJs+C3o2338rFArw8M5ga32l2ZrZ
    4qGAQrN8JuUf/IWTDYoJ9heJBxQc8sqtY1R4dTAlWUvuYOsj1J5pKjkal6J8RxFx
    hnwJg7EMZq+mOOmK7sx42aardnmHOC633ilI8LrPs/WZleRBRQc1LwBUJW6BVyAA
    spBfj2E1QLR11KphjCVMbaDbrkJHC0AoRRvxIxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519413926; bh=S9a9tATbw06h9L7DdoSXdQ2UNl
    eMV6WtVfFxBnnvEZ4=; b=PwxGHzNQw/aqEmIi/MB6W2U0zlXq2ncg2J9ZBgFDKo
    t6WAaiLKtm8EAmz/JZgasJZMArac+aGXnn4DlTvpLsb/9bMvpy6eACf1miOotf0f
    BnJDfOfX7dF+38SeW8tIe/brcjxV1A/Kh2+byiS1Z894zeU8z7cz+dueun7pz8av
    lnULmzKQ4cvh+OSlGSndqskhUk289cTM7Ln+TGLIMVJfyUHmZwXWRZlhBGs9kVdm
    dUxm4Dp8w24CGa4QRwDQiAt0Xmfr3hhNYYq5e6fVbx2attyA9HGQD1WTOAdOyEFO
    LOO7/uJp/An7EamD/j8CVzb74VFY7VKYDJxbKhGGHLRA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935248AbeBWSwz (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:52:55 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47142 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935204AbeBWSwy (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:52:54 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 082/159] gpio: 74x164: Fix crash during .remove()
Date: Fri, 23 Feb 2018 19:26:30 +0100
Message-Id: <20180223170753.496872487@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>


[ Upstream commit a158531f3c92467df0e93e000d58185acae78a6e ]

Commit 7ebc194d0fd4bb0f ("gpio: 74x164: Introduce 'enable-gpios'
property") added a new member gpiod_oe to the end of the struct
gen_74x164_chip, after the zero-length buffer array.

However, this buffer is a flexible array, allocated together with the
structure during .probe().  As the buffer is no longer the last member,
writing to it corrupts the newly added member after it.
During device removal, the corrupted member will be used as a pointer,
leading to a crash.

This went unnoticed, as the flexible array was declared as "buffer[0]"
instead of "buffer[]", and thus did not trigger a "flexible array member
not at end of struct" error from gcc.

Move the gpiod_oe field up to fix this, and drop the zero from the array
size to prevent future similar bugs.

Fixes: 7ebc194d0fd4bb0f ("gpio: 74x164: Introduce 'enable-gpios' property")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpio-74x164.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpio/gpio-74x164.c
+++ b/drivers/gpio/gpio-74x164.c
@@ -23,6 +23,7 @@
 struct gen_74x164_chip {
 	struct gpio_chip	gpio_chip;
 	struct mutex		lock;
+	struct gpio_desc	*gpiod_oe;
 	u32			registers;
 	/*
 	 * Since the registers are chained, every byte sent will make
@@ -31,8 +32,7 @@ struct gen_74x164_chip {
 	 * register at the end of the transfer. So, to have a logical
 	 * numbering, store the bytes in reverse order.
 	 */
-	u8			buffer[0];
-	struct gpio_desc	*gpiod_oe;
+	u8			buffer[];
 };
 
 static int __gen_74x164_write_config(struct gen_74x164_chip *chip)
