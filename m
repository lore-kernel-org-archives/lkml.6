Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519415189-2-15317164322717127044
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enfrca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415189; b=SjKZOVqHi5c9uzhT/TNev+QcAOx6jxMK7Uk8kPkc73b1UIR
    4vTFSALBtKT3wGtjdbroy2V86jgX4QUd+U3cabwvuO9etgcVJ314Ol1I49/IN9E+
    PL9KPgYzyVlYyaO07Vgot9cmhbDR+pSedextCA0QXdqVaGQ+oXXGXWD74BeIMG/u
    rOBRMdeNxlim7h+uukYQizi/tuclQdOest+FLLw9SQ8h2hxQuzckGa+Sj3hQ2/Bb
    RwyIu8U4wrN1ZM2fTFcrI3KtK8E/jmFTgs+4LlHOjFd3Qo2Nrv48PvzDy2AWnJww
    YGHJyO6dThjoAvil/aOuygmw3tJDlH5CGBdExnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415189; bh=oGvRl6Lfo6kFqm2EZCcaq1+hUK
    pmXdnrjv8ftQOabUU=; b=c3zWEenFjdPJx01rx3lBuRNAcXEGmffV2DoygX6YXo
    9HTtghoFr/XqM3MPNi4wE+l/pNX9gYW4HAOuOCGtNZUiQk/c+j+G4pgS4hpO1gk0
    elLqZbKiOc69V7Ih3DtYzoW3jPFZbsC29n5TaNt7LCOlEnI34gu46fSDvxJA2vF2
    MFUCykmEOwfUjGWi47Y/fjooaIRAW4HM4NQNgcy47QUSSIla8OMVWgCRbJk7xSal
    XBDoYeUZZdkKtetPUuBMPW/2wSIrgsLysP/4GxvPbMJoZEsBki4/+iy0L9oEEyCL
    TCGDic8yVZN9isDDLrjsuVQH8plMno5PDP7JXvhOpVFw==
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
        id S934266AbeBWSr5 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:47:57 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44678 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934258AbeBWSrv (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:47:51 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.9 087/145] powerpc/64s: Fix conversion of slb_miss_common to use RFI_TO_USER/KERNEL
Date: Fri, 23 Feb 2018 19:26:33 +0100
Message-Id: <20180223170735.992723075@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

The back port of commit c7305645eb0c ("powerpc/64s: Convert
slb_miss_common to use RFI_TO_USER/KERNEL") missed a hunk needed to
restore cr6.

Fixes: 48cc95d4e4d6 ("powerpc/64s: Convert slb_miss_common to use RFI_TO_USER/KERNEL")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/exceptions-64s.S |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -680,6 +680,7 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_R
 .machine	push
 .machine	"power4"
 	mtcrf	0x80,r9
+	mtcrf	0x02,r9		/* I/D indication is in cr6 */
 	mtcrf	0x01,r9		/* slb_allocate uses cr0 and cr7 */
 .machine	pop
 
