Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2848808-1517590797-2-15374587629381013286
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
    t=1517590795; b=hICW1BxIAQhAV0COE7NRNCDEyauWOMgUNGlzLUkaJKK+r0i
    z5XAcJkn47YPSKtmw3J9YTppcwJDhQCa5y5uDhbwMJ2C3d61D1ucjbiZNIkmHmZa
    hhJ+oVcaR1un3u8YuwK+h7cRY9WzJx4pgx7183d+TnvlSUC3kU/SIDBDBxWT8oMm
    WTeQTrx0i7/Cw5XGZj0yGunbPT1Fbd7+6NOV3YbHEnZXKBDdzww2Z4TGRgfR3bF8
    N6zuVyxb72WEsaZO/TCCHMytZn/yB0WGaUEHjiYPP70bAmAfxOrfyFL5MTBP0JyS
    11cyfL8H1b4X6aPZAgGp5fmcXv3qmKAKz25m0qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517590795; bh=hLl0kcmq+bNvjGOXJM7sTSoAQk
    TCuhbbnADjOh+9qcc=; b=kfaqcpDjOCF4X4lo1imrC15k5IKgih0RvDZPuplUEj
    eW6Tm7FN1wS0LnW2HLo1beiucNZsiYBUKCcSCOjrRRdlBFfYRjixV4ww/SN64bh0
    BBNDkqkhd07e1Npc4WnNss93WN9TzxlkDOMfRx6gm0TRlvNt4vT1WueY/GTZ/sts
    MANi5w15GmIhtrTRXngXP1NtBfYDXselitDUt+NwIoGRpvQBzrmefu4oxtNN1P7V
    14Upr6nI9/wn2XmvrgT/5qcN+miEjFrnGKt8I46Cf3ER8D5Hm+hEf0CcGNIpRgR+
    xf+oY0cz799nOyc2/RDqL5uwMlk2aHme2iT4Xh45A6gw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752523AbeBBQ7x (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 11:59:53 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34518 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752518AbeBBQ7p (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 11:59:45 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luo Quan <a4651386@163.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 13/67] ALSA: seq: Make ioctls race-free
Date: Fri,  2 Feb 2018 17:57:42 +0100
Message-Id: <20180202140816.773212940@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit b3defb791b26ea0683a93a4f49c77ec45ec96f10 upstream.

The ALSA sequencer ioctls have no protection against racy calls while
the concurrent operations may lead to interfere with each other.  As
reported recently, for example, the concurrent calls of setting client
pool with a combination of write calls may lead to either the
unkillable dead-lock or UAF.

As a slightly big hammer solution, this patch introduces the mutex to
make each ioctl exclusive.  Although this may reduce performance via
parallel ioctl calls, usually it's not demanded for sequencer usages,
hence it should be negligible.

Reported-by: Luo Quan <a4651386@163.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[bwh: Backported to 4.4: ioctl dispatch is done from snd_seq_do_ioctl();
 take the mutex and add ret variable there.]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/seq/seq_clientmgr.c |   10 ++++++++--
 sound/core/seq/seq_clientmgr.h |    1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -236,6 +236,7 @@ static struct snd_seq_client *seq_create
 	rwlock_init(&client->ports_lock);
 	mutex_init(&client->ports_mutex);
 	INIT_LIST_HEAD(&client->ports_list_head);
+	mutex_init(&client->ioctl_mutex);
 
 	/* find free slot in the client table */
 	spin_lock_irqsave(&clients_lock, flags);
@@ -2195,6 +2196,7 @@ static int snd_seq_do_ioctl(struct snd_s
 			    void __user *arg)
 {
 	struct seq_ioctl_table *p;
+	int ret;
 
 	switch (cmd) {
 	case SNDRV_SEQ_IOCTL_PVERSION:
@@ -2208,8 +2210,12 @@ static int snd_seq_do_ioctl(struct snd_s
 	if (! arg)
 		return -EFAULT;
 	for (p = ioctl_tables; p->cmd; p++) {
-		if (p->cmd == cmd)
-			return p->func(client, arg);
+		if (p->cmd == cmd) {
+			mutex_lock(&client->ioctl_mutex);
+			ret = p->func(client, arg);
+			mutex_unlock(&client->ioctl_mutex);
+			return ret;
+		}
 	}
 	pr_debug("ALSA: seq unknown ioctl() 0x%x (type='%c', number=0x%02x)\n",
 		   cmd, _IOC_TYPE(cmd), _IOC_NR(cmd));
--- a/sound/core/seq/seq_clientmgr.h
+++ b/sound/core/seq/seq_clientmgr.h
@@ -59,6 +59,7 @@ struct snd_seq_client {
 	struct list_head ports_list_head;
 	rwlock_t ports_lock;
 	struct mutex ports_mutex;
+	struct mutex ioctl_mutex;
 	int convert32;		/* convert 32->64bit */
 
 	/* output pool */
