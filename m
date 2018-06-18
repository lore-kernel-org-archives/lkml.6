Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACFAC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 05:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E5D20874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 05:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hECJaZyN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E5D20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754714AbeFRF4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 01:56:36 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40663 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754013AbeFRF4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 01:56:34 -0400
Received: by mail-pg0-f66.google.com with SMTP id w8-v6so3977597pgp.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 22:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yMq6OMGQd5KEu4f4kTnJaODZzf8R3NT8lcJh8+yBCOg=;
        b=hECJaZyNI5n/cOtCuMqH90flzpJfxHZe75sFrJ4tcH3xAZXioWMUJnNQQN9UzxFkNG
         O3ZhG8ncXnvlysh5f81zwCCauVnb/R+w4NBgJN/F2nql47w18k3eLgZmOwvG/faOXh4E
         n2Pk1Xl5AhcLPmEkqkW247rM0SA1BnfrqX38k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=yMq6OMGQd5KEu4f4kTnJaODZzf8R3NT8lcJh8+yBCOg=;
        b=AmqV8HVuI+j4rBqxydNpoGnhRmj3Q6w5U8n4KTMEIUOvHoWQsy4AduSPgHeZ4OZdqf
         +9knDsQymK+cI6CogUZ8h9adsRcG4bymLu1mmnoMhtInEprGuICv6bteVCg/v6w/D/A0
         EcMKBTXgt1dZ6XIpZDwjLW+Mms8T19kXqdPtneTrM8Qf1I9NVGQ5lpuXF2BJrn3LqUkz
         Oil+z3iMEeMcEkFCLu5HIGR4VL4JQ9yQ46gkibBOP5ZlkwHwhTHfzuNoJEfZi/Lj7PkX
         Q13R+JKHcI6Bh9R+Rnu8Hf61JEUoNZycY9xoNy2By7DQ8ylObpHKEYMxWDWD7Hm86yAO
         N/QA==
X-Gm-Message-State: APt69E0k4Gcb8fGK2HPq14qxLPae3cwK80os4O7ypHFTXq89QxzIYlvt
        P/gQKITlvdWfWsSPmR0nx9sqSw==
X-Google-Smtp-Source: ADUXVKKbdDZl2jDxdhSUdZKVJ2YMVjQ5fxCpJHDNXWCZ5sHo8xZNAtz7/L5iLkLO0fqz3zJtH/bzwA==
X-Received: by 2002:a62:8a0a:: with SMTP id y10-v6mr12086653pfd.237.1529301393883;
        Sun, 17 Jun 2018 22:56:33 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id r26-v6sm33895357pfj.180.2018.06.17.22.56.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jun 2018 22:56:33 -0700 (PDT)
Date:   Mon, 18 Jun 2018 14:57:12 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     James Morse <james.morse@arm.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, ard.biesheuvel@linaro.org,
        tbaicar@codeaurora.org, bhsharma@redhat.com, dyoung@redhat.com,
        mark.rutland@arm.com, al.stone@linaro.org,
        graeme.gregory@linaro.org, hanjun.guo@linaro.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
Subject: Re: [PATCH 0/3] arm64: kexec,kdump: fix boot failures on acpi-only
 system
Message-ID: <20180618055711.GE23681@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, akpm@linux-foundation.org,
        ard.biesheuvel@linaro.org, tbaicar@codeaurora.org,
        bhsharma@redhat.com, dyoung@redhat.com, mark.rutland@arm.com,
        al.stone@linaro.org, graeme.gregory@linaro.org,
        hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com,
        sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
References: <20180615075623.13454-1-takahiro.akashi@linaro.org>
 <81a9a385-3b9f-113d-96f0-379be74c19f0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81a9a385-3b9f-113d-96f0-379be74c19f0@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James,

Thank you for follow-up explanation.
I have nothing to add :)

-Takahiro AKASHI

On Fri, Jun 15, 2018 at 05:29:32PM +0100, James Morse wrote:
> Hi Akashi,
> 
> Thanks for putting this together,
> 
> On 15/06/18 08:56, AKASHI Takahiro wrote:
> > This patch series is a set of bug fixes to address kexec/kdump
> > failures which are sometimes observed on ACPI-only system and reported
> > in LAK-ML before.
> > 
> > In short, the phenomena are:
> > 1. kexec'ed kernel can fail to boot because some ACPI table is corrupted
> >    by a new kernel (or other data) being loaded into System RAM. Currently
> >    kexec may possibly allocate space ignoring such "reserved" regions.
> >    We will see no messages after "Bye!"
> > 
> > 2. crash dump (kdump) kernel can fail to boot and get into panic due to
> >    an alignment fault when accessing ACPI tables. This can happen because
> >    those tables are not always properly aligned while they are mapped
> >    non-cacheable (ioremap'ed) as they are not recognized as part of System
> >    RAM under the current implementation.
> > 
> > After discussing several possibilities to address those issues,
> > the agreed approach, in my understanding, is
> > * to add resource entries for every "reserved", i.e. memblock_reserve(),
> >   regions to /proc/iomem.
> >   (NOMAP regions, also marked as "reserved," remains at top-level for
> >   backward compatibility.)
> 
> This means user-space can tell the difference between reserved-system-ram and
> reserved-address-space.
> 
> 
> > * For case (1), user space (kexec-tools) should rule out such regions
> >   in searching for free space for loaded data.
> 
> ... but doesn't today, because it fails to account for second-level entries.
> We've always had second-level entries, so this is a user-space bug. We need both
> fixed to fix the issue.
> 
> Our attempts to fix this just in the kernel reached a dead end, because Kdump
> needs to include reserved-system-ram, whereas kexec has to avoid it. User-space
> needs to be able to tell reserved-system-ram and reserved-address-space apart.
> Hence we need to expose that information, and pick it up in user-space.
> 
> Patched-kernel and unpatch-user-space will work the same way it does today, as
> the additional reserved regions are ignored by user-space.
> 
> Unpatched-kernel and patched-user-space will also work the same way it does
> today as the additional reserved regions are missing.
> 
> I think this is the only way forwards on this issue...
> 
> 
> > * For case (2), the kernel should access ACPI tables by mapping
> >   them with appropriate memory attributes described in UEFI memory map.
> >   (This means that it doesn't require any changes in /proc/iomem, and
> >   hence user space.)
> 
> (this one is handled entirely in the kernel)
> 
> 
> Thanks,
> 
> James
