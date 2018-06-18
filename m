Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C93DC5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9AE20836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzlgSDH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C9AE20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755423AbeFRVde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 17:33:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755386AbeFRVdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 17:33:33 -0400
Received: from mail-wr0-f170.google.com (mail-wr0-f170.google.com [209.85.128.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B68120852
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 21:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529357612;
        bh=V85O7nWFSZGjaL46G6qYHcLRh0WWKpLmV16XW3Ow1eg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gzlgSDH197Hy2Lja5bJ8Rs21VWywpAsyrppy+LDuJLk6Cx9I0YW8SckGYcWbSccVg
         6tZQSe5dKNdlJejMfMACmTEdbqcLBIDr6aOAWbBpoB5YeN3eH7GJ/p1/g6D5ibnhTn
         0su/6aBBGLnZBE3Z4/Cd02f3IL6ulgv/JciQSjKs=
Received: by mail-wr0-f170.google.com with SMTP id d8-v6so18344695wro.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 14:33:32 -0700 (PDT)
X-Gm-Message-State: APt69E1hqd0O5tpa7GFcdl1LE9shhOx60aoR05DLu1/Qu2x7OSUCFdOo
        wsTGWDN1RH/MAq2u6O4I/JecYwLgpoHQ/0lfafaxRg==
X-Google-Smtp-Source: ADUXVKL7AGt/ypvImMnoydSDi2BYydfZ0wJJebCqT/ggjdD3aB/7703x5JKaXJ5xPbOLpVRVK05dKnKkQ2ipR7vtKl0=
X-Received: by 2002:adf:85ec:: with SMTP id 41-v6mr11727642wru.120.1529357610781;
 Mon, 18 Jun 2018 14:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
 <20180608171216.26521-10-jarkko.sakkinen@linux.intel.com> <78982a32-c589-48e2-9a83-fd36903b5588@fortanix.com>
In-Reply-To: <78982a32-c589-48e2-9a83-fd36903b5588@fortanix.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 18 Jun 2018 14:33:18 -0700
X-Gmail-Original-Message-ID: <CALCETrXTjjiARJf=pc3mqrot3_VDoQtZM=PJg=fpg=P1x63jyw@mail.gmail.com>
Message-ID: <CALCETrXTjjiARJf=pc3mqrot3_VDoQtZM=PJg=fpg=P1x63jyw@mail.gmail.com>
Subject: Re: [intel-sgx-kernel-dev] [PATCH v11 09/13] x86, sgx: basic routines
 for enclave page cache
To:     Jethro Beekman <jethro@fortanix.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        X86 ML <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        npmccallum@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        intel-sgx-kernel-dev@lists.01.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 8:11 AM Jethro Beekman <jethro@fortanix.com> wrote:
>
> On 2018-06-08 10:09, Jarkko Sakkinen wrote:
> > +/*
> > + * Writing the LE hash MSRs is extraordinarily expensive, e.g.
> > + * 3-4x slower than normal MSRs, so we use a per-cpu cache to
> > + * track the last known value of the MSRs to avoid unnecessarily
> > + * writing the MSRs with the current value.  Because most Linux
> > + * kernels will use an LE that is signed with a non-Intel key,
>
> I don't think you can predict what most Linux kernels will be doing. I
> think not initializing the cache to the CPU's initial value is fine, but
> this particular argument shouldn't appear in the rationale.

No, it's quite predictable.  Upstream Linux will not permit the
Intel-signed LE to be used unless Intel makes some major changes to
the way the launch process works.

>
> > + * i.e. the first EINIT will need to write the MSRs regardless
> > + * of the cache, the cache is intentionally left uninitialized
> > + * during boot as initializing the cache would be pure overhead
> > + * for the majority of systems.

But the comment does need changes.  How about saying that the cache
either contains all zeros or matches the MSRs?  All zeros is used
when, for whatever reason, we choose not to care what the current MSR
values are.  Leaving it genuinely uninitialized would be incorrect.
(And, of course, we're assuming that no one ever needs the MSRs
zeroed.)

When KVM host support goes in, even this won't be good enough if we
want to allow passthrough access to the MSRs because we will no longer
be able to guarantee that all zeros is invalid.  Instead we'd need an
actual flag saying that the cache is invalid.

--Andy
