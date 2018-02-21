Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1521561-1519217343-5-10056535323261888357
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519217343; b=pwxp6chf9AVqPmgtvDEJeQeb174m5tkgDrfy2n6TvZ67tPd
    Gvyi8K7xQ8T4DQYqb6z1gopDsSEYtU99OHxj8M9i7HZWd4/Z/fC/ixH2k7fD8ljP
    TNvv9nBtRYiIaZHjCfxz2gU8UaAzbPh6MQiXGJFNMOivmm+86qw4y+P3ntMe836p
    VOYzNCXh6tyYbCzTiVohARUTAIPEvSMMv0LAHnU17B7OcXkvH8kbjYSo6rt+VTVZ
    V5ySzJhtVcWupCXKe5zDCCS647DUIYn8b0AVLIRzoDMGwWwTE1F4+RqyTTdOLK0y
    Bi7kD7ywiB5/92T2koXuBQog2AYKeYPWp93DuMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519217343; bh=BTWWqZEL7rumeA7PmAXgL6XuqB
    cVAj4mqlF1bbrAC9Q=; b=E+Qf5T9Pwt0WgXC+WCHO6ed3uGNXQVLIHPUiGBy7Lr
    QmiPJ3cAIKOejFgy0QeV0NwYwYsS80TsIi2UhGk/8FJxi8iCdjb83h2VeMbSdRrg
    aA34Dd5ap3SZ7mp87su6Urji1fXnxSz33Dr4PW89S9pqgUhKqSKkOeudFbRvIe3n
    fVHzFco5jifb3uKCgCFCHZdoWycsWEi2h+s5aP7W48hy2Jci541yl1uAbdMjingD
    bDG8W7cXihxFHe9Jq9g6jJd77MjAJdR4qDORSfw199FcTPV9wumEe3T/E3F4tXC6
    BMaepoWG1BC6+BLRZDLv4ITrS7DOPs+rOqN/zmeNBifQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933915AbeBUMq2 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 07:46:28 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:59638 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933905AbeBUMq0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 07:46:26 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stewart Smith <stewart@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.4 12/33] rtc-opal: Fix handling of firmware error codes, prevent busy loops
Date: Wed, 21 Feb 2018 13:44:55 +0100
Message-Id: <20180221124410.314449386@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124409.564661689@linuxfoundation.org>
References: <20180221124409.564661689@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stewart Smith <stewart@linux.vnet.ibm.com>

commit 5b8b58063029f02da573120ef4dc9079822e3cda upstream.

According to the OPAL docs:
  skiboot-5.2.5/doc/opal-api/opal-rtc-read-3.txt
  skiboot-5.2.5/doc/opal-api/opal-rtc-write-4.txt

OPAL_HARDWARE may be returned from OPAL_RTC_READ or OPAL_RTC_WRITE and
this indicates either a transient or permanent error.

Prior to this patch, Linux was not dealing with OPAL_HARDWARE being a
permanent error particularly well, in that you could end up in a busy
loop.

This was not too hard to trigger on an AMI BMC based OpenPOWER machine
doing a continuous "ipmitool mc reset cold" to the BMC, the result of
that being that we'd get stuck in an infinite loop in
opal_get_rtc_time().

We now retry a few times before returning the error higher up the
stack.

Fixes: 16b1d26e77b1 ("rtc/tpo: Driver to support rtc and wakeup on PowerNV platform")
Cc: stable@vger.kernel.org # v3.19+
Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/rtc/rtc-opal.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/drivers/rtc/rtc-opal.c
+++ b/drivers/rtc/rtc-opal.c
@@ -58,6 +58,7 @@ static void tm_to_opal(struct rtc_time *
 static int opal_get_rtc_time(struct device *dev, struct rtc_time *tm)
 {
 	long rc = OPAL_BUSY;
+	int retries = 10;
 	u32 y_m_d;
 	u64 h_m_s_ms;
 	__be32 __y_m_d;
@@ -67,8 +68,11 @@ static int opal_get_rtc_time(struct devi
 		rc = opal_rtc_read(&__y_m_d, &__h_m_s_ms);
 		if (rc == OPAL_BUSY_EVENT)
 			opal_poll_events(NULL);
-		else
+		else if (retries-- && (rc == OPAL_HARDWARE
+				       || rc == OPAL_INTERNAL_ERROR))
 			msleep(10);
+		else if (rc != OPAL_BUSY && rc != OPAL_BUSY_EVENT)
+			break;
 	}
 
 	if (rc != OPAL_SUCCESS)
@@ -84,6 +88,7 @@ static int opal_get_rtc_time(struct devi
 static int opal_set_rtc_time(struct device *dev, struct rtc_time *tm)
 {
 	long rc = OPAL_BUSY;
+	int retries = 10;
 	u32 y_m_d = 0;
 	u64 h_m_s_ms = 0;
 
@@ -92,8 +97,11 @@ static int opal_set_rtc_time(struct devi
 		rc = opal_rtc_write(y_m_d, h_m_s_ms);
 		if (rc == OPAL_BUSY_EVENT)
 			opal_poll_events(NULL);
-		else
+		else if (retries-- && (rc == OPAL_HARDWARE
+				       || rc == OPAL_INTERNAL_ERROR))
 			msleep(10);
+		else if (rc != OPAL_BUSY && rc != OPAL_BUSY_EVENT)
+			break;
 	}
 
 	return rc == OPAL_SUCCESS ? 0 : -EIO;
