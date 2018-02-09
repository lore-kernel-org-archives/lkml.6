Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1420212-1518184981-2-7247933622150702177
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
    t=1518184980; b=elNNqcHZDFinwNY33Eg5kVTc0GNQpWCC4Q9mMMVgvvCjgAV
    MIK7ESBZH1biyeZWPBoBcSHAeIc/hjNeDzWFYW+C7mJk+OF9ldcAyhJ6b3YHL5mT
    PqJBV6XcwGTB8AFcaYsK9CWa/8lfHdoFIf3TvzO3ozzMttBOpuotVAsFkKUfaASh
    VlT1wLt10BmGmogakhVHdyPAGqCs++X/S3Ri6RWJs5RVSechWtCAPzHvojpwFbku
    9nRNKkd/mtjSTq8UPGdkuPHukQFK1BXKCP80Y4vwjg6bUp6dLWCfTCxa/PRSzKFl
    vXJkYUWHOtAvhi3n8arGCJH+wf3mlmMWNSRfwSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184980; bh=f/v85SbPLypmrNgA6Rndb+qd27
    z6xDDl7YiikB+I78w=; b=Vvt6RnACPk4SoQHq4nCViEHhG0vFB8HxbXmoMVnocm
    fOTMnmjjNS+5DK95BFv+hRog90deRQ6OF2caLaT5fQCDzE4yGcVLUoLE1xDLriEx
    Yc/3uDXF7/ta2l/k1wo9goVj5dmzCfOBSnZYS7BuCMtBaf23IqQdJmCCAwVgNXCX
    kVGbK3G2lsxQjZfvA09ackLbUy0QzDre0zhKTmgYpQ5JZvVm0cKg7BCT5nbgsn7n
    CcNfBYpaPsCyA33Q7rJ3RC0cz9LdtlU/UgE1eR16PhZCUtFK8tIL+jHuAhWE7SO/
    ameJG5Qgw5JF1jX/5cZoKOM68fbbhYB/QarHMdqgWx+w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752908AbeBIOC6 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 09:02:58 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50924 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753234AbeBINnj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:43:39 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>, karahmed@amazon.de,
        peterz@infradead.org, bp@alien8.de
Subject: [PATCH 4.9 72/92] x86/retpoline: Avoid retpolines for built-in __init functions
Date: Fri,  9 Feb 2018 14:39:41 +0100
Message-Id: <20180209133936.436291131@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
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

From: David Woodhouse <dwmw@amazon.co.uk>


(cherry picked from commit 66f793099a636862a71c59d4a6ba91387b155e0c)

There's no point in building init code with retpolines, since it runs before
any potentially hostile userspace does. And before the retpoline is actually
ALTERNATIVEd into place, for much of it.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: karahmed@amazon.de
Cc: peterz@infradead.org
Cc: bp@alien8.de
Link: https://lkml.kernel.org/r/1517484441-1420-2-git-send-email-dwmw@amazon.co.uk
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/init.h |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -4,6 +4,13 @@
 #include <linux/compiler.h>
 #include <linux/types.h>
 
+/* Built-in __init functions needn't be compiled with retpoline */
+#if defined(RETPOLINE) && !defined(MODULE)
+#define __noretpoline __attribute__((indirect_branch("keep")))
+#else
+#define __noretpoline
+#endif
+
 /* These macros are used to mark some functions or 
  * initialized data (doesn't apply to uninitialized data)
  * as `initialization' functions. The kernel can take this
@@ -39,7 +46,7 @@
 
 /* These are for everybody (although not all archs will actually
    discard it in modules) */
-#define __init		__section(.init.text) __cold notrace __latent_entropy
+#define __init		__section(.init.text) __cold notrace __latent_entropy __noretpoline
 #define __initdata	__section(.init.data)
 #define __initconst	__section(.init.rodata)
 #define __exitdata	__section(.exit.data)
