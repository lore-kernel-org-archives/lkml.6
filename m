Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2243538-1518720787-2-16510994158225710342
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
    t=1518720786; b=pa0rxrWDus2pF2PgB4bqTiWsr+ezgnMmYURkOCqIOvm7Bvq
    LwXV7y3OH17NumLTCv+9XHfTgsoONNtPv7Ys53rH6n7r6Ihkrfw37yfrNbnuiraC
    5mJ2nBJ9w1a3O4KjEwA9FzkYIwirFV5Z4owjRPDLysHWKdcDt6UD4zW5hLWanaK7
    GYEmRmXsNieQYZ2vNMMP0zdAz8KvHRaU4/3q3CcmpA6FGD8DRzc1quDGqv6avXGn
    gkQzdrtTviGZOsAoGjlomtwYD+tZcs1buvpVT6GcZ2fpkZrRPew2ASTYfT6tnrGx
    ZPDIYbt5WOjQHVDC/R8+j64EboNARDKzL7kak1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720786; bh=9pE+d0Skm1bZGkHE4iIygk7mQH
    rTIjQFBhwB27ORr34=; b=KgOFLYRmDbXWzFWtNwvZVmfHYtvWFKyAYECI1uVMv2
    5iNd27aQ3IZOulD/Y1lsRMwOH6ieAicDaRjRX/hTlslkVCrH2Zyy2mtO7A0FJQev
    9Qe1TohXN1uU80BAiS/gHqAlgfe8uXbVBsdjT2uUv6q4AcXP+dNIP0LCR7EUf01r
    UmJZtyv4DMPur4y8HCs5nZZMdpfqNQEI0uO8XIn799xAn7v3xbN7NKElbp05pdqO
    n41wbGf2mNEpnwXaUil9Wya9zw1YFuk3U2hI4K03zh9jEvTspNEz5RdSOTxikhtX
    GPiIvZTDXvGxHnLkSLyWQWq54dDsh79qZK12VQEWRWzg==
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
        id S1161985AbeBOPVL (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:21:11 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48536 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161956AbeBOPVK (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:21:10 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.4 010/108] powerpc/64s: Convert slb_miss_common to use RFI_TO_USER/KERNEL
Date: Thu, 15 Feb 2018 16:16:07 +0100
Message-Id: <20180215151223.813096591@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

commit c7305645eb0c1621351cfc104038831ae87c0053 upstream.

In the SLB miss handler we may be returning to user or kernel. We need
to add a check early on and save the result in the cr4 register, and
then we bifurcate the return path based on that.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
[mpe: Backport to 4.4 based on patch from Balbir]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/exceptions-64s.S |   22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1503,6 +1503,8 @@ slb_miss_realmode:
 
 	andi.	r10,r12,MSR_RI	/* check for unrecoverable exception */
 	beq-	2f
+	andi.	r10,r12,MSR_PR	/* check for user mode (PR != 0) */
+	bne	1f
 
 .machine	push
 .machine	"power4"
@@ -1516,7 +1518,23 @@ slb_miss_realmode:
 	ld	r11,PACA_EXSLB+EX_R11(r13)
 	ld	r12,PACA_EXSLB+EX_R12(r13)
 	ld	r13,PACA_EXSLB+EX_R13(r13)
-	rfid
+	RFI_TO_KERNEL
+	b	.	/* prevent speculative execution */
+
+1:
+.machine	push
+.machine	"power4"
+	mtcrf	0x80,r9
+	mtcrf	0x01,r9		/* slb_allocate uses cr0 and cr7 */
+.machine	pop
+
+	RESTORE_PPR_PACA(PACA_EXSLB, r9)
+	ld	r9,PACA_EXSLB+EX_R9(r13)
+	ld	r10,PACA_EXSLB+EX_R10(r13)
+	ld	r11,PACA_EXSLB+EX_R11(r13)
+	ld	r12,PACA_EXSLB+EX_R12(r13)
+	ld	r13,PACA_EXSLB+EX_R13(r13)
+	RFI_TO_USER
 	b	.	/* prevent speculative execution */
 
 2:	mfspr	r11,SPRN_SRR0
@@ -1525,7 +1543,7 @@ slb_miss_realmode:
 	mtspr	SPRN_SRR0,r10
 	ld	r10,PACAKMSR(r13)
 	mtspr	SPRN_SRR1,r10
-	rfid
+	RFI_TO_KERNEL
 	b	.
 
 unrecov_slb:
