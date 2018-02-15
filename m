Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1883814-1518710835-2-13802267834834986584
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
    t=1518710834; b=qmKMsaTU5xBpK6ZKVZ5eKbJxBAbLUpWnrfwhSf8n9u9alY9
    sN5MJ/8tvdxuNGWeAslkQ23ahRv122fPZB4OG+juGWIgGCQGG1VVVV/uR+j3UwK8
    rcdwi8wlkleDOtozxcanla+NliNxSqhGzea4T8Ek1Z5/9eVGqZOBcHeRVMib0Ol1
    YbEs2KEFRXjdY6SJenr+yFrjcP9zLTz44UlrAY+tl9YW3okLaLaUna/UzEnhFlt5
    Hqzpe7W8Kqv5q64x0EYur1Qj+QJShWKsHDCwHiahFJmYqco6CNWvoBLpAUvLKaVa
    UDSuteATYC4Gv3Uk7/g+1xym+uCHixefGGnuC3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518710834; bh=cAeWIass84dZ3GNW30bKJYwnIU
    nth1dWk3r2+XIDjyw=; b=AwIPzgA4sqJouYVHiOW03zudTvD5rshibI5T/iiNVV
    n0cgs4//VFTmdFfp+ktr/sM7cpNK+RdzXwC0LHkcckh+sr7tlNRQNelkgxIV4c+d
    cJa8AViN+/Y3Pt1VO0PyWJ7xbvoHiYhMQIaCZ7cB4iXbumUt8n3lBsCaypaDx3Pu
    NyVSAwg7OByDKNrubdyPPEuyVkg5GsdS2n+DR5fO27kli55xSVLt8ToxZRGFO7TI
    TUdV65kvWgM1L+4Jeg3OIHe0p0N4nH83bk4q+H8ZctgbC8In11SugEupsCJ3Mog/
    xJkyIbjs+LYt2SXYf/f26ApwWkScl3RAgYmpXprOi0mw==
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
        id S1423883AbeBOPpt (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:45:49 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35100 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424535AbeBOPps (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:45:48 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.15 156/202] fs/proc/kcore.c: use probe_kernel_read() instead of memcpy()
Date: Thu, 15 Feb 2018 16:17:36 +0100
Message-Id: <20180215151721.082195457@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiko Carstens <heiko.carstens@de.ibm.com>

commit d0290bc20d4739b7a900ae37eb5d4cc3be2b393f upstream.

Commit df04abfd181a ("fs/proc/kcore.c: Add bounce buffer for ktext
data") added a bounce buffer to avoid hardened usercopy checks.  Copying
to the bounce buffer was implemented with a simple memcpy() assuming
that it is always valid to read from kernel memory iff the
kern_addr_valid() check passed.

A simple, but pointless, test case like "dd if=/proc/kcore of=/dev/null"
now can easily crash the kernel, since the former execption handling on
invalid kernel addresses now doesn't work anymore.

Also adding a kern_addr_valid() implementation wouldn't help here.  Most
architectures simply return 1 here, while a couple implemented a page
table walk to figure out if something is mapped at the address in
question.

With DEBUG_PAGEALLOC active mappings are established and removed all the
time, so that relying on the result of kern_addr_valid() before
executing the memcpy() also doesn't work.

Therefore simply use probe_kernel_read() to copy to the bounce buffer.
This also allows to simplify read_kcore().

At least on s390 this fixes the observed crashes and doesn't introduce
warnings that were removed with df04abfd181a ("fs/proc/kcore.c: Add
bounce buffer for ktext data"), even though the generic
probe_kernel_read() implementation uses uaccess functions.

While looking into this I'm also wondering if kern_addr_valid() could be
completely removed...(?)

Link: http://lkml.kernel.org/r/20171202132739.99971-1-heiko.carstens@de.ibm.com
Fixes: df04abfd181a ("fs/proc/kcore.c: Add bounce buffer for ktext data")
Fixes: f5509cc18daa ("mm: Hardened usercopy")
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Acked-by: Kees Cook <keescook@chromium.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/proc/kcore.c |   18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -512,23 +512,15 @@ read_kcore(struct file *file, char __use
 				return -EFAULT;
 		} else {
 			if (kern_addr_valid(start)) {
-				unsigned long n;
-
 				/*
 				 * Using bounce buffer to bypass the
 				 * hardened user copy kernel text checks.
 				 */
-				memcpy(buf, (char *) start, tsz);
-				n = copy_to_user(buffer, buf, tsz);
-				/*
-				 * We cannot distinguish between fault on source
-				 * and fault on destination. When this happens
-				 * we clear too and hope it will trigger the
-				 * EFAULT again.
-				 */
-				if (n) { 
-					if (clear_user(buffer + tsz - n,
-								n))
+				if (probe_kernel_read(buf, (void *) start, tsz)) {
+					if (clear_user(buffer, tsz))
+						return -EFAULT;
+				} else {
+					if (copy_to_user(buffer, buf, tsz))
 						return -EFAULT;
 				}
 			} else {
