Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx489DuB6oFeLXZVnYINVjLFupEh/SU0tJubqVEggqbQuxdw64z8JqHdSbeD1sfGjV9sblkKP
ARC-Seal: i=1; a=rsa-sha256; t=1523472582; cv=none;
        d=google.com; s=arc-20160816;
        b=UMOJDzi2A65L7JQoBytKjoHVnMbdbkBhQsAKRWK261AWbdoU0TMPKQ02atmfnlvpgY
         RX+CeakxvNcE9Z7NKSqVFHNJzyrShRAqvenPXE9b5T5DfqmsJ4NWpuVDTDt/F4OSvopT
         ymL4NrWT0sqfWcq+4EQUpCUjWqKKECv4W81VTsfAloQ0k0gjFY7m15DKV/i9v29wHKHM
         LUc5sgcm56OrLadfBK6mwAoTP/4bSe88KzjZ4rgdLjZMWzhi7eQyQC6bg5X9OI/buLez
         fZ6wajqRPrQfRfFEpuT7O+CLE+FMXFLLwzVM6jwbkzGKlu7jwDtPYp7eiKyGRH14c4wW
         Vfhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=297BEQYo9ThSrVimKcgY4HPfnle9vBYe8qKVGyhB1KE=;
        b=jJT46Bn8qgkj4Izae+RR7Y08Xb67xd7A0WYkTCIOeHImcA0s6MmPQm75v6GjiYjFjT
         0/Nq/a/JkXCuAL6/vU3+MFptts/rqHGQaXMgLVzuHtIViPGlSmNu/9X6skaGUe+WD8Ni
         rGHuQRD6WKSImG3xJ8fuT0c35rxti6YOOhRRO32rxgtXhif2HsuGDnhPq1juBexrocGw
         ASt1egY3/GPU2kNa6f1ed8Ppg8VxINILDRJEGrYcs+ttfRaFgkxOsFYv1djSdZRuoznH
         Unl16uCWaUdEm5vzbibyT1OdmwVpLp8u8+XZ0qvf2i+in8vtu8/x9CRsoYqMsEAutrMs
         49eQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Steve Best <sbest@redhat.com>,
	Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 103/190] rtc: interface: Validate alarm-time before handling rollover
Date: Wed, 11 Apr 2018 20:35:49 +0200
Message-Id: <20180411183556.601176115@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476188518717832?=
X-GMAIL-MSGID: =?utf-8?q?1597476786792182839?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>


[ Upstream commit da96aea0ed177105cb13ee83b328f6c61e061d3f ]

In function __rtc_read_alarm() its possible for an alarm time-stamp to
be invalid even after replacing missing components with current
time-stamp. The condition 'alarm->time.tm_year < 70' will trigger this
case and will cause the call to 'rtc_tm_to_time64(&alarm->time)'
return a negative value for variable t_alm.

While handling alarm rollover this negative t_alm (assumed to seconds
offset from '1970-01-01 00:00:00') is converted back to rtc_time via
rtc_time64_to_tm() which results in this error log with seemingly
garbage values:

"rtc rtc0: invalid alarm value: -2-1--1041528741
2005511117:71582844:32"

This error was generated when the rtc driver (rtc-opal in this case)
returned an alarm time-stamp of '00-00-00 00:00:00' to indicate that
the alarm is disabled. Though I have submitted a separate fix for the
rtc-opal driver, this issue may potentially impact other
existing/future rtc drivers.

To fix this issue the patch validates the alarm time-stamp just after
filling up the missing datetime components and if rtc_valid_tm() still
reports it to be invalid then bails out of the function without
handling the rollover.

Reported-by: Steve Best <sbest@redhat.com>
Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/interface.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -217,6 +217,13 @@ int __rtc_read_alarm(struct rtc_device *
 			missing = year;
 	}
 
+	/* Can't proceed if alarm is still invalid after replacing
+	 * missing fields.
+	 */
+	err = rtc_valid_tm(&alarm->time);
+	if (err)
+		goto done;
+
 	/* with luck, no rollover is needed */
 	t_now = rtc_tm_to_time64(&now);
 	t_alm = rtc_tm_to_time64(&alarm->time);
@@ -268,9 +275,9 @@ int __rtc_read_alarm(struct rtc_device *
 		dev_warn(&rtc->dev, "alarm rollover not handled\n");
 	}
 
-done:
 	err = rtc_valid_tm(&alarm->time);
 
+done:
 	if (err) {
 		dev_warn(&rtc->dev, "invalid alarm value: %d-%d-%d %d:%d:%d\n",
 			alarm->time.tm_year + 1900, alarm->time.tm_mon + 1,
