Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3704313-1519413846-2-14242084143903069296
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
    t=1519413846; b=ZASnEQSsjLp6GCuKYQHsyW/7niTHEH8lcO4jcPz63UR79gs
    Oxv4TyrEBx7qF4e9vlK95xOezjH7CecJ39VjKQHgnVV7gVoJ2Lt9OvJyO+pnGFQg
    +0eW2ZQagrw4q75mQFtKC3iMpLDm/hDmHOwCHM0+aiciTQKh/hUjLu46kabBLmw0
    KB9GMn/GIAN84ik+bmQAgDtfA1TumsPV3nc7aHK+zrwlApbwmLs18IboAFRvHd65
    n/MsIBwV9nsp+gKejqL14bmfbbDI/6ZGwOTP+u5IOqPKVanGfbQjkcvxIYsV1NJ1
    DKRJ74dvAl2l8HmfrtnGCZkZCWxywSqF9f8lcZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519413846; bh=V3mBy1w2t9HJ8592rBMkjWjRwd
    U3LtTvyGgxo9GVRpQ=; b=MHwST9/WJRsFiUBAqMwxza3RdstpxHQf4uKf98RQLR
    k6e6Amx+g+U6BDuT0lQJuuRocEpN8lCFlxhkUvi8qLlzrwnuXWyXpW1613xD/p/+
    WqyqbBJ7xOqpE7HFzQ8x+Nr5b/N9/wxHjUJ/KS9H7Dl3+WqNnPwUvWfZSLT85oGA
    si6v6E9kzpUx/G5pvQ8xj8Y9tizI9U/qCf3FndlIkmDikK92yLnQArXtD96DVlMg
    Uz1mN9ha+d+YbE89CLQ/qPRCVQpZ+NxUJbI08eGpyrMRafSyaRB7gzNsdV33DVz8
    X2ZYPIXoO2/11v/SWdRGXJ9N92N6W7+g7xVAe7yht/4g==
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
        id S1752234AbeBWTXt (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:23:49 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47294 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935048AbeBWSxS (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:53:18 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 090/159] i40iw: Do not free sqbuf when event is I40IW_TIMER_TYPE_CLOSE
Date: Fri, 23 Feb 2018 19:26:38 +0100
Message-Id: <20180223170754.407848638@linuxfoundation.org>
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

From: Mustafa Ismail <mustafa.ismail@intel.com>


[ Upstream commit 10499986dbd8778e1acf9f9d2e166800dfee44b4 ]

When the event type is I40IW_TIMER_TYPE_CLOSE, there is no sqbuf and
it should not be freed as one in i40iw_schedule_cm_timer().

Fixes: f27b4746f378 ("i40iw: add connection management code")
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/i40iw/i40iw_cm.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/infiniband/hw/i40iw/i40iw_cm.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_cm.c
@@ -1043,7 +1043,7 @@ negotiate_done:
  * i40iw_schedule_cm_timer
  * @@cm_node: connection's node
  * @sqbuf: buffer to send
- * @type: if it es send ot close
+ * @type: if it is send or close
  * @send_retrans: if rexmits to be done
  * @close_when_complete: is cm_node to be removed
  *
@@ -1067,7 +1067,8 @@ int i40iw_schedule_cm_timer(struct i40iw
 
 	new_send = kzalloc(sizeof(*new_send), GFP_ATOMIC);
 	if (!new_send) {
-		i40iw_free_sqbuf(vsi, (void *)sqbuf);
+		if (type != I40IW_TIMER_TYPE_CLOSE)
+			i40iw_free_sqbuf(vsi, (void *)sqbuf);
 		return -ENOMEM;
 	}
 	new_send->retrycount = I40IW_DEFAULT_RETRYS;
@@ -1082,7 +1083,6 @@ int i40iw_schedule_cm_timer(struct i40iw
 		new_send->timetosend += (HZ / 10);
 		if (cm_node->close_entry) {
 			kfree(new_send);
-			i40iw_free_sqbuf(vsi, (void *)sqbuf);
 			i40iw_pr_err("already close entry\n");
 			return -EINVAL;
 		}
