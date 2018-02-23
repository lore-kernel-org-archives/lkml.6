Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3841409-1519419065-2-18210800641800506041
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
    t=1519419065; b=CkN8SR7C+vy4sCq/b4maDjde2/l03ZSH3bESXVcIKgTDLud
    ftzE5NkT4zbHXfRt8ZPW4iLk+GJ8guFNgmhVhkF+FrfvEV9G1IKoq68SeQ94w8us
    mNCCaKqcb2WtYF3cWQd366G4bXhED6Nza50FJiJyBWOPAe+qdMyybLkg8sTesTj0
    3AQudogETimApaO223Xh3UES5emI0KY0HAnpwlrDa+mN9TeqxOZfsrIZ1tPaECEO
    GGFRCf8INbYLZI1+C33xLuiLJVeaOlK4xCDWgXICn7Pz0VySZXTEPZxE6awafW+F
    JkDg1FR4xCDw3h+b+prnPL0oYWZhtiMJQRObi4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519419065; bh=tL1Q6pDktVY3Wt6VvTiD12S/vD
    Aqcb5jqzXRxYLu9Dw=; b=RDTSw90REQGilYUgZd85UiqcnsJM5amrlFGGujZlLp
    VEWKflGLSJ24iEC39Bzmpscu4YpaQGbM0ueRGedJ7bOAXsVvsiHyZXG7rWO/FvRr
    Ze2B6w6yYP3huD/P+rjJahkaEPBfxpz6bJ2VG0/QEr2UxMDhSlXWI6hXzriU7LUz
    WKxi7mFWf8PLVEC9UOV+iuqdkbrlIO0/Khf3f2LlfJh2K/Z9F/h2ep61mRBlfbGP
    9wZn4PpR75C11fwDL6e9lAsoiTkj2Ej46giS+fUdYR+ZdRdQXJPqNuF7mvlm6TJ8
    2zgVCZLe5tIqux4cAU/HBC5MTFR94KYGvI2b5ZDEJSBg==
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
        id S1752451AbeBWSbF (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:31:05 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34768 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752422AbeBWSa7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:30:59 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 3.18 29/58] Provide a function to create a NUL-terminated string from unterminated data
Date: Fri, 23 Feb 2018 19:26:28 +0100
Message-Id: <20180223170211.457413857@linuxfoundation.org>
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

From: David Howells <dhowells@redhat.com>

commit f35157417215ec138c920320c746fdb3e04ef1d5 upstream.

Provide a function, kmemdup_nul(), that will create a NUL-terminated string
from an unterminated character array where the length is known in advance.

This is better than kstrndup() in situations where we already know the
string length as the strnlen() in kstrndup() is superfluous.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/string.h |    1 +
 mm/util.c              |   24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -121,6 +121,7 @@ void *memchr_inv(const void *s, int c, s
 extern char *kstrdup(const char *s, gfp_t gfp);
 extern char *kstrndup(const char *s, size_t len, gfp_t gfp);
 extern void *kmemdup(const void *src, size_t len, gfp_t gfp);
+extern char *kmemdup_nul(const char *s, size_t len, gfp_t gfp);
 
 extern char **argv_split(gfp_t gfp, const char *str, int *argcp);
 extern void argv_free(char **argv);
--- a/mm/util.c
+++ b/mm/util.c
@@ -42,6 +42,8 @@ EXPORT_SYMBOL(kstrdup);
  * @s: the string to duplicate
  * @max: read at most @max chars from @s
  * @gfp: the GFP mask used in the kmalloc() call when allocating memory
+ *
+ * Note: Use kmemdup_nul() instead if the size is known exactly.
  */
 char *kstrndup(const char *s, size_t max, gfp_t gfp)
 {
@@ -80,6 +82,28 @@ void *kmemdup(const void *src, size_t le
 EXPORT_SYMBOL(kmemdup);
 
 /**
+ * kmemdup_nul - Create a NUL-terminated string from unterminated data
+ * @s: The data to stringify
+ * @len: The size of the data
+ * @gfp: the GFP mask used in the kmalloc() call when allocating memory
+ */
+char *kmemdup_nul(const char *s, size_t len, gfp_t gfp)
+{
+	char *buf;
+
+	if (!s)
+		return NULL;
+
+	buf = kmalloc_track_caller(len + 1, gfp);
+	if (buf) {
+		memcpy(buf, s, len);
+		buf[len] = '\0';
+	}
+	return buf;
+}
+EXPORT_SYMBOL(kmemdup_nul);
+
+/**
  * memdup_user - duplicate memory region from user space
  *
  * @src: source address in user space
