Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-441027-1519963591-2-2243823388985738490
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
    t=1519963590; b=t4+e+6PeCwTfMYyuA037ZzZo5dO10LmyzRh03YRot81GNcS
    OT2P97maMdtCssa9wgW1gaP60NzVZ2oIwpccTUn9m1Ynrn5c9Nq7IRPWNZ77bA6l
    Su83Wn+3tgtp2wT35jec4JABWjNZ7hIhj7dF/X5X36ahB7QH3gxYOsF13an+UgOy
    tXTI27dJWzwhnrf3KFujGYWYB9jehN0oCdSahE7rblMDofJw715dlPsIxEod4p4U
    x6PFtcPOJRTC5G569YhDLa85oYNby/7JI4o9D1kdt47znzaM2qUTJUmRHcFyx1h4
    5YQdppwzWghdaUtdHyjNilN5HSRQJhjnrbowK6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519963590; bh=rffv3sWQ2L3MU3KEtL1teeUI4C8j3LVdPhVLCJeRu+s=; b=H
    R/2F/9HX0G9xch86VmC0UKUnVDE0diz4hRsqYD3qf+yxJqmS4Nof7Zax7oM/J2Fb
    3U1RoOuVaKXMfjC/LeK128LOt+GMx6rTNI59BvF99/DbsfYkJDv9iIFdC7dbJqS6
    Vpb7wSUAKjx1PeYtOWt1IMB+NIkOsc7sL3EtV7BxKp725nBzwD08YdmiEZjKT/PG
    PSeAU2EGS7mER8FTCZOxmJn4AUhTHNiu7GYLGwAqZEafdbFc4GfWP7T6/a7YkH9z
    VCdN8Fq7mjNr9Gmw4UOHb9jh0u9rmV43ciFlPqFgpGHKT/FDntte3aRWZkh5r5RJ
    ii4B1HwqAPWGGaCLsxTxA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164462AbeCBECs (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 23:02:48 -0500
Received: from mga04.intel.com ([192.55.52.120]:16694 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163935AbeCBECp (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 1 Mar 2018 23:02:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,409,1515484800";
   d="scan'208";a="208265690"
Subject: [PATCH v5 01/12] dax: fix vma_is_fsdax() helper
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: stable@vger.kernel.org, Gerd Rausch <gerd.rausch@oracle.com>,
        Jane Chu <jane.chu@oracle.com>,
        Haozhong Zhang <haozhong.zhang@intel.com>,
        Jan Kara <jack@suse.cz>, linux-xfs@vger.kernel.org, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date: Thu, 01 Mar 2018 19:53:38 -0800
Message-ID: <151996281881.28483.2616406435517031167.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151996281307.28483.12343847096989509127.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151996281307.28483.12343847096989509127.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
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
