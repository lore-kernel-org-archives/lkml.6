Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA270C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44DA520658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="f6fBOM6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44DA520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mailbox.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbeH3O5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 10:57:10 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:20924 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728195AbeH3O5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 10:57:10 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id D017940EE8;
        Thu, 30 Aug 2018 12:55:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-language:content-type
        :content-type:mime-version:date:date:message-id:subject:subject
        :from:from:received; s=mail20150812; t=1535626532; bh=FGUtwiiP0C
        PfsCgkDaL23T/25MIZEpRU2dUdVVByj2s=; b=f6fBOM6V8la7zrNpht+RLyLzIY
        jgn8pdYK0KtSAPF8uULT9vaSuakClcxEwKadSqMYdinpZ/au+19+RssRRVY25vWH
        EkGp2rlsmPediuQcOIxYA/bKWQZWvD63SlEk5VcCHobOZNoSB85RzIxQVz213Mx4
        Yfwe/t3AeYJCY0EVj17M9j9dQ6HoBZLWBdagOXOlWXHD2ltePh6jzZ9meERJzT5L
        X5tOS4mKrQH6MjRl+ja2QyW+UpY1ejFzhpL6vFn/FxGZvDcddkiJnRm0nZaXN/ur
        Er36tpTczh2kzv402rkF3BdKctANX+zVFQhDKPqB27o2exqun0Egbcm4K6Lw==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id XqseTK0zwzzs; Thu, 30 Aug 2018 12:55:32 +0200 (CEST)
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, tglx@linutronix.de,
        rafael.j.wysocki@intel.com, len.brown@intel.com, rjw@rjwysocki.net,
        diego.viola@gmail.com, rui.zhang@intel.com,
        viktor_jaegerskuepper@freenet.de
From:   Siegfried Metz <frame@mailbox.org>
Subject: REGRESSION: boot stalls on several old dual core Intel CPUs
Message-ID: <74c5abc8-7430-5bc9-2f8a-a2205608bee7@mailbox.org>
Date:   Thu, 30 Aug 2018 12:55:30 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear kernel developers,

since mainline kernel 4.18 (up to the latest mainline kernel 4.18.5)
Intel Core 2 Duo processors are affected by boot stalling early in the
boot process. As it is so early there is no dmesg output (or any log).

A few users in the Arch Linux community used git bisect and tracked the
issue down to this the bad commit:
7197e77abcb65a71d0b21d67beb24f153a96055e clocksource: Remove kthread

Either reverting the bad commit or as a workaround using an additional
kernel boot parameter "clocksource=hpet" has been successfully used to
boot with Intel Core 2 processors and avoid the stalling.

clocksource= options parameters are one of "tsc", "hpet", "acpi_pm",
most of the time hpet did the trick.


Additional information:
Kernel 4.17.19 is unaffected by this issues, kernel 4.18 series and
4.19-rc1 are still affected.

Also there is the bug-report:
https://bugzilla.kernel.org/show_bug.cgi?id=200957
and a duplicate one:
https://bugzilla.kernel.org/show_bug.cgi?id=200959


Thanks for fixing this issue.

Siegfried
