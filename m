Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1420212-1518184803-2-18351313826164672288
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
    t=1518184802; b=ClTW88VOIS1SjLGzowC9Xrzif1KRg9l7oMFYnYuV1z1cQPS
    TKVIPclAlqnXKnHtOg4qHUVikgJh2U3v1LjuwvFQX32icALloMDcuC9nyDwY2xo5
    AQaGF/ypizzSMd4t1GvKn+T65kN/cLUXJ2KkBcgwcB7ydl+u3TpJQ0aKu/uQLQ6I
    kDKLRXmtbEwMkXnbR1/NR2Q1x1AhEHKo8fZeZs6pYmY/MVJhpup02lXtp9AJSTwO
    38fiDMUJdFANzPNHXlRfoRObty+S4IaMX8Nxh0jrx2JW4UJlguN3zuoJvFZu7ofW
    D9RqHprkTBoH2f0Dotk3tCqD2MsAqUbZtLFR/Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184802; bh=v9rzUzpjy0DEcO1lU6jhY1+82f
    O0Bsp68eZX0UiYKDI=; b=a+W8/di3dc9P/YdJD/aNhGEZimwvTc9EmsZTqi0stl
    VYksrdhyIWarzP/LhvnDqbnD3irHDfEk8mot5/IUjMfQVNZUrEYN2hTzuuJvRsOt
    29tJEGOOGvd5czR+i888pP0KEo2ZzSCnUqlSBLpYEjqT/geadh9xk4DUdhM7L69k
    8o/I19k6SRAqjJwxRR4qpNoVg+iyyp5hun8DfgUJ4aCByK6T2kWA6tuyCG52ZF0S
    /m1vhvlKFw3vbO9LykaEVX3OoJp2PZ7ta45VCGtuofwoj40x6V8VmGyjkk9XDW7k
    htCxf8BXEMTyyE9ZP0S9RhBbOtrDEKCeDdP2FausZ6FA==
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
        id S1752532AbeBIN7p (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:59:45 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51352 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752995AbeBINoV (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:44:21 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Thomas Gleixner <tglx@linutronix.de>, ak@linux.intel.com,
        peterz@infradead.org, Tomohiro <misono.tomohiro@jp.fujitsu.com>,
        dave.hansen@intel.com, bp@alien8.de, arjan@linux.intel.com,
        dwmw@amazon.co.uk
Subject: [PATCH 4.9 52/92] x86/spectre: Check CONFIG_RETPOLINE in command line parser
Date: Fri,  9 Feb 2018 14:39:21 +0100
Message-Id: <20180209133934.972811022@linuxfoundation.org>
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

From: Dou Liyang <douly.fnst@cn.fujitsu.com>

(cherry picked from commit 9471eee9186a46893726e22ebb54cade3f9bc043)

The spectre_v2 option 'auto' does not check whether CONFIG_RETPOLINE is
enabled. As a consequence it fails to emit the appropriate warning and sets
feature flags which have no effect at all.

Add the missing IS_ENABLED() check.

Fixes: da285121560e ("x86/spectre: Add boot time option to select Spectre v2 mitigation")
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: ak@linux.intel.com
Cc: peterz@infradead.org
Cc: Tomohiro <misono.tomohiro@jp.fujitsu.com>
Cc: dave.hansen@intel.com
Cc: bp@alien8.de
Cc: arjan@linux.intel.com
Cc: dwmw@amazon.co.uk
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/f5892721-7528-3647-08fb-f8d10e65ad87@cn.fujitsu.com
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -212,10 +212,10 @@ static void __init spectre_v2_select_mit
 		return;
 
 	case SPECTRE_V2_CMD_FORCE:
-		/* FALLTRHU */
 	case SPECTRE_V2_CMD_AUTO:
-		goto retpoline_auto;
-
+		if (IS_ENABLED(CONFIG_RETPOLINE))
+			goto retpoline_auto;
+		break;
 	case SPECTRE_V2_CMD_RETPOLINE_AMD:
 		if (IS_ENABLED(CONFIG_RETPOLINE))
 			goto retpoline_amd;
