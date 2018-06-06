Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ugMxA89lGFtRUgAAmS7hNA
	; Wed, 06 Jun 2018 22:53:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AF0A1608B8; Wed,  6 Jun 2018 22:53:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2EACD601C3;
	Wed,  6 Jun 2018 22:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2EACD601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752789AbeFFWxT convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 25 others);
        Wed, 6 Jun 2018 18:53:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51431 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752026AbeFFWxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 18:53:17 -0400
Received: from wld62.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w56Mr9b71974975
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 6 Jun 2018 15:53:10 -0700
Date: Wed, 06 Jun 2018 15:53:02 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMzpN2iE1zba6g6Jh5LzzuX1AM+SskiwVtVi8WtcB+4dD2mJGQ@mail.gmail.com>
References: <1528302199-29619-1-git-send-email-chang.seok.bae@intel.com> <1528302199-29619-8-git-send-email-chang.seok.bae@intel.com> <CALCETrWsWbyyFC9p5POY8-Xbu8Tw-OhhD_m-5P8b4oYseQfYGQ@mail.gmail.com> <CAMzpN2iE1zba6g6Jh5LzzuX1AM+SskiwVtVi8WtcB+4dD2mJGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v2 7/8] x86/segments/32: Introduce CPU_NUMBER segment
To: Brian Gerst <brgerst@gmail.com>, Andy Lutomirski <luto@kernel.org>
CC: "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
From: hpa@zytor.com
Message-ID: <F261317E-688B-4638-AB58-75355D97FD6C@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On June 6, 2018 12:07:15 PM PDT, Brian Gerst <brgerst@gmail.com> wrote:
>On Wed, Jun 6, 2018 at 1:16 PM, Andy Lutomirski <luto@kernel.org>
>wrote:
>> On Wed, Jun 6, 2018 at 9:23 AM Chang S. Bae
><chang.seok.bae@intel.com> wrote:
>>>
>>> The new entry will be equivalent to that of x86-64 which
>>> stores CPU number. The entry is placed in segment 23 in GDT
>>> by bumping down 23-28 by one, which are all kernel-internal
>>> segments and so have no impact on user space.
>>>
>>> CPU_NUMBER segment will always be at '%ss (USER_DS) + 80'
>>> for the default (flat, initial) user space %ss.
>>
>> No, it won't :(  This is because, on Xen PV, user code very
>frequently
>> sees a different, Xen-supplied "flat" SS value.  This is definitely
>> true right now on 64-bit, and I'm reasonably confident it's also the
>> case on 32-bit.
>>
>> As it stands, as far as I can tell, we don't have a "cpu number"
>> segment on 32-bit kernels.  I see no compelling reason to add one,
>and
>> we should definitely not add one as part of the FSGSBASE series.  I
>> think the right solution is to rename the 64-bit segment to
>> "CPU_NUMBER" and then have the rearrangement of the initialization
>> code as a followup patch.  The goal is to make the patches
>> individually reviewable.  As it stands, this patch adds some #defines
>> without making them work, which is extra confusing.
>>
>> Given how many times we screwed it up, I really want the patch that
>> moves the initialization of the 64-bit CPU number to be obviously
>> correct and to avoid changing the sematics of anything except the
>> actual CPU number fields during boot.
>>
>> So NAK to this patch, at least as part of the FSGSBASE series.
>>
>> (My apologies -- a bunch of this is because I along with everyone
>else
>> misunderstood the existing code.)
>
>The sole purpose of this segment is for the getcpu() function in the
>VDSO.  No other userspace code can rely on its presence or location.
>
>--
>Brian Gerst

Unfortunately that is not true in reality :(
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
