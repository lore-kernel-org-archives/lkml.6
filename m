Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B160C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0005F22465
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgmB4Yg+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0005F22465
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933936AbeGFT4g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 15:56:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:55870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933738AbeGFT4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 15:56:34 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D450622BEF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jul 2018 19:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530906994;
        bh=vXrgN1G3tMCurOAoqXxCURCm5FEI4UOyLJG3FPuZ80k=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=YgmB4Yg+L4Q3yi7ooH1QW2DMbCSqCArKBsVRLRTZCRiiC2GfVqzvgt06BWOSXmVN8
         Lk/vHt+fPfIpwzP5mp4D5a7m7pXohsl13Jpven3SR5iboiMt0ppRYKgvqB2XjHLRwu
         SJuzk8W0Ebrql4Uj3Xwhpcmbd+T+5ap4dKgpMRrs=
Received: by mail-wr1-f44.google.com with SMTP id h10-v6so5211631wrq.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 12:56:33 -0700 (PDT)
X-Gm-Message-State: APt69E25HHKzcWBi0uU7yc5Bt1zbs3BJHTDUshfRcp1FvZywfeFca4DO
        fDUUEUofI3cg/JJJjJRyw5q2bEO8Ys9S25xc4FWp3g==
X-Google-Smtp-Source: AAOMgpevCyd63ukpCvxNX0yQe72bzAzaZxRX+lhM3Gz1lYEQWvlsuapZjtfu6DCLc0FmHQj8efcWWbzPiSTnBBaWjQE=
X-Received: by 2002:adf:b445:: with SMTP id v5-v6mr8284600wrd.67.1530906992235;
 Fri, 06 Jul 2018 12:56:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:d548:0:0:0:0:0 with HTTP; Fri, 6 Jul 2018 12:56:11 -0700 (PDT)
In-Reply-To: <CA+55aFzz1CC6son0T2nD-Yqhy0_yC5nBer2XSH9kqe5x3N26Ug@mail.gmail.com>
References: <20180705180601.18423-1-mathieu.desnoyers@efficios.com>
 <20180705180601.18423-4-mathieu.desnoyers@efficios.com> <1846432971.1245.1530892973439.JavaMail.zimbra@efficios.com>
 <436937568.1359.1530905019620.JavaMail.zimbra@efficios.com> <CA+55aFzz1CC6son0T2nD-Yqhy0_yC5nBer2XSH9kqe5x3N26Ug@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 6 Jul 2018 12:56:11 -0700
X-Gmail-Original-Message-ID: <CALCETrXToJ0LcmANL3=Fo-BfdPqtiF3C3gYTHeeokTcb_aK9Zw@mail.gmail.com>
Message-ID: <CALCETrXToJ0LcmANL3=Fo-BfdPqtiF3C3gYTHeeokTcb_aK9Zw@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 3/5] rseq: uapi: declare rseq_cs field as
 union, update includes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>,
        Christoph Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 12:31 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Jul 6, 2018 at 12:23 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> For -rc, I would favor the following simpler approach. Or I could even
>> just use get_user() instead. Thoughts ?
>
> Please just use "get_user()".
>
> In fact, we should be thinking seriosly about just removing
> __get_user() entirely. It's wrong. It optimizes the wrong thing
> entirely. It _used_ to be that the range check was noticeable, and it
> really isn't any more. These days the expensive parts are the SMAP
> costs, and both get_user() and __get_user() have those, except
> get_user() is safer and doesn't waste I$ on inlining the code to
> disable and re-enable SMAP.

If Al and Christoph ever manage to get rid of set_fs(), I bet we can
rewrite access_ok() and get_user() so that gcc can fold redundant
checks together and generate optimal code for get_user() of
consecutive struct fields all by itself.  Or maybe I'm giving gcc more
credit than it deserves.
