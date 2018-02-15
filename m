Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1841884-1518709924-2-9247557757736922066
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
    t=1518709923; b=GmVLz+LJn0PO8EgG8E43PxgljT4LyNRrhInYumYkLpWYODK
    lXrLO40UW/zw4O4O0t8vNxjXtg+DXIe+sKnOl2IMPYbKCZTX7ATx1u7ZYjEz+Fpl
    uM7162dLNscbEiKaV4lPk74c0QNYNT/3k5smXDs6nwlJf6YIOvV64cdPTYxpKmBx
    G10zSTw/F7t9oxIDF0H+YQ5fIDeXrRjukZzv3B4s4wmWhH/2XLKLtbP1UhVo6cBO
    zZpw9KYCBimYMTbtj7W145/8h1dzHBQiIn8j0BuXDWez0172HnWOU5IWEfw22xYp
    dkn102CMKNMGZSLFFtTWJpYzhO4eFqkDiROMwdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518709923; bh=FndqYL9xI84qPPq1vdQ3JwHw0f
    Abvp5q+ytUUn376oc=; b=BvdcqH+dtKlXgVzBYPBFJzEQ7OkIGnNuG+S5WwJpSZ
    lKQ5zXp28aVKCNKGLHhAXQaPC3CxeDAxSgd9YBlbK02QMt4Mk2SsMe47HDAfk30I
    njqJt23jNVF6inue1QlJCfztvZ2KRAHEQX+ut2Ae8WWm3Xq9A1HZbS2Klm8DVvgw
    VjoTKZr3JDmCRhsuAQ40HFJzJ9GZnqMM+Agf09D5dMTp7GPyo0sjkkJkaEwMQ2R6
    IoatpnVxWNqpAHd/D7qeBFW+sdBTS9xalcTNVeDntomK9Ycj7Cl9RtnutikEQAi7
    81GeAbA6xlRDXvDDjLgviN6HFnFkbwLB+tti61kFWr7w==
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
        id S1424385AbeBOPro (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:47:44 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36316 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424947AbeBOPrm (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:47:42 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Masakazu Urade <urade.masakazu@jp.panasonic.com>,
        Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 4.15 197/202] mn10300/misalignment: Use SIGSEGV SEGV_MAPERR to report a failed user copy
Date: Thu, 15 Feb 2018 16:18:17 +0100
Message-Id: <20180215151722.967123072@linuxfoundation.org>
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

From: Eric W. Biederman <ebiederm@xmission.com>

commit 6ac1dc736b323011a55ecd1fc5897c24c4f77cbd upstream.

Setting si_code to 0 is the same a setting si_code to SI_USER which is definitely
not correct.  With si_code set to SI_USER si_pid and si_uid will be copied to
userspace instead of si_addr.  Which is very wrong.

So fix this by using a sensible si_code (SEGV_MAPERR) for this failure.

Fixes: b920de1b77b7 ("mn10300: add the MN10300/AM33 architecture to the kernel")
Cc: David Howells <dhowells@redhat.com>
Cc: Masakazu Urade <urade.masakazu@jp.panasonic.com>
Cc: Koichi Yasutake <yasutake.koichi@jp.panasonic.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mn10300/mm/misalignment.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mn10300/mm/misalignment.c
+++ b/arch/mn10300/mm/misalignment.c
@@ -437,7 +437,7 @@ transfer_failed:
 
 	info.si_signo	= SIGSEGV;
 	info.si_errno	= 0;
-	info.si_code	= 0;
+	info.si_code	= SEGV_MAPERR;
 	info.si_addr	= (void *) regs->pc;
 	force_sig_info(SIGSEGV, &info, current);
 	return;
