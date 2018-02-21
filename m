Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1568560-1519219050-2-8676520350304888483
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES endasv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519219050; b=homA2WaYxlNMxJGlPPbTb56nTK9qLZfVKsN77jS+7rNWc1e
    77lw+8VzIf50vbpcmOPnmRDcxUegkHkxk4izGnAJFA1++RLNA1WX6miVuWdwxQAy
    8d06DbOGk77YZbi4VACFFzm6o6zcOB8KCc1Gys8pg0OMY4MyDW9QFdxDNhxbexP8
    kStz07wzaeV/i8DaCUlGuPB/KOru4CCmnBFvi4liVDrMKKaktXnhcqXUrvgeFBDC
    W/6+pmQDd8RybJTex/H5svb2pq4NokuhXhJM2FCWg9XEUyffa1Cj+Lwwstxzj2fl
    v5jt21rsNAhGkHKJAk8O/FF+O8voSIM4AKce0Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519219050; bh=agjgDCXpMnRsakLvdgQNCu4eyO
    5diyDb6fNkfKvKbdg=; b=nwJyD2HeDEImEGqswzyhWIZbYLKyaVlzRfLgU4ZFop
    BdKNqHbvC56I6JM+hgGWSftvv6V7j+rtioSqC3E0DbslGU2y7v/Y8dMXWCpC1ldu
    9C9ZdUhBQ5avIOZOyquCm8+9HVSBHEhMG2H/jG1IIExzSbGpz6K9vda2i3eci2jM
    WcziJ5yMMsirfdGbtcBKkba1qYd2xUgRDS+jvgqsR6jgWveKIhj5C4XEeiMEXOzk
    ZoZsdfnP8ZdnuxUkajuyvI6ZSjyeJRWKXSe1lab2iXAaPC0UThRAg/y3eG1vWLUX
    zItzhrneiq6YP2zN58wKY3tjyGWjaSTivvHwOPkop8Kg==
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
        id S1752450AbeBUNM6 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:12:58 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45884 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965623AbeBUNM4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 08:12:56 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Markus Elfring <elfring@users.sourceforge.net>,
        David Disseldorp <ddiss@suse.de>,
        Nicholas Bellinger <nab@linux-iscsi.org>
Subject: [PATCH 4.15 132/163] target/iscsi: avoid NULL dereference in CHAP auth error path
Date: Wed, 21 Feb 2018 13:49:21 +0100
Message-Id: <20180221124537.467213921@linuxfoundation.org>
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

From: David Disseldorp <ddiss@suse.de>

commit ce512d79d0466a604793addb6b769d12ee326822 upstream.

If chap_server_compute_md5() fails early, e.g. via CHAP_N mismatch, then
crypto_free_shash() is called with a NULL pointer which gets
dereferenced in crypto_shash_tfm().

Fixes: 69110e3cedbb ("iscsi-target: Use shash and ahash")
Suggested-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: David Disseldorp <ddiss@suse.de>
Cc: stable@vger.kernel.org # 4.6+
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/target/iscsi/iscsi_target_auth.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/target/iscsi/iscsi_target_auth.c
+++ b/drivers/target/iscsi/iscsi_target_auth.c
@@ -421,7 +421,8 @@ static int chap_server_compute_md5(
 	auth_ret = 0;
 out:
 	kzfree(desc);
-	crypto_free_shash(tfm);
+	if (tfm)
+		crypto_free_shash(tfm);
 	kfree(challenge);
 	kfree(challenge_binhex);
 	return auth_ret;
