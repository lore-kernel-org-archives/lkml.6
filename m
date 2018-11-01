Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F65C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F1820820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oUeTklmp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F1820820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbeKBF6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 01:58:16 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38344 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbeKBF6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 01:58:15 -0400
Received: by mail-yw1-f65.google.com with SMTP id d126-v6so8462927ywa.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 13:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Gol5B4GroMQ4WFw6ddKdqUihpAJKF0SO/kCjJG1vtfI=;
        b=oUeTklmpT7YsHNI0lS55GfhKFUmzSg6QzkxW6CuIcylNqTfkxfHPRR/75+ODNob1X2
         308fJTxmNkCkU9zUr4SwvAAJ381CwRCpoe+GRSF6Mxz66MuktX0ewbqALiowetsQj9CF
         DukM0Wsr795VjDdN6ieEut+YH9yGQpqBgaKuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Gol5B4GroMQ4WFw6ddKdqUihpAJKF0SO/kCjJG1vtfI=;
        b=q96YMWLD6QuUCrQKCorqCPJtpqEpb3EypYnsauZ99xQg4OO72FSaUn6bC5GF2GGSOy
         M4h61hIRBya80L7jimcceoPaV5MdsAuySVis0m0VAPusSL3MpalHZQZF6i8L/2B1I7Ay
         fdnhIqgafNuRZnlTqLBIz+FgFYDWRfS/RrESvl0Jh1ND8kFdNdPhAfV99ITIIOiFpDO3
         XEc3kdsC1eEvbcbPzbyuI2jj7KBBMPi7lAO8dCPVih1QzIfVuC7A+PH4TnUKGE4SCFJy
         KNNQlSBn37uoCUJPg0v2P2NpiSwBL+kxDYCU90CBXP3AW7ru4O4PWuSHTeGi9FAthXPX
         mrdw==
X-Gm-Message-State: AGRZ1gI0Hxisu4Bn+PZE4z9R3gDD+wR0YBMt9xUOlJx4pk+ewd5Ke4bq
        I5j+0LR5rAS4sl3NW4H3Rl90/tPWrR4=
X-Google-Smtp-Source: AJdET5fBeUFrUh4SxRdtvnyF8UG7THeTg7sxi54meddbUJk8aatw3LKTp0RQ8UgpDW4haxoGoEidaw==
X-Received: by 2002:a0d:c045:: with SMTP id b66-v6mr8728105ywd.208.1541105619306;
        Thu, 01 Nov 2018 13:53:39 -0700 (PDT)
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id 123-v6sm8008290ywu.91.2018.11.01.13.53.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 13:53:37 -0700 (PDT)
Received: by mail-yw1-f42.google.com with SMTP id k6-v6so4088728ywa.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 13:53:37 -0700 (PDT)
X-Received: by 2002:a0d:d302:: with SMTP id v2-v6mr9263414ywd.124.1541105616435;
 Thu, 01 Nov 2018 13:53:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Thu, 1 Nov 2018 13:53:35 -0700 (PDT)
In-Reply-To: <20181101234102.5fd16894fefffe18fccd6999@kernel.org>
References: <20181022093023.GA8920@beast> <cbeccaf1-33ec-0e54-0cfa-8cff81bbc1cd@redhat.com>
 <20181101234102.5fd16894fefffe18fccd6999@kernel.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 1 Nov 2018 13:53:35 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJ-LQeFw+=5QoVW581TsUx2axCv6OCduWff69V2Fcp7Dg@mail.gmail.com>
Message-ID: <CAGXu5jJ-LQeFw+=5QoVW581TsUx2axCv6OCduWff69V2Fcp7Dg@mail.gmail.com>
Subject: Re: [PATCH] ARM: kprobes: Fix false positive with FORTIFY_SOURCE
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     William Cohen <wcohen@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Laura Abbott <labbott@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 7:41 AM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> On Tue, 30 Oct 2018 13:40:27 -0400
> William Cohen <wcohen@redhat.com> wrote:
>
>> On 10/22/18 5:30 AM, Kees Cook wrote:
>> > The arm compiler internally interprets an inline assembly label
>> > as an unsigned long value, not a pointer. As a result, under
>> > CONFIG_FORTIFY_SOURCE, the size of the array pointed to by an address
>> > of a label is 4 bytes, which was tripping the runtime checks. Instead,
>> > we can just cast the label (as done with the size calculations earlier)
>> > to avoid the problem.
>> >
>> > Reported-by: William Cohen <wcohen@redhat.com>
>> > Fixes: 6974f0c4555e ("include/linux/string.h: add the option of fortified string.h functions")
>> > Cc: stable@vger.kernel.org
>> > Signed-off-by: Kees Cook <keescook@chromium.org>
>> > ---
>> >  arch/arm/probes/kprobes/opt-arm.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/arch/arm/probes/kprobes/opt-arm.c b/arch/arm/probes/kprobes/opt-arm.c
>> > index b2aa9b32bff2..2c118a6ab358 100644
>> > --- a/arch/arm/probes/kprobes/opt-arm.c
>> > +++ b/arch/arm/probes/kprobes/opt-arm.c
>> > @@ -247,7 +247,7 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *or
>> >     }
>> >
>> >     /* Copy arch-dep-instance from template. */
>> > -   memcpy(code, &optprobe_template_entry,
>> > +   memcpy(code, (unsigned char *)optprobe_template_entry,
>> >                     TMPL_END_IDX * sizeof(kprobe_opcode_t));
>> >
>> >     /* Adjust buffer according to instruction. */
>> >
>>
>> The patch fixes the issue for kretprobes.  It looks good to me.
>
> This looks good to me too. Thank you for finding and fixing it :)
>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
>
> Thanks!

Thanks for acks and testing. I've tossed this at the arm patch tracker:
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8806/1

-- 
Kees Cook
