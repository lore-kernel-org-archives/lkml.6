Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3726165-1519676380-2-5708934387172413597
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
    t=1519676380; b=gEV3eiR4eeE6IXYphXNdbfZhRbp9KxXoeuYIyZSFsNmV6TT
    HFhEGI14wkqsjh/QNRIFQqVEJ/h+LwoJDrg6DTArUvFG/sgVacxpN513oFNCdQRY
    jpQHXJiDgdkZpbZjv/ne6tzi+vH/5+t1ayGMXhj8Zr8o7AfWFG7cxo1zEf03QySh
    oo6qFDZLY+vip6Q9OmejfbPS+1FLRrvZC6J2ULeArXwY6LJJApEhrRSd1fxliFwW
    L/AX+gh343sM98S7tWYbndzRtWbnYxQMqIrMmOOLWgik27hJlPiq7AQY7+/OqumJ
    +LHwBjZHYT4suwqxMPB9hFh8itu+atfVaon8LlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519676380; bh=HbUun5r4Smy6O1Q1CQxyFyjfZl
    PuPymisR6nUtT02s4=; b=I4WQMnoPcMHKnkMy0LT7i/RtDmTbPyv+MbnT8U8PNU
    ry5K+Le3dHIFTr00nunoAXg3m24arHiumTXrDbDD8as+jG54y8Hb1SagC/4WsYyh
    4EvrTMfZkC/FjJbpTFEiiK0NQt//L4vipNCLMGWbYyq090EoYsZN+No4tO/D1QwR
    8YpPHcTMi6xgcYl6A3azukQNVPIAtryFsNqFvTuSq7C+/qn2W1VS0YpsPnMi4xPc
    me4SvO4ewyI2tl5yJfvbXh/kFQK4IndGYwt/2P3l9VfS5cwmznMA/bVlNYVMGAOC
    zCy/VyrvTQ1nz7xm5f69nKHqnT2xqp59PciDUYHRPHjg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751553AbeBZUT1 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 15:19:27 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:59798 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751446AbeBZURO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 15:17:14 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH 4.4 22/22] binder: add missing binder_unlock()
Date: Mon, 26 Feb 2018 21:16:22 +0100
Message-Id: <20180226201559.693431247@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201558.681421374@linuxfoundation.org>
References: <20180226201558.681421374@linuxfoundation.org>
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


From: Eric Biggers <ebiggers@google.com>

When commit 4be5a2810489 ("binder: check for binder_thread allocation
failure in binder_poll()") was applied to 4.4-stable and 4.9-stable it
was forgotten to release the global binder lock in the new error path.
The global binder lock wasn't removed until v4.14, by commit
a60b890f607d ("binder: remove global binder lock").

Fix the new error path to release the lock.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/android/binder.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2622,8 +2622,10 @@ static unsigned int binder_poll(struct f
 	binder_lock(__func__);
 
 	thread = binder_get_thread(proc);
-	if (!thread)
+	if (!thread) {
+		binder_unlock(__func__);
 		return POLLERR;
+	}
 
 	wait_for_proc_work = thread->transaction_stack == NULL &&
 		list_empty(&thread->todo) && thread->return_error == BR_OK;
