Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3278546-1521213827-2-14448122666313269330
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES daenro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521213824; b=t33dYLUKpY+wroblf0/6zoKC9CSKcCp0MGAkexnizfpNTU9
    6MgqGeDnaiPBIGEQxeumaQwjvMRgFxzBhIFHUY7goc0tQ5TprdnK1iDO32DTxMmN
    h7uNF/L7I/aj1FGeVQrJsbI1GtLnBcGuHVnDEW2Hr+U92jTYLGGFaS3FksyBNlBe
    HNs6lN/Xt/Usp850WqM9VDXkouERmOpls5Fs3BwShIGRnwU+01jyh9yuLVL5QFNa
    IuK+itHmARj0oR/W588do82HOC/FbU3dk9pruRAXpW3Tu4N8RrRqgVPQaqUAgfJ9
    6ssQgS82uq0GE9DEGVm/lYkNw/hvChLbZg9Np1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521213824; bh=+SLB8K5LVsc/UB/ByJS3uR8lSw
    DeBBcVc/hzr2hm4MA=; b=TopnZVrWiXgnNtp+HAeL4aBM+RWmDE6loDQAI1D8j4
    fOgjeiF/Ej4qrl4yEmXAPWFhOeYjV2u+F46JshuF+fkKeB0BQ8xxBbXBLxBx2Q2I
    o8l6uZzDlT+Xk2eAIogG2hTdBzx0EDD/lTmtkhUa/5VSws8as9tBXDfLLPxsBIak
    gRLTYP9R8S1hifClgmgQ1qp02Y4OYEiTN8IG81cF0VxbXijTbYs5FurNforXMy7x
    xt7+Ig+McVAIuLb5rNAgxnz6Xmz8E5ebmAxjoTTFZWEKu6T4Ef7m9c8XjvFR5Tb5
    YRypOhIKQZlEjtTHjjAQg/MZ1wnM/+8VLCjiPi7BOvRw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753370AbeCPPXl (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:23:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33202 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbeCPPXj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:23:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+10c98dc5725c6c8fc7fb@syzkaller.appspotmail.com,
        Paolo Abeni <pabeni@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 3.18 07/25] netfilter: x_tables: fix missing timer initialization in xt_LED
Date: Fri, 16 Mar 2018 16:22:54 +0100
Message-Id: <20180316152233.055998263@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152232.750180431@linuxfoundation.org>
References: <20180316152232.750180431@linuxfoundation.org>
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

From: Paolo Abeni <pabeni@redhat.com>

commit 10414014bc085aac9f787a5890b33b5605fbcfc4 upstream.

syzbot reported that xt_LED may try to use the ledinternal->timer
without previously initializing it:

------------[ cut here ]------------
kernel BUG at kernel/time/timer.c:958!
invalid opcode: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 1 PID: 1826 Comm: kworker/1:2 Not tainted 4.15.0+ #306
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
Google 01/01/2011
Workqueue: ipv6_addrconf addrconf_dad_work
RIP: 0010:__mod_timer kernel/time/timer.c:958 [inline]
RIP: 0010:mod_timer+0x7d6/0x13c0 kernel/time/timer.c:1102
RSP: 0018:ffff8801d24fe9f8 EFLAGS: 00010293
RAX: ffff8801d25246c0 RBX: ffff8801aec6cb50 RCX: ffffffff816052c6
RDX: 0000000000000000 RSI: 00000000fffbd14b RDI: ffff8801aec6cb68
RBP: ffff8801d24fec98 R08: 0000000000000000 R09: 1ffff1003a49fd6c
R10: ffff8801d24feb28 R11: 0000000000000005 R12: dffffc0000000000
R13: ffff8801d24fec70 R14: 00000000fffbd14b R15: ffff8801af608f90
FS:  0000000000000000(0000) GS:ffff8801db500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000206d6fd0 CR3: 0000000006a22001 CR4: 00000000001606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  led_tg+0x1db/0x2e0 net/netfilter/xt_LED.c:75
  ip6t_do_table+0xc2a/0x1a30 net/ipv6/netfilter/ip6_tables.c:365
  ip6table_raw_hook+0x65/0x80 net/ipv6/netfilter/ip6table_raw.c:42
  nf_hook_entry_hookfn include/linux/netfilter.h:120 [inline]
  nf_hook_slow+0xba/0x1a0 net/netfilter/core.c:483
  nf_hook.constprop.27+0x3f6/0x830 include/linux/netfilter.h:243
  NF_HOOK include/linux/netfilter.h:286 [inline]
  ndisc_send_skb+0xa51/0x1370 net/ipv6/ndisc.c:491
  ndisc_send_ns+0x38a/0x870 net/ipv6/ndisc.c:633
  addrconf_dad_work+0xb9e/0x1320 net/ipv6/addrconf.c:4008
  process_one_work+0xbbf/0x1af0 kernel/workqueue.c:2113
  worker_thread+0x223/0x1990 kernel/workqueue.c:2247
  kthread+0x33c/0x400 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:429
Code: 85 2a 0b 00 00 4d 8b 3c 24 4d 85 ff 75 9f 4c 8b bd 60 fd ff ff e8 bb
57 10 00 65 ff 0d 94 9a a1 7e e9 d9 fc ff ff e8 aa 57 10 00 <0f> 0b e8 a3
57 10 00 e9 14 fb ff ff e8 99 57 10 00 4c 89 bd 70
RIP: __mod_timer kernel/time/timer.c:958 [inline] RSP: ffff8801d24fe9f8
RIP: mod_timer+0x7d6/0x13c0 kernel/time/timer.c:1102 RSP: ffff8801d24fe9f8
---[ end trace f661ab06f5dd8b3d ]---

The ledinternal struct can be shared between several different
xt_LED targets, but the related timer is currently initialized only
if the first target requires it. Fix it by unconditionally
initializing the timer struct.

v1 -> v2: call del_timer_sync() unconditionally, too.

Fixes: 268cb38e1802 ("netfilter: x_tables: add LED trigger target")
Reported-by: syzbot+10c98dc5725c6c8fc7fb@syzkaller.appspotmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/xt_LED.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/net/netfilter/xt_LED.c
+++ b/net/netfilter/xt_LED.c
@@ -141,10 +141,11 @@ static int led_tg_check(const struct xt_
 		goto exit_alloc;
 	}
 
-	/* See if we need to set up a timer */
-	if (ledinfo->delay > 0)
-		setup_timer(&ledinternal->timer, led_timeout_callback,
-			    (unsigned long)ledinternal);
+	/* Since the letinternal timer can be shared between multiple targets,
+	 * always set it up, even if the current target does not need it
+	 */
+	setup_timer(&ledinternal->timer, led_timeout_callback,
+		    (unsigned long)ledinternal);
 
 	list_add_tail(&ledinternal->list, &xt_led_triggers);
 
@@ -181,8 +182,7 @@ static void led_tg_destroy(const struct
 
 	list_del(&ledinternal->list);
 
-	if (ledinfo->delay > 0)
-		del_timer_sync(&ledinternal->timer);
+	del_timer_sync(&ledinternal->timer);
 
 	led_trigger_unregister(&ledinternal->netfilter_led_trigger);
 
