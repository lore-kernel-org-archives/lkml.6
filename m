Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958BAC65BD1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A502085B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="b22NuDay";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TpjYsrFU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A502085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbeJJEPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 00:15:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59946 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeJJEPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 00:15:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4C53D6031A; Tue,  9 Oct 2018 20:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539118575;
        bh=6ncdQBBvka/drSAbkw/gkLt3bev/tSblfQichRnBk80=;
        h=Date:From:To:Cc:Subject:From;
        b=b22NuDaytgMGpTVgGltOZZRHs5AeYz/CqnAdB6XnLRdHnVoktmn8JoMCfTO88lg85
         ycysvDeTQmYTFHnIiVPlksmzaMejg+UtMmmQ84QP/hpGY/1y4LWGd6n6E84r+l5fIa
         E0ukBkWOif61VaUAcc47RSNb601xVJe6g3PRGHZ4=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 970696031A;
        Tue,  9 Oct 2018 20:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539118574;
        bh=6ncdQBBvka/drSAbkw/gkLt3bev/tSblfQichRnBk80=;
        h=Date:From:To:Cc:Subject:From;
        b=TpjYsrFULB9ZkJzLQKTOY8Zs0yGtvpmS94yE2z7ZY7IySnI4tC+BolCS+Pgr3+L5N
         oKtY09DOCeE4JpO++83XWe5Jlx9OKkq+DTpzCHpYWKjW812Z6/1kSo4+HWX/kfbiww
         ApR4oET70BE7lYdvl24230iKfTGd/++k+sVc5HIs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 09 Oct 2018 13:56:14 -0700
From:   Sodagudi Prasad <psodagud@codeaurora.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com,
        gregkh@linuxfoundation.org, ard.biesheuvel@linaro.org,
        robin.murphy@arm.com, ynorov@caviumnetworks.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: livelock with hrtimer cpu_base->lock
Message-ID: <8f671ebb6b331cd00ce17d111f28c548@codeaurora.org>
X-Sender: psodagud@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

This is regarding - thread "try to fix contention between expire_timers 
and try_to_del_timer_sync".
https://lkml.org/lkml/2017/7/28/172

I think this live lockup issue was discussed earlier but the final set 
of changes were not concluded.
I would like to check whether you have new updates on this issue or not. 
  This problem is observed with 4.14 .64 stable kernel too.
We see this problem 2 times in overnight testing.

I have to add the following code to avoid live lock. I am thinking that 
fixing this at the cpu_relax() level.

+++ b/kernel/time/hrtimer.c
@@ -52,6 +52,7 @@
  #include <linux/timer.h>
  #include <linux/freezer.h>
  #include <linux/compat.h>
+#include <linux/delay.h>

  #include <linux/uaccess.h>

@@ -152,6 +153,7 @@ struct hrtimer_clock_base *lock_hrtimer_base(const 
struct hrtimer *timer,
                         
raw_spin_unlock_irqrestore(&base->cpu_base->lock, *flags);
                 }
                 cpu_relax();
+               udelay(1);
         }
  }

@@ -1067,6 +1069,7 @@ int hrtimer_cancel(struct hrtimer *timer)
                 if (ret >= 0)
                         return ret;
                 cpu_relax();
+               udelay(1);
         }
  }
  EXPORT_SYMBOL_GPL(hrtimer_cancel);

Note:- Timer event streaming is enabled and still live lock observed.

-Thanks, Prasad

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project
