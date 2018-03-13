Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3463848-1520955790-2-13396242381868620624
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
    t=1520955789; b=XSPpbUNMyV99mS441hQZQQMnDNOOHfoduvWlJF5SNUWuj7r
    XW1G8SeL/PMf/HJXQ9AslH7kLvbD5V2R8trSfpSo53Sm3pxvQYCsQDnXqs6OISx/
    D5IMP1miMudYVH4HXbgqB1Y8NLaKB6CnlshpVgBOeNZ8MPPuuayX12iEno00+SaR
    Su2y4/kqZOpQyAsE8XQh11LFMjqFNS37FkpWsBZuQPe14fZnJOkzuCjW8prJxzz2
    k6+US1mcGk6rbR8HTRyLPd/LBr3m8GPqR9/zjAZZufjQi9vsOc6Fui9OjXMcFizv
    bGVrLHRzoMynRvN49bIWsDjUi3LqqqWyfqshKfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520955789; bh=fa2ujxQgZjjzJQIDpp5JvocgQq
    xCOyiJLRrEVpiGB0w=; b=jeIMBjxqOG+9OEvXziPmbYaNUvVDWvAYS8gUGtu7B+
    XdhFS6piS9kFfIXS0jbHw4nhWBjVGb+9h+R8F+dPSPbnCH3tni56VQcDyJXJavfH
    erHuGjBgmEQrixvkY/bfvHAXkL1wJS636J5h1oY8vdyfCE1Nzvmv9Ta5OYSg7MtJ
    wDhMyMteZxEjTgrcN3BWowRfasgqiV7bmwcODliFQRgSfZvK/dJ27R5Gqr33fBe5
    O99DSZgXp2k020pUXXxVsIgUh1x4XNwFEb3iAsFHDhzSPf6Uy6unGjGAnIl8NjAA
    xbhi3N+nyOUmamzzAExMOUY4plNgjAX2Rpqhr3FRI+WA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
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
        id S933276AbeCMPnH (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 11:43:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37084 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934720AbeCMPlm (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 11:41:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 4.14 138/140] objtool: Fix another switch table detection issue
Date: Tue, 13 Mar 2018 16:25:41 +0100
Message-Id: <20180313152507.445017149@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
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

From: Josh Poimboeuf <jpoimboe@redhat.com>

commit 1402fd8ed7e5bda1b3e7613b70780b0db392d1e6 upstream.

Continue the switch table detection whack-a-mole.  Add a check to
distinguish KASAN data reads from switch data reads.  The switch jump
tables in .rodata have relocations associated with them.

This fixes the following warning:

  crypto/asymmetric_keys/x509_cert_parser.o: warning: objtool: x509_note_pkey_algo()+0xa4: sibling call from callable instruction with modified stack frame

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/d7c8853022ad47d158cb81e953a40469fc08a95e.1519784382.git.jpoimboe@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/objtool/check.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -924,7 +924,11 @@ static struct rela *find_switch_table(st
 		if (find_symbol_containing(file->rodata, text_rela->addend))
 			continue;
 
-		return find_rela_by_dest(file->rodata, text_rela->addend);
+		rodata_rela = find_rela_by_dest(file->rodata, text_rela->addend);
+		if (!rodata_rela)
+			continue;
+
+		return rodata_rela;
 	}
 
 	return NULL;
