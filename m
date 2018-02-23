Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3559911-1519410783-2-5939744013670916751
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
    t=1519410782; b=PUPInoOC8eG7RrCqHEmaYJ2UT8UvnFXNhESXhuYp8jLYw4g
    sSdcoqbEbh/RHXRuMcuwoUn+P4gXN3NkwPCgSfOU6L3MzCCKA8OHciNT9cjfTW3k
    KzkGWEADi/CgH7I6KjeBL3epJIu5URtJRwk+0+A4KfP87vhkbSg2evIv0uscIron
    ZA0Yye/YOBCxXeITk5Tpn1Xt74ptW4MfssjJ0iQKcFD8P6HmxLxOKmEMtdVZAiQD
    Hsib2rSqoS3KqEO28LedifG5piJgLFdBKd5l0QtwV74rjA22AeSKcZhorVcn6jgF
    WedJEUutFnzx1osq4o4U8mWVBnwY8/EZJ0/Yp3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519410782; bh=uEC1aAiO2XcYTqD5/1x+YPd6NA
    T5hTIZ+TJy9uLvqC4=; b=LKS+ZlEfLuW6bVUwWAfYl2bNvTJzfjsQjdP9KyWOTD
    2L4DC3yLDH8EEUYk3YNOISswXRWPKrmp9i+7lZ6y0KwTufaLDkVeFtcePfQd7wUr
    Z41t+IzqULixr1KpFK8g0Y5AWwStL9DpkaS4VVHiGFwZp4iBD7mX2+6N1D7uL8OM
    PADrZv0tHnhv+f2HZiTb90QfGWsOdnCvGjCeIQ2d/GxO7fScaV6p4dzN2DwLREpo
    pDI0/SVy8OI4WQkUHmES/uakNQEqNicZPebO67lXgxCRirlLrgFYYHaYh8u9QQ+3
    eVgGU60lesuNEQ5Zyl96O5CVJg22dXZYPcJ6NdIH7SYA==
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
        id S1753038AbeBWSc6 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:32:58 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36368 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbeBWSc4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:32:56 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller-bugs@googlegroups.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        James Morris <james.l.morris@oracle.com>
Subject: [PATCH 4.4 011/193] selinux: skip bounded transition processing if the policy isnt loaded
Date: Fri, 23 Feb 2018 19:24:04 +0100
Message-Id: <20180223170327.926341341@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Moore <paul@paul-moore.com>

commit 4b14752ec4e0d87126e636384cf37c8dd9df157c upstream.

We can't do anything reasonable in security_bounded_transition() if we
don't have a policy loaded, and in fact we could run into problems
with some of the code inside expecting a policy.  Fix these problems
like we do many others in security/selinux/ss/services.c by checking
to see if the policy is loaded (ss_initialized) and returning quickly
if it isn't.

Reported-by: syzbot <syzkaller-bugs@googlegroups.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Reviewed-by: James Morris <james.l.morris@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/selinux/ss/services.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -860,6 +860,9 @@ int security_bounded_transition(u32 old_
 	int index;
 	int rc;
 
+	if (!ss_initialized)
+		return 0;
+
 	read_lock(&policy_rwlock);
 
 	rc = -EINVAL;
