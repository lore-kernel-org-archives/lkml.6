Return-Path: <mika.westerberg@linux.intel.com>
X-Google-Smtp-Source: AG47ELtYu8fHyv5t8DZn/Dl4ExZpTPC0fpL0oNbDi7Wjj7IWaeFsZbRgnn6J3uELvDm1Zs+ZPetq
ARC-Seal: i=1; a=rsa-sha256; t=1521476831; cv=none;
        d=google.com; s=arc-20160816;
        b=zQ14ftab6BgNiQLSY/swOzeFa19LIIWL8dN0scq3RWpEd/+gT5ta5GprNGIjOTi3Ve
         bh9vdpmoA/lltmfRVlBoBMGCiVSc2Z7dHPgCOc/AU+By2VFGOix7WUGHrf2fr+mEVVjK
         FACXCfWRPpaOoQ3RHwQttNPZ/egThRwfG5YndYd+bLEQAJI4PPE9bsW3iu1q1icpXczQ
         6A0sFUs2/JZ5NAD/sxphTkZNXQM/PtVz3Cz/Jrjv1eA+yVwhgrCAJEUJ0lQO+qQg8H4L
         wTikX3yfWwNKwqqyu4ZaIFZEUP/gG8tuSr0hn4uH1vw1g5Cm1vFt5eXc5Krv/mOwEYVl
         wLgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=VDuA5uLZm2nlnS4IJ0mcmpkk49i20rKEkJlZlE+IO6A=;
        b=U0YjCPZE9uDpCsV2ANTkl+KmlZKNJJytzPY9Isj769bEYMRjMWX9d7asGEs/Nx9FCp
         eAAtfSyMakEj1y5GpUwo8GOnS7CrvsIbuaYNrKkBVndF9UzlBpnKA3tla6MAn96duckb
         4ttiRTFWvAGA55cT6zNcvD/Yjta+c2gIUTlQkvdyOq0bffuc5D0IMfGocfi5Iis+u5v6
         RCxEhRWliHb2y6fNyc9i/2z/Q7GSsy2b8N/KPU68l93jZd1YF0COpcT3Jv2KKbE+37vs
         nxB0V+w1ndZVQbIB2AiO39oepre+g1Kmb5ovOqsz/f1ZMASeNOssRh0PmoEXR6/19uEz
         j6QA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,331,1517904000";
   d="scan'208";a="212699937"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <yehezkel.bernat@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/19] thunderbolt: Wait a bit longer for ICM to authenticate the active NVM
Date: Mon, 19 Mar 2018 19:26:50 +0300
Message-Id: <20180319162703.5331-7-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319162703.5331-1-mika.westerberg@linux.intel.com>
References: <20180319162703.5331-1-mika.westerberg@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595384090030987682?=
X-GMAIL-MSGID: =?utf-8?q?1595384090030987682?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Sometimes during cold boot ICM has not yet authenticated the active NVM
image leading to timeout and failing the driver probe. Allow ICM to take
some more time and increase the timeout to 3 seconds before we give up.

While there fix icm_firmware_init() to return the real error code
without overwriting it with -ENODEV.

Fixes: f67cf491175a ("thunderbolt: Add support for Internal Connection Manager (ICM)")
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/thunderbolt/icm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 1183321586c5..611d28e8e5f2 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -736,14 +736,14 @@ static bool icm_ar_is_supported(struct tb *tb)
 static int icm_ar_get_mode(struct tb *tb)
 {
 	struct tb_nhi *nhi = tb->nhi;
-	int retries = 5;
+	int retries = 60;
 	u32 val;
 
 	do {
 		val = ioread32(nhi->iobase + REG_FW_STS);
 		if (val & REG_FW_STS_NVM_AUTH_DONE)
 			break;
-		msleep(30);
+		msleep(50);
 	} while (--retries);
 
 	if (!retries) {
@@ -1063,6 +1063,9 @@ static int icm_firmware_init(struct tb *tb)
 			break;
 
 		default:
+			if (ret < 0)
+				return ret;
+
 			tb_err(tb, "ICM firmware is in wrong mode: %u\n", ret);
 			return -ENODEV;
 		}
-- 
2.16.2
