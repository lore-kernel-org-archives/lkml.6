Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3709765-1519676991-2-5474632670002398745
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
    t=1519676991; b=DOGhwAzS2Cz2eBH7A9FGTuBBV5P9d0B2OPtoMCSE2mkJ34r
    AWT0F3tNouDNrs+8mIFRkILK+pFgdROtYHN77+XyHJDLVLQNTPkfeEkOP1rbDFsn
    kKI0NesUody5JwrdDpDfbhsiQJfZsBs3b7MFE8TzNQgFHoQmOjp4uCaYLaBI3sOu
    8HcjLfR0SnNC/imTMGHsDJ6Z5h4ntWgz5oMSfU/OmxUUAoZloxFoRCnlH/sO7AvR
    exJi1QlXnafEa8yZfvQWRP9Yja6sx0RKMa70ST/eGnPqhlXfctF6qyD7Gmk//uxM
    HBZE7t0Ul3CSf5HCVGiD37BHUORQcqUnIMNjLPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519676991; bh=OqmqrhGtFnOVC68tTKJEyoXvTy
    u7RmUhr2bJmvMEF1k=; b=D4eX97gM/hP7dLBWADpcNh5IRgDLQbSzwyd30kK1XE
    Fnmov/ZtAN/Xi+c6VgV3Mr5qlLgo+qiKoShyVvzEsWGeZ5YHZf9GPhILjXfwIQzM
    w43JyCntg+5gmDJ0gUr/Fdh0iD8YuRNX7cv7CznMPxERHi3e51G17nO5OJG6REpi
    /itkIMBnFGldX5lhJcGroQbemvAHqkTWBIeX6IxDCxZOQMw1FnQvFCIcrngT7Yy7
    T7wwWlQdzhUqjUH0RX2xS/kR8Xf4gKxqFYq7i8Nb5mfsl0HA4H35aRNajL5Y0vqW
    LR36XhXRcu/0tUcGzyid6pCtD2e3IbyYkEn5JUBvrIdg==
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
        id S1754101AbeBZU3a (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 15:29:30 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37588 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753646AbeBZU32 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 15:29:28 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NCSC Security <security@ncsc.gov.uk>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.15 63/64] arm64: __show_regs: Only resolve kernel symbols when running at EL1
Date: Mon, 26 Feb 2018 21:22:40 +0100
Message-Id: <20180226202156.142384432@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
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

From: Will Deacon <will.deacon@arm.com>

commit a06f818a70de21b4b3b4186816094208fc7accf9 upstream.

__show_regs pretty prints PC and LR by attempting to map them to kernel
function names to improve the utility of crash reports. Unfortunately,
this mapping is applied even when the pt_regs corresponds to user mode,
resulting in a KASLR oracle.

Avoid this issue by only looking up the function symbols when the register
state indicates that we're actually running at EL1.

Cc: <stable@vger.kernel.org>
Reported-by: NCSC Security <security@ncsc.gov.uk>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kernel/process.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -221,8 +221,15 @@ void __show_regs(struct pt_regs *regs)
 
 	show_regs_print_info(KERN_DEFAULT);
 	print_pstate(regs);
-	print_symbol("pc : %s\n", regs->pc);
-	print_symbol("lr : %s\n", lr);
+
+	if (!user_mode(regs)) {
+		print_symbol("pc : %s\n", regs->pc);
+		print_symbol("lr : %s\n", lr);
+	} else {
+		printk("pc : %016llx\n", regs->pc);
+		printk("lr : %016llx\n", lr);
+	}
+
 	printk("sp : %016llx\n", sp);
 
 	i = top_reg;
