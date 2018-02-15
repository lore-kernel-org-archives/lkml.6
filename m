Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1906823-1518710482-2-3272551319743739350
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518710482; b=jT2JBzqDnjptbBVNTDNKZMiDJUTY4BNr7InCLAnMJjV03IL
    4Y7aCiKcvK7ILnhP790BEYHmcU0410lsE0+PEixfj9+44Ls306WqvqEBjhXpqjWl
    7jNqn5LceNtIJODUyXu8mnqv4mlNVkDTTeeb0jZetierrdrIkhXgRqMXjRu4yupu
    9LkXGSVejszweSjLmkxk6/0Y1inKeNAZmR0WrWXDwNlQG0qU1eRn8FYn1uFpV5wR
    wL+4raEMDOInZhTziQ8GWpU9Mv3pnOzdiZ0hzH6o0xeKzPAzACeZFViceT26hNie
    yOwSb2Ru2FQ3ca8lynmS9pJB9TM59rryHntU3Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518710482; bh=VCL/I+C7EDhk3QZnRZHiN9vowJ
    6gNZBgoXUMV5PsFrc=; b=eG2niIgnr/h5YitwA2idtAusvxfsFtoIP09u48TL8G
    tYgNOl5X0Z/eVu3DqANmBGO5hEht4tL+6u1hLUHTV+mgA0JgDVyCt3YJPsS6/1Rm
    4OJYiZNJbrCRyPDL/lloKWISaJGfCfrG/9/+EHTXUT5Md7Oa45fsnfr06uci4P9v
    vsHQuPqICJVWN3bDhvSccgUkoQlWNLWHP8Bpkl6A02xdoCqOX9zV7AFMTRQ2nUb7
    ekW6utqVMwZp8yX3G5fIv0ODJdeRduVfoF398/8R7pYXUDK5hYYA/y9eM893sP83
    C0x1eWEj8DYW6JahJCClYIb2iyWqEXP8kf/bwBapbPuA==
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
        id S1424800AbeBOQBG (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 11:01:06 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35970 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424685AbeBOPqx (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:46:53 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bart.vanassche@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.15 181/202] pktcdvd: Fix pkt_setup_dev() error path
Date: Thu, 15 Feb 2018 16:18:01 +0100
Message-Id: <20180215151722.327456425@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit 5a0ec388ef0f6e33841aeb810d7fa23f049ec4cd upstream.

Commit 523e1d399ce0 ("block: make gendisk hold a reference to its queue")
modified add_disk() and disk_release() but did not update any of the
error paths that trigger a put_disk() call after disk->queue has been
assigned. That introduced the following behavior in the pktcdvd driver
if pkt_new_dev() fails:

Kernel BUG at 00000000e98fd882 [verbose debug info unavailable]

Since disk_release() calls blk_put_queue() anyway if disk->queue != NULL,
fix this by removing the blk_cleanup_queue() call from the pkt_setup_dev()
error path.

Fixes: commit 523e1d399ce0 ("block: make gendisk hold a reference to its queue")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/pktcdvd.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2745,7 +2745,7 @@ static int pkt_setup_dev(dev_t dev, dev_
 	pd->pkt_dev = MKDEV(pktdev_major, idx);
 	ret = pkt_new_dev(pd, dev);
 	if (ret)
-		goto out_new_dev;
+		goto out_mem2;
 
 	/* inherit events of the host device */
 	disk->events = pd->bdev->bd_disk->events;
@@ -2763,8 +2763,6 @@ static int pkt_setup_dev(dev_t dev, dev_
 	mutex_unlock(&ctl_mutex);
 	return 0;
 
-out_new_dev:
-	blk_cleanup_queue(disk->queue);
 out_mem2:
 	put_disk(disk);
 out_mem:
