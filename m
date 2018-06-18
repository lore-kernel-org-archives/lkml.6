Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74506C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EAB720836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2UKpQ3k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EAB720836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964811AbeFRVrU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 17:47:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755347AbeFRVrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 17:47:18 -0400
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13B4020852
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 21:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529358438;
        bh=MCS0vo9fUt2JrQLC8B4aN1g9EmGSfbG/GbNOGDPWcwc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G2UKpQ3k61BvYEuD807vxFB5iY0le9YKLF+XSy+5guGqqGG0ev2cU3hNuHyhKRESx
         oUlokqL1ZkrFM456yW4OH10OX1IPbvzAaODg3NuCi8p5YDm3xy/bEwfFn6/EYzZYb5
         ZkRbpdRNVDeGS7yuqpX+JHYRTVLKMsECz1avHqrE=
Received: by mail-wm0-f49.google.com with SMTP id r15-v6so16492399wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 14:47:18 -0700 (PDT)
X-Gm-Message-State: APt69E22yZX+fBUedlnG3ETPJcJrs+s94U+8xlB1Bzui/6tomNGIEKEM
        w3vdIKBStIiQV534kNolMqNb/t/Hi5GV53DOfDX7OA==
X-Google-Smtp-Source: ADUXVKIHyI/e9lOCkaULNZqbzMLu8DDpZOTPiRWja9qRHZGIZ2ypBtb0BAJzNT+GzbsfILvXXmcxsJ+3gWNCPdnTV7A=
X-Received: by 2002:a1c:b947:: with SMTP id j68-v6mr9330493wmf.144.1529358436552;
 Mon, 18 Jun 2018 14:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <DM5PR11MB201156F1CAB2592B07C79A03B17D0@DM5PR11MB2011.namprd11.prod.outlook.com>
In-Reply-To: <DM5PR11MB201156F1CAB2592B07C79A03B17D0@DM5PR11MB2011.namprd11.prod.outlook.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 18 Jun 2018 14:47:05 -0700
X-Gmail-Original-Message-ID: <CALCETrXUdLZTnf0EF2LVM4ru2G6nkFX--gQ=6JpBRNZ7Gm+MsQ@mail.gmail.com>
Message-ID: <CALCETrXUdLZTnf0EF2LVM4ru2G6nkFX--gQ=6JpBRNZ7Gm+MsQ@mail.gmail.com>
Subject: Re: [PATCH] x86: Call fixup_exception() before notify_die() in math_error()
To:     Siarhei.Liakh@concurrent-rt.com
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bpetkov@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 10:10 PM Siarhei Liakh
<Siarhei.Liakh@concurrent-rt.com> wrote:
>
> fpu__drop() has an explicit fwait which under some conditions can trigger
> a fixable FPU exception while in kernel. Thus, we should attempt to fixup
> the exception first, and only call notify_die() if the fixup failed just
> like in do_general_protection(). The original call sequence incorrectly
> triggers KDB entry on debug kernels under particular FPU-intensive
> workloads. This issue had been privately observed, fixed, and tested
> on 4.9.98, while this patch brings the fix to the upstream.

Reviewed-by: Andy Lutomirski <luto@kernel.org>

With the caveat that you are perpetuating what is arguably a bug in
some of the other entries: math_error() can now be called with IRQs
off and return with IRQs on.  If we actually start asserting good
behavior in the entry code, we'll need to fix this.

--Andy
