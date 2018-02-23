Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3704313-1519414307-5-11077069152705873218
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
    t=1519414307; b=bddkgdiiSMXAWHTwX6tfYK+pFSAKt5voga8VK+rPk+aUXcZ
    atOYFm/FTv7VDjH1Ue+TYin8Gft0ZtqykJXIT1Xkyz06ymbFFG9EhWcmKkjsAQNB
    AMUPbvEEdYObEDTSyZF1qkH2MK+8CLND/hO4wV3W+zTemb8e7zMjUV9yiuDGpkOf
    kglZj+fvTF6ceMQjdk+R089TAtKjy1tzqWjpmh+DVW0YX/52OpHPHadSnWh1S6gs
    LorlSFOb7VSejZD9/WnrMr+hUDz8u6JnUEIifIVxTRqPJUDwh+FbYQDxys2ZaJPE
    tWCEt+Qds8fEGjfc4lZank3CfiAR8oz1leeCfmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414307; bh=lzcBUgR7H61xNF2jlQbg3NYuuQ
    LL1fxTGV4CLQLs+ko=; b=CvtW9s2H1dM0a7HjdP765rBT90rr65CJRKgCK2hwuK
    KdDtsGvZnrcFnZAirfYlHR6nBON9hUllxj/EYjIAtvhQUjEeB98nRQxuTvZNxI04
    YxsgYmfFHdQh4bfO0RsNHSUA585LgNhmJ6otGevkUlVQYMmvZcmUYZh4JfKCe+Rg
    HBJ3vX8CAkMrRxBOL/HxgclT44+EEYuB+43UONV6JMF4NKTtWjQG3EtFv3AX8ltB
    DSHhtyYrBQfx3sV1ph3SBkr79PtHml3/z8NS14LYHfzl8swLU2Iq8OurVN2WZ67x
    q4jgXeTKfwo1oje2jqX1keJ2+4rCHHNg0mqBlnqaYDRA==
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
        id S934965AbeBWSvb (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:51:31 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46032 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934552AbeBWSv3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:51:29 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Shankara Pailoor <sp3485@columbia.edu>,
        syzbot <syzkaller@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 034/159] kcov: detect double association with a single task
Date: Fri, 23 Feb 2018 19:25:42 +0100
Message-Id: <20180223170747.514302346@linuxfoundation.org>
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
@@ -225,9 +225,9 @@ static int kcov_ioctl_locked(struct kcov
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
