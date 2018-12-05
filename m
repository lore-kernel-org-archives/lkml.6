Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5BEC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0DA20989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544052985;
	bh=HdKzwjq0Ktp+3fDTmn75tOVezfVsQGQJUbhDfnOAGO4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vNqEDTLqFmKP7AVHSdXjMA/0/z37b00mxlZ0HPGiLjviC6wGJsPrvsK79Pt2fd1za
	 tkpQyxO+b9F6Jr4dD38fPxFPIL4Khf+aHffSXFkggENcQ5h0PSJMuEcGJWupkYYX7/
	 sZpXF4rhukAwtJYdB9A54P6KZFR5PBXr5UI6Ocv0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F0DA20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbeLEXgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:36:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:55080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727628AbeLEXgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:36:23 -0500
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF201213A2
        for <linux-kernel@vger.kernel.org>; Wed,  5 Dec 2018 23:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544052983;
        bh=HdKzwjq0Ktp+3fDTmn75tOVezfVsQGQJUbhDfnOAGO4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LKxsy6iwT1syzHEMGN9kUv2eF8/m/yymbi4vbkd6+G5oL08pmdMJ961Ir9xVm481e
         22rv/J5683IKZbWPExK200+EMPqjrIkRdoHYih5ShTCcXnlz1l4RRpQF6lOH8z0Dmo
         ad8u/N7VmNm2ipBaE8BGtTzkzYbcKSLzM4TCFi/k=
Received: by mail-wr1-f53.google.com with SMTP id q18so21419715wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 15:36:22 -0800 (PST)
X-Gm-Message-State: AA+aEWbIwSFS67nZCMiPFQyXrQBsDGooFoZI7YIEXgMxzi9GRZwfF2vx
        nfI39st2SYt1QvPJDAF1lVbAlp8pf6S2v4J6vY5XkA==
X-Google-Smtp-Source: AFSGD/VM4K/n8k3YpqBh8waGbHJeO9yrb9B0DMwNHN4b4UqLvlhx91mdfrz/yKI3a3ViZKefYx3ZTV+uJ4gmvGScH0c=
X-Received: by 2002:a5d:5502:: with SMTP id b2mr24114300wrv.330.1544052981473;
 Wed, 05 Dec 2018 15:36:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543200841.git.jpoimboe@redhat.com> <20181204180835.29f9aa03@vmware.local.home>
 <EE66E7C9-5735-48B3-A001-E9FCDA46E177@amacapital.net> <20181205150422.mlrjcm5rm26ozg5j@treble>
In-Reply-To: <20181205150422.mlrjcm5rm26ozg5j@treble>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 5 Dec 2018 15:36:10 -0800
X-Gmail-Original-Message-ID: <CALCETrVeWE8NOry6-wiy1q7C0cT8JXSAJvg8T7pwV=Vubu27bw@mail.gmail.com>
Message-ID: <CALCETrVeWE8NOry6-wiy1q7C0cT8JXSAJvg8T7pwV=Vubu27bw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Static calls
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>, julia@ni.com, jeyu@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> On Dec 5, 2018, at 7:04 AM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
>
>> Anyway, I have a new objection to Josh=E2=80=99s create_gap proposal: wh=
at on
>> Earth will kernel CET do to it?  Maybe my longjmp-like hack is
>> actually better.
>
> Does CET even care about iret?  I assumed it didn't.  If it does, your
> proposal would have the same problem, no?

I think it doesn=E2=80=99t, but it doesn=E2=80=99t really matter.  The shad=
ow stack looks like:

retaddr of function being poked
call do_int3 + 5

And, to emulate a call, you need to stick a new frame right in the
middle.  At least with a longjmp-like approach, you can clobber the
=E2=80=9Ccall do_int3 + 5=E2=80=9D part and then INCSSP on the way out.  To=
 be fair, I
think this also sucks.

PeterZ, can we abuse NMI to make this problem go away?  I don't
suppose that we have some rule that NMI handlers never wait for other
CPUs to finish doing anything?
