Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2879036-1517591003-2-14117595516198628690
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591003; b=lpxe9ay238zr+GQpxPVhDfZKalZosQeVDdP9oqw3sJrrz8M
    0wDElgSko6COofQcjVXNSR570B3iRDqk+xp4TPvtEJ9bFlHIUYAnqfCVVs6DFXcw
    TUGJomPanu7BqqmTImPZzO7mt1cFXJShAyBaGZznjVqhHqjkbH6Mdnt0pIN6dHCQ
    nL5n4eL6LI84zGSsJ9urWUXsIVVmlm47g02xniRTICmJ+9M9hNtXJ6E1FCf4x3D4
    BVoHBXpjevrPwp9dNhgSmUiPMIBJv4Qhkiq61iCJhONnstFNK39pqIWSecsD4NUM
    +EohyF4WlJHyJdqrh6zBffMPQKZAGd2X8CzUxoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591003; bh=VIlFVEsBGzw2HuHH61jd4ACK9u
    IF6TMn6dtZ3cfLiBk=; b=FhXlSAftzqq87KXkGrAwcBJ4GT1Ebsz3phnnnTUfxk
    S7jhkMPKTNRtKUpko+ZhclgpA8FS8la40qGzwsSHdQVyV550TJoGaPu07HxwLf/u
    JG82QBIEWclUAI1ED2e2+062Wf6xy/Q2wywgZ8aziSVCwzTiAcXwyBHr7bcDea7n
    dRQIUK7nvZ5x4HS2WG7VSItF/pDdTinzvaBtPSZLogPVKX0vbkMpNCJ2+RsJNcf+
    4pProUWRL1Kt+FYJMgo/XgrOaM4qq+yaqQURbb0OewEUPcbbgcx0TMlPeue0C5ke
    ahV2vZz0ZeCP7mARmeU2spGuos2YfuAwRaV7oyU7BoGA==
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
        id S1752684AbeBBRDU (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:03:20 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35630 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752802AbeBBRDI (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:03:08 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.9 06/86] gpio: Fix kernel stack leak to userspace
Date: Fri,  2 Feb 2018 17:57:26 +0100
Message-Id: <20180202140823.289348141@linuxfoundation.org>
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

From: Linus Walleij <linus.walleij@linaro.org>

commit 24bd3efc9d1efb5f756a7c6f807a36ddb6adc671 upstream.

The GPIO event descriptor was leaking kernel stack to
userspace because we don't zero the variable before
use. Ooops. Fix this.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Bartosz Golaszewski <brgl@bgdev.pl>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpiolib.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -705,6 +705,9 @@ static irqreturn_t lineevent_irq_thread(
 	struct gpioevent_data ge;
 	int ret, level;
 
+	/* Do not leak kernel stack to userspace */
+	memset(&ge, 0, sizeof(ge));
+
 	ge.timestamp = ktime_get_real_ns();
 	level = gpiod_get_value_cansleep(le->desc);
 
