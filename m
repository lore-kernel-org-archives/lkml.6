Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C255C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB5B214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbfAJKcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 05:32:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44098 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbfAJKcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 05:32:51 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 60C0C7970A;
        Thu, 10 Jan 2019 10:32:51 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E466A672C4;
        Thu, 10 Jan 2019 10:32:48 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Tony Luck <tony.luck@gmail.com>, Borislav Petkov <bp@alien8.de>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <Babu.Moger@amd.com>, X86-ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        =?utf-8?Q?Jan_H=2E_Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        David Duncan <davdunc@amazon.com>
Subject: Re: [PATCH] x86/intel_rdt: use rdmsr_safe() to workaround AWS host issue
In-Reply-To: <CA+8MBbLh2JyWg=AF-cftrCfDB8QgRwJ2sKV-S24Jqtu_y1qZrg@mail.gmail.com>
References: <20181220134046.7916-1-vkuznets@redhat.com> <20181220161722.GD31403@zn.tnic> <51dcb13a-4751-47f5-1e01-f6731a2c6f3c@intel.com> <20521afe-09af-7acf-6f32-3f6e9a971091@intel.com> <20190109113915.GB15665@zn.tnic> <87bm4qoww4.fsf@vitty.brq.redhat.com> <20190109121445.GC15665@zn.tnic> <CA+8MBbLh2JyWg=AF-cftrCfDB8QgRwJ2sKV-S24Jqtu_y1qZrg@mail.gmail.com>
Date:   Thu, 10 Jan 2019 11:32:47 +0100
Message-ID: <87woncol9s.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 10 Jan 2019 10:32:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Luck <tony.luck@gmail.com> writes:

> On Wed, Jan 9, 2019 at 5:00 AM Borislav Petkov <bp@alien8.de> wrote:
>>
>> On Wed, Jan 09, 2019 at 01:09:31PM +0100, Vitaly Kuznetsov wrote:
>> > Hm, why is that? In theory, hypervisors can pass through or emulate the
>> > required MSRs...
>>
>> ...and when the theory becomes reality we'll remove the check.
>
> In practice that may be a long time coming. We don't have many CLOSIDs, or
> bits in a cache mask, at the h/w level. If you start trying to
> subdivide those resources to pass a subset to a guest, then you'll
> quickly find that you have no flexibility in the guest to do anything
> useful.  It would only work if you limited to two, or perhaps three
> guests.

Running a single guest on a physical CPU is a very common scenario. In
fact, sharing cores is very rare for public clouds: e.g. all worthy
instance types on AWS/Azure give you dedicated cores and I don't see why
hypervisor can't pass through resctl features.

The other thing is: how can we be sure that there's no hypervisor
exposing these feature already? Even if open-source hypervisors like
KVM/Xen don't do it it doesn't prove anything: there are numerous
proprietary hypervisors and who knows what they do.

The original issue which triggered the discussion was discovered on AWS
Xen where the host is buggy and I suggested a simple short-term
workaround, I'm no expert in rdt/qos so I'm leaving this up to the
maintainers to decide which fix deserves to go in (if any).

-- 
Vitaly
