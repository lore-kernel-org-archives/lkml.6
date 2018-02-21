Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1474421-1519217272-2-125973693939538209
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
    t=1519217272; b=QshygcnbQ/u0Fiuliu9kbGjbcZIfhACpR9Ni9RYX8YYhfpx
    8MEwkYlLcR/f98sBZ/Y+Lj0fJSK5+YwzGhG6Wa9IBR86gMf4qw/CwS9bwXs8d/SQ
    0hiCQmYugSngUBDqbe7pB1r8YZFRH1BH7t7x0whNLGpcUBV1X2uvYRuwtlTR7UJ6
    FVWprZMI1P5gVWrNfzs/SKAasjDOsXWKtmh/r7vPRsSslz9zOvd++4A5X2l4qzO9
    cf4XNnuoeRfJ9TDbYKskqWcmLmC8KHs6rC2Is9zWk30vJ82+WusWfTaqtXw4SGa6
    Mn+/8vwVzDuW9J6hbcP3N6mOmUDLo+qJ1+6YHpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519217272; bh=gNYWuvGFOLOjfQ1JJRPcLxHHlW
    zx3RMa/ptBAV9MNKU=; b=uSjhlg0tbbUPe/RnVKFpn1PW7iAgSAO7YAz6GJJWvA
    qOOrqm6FHMROLSnmdUAkL5pZFiqWn386Mpqj3BNxqYmgRCvIYOblv73ysv5bh+s3
    hKwPK4bDnePvkwGifrD6nQbSPOtaCMnVWh8ExrOQ7HeTH7jowViD5meIWbhTbs/a
    fusyqULJV6Hyhbn/119eune5EpmaA2v5DTGnj76RgSJOTZSySTR6itJW6gyvfaxN
    3NdH/ZT7e8k9Gp1jxbCI4lEjP1oBMpznvq1dk//FZwOGDAUXNBSAUHA8PgVsoBYW
    tZi9bSyeX9ExF38tWiS8EiFc4ivORdaN/6pweFxPZC/w==
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
        id S933944AbeBUMqi (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 07:46:38 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:59960 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933905AbeBUMqg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 07:46:36 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Vegard Nossum <vegard.nossum@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 4.4 30/33] vfs: dont do RCU lookup of empty pathnames
Date: Wed, 21 Feb 2018 13:45:13 +0100
Message-Id: <20180221124411.128121753@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124409.564661689@linuxfoundation.org>
References: <20180221124409.564661689@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2000,6 +2000,9 @@ static const char *path_init(struct name
 	int retval = 0;
 	const char *s = nd->name->name;
 
+	if (!*s)
+		flags &= ~LOOKUP_RCU;
+
 	nd->last_type = LAST_ROOT; /* if there are only slashes... */
 	nd->flags = flags | LOOKUP_JUMPED | LOOKUP_PARENT;
 	nd->depth = 0;
