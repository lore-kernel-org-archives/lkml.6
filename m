Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B3672C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B94208AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B94208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933819AbeFLApU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 20:45:20 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:56530 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932893AbeFLApS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 20:45:18 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fSXQz-0005s5-Pg; Mon, 11 Jun 2018 18:45:17 -0600
Received: from 97-119-124-205.omah.qwest.net ([97.119.124.205] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fSXQz-0005QE-7j; Mon, 11 Jun 2018 18:45:17 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     "Farnitano\, Jarrett" <jmf@amazon.com>
Cc:     "kexec\@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1528738546-3328-1-git-send-email-jmf@amazon.com>
        <87po0xszdx.fsf@xmission.com>
        <588FC7E2-C106-456A-81E7-A98F99F0E392@amazon.com>
Date:   Mon, 11 Jun 2018 19:45:11 -0500
In-Reply-To: <588FC7E2-C106-456A-81E7-A98F99F0E392@amazon.com> (Jarrett
        Farnitano's message of "Mon, 11 Jun 2018 23:47:46 +0000")
Message-ID: <87bmcgsui0.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1fSXQz-0005QE-7j;;;mid=<87bmcgsui0.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18kVqlagV0to1WidfJX5TdbnyQ3HBk29vU=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] kexec: yield to scheduler when loading kimage segments
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Farnitano, Jarrett" <jmf@amazon.com> writes:

>> ﻿On 6/11/18, 4:00 PM, "Eric W. Biederman" <ebiederm@xmission.com> wrote:
>> 
>>     Is there a practical problem with unresponsiveness?  You are talking
>>     an embedded machine and rarely are there people in front of embedded
>>     computers these days.
>
> I did run into a practical problem. Hardware watchdogs on embedded
> systems can have short timers on the order of seconds. If the system
> is locked up for a few seconds with only a single core available, the
> watchdog may not be pet in a timely fashion. If this happens, the
> hardware watchdog will fire and reset the system.
>
> This really only becomes a problem when you are working with a single
> core, a decently sized initrd, and have a constrained hardware
> watchdog.

That would do it.

My foggy memory says this was not included back in the days where
cond_resched was spelled "if (need_resched) schedule();"  There were
concerns with spreading that too thin.  cond_resched in this path seems
as reasonable as anything.

Eric
