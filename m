Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1546708-1519219016-2-5057783847054014239
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519219016; b=vq+R3yizORt2xJWYcreItTetq+RS7AKCxA35IPyrvmc6ueX
    QY6jnqdbI1yd3ozLNaNJFHq+75vwW5h7gNhRV+/IIGIKtkse62vyTaEXbFaDKv/h
    s7H+O8rPdvNvPDPQRLY6CfAIbbj4kesuDX19P8QCq/Hw+QMLGW3D/omfP5J1fUtK
    /HXvOyalNz5/LYHxDYzxd6sKmTTEyR0lBOZfFkUC71lo/2RzWLnwtEi8oRJAnqX3
    ItMIUJhAgVa+Ekr9nf0TXImlBAck+Q5prSn+k1t0rtcYIBexFU+BrRYNmiabBPFX
    xjbpSfflb0F8AfNLhycqNijFDJpHQQcpZt40dWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519219016; bh=QpGVvy5rFtpt1I3EghmBCd4MZ8
    W3VYp5IuJnc9OdUU0=; b=titlttbacEBbUlNqFjeCSmBG8ZrpLZBcVTjVdcDDZw
    Sqx0B/Iu7Dx9/KwQ+kjqdopk6cym9QPCPYd+g1BKpuQbivdEhNhNtt6E0tqFqftM
    q/J9qHseCjZO9dMxuHkI5GPGWmcfUB5Jq7e6137UC2FBjqQnDzY29IjzC8cZpijZ
    PVrJ3YDZDv1hUxfjd3026hwqRP/kYbZwwrkiiaAmRLIBmI1NhirUIZg9Q0IfLrMK
    GMVPKLOK+/+BdNoNWb3b/dqVsXsMPRO6xiKVueTl4OwaZ5aspUvCXhqpQB9GoV/Y
    9jtxFP75d0+faoT9mS+jqXCMrE6HOjMP5JspO91S3hyw==
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
        id S1754531AbeBUNNH (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:13:07 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45914 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753150AbeBUNNE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 08:13:04 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.15 161/163] media: r820t: fix r820t_write_reg for KASAN
Date: Wed, 21 Feb 2018 13:49:50 +0100
Message-Id: <20180221124538.808129304@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 16c3ada89cff9a8c2a0eea34ffa1aa20af3f6008 upstream.

With CONFIG_KASAN, we get an overly long stack frame due to inlining
the register access functions:

drivers/media/tuners/r820t.c: In function 'generic_set_freq.isra.7':
drivers/media/tuners/r820t.c:1334:1: error: the frame size of 2880 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]

This is caused by a gcc bug that has now been fixed in gcc-8.
To work around the problem, we can pass the register data
through a local variable that older gcc versions can optimize
out as well.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/tuners/r820t.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/drivers/media/tuners/r820t.c
+++ b/drivers/media/tuners/r820t.c
@@ -396,9 +396,11 @@ static int r820t_write(struct r820t_priv
 	return 0;
 }
 
-static int r820t_write_reg(struct r820t_priv *priv, u8 reg, u8 val)
+static inline int r820t_write_reg(struct r820t_priv *priv, u8 reg, u8 val)
 {
-	return r820t_write(priv, reg, &val, 1);
+	u8 tmp = val; /* work around GCC PR81715 with asan-stack=1 */
+
+	return r820t_write(priv, reg, &tmp, 1);
 }
 
 static int r820t_read_cache_reg(struct r820t_priv *priv, int reg)
@@ -411,17 +413,18 @@ static int r820t_read_cache_reg(struct r
 		return -EINVAL;
 }
 
-static int r820t_write_reg_mask(struct r820t_priv *priv, u8 reg, u8 val,
+static inline int r820t_write_reg_mask(struct r820t_priv *priv, u8 reg, u8 val,
 				u8 bit_mask)
 {
+	u8 tmp = val;
 	int rc = r820t_read_cache_reg(priv, reg);
 
 	if (rc < 0)
 		return rc;
 
-	val = (rc & ~bit_mask) | (val & bit_mask);
+	tmp = (rc & ~bit_mask) | (tmp & bit_mask);
 
-	return r820t_write(priv, reg, &val, 1);
+	return r820t_write(priv, reg, &tmp, 1);
 }
 
 static int r820t_read(struct r820t_priv *priv, u8 reg, u8 *val, int len)
