Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E9DC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F43520882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbfA3MW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 07:22:27 -0500
Received: from ozlabs.org ([203.11.71.1]:57287 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfA3MW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 07:22:26 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43qMv31SbXz9s9h;
        Wed, 30 Jan 2019 23:22:23 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Jiri Kosina <jikos@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        live-patching@vger.kernel.org,
        Balbir Singh <bsingharora@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nicolai Stange <nstange@suse.de>, Torsten Duwe <duwe@lst.de>
Subject: Re: [PATCH 0/4] powerpc/livepatch: reliable stack unwinder fixes
In-Reply-To: <nycvar.YFH.7.76.1901300049470.6626@cbobk.fhfr.pm>
References: <20190122155724.27557-1-joe.lawrence@redhat.com> <nycvar.YFH.7.76.1901300049470.6626@cbobk.fhfr.pm>
Date:   Wed, 30 Jan 2019 23:22:22 +1100
Message-ID: <87y372pc75.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Kosina <jikos@kernel.org> writes:
> On Tue, 22 Jan 2019, Joe Lawrence wrote:
>
>> This patchset fixes a false negative report (ie, unreliable) from the
>> ppc64 reliable stack unwinder, discussed here [1] when it may
>> inadvertently trip over a stale exception marker left on the stack.
>> 
>> The first two patches fix this bug.  Nicolai's change clears the marker
>> from the stack when an exception is finished.  The next patch modifies
>> the unwinder to only look for such on stack elements when the ABI
>> guarantees that they will actually be initialized.
>> 
>> The final two patches consist of code cleanups that Nicolai and I
>> spotted during the development of the fixes.
>> 
>> Testing included re-running the original test scenario (loading a
>> livepatch module on ppc64le) on a 5.0.0-rc2 kernel as well as a RHEL-7
>> backport.  I ran internal tests on the RHEL-7 backport and no new test
>> failures were introduced.  I believe that Nicolai has done the same
>> with respect to the first patch.
>> 
>> [1] https://lore.kernel.org/lkml/7f468285-b149-37e2-e782-c9e538b997a9@redhat.com/
>> 
>> Joe Lawrence (3):
>>   powerpc/livepatch: relax reliable stack tracer checks for first-frame
>>   powerpc/livepatch: small cleanups in save_stack_trace_tsk_reliable()
>>   powerpc/livepatch: return -ERRNO values in
>>     save_stack_trace_tsk_reliable()
>> 
>> Nicolai Stange (1):
>>   powerpc/64s: Clear on-stack exception marker upon exception return
>
> Michael, are you fine with this going through LP tree, or do you plan to 
> take it through yours?

I'm happy to take it, unless there's some reason you'd rather it go via
the LP tree?

I don't have any automated live patch tests, but I assume if it's in
linux-next someone can test it? :)

cheers
