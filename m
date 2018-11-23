Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95726C43610
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D6B20861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51D6B20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409025AbeKWUKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:10:33 -0500
Received: from foss.arm.com ([217.140.101.70]:38976 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409000AbeKWUKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:10:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4477535F5;
        Fri, 23 Nov 2018 01:27:06 -0800 (PST)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1AA03F5CF;
        Fri, 23 Nov 2018 01:27:04 -0800 (PST)
To:     Peter Anvin <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        James Morse <james.morse@arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Subject: Sleeping in user_access section
Message-ID: <3e881ee6-0ff6-b8b6-0633-3d4a7743411d@arm.com>
Date:   Fri, 23 Nov 2018 09:27:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I made an attempt at implementing the 
user_access_begin()/user_access_end() macros along with the 
get/put_user_unsafe() for arm64 by toggling the status of PAN (more or 
less similar to x86's STAC/CTAC).

With a small mistake in my patch, we realized that directly calling 
function that could reschedule while in a user_access section could lead to:

- scheduling another task keeping the user_access status enabled despite 
the task never calling user_access_begin()

- when re-scheduling the task that was mid user_access section, 
user_access would be disabled and the task would fault on the next 
get/put_user_unsafe.


This is because __switch_to does not alter the user_access status when 
switching from next to prev (at least on arm64 we currently don't, and 
by looking at the x86 code I don't think this is done either).


 From my understanding, this is not an issue when the task in 
user_access mode gets scheduled out/in as a result of an interrupt as 
PAN and EFLAGS.AC get saved/restore on exception entry/exit (at least I 
know it is the case for PAN, I am less sure for the x86 side).


So, the question is, should __switch_to take care of the user_access 
status when scheduling new tasks? Or should there be a restriction about 
scheduling out a task with user_access mode enabled and maybe add a 
warning if we can detect this?

(Or did we miss something and this is not an issue on x86?)

Thanks,

-- 
Julien Thierry
