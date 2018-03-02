Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1330670-1519989356-2-5559311126063045592
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES daen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519989355; b=ne8AL6iU/u/748iKWWp8LlmJAoPuqwHxNL94I4U3Ln14Pk6
    raYUa36M7yO6mjZ8ylEFCVvs6/SNYPVMBZJX9kkk9E2aJ05Qa/9yriNI01/gO9mC
    vEcj1mmHuHQKY+0kBDPTwa/S5HlyCTLVtUCzF6W1uNjdRP+bJCwTxuhdoRGXgreW
    np5VglGo/bX0H0sOLJ87yv8GVz0F27Gi00ztzGE0qqXJG0XcRL3+DIsZT3fU/gK3
    YkwwhqKjVfIzIfPTi58Bwmc/1wdKlzfXqlEUbuIdG+sdsqx6x9E6UCM6X4o2Z0RT
    oUJQ4TI+3fRJVhIBN8BI/DQxvT5le+KX78Re8zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519989355; bh=5rm078RSRaKz+5AAH1iubSLQT3
    BITlZFbe4N7QTyHLs=; b=QI6GofQeoNarpBLiwYddnATWXugYCL0c6SDCAaszYO
    qIsj62lZjZ3bu45QsNsBkxkDUDGY1HlBJPy1MjIdoTDQm1D8/rBEJFlfQsmXF5xX
    DLZMHYgGyPc1P+GKxKfkPh+3jAaydLGZDTMHe8dalEkvNDJlrJc0JOevykvBa4e4
    7xSnc5N4TE0O34QaAKKsfcsryBznGO+OukVczN9IKnoYPEHr/9RQzNAThGzmHPlE
    +NSbH4m2Y7weuWh28q97q8SmkF35F0M9x3PYL8ra5lKXtjcnwr7U1B5vA9MDl0Op
    uW1JwPdH+nuS/TOCBpRia5FFyzzfQGANiO73cHGDUb9w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423382AbeCBIxv (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 03:53:51 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50214 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423321AbeCBIxt (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 03:53:49 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 05/24] sget(): handle failures of register_shrinker()
Date: Fri,  2 Mar 2018 09:51:02 +0100
Message-Id: <20180302084239.446610429@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084239.157503766@linuxfoundation.org>
References: <20180302084239.157503766@linuxfoundation.org>
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

From: Al Viro <viro@zeniv.linux.org.uk>


[ Upstream commit 9ee332d99e4d5a97548943b81c54668450ce641b ]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/super.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/fs/super.c
+++ b/fs/super.c
@@ -476,7 +476,11 @@ retry:
 	hlist_add_head(&s->s_instances, &type->fs_supers);
 	spin_unlock(&sb_lock);
 	get_filesystem(type);
-	register_shrinker(&s->s_shrink);
+	err = register_shrinker(&s->s_shrink);
+	if (err) {
+		deactivate_locked_super(s);
+		s = ERR_PTR(err);
+	}
 	return s;
 }
 
