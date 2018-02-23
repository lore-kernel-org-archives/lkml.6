Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3704313-1519414285-2-7717975584163923979
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
    t=1519414284; b=ZB9fz5Qu2sQrhl0eKjfOUAFPyBQVn3GHhXhM1dkBH1f5Wts
    Kmlrrkx1zBH1mILCoAflyz/79Fl09xM6K48N7SwH8hircVVwljzME3je9+BZByr6
    Ho/lfQEYy2k1xiyHRysH0q1Hf6S2QkfPba+hb3B+xN2uXzdzzYb0J2/DVy22aywa
    ZdiQx3vsvsArv6tp4jWklh38Wc++EqRRLJ4UaIP+pPYOMfRW14OR3m0QARUg3eD4
    TUQ5aC3V3DbukeY/lsLSyvIganiCggvwEfYrZPiJ/Pr3xsORG+n2mlye+gy24t/q
    mUr7nAE7Czj0T8EyAaS7g0UF0tbbfo+16I+vE2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414284; bh=ecpH2lUGKGhaFXOiC7pugXoq8f
    MMTrFV+EWJetWxq9g=; b=CQqhh01MCLag2QG/zMdVWsFRhpXKYbbC0YuhBeniJv
    pnEHDU0NYu/vBpUrzXkaSdff+HMqoFA0YD0HZ4/d6eAP3gElb6YwxLPPcyX2dxCJ
    XoGRK5e0Uiz7ZvLdlGxdyYCPkg69Nhm6L54PfizeH7rbK4SqQa64S167rS8LgdZe
    KZMfm8WRvRm50Dg9Eg44MVLIZUs0dNe90Zz60n0UOlMU22OrUXRpMsn/FoMEQq/9
    wKVDAZjAoZOS5shIWKatXe3X09zHqEm0SbFtbKsnBoYUOYkDgV0ivkVJJh2nsP0t
    FB4l+xU6jkyZsHbUeUpfz6OwUGh/8K30GTahpA2TMyZg==
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
        id S934605AbeBWSvh (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:51:37 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46050 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934552AbeBWSvf (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:51:35 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH 4.14 053/159] binder: check for binder_thread allocation failure in binder_poll()
Date: Fri, 23 Feb 2018 19:26:01 +0100
Message-Id: <20180223170749.994498164@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
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

From: Eric Biggers <ebiggers@google.com>

commit f88982679f54f75daa5b8eff3da72508f1e7422f upstream.

If the kzalloc() in binder_get_thread() fails, binder_poll()
dereferences the resulting NULL pointer.

Fix it by returning POLLERR if the memory allocation failed.

This bug was found by syzkaller using fault injection.

Reported-by: syzbot <syzkaller@googlegroups.com>
Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/android/binder.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -4346,6 +4346,8 @@ static unsigned int binder_poll(struct f
 	bool wait_for_proc_work;
 
 	thread = binder_get_thread(proc);
+	if (!thread)
+		return POLLERR;
 
 	binder_inner_proc_lock(thread->proc);
 	thread->looper |= BINDER_LOOPER_STATE_POLL;
