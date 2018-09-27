Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6175FC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F1921533
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05F1921533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeI0P5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:57:21 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:53396 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbeI0P5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:57:20 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g5Sm1-0000i0-MF; Thu, 27 Sep 2018 03:39:53 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g5Sm0-0006oo-H8; Thu, 27 Sep 2018 03:39:53 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <871s9j462u.fsf@xmission.com>
        <20180926173841.GD175719@arrakis.emea.arm.com>
Date:   Thu, 27 Sep 2018 11:39:35 +0200
In-Reply-To: <20180926173841.GD175719@arrakis.emea.arm.com> (Catalin Marinas's
        message of "Wed, 26 Sep 2018 18:38:42 +0100")
Message-ID: <87ftxvs2i0.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1g5Sm0-0006oo-H8;;;mid=<87ftxvs2i0.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19mhsuTzrR+swoaCRJ7qkJqyNxWeL/osKc=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [REVIEW][PATCH 00/15] signal/arm64: siginfo cleanups
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Catalin Marinas <catalin.marinas@arm.com> writes:

> Hi Eric,
>
> On Mon, Sep 24, 2018 at 11:07:05AM +0200, Eric W. Biederman wrote:
>> This is the continuation of my work to sort out signaling of exceptions
>> with siginfo.  The old signal sending functions by taking a siginfo
>> argument resulted in their callers having to deal with the fiddly nature
>> of siginfo directly.  In small numbers of callers this is not a problem
>> but in the number of callers in the kernel this resulted in cases
>> where fields were not initialized or improperly initialized before
>> being passed to userspace.
>> 
>> To avoid having to worry about those issues I have added new signal
>> sending functions that each deal wit a different siginfo case.  When
>> using these functions there is no room for the fiddly nature of siginfo
>> to cause mistakes.
>> 
>> This is my set of changes to update arm64 to use those functions.
>> Along with some refactoring so those functions can be cleanly used.
>> 
>> Folks please review and double check me.  I think I have kept these
>> changes simple and obviously correct but I am human and mess up
>> sometimes.
>
> Nice clean-up, thanks. I started reviewing the patches, I should finish
> by tomorrow (I also applied them locally to give some testing).
>
>> After these patches have had a chance to be reviewed I plan to merge
>> them by my siginfo tree.  If you would rather take them in the arm64
>> tree let me know.   All of the prerequisites should have been merged
>> through Linus's tree several releases ago.
>
> Either way works for me. There is a trivial conflict in
> force_signal_inject() with the arm64 for-next/core tree so I could as
> well put them on top of this branch and send them during the 4.20
> merging window.

As long as there is a trivial conflict I would like to keep everything
in one tree.

There is a following patchset that manages to reduce the size of struct
siginfo in the kernel that I have also posted for review.    With
everything in one tree I can make that change now, and just cross it off
my list of things to worry about.

Eric

