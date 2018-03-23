Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1092440-1521803862-2-1839234473015885078
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521803862; b=PO6Dm/khs+MR1LbPlKdlApL9WPhYMHEx3YNE+0Uju+PzhsJ
    L4lp8XDpa2x7gnLXaLQqyYxe1FSrE1/ZKyasaSgaeoqVkftQ4dVf4FM6oTnRROzD
    5/dSNuoFl6PlZe3a93HjVIukwPV9aYdR37XRSAgKD9cmdjGauJYYWosifWiAl7R3
    6QrAagBGDxn2ScI+XMshmBQ0H/VHpoCgUNNrTc8D1qQg+Ih90XiVFGh3bbY0jjXq
    k/DfWiTzIJ9oSO9SeIPNuw0DtMxgdkq6byrwJgX9W0dZI3TQgetTm0B/XNcPrM1o
    nVKt1S8ieAkgvbrI5nS/nKth79R3YeF4vFwoFzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803862; bh=9Jkjdf8FJBTbTIvLxaW5UQgKSd
    viFKHmmpmG5DjcMkM=; b=IZhaMYfhOhgiAQBDwKnYa31y0ORPnZ7SAUSSqLDJXg
    mPk0CM6wljIvHMYIQAD/7w06Yiec0ctt5+K9kYCwJwgJ27NglxjrKrI5LeDH+Foz
    2v5uX8xufRHigDNpOYK1f7JGNqMpLbohOxYpgK3RCjv2gQPQuXawyupW+KoTU7CA
    HbamQGfRYSewzKkF+iAkd8hEcC+zrVGe1BhjiLTZ9ECjI8ydbnx1o/e3ZkrgDlgG
    Ivh9Yjra5DMrNIWm1xVvazgLGk+vw+nng6QNX6JKkPTxZPu0U5DvUyMjqUmKh41a
    F4Ws/xtFpxKx6oHTt3CZcCFXY2ySaDbC2DsATAiYD1Ng==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755767AbeCWKJZ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:09:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42090 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755763AbeCWKJX (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:09:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guoqing Jiang <gqjiang@suse.com>,
        NeilBrown <neilb@suse.com>, Shaohua Li <shli@fb.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 116/177] md/raid10: skip spare disk as first disk
Date: Fri, 23 Mar 2018 10:54:04 +0100
Message-Id: <20180323094210.377226478@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
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

From: Shaohua Li <shli@fb.com>


[ Upstream commit b506335e5d2b4ec687dde392a3bdbf7601778f1d ]

Commit 6f287ca(md/raid10: reset the 'first' at the end of loop) ignores
a case in reshape, the first rdev could be a spare disk, which shouldn't
be accounted as the first disk since it doesn't include the offset info.

Fix: 6f287ca(md/raid10: reset the 'first' at the end of loop)
Cc: Guoqing Jiang <gqjiang@suse.com>
Cc: NeilBrown <neilb@suse.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/raid10.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4089,6 +4089,7 @@ static int raid10_start_reshape(struct m
 				diff = 0;
 			if (first || diff < min_offset_diff)
 				min_offset_diff = diff;
+			first = 0;
 		}
 	}
 
