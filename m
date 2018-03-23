Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtGzKHjTtZOLNHNDKODaehkFEyQ9qwQtsWmtmiNgXfDmx9GsH61vXEXvboefUsJ0ZrRIYav
ARC-Seal: i=1; a=rsa-sha256; t=1521800287; cv=none;
        d=google.com; s=arc-20160816;
        b=i8KDcpoyQIz/2v2EJcQJSPpQQ5krOularfYhXG0Z2A7FVtWadeNHAQYTP1JFNb5R9q
         tqAYhgYJnsNUG08cGX46U7YyowH3kjSmWnYODEGJrfwnl14OaSMz8BWXX2LmTC059VpO
         WKJIRDxne6n6Fjw/YQgqYPusra+TV96WLQ07fczK8Ko2egUXKhi7V5yXwp1hFtC61ndP
         4hc4tAD5vOFix87kCVY9ljiELJLXdw4qf3FcACgPd3GNdIxO96ErGJWdH9TWlEqsYI8b
         H8g+A1z4lyxqtetgVqjuFx7FEOdXR0Xx4xJqxBseOTRcoFiMKAuZt4GLSlv6cm+Q3w7Y
         sc7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mAoMcmzgCNBoc1NxBbA5gE8ANRlxmwW9ZUKgXHMuQQs=;
        b=ltm797tDLLJCs8z0sw1XsiLNudxAPjXCE5AfqWHM27LfpkPzPVfJGLDZQxKQpkCBNh
         3Ve0XVyVHnHDI53A6kZXwrw1TC7VZez9F45segKb3IgJiJ5RVm7oE7A/X8a+wCcNXw2o
         Qmr6G/gFJWnxivlett2U7Q5CqFvSV9Qauyxu3lOPA0XWFD7Q88lZBy4G0P9MaS1PYphD
         HjbkTFYDSbzStNG9vFIGQnDNhU0DqSkMO4MU0LtKqU3MXXm05VgUS9792Yun7n1wmL8q
         ctmIAeORCwWGXbWSkhz82E3IH6JqXkp4aHNd1vcOtT+KpBfAqLyXZtVWy2PMCl0sxePH
         b7FA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bernd Faust <berndfaust@gmail.com>,
	Sasha Neftin <sasha.neftin@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Aaron Brown <aaron.f.brown@intel.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 15/47] e1000e: fix timing for 82579 Gigabit Ethernet controller
Date: Fri, 23 Mar 2018 10:55:06 +0100
Message-Id: <20180323094248.782924661@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722523208353746?=
X-GMAIL-MSGID: =?utf-8?q?1595723257745185461?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bernd Faust <berndfaust@gmail.com>


[ Upstream commit 5313eeccd2d7f486be4e5c7560e3e2be239ec8f7 ]

After an upgrade to Linux kernel v4.x the hardware timestamps of the
82579 Gigabit Ethernet Controller are different than expected.
The values that are being read are almost four times as big as before
the kernel upgrade.

The difference is that after the upgrade the driver sets the clock
frequency to 25MHz, where before the upgrade it was set to 96MHz. Intel
confirmed that the correct frequency for this network adapter is 96MHz.

Signed-off-by: Bernd Faust <berndfaust@gmail.com>
Acked-by: Sasha Neftin <sasha.neftin@intel.com>
Acked-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/e1000e/netdev.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3507,6 +3507,12 @@ s32 e1000e_get_base_timinca(struct e1000
 
 	switch (hw->mac.type) {
 	case e1000_pch2lan:
+		/* Stable 96MHz frequency */
+		incperiod = INCPERIOD_96MHz;
+		incvalue = INCVALUE_96MHz;
+		shift = INCVALUE_SHIFT_96MHz;
+		adapter->cc.shift = shift + INCPERIOD_SHIFT_96MHz;
+		break;
 	case e1000_pch_lpt:
 		/* On I217, the clock frequency is 25MHz or 96MHz as
 		 * indicated by the System Clock Frequency Indication
