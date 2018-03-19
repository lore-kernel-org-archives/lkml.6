Return-Path: <mika.westerberg@linux.intel.com>
X-Google-Smtp-Source: AG47ELsK3FKlfntkSSXPc1lrP1xK4PttHH5GHznHW2km5Eef37rexgexHb0pBp6dD1nxXftzwRSV
ARC-Seal: i=1; a=rsa-sha256; t=1521476831; cv=none;
        d=google.com; s=arc-20160816;
        b=XiGL0NEZRWpskywaSd367B7VGpVRJ7hoqp2aRhsz+IkIGgRaFdbtZo5Fp6HIqKX52l
         3uwbIY0dBmU8BAtGUm7oPBby7aV/1yjqnHDUUlh+takOVRh0pSmRaflM+yh1KNd0PFo6
         5AzQSG9yQ3ea45PdikXScyOn/2duddN8WwVvbcMuyUCd0P08GHp486tjqoyRdThdgYHD
         IEMksTLEu5WiekLi6zTQJtJAAzuEHD6dSAaDZw3YKZq0k/9/9vZQo8iW/39uoGxMcbW9
         2uKFLAKui51qEUGEMnt3PUS7svP3El4VooEZKNULfkwLazBRrSIiGjSdPxAgecnsoLrt
         6twg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=GmtWtCmkLR+Jno06syuT2zQz+yzzpTjMufn0nQ0PKd4=;
        b=IcXvVF9EzrbyZoliBDubEsVBiF82rYvU8nLdLAF4l5VsZ4CVrXZnupngUf1QRBgkZr
         JEsMHYSa23htF6dtr/kJCzj2KgVmnZn+kYSI4xwikzvsOr5oDWJ8BCImBhk8jQyzKJ4F
         /3rqxTXLzyoxnZV8FXbbNXHlJkgYb3CR4oOS8AWo0h6t59WCs8W6UzhcBLW3RjP1l1JO
         2uaV1Q4jwwxSovHYNKpF/A+Hct6rEWOG1pACEIle1KMNdsswm7wpNJlWbcORUloh2N00
         Z+cOG3/mvhLNF/WCbqcGCjqso8JS7Zsmyvt3Q3Kzp5aYAMQ6XZt1jTsq+CUbQH00CTbM
         US3w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,331,1517904000";
   d="scan'208";a="25779766"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <yehezkel.bernat@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/19] thunderbolt: Wait a bit longer for root switch config space
Date: Mon, 19 Mar 2018 19:26:49 +0300
Message-Id: <20180319162703.5331-6-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319162703.5331-1-mika.westerberg@linux.intel.com>
References: <20180319162703.5331-1-mika.westerberg@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595384089997395008?=
X-GMAIL-MSGID: =?utf-8?q?1595384089997395008?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In some case reading root switch config space takes longer than what we
are currently waiting in the driver resulting timeout and failure.
Increase number of retries to allow some more time for the root switch
config space to become accesssible.

Also log an error if the timeout is exceeded so we know why the driver
probe failed.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/thunderbolt/icm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 182226023acb..1183321586c5 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -828,7 +828,7 @@ __icm_driver_ready(struct tb *tb, enum tb_security_level *security_level)
 	struct icm_pkg_driver_ready request = {
 		.hdr.code = ICM_DRIVER_READY,
 	};
-	unsigned int retries = 10;
+	unsigned int retries = 50;
 	int ret;
 
 	memset(&reply, 0, sizeof(reply));
@@ -856,6 +856,7 @@ __icm_driver_ready(struct tb *tb, enum tb_security_level *security_level)
 		msleep(50);
 	} while (--retries);
 
+	tb_err(tb, "failed to read root switch config space, giving up\n");
 	return -ETIMEDOUT;
 }
 
-- 
2.16.2
