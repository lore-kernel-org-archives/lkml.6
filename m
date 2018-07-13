Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFF1ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430E220849
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430E220849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbeGMOBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 10:01:31 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:57761 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729632AbeGMOBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 10:01:31 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fdyPG-0004jk-6d; Fri, 13 Jul 2018 07:46:46 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fdyP0-0000N2-Qc; Fri, 13 Jul 2018 07:46:46 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Pavel Emelyanov <xemul@virtuozzo.com>
Cc:     Adrian Reber <adrian@lisas.de>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrei Vagin <avagin@virtuozzo.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux-foundation.org>
References: <20180712130733.11510-1-adrian@lisas.de>
        <87sh4o5s82.fsf@xmission.com>
        <23f87cb4-cdf5-0f9c-c7b9-a0abb228b77f@virtuozzo.com>
Date:   Fri, 13 Jul 2018 08:46:25 -0500
In-Reply-To: <23f87cb4-cdf5-0f9c-c7b9-a0abb228b77f@virtuozzo.com> (Pavel
        Emelyanov's message of "Fri, 13 Jul 2018 11:35:50 +0300")
Message-ID: <87sh4nz1se.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fdyP0-0000N2-Qc;;;mid=<87sh4nz1se.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19GJK7D/fXrYfqF2UfCPrzI329Bl//Hnlg=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] kconfig: remove EXPERT from CHECKPOINT_RESTORE
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Emelyanov <xemul@virtuozzo.com> writes:

> On 07/12/2018 07:33 PM, Eric W. Biederman wrote:
>> 
>> Adrian Reber <adrian@lisas.de> writes:
>> 
>>> The CHECKPOINT_RESTORE configuration option was introduced in 2012 and
>>> combined with EXPERT. CHECKPOINT_RESTORE is already enabled in many
>>> distribution kernels and also part of the defconfigs of various
>>> architectures.
>>>
>>> To make it easier for distributions to enable CHECKPOINT_RESTORE this
>>> removes EXPERT and moves the configuration option out of the EXPERT
>>> block.
>> 
>> I think we should change the help text at the same time, to match
>> our improve understanding of the situation.
>> 
>> Does anyone remember why this option was added at all?
>
> Sure! Quoting Andrew's ~7 years ago akpm branch merge e-mail:
>
>    However I'm less confident than the developers that it will all
>    eventually work! So what I'm asking them to do is to wrap each piece
>    of new code inside CONFIG_CHECKPOINT_RESTORE.  So if it all
>    eventually comes to tears and the project as a whole fails, it should
>    be a simple matter to go through and delete all trace of it.
>
> the best link with full e-mail I googled for is
> https://gitlab.imag.fr/kaunetem/linux-kaunetem/commit/099469502f62fbe0d7e4f0b83a2f22538367f734

Good explanation.  Thank you.

At this point we even have not CRIU users of some of the pieces.
The project as a whole has not failed.

The code is old enough an common enough (enabled in some distros) that
we need to do the whole watch out for regressions if we remove any part
of it.

Which is a long way of saying the original justifiction for
CONFIG_CHECKPOINT_RESTORE is gone.  So please let's remove the entire
config option and simplify everyone's lives who has to test this stuff.

Unless someone can come up with a justification for keeping some of this
behind a config option.

Eric
