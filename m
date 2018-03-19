Return-Path: <mika.westerberg@linux.intel.com>
X-Google-Smtp-Source: AG47ELu8YPaNWbQqxMqlToytSBc+r/dsldqk4k9Rt6bsC4CqcqoaWHYmpizXse/yWq7OsxZwtPpE
ARC-Seal: i=1; a=rsa-sha256; t=1521476827; cv=none;
        d=google.com; s=arc-20160816;
        b=yDsyxenOt2mlrazTHboqhv7RT9UoEEaZhkmoS17ECmpsLTKjyRePBIobqrJJyvHiBS
         IpLdySpId5i5rC0tMYh3Lws/Z7COmE5tCf6gS5QwnoLlSE3813sIMU3rzUsTWvQhYOjn
         DdweiIfcRhIQAXPJ8IWXSvq8HQmrsiKAzhdkXcJZwhzF8TmqS89514b0eDHiRLK3Xmcs
         kxSjFGWuO9rvjr6usL1DmceM1MR73GtZlvWbRMdG0qwdC4YT2GV4c0U9eXj3qWlWzfaW
         wKPRdxY72ZOVLU58AYGk5Ats4WdIXVZKIL+mfHBzWcMr2f7t7O8eBfCHBD8qUkwiFy25
         xjJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Y7f2Sdh++zDcYrbRsvLs5uU2niHIFOcdqQkICeDkCb0=;
        b=FFb64DrtRywh2VhMlpWmqE3n6p5WP3d3mCdFTQKO+L9DdwexUUlzwoIbDmECyQWJbw
         Nii15XTVqH5RPaILiEeqMpcYGhyof2fclQEhUtOkRo6nrMPWZk/ZhhqEmlAj3djcmzxs
         IvA+KN+adJSFRLWW5d57yL+eBymOw5G/qq7arX6moqpPzRYxT7jXfEuhDsFrE4JQNt1x
         MTsUtVbsX8Sg0vWI8aQaEdE6dWAJ1BJTwXYqtvYZbBXnHY/UKZ7ospSByZbujBmw4/Bv
         YA04+1WkOkjRYBfSEb8HoiytveHI/TfvaTlkJ+To+QEL8X2j+/bU6WtQ5p0BMkZJZBv0
         421g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,331,1517904000";
   d="scan'208";a="184124486"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <yehezkel.bernat@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/19] thunderbolt: Resume control channel after hibernation image is created
Date: Mon, 19 Mar 2018 19:26:45 +0300
Message-Id: <20180319162703.5331-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319162703.5331-1-mika.westerberg@linux.intel.com>
References: <20180319162703.5331-1-mika.westerberg@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595384085943657546?=
X-GMAIL-MSGID: =?utf-8?q?1595384085943657546?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The driver misses implementation of PM hook that undoes what
->freeze_noirq() does after the hibernation image is created. This means
the control channel is not resumed properly and the Thunderbolt bus
becomes useless in later stages of hibernation (when the image is stored
or if the operation fails).

Fix this by pointing ->thaw_noirq to driver nhi_resume_noirq(). This
makes sure the control channel is resumed properly.

Fixes: 23dd5bb49d98 ("thunderbolt: Add suspend/hibernate support")
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/thunderbolt/nhi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index f45bcbc63738..80c33c7404f5 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -1064,6 +1064,7 @@ static const struct dev_pm_ops nhi_pm_ops = {
 					    * we just disable hotplug, the
 					    * pci-tunnels stay alive.
 					    */
+	.thaw_noirq = nhi_resume_noirq,
 	.restore_noirq = nhi_resume_noirq,
 	.suspend = nhi_suspend,
 	.freeze = nhi_suspend,
-- 
2.16.2
