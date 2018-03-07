Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4119318-1520453117-2-3317529231368964528
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
    t=1520453117; b=fSue3xgjuk86yGmWq5tgoa0ntntQjhF4L8YgzSxeqlCRP/P
    ESXAEA9tcVgggeekDjAfNOsokD7EXdEdjVbuUEKxjqfR2RSrew60i8h80locUju+
    e5LRWc67A9ZEqwDteIl2PYpb10ot2HkgcIasNXvxjWCpeP2vmk9M1zd21VWFiCNj
    mZRBRk9GcrQOAJ/ourYGMGfYi5vtVWJB2vAg/6+OeUKBP0voIVjRNhgtrK4S8nD7
    C9Fuc1Dudt/l4WeFNlyP/cFcRvYD/rQLvBd2otQ9cspIYpAZBdxk8J0sWW/ztASq
    9TSXdJPK/jnZtjHxbsneV0Vna+6ZvT9uT7YKvWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520453117; bh=l3yor8ElAUnYnsC+LzEseIhyMT
    5DRsKnRORZm6nAChc=; b=lOJZnBgNi150KVRAKwa3cXa5lEjVnCGkNmJUBSbZQ9
    6cXXxfPOHD9dsvGsp3ZP2CT8GqfSw+eSCnlpTK01Nj7o1zH1lT3rVU2EytCYoF9s
    wHildyOGe34aCHuz87p5uizNRPOtBCEJ+rX13Rc77ABkXKY4gB21sQu9Y8OcMKr4
    3XtPSSDFc+Ivlg55ystvJz3dxqurTo3lJXmjpTWAb/Usf6A0VmWZr/p4p4FZxEPl
    /mrPMsFEd378FiM5eN7HAemjGk0CEN/8DWCpZktunBBf6a0IOSYdHPd2pPscHqUy
    lkcr9AKBgIkkXWbmt6rwYjkAju10IKq6VKir2o++e0qA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
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
        id S965504AbeCGTqS (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:46:18 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44528 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965465AbeCGTqR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:46:17 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 011/110] ALSA: control: Fix memory corruption risk in snd_ctl_elem_read
Date: Wed,  7 Mar 2018 11:37:54 -0800
Message-Id: <20180307191041.187154835@linuxfoundation.org>
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

From: Richard Fitzgerald <rf@opensource.cirrus.com>

commit 5a23699a39abc5328921a81b89383d088f6ba9cc upstream.

The patch "ALSA: control: code refactoring for ELEM_READ/ELEM_WRITE
operations" introduced a potential for kernel memory corruption due
to an incorrect if statement allowing non-readable controls to fall
through and call the get function. For TLV controls a driver can omit
SNDRV_CTL_ELEM_ACCESS_READ to ensure that only the TLV get function
can be called. Instead the normal get() can be invoked unexpectedly
and as the driver expects that this will only be called for controls
<= 512 bytes, potentially try to copy >512 bytes into the 512 byte
return array, so corrupting kernel memory.

The problem is an attempt to refactor the snd_ctl_elem_read function
to invert the logic so that it conditionally aborted if the control
is unreadable instead of conditionally executing. But the if statement
wasn't inverted correctly.

The correct inversion of

    if (a && !b)

is
    if (!a || b)

Fixes: becf9e5d553c2 ("ALSA: control: code refactoring for ELEM_READ/ELEM_WRITE operations")
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/control.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -888,7 +888,7 @@ static int snd_ctl_elem_read(struct snd_
 
 	index_offset = snd_ctl_get_ioff(kctl, &control->id);
 	vd = &kctl->vd[index_offset];
-	if (!(vd->access & SNDRV_CTL_ELEM_ACCESS_READ) && kctl->get == NULL)
+	if (!(vd->access & SNDRV_CTL_ELEM_ACCESS_READ) || kctl->get == NULL)
 		return -EPERM;
 
 	snd_ctl_build_ioff(&control->id, kctl, index_offset);
