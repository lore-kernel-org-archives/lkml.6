Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045FCC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5F420870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FQAd/Kcq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CXcInnOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA5F420870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbeLJKBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 05:01:25 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52270 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbeLJKBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 05:01:25 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1B5D660A31; Mon, 10 Dec 2018 10:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544436084;
        bh=I7AxhQwQHysEjPDandmm/jeeMAur+STPiMaBPDh2vN4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FQAd/KcqwXE22S3tZ1TYoCrdfSwVph2kldE+P6IckGfYdcOyBDtJ0HnRZIypKVotT
         NMoJzvaIguwAFiY9sfS/w4fRTWau4RqCb+HsZquU9/+66UQey//rXKzcO4J6voDRVT
         RuiUx5BXMTGj+2tqztyn5KYVBxjKkBEdhlymeBno=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id B8B8860241;
        Mon, 10 Dec 2018 10:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544436083;
        bh=I7AxhQwQHysEjPDandmm/jeeMAur+STPiMaBPDh2vN4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CXcInnOGJIU+bLryvuAqpsaMaq1gWgaGoRWmIfN4927UTONX7HxeEdpZO/9uCOTWq
         0dpk6zdj+NOkwApLr204tNdJX4qDc8BT+VoWOTfwrkultaLJ8uMXMeDOr3jOwXwfUm
         TvlZNxYEQtTSYcAM9pFXiANh1EvA5vQWvRBKS3rc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 10 Dec 2018 18:01:23 +0800
From:   yuankuiz@codeaurora.org
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc-owner@vger.kernel.org
Subject: Re: [PATCH] rtc: proc: printf using alarm for alrm
In-Reply-To: <20181206203827.GE8952@piout.net>
References: <b44225b8e243a70c6ab63a40a3de630d@codeaurora.org>
 <acac27b279864ff8f938f79bcc49b238@codeaurora.org>
 <20181206203827.GE8952@piout.net>
Message-ID: <6997a28d4752ce340638f3de5a655d4d@codeaurora.org>
X-Sender: yuankuiz@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-07 04:38 AM, Alexandre Belloni wrote:
> On 06/12/2018 15:22:51+0800, yuankuiz@codeaurora.org wrote:
>> Hi,
>> 
>>     Kindly, this format change formats the rtc dump from:
>>         alrm_time	: 00:00:00
>>         alrm_date	: 1970-01-01
>>         alarm_IRQ	: no
>>         alrm_pending	: no
>> 
>>     to:
>>         alarm time	: 00:00:00
>>         alarm date	: 1970-01-01
>>         alarm IRQ	: no
>>         alarm pending	: no
>> 
> 
> Yes, and this would break the ABI as this file is in procfs. This is 
> not
> something I'm willing to do, especially since this file has been
> deprecated since 2006.

OK. So shall we default it as n like:
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index a819ef0..c51f0e1 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -100,7 +100,7 @@ config RTC_INTF_SYSFS
  config RTC_INTF_PROC
         bool "/proc/driver/rtc (procfs for rtcN)"
         depends on PROC_FS
-       default RTC_CLASS
+       default n
         help
           Say yes here if you want to use your system clock RTC through
           the proc interface, /proc/driver/rtc.


     Thanks,
BR//John Zhao
