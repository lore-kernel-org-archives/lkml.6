Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B702C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11CE121582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11CE121582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388466AbeKPCrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 21:47:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39174 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387839AbeKPCrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 21:47:43 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D7AB53078A50;
        Thu, 15 Nov 2018 16:39:10 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.34.244.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CFBE1A92D;
        Thu, 15 Nov 2018 16:39:03 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Ahmed Soliman <ahmedsoliman@mena.vt.edu>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        Andrew Jones <drjones@redhat.com>
Subject: Re: KVM selftests are failing
In-Reply-To: <CANBxJ=EGR=7RrO8ZtJFUwpNZRy_adjCObNtWtcMA=y4rLgeWaQ@mail.gmail.com>
References: <CANBxJ=EQOt1t=PkLsMvtfB2SbiLMPeGvFxB7SJXf7m3OkcionQ@mail.gmail.com> <20181114180807.6crs7awhvo26ldbr@hawk.localdomain> <CADYN=9Jh10guVNFfhS8XH+RwZAouLJQu7Svg4+Tz3rQDexzDkg@mail.gmail.com> <CANBxJ=G4xdF8ZOR4zyoX1edNa=jYxk1xrzoi+7Xgcqt9qDoM2w@mail.gmail.com> <CANBxJ=EB8izWM8iLd49Uvd1z1O-gLvkGmiKNHjfHifFohj2xbg@mail.gmail.com> <20181115090203.5z25gwa2yznj6mmu@kamzik.brq.redhat.com> <CANBxJ=EHkuxKFoQw=K21o=9_FMhi_=on=Poq+ZF37eieoKV4zg@mail.gmail.com> <20181115145028.qijg7hjswcuabrt2@kamzik.brq.redhat.com> <CANBxJ=EGR=7RrO8ZtJFUwpNZRy_adjCObNtWtcMA=y4rLgeWaQ@mail.gmail.com>
Date:   Thu, 15 Nov 2018 17:39:01 +0100
Message-ID: <87efbmqore.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 15 Nov 2018 16:39:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ahmed Soliman <ahmedsoliman@mena.vt.edu> writes:

> Hello,
> On Thu, Nov 15, 2018 at 4:50 PM Andrew Jones <drjones@redhat.com> wrote:
>>
>> On Thu, Nov 15, 2018 at 03:36:44PM +0200, Ahmed Soliman wrote:
>> > mmap(NULL, 6291456, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
>> > -1, 0) = 0x7f46ea2a1000
>> > madvise(0x7f46ea2a1000, 6291456, MADV_NOHUGEPAGE) = -1 EINVAL (Invalid argument)
>> >
>> > For comprehension, this is done on intel core i7-4500U CPU @ 1.80GHz
>>
>> Argh. I see what it is. Your config doesn't have CONFIG_TRANSPARENT_HUGEPAGE=y,
>> so madvise_behavior_valid() returns false, which causes madvise() to
>> immediately return EINVAL. We should be more careful in kvm selftests with
>> our madvise behavior use.
>>
>> >
>> > As for now I will comment the madvise line and the assert when writing
>> > my own kvm self test. I think it wouldn't cause any trouble?, If it is
>> > not the case, please let me know.
>> >
>>
>> You may not need madvise() at all for your test, depending on what you're
>> doing. So leaving it out may be fine. Reworking kvm selftests to ensure
>> only valid madvise behaviors are used (and only when necessary), before
>> adding new tests, would be best.
>
> Confirmed it worked after CONFIG_TRANSPARENT_HUGEPAGE=y
> I will send a patch soon that should make the self test check if
> Transparent huge pages are enabled first before issuing the related
> madvise()

Just ignore -EINVAL returned from madvise(), QEMU went even further,
see:

commit 1d7414396f926651c4d7a673eb3a10aca5246d76
Author: Dr. David Alan Gilbert <dgilbert@redhat.com>
Date:   Thu Nov 19 15:27:48 2015 +0000

    Assume madvise for (no)hugepage works

-- 
Vitaly
