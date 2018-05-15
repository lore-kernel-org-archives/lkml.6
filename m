Return-Path: <mika.westerberg@linux.intel.com>
X-Google-Smtp-Source: AB8JxZpksQenOvjIfOUjJm5ISd9jsm7B60rhq2Ue8fUVF0JlcPZlDU+P/1Xgf78pUEs5RLKazw2F
ARC-Seal: i=1; a=rsa-sha256; t=1526389469; cv=none;
        d=google.com; s=arc-20160816;
        b=CfTtF7IIw1OPWE/ODJ724w7+we+3GFnnz17jOd6480mmuLh0sBnl2aGvJ4DWnoNJlW
         KUSBniUe95/bSwAufpXkkW1PWK8lI3CpjrsaTfko/agZ48tRYrtx4FdNfDj0a6fX/ffL
         wCQDIWyV6HwsXYSJzoKzpOj3lEMrnm9dopIwnqvzrgJ6pm8d+LqXYe+PyCb+U+oeZeOi
         DkpqKQZzOpeDVC9f2clgaIgdvCEB3q/r5nnqHawxUoFcL4lks/pKa1i17RzBTDOUQfty
         Dg8tR20vZGPkSjWKxbzc6MipvWIkrQaUGiK0+UJyqWDs7BzchFUfQPPLCSBU3f1l8vKU
         fC1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=b49bD5bR2m36keu6lF7TeHq4dqAp7NBbXIpmi0mkojc=;
        b=YCH2EIXaodC/YoDy+IEPrpRozSGytz0clRJhiYPR1kg0/4WTS9c4gLlV45k5vkbJCt
         /TISRzHiXULvPig/GFDMB0XG4Zpwm6+iWgV0QvIAWlobkXk8iwyJtsLvVtqBWfPBwkwD
         e+pjS66nicDfgVnBsF+L2LzOOv+2HbpDTZjEYXulsGvPwhdecL0Fw4mbszDpMOHFKO2i
         V+b7BD6YoOdchZ6oWgofOz4PYd7NsecSqvY/pkAUQx0itP//xJR6jOhurHQginNkkOK4
         gsfT3dXjfRgz/ZWOxjpYe5Cz9Gy2nS36z9ixIj0geb7Ji3CRqyIT5OO/SeigfPG6x8fs
         cUcQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,403,1520924400";
   d="scan'208";a="49395931"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] thunderbolt: Handle NULL boot ACL entries properly
Date: Tue, 15 May 2018 16:04:25 +0300
Message-Id: <20180515130425.7652-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180515130425.7652-1-mika.westerberg@linux.intel.com>
References: <20180515130425.7652-1-mika.westerberg@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600535364263356060?=
X-GMAIL-MSGID: =?utf-8?q?1600535364263356060?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If the boot ACL entry is already NULL we should not fill in the upper
two DWs with 0xfffffffff. Otherwise they are not shown as empty entries
when the sysfs attribute is read.

Fixes: 9aaa3b8b4c56 ("thunderbolt: Add support for preboot ACL")
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Yehezkel Bernat <yehezkelshb@gmail.com>
---
 drivers/thunderbolt/icm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 2d2ceda9aa26..500911f16498 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -1255,7 +1255,7 @@ static int icm_ar_get_boot_acl(struct tb *tb, uuid_t *uuids, size_t nuuids)
 			/* Map empty entries to null UUID */
 			uuid[0] = 0;
 			uuid[1] = 0;
-		} else {
+		} else if (uuid[0] != 0 || uuid[1] != 0) {
 			/* Upper two DWs are always one's */
 			uuid[2] = 0xffffffff;
 			uuid[3] = 0xffffffff;
-- 
2.17.0
