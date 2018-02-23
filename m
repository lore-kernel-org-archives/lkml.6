Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3841677-1519418911-2-7725450865298831980
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
    t=1519418911; b=cbC+HzAxrd07VsejmDDmTwHL0dS2z35Q3GV8V6TvR7aiLSE
    +ppWBk8duN7QIJjlkXzPGHpIcnwgVShEiurFlyK8OpbeUL1js0T+raRH27h0ax5R
    ZRJck8FSZxajQd/an6/PvPvAVQ7HTc7KcaNebyt6HqSavp+zVyUE0cEl5/m+VL2d
    lbweX7a0vVnBHFPcv1v5ihnAPSgqntFFiVBq/yHeLXGqFbW1xKmfJm+DsfFcp6Yi
    YmyKv5IgiemTcDzDB7SxS+FCrnuz1l9tPC0rZSl0KK5x42yAVdgnJVB/PIz5E8zr
    7qs3L861CN2ARl3Ij3DLEIPTXKKm/slLmZoYf0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519418911; bh=WjGjN5JAETBpWvqeP/BN6ADbAa
    rM4WfK4+7AdzemqIY=; b=mcZn2tDPGQOGUU1PYB63yldA0NQOwyyvTcY7lsL8yR
    1UirJyKDxu+10PQ2loTIop3zkZIpqjtVapGJ0oaIIHIughSFsq8YX2wrwMR/91O6
    Lxz5amkdUi0wbIbVKX6B/UGfDqFD1E0N71FaY55lc/FjxYm6J3f3Y5trZ4hblKJO
    Pk2J6KOTPcO1/tQgjuRIpEdSu0I7sIdgujVhmxwM94Gxpnw8fSvNzS9ZChMQJ5VZ
    SWtg3PFhlzM78iIDTWimDEUoYszDlrPeDaz5F3C8oBIMzeA20KT6pfOqxfmiY+zu
    dbjRsUicS+rAc22O0zIQ9Pe/vqdo/qwOp9lNnPWIIuBw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbeBWSbs (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:31:48 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35356 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752656AbeBWSbq (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:31:46 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 3.18 09/58] ext4: save error to disk in __ext4_grp_locked_error()
Date: Fri, 23 Feb 2018 19:26:08 +0100
Message-Id: <20180223170208.172906318@linuxfoundation.org>
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

From: Zhouyi Zhou <zhouzhouyi@gmail.com>

commit 06f29cc81f0350261f59643a505010531130eea0 upstream.

In the function __ext4_grp_locked_error(), __save_error_info()
is called to save error info in super block block, but does not sync
that information to disk to info the subsequence fsck after reboot.

This patch writes the error information to disk.  After this patch,
I think there is no obvious EXT4 error handle branches which leads to
"Remounting filesystem read-only" will leave the disk partition miss
the subsequence fsck.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/super.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -677,6 +677,7 @@ __acquires(bitlock)
 	}
 
 	ext4_unlock_group(sb, grp);
+	ext4_commit_super(sb, 1);
 	ext4_handle_error(sb);
 	/*
 	 * We only get here in the ERRORS_RO case; relocking the group
