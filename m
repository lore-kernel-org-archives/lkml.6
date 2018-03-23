Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804582-2-1303038164503117257
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
    t=1521804582; b=dMhuDjYGFutd8/wCE8qSYl/+C3cOZRCq0PeI/A1k3lOBu7V
    TKG71htuTs994ttcuy8lnzb8fNFa9TTFEyJJx0xluBoucnpa4QT4siKa9mPJ/QZ7
    ZdfXEyZL9mbDJsmzDrfph6yfoOhu527QXtGPaUoyh61CeFQxSqSND/71I1mxkoEi
    fFR7mkZxCLMZ+Ge+cWGqhJ4emg8d3cQ1Lj/osIrJe83mxaOfzjDG9+SSk3d8bFwQ
    eZ8ffy3+Jj9Sf7b27xYZxTYglmGRhobM2BiDqMxliO4p+/Y74vcWrrDAh30m0W1Q
    /H0vlg8Yl9gnzUVF9QgsDHweZ+gRwGlGlNr5KsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804582; bh=dsv5kGNp0CdlgUno4wwrih5+bz
    3khZLFSUUnLxzVMAg=; b=NawiutG3YsU2rFR6hFYKksal990ZhIi3FgmH9faTg6
    UPZZPjOlW2AwEbI3E0hmDZ+meZWY7evzlGj7LLd2g0V20kT5KZ4KBcIIucRiYAOc
    R7j7/z0a0G0Q4PLcgBUrUlUmvenHlsJ1NeOKV5vr07HiwBgjUe/sSF452mVSQtJm
    WWVj8mUZ4Xhd6UaV8237HBgMctEyRdbc8RWSXLGMSGbFhBLoEZd8/vTk6jg3+sHH
    kVFV0bt022Qqa3oIu3xulCZj8XXjrAvLVfH1485M8KZfdgHElRT7csUpwZLch4cH
    Hv2I+1WRf90N/WgC16wg64aMiHC7nj+fQRDZmnqToP3A==
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
        id S1755250AbeCWKGd (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:06:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40834 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755207AbeCWKGc (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:06:32 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Feras Daoud <ferasda@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 044/177] IB/ipoib: Fix deadlock between ipoib_stop and mcast join flow
Date: Fri, 23 Mar 2018 10:52:52 +0100
Message-Id: <20180323094207.192106795@linuxfoundation.org>
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
@@ -487,6 +487,9 @@ static int ipoib_mcast_join(struct net_d
 	    !test_bit(IPOIB_FLAG_OPER_UP, &priv->flags))
 		return -EINVAL;
 
+	init_completion(&mcast->done);
+	set_bit(IPOIB_MCAST_FLAG_BUSY, &mcast->flags);
+
 	ipoib_dbg_mcast(priv, "joining MGID %pI6\n", mcast->mcmember.mgid.raw);
 
 	rec.mgid     = mcast->mcmember.mgid;
@@ -645,8 +648,6 @@ void ipoib_mcast_join_task(struct work_s
 			if (mcast->backoff == 1 ||
 			    time_after_eq(jiffies, mcast->delay_until)) {
 				/* Found the next unjoined group */
-				init_completion(&mcast->done);
-				set_bit(IPOIB_MCAST_FLAG_BUSY, &mcast->flags);
 				if (ipoib_mcast_join(dev, mcast)) {
 					spin_unlock_irq(&priv->lock);
 					return;
@@ -666,11 +667,9 @@ out:
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
 
