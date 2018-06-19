Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA79C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC5E2083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGckq8z9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC5E2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sai.msu.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967034AbeFSQX1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:23:27 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46593 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966208AbeFSQX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:23:26 -0400
Received: by mail-oi0-f67.google.com with SMTP id h79-v6so233801oig.13;
        Tue, 19 Jun 2018 09:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=mBQgnr5Ju45ExTKxcUtUZKOeUjsgmNuxMa7SithEQ7s=;
        b=tGckq8z9hhV2+vYODWqsvjcZVVyLAaa9/1gx3weCtA+JiXTGaF6DT/SJ4+hdJumxCz
         d7LrMSwCp5J2RYIajHa8snQIGd6KlHU8hM6ptkGyIeIIU8QvGNs1j6gXZeDlialYgXbB
         BwSr2xOTl1MdsGO6ExF+r9sNwRK/T7+KzqCO/A/O/HIpxxXbjVX0l8oOehRZP3ruFIAr
         ZycYGDHgoPsUTjEjlrGbgk5+ggSlJeRyslgsQhPyUxvuT9d/VsFSpn+d3J50UBXkPzWs
         Cnn3nzco7fKikulsBh/B14/kxKRPzkgjMpOit9NSpDrebdTn/7TcOXICboWcli7JuiyI
         ujWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=mBQgnr5Ju45ExTKxcUtUZKOeUjsgmNuxMa7SithEQ7s=;
        b=chhFguk/RHpSXH3L0kgq1yUN+1oZKkhzANNGLiFtbrxGj51n0XMlheGSFfQBxh99jE
         6AH0JnKdrxdcnkOkYgZjEkTNWqOa8lwZcqscXftE/cQYYkjGVRS1Faz3h7ks02bIFftl
         P6WLajjzekJVhd4NXANLnqgihNyYov76RwZW9MxaGEXHzZdab0/ZmwXE8xAtw4rift6r
         Cok6JFH3c8TY9anySUAXxvbML0tld5K+8IcNb7WL5x/0QF9ixgivjKxXrbgry04e0inV
         fGClMkeT2q7teMgBk1BQcWpZVtHzh82YdS08Dwp/HRg2X2eXxwFjKjw3G3GzYNvOWMWJ
         opTw==
X-Gm-Message-State: APt69E07OHo2B/Q33q8cfH41cYp0zDwl1xP9W9D3pykPzo4aOl+ufaeN
        jEQEfw4jQFJWqWnh2tmle3aKnhIbUE8jB5bTHGA=
X-Google-Smtp-Source: ADUXVKKh+liVW5HNG+XSA+a/a9DlaNj/3SV5Mh48nkpB1tMVEBrTkjK1zmELUdVeTLMOMwW+MTppXW/6UYG4a4BsE+g=
X-Received: by 2002:aca:de07:: with SMTP id v7-v6mr10013432oig.161.1529425405142;
 Tue, 19 Jun 2018 09:23:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:743:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 09:23:04 -0700 (PDT)
In-Reply-To: <20180618145854.2092c6e0@gandalf.local.home>
References: <20180617143625.32133-1-matwey@sai.msu.ru> <20180618145854.2092c6e0@gandalf.local.home>
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
Date:   Tue, 19 Jun 2018 19:23:04 +0300
X-Google-Sender-Auth: TMDM7LRezqB4Ahj9OeIRYec95CY
Message-ID: <CAJs94EZAAuUS4rznPDmD=1aD8B72P0mLft+YDoNs+74pRXr+KA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Add TRACE_EVENTs in pwc_isoc_handler()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org, mingo@redhat.com,
        Mike Isely <isely@pobox.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Colin King <colin.king@canonical.com>,
        linux-media@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

Thank you for valuable comments.

This is for measuring performance of URB completion callback inside PWC driver.
What do you think about moving events to __usb_hcd_giveback_urb() in
order to make this more generic? Like the following:

        local_irq_save(flags);
// trace urb complete enter
        urb->complete(urb);
// trace urb complete exit
        local_irq_restore(flags);


2018-06-18 21:58 GMT+03:00 Steven Rostedt <rostedt@goodmis.org>:
> On Sun, 17 Jun 2018 17:36:24 +0300
> "Matwey V. Kornilov" <matwey@sai.msu.ru> wrote:
>
> I would prefer a change log here that would explain why these
> tracepoints are being added.
>
>
>> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
>> ---
>>  drivers/media/usb/pwc/pwc-if.c |  7 +++++++
>>  include/trace/events/pwc.h     | 45 ++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 52 insertions(+)
>>  create mode 100644 include/trace/events/pwc.h
>>
>> diff --git a/drivers/media/usb/pwc/pwc-if.c b/drivers/media/usb/pwc/pwc-if.c
>> index 54b036d39c5b..5775d1f60668 100644
>> --- a/drivers/media/usb/pwc/pwc-if.c
>> +++ b/drivers/media/usb/pwc/pwc-if.c
>> @@ -57,6 +57,9 @@
>>     - Pham Thanh Nam: webcam snapshot button as an event input device
>>  */
>>
>> +#define CREATE_TRACE_POINTS
>> +#include <trace/events/pwc.h>
>> +
>>  #include <linux/errno.h>
>>  #include <linux/init.h>
>>  #include <linux/mm.h>
>> @@ -260,6 +263,8 @@ static void pwc_isoc_handler(struct urb *urb)
>>       int i, fst, flen;
>>       unsigned char *iso_buf = NULL;
>>
>> +     trace_pwc_handler_enter(urb);
>> +
>>       if (urb->status == -ENOENT || urb->status == -ECONNRESET ||
>>           urb->status == -ESHUTDOWN) {
>>               PWC_DEBUG_OPEN("URB (%p) unlinked %ssynchronously.\n",
>
> Looks like if this is hit, we will return from the function without
> calling trace_pwc_handler_exit().
>
>> @@ -347,6 +352,8 @@ static void pwc_isoc_handler(struct urb *urb)
>>               pdev->vlast_packet_size = flen;
>>       }
>>
>> +     trace_pwc_handler_exit(urb);
>> +
>>  handler_end:
>
> Why not add the tracepoint after handler_end. In fact, why not add some
> exit status to the trace event? I would think that would be useful as
> well.
>
>
>>       i = usb_submit_urb(urb, GFP_ATOMIC);
>>       if (i != 0)
>> diff --git a/include/trace/events/pwc.h b/include/trace/events/pwc.h
>> new file mode 100644
>> index 000000000000..b13d2118bb7a
>> --- /dev/null
>> +++ b/include/trace/events/pwc.h
>> @@ -0,0 +1,45 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#if !defined(_TRACE_PWC_H) || defined(TRACE_HEADER_MULTI_READ)
>> +#define _TRACE_PWC_H
>> +
>> +#include <linux/usb.h>
>> +#include <linux/tracepoint.h>
>> +
>> +#undef TRACE_SYSTEM
>> +#define TRACE_SYSTEM pwc
>> +
>> +TRACE_EVENT(pwc_handler_enter,
>> +     TP_PROTO(struct urb *urb),
>> +     TP_ARGS(urb),
>> +     TP_STRUCT__entry(
>> +             __field(struct urb*, urb)
>> +             __field(int, urb__status)
>> +             __field(u32, urb__actual_length)
>> +     ),
>> +     TP_fast_assign(
>> +             __entry->urb = urb;
>> +             __entry->urb__status = urb->status;
>> +             __entry->urb__actual_length = urb->actual_length;
>
> Is there any other data that may be interesting to record here?
>
> -- Steve
>
>> +     ),
>> +     TP_printk("urb=%p (status=%d actual_length=%u)",
>> +             __entry->urb,
>> +             __entry->urb__status,
>> +             __entry->urb__actual_length)
>> +);
>> +
>> +TRACE_EVENT(pwc_handler_exit,
>> +     TP_PROTO(struct urb *urb),
>> +     TP_ARGS(urb),
>> +     TP_STRUCT__entry(
>> +             __field(struct urb*, urb)
>> +     ),
>> +     TP_fast_assign(
>> +             __entry->urb = urb;
>> +     ),
>> +     TP_printk("urb=%p", __entry->urb)
>> +);
>> +
>> +#endif /* _TRACE_PWC_H */
>> +
>> +/* This part must be outside protection */
>> +#include <trace/define_trace.h>
>



-- 
With best regards,
Matwey V. Kornilov.
Sternberg Astronomical Institute, Lomonosov Moscow State University, Russia
119234, Moscow, Universitetsky pr-k 13, +7 (495) 9392382
