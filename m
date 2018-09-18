Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C099CECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5AA2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5AA2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbeISCo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 22:44:56 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:51145 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbeISCo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 22:44:56 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g2NGQ-0007RN-Uy; Tue, 18 Sep 2018 15:10:30 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g2NGA-0001XO-MX; Tue, 18 Sep 2018 15:10:30 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org
References: <87y3bzk6yv.fsf@xmission.com>
        <alpine.DEB.2.21.1809182253220.1468@nanos.tec.linutronix.de>
Date:   Tue, 18 Sep 2018 23:10:06 +0200
In-Reply-To: <alpine.DEB.2.21.1809182253220.1468@nanos.tec.linutronix.de>
        (Thomas Gleixner's message of "Tue, 18 Sep 2018 22:55:08 +0200
        (CEST)")
Message-ID: <87zhweh5qp.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1g2NGA-0001XO-MX;;;mid=<87zhweh5qp.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+pZQAaEj/6O8tJlh5tXjS7/lm3FPBqfeQ=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [REVIEW][PATCH 00/20] siginfo cleanups for x86
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> On Tue, 18 Sep 2018, Eric W. Biederman wrote:
>> I have been slowly going thought and reworking the arch specific
>> functions that generate siginfo.  The problems I have been addressing
>> is that using siginfo directly is error prone.  Using siginfo directly
>> makes it easy to leave fields initialized, and get confused about
>> which fields need to be filled in.
>> 
>> To address this I have added a series of helper functions to
>> kernel/signal.c, that are specific to exactly one use of struct siginfo
>> and take the parameters they need.
>> 
>> To use these functions the x86 signal handling needs some cleanups but
>> the net result appears to be less code that is easier to follow.
>> 
>> If while looking over these patches you see anything please let me know.
>
> Only nitpicks.
>
>> I don't think I missed something but to err is human.
>
> I went through the changes a couple of times, but failed to spot
> something. Was pleasure to read that set!
>
>> Likewise if you would like to merge these patches via the tip tree
>> let me know.  Otherwise after the review is complete I plan on merging
>> these into my siginfo tree.  At this point I believe all of the
>> prerequisite patches are merged so it should not make a difference.
>
> Works either way. Ingo?

If I manage to get through all of the architecture specific code I can
shrink the in-kernel version of struct siginfo.    So there is a slight
advantage to having it all in my tree.  But worst case I just have to
wait another cycle which doesn't look like a particularly long wait at
this point.

Eric
