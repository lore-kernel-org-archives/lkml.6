Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880D3ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4030C208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4030C208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbeGMQBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:01:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40102 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729736AbeGMQBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:01:31 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F296D720;
        Fri, 13 Jul 2018 15:46:19 +0000 (UTC)
Date:   Fri, 13 Jul 2018 17:46:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     devel@driverdev.osuosl.org, John Joseph <jnjoseph@google.com>,
        linux-kernel@vger.kernel.org, Simon Que <sque@chromium.org>,
        Rob Springer <rspringer@google.com>
Subject: Re: [PATCH] staging: gasket remove current_kernel_time usage
Message-ID: <20180713154617.GA24618@kroah.com>
References: <20180713150703.3156256-1-arnd@arndb.de>
 <20180713153351.GA23607@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713153351.GA23607@kroah.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 05:33:51PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jul 13, 2018 at 05:06:37PM +0200, Arnd Bergmann wrote:
> > A new user of the deprecated current_kernel_time() function has appeared
> > here. This code won't work correct during leap seconds or a concurrent
> > settimeofday() call, and it probably doesn't do what the author intended
> > even for the normal case, as it passes a timeout in nanoseconds but
> > reads the time using a jiffies-granularity accessor.
> > 
> > I'm changing it to ktime_get_ns() here, which simplifies the logic,
> > and uses a high-res clocksource. This is a bit slower, but that
> > probably doesn't matter in a busy-wait loop.
> > 
> > Note: it also doesn't matter in the current version, as there are no
> > callers of this function.
> 
> Let's just rip the whole function out, I've been going through and
> removing functions that no one calls and no one uses.  That would make
> more sense here.  Want me to send a patch for that, or do you want to?

Ah it was easy enough, here's the patch, I'll add it to the longer list
of gasket patches I have queued up to be applied tomorrow:

-------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] staging: gasket: remove gasket_wait_sync()

This function is not called anywhere, so just remove it.

Also, as an added benifit, Arnd points out that it doesn't even work
properly:
	This code won't work correct during leap seconds or a concurrent
	settimeofday() call, and it probably doesn't do what the author intended
	even for the normal case, as it passes a timeout in nanoseconds but
	reads the time using a jiffies-granularity accessor.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 4ca6e53116ea..df52e6e6bf13 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -2067,50 +2067,6 @@ struct device *gasket_get_device(struct gasket_dev *dev)
 	return NULL;
 }
 
-/**
- * Synchronously waits on device.
- * @gasket_dev: Device struct.
- * @bar: Bar
- * @offset: Register offset
- * @mask: Register mask
- * @val: Expected value
- * @timeout_ns: Timeout in nanoseconds
- *
- * Description: Busy waits for a specific combination of bits to be set
- * on a Gasket register.
- **/
-int gasket_wait_sync(
-	struct gasket_dev *gasket_dev, int bar, u64 offset, u64 mask, u64 val,
-	u64 timeout_ns)
-{
-	u64 reg;
-	struct timespec start_time, cur_time;
-	u64 diff_nanosec;
-	int count = 0;
-
-	reg = gasket_dev_read_64(gasket_dev, bar, offset);
-	start_time = current_kernel_time();
-	while ((reg & mask) != val) {
-		count++;
-		cur_time = current_kernel_time();
-		diff_nanosec = (u64)(cur_time.tv_sec - start_time.tv_sec) *
-				       1000000000LL +
-			       (u64)(cur_time.tv_nsec) -
-			       (u64)(start_time.tv_nsec);
-		if (diff_nanosec > timeout_ns) {
-			gasket_log_error(
-				gasket_dev,
-				"gasket_wait_sync timeout: reg %llx count %x "
-				"dma %lld ns\n",
-				offset, count, diff_nanosec);
-			return -1;
-		}
-		reg = gasket_dev_read_64(gasket_dev, bar, offset);
-	}
-	return 0;
-}
-EXPORT_SYMBOL(gasket_wait_sync);
-
 /**
  * Asynchronously waits on device.
  * @gasket_dev: Device struct.
diff --git a/drivers/staging/gasket/gasket_core.h b/drivers/staging/gasket/gasket_core.h
index 45013446b8c5..e51acadc0fc4 100644
--- a/drivers/staging/gasket/gasket_core.h
+++ b/drivers/staging/gasket/gasket_core.h
@@ -699,11 +699,6 @@ const struct gasket_driver_desc *gasket_get_driver_desc(struct gasket_dev *dev);
 /* Get the device structure for a given device. */
 struct device *gasket_get_device(struct gasket_dev *dev);
 
-/* Helper function, Synchronous waits on a given set of bits. */
-int gasket_wait_sync(
-	struct gasket_dev *gasket_dev, int bar, u64 offset, u64 mask, u64 val,
-	u64 timeout_ns);
-
 /* Helper function, Asynchronous waits on a given set of bits. */
 int gasket_wait_with_reschedule(
 	struct gasket_dev *gasket_dev, int bar, u64 offset, u64 mask, u64 val,
