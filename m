Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0906C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8648220871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8648220871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbeKLGcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:32:33 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49320 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729753AbeKLFsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:01 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsN-0000lD-Qs; Sun, 11 Nov 2018 19:58:31 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsN-0001Mj-LF; Sun, 11 Nov 2018 19:58:31 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Darren Hart" <dvhart@linux.intel.com>,
        "Paul Bolle" <pebolle@tiscali.nl>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.550498422@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 009/366] eeepc-laptop: simplify parse_arg()
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Bolle <pebolle@tiscali.nl>

commit 95369a73a957ad221f1d6b8f11a63a376f38c544 upstream.

parse_arg() has three possible return values:
    -EINVAL if sscanf(), in short, fails;
    zero if "count" is zero; and
    "count" in all other cases

But "count" will never be zero. See, parse_arg() is called by the
various store functions. And the callchain of these functions starts
with sysfs_kf_write(). And that function checks for a zero "count". So
we can stop checking for a zero "count", drop the "count" argument
entirely, and transform parse_arg() into a function that returns zero on
success or a negative error. That, in turn, allows to make those store
functions just return "count" on success. The net effect is that the
code becomes a bit easier to understand.

A nice side effect is that this GCC warning is silenced too:
    drivers/platform/x86/eeepc-laptop.c: In function ‘store_sys_acpi’:
    drivers/platform/x86/eeepc-laptop.c:279:10: warning: ‘value’ may be used uninitialized in this function [-Wmaybe-uninitialized]
      int rv, value;

Which is, of course, the reason to have a look at parse_arg().

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
Signed-off-by: Darren Hart <dvhart@linux.intel.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/platform/x86/eeepc-laptop.c | 36 ++++++++++++++---------------
 1 file changed, 18 insertions(+), 18 deletions(-)

--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -263,13 +263,11 @@ static int acpi_setter_handle(struct eee
 /*
  * Sys helpers
  */
-static int parse_arg(const char *buf, unsigned long count, int *val)
+static int parse_arg(const char *buf, int *val)
 {
-	if (!count)
-		return 0;
 	if (sscanf(buf, "%i", val) != 1)
 		return -EINVAL;
-	return count;
+	return 0;
 }
 
 static ssize_t store_sys_acpi(struct device *dev, int cm,
@@ -278,12 +276,13 @@ static ssize_t store_sys_acpi(struct dev
 	struct eeepc_laptop *eeepc = dev_get_drvdata(dev);
 	int rv, value;
 
-	rv = parse_arg(buf, count, &value);
-	if (rv > 0)
-		value = set_acpi(eeepc, cm, value);
-	if (value < 0)
+	rv = parse_arg(buf, &value);
+	if (rv < 0)
+		return rv;
+	rv = set_acpi(eeepc, cm, value);
+	if (rv < 0)
 		return -EIO;
-	return rv;
+	return count;
 }
 
 static ssize_t show_sys_acpi(struct device *dev, int cm, char *buf)
@@ -377,13 +376,13 @@ static ssize_t store_cpufv(struct device
 		return -EPERM;
 	if (get_cpufv(eeepc, &c))
 		return -ENODEV;
-	rv = parse_arg(buf, count, &value);
+	rv = parse_arg(buf, &value);
 	if (rv < 0)
 		return rv;
-	if (!rv || value < 0 || value >= c.num)
+	if (value < 0 || value >= c.num)
 		return -EINVAL;
 	set_acpi(eeepc, CM_ASL_CPUFV, value);
-	return rv;
+	return count;
 }
 
 static ssize_t show_cpufv_disabled(struct device *dev,
@@ -402,7 +401,7 @@ static ssize_t store_cpufv_disabled(stru
 	struct eeepc_laptop *eeepc = dev_get_drvdata(dev);
 	int rv, value;
 
-	rv = parse_arg(buf, count, &value);
+	rv = parse_arg(buf, &value);
 	if (rv < 0)
 		return rv;
 
@@ -412,7 +411,7 @@ static ssize_t store_cpufv_disabled(stru
 			pr_warn("cpufv enabled (not officially supported "
 				"on this model)\n");
 		eeepc->cpufv_disabled = false;
-		return rv;
+		return count;
 	case 1:
 		return -EPERM;
 	default:
@@ -1042,10 +1041,11 @@ static ssize_t store_sys_hwmon(void (*se
 {
 	int rv, value;
 
-	rv = parse_arg(buf, count, &value);
-	if (rv > 0)
-		set(value);
-	return rv;
+	rv = parse_arg(buf, &value);
+	if (rv < 0)
+		return rv;
+	set(value);
+	return count;
 }
 
 static ssize_t show_sys_hwmon(int (*get)(void), char *buf)

