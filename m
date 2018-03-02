Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1415877-1519989735-2-4037561886050984158
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519989734; b=Yo5ZPw+SyX21/BN87UFnZDPdkjVokgvUBFCGZPaWQ+0fwrG
    TdfqUU8beI/Rxt0NzJTvWvcDBrVVrwrNUxinbY9AmkHS/puJFtdpU0DP37GVrW3M
    rJ8bJfB7lLFWq9i8XixqSbx3DLT6C8TE40AWL3ggvU5uKdk2Sg53rgJCyBiFZOHu
    ejCQWp+IMTAjeUOVVaD12P4D1XoCjFVUADMJkduwrbYNq+2outvWVa5HxiT/Zr5n
    7XsJfrbvS6QI1JyR57U5CnFscnQORipuD67KWxl/RjeRANPbS8QO/Ztobw/gisJZ
    xrbvXRA/EXst5Ua2dnJdD2wod5ALlctp9BgZhlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519989734; bh=X5PsSQzaZYL38y4fOvr0feH1z1
    QFAwu37uJcZbIqj10=; b=mIIQsglKkW3BOOwmq7JTUhP3SR4ZgkUSM6JVtH3HN3
    vrN5HE7uikYKh+ZAJezGnXzcN7cm5O3QKujNvm1CjQjCOLpfJjbmPbbTPH01tIac
    VKNHFBAJjUvp9J9LPFFPMpxQvu81yiyiCZ/5aPnFkQlvFLNxz1Yt1+VnTfjOwn5n
    HJ8jl/latNPvZ/3Q1iUn9GORolFQQspvbEeJqsl7IKEYvI7kAdglBid2w9AxS5Xa
    TIP6BfP+vhDvl24uYls5yVgpfkFGLWUM1JNfQuZDnT1QfiWc8Q6ubL/TZ8V32cRf
    GiTpx6IosNnxs/vBDvNT9a9nMhkkevZ9Kfkl4JYnFb6w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165056AbeCBIvm (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 03:51:42 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49050 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1165086AbeCBIvl (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 03:51:41 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: [PATCH 3.18 12/24] led: core: Fix brightness setting when setting delay_off=0
Date: Fri,  2 Mar 2018 09:51:09 +0100
Message-Id: <20180302084239.760670896@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084239.157503766@linuxfoundation.org>
References: <20180302084239.157503766@linuxfoundation.org>
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

From: Matthieu CASTET <matthieu.castet@parrot.com>


[ Upstream commit 2b83ff96f51d0b039c4561b9f95c824d7bddb85c ]

With the current code, the following sequence won't work :
echo timer > trigger

echo 0 >  delay_off
* at this point we call
** led_delay_off_store
** led_blink_set
---
 drivers/leds/led-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/leds/led-core.c
+++ b/drivers/leds/led-core.c
@@ -76,7 +76,7 @@ void led_blink_set(struct led_classdev *
 		   unsigned long *delay_on,
 		   unsigned long *delay_off)
 {
-	del_timer_sync(&led_cdev->blink_timer);
+	led_stop_software_blink(led_cdev);
 
 	led_cdev->flags &= ~LED_BLINK_ONESHOT;
 	led_cdev->flags &= ~LED_BLINK_ONESHOT_STOP;
