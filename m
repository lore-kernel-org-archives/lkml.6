Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18993C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D922E20864
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D922E20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409228AbeKWUl3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:41:29 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37531 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388367AbeKWUl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:41:29 -0500
Received: from wld62.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id wAN9vIpR4153615
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 23 Nov 2018 01:57:19 -0800
Date:   Fri, 23 Nov 2018 01:57:12 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <3e881ee6-0ff6-b8b6-0633-3d4a7743411d@arm.com>
References: <3e881ee6-0ff6-b8b6-0633-3d4a7743411d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: Sleeping in user_access section
To:     Julien Thierry <julien.thierry@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        James Morse <james.morse@arm.com>
From:   hpa@zytor.com
Message-ID: <5B3B6AF9-9D8C-4577-905E-D407A5E7D0E3@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On November 23, 2018 1:27:02 AM PST, Julien Thierry <julien.thierry@arm.com> wrote:
>Hi,
>
>I made an attempt at implementing the 
>user_access_begin()/user_access_end() macros along with the 
>get/put_user_unsafe() for arm64 by toggling the status of PAN (more or 
>less similar to x86's STAC/CTAC).
>
>With a small mistake in my patch, we realized that directly calling 
>function that could reschedule while in a user_access section could
>lead to:
>
>- scheduling another task keeping the user_access status enabled
>despite 
>the task never calling user_access_begin()
>
>- when re-scheduling the task that was mid user_access section, 
>user_access would be disabled and the task would fault on the next 
>get/put_user_unsafe.
>
>
>This is because __switch_to does not alter the user_access status when 
>switching from next to prev (at least on arm64 we currently don't, and 
>by looking at the x86 code I don't think this is done either).
>
>
> From my understanding, this is not an issue when the task in 
>user_access mode gets scheduled out/in as a result of an interrupt as 
>PAN and EFLAGS.AC get saved/restore on exception entry/exit (at least I
>
>know it is the case for PAN, I am less sure for the x86 side).
>
>
>So, the question is, should __switch_to take care of the user_access 
>status when scheduling new tasks? Or should there be a restriction
>about 
>scheduling out a task with user_access mode enabled and maybe add a 
>warning if we can detect this?
>
>(Or did we miss something and this is not an issue on x86?)
>
>Thanks,

You should never call a sleeping function from a user_access section. It is intended for very limited regions.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
