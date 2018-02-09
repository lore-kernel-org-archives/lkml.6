Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1465196-1518185167-2-8614893876875319228
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
    t=1518185166; b=dET4WfR3FTQVTez8dR8qHDPBpXQY4JQvS08t6vjEj7PyZTm
    +M0knaaNirKuY0gCtSrC//7yP5Gl8MLRSW3Y2wmcNZbQkZT0pWd/BX8pSglU9XE6
    KFDN2jcINt14BJvg60QoLflnzs733CKeDmPWVKCaP1qmINedX1jVKJjI9/fq0Qyd
    X1nbmusfrJunUMGYo05NBdn5Q3SCC5ouL1aJI0zFymXMm7ISTvGG6gMbtQeXk1Ec
    38HFG3Fb0n+JvJyrOiztCcG6owUQjAHa3qRmLWs9gi+iL01Gix3jUtsPe1mJrzZF
    BJURX16qbfBiCysT9eFvTN241CgkOKiybdyjjGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518185166; bh=gZA3dbX0ns+XMEksinixFSeb+S
    /ySMIAUmqnKkLqXNM=; b=LCgYF/oqgVIGkrKieQ5Ni6YdUdh82+EtmaNSTMLOYQ
    XB6KBN9GDGEu8BoCuWxDVh7aptgox6d98xN4yFikuO0fZXgHBJDX5qrJX4NTWWpk
    CCfUAgUyYJR7PV5c4gfgzsS1dPqccsyxEXiC8dIXXy7HOMr9MEyfqe4a2RLCUA5s
    XzmALHTHZ+3Qpo6dicaF+1uh0V3P5NQNlCeUBp09EFiNXbyZlm8DU+TywC6RS0pR
    VBmu4/t6IpNlOsElRJ1xlSwkC3t8ZiY6yLpnxyo4jw3ujzIihOXNCcYIb7h0wnM6
    wT4rGqrOLrM6qvkRj1S4xddiod9RzZo7TL5vcuox/R9g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751145AbeBINm4 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:42:56 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50070 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753109AbeBINmy (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:42:54 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arch@vger.kernel.org, kernel-hardening@lists.openwall.com,
        alan@linux.intel.com, David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 58/92] x86: Implement array_index_mask_nospec
Date: Fri,  9 Feb 2018 14:39:27 +0100
Message-Id: <20180209133935.416247744@linuxfoundation.org>
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

From: Dan Williams <dan.j.williams@intel.com>


(cherry picked from commit babdde2698d482b6c0de1eab4f697cf5856c5859)

array_index_nospec() uses a mask to sanitize user controllable array
indexes, i.e. generate a 0 mask if 'index' >= 'size', and a ~0 mask
otherwise. While the default array_index_mask_nospec() handles the
carry-bit from the (index - size) result in software.

The x86 array_index_mask_nospec() does the same, but the carry-bit is
handled in the processor CF flag without conditional instructions in the
control flow.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org
Cc: alan@linux.intel.com
Link: https://lkml.kernel.org/r/151727414808.33451.1873237130672785331.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/barrier.h |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -23,6 +23,30 @@
 #define wmb()	asm volatile("sfence" ::: "memory")
 #endif
 
+/**
+ * array_index_mask_nospec() - generate a mask that is ~0UL when the
+ * 	bounds check succeeds and 0 otherwise
+ * @index: array element index
+ * @size: number of elements in array
+ *
+ * Returns:
+ *     0 - (index < size)
+ */
+static inline unsigned long array_index_mask_nospec(unsigned long index,
+		unsigned long size)
+{
+	unsigned long mask;
+
+	asm ("cmp %1,%2; sbb %0,%0;"
+			:"=r" (mask)
+			:"r"(size),"r" (index)
+			:"cc");
+	return mask;
+}
+
+/* Override the default implementation from linux/nospec.h. */
+#define array_index_mask_nospec array_index_mask_nospec
+
 #ifdef CONFIG_X86_PPRO_FENCE
 #define dma_rmb()	rmb()
 #else
