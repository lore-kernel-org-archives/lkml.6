Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3775223-1519416435-2-16709037061550250620
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
    t=1519416434; b=bqKKquN3GWYqhFBs6U7yXoO4l4OoKXbF7FcMm+R2mSS0ID3
    R4GbwUzhDIG881brIZXsXiLM11Cc6A0er6XmnJwWXi7Bn1q4NipvCVT8NrZInJ2s
    1lBwdmv7/WFcQipz9dBz+K+B1tZNybGwC9XSC9Rv0N67LG9CdaWeGy1wj4bkCX1Q
    oj9TzUwJ8fpHo3r6xDVyxSXXX7jEnbWd9uKZgixxCAKayUFALeWDmy8o/+fezzjk
    BTMJh1srnkWHnS+9qeegm+ZY95u+k/y7CNZ5rAeVu7rs/SeERHiZAe1f5fwCUCwK
    hISTtDwCjL2Wup9CDysRZ8u+cs0pmVAjtsUmsMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519416434; bh=rZIpmzHS9UFaBUdh/d9FjytWBo
    FlWAPK2PSiZR20kTU=; b=Ai2+4cVP0Xe1Zn+5MT5SfmzDq7uW9XHJbxPS9FDzqs
    sdUn5PZLFXe4dCKBOkuvG1m1cW6SBoW5/+Fm+LS1mRXAE0StF8w6dov78q8ZGcMf
    mdh8bz24o6++j9avcLpmjD5G9OECTN0zicxyLDLxGNEtYWkBe3JpB/0DI+WOml+Q
    vD70SEaaDXHe9gytZ7ug2I/W8ZTyhhamJxtI4rMaIZuPmJantloF7MjKCAxDDI3g
    AkGWqC2GBUGeOK2bnMEhCwgs5fIxWNoRHUL21q+reKXfkuVHM0SqdK18sVuzqwov
    HM3Zk6niDUNEzSavHGiUSI2l6sfQwuLA7U+7133OWWmQ==
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
        id S933155AbeBWSmz (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:42:55 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41944 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932515AbeBWSmv (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:42:51 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Shankara Pailoor <sp3485@columbia.edu>,
        syzbot <syzkaller@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 021/145] kcov: detect double association with a single task
Date: Fri, 23 Feb 2018 19:25:27 +0100
Message-Id: <20180223170727.394863455@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
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

From: Dmitry Vyukov <dvyukov@google.com>

commit a77660d231f8b3d84fd23ed482e0964f7aa546d6 upstream.

Currently KCOV_ENABLE does not check if the current task is already
associated with another kcov descriptor.  As the result it is possible
to associate a single task with more than one kcov descriptor, which
later leads to a memory leak of the old descriptor.  This relation is
really meant to be one-to-one (task has only one back link).

Extend validation to detect such misuse.

Link: http://lkml.kernel.org/r/20180122082520.15716-1-dvyukov@google.com
Fixes: 5c9a8750a640 ("kernel: add kcov code coverage")
Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Reported-by: Shankara Pailoor <sp3485@columbia.edu>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/kcov.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -220,9 +220,9 @@ static int kcov_ioctl_locked(struct kcov
 		if (unused != 0 || kcov->mode == KCOV_MODE_DISABLED ||
 		    kcov->area == NULL)
 			return -EINVAL;
-		if (kcov->t != NULL)
-			return -EBUSY;
 		t = current;
+		if (kcov->t != NULL || t->kcov != NULL)
+			return -EBUSY;
 		/* Cache in task struct for performance. */
 		t->kcov_size = kcov->size;
 		t->kcov_area = kcov->area;
