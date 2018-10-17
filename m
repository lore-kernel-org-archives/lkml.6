Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2901ECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A627A21476
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U3ll2Se5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A627A21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbeJRCaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:30:18 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:44470 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbeJRCaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:30:18 -0400
Received: by mail-yw1-f66.google.com with SMTP id s73-v6so10758229ywg.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 11:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=E7Ju8kbYszWk0nEMKwbY77mi8dj+AQLdKq6dVXBCtDo=;
        b=U3ll2Se5XxPEOBwzJ1MS41Z38hkSOPXmdQ+lsrhFkibCJcnw/8Jy0RONnCl+pmCF9A
         SbJXWXdmtAKayVyoZFC/akqkNbRySOF0y4JXVAegaOXIsCW4T3SbwLGVPUzCtG5kJF0D
         7f66DbaJJV9zeqJt8endLyh/xZMyhmWKGJRys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=E7Ju8kbYszWk0nEMKwbY77mi8dj+AQLdKq6dVXBCtDo=;
        b=geYQWEcYnwL3MKAyd3pOEqTvIMWghCOGLGFgs2IwpLK0ImcpD/vm3fib2y71i8Mby6
         S/f2pWmQ5JxDuObH4NI6Om4hUxTI3zR9EVgSuvdSCErKOBq/m3/j9BPAs4Nf/AUnTgNM
         lZQNul2BtOgCNdXPMIZpPEidRpBz2ZtLZu6bp5ZJrz/mXxvKFQNzS5uSbk1d9CR6QQxV
         W/xBgamo2wDi34SGefWW53slprz0rUQrPMapOIl8mvvWWF0qezGFMCk6/VGckmrM/WEI
         dJmiDPf7fSUzTHlAsQ5cJ03yJnDF9x1YTrkOvgMxyDABKsptAiIwNFsL+VjVEAE18E9g
         fu6g==
X-Gm-Message-State: ABuFfohdR3GetRDcXSHz8jNvWIVu6t3xeBQjy1ap3zO96rVbc2qG6SJ6
        1kBVHJhFBYAJ7xlBeUb+NU6ZG4a408M=
X-Google-Smtp-Source: ACcGV62u0/74cJVxYLAx37rpNu0bkbyeMp/Azd6DDUDl15kTygU0o/083loF4+byWSn+U6b/9h5Ybg==
X-Received: by 2002:a0d:ff83:: with SMTP id p125-v6mr16307868ywf.65.1539801200050;
        Wed, 17 Oct 2018 11:33:20 -0700 (PDT)
Received: from mail-yw1-f49.google.com (mail-yw1-f49.google.com. [209.85.161.49])
        by smtp.gmail.com with ESMTPSA id c128-v6sm6923881ywb.68.2018.10.17.11.33.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 11:33:19 -0700 (PDT)
Received: by mail-yw1-f49.google.com with SMTP id j75-v6so10765214ywj.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 11:33:19 -0700 (PDT)
X-Received: by 2002:a81:2cc3:: with SMTP id s186-v6mr16382159yws.168.1539800735756;
 Wed, 17 Oct 2018 11:25:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Wed, 17 Oct 2018 11:25:34
 -0700 (PDT)
In-Reply-To: <20181017175611.GB107185@joelaf.mtv.corp.google.com>
References: <1cae8f10-55f5-20ce-9105-30af6f88bd6e@codeaurora.org>
 <20181016112928.4b52afb5@gandalf.local.home> <CAGXu5jLBtBU1eX7tGX1gOVKSFKeLMeoke3bGHUuqxk86dLSnng@mail.gmail.com>
 <20181017101355.GA230639@joelaf.mtv.corp.google.com> <2a23cd74-7364-0fb7-3c7b-7be79a881073@codeaurora.org>
 <69d2f43d-dc96-9348-7f70-5db88e8f5c39@codeaurora.org> <20181017175611.GB107185@joelaf.mtv.corp.google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 17 Oct 2018 11:25:34 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+Jg6SQWcduVy-Kt39Bup4og=jr=eGrBCLEdn80Cayu-Q@mail.gmail.com>
Message-ID: <CAGXu5j+Jg6SQWcduVy-Kt39Bup4og=jr=eGrBCLEdn80Cayu-Q@mail.gmail.com>
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        "Ivan T. Ivanov" <ivan.ivanov@linaro.org>,
        Geliang Tang <geliangtang@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pramod Gurav <gpramod@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 10:56 AM, Joel Fernandes <joel@joelfernandes.org> wrote:
> On Wed, Oct 17, 2018 at 08:19:41PM +0530, Sai Prakash Ranjan wrote:
>> On 10/17/2018 5:08 PM, Sai Prakash Ranjan wrote:
>> > >
>> > > What do you think about the (untested) patch below? It seems to me
>> > > that it
>> > > should solve the issue of missing early crash dumps, but I have not
>> > > tested it
>> > > yet. Sai, would you mind trying it out and let me know if you can see the
>> > > early crash dumps properly now?
>> > >
>> > > ----8<---
>> > > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
>> > > Subject: [RFC] pstore: allocate compression during late_initcall
>> > >
>> > > ramoop's pstore registration (using pstore_register) has to run during
>> > > late_initcall because crypto backend may not be ready during
>> > > postcore_initcall. This causes missing of dmesg crash dumps which could
>> > > have been caught by pstore.
>> > >
>> > > Instead, lets allow ramoops pstore registration earlier, and once crypto
>> > > is ready we can initialize the compression.
>> > >
>> > > Reported-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>> > > ---
>> > >   fs/pstore/platform.c | 13 +++++++++++++
>> > >   fs/pstore/ram.c      |  2 +-
>> > >   2 files changed, 14 insertions(+), 1 deletion(-)
>> > >
>> > > diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
>> > > index 15e99d5a681d..f09066db2d4d 100644
>> > > --- a/fs/pstore/platform.c
>> > > +++ b/fs/pstore/platform.c
>> > > @@ -780,6 +780,19 @@ void __init pstore_choose_compression(void)
>> > >       }
>> > >   }
>> > > +static int __init pstore_compression_late_init(void)
>> > > +{
>> > > +    /*
>> > > +     * Check if any pstore backends registered earlier but did not
>> > > allocate
>> > > +     * for compression because crypto was not ready, if so then
>> > > initialize
>> > > +     * compression.
>> > > +     */
>> > > +    if (psinfo && !tfm)
>> > > +        allocate_buf_for_compression();
>> > > +    return 0;
>> > > +}
>> > > +late_initcall(pstore_compression_late_init);
>> > > +
>> > >   module_param(compress, charp, 0444);
>> > >   MODULE_PARM_DESC(compress, "Pstore compression to use");
>> > > diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
>> > > index bbd1e357c23d..98e48d1a9776 100644
>> > > --- a/fs/pstore/ram.c
>> > > +++ b/fs/pstore/ram.c
>> > > @@ -940,7 +940,7 @@ static int __init ramoops_init(void)
>> > >       ramoops_register_dummy();
>> > >       return platform_driver_register(&ramoops_driver);
>> > >   }
>> > > -late_initcall(ramoops_init);
>> > > +postcore_initcall(ramoops_init);
>> > >   static void __exit ramoops_exit(void)
>> > >   {
>> > >
>> >
>> > Yes I could see the early crash dump. Also I tested with different
>> > compression (LZO) instead of deflate just to be sure and it works fine,
>> > thanks :)
>> >
>> > Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> >
>
> Thanks.
>
>> I just noticed that allocate_buf_for_compression() is also called from
>> pstore_register(). Shouldn't that call be removed now that ramoops_init is
>> moved to postcore_initcall and allocate_buf_for_compression() will just
>> return doing nothing when called from pstore_register()?
>
> Yes, that is the point. If crypto is not ready then my thought is
> allocate_buf_for_compression() called from pstore_register() should do
> nothing and pstore will work uncompressed and the kdump infrastructure will
> only cause uncompressed writes. But say if the kdump triggered *after* crypto
> was ready, then the dump write out would be compressed since pstore is ready
> for compression.
>
> The idea is if a future pstore backend calls pstore_register late, then it
> may as well do the allocate_buf_for_compression as well at that time when it
> runs. In that cause pstore_compression_late_init would do nothing.
>
> So this approach is both dynamic and future proof.

Yeah, thanks! I think this looks correct, but I'll spend some more
time testing it too.

-Kees

-- 
Kees Cook
Pixel Security
