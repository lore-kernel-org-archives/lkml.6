Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1521561-1519217830-2-838655259366440222
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
    t=1519217829; b=HOXlzMSSMYixd04H7IvpjIgePd5FPwcLTrzMid4pv5+qmUc
    pu3YuzzPQ/rXNp9yVGgV3XFogBkm9fotCjPii5xSOtv9YT4VvF5XUBcZjGwUlq9q
    FUiohxiXYiv4l9+3vC71nL12Ia9qc/LPz/hB/KqYUR/m+6X0yoXgXrHlHwzMVVP9
    8fZonrhMFP6Zv/wUdL27XnSwTfigUHtqIZo73DHm/czL/MrgrBgH+7TjlOyOns+Q
    3YcVBN/QPyPNUjYmhK++FCHIYotLow70VrHvo5g+0dD0KjRdmScOvmmJxrN+LBoD
    ucquBVrgyFiXsCgWEongCIhGjzOiPEacXQp6jCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519217829; bh=JpcKYMmXQa9W76v+oLKtF0wnFs
    Z5oyZJySS0t3+Zp84=; b=lUTUrM0D42LhEM7nBi5lGRLfDylaH8OFXK8mmoqxXf
    iz3zfHcc+dXctXwOpPxdRnmRjMfgimp6ry7MQ/hCUrLcvBhGKJh7TNNMIXynRJxf
    3dTYYXRL1CcMiBP06dPijCr4sb3OGmzVB4+U4e9Y5/TFfIq+MMNerc5HoUDlT2wA
    bRXHqRoksHcSd9IrtcglaI7JaSYUlP2tTZY0J+Otzaj3Wvb4hgawr3LoWqADHoy1
    rBlUngdyh1ekHSaMDjhgIvF1EQAFKRoYYymA4RXtoYVaY4CjaoEEADFK23lxYlqh
    mihHH7v3qssj9ghwdQ/QObnn6ERI9RFeZNH/xg1bc15A==
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
        id S934588AbeBUM5G (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 07:57:06 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35650 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932701AbeBUM5E (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 07:57:04 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Vegard Nossum <vegard.nossum@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 4.9 68/77] vfs: dont do RCU lookup of empty pathnames
Date: Wed, 21 Feb 2018 13:49:17 +0100
Message-Id: <20180221124435.068113114@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
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

From: Linus Torvalds <torvalds@linux-foundation.org>

commit c0eb027e5aef70b71e5a38ee3e264dc0b497f343 upstream.

Normal pathname lookup doesn't allow empty pathnames, but using
AT_EMPTY_PATH (with name_to_handle_at() or fstatat(), for example) you
can trigger an empty pathname lookup.

And not only is the RCU lookup in that case entirely unnecessary
(because we'll obviously immediately finalize the end result), it is
actively wrong.

Why? An empth path is a special case that will return the original
'dirfd' dentry - and that dentry may not actually be RCU-free'd,
resulting in a potential use-after-free if we were to initialize the
path lazily under the RCU read lock and depend on complete_walk()
finalizing the dentry.

Found by syzkaller and KASAN.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Reported-by: Vegard Nossum <vegard.nossum@gmail.com>
Acked-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Eric Biggers <ebiggers3@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/namei.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2138,6 +2138,9 @@ static const char *path_init(struct name
 	int retval = 0;
 	const char *s = nd->name->name;
 
+	if (!*s)
+		flags &= ~LOOKUP_RCU;
+
 	nd->last_type = LAST_ROOT; /* if there are only slashes... */
 	nd->flags = flags | LOOKUP_JUMPED | LOOKUP_PARENT;
 	nd->depth = 0;
