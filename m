Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1883814-1518710509-2-10512439140798374459
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
    t=1518710508; b=wXG7Y5mPyDohuNc6CiZmLjkQy7yYO7ylttRXpIIO4CZrY8B
    FQAUmfrF28yk+sRzXAjJlMo4VnTlE2+KCQYQ+Xo676w7w4woMBDyOvR0kiGuy4De
    TWna6YDcBNt1inw7tbsW6VTSzHC1L/QAuPhkbMgs1MJZopJCOCnPpyTuBCm/ALmH
    JbN3wQQ3TrLDblS5rxcz9f/SwmUiJPF5JUqM/fueYyjyHUrqywSQZzng47jyh+uY
    qJZNPaEdBwtDI7Ij5VcUe++LG02G1swOUZGKgJMGarFC2Hg7EuyOtlM63Dk8whQ/
    FR1nhQUCMnLv6H/KA3nN+jw5bctRRMNWmAVqnTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518710508; bh=6QRZ28abdKrAQVaJqKeCyuNgiL
    FsmgLtsK1SaeKlv9o=; b=DaxqncTio0EWis3KRYmiyumjlqoBp1/UgojSeNm8Rw
    /qVRiuqnzBe5vqf+zPcf/Et2y4tYKvM/XE8qfzexcUtN23yYRYdtV7Ba1Qr4JHnZ
    0z27m08BWp3aOskLb4/D/TQ9KXb2zXl9IXwTO2AAljNpxsAwvqR2i3PoGLNAzcom
    LgAiQ9GKjY/DX1P3wbdC+TwtzLyb5FgQ4hHc+3m77HP7Ew0YodNcNObC6G+50Qpg
    2QM5J2Lr/t4Tl8NLcnXimXXqpqdEiXU7falanGDdHjpkLzwba2acqrY8GKvXUG2/
    UhgTRzBe4lbKvecQA88n79L1EmckgnhBHqeqHhY2GqIg==
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
        id S1424735AbeBOPqq (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:46:46 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35924 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424685AbeBOPqp (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:46:45 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.15 178/202] pinctrl: sx150x: Unregister the pinctrl on release
Date: Thu, 15 Feb 2018 16:17:58 +0100
Message-Id: <20180215151722.185849457@linuxfoundation.org>
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

From: Peter Rosin <peda@axentia.se>

commit 0657cb50b5a75abd92956028727dc255d690a4a6 upstream.

There is no matching call to pinctrl_unregister, so switch to the
managed devm_pinctrl_register to clean up properly when done.

Fixes: 9e80f9064e73 ("pinctrl: Add SX150X GPIO Extender Pinctrl Driver")
Signed-off-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pinctrl/pinctrl-sx150x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pinctrl/pinctrl-sx150x.c
+++ b/drivers/pinctrl/pinctrl-sx150x.c
@@ -1225,7 +1225,7 @@ static int sx150x_probe(struct i2c_clien
 	pctl->pinctrl_desc.npins = pctl->data->npins;
 	pctl->pinctrl_desc.owner = THIS_MODULE;
 
-	pctl->pctldev = pinctrl_register(&pctl->pinctrl_desc, dev, pctl);
+	pctl->pctldev = devm_pinctrl_register(dev, &pctl->pinctrl_desc, pctl);
 	if (IS_ERR(pctl->pctldev)) {
 		dev_err(dev, "Failed to register pinctrl device\n");
 		return PTR_ERR(pctl->pctldev);
