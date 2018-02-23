Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2089732-1519370923-2-15157733051546648206
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519370923; b=tifz781o9EdybRreI/zYK5ePdChZafDVryhPzwaB+UO2IL9
    PVYYyQTb+629IAeaAE77vMZZR3mLZonOAGnf6207ZutU6dVDA3pYacukogQjYcdv
    eE70sb1eWGhNZtFbYk2orI3/4ykAm3RTcSonkLlaGq4xPYKQz+oyYre0qsHCvcP1
    pQLKxIQrmKomKCoeOtpAkB96PH102BdnMjF503bVOvPsg1nrY2YY7WSqLtFKHKQB
    eXk3Slefk/6jjKOw8lwJa7UGCQlAHAUBpo8Z3b1ZrOijqpCRmzYYWuYplrYmF5TQ
    9Y/tSvhcp3G3cGW8Pjp7IibDgV7VIp8PJ3SRNAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519370923; bh=RZJgo4rvzBndIY7UBvsWFjALUWBUxqQ7Cvd5k01xOaI=; b=C
    drYsUlicZFwqxJ1dEDzqf5MuO1BY4SynJ57RijnUaGIniMRq3TsWL1cIA3Zmuj8A
    IyX0jRTfqdSiGTDxI9hT7sJVLJxbTyFpjEKLLtiEUEvhhXmJ56gUHouwKq8zQ2RD
    UFsj3qmDuUbZm0T9acad3qfnIvvEZ/YvoOf2xi6Gg3S+gapkFPYU03oy7bl6yvId
    pGh0G0/GeBCcn0PdoGu8xbsu5bEmmSuTW7H1dhThykmTwMqoI7bBySCY6INY92n9
    I2Rjmah12K/1u7dWh2TwnH/BO6XcnTX5hYq0b82p6JGOoYpTUs+SnwCcxbzXB9Uy
    dsyw1u/biktcQ+jqwELLA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751586AbeBWH0y (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 02:26:54 -0500
Received: from mga02.intel.com ([134.134.136.20]:57366 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751585AbeBWH0w (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 23 Feb 2018 02:26:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,382,1515484800";
   d="scan'208";a="20208099"
Subject: [PATCH v2 1/5] dax: fix vma_is_fsdax() helper
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: Haozhong Zhang <haozhong.zhang@intel.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-mm@kvack.org, Gerd Rausch <gerd.rausch@oracle.com>,
        linux-fsdevel@vger.kernel.org
Date: Thu, 22 Feb 2018 23:17:45 -0800
Message-ID: <151937026590.18973.14558952639668942540.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151937026001.18973.12034171121582300402.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151937026001.18973.12034171121582300402.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Gerd reports that ->i_mode may contain other bits besides S_IFCHR. Use
S_ISCHR() instead. Otherwise, get_user_pages_longterm() may fail on
device-dax instances when those are meant to be explicitly allowed.

Fixes: 2bb6d2837083 ("mm: introduce get_user_pages_longterm")
Cc: <stable@vger.kernel.org>
Reported-by: Gerd Rausch <gerd.rausch@oracle.com>
Reported-by: Haozhong Zhang <haozhong.zhang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/fs.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2a815560fda0..79c413985305 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3198,7 +3198,7 @@ static inline bool vma_is_fsdax(struct vm_area_struct *vma)
 	if (!vma_is_dax(vma))
 		return false;
 	inode = file_inode(vma->vm_file);
-	if (inode->i_mode == S_IFCHR)
+	if (S_ISCHR(inode->i_mode))
 		return false; /* device-dax */
 	return true;
 }
