Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3586829-1519410736-2-15101977392542827802
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
    t=1519410735; b=Ps1NNS1U1tJxg7Sj99rKofmztb0K+jxrhXBWGv6XtIasOej
    bWv1dKp8Ga7XbcEtsbhchipT8DE4vJHz6H61R55zchSgljM/LxEHlGxVfKRjUgWz
    yI3Q4U50+qWH0mjSftmuhzI11ZGeJnn+ThpQDEoesoroao+J7sOsHG95XamT7vV1
    WcVqi4/PpNZ3svbvfkNvpj9wpAQdWh1N1EWwcUCCW9SSfytVawyB8UV8yOOc/35j
    UuVKe65KDD2AeAz96gDTHDCRoEXoIur2p1gdHQQ9iV2nvzSkJxlfUIKe7ByGIjY7
    fq8GZ2IW2f0Qr0M6xA1qMdb/5apnTIafuKhI0Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519410735; bh=LHtES75ODUMuWQp0zPTGSrNCiY
    Ex5/ErfkPcd0Ao0Wg=; b=qP/4BnOic3S8T8W64rDuF+i80gd71lgiXtIjqQRXkx
    6iccPVqwgW/oTHtS31ova6Jo50/REqLmU7bZWqhaafSHVmlH+jc637OA/9luGF9I
    reQPfMvKwsDL5cYzGJgoRa5KOgT2L6Tm+giI+ZhGvNoFFcj9yEJRWf3gTJmzMe15
    gj12HXNcHQJFR0+Ws0nVYU+PHJONE98lmgVJuLV78UXfGFwzQz0KTZ90J7urIhco
    qzRPyzQ0cD4AhK/iA/NePbo8bBUPfOkYInpFRJpBQOrMC9kv2HoIMrFEox+j38Th
    eKCk/V05cltXjWfyyeiwaUCCxAIWiwGnxZdWvJUNJ14g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752766AbeBWScM (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:32:12 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35904 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752716AbeBWScI (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:32:08 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, bp@suse.de,
        linux-efi@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 53/58] mm/early_ioremap: Fix boot hang with earlyprintk=efi,keep
Date: Fri, 23 Feb 2018 19:26:52 +0100
Message-Id: <20180223170215.061838996@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170206.724655284@linuxfoundation.org>
References: <20180223170206.724655284@linuxfoundation.org>
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

From: Dave Young <dyoung@redhat.com>


[ Upstream commit 7f6f60a1ba52538c16f26930bfbcfe193d9d746a ]

earlyprintk=efi,keep does not work any more with a warning
in mm/early_ioremap.c: WARN_ON(system_state != SYSTEM_BOOTING):
Boot just hangs because of the earlyprintk within the earlyprintk
implementation code itself.

This is caused by a new introduced middle state in:

  69a78ff226fe ("init: Introduce SYSTEM_SCHEDULING state")

early_ioremap() is fine in both SYSTEM_BOOTING and SYSTEM_SCHEDULING
states, original condition should be updated accordingly.

Signed-off-by: Dave Young <dyoung@redhat.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: bp@suse.de
Cc: linux-efi@vger.kernel.org
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20171209041610.GA3249@dhcp-128-65.nay.redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/early_ioremap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/early_ioremap.c
+++ b/mm/early_ioremap.c
@@ -102,7 +102,7 @@ __early_ioremap(resource_size_t phys_add
 	enum fixed_addresses idx;
 	int i, slot;
 
-	WARN_ON(system_state != SYSTEM_BOOTING);
+	WARN_ON(system_state >= SYSTEM_RUNNING);
 
 	slot = -1;
 	for (i = 0; i < FIX_BTMAPS_SLOTS; i++) {
