Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1825685-1518708727-2-16755309478956456905
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
    t=1518708726; b=mQFdbJID6TG7rfYlnIIwFU8MYGV3apHKQScPyyXo9hMRCce
    AWyE7Ux+fOwCyHNY5sSTlftDBD8KShSRkyrYGIh91IMUfeRFJd3QV9dBx+qOitPW
    R3gnntEzHQVzx81g2JlKiGbNqq348r5Uun/zHc6jc+ggEe0CjyYSQ5aLZwDEOWVf
    DdLmgjnwfqhZ1n9p92UdKc/CbZPNskpf3o18E+uiOBVJ8TFwTZfDXb50HawsQZ4l
    qxXOPKdPAeU95cuLNfCUd0AbWwIaidkNfnMHhbJP3U6GbChy+gtF0krScjsf8aSZ
    T2NHSDZPinQCExpfnep85hUQyu8Ue0xpjkbVJSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518708726; bh=hlTcVeXmQnZQ4dSSyRKSvVwX7T
    fDkMkWx0GVwAl9YU0=; b=SBrnShKLyWAz+xivsWzPe4desEsPESt2I2UWb/3Kld
    iJtTGMOUsaR7UsS9t4jge0SPTCnnXftbUrrid6MwN+Kr9AsW/oIdUJD3OQfsXw0m
    YyFiryIAoxK9YdUsyWWHZ66XjHP/5VELTPrfGzc6/CNT72xjyPb2pSuVJMRQiS10
    2IovnARS2VSZzuZ9B7g9JFcyUeruy4oSw1KpgWuTj4/7hSljeAfT11gHR69awqug
    3cLQ47vQgc2/lMeJpD/h0jl04EgcjFt/x/ChF5efGFNb5aWx6DZk4Bpzt4AkJJY1
    HEnVSll81UsIzOGhxkl+2bckeY+8GrIDQgfvwGuwAZZg==
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
        id S1164537AbeBOPcE (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:32:04 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:56222 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164491AbeBOPcC (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:32:02 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 057/195] [Variant 1/Spectre-v1] arm64: Implement array_index_mask_nospec()
Date: Thu, 15 Feb 2018 16:15:48 +0100
Message-Id: <20180215151708.585544778@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robin Murphy <robin.murphy@arm.com>


Commit 022620eed3d0 upstream.

Provide an optimised, assembly implementation of array_index_mask_nospec()
for arm64 so that the compiler is not in a position to transform the code
in ways which affect its ability to inhibit speculation (e.g. by introducing
conditional branches).

This is similar to the sequence used by x86, modulo architectural differences
in the carry/borrow flags.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/barrier.h |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -40,6 +40,27 @@
 #define dma_rmb()	dmb(oshld)
 #define dma_wmb()	dmb(oshst)
 
+/*
+ * Generate a mask for array_index__nospec() that is ~0UL when 0 <= idx < sz
+ * and 0 otherwise.
+ */
+#define array_index_mask_nospec array_index_mask_nospec
+static inline unsigned long array_index_mask_nospec(unsigned long idx,
+						    unsigned long sz)
+{
+	unsigned long mask;
+
+	asm volatile(
+	"	cmp	%1, %2\n"
+	"	sbc	%0, xzr, xzr\n"
+	: "=r" (mask)
+	: "r" (idx), "Ir" (sz)
+	: "cc");
+
+	csdb();
+	return mask;
+}
+
 #define __smp_mb()	dmb(ish)
 #define __smp_rmb()	dmb(ishld)
 #define __smp_wmb()	dmb(ishst)
