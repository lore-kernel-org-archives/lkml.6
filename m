Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087FCC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 956352075C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F39IcTaY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956352075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbeJKWwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:52:41 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41939 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbeJKWwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 18:52:40 -0400
Received: by mail-io1-f65.google.com with SMTP id q4-v6so6900822iob.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 08:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=miQiWFyV3lLkdNjXe1ZSDxVu+ciOnWcPaTkxIg3qx90=;
        b=F39IcTaYz3GCuUEHKrT6jusudqbRVx+UOOoe3TDZIbJajshM83AiJwuee1lMYXzXjt
         JQahRkJjosju2uZzEENzdpIkBRfh+pm/eyiMQV+qfO1DbQ4ppiT/xk4VXQWOrFAq3wqb
         sc6pWxCc0uteBK1PJyPfkMQ+BSROCxWjhRv4Dwjtqnuo7tw2nG9U7xEtnFEbi9CiVCnO
         ssw5ILnEa7rD6uY9JPpVAu7dJujT12rINdU+MKMKfDY7YCs4rpxl80qqBao4OE7obr9q
         RoVbjT6MKfC2wfyt7ASafREhTL+dklj7ajUMwbBmHwc88gDeW78A8OZanc7Q9s7BvlMW
         zNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=miQiWFyV3lLkdNjXe1ZSDxVu+ciOnWcPaTkxIg3qx90=;
        b=TyGkcCrj2W4vFViL/5ENTLCvv5Fe+7s+VqQ1Ja3kym4KLzS0L0ipGGzGtlzn6CdZk3
         GVRkLgT9uZf/XiO5KJiAQXOtVXwDg9PoDslGuIdZOoNixHH+Fq0GLVv/HrgZcnR8Qp3l
         pyTeTNzeDrwmb0PrhDIeD625NbM8TjX2yaxdhkyp2NNEzCRVm5tZW2hP+2fbfX/MaLM7
         ZN3V4Mk9JLQVuBXlre0bG2h9CBuVCXc0sxVfQEeVRxwygPx4TdhKHF0tNMKZz5Hj8sU0
         5OwZvhItFuENCLx9rAOnUBIeeAg3Nq2KKZg+kOakRum9Ycssx0UDQ5V2NGKVEI42MhjL
         PxmA==
X-Gm-Message-State: ABuFfohw+hhyJ/y2TaixW9H2AW3elVI7XOM+w4ueg+VXMz8N2ZhGa7Op
        bdHrThUekc76ZATEjzgvS1UeoSzqGuAeIFyh0uTfoLlV+cknpA==
X-Google-Smtp-Source: ACcGV62z8MJ6WkpBrPelrcmLchsZKjzt1prNMiJEOMEvYYBR2hYmqoylLHRqYg038H8fXHnmcR13uskAXSmqs/1Qnns=
X-Received: by 2002:a6b:8f93:: with SMTP id r141-v6mr1463016iod.118.1539271500674;
 Thu, 11 Oct 2018 08:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20181011103825.023036082@infradead.org> <20181011104019.748208519@infradead.org>
 <CANn89iKxTMRr_XSC4xHD-etoU9kF6nN7yzQP4AEfYeNKjQLTPQ@mail.gmail.com>
In-Reply-To: <CANn89iKxTMRr_XSC4xHD-etoU9kF6nN7yzQP4AEfYeNKjQLTPQ@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 11 Oct 2018 08:24:49 -0700
Message-ID: <CANn89iJsD=rKTjiGF_EEoSh9WmiifOjxu2mcqSv8Sx-NT7zixQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/percpu: Fix this_cpu_read()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 8:02 AM Eric Dumazet <edumazet@google.com> wrote:
>
> On Thu, Oct 11, 2018 at 3:45 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Eric reported that a sequence count loop using this_cpu_read() got
> > optimized out. This is wrong, this_cpu_read() must imply READ_ONCE()
> > because the interface is IRQ-safe, therefore an interrupt can have
> > changed the per-cpu value.
> >
> > Fixes: 59eaef78bfea ("x86/tsc: Remodel cyc2ns to use seqcount_latch()")
> > Reported-by: Eric Dumazet <edumazet@google.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
>
> Acked-by: Eric Dumazet <edumazet@google.com>

Actually the Fixes: tag seems funky.

Bug was not added by 59eaef78bfea

Your patch probably needs to be backported to older versions of linux,
just to be safe, since
we might have other places where authors relied on this_cpu_read()
semantic (different than this_cpu_read_stable())
