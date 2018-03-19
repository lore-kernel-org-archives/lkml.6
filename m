Return-Path: <mika.westerberg@linux.intel.com>
X-Google-Smtp-Source: AG47ELu+9EMiWnXbvPaUKcW1GpwUzJjpZ/QAZak5GZN4iyIMoFebSCGwk0xMaw9XyNHsPgiO8TtG
ARC-Seal: i=1; a=rsa-sha256; t=1521476827; cv=none;
        d=google.com; s=arc-20160816;
        b=U5fUDmC5W3OLGu5UDMMcDy/JTNhxEn1pE5nJZhWTX+4w7E6ENLIBSYNXTvsn+SUNTc
         hbJ2dlIk5R8F5I9ZTZL1CyVLnBrofiwvbV0fjlkBS3U4SUwNWUSgIwlMOlrVf8ZzZauP
         /pIa9IENgMmKv1emJSPh0Rt3IsnEo6yKSoVKQOL6E1KncY1iBjLqei93U0+pj/HgDRnB
         0UPkreXml28/6o9pNGs6vKssZK2If+AinojcOuIRKnviqEe0PoN5HuHWpMgw0TOtNFjq
         1SI9PhfKzeotUTqfSJhg/7OHn8IL2zpoaSBD/vN8M23BBj5PV/hm/kNLSE59oF51NVRw
         fBhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Gk5NDTMAyeejRq7YMfnMlGHfFdnCagBX+TbcM6TncDI=;
        b=i/Au63Be2DPnYRjrns3wI+syVW6HY+pjL0ZNndiSiufIW+YDXhoC/aFr0sPSOdFPVD
         XxVdLg521HUB2GqqoDk3T+Ed8MQnPe67MYLu60QlUvE3A3keHOIFnqauMsA/HnJoI8EF
         uRCs3dq37NAw0nmdVu/FT6exq6MuvHkM7+hq6eAYjNhRgFqDRNos4sEWPsErscGtnuSq
         px8/pP7OGT8tM0ekcKtBRzDnXiIGdjgwMhp3eS5MNg0yEFesstZM6fURUqYkEwJ7ALB1
         Pac9kkh3J1yYGPuaUHRwj3RJ9sICZ1KOdpeSLLEpKjxgVLJXrd4EQ3KVPXYokUbXscw6
         +2aw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,331,1517904000";
   d="scan'208";a="43391191"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <yehezkel.bernat@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/19] thunderbolt: Serialize PCIe tunnel creation with PCI rescan
Date: Mon, 19 Mar 2018 19:26:46 +0300
Message-Id: <20180319162703.5331-3-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319162703.5331-1-mika.westerberg@linux.intel.com>
References: <20180319162703.5331-1-mika.westerberg@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595384085882537797?=
X-GMAIL-MSGID: =?utf-8?q?1595384085882537797?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We need to make sure a new PCIe tunnel is not created in a middle of
previous PCI rescan because otherwise the rescan code might find too
much and fail to reconfigure devices properly. This is important when
native PCIe hotplug is used. In BIOS assisted hotplug there should be no
such issue.

Fixes: f67cf491175a ("thunderbolt: Add support for Internal Connection Manager (ICM)")
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org
---
 drivers/thunderbolt/switch.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index da54ace4dd2f..1cc79785ce42 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -716,6 +716,13 @@ static int tb_switch_set_authorized(struct tb_switch *sw, unsigned int val)
 	if (sw->authorized)
 		goto unlock;
 
+	/*
+	 * Make sure there is no PCIe rescan ongoing when a new PCIe
+	 * tunnel is created. Otherwise the PCIe rescan code might find
+	 * the new tunnel too early.
+	 */
+	pci_lock_rescan_remove();
+
 	switch (val) {
 	/* Approve switch */
 	case 1:
@@ -735,6 +742,8 @@ static int tb_switch_set_authorized(struct tb_switch *sw, unsigned int val)
 		break;
 	}
 
+	pci_unlock_rescan_remove();
+
 	if (!ret) {
 		sw->authorized = val;
 		/* Notify status change to the userspace */
-- 
2.16.2
