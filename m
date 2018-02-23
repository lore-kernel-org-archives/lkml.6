Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3704313-1519414327-2-2220707558894778378
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
    t=1519414326; b=VEiECHNuuNH1xy7BrwxHXnv0X0aMaS0HttXcCD3dAHnoZ1U
    oWX3wspsD0qsSzksWwmAFomlCg3wkN+MQBX8G5q1KMjaWUvYdzEBmUR8rwzHRvWm
    J6hgIfEppUaJGdUN5u7CdINvPMrm5w1fO3MczeJrABaXQlLcrlsQ0eHR9LQZ8vlO
    /fHXHW8B+1cc/8v1Lq/yL5nLz3LjxZHWGudaCM+qIWp9ww9NXLR8BTZ/oQUWnBGm
    Pz3pEmRK3LeULmjbutBMAmqwuI+L9FSMPt8nVeGVN89S18tR0bQp1Tzh4BbqLda+
    D0OPS1ZGD94aEXVZrvwEf5M3bxgxsy33UJ4gWAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414326; bh=lyypm2p/KVnq5JoQpfNBWNghNG
    z2CTDPrlj0xlXY8uo=; b=LxKs4E/2pltofqNaggdGQc0R4oDgjxXfwzbDgPEOaJ
    cxygRhnnIQxmLkqgQhm3aaai/1ir4d4ct/vO8nxt+ANKHmU5TnpsDb05L0E+eV/d
    nShUwspiaulbDpqTKlJDdovyr6FrNsbdysPYhiXQ0iBIkDVoLI3/y7af/yga7CN1
    CbdJOT32V+Iq05eIyJLFR9Z5UfDPFrRmZEG9u0wIy19+bO25hQ0US9RTGhmrLuKk
    1YPZMh1cDCk64ZhcBwBiSzBPv8S+yCTWhn5Vuik0KzwYtoTYLXLUd5OfoXvKqv8g
    neUA2X2mJQmaMbg1UBeLa05/A4LFPAN+5kZKzrltFbEQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754743AbeBWTbu (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:31:50 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46024 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934954AbeBWSv0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:51:26 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+a2a3c4909716e271487e@syzkaller.appspotmail.com,
        Martijn Coenen <maco@android.com>
Subject: [PATCH 4.14 051/159] ANDROID: binder: synchronize_rcu() when using POLLFREE.
Date: Fri, 23 Feb 2018 19:25:59 +0100
Message-Id: <20180223170749.735086588@linuxfoundation.org>
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

From: Martijn Coenen <maco@android.com>

commit 5eeb2ca02a2f6084fc57ae5c244a38baab07033a upstream.

To prevent races with ep_remove_waitqueue() removing the
waitqueue at the same time.

Reported-by: syzbot+a2a3c4909716e271487e@syzkaller.appspotmail.com
Signed-off-by: Martijn Coenen <maco@android.com>
Cc: stable <stable@vger.kernel.org> # 4.14+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/android/binder.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -4322,6 +4322,15 @@ static int binder_thread_release(struct
 
 	binder_inner_proc_unlock(thread->proc);
 
+	/*
+	 * This is needed to avoid races between wake_up_poll() above and
+	 * and ep_remove_waitqueue() called for other reasons (eg the epoll file
+	 * descriptor being closed); ep_remove_waitqueue() holds an RCU read
+	 * lock, so we can be sure it's done after calling synchronize_rcu().
+	 */
+	if (thread->looper & BINDER_LOOPER_STATE_POLL)
+		synchronize_rcu();
+
 	if (send_reply)
 		binder_send_failed_reply(send_reply, BR_DEAD_REPLY);
 	binder_release_work(proc, &thread->todo);
