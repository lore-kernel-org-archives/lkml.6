Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4119318-1520453136-2-15958639996190246825
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
    t=1520453135; b=GhliCoZYd9ueAmjly4Tp/+Om4nJcH+5+BlKxZz4dOHbVP0Y
    3Zj38u4g9HY04XV8226PrLWmyfMmB8bNtlWYl2CwDiYNRINTUYvEMabzHmuYHYJ5
    fzx7T3a6G8640/45rwCF2KVgMg69iuvHuPdQpTG5/TjgsdcUWvkUSsSlYKnpMZzt
    rpr569R2IeqoA6gd93gUW5aUsOxXx1F9UZJZp70pdH0KBpPSZy9ZxgZeF+RF1USt
    RGQ5axLb5TEIuFP8HTWAmC5y/VgtXk5SVhrtTpSlqdlaifQYFg1vdQjedWcC5M7d
    OaP6eAzW12UTV97Ics2KEsOxHcGwCjA/i7C8ONw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520453135; bh=BnPHZLLLv88ydTdHEl8KcyDzSS
    6/0O8Aye3q2BepLpE=; b=nX0LcFonympU7UHIZ7rvq2HCVdtzYj+aqWAkuXEGXD
    N+/fm/XYjekZjjwTF+0wEYMW29oWevxLxS9+OdMmHKK1LaK4nSPLIVkFLa4Exg78
    62eQwe0cRJqpHiyl1UmVBCw1Q8VLpH/BaCq8w23PV7S2uaXv/BsdiooSVHEC+/iW
    DAaO3co0CvVO4GTwvUvInOHNLDp3iFN7aSLpuRW2cxOzST9ssHQdkAEnwCc4h0hq
    le+D5GwfuuR36inYvMranHfyHMU1YHF49SLeJ5LXqqoKyoWFvLUfLmaA8zX+2niW
    2S/+hoESPbSQSrjH8ber83d+jynFlGxNkYOhq+TUzqHg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
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
        id S935123AbeCGUFQ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 15:05:16 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44524 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965497AbeCGTqP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:46:15 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Neeraj Upadhyay <neeraju@codeaurora.org>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 4.14 020/110] timers: Forward timer base before migrating timers
Date: Wed,  7 Mar 2018 11:38:03 -0800
Message-Id: <20180307191042.304975597@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
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

From: Lingutla Chandrasekhar <clingutla@codeaurora.org>

commit c52232a49e203a65a6e1a670cd5262f59e9364a0 upstream.

On CPU hotunplug the enqueued timers of the unplugged CPU are migrated to a
live CPU. This happens from the control thread which initiated the unplug.

If the CPU on which the control thread runs came out from a longer idle
period then the base clock of that CPU might be stale because the control
thread runs prior to any event which forwards the clock.

In such a case the timers from the unplugged CPU are queued on the live CPU
based on the stale clock which can cause large delays due to increased
granularity of the outer timer wheels which are far away from base:;clock.

But there is a worse problem than that. The following sequence of events
illustrates it:

 - CPU0 timer1 is queued expires = 59969 and base->clk = 59131.

   The timer is queued at wheel level 2, with resulting expiry time = 60032
   (due to level granularity).

 - CPU1 enters idle @60007, with next timer expiry @60020.

 - CPU0 is hotplugged at @60009

 - CPU1 exits idle and runs the control thread which migrates the
   timers from CPU0

   timer1 is now queued in level 0 for immediate handling in the next
   softirq because the requested expiry time 59969 is before CPU1 base->clk
   60007

 - CPU1 runs code which forwards the base clock which succeeds because the
   next expiring timer. which was collected at idle entry time is still set
   to 60020.

   So it forwards beyond 60007 and therefore misses to expire the migrated
   timer1. That timer gets expired when the wheel wraps around again, which
   takes between 63 and 630ms depending on the HZ setting.

Address both problems by invoking forward_timer_base() for the control CPUs
timer base. All other places, which might run into a similar problem
(mod_timer()/add_timer_on()) already invoke forward_timer_base() to avoid
that.

[ tglx: Massaged comment and changelog ]

Fixes: a683f390b93f ("timers: Forward the wheel clock whenever possible")
Co-developed-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: linux-arm-msm@vger.kernel.org
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180118115022.6368-1-clingutla@codeaurora.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/time/timer.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1834,6 +1834,12 @@ int timers_dead_cpu(unsigned int cpu)
 		raw_spin_lock_irq(&new_base->lock);
 		raw_spin_lock_nested(&old_base->lock, SINGLE_DEPTH_NESTING);
 
+		/*
+		 * The current CPUs base clock might be stale. Update it
+		 * before moving the timers over.
+		 */
+		forward_timer_base(new_base);
+
 		BUG_ON(old_base->running_timer);
 
 		for (i = 0; i < WHEEL_SIZE; i++)
