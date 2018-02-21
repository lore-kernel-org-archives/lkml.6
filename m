Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1474421-1519217198-5-10730512364540542344
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
    t=1519217198; b=BH7yk/xWKti+78Dldj0WbrkDMeII/WtIuGiR8k8H15waj04
    iAjPH4RToKYcN6bgdhQw3lo6QDhGKYxSE0AG5o5t2vlwDzEp91DozXCgn/rj0d0N
    Z4Rs7sLBmODBl1pkK+CagTm8ZHlALDi7U3enphbARISq/qfNXbQFqJqwOMyZzgo2
    aN+xNIoWNTpy6+AVNXf1H+zPioyUqhrEiuEwtN9+vxnDcolvEpfdxZMwUHVPPtTk
    M2GhtkZptNd7CMAJWt7KgxKVNYSzJZDSqZ49smvCEyDeCWL3xfVMyJd9VZznvBrU
    ywBlpIHX6xWoXK9lJ8K3gPItH+PUU9TDJ8Zw4mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519217198; bh=nzNqnKhQ9IrLzCaNwzq8AKBY5u
    AhgI6tv5Z7tc4VhkM=; b=BWpmZ1TIO3nSos54hV/KTbIcyNyZrG2XksEBq0VxuH
    za91nBaCVC5d84NpbzXQ8xQe+lArIYOvK2G+JN+4H9Ggk5/ibk6caMu9T6HEQOvo
    gsMzovVEu7rtNeeNB1apUdnxGf0gQZhwUXpogb0RFi/48jfxPea9H2zcgMObktxI
    2CmO4YPKZ0VZZaXY0ngs+pYHZFCvshjdMfUnz48qjbuUSKth6FseKvDycVDKIyjD
    G9OiOm9OZQhDm7W8uXwDZEw/rxzNkn1xKMGJh93xnsLBF3FSz7/yvENihMG6sUAf
    IQh58DDUHlZSq7+VgxvxYwHb9isbBV5L6818rAKD2DwQ==
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
        id S1754366AbeBUMqR (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 07:46:17 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:59356 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754362AbeBUMqO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 07:46:14 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 08/33] ALSA: seq: Fix regression by incorrect ioctl_mutex usages
Date: Wed, 21 Feb 2018 13:44:51 +0100
Message-Id: <20180221124410.117039630@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124409.564661689@linuxfoundation.org>
References: <20180221124409.564661689@linuxfoundation.org>
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
@@ -2196,7 +2196,6 @@ static int snd_seq_do_ioctl(struct snd_s
 			    void __user *arg)
 {
 	struct seq_ioctl_table *p;
-	int ret;
 
 	switch (cmd) {
 	case SNDRV_SEQ_IOCTL_PVERSION:
@@ -2210,12 +2209,8 @@ static int snd_seq_do_ioctl(struct snd_s
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
@@ -2226,11 +2221,15 @@ static int snd_seq_do_ioctl(struct snd_s
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
