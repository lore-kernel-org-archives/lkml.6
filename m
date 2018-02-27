Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-379639-1519705956-2-8660638748893670204
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519705955; b=SRS2lGjG4QHE0TdRF9TvgbxQPhkqwYxs2smeR60ofHJuBAV
    F0wgHUNF8WbmgTsUAp7hm1w5xaqIjs546piwU1gPc7e2a8y/gv94fwJsRiZXFZD1
    zGQCpfpSJtdHBL+lbIfwpky/5H2kEZgKwpAtnx3RzQG0YXXqg+LjDPNi8JFz51ED
    UTdtr7EQuVk0OHZyULp5l4R9B2Iu6V9wM2taMGNtXI3tS4Bsb3w7CQFMbhbcwJbs
    wrYPzx870AH6QE/9/QXD8PCDIu8mGqEHbGac8uvI/1bkz+rIGbqdUrEY3/ZZOhlj
    jIKk/CYzZRuv/NIg/x8WoeJxr5CgwHecUcq2t+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519705955; bh=rffv3sWQ2L3MU3KEtL1teeUI4C8j3LVdPhVLCJeRu+s=; b=t
    iFJuXeaNcYOqPJaUW0xNcVw9eLFCOeiStpU3q1PoAjDmfLAqgZdbjClA69gnMl7O
    PsH2UiRgtal/etfRd2W1EMLN83iT76ZaXaBHwPDz/ajsrs/l0lbPEW3znmkoowF+
    ipiMOLSLlJRsn+GfLanl+HnBoRJ1FM8CjKucrzXsZSkaU/yZCkZ1Lv09So/j1kE3
    B8yDgs4utuE+b4Qh+QBEjbXrQMbPnlfFKLSRywPwOqbV4cmc+E1FLtLDwV9KytGg
    1uvIevn6bYxYKzMksUXdBq5bVxA3rUlgpNqHndie6oKW/Jg3XA9ndtZ9mBuYNMyH
    xdG+MC4uLQefBUuv52aJw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751510AbeB0E3J (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 23:29:09 -0500
Received: from mga06.intel.com ([134.134.136.31]:63164 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751591AbeB0E3G (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 26 Feb 2018 23:29:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,398,1515484800";
   d="scan'208";a="30001993"
Subject: [PATCH v4 01/12] dax: fix vma_is_fsdax() helper
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: Jane Chu <jane.chu@oracle.com>,
        Haozhong Zhang <haozhong.zhang@intel.com>,
        Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, linux-mm@kvack.org,
        Gerd Rausch <gerd.rausch@oracle.com>,
        linux-fsdevel@vger.kernel.org
Date: Mon, 26 Feb 2018 20:20:00 -0800
Message-ID: <151970519993.26729.274277383890046437.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151970519370.26729.1011551137381425076.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151970519370.26729.1011551137381425076.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Acked-by: Jane Chu <jane.chu@oracle.com>
Reported-by: Haozhong Zhang <haozhong.zhang@intel.com>
Reviewed-by: Jan Kara <jack@suse.cz>
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
