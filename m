Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3684173-1519414184-2-2701408981215574080
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
    t=1519414183; b=iWvyzuDcSc5I0ZWDEMrk5VVLLaf+YIqzoN2R8tWuSsp1rJm
    A9gLhlHH19h/5OktM4Y/ZD4shSdg5lCw9GzXE6+8Q2NYNJqYROvbqZCfcH1dZ0aZ
    jxFVnM2zKxCvS8uKcmsCH77Zcne6+3bd1f0zyxE7f2cb3d/G2NVqHSCRKJoPQbHb
    Po2L0V9Xd9fysg4wvo6MFzweem1OviU1+7fcp7nDMf/UBT4XTjqaokpFJPms53XM
    Uz6TaUjSgA50LEyq5igYbhW6laFQqb8P3CRX00bj6HtT5NBLtRq/hniB5M9VIpDM
    XLmCdgCJoo4+F1bUaPQU8eLe32ohdRbWCy7mSHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414183; bh=2t7JfaRyLIPsSNC/K9HGlJ16Et
    1MoPbTscIobLIfzz0=; b=bP+JenokArN+B8Eaqi2iCFfEYGTL40pFjO2klIk5hD
    cdzRMzvrxSI67BccuweZqGEqBbjxjyP3YtNf4N6UVLufKIstgCuUvXuJx4Mkmglb
    LxRwSLgotcb+mT7vtZiEIv8CecIaFr34dqF/GGcGD+TaK5/J2deJuYA47e/qCpGY
    CVmeVvgVGJA5uBG09xDP+rWc8lDRz86LU//ZY7jDT4M72pNaXNvEwYrxSLYa57n6
    hjOTzXArUmhG6CQ15wpz2pmKMMZ3zLwC6yhF6u/wFrvihAv/wFQKp7BVrIc18VGs
    uhv0y1y3kQ344/dasx/UT/fLQwTA2RGHhnp0lVBasOWQ==
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
        id S935043AbeBWSv5 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:51:57 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46252 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934465AbeBWSvz (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:51:55 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 060/159] serdev: fix receive_buf return value when no callback
Date: Fri, 23 Feb 2018 19:26:08 +0100
Message-Id: <20180223170750.850913741@linuxfoundation.org>
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

From: Johan Hovold <johan@kernel.org>


[ Upstream commit fd00cf81a9a84776ba58e56bd042c726dcf75cf3 ]

The receive_buf callback is supposed to return the number of bytes
processed and should specifically not return a negative errno.

Due to missing sanity checks in the serdev tty-port controller, a driver
not providing a receive_buf callback could cause the flush_to_ldisc()
worker to spin in a tight loop when the tty buffer pointers are
incremented with -EINVAL (-22).

The missing sanity checks have now been added to the tty-port
controller, but let's fix up the serdev-controller helper as well.

Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/serdev.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -184,7 +184,7 @@ static inline int serdev_controller_rece
 	struct serdev_device *serdev = ctrl->serdev;
 
 	if (!serdev || !serdev->ops->receive_buf)
-		return -EINVAL;
+		return 0;
 
 	return serdev->ops->receive_buf(serdev, data, count);
 }
