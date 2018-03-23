Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182439-1521806098-3-5267072515209327432
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
    t=1521806098; b=g3T6CcZ2xzGJ7ejzZvOca3Jsnhq2+Om9a9q9JvA/8j2nYmd
    DOUvNKKf+IioI0zkKzKg9asPUgQRBSaRiBeenFotCD2F7AZ9VII5M8g6v7uT9pY+
    WGc/sgaMgNJlAUf0R+UhkK9D6MIm9uRs42mcgmEgJuWBgxx3gO2Bi6dX/+IAtomQ
    zv7zVQlF+vvkJpeG9GwRz8AOQYje7T7rLO2prckwIcffTK6uk7V5vifpMQtaIeB+
    EDNK8rNGEEbO25Q17wbwwVHHtsBoVTPJ4hVvkY6JTjmlfsFVaLbd4KraM88R32FG
    ZLfBpiJAL5IPnprA7NcCM/dft8zp45ivBQC7WIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806098; bh=IfE+8hQ2yer3s1DypasDxI+qMO
    gHv4JzSPkctgXe8YE=; b=OaRFGgRh3DA/lxLBurjrXg5Cb4AdWAm0pJCTT6q2RK
    88ySiIQUXzef70sBPQi3GQo6b26PttXm9Z9Yt1I31baFzVBwd3vRJHpLmy6Dik2v
    H1dADslGuzeozgp0vuptxWMKV7wqUOlWslxAWgYbFVQzVzt2yFOIVMHYmSLd+fPC
    exm/0wMysWoz5KhWd7jntT4BQRkFvZSF3SErkofLPk7qS4Qqm/Sbk+J8Sapsd2dv
    frD+62W4YgYSNIpWgrWQaMWJVNWUWvXEsKWUmInp8DKMNQpiJKbXLNj+5ERo5S6N
    0EX7IPdlG7YFeCYBswtnC8+IWM4gntbMQr/Dh222L46Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753166AbeCWKBU (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:01:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37750 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753865AbeCWKBT (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:01:19 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 29/77] /dev/mem: Add bounce buffer for copy-out
Date: Fri, 23 Mar 2018 10:54:03 +0100
Message-Id: <20180323094144.174719457@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
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

From: Kees Cook <keescook@chromium.org>


[ Upstream commit 22ec1a2aea73b9dfe340dff7945bd85af4cc6280 ]

As done for /proc/kcore in

  commit df04abfd181a ("fs/proc/kcore.c: Add bounce buffer for ktext data")

this adds a bounce buffer when reading memory via /dev/mem. This
is needed to allow kernel text memory to be read out when built with
CONFIG_HARDENED_USERCOPY (which refuses to read out kernel text) and
without CONFIG_STRICT_DEVMEM (which would have refused to read any RAM
contents at all).

Since this build configuration isn't common (most systems with
CONFIG_HARDENED_USERCOPY also have CONFIG_STRICT_DEVMEM), this also tries
to inform Kconfig about the recommended settings.

This patch is modified from Brad Spengler/PaX Team's changes to /dev/mem
code in the last public patch of grsecurity/PaX based on my understanding
of the code. Changes or omissions from the original code are mine and
don't reflect the original grsecurity/PaX code.

Reported-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Fixes: f5509cc18daa ("mm: Hardened usercopy")
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/mem.c |   27 ++++++++++++++++++++++-----
 security/Kconfig   |    1 +
 2 files changed, 23 insertions(+), 5 deletions(-)

--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -107,6 +107,8 @@ static ssize_t read_mem(struct file *fil
 	phys_addr_t p = *ppos;
 	ssize_t read, sz;
 	void *ptr;
+	char *bounce;
+	int err;
 
 	if (p != *ppos)
 		return 0;
@@ -129,15 +131,22 @@ static ssize_t read_mem(struct file *fil
 	}
 #endif
 
+	bounce = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!bounce)
+		return -ENOMEM;
+
 	while (count > 0) {
 		unsigned long remaining;
 		int allowed;
 
 		sz = size_inside_page(p, count);
 
+		err = -EPERM;
 		allowed = page_is_allowed(p >> PAGE_SHIFT);
 		if (!allowed)
-			return -EPERM;
+			goto failed;
+
+		err = -EFAULT;
 		if (allowed == 2) {
 			/* Show zeros for restricted memory. */
 			remaining = clear_user(buf, sz);
@@ -149,24 +158,32 @@ static ssize_t read_mem(struct file *fil
 			 */
 			ptr = xlate_dev_mem_ptr(p);
 			if (!ptr)
-				return -EFAULT;
-
-			remaining = copy_to_user(buf, ptr, sz);
+				goto failed;
 
+			err = probe_kernel_read(bounce, ptr, sz);
 			unxlate_dev_mem_ptr(p, ptr);
+			if (err)
+				goto failed;
+
+			remaining = copy_to_user(buf, bounce, sz);
 		}
 
 		if (remaining)
-			return -EFAULT;
+			goto failed;
 
 		buf += sz;
 		p += sz;
 		count -= sz;
 		read += sz;
 	}
+	kfree(bounce);
 
 	*ppos += read;
 	return read;
+
+failed:
+	kfree(bounce);
+	return err;
 }
 
 static ssize_t write_mem(struct file *file, const char __user *buf,
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -154,6 +154,7 @@ config HARDENED_USERCOPY
 	bool "Harden memory copies between kernel and userspace"
 	depends on HAVE_HARDENED_USERCOPY_ALLOCATOR
 	select BUG
+	imply STRICT_DEVMEM
 	help
 	  This option checks for obviously wrong memory regions when
 	  copying memory to/from the kernel (via copy_to_user() and
