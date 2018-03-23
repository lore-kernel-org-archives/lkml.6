Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1061450-1521802342-2-5591693467993702623
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
    t=1521802342; b=NOI/HyV7D8aJkyNyM9hCebG8uKoLq/6soYiPG+DvxnrCa42
    Bi3U83Hk4gJAA8DWIv0ztBKPS9kCqAA3YnejBRhkZeD9knqf/bJM9oDWLB9kUxLW
    3tbLwlxYZcQ6NRPg4lqYgbTSN2HHZPZyEQmNaf/i4fYW0UieSzTQqC6a0cWbeqpx
    UF8b/6T5zVlsi899Hx92RUkQOk4sRYgKdR45dA17T0NhoG+MsS2xl4IAB5bnPc7Q
    HTsVm9J9TBYXnSzVqVG2r9zORrzJ0lzvssAiV85NPITo/x6hCtEnrqiLGsfe1fLx
    D4gHPi9SSntkEJCRhkrotKrb0b3GvlJI7vm1VJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521802342; bh=+2ghKHW8x/UDi5RHqAYb2/Ci5t
    YJzR3YhLFh2JBG1+c=; b=aM9myk2OdtyO2FmjePLjtCjB3HXH/194M6gpRuhky8
    mVD06eWp1fVWlaBy98gjKbrGQOXWlo6HAQzmsHJ8/45bi+fkx368FPh/ic8TjAmR
    WHpf4IBvUk2RvYkBXnMKqRG4uTES2q332Yw//UukpHzM7RfQAoyCS2D8dn0Oho5e
    sboRk9a+21NgKx+872sIGaH7iuaS4cS6AQpvFt3qYlZeXTdZ3wwiPbgoQ8oQm0lf
    0f2jDYkd6LUzKvMa8gMOcAqqk2thy7bjmJ6+sxVWL8Jlg+sbpZ91yx/OAfeUda8G
    DUyjLiTxfZHW2TXvJRcWKFZ91nGHcRsnHrcNfAKCqjYw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
        id S1755979AbeCWKOK (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:14:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45058 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755901AbeCWKOH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:14:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Feras Daoud <ferasda@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 31/97] IB/ipoib: Fix deadlock between ipoib_stop and mcast join flow
Date: Fri, 23 Mar 2018 10:54:18 +0100
Message-Id: <20180323094159.381404262@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
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

From: Feras Daoud <ferasda@mellanox.com>


[ Upstream commit 3e31a490e01a6e67cbe9f6e1df2f3ff0fbf48972 ]

Before calling ipoib_stop, rtnl_lock should be taken, then
the flow clears the IPOIB_FLAG_ADMIN_UP and IPOIB_FLAG_OPER_UP
flags, and waits for mcast completion if IPOIB_MCAST_FLAG_BUSY
is set.

On the other hand, the flow of multicast join task initializes
a mcast completion, sets the IPOIB_MCAST_FLAG_BUSY and calls
ipoib_mcast_join. If IPOIB_FLAG_OPER_UP flag is not set, this
call returns EINVAL without setting the mcast completion and
leads to a deadlock.

    ipoib_stop                          |
        |                               |
    clear_bit(IPOIB_FLAG_ADMIN_UP)      |
        |                               |
    Context Switch                      |
        |                       ipoib_mcast_join_task
        |                               |
        |                       spin_lock_irq(lock)
        |                               |
        |                       init_completion(mcast)
        |                               |
        |                       set_bit(IPOIB_MCAST_FLAG_BUSY)
        |                               |
        |                       Context Switch
        |                               |
    clear_bit(IPOIB_FLAG_OPER_UP)       |
        |                               |
    spin_lock_irqsave(lock)             |
        |                               |
    Context Switch                      |
        |                       ipoib_mcast_join
        |                       return (-EINVAL)
        |                               |
        |                       spin_unlock_irq(lock)
        |                               |
        |                       Context Switch
        |                               |
    ipoib_mcast_dev_flush               |
    wait_for_completion(mcast)          |

ipoib_stop will wait for mcast completion for ever, and will
not release the rtnl_lock. As a result panic occurs with the
following trace:

    [13441.639268] Call Trace:
    [13441.640150]  [<ffffffff8168b579>] schedule+0x29/0x70
    [13441.641038]  [<ffffffff81688fc9>] schedule_timeout+0x239/0x2d0
    [13441.641914]  [<ffffffff810bc017>] ? complete+0x47/0x50
    [13441.642765]  [<ffffffff810a690d>] ? flush_workqueue_prep_pwqs+0x16d/0x200
    [13441.643580]  [<ffffffff8168b956>] wait_for_completion+0x116/0x170
    [13441.644434]  [<ffffffff810c4ec0>] ? wake_up_state+0x20/0x20
    [13441.645293]  [<ffffffffa05af170>] ipoib_mcast_dev_flush+0x150/0x190 [ib_ipoib]
    [13441.646159]  [<ffffffffa05ac967>] ipoib_ib_dev_down+0x37/0x60 [ib_ipoib]
    [13441.647013]  [<ffffffffa05a4805>] ipoib_stop+0x75/0x150 [ib_ipoib]

Fixes: 08bc327629cb ("IB/ipoib: fix for rare multicast join race condition")
Signed-off-by: Feras Daoud <ferasda@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -473,6 +473,9 @@ static int ipoib_mcast_join(struct net_d
 	    !test_bit(IPOIB_FLAG_OPER_UP, &priv->flags))
 		return -EINVAL;
 
+	init_completion(&mcast->done);
+	set_bit(IPOIB_MCAST_FLAG_BUSY, &mcast->flags);
+
 	ipoib_dbg_mcast(priv, "joining MGID %pI6\n", mcast->mcmember.mgid.raw);
 
 	rec.mgid     = mcast->mcmember.mgid;
@@ -631,8 +634,6 @@ void ipoib_mcast_join_task(struct work_s
 			if (mcast->backoff == 1 ||
 			    time_after_eq(jiffies, mcast->delay_until)) {
 				/* Found the next unjoined group */
-				init_completion(&mcast->done);
-				set_bit(IPOIB_MCAST_FLAG_BUSY, &mcast->flags);
 				if (ipoib_mcast_join(dev, mcast)) {
 					spin_unlock_irq(&priv->lock);
 					return;
@@ -652,11 +653,9 @@ out:
 		queue_delayed_work(priv->wq, &priv->mcast_task,
 				   delay_until - jiffies);
 	}
-	if (mcast) {
-		init_completion(&mcast->done);
-		set_bit(IPOIB_MCAST_FLAG_BUSY, &mcast->flags);
+	if (mcast)
 		ipoib_mcast_join(dev, mcast);
-	}
+
 	spin_unlock_irq(&priv->lock);
 }
 
