Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3841409-1519419104-2-14113463152118709586
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
    t=1519419104; b=p/HYPE8UYkjXiL/9eUE8hrNuMe0hDCGdudbIoSydinHdr2v
    piEWq/GjhgLnyKvGIMLfR8gYs0dQBlo039mHfE0GL5GWLyfyJdJIsYjvqkpemvRX
    v2iPdrfzPLrTafToIIJvyw2mUzUeIjuHhtiDEkrjFHYSX7f9N9KGowUrIj9aNWoV
    l/5RsoXkEElbEO1OzUSfulkn5PDc5RgzXM804JK4hz9Ih9gAOZFhdkR/ILNYloja
    vsFJNRGAOdp47rGVQ9SYY3mSxhiwqoTCOsCOLc+2xVu8QuJCa0WJKVUvWmHHEcA/
    bnQwlUZH0AcxDZWYIVVnCA5ZxN8wyRXJurUomgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519419104; bh=17/Sat3vk5mIks/IrBf04OWW1p
    oahQsw1jwi/pYkwoY=; b=ZI6uZCt9ZHiKYC+IedKVobsWv0sNldjeE4k6TlEO01
    X3pzwROx+GSzSAfRRmrYd1eY6Ho+A/D2t6U9rO6k3LcC/kzp+d3Ar4AVF/mvzN7N
    RS/qYGGcU7RF9hDCy3rhxvmCwkEE4Vod3JiIdiVrYfM4ovS47GJ8eZZeuqHilP51
    HchtkD8QyjmppOQ8aFq/rMrAkch2DwsetoZ/MKBHs2iu1QVxpdNg0nMMZUVcdTqG
    m0faBnYt3mJ/exY/Bx66i5wsbyRMpMWjg7gtLJamXf7D+V8uvhYcuRd0ivjiEIJL
    nMcPJy42en4lC567HdlbUaw7LaQC7xS992DxUNFXq5cA==
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
        id S1752443AbeBWSbE (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:31:04 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34792 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752440AbeBWSbB (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:31:01 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        Paul Moore <paul@paul-moore.com>,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH 3.18 30/58] selinux: ensure the context is NUL terminated in security_context_to_sid_core()
Date: Fri, 23 Feb 2018 19:26:29 +0100
Message-Id: <20180223170211.579631841@linuxfoundation.org>
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

From: Paul Moore <paul@paul-moore.com>

commit ef28df55ac27e1e5cd122e19fa311d886d47a756 upstream.

The syzbot/syzkaller automated tests found a problem in
security_context_to_sid_core() during early boot (before we load the
SELinux policy) where we could potentially feed context strings without
NUL terminators into the strcmp() function.

We already guard against this during normal operation (after the SELinux
policy has been loaded) by making a copy of the context strings and
explicitly adding a NUL terminator to the end.  The patch extends this
protection to the early boot case (no loaded policy) by moving the context
copy earlier in security_context_to_sid_core().

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Reviewed-By: William Roberts <william.c.roberts@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/selinux/ss/services.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1239,27 +1239,25 @@ static int security_context_to_sid_core(
 	if (!scontext_len)
 		return -EINVAL;
 
+	/* Copy the string to allow changes and ensure a NUL terminator */
+	scontext2 = kmemdup_nul(scontext, scontext_len, gfp_flags);
+	if (!scontext2)
+		return -ENOMEM;
+
 	if (!ss_initialized) {
 		int i;
 
 		for (i = 1; i < SECINITSID_NUM; i++) {
-			if (!strcmp(initial_sid_to_string[i], scontext)) {
+			if (!strcmp(initial_sid_to_string[i], scontext2)) {
 				*sid = i;
-				return 0;
+				goto out;
 			}
 		}
 		*sid = SECINITSID_KERNEL;
-		return 0;
+		goto out;
 	}
 	*sid = SECSID_NULL;
 
-	/* Copy the string so that we can modify the copy as we parse it. */
-	scontext2 = kmalloc(scontext_len + 1, gfp_flags);
-	if (!scontext2)
-		return -ENOMEM;
-	memcpy(scontext2, scontext, scontext_len);
-	scontext2[scontext_len] = 0;
-
 	if (force) {
 		/* Save another copy for storing in uninterpreted form */
 		rc = -ENOMEM;
