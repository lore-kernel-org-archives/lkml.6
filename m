Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-947063-1521799947-2-660834831622917753
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
    t=1521799946; b=VhCxv6lNT91kpYEPktSITqCWE0REPWG9hUtH63+93EwBFUv
    bHSYu+FFqwNC5T+jPr+QOKGoan6wo5fBzOu9SyP3uM6KjwnBgNZygwhdBZsNq5PE
    7oJT+3E562T7iZW0/aWi92r7MmOQ7aW0+11I85keeDjm6dYfqNV1Nv2xr5ji+s+y
    Zc/RJezn3vNIfgJoMZxnul6sWbpBgf/SxXTXLhUREXLkBB/o8hjnLqtAAdol0a5N
    ciNyfM0/SwlbW1axumMNyDQuoTjJidIDXbnm3hHjj97cjGMwHiBkNx7CXelTqRWP
    oFe3Mm28ngS9jjeELIw70SIV6DZTl6qsDuToQsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521799946; bh=lvuuIswoaj0OWZ0T9r0mcqpZ6G
    23Tm/hvbQQLRcIezU=; b=DMlZEM2XHXd/fLpl4t0p8hIGPcp/ilLzfKa6mPiSh9
    yV6GJyOlDZdBixi8odYyhyAOUAlWrISTHUAJL8FnrnMoN5mtVE+Y6WWjA/LtG+ox
    jABTfXx2Z982KoySW4wXvK6oHrnVci5Xrhokw5DlZLl7D/NtlVOp2nYR1vr0GOGs
    qnIjCNVY0ZIJVTJrwM9u//DY+QWyvnDNo07V336O4jji+pJpjyRNnTDKYmF7PxlA
    BitUXXib7KWgmywyZ+q+KSBi1jg0YWQi3EaPswVr5Aon9KyEw/9UborQKRmLr2Ei
    pmc7jCgeJzeuRXzjTvPZeTyNpV05zfe5THLPjto9AkGw==
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
        id S933161AbeCWKMS (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:12:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44210 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932478AbeCWKMP (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:12:15 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sahara <keun-o.park@darkmatter.ae>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 159/177] pty: cancel pty slave port bufs work in tty_release
Date: Fri, 23 Mar 2018 10:54:47 +0100
Message-Id: <20180323094212.200792318@linuxfoundation.org>
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

From: Sahara <keun-o.park@darkmatter.ae>


[ Upstream commit 2b022ab7542df60021ab57854b3faaaf42552eaf ]

In case that CONFIG_SLUB_DEBUG is on and pty is used, races between
release_one_tty and flush_to_ldisc work threads may happen and lead
to use-after-free condition on tty->link->port. Because SLUB_DEBUG
is turned on, freed tty->link->port is filled with POISON_FREE value.
So far without SLUB_DEBUG, port was filled with zero and flush_to_ldisc
could return without a problem by checking if tty is NULL.

CPU 0                                 CPU 1
-----                                 -----
release_tty                           pty_write
   cancel_work_sync(tty)                 to = tty->link
   tty_kref_put(tty->link)               tty_schedule_flip(to->port)
      << workqueue >>                 ...
      release_one_tty                 ...
         pty_cleanup                  ...
            kfree(tty->link->port)       << workqueue >>
                                         flush_to_ldisc
                                            tty = READ_ONCE(port->itty)
                                            tty is 0x6b6b6b6b6b6b6b6b
                                            !!PANIC!! access tty->ldisc

 Unable to handle kernel paging request at virtual address 6b6b6b6b6b6b6b93
 pgd = ffffffc0eb1c3000
 [6b6b6b6b6b6b6b93] *pgd=0000000000000000, *pud=0000000000000000
 ------------[ cut here ]------------
 Kernel BUG at ffffff800851154c [verbose debug info unavailable]
 Internal error: Oops - BUG: 96000004 [#1] PREEMPT SMP
 CPU: 3 PID: 265 Comm: kworker/u8:9 Tainted: G        W 3.18.31-g0a58eeb #1
 Hardware name: Qualcomm Technologies, Inc. MSM 8996pro v1.1 + PMI8996 Carbide (DT)
 Workqueue: events_unbound flush_to_ldisc
 task: ffffffc0ed610ec0 ti: ffffffc0ed624000 task.ti: ffffffc0ed624000
 PC is at ldsem_down_read_trylock+0x0/0x4c
 LR is at tty_ldisc_ref+0x24/0x4c
 pc : [<ffffff800851154c>] lr : [<ffffff800850f6c0>] pstate: 80400145
 sp : ffffffc0ed627cd0
 x29: ffffffc0ed627cd0 x28: 0000000000000000
 x27: ffffff8009e05000 x26: ffffffc0d382cfa0
 x25: 0000000000000000 x24: ffffff800a012f08
 x23: 0000000000000000 x22: ffffffc0703fbc88
 x21: 6b6b6b6b6b6b6b6b x20: 6b6b6b6b6b6b6b93
 x19: 0000000000000000 x18: 0000000000000001
 x17: 00e80000f80d6f53 x16: 0000000000000001
 x15: 0000007f7d826fff x14: 00000000000000a0
 x13: 0000000000000000 x12: 0000000000000109
 x11: 0000000000000000 x10: 0000000000000000
 x9 : ffffffc0ed624000 x8 : ffffffc0ed611580
 x7 : 0000000000000000 x6 : ffffff800a42e000
 x5 : 00000000000003fc x4 : 0000000003bd1201
 x3 : 0000000000000001 x2 : 0000000000000001
 x1 : ffffff800851004c x0 : 6b6b6b6b6b6b6b93

Signed-off-by: Sahara <keun-o.park@darkmatter.ae>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/tty_io.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1702,6 +1702,8 @@ static void release_tty(struct tty_struc
 	if (tty->link)
 		tty->link->port->itty = NULL;
 	tty_buffer_cancel_work(tty->port);
+	if (tty->link)
+		tty_buffer_cancel_work(tty->link->port);
 
 	tty_kref_put(tty->link);
 	tty_kref_put(tty);
