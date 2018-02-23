Return-Path: <dan.j.williams@intel.com>
X-Google-Smtp-Source: AH8x225iT1eiM2xkOcI+/MylWgJEKTJ2ffF1sRwLgAtFaGlYBReCyl4GaumoU5w31KCnYVMPej28
ARC-Seal: i=1; a=rsa-sha256; t=1519424079; cv=none;
        d=google.com; s=arc-20160816;
        b=Qco5i/hiXQuGzgfBT+QZ9rFt3kMGEdedAf/eHdx42sqdfPy/W+E+qHkvBqSSPSRWNn
         L1HfqDNA2UShL3CJh2Yd1RA9443Whqts3v+mJGzhth2boRpAC0EPE90i5B7athRNSb9G
         2lPVeN/xzd3NXygpx9fUGb8dSN9jFBUFMpxZivlIZWPHiP1Y9eR3VpwHXy/o1NIy6mpa
         P3n3s7JMn2KHihMK8oVTmDnAg67nLAKO6p3JRBpAzga+twAAkPfZIOU4NyUdoTU2VWRY
         vBsztX5AJ3KPFPfZCFtSkorevEPrxekNlkl+8DGIBmd1p3XjYezTgDQRM73XkwamMixl
         i7tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject
         :arc-authentication-results;
        bh=RjIXJ3VITKCk2BoGKohkTzODzX2jhNUd7UNb9SEETyY=;
        b=wGnjHh/SAf4QHlS/+kS/av4wv9x1E/V/7bnyhzLpE25MBhQ0ipDmUnOyW9zPyzb5Gj
         ocLyVcdzIW5CfgjVCH6SrUXE/mqZY5EdmDllrvgFy4tEfDVKPJlysc12F27trLsBRpw5
         fv6MY4MQxzfbhgTpHr1X+G4JzH/veP9bZepKedQoKAj6ghoMzdsJqgmZ0sxtBiYnNJJc
         TKbRmda6Y00X/K1DSmgmNkY4hK1CoaUNZcaxonyzq0w3EA3LwSwZ4tmKHvhhfYEJec7M
         BOEFYjr6996bnHTVSzzvleSSa1KFLGNEzi92aZQ19iWrl2z+vXWcVmM6ZGc6jKYD7NVa
         3Wmw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dan.j.williams@intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=dan.j.williams@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dan.j.williams@intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=dan.j.williams@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,383,1515484800";
   d="scan'208";a="22639690"
Subject: [4.9-stable PATCH 02/11] fs/dax.c: fix inefficiency in
 dax_writeback_mapping_range()
From: Dan Williams <dan.j.williams@intel.com>
To: gregkh@linuxfoundation.org
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Ross Zwisler <ross.zwisler@linux.intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>
Bcc: dan.j.williams@intel.com
Date: Fri, 23 Feb 2018 14:05:33 -0800
Message-ID: <151942353293.21775.3589635231521871832.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151942352167.21775.16852023419062929165.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151942352167.21775.16852023419062929165.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593231623385291381?=
X-GMAIL-MSGID: =?utf-8?q?1593231623385291381?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jan Kara <jack@suse.cz>

commit 1eb643d02b21412e603b42cdd96010a2ac31c05f upstream.

dax_writeback_mapping_range() fails to update iteration index when
searching radix tree for entries needing cache flushing.  Thus each
pagevec worth of entries is searched starting from the start which is
inefficient and prone to livelocks.  Update index properly.

Link: http://lkml.kernel.org/r/20170619124531.21491-1-jack@suse.cz
Fixes: 9973c98ecfda3 ("dax: add support for fsync/sync")
Signed-off-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 fs/dax.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/dax.c b/fs/dax.c
index 800748f10b3d..71f87d74afe1 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -785,6 +785,7 @@ int dax_writeback_mapping_range(struct address_space *mapping,
 			if (ret < 0)
 				return ret;
 		}
+		start_index = indices[pvec.nr - 1] + 1;
 	}
 	return 0;
 }
