Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3759000-1519415229-2-5163855850767836645
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
    t=1519415229; b=BiMai3H/6XkA2y+AYFswFLC8yS7xgxGBQbq5QsmuUar/EtI
    Aj2WuYLaa2tJRN4QgbP9v7tJPDU/EMuxbzfRrm9Ad0S4sn0ozeG+k5eMM38Hwmo+
    XOUbpeW0lhD4sTeYCyDhdk4hFBGwEUU/f1RaBncohN8rmzLYhtvUFTYpPam+WkYW
    O1Pr5wlL4s/ABYWsVILpdxoD6v/7ACD7VkORdVDinyyBnwSuwOJP+lfnmyLOGIWc
    Y2cX/iDhwhekZM4k7s+PSItvVFWkU91lK97z0gqRFpgDs/Z6azq2ZEf4xEKXZWcm
    l3YAAF3spSRByZxOOw2KAi/xdqjGY0EGjjjcgsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415229; bh=9nUFy09HcWepBy3Yag++gd+mhj
    luqvTmh2eo21IHtkg=; b=kCeUpwVdv6a0bjUPpo6amVfGLnM4Xncptm5/rqsXI8
    /Y3dAyocxEfD89+DNfbPKj1QAAzw5vC2Csgn5SFCZgNNFMaoz16VlIrFSOlsdMM+
    q4NRzWUpzg2DOOPTy0DhkYFHI5Cr4yNO8OaYmM7h5TaZl4RnYaxsqcX+xz/YryqH
    ZA1cOp/Z8Vk3omUgUqgZ21rTci7xlGczbgh5q85rDXk4J7HjeeEPjMIHW66WBobT
    bAm48rSI9EmcugLEpk+N146+Y4uh0cdHZASrSxyvqAKDWEjs6z3iW2EgCrFsrJ3U
    4VOQbsL+BmxeXI5E13HUNzlXzxV0wf7f5wIERiVDBkyQ==
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
        id S934199AbeBWSri (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:47:38 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44600 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933859AbeBWSrg (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:47:36 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 117/145] ALSA: hda/ca0132 - fix possible NULL pointer use
Date: Fri, 23 Feb 2018 19:27:03 +0100
Message-Id: <20180223170739.958889642@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

commit 46a049dae771b95e77ac6c823330f4a60f600236 upstream.

gcc-7 caught what it considers a NULL pointer dereference:

sound/pci/hda/patch_ca0132.c: In function 'dspio_scp.constprop':
sound/pci/hda/patch_ca0132.c:1487:4: error: argument 1 null where non-null expected [-Werror=nonnull]

This is plausible from looking at the function, as we compare 'reply'
to NULL earlier in it. I have not tried to analyze if there are constraints
that make it impossible to hit the bug, but adding another NULL check in
the end kills the warning and makes the function more robust.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_ca0132.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1482,6 +1482,9 @@ static int dspio_scp(struct hda_codec *c
 		} else if (ret_size != reply_data_size) {
 			codec_dbg(codec, "RetLen and HdrLen .NE.\n");
 			return -EINVAL;
+		} else if (!reply) {
+			codec_dbg(codec, "NULL reply\n");
+			return -EINVAL;
 		} else {
 			*reply_len = ret_size*sizeof(unsigned int);
 			memcpy(reply, scp_reply.data, *reply_len);
