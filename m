Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3552852-1521221920-4-7681668269225586409
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521221920; b=eoAJVA0bSKttmrWUBHsVIRGVhPxwxTODeSP6GHaIwQ0nXsQ
    iTuv8ZAmeWvcREdw+HZlZ8ZrQzWVr/N6dQPzazAbiFPRNIQyGhtJSvBjJj185uIB
    pthFtuuq24T36nfR6tVymie+EP6inP151P5EFDm7BBlGNqCfS/UuZsX48EzSUaqp
    lt4lykFPMJOgsXn34EnB/RmWmL0rD34uytxjbEy+v/BiLsE8n9Bx9GzYwuaBlSyP
    5nseXEt85cNDnFZ/XoX7WdQhHSiKmpvmp7lUOQRzuOyxcJ1zKGsgjcgF1z68J0pw
    40WlfXOoNTYvaXP5lNQZLtQSr29RAhAtsBbYHOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521221920; bh=HzwZgifk3/i3MMH8xLKODhXB+Y
    VjT7T2KVWF35HZIw8=; b=OfjDTB+dza2v/OlrtKZkTWZXMIt6niZCTmEzsZDGDg
    CMXW3jTgHnNSmYjiGPvWQCt0gr1viGW1pKarycDbM4wt7bwSHWqLv/obMx+YlYfE
    u14WqqrxMp5qmjw8SmrVi8Hd5vc6ABCTd0ghsGLWksRSOMP1ZF2HUD/9MLvGyPwk
    RQXweKdwlqfHLH1f7+0do3lpGB0UZsHVXml6enTy44HJnViha/0kFRAvGqc1hbjY
    4fQM+0niCMulKGmRzH17l8R+wxSKTX74GR+4zt0Y+tNN+nDywf1gPK7y1MF7kyzu
    3Zb8kjoR8EzzSLIMdwzLm8B+Oi/T59FUr2YA1nkqIZAA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
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
        id S1753323AbeCPPXa (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:23:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33134 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752655AbeCPPX2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:23:28 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhang Bo <zbsdta@126.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3.18 03/25] Input: matrix_keypad - fix race when disabling interrupts
Date: Fri, 16 Mar 2018 16:22:50 +0100
Message-Id: <20180316152232.898976977@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152232.750180431@linuxfoundation.org>
References: <20180316152232.750180431@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Bo <zbsdta@126.com>

commit ea4f7bd2aca9f68470e9aac0fc9432fd180b1fe7 upstream.

If matrix_keypad_stop() is executing and the keypad interrupt is triggered,
disable_row_irqs() may be called by both matrix_keypad_interrupt() and
matrix_keypad_stop() at the same time, causing interrupts to be disabled
twice and the keypad being "stuck" after resuming.

Take lock when setting keypad->stopped to ensure that ISR will not race
with matrix_keypad_stop() disabling interrupts.

Signed-off-by: Zhang Bo <zbsdta@126.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/keyboard/matrix_keypad.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -216,8 +216,10 @@ static void matrix_keypad_stop(struct in
 {
 	struct matrix_keypad *keypad = input_get_drvdata(dev);
 
+	spin_lock_irq(&keypad->lock);
 	keypad->stopped = true;
-	mb();
+	spin_unlock_irq(&keypad->lock);
+
 	flush_work(&keypad->work.work);
 	/*
 	 * matrix_keypad_scan() will leave IRQs enabled;
