Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521804830-2-2060287258284627861
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
    t=1521804830; b=GhWNJt3UKrAD+ua17YQKLjqvwYdQDwlveqGO9OrGAWbTE84
    jabPBJ/LNBq1K/GhZh8+PRWFs2pFvwRQMGRgrWm9DHszG7z3WsjsCFZx+j8/BwE5
    /AAZQ0gkjD4aaviCLS1Tyj0s1YxHl8mY43VD+b3XzgwZ0Mul66WFJiAMU1Icb27H
    KA5+Nni+oZ2S/vqilz5nBh5sCCpT1yFzk7x4bYR1um8CO7qpepu3MyM5+F24CJ5K
    mC75VCFKwBwdCG232bB0YCGbDw38IT635DmTm8nZvR6UIjeGOj0f1IiSGFnXtEu3
    0RH43iWLb3zvqZl6QkU7+cQLFOOzAhwF873Lgrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804830; bh=DOYW5/AdjZ5gfO5eGDXPk539Vu
    DMc5IfbpyabX3n1yc=; b=eyNwOkcf5FI6Qy6xWMKkLhFzgLzKOJAPl7FuNyFqSg
    PttZekCG3pTmJGJgu7IfnNUAvZoE4cPYhrANuNeuLe7QBwDdXtS1R9tYdcBawnVM
    xVJClZ5xw/1t0zL1aBtEZmdRqByH+sg6aPnOyuKNDP9IRTnKipBaAL6JjnYgPn1e
    dVgDd9bel/GwRG0kUIh+HuMi/s0sVps7wT3y2l+tZzIVALtEzyxybxra9/fuy6rr
    6JI74y+WUYgFWS9VMoZhdMJXXM+wsUz6csYG+fpOaWOZJLyQo0c0EGxRu1zHo12s
    CYY+WrzXd9RNsJSsjbOhPdOdJyZmwXBXtanarAKyKZ1g==
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
        id S1755321AbeCWLdf (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:33:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39762 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755018AbeCWKFf (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:05:35 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guoqing Jiang <gqjiang@suse.com>,
        NeilBrown <neilb@suse.com>, Shaohua Li <shli@fb.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 039/177] md/raid10: wait up frozen array in handle_write_completed
Date: Fri, 23 Mar 2018 10:52:47 +0100
Message-Id: <20180323094206.886790183@linuxfoundation.org>
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

From: Guoqing Jiang <gqjiang@suse.com>


[ Upstream commit cf25ae78fc50010f66b9be945017796da34c434d ]

Since nr_queued is changed, we need to call wake_up here
if the array is already frozen and waiting for condition
"nr_pending == nr_queued + extra" to be true.

And commit 824e47daddbf ("RAID1: avoid unnecessary spin
locks in I/O barrier code") which has already added the
wake_up for raid1.

Signed-off-by: Guoqing Jiang <gqjiang@suse.com>
Reviewed-by: NeilBrown <neilb@suse.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/raid10.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2704,6 +2704,11 @@ static void handle_write_completed(struc
 			list_add(&r10_bio->retry_list, &conf->bio_end_io_list);
 			conf->nr_queued++;
 			spin_unlock_irq(&conf->device_lock);
+			/*
+			 * In case freeze_array() is waiting for condition
+			 * nr_pending == nr_queued + extra to be true.
+			 */
+			wake_up(&conf->wait_barrier);
 			md_wakeup_thread(conf->mddev->thread);
 		} else {
 			if (test_bit(R10BIO_WriteError,
