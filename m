Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3559911-1519410709-2-16244992049654727347
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
    t=1519410708; b=pu4SjZR07LuCk6zWWVRpgSm1IJF3ubz54l0nwv1oFwVObie
    v0n+c9CzWXMP5eZqGcZyaZ857RomHtuIH+IIWokCX3QLgHm8nqFBi492JgpkqRlk
    fnxgEVTD/X62FtT2arJD+sHLAF2TWcq+dQfS3ITocxpm1p3cEeMVGWfnjSgWmYbA
    /rfeMnR1W8+lH76q+SxaxQ4OS2631pEuSc7nBOIJZ6x5ypbXBueIc636CGRbY2zw
    HTb+ZI/zE+KCvfqSPk32KpkkUxftzsVQG3QMfLnGr6CRvPqwrnNRUnZUNFxwCXMB
    OM14nfFWoeHpjei+ALthr4uvYk0CNhOfi3Xqm4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519410708; bh=CGhLFpYDTGC3XZlFKVEOcx8JrD
    UCLFEJPopof+mU6js=; b=CTpNet1d1+KhvS0Q3p9Nur1bWQRdOV/+6sWc7TIY7Z
    O5nqN8YVgpxdcxFAy9KoaJkutkUzjfjFHA5jQcBKhlvbZSnukJIBDjzqL9my9BGC
    GDkdlm5PV/2qKz76Dq4SYt4ZwD36VLBm0+0i2Eh9wI99Fsus2xPCz2++8L6nYKP2
    k3kWlm88dKLqN8IRGOdCmYJ12HSdoVH4FyVBelDXVqBkuVc5HSRwofYoET5MtUzM
    rnGYHj1AFc2sI4YYPikpRpc3j2Y7R3XWTB0wpZL/Jpe3Sr83oYyMOBFe3HiD7ZYb
    knQi+7gcH9xdYUb3kv+HkXk922jhvAljKNkM9mW3UV1Q==
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
        id S1751623AbeBWSbp (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:31:45 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35324 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752597AbeBWSbk (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:31:40 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3.18 07/58] ALSA: seq: Fix regression by incorrect ioctl_mutex usages
Date: Fri, 23 Feb 2018 19:26:06 +0100
Message-Id: <20180223170207.806265170@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170206.724655284@linuxfoundation.org>
References: <20180223170206.724655284@linuxfoundation.org>
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

From: Takashi Iwai <tiwai@suse.de>

This is the revised backport of the upstream commit
b3defb791b26ea0683a93a4f49c77ec45ec96f10

We had another backport (e.g. 623e5c8ae32b in 4.4.115), but it applies
the new mutex also to the code paths that are invoked via faked
kernel-to-kernel ioctls.  As reported recently, this leads to a
deadlock at suspend (or other scenarios triggering the kernel
sequencer client).

This patch addresses the issue by taking the mutex only in the code
paths invoked by user-space, just like the original fix patch does.

Reported-and-tested-by: Andres Bertens <abertensu@yahoo.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

Tagged as 4.4.x, but should be applied to other older kernels, too.

 sound/core/seq/seq_clientmgr.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -2201,7 +2201,6 @@ static int snd_seq_do_ioctl(struct snd_s
 			    void __user *arg)
 {
 	struct seq_ioctl_table *p;
-	int ret;
 
 	switch (cmd) {
 	case SNDRV_SEQ_IOCTL_PVERSION:
@@ -2215,12 +2214,8 @@ static int snd_seq_do_ioctl(struct snd_s
 	if (! arg)
 		return -EFAULT;
 	for (p = ioctl_tables; p->cmd; p++) {
-		if (p->cmd == cmd) {
-			mutex_lock(&client->ioctl_mutex);
-			ret = p->func(client, arg);
-			mutex_unlock(&client->ioctl_mutex);
-			return ret;
-		}
+		if (p->cmd == cmd)
+			return p->func(client, arg);
 	}
 	pr_debug("ALSA: seq unknown ioctl() 0x%x (type='%c', number=0x%02x)\n",
 		   cmd, _IOC_TYPE(cmd), _IOC_NR(cmd));
@@ -2231,11 +2226,15 @@ static int snd_seq_do_ioctl(struct snd_s
 static long snd_seq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct snd_seq_client *client = file->private_data;
+	long ret;
 
 	if (snd_BUG_ON(!client))
 		return -ENXIO;
 		
-	return snd_seq_do_ioctl(client, cmd, (void __user *) arg);
+	mutex_lock(&client->ioctl_mutex);
+	ret = snd_seq_do_ioctl(client, cmd, (void __user *) arg);
+	mutex_unlock(&client->ioctl_mutex);
+	return ret;
 }
 
 #ifdef CONFIG_COMPAT
