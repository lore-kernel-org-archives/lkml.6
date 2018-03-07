Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4025272-1520451922-2-8777243970568794787
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
    t=1520451921; b=WvqVodNWNBkYhtKyB/a4ESZTYNbIeKOJOD2jAkuFrRhwUi4
    0KlPT5dKnkgQbyWZiZO0ob3SCHMlXjL4CWoijH2IizwztAjB1bKRkiBsClOEwaSE
    KtnwAWYSDQnhRrsYQIoOte88URwcDvc2Z2YHxLJ1qHmCWkquwlOVQ1HUAVT+36VB
    K9iSK3jkgN+ZRuU35uxnMem8idlND4uYUzLFZIpcxsLcmqi9Zp8kG3AJV06MvWsr
    GNCNNFLklkbzYi1Ldj4p/Z71fC3RP5H50TTGkj32Y/0Z5+azBSrEqyFK2xLGnxKT
    1B3ks+WYp79Q0uir19EALbcy8kNqV12j5CDfVpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520451921; bh=ZnjTY1egsd/wBOwtJ5DTjXi7fQ
    qr8/1P9Txn/JzwGgk=; b=pJyHYu5lXp15G5ahQOltVfAxG+MEWlyFsOmtmazq1y
    RRdabxXkorT62zaMpLnGA39MLOa/FWkFHIYLbwi9Q1IaByledMcbBCvRr988nTEd
    5m/+pv+Y+/G98AVQjzCZnVOuqbtrNUk6IWZsXA/7e6DIr/0ZgRI8V41mogUZoxLq
    I/5qkfIufCfrOIHMinVJkNprVR4y199woL4zzlZg06onaD+yvjJn2Xulx/+MqtuL
    HA620B3b+Vym8R+jIoDdoBLc+N+oQBL97fCfvytvxOy7YZO6u6ZVIZ+XjxTpZyLp
    eLXw8jPAIwSnnfreDivsclrXzd+24LzEgPQ/03m+xOcQ==
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
        id S965182AbeCGTpR (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:45:17 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44118 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965284AbeCGTpP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:45:15 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gerd Rausch <gerd.rausch@oracle.com>,
        Jane Chu <jane.chu@oracle.com>,
        Haozhong Zhang <haozhong.zhang@intel.com>,
        Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.14 029/110] dax: fix vma_is_fsdax() helper
Date: Wed,  7 Mar 2018 11:38:12 -0800
Message-Id: <20180307191043.476088385@linuxfoundation.org>
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

From: Dan Williams <dan.j.williams@intel.com>

commit 230f5a8969d8345fc9bbe3683f068246cf1be4b8 upstream.

Gerd reports that ->i_mode may contain other bits besides S_IFCHR. Use
S_ISCHR() instead. Otherwise, get_user_pages_longterm() may fail on
device-dax instances when those are meant to be explicitly allowed.

Fixes: 2bb6d2837083 ("mm: introduce get_user_pages_longterm")
Cc: <stable@vger.kernel.org>
Reported-by: Gerd Rausch <gerd.rausch@oracle.com>
Acked-by: Jane Chu <jane.chu@oracle.com>
Reported-by: Haozhong Zhang <haozhong.zhang@intel.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/fs.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3185,7 +3185,7 @@ static inline bool vma_is_fsdax(struct v
 	if (!vma_is_dax(vma))
 		return false;
 	inode = file_inode(vma->vm_file);
-	if (inode->i_mode == S_IFCHR)
+	if (S_ISCHR(inode->i_mode))
 		return false; /* device-dax */
 	return true;
 }
