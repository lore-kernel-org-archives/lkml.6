Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx495kR3bGQU1nlPLrZ6fmlWkKEUaNiVDZFIzhGj99325SUI0hiQIg/RUbW5kpeiwAWlIpliD
ARC-Seal: i=1; a=rsa-sha256; t=1524405467; cv=none;
        d=google.com; s=arc-20160816;
        b=uNOpSBzjfb0zx0LLX/Ug6n4CBinChX3rx+IcwQc1p6eAI6tyHeWN+MNF2b/i+uIHQI
         MU0KXCCTwEW9BjSClkp4GIcU4KpSwkG5FDUIGqhubp1q9pAicWRvPvvEE8h5aC9oGUFR
         1/Cwt99ciyVi9B5kkI85NfrzmpCFVWlyVXXLlFRqc83etSNFOksS37GC8u+470cZwh0v
         bNG7uKNJ0nAdKL2GiDRayy5Or4BeBjSuwupWJSu03WrTyiZfVsQlJRVAr/N4rBK8Ci8a
         ISO0/08PJNHBaw5wnqPnnqlaFBNamaJryio2WOugxl1gKykCbM/m3n2CFwSW7UXcn7nI
         sJiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jESWZSwxqujIGmDOjD+Nm9l4zcf4sK9Na5k+WOURsew=;
        b=OFmMoVSQmB3xbZbYlXjKbTECvZTR0MUsXyysx06eSdVW9z8v8OrP12JXKZUir+HP1e
         zjjHVuQzoCCKUiS/Soz3zWe936ZCdCOxVEJ2Ie90kfo/kpFz4tj2akPN75AWqkIu5kCH
         2jLZKyBHml3R/7G7U+03XVn5IcUN8wM7okiNsv2cTw42ZQpocgVmNDqw+/3xcuBhY/Jv
         kY4E0DnBxKAAG99L1XJ9Bt++4rGicImPCvREYH0i3K0kycta8yXGOWJk1DtoE+ViqVO1
         AzdJQeKW6hJ2uCKdba3mDy09vi+AgPkDlqC8TvctDKJi3FQiULuwpbuKJ69KVrYduGjq
         eEdQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4.16 076/196] thunderbolt: Serialize PCIe tunnel creation with PCI rescan
Date: Sun, 22 Apr 2018 15:51:36 +0200
Message-Id: <20180422135108.176958731@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454987127577540?=
X-GMAIL-MSGID: =?utf-8?q?1598454987127577540?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit a03e828915c00ed0ea5aa40647c81472cfa7a984 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/thunderbolt/switch.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -716,6 +716,13 @@ static int tb_switch_set_authorized(stru
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
@@ -735,6 +742,8 @@ static int tb_switch_set_authorized(stru
 		break;
 	}
 
+	pci_unlock_rescan_remove();
+
 	if (!ret) {
 		sw->authorized = val;
 		/* Notify status change to the userspace */
