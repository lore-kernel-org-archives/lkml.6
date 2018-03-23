Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1092440-1521804151-2-7188771753612459700
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
    t=1521804151; b=tGALKhzUgTkkaeqsZpCiQ5vymR1ee6PvaidyTH3X1A43y9w
    1dJZhc1vpl4Mc7KV75a0Mo6givNZ1FZjYyjeOh+uvmc4JgzZoKvcDyqze1DOmyMD
    HxioPUSA1MAmkVgW7KcEC+yoceIQYfUAMIiPcELdxGD55/5ASdexM1lrVfATJq7k
    eQNUudmdoJ2yz4sNdKDaKdNoW6c5/sWetPtWRIlUS7AtalAJqunHhbUIfcWIOVZe
    MQAPH6pRHr5G8RAJJ//gCmuoO+BClIvZuH0aEE26WGPL+2Vns4CgNMWPOHbS3oab
    Ii2RSU0qSZ+foS26c1Ocz5gxDL6WURRw42NrKhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804151; bh=GhlKFbStUJGSnWQ28bYzHLRPp0
    zXOnE+MsANvr+XZ0Y=; b=Sfl9yAdMqrKDzwLxuc+U9DeJlsvdIS6izwBg746Kv8
    ttssFJFicmfyZwWcMNfDDJEWurDzo8cEA3g1slNfW6PFnhh3tkpm+qPu0cIQRw/c
    Xq/0y3A668lXn6GpC5lR/sGUeJKaRUNWJH4g5EXJ+CswhZ8yPDfl/9jVtn9M8d/Z
    Q5O0dPBPtXchA1nxWJIrXVje/hRxCfrtKpeOtJmE4VmPu/NYxC54UwaMmbTWyfLE
    1njmJSz0zJl9eql/2BcnYAVK3P+2+0wLIfIqaWAnsZXq0FNtNxjRvW58vNMH0D65
    xnVkhKSqUuwAI63MgHTegvR9n8ckT2F7VTA37Gwnj6HA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
        id S1755023AbeCWKIP (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:08:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41594 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755500AbeCWKIN (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:08:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 078/177] Btrfs: fix extent map leak during fallocate error path
Date: Fri, 23 Mar 2018 10:53:26 +0100
Message-Id: <20180323094208.752768865@linuxfoundation.org>
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

From: Filipe Manana <fdmanana@suse.com>


[ Upstream commit be2d253cc98244765323a7c94cc1ac5cd5a17072 ]

If the call to btrfs_qgroup_reserve_data() failed, we were leaking an
extent map structure. The failure can happen either due to an -ENOMEM
condition or, when quotas are enabled, due to -EDQUOT for example.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/file.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2817,8 +2817,10 @@ static long btrfs_fallocate(struct file
 			}
 			ret = btrfs_qgroup_reserve_data(inode, cur_offset,
 					last_byte - cur_offset);
-			if (ret < 0)
+			if (ret < 0) {
+				free_extent_map(em);
 				break;
+			}
 		} else {
 			/*
 			 * Do not need to reserve unwritten extent for this
