Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59DAC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 05:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4EC20868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 05:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C4EC20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731839AbeKXQhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 11:37:00 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45035 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731053AbeKXQhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 11:37:00 -0500
Received: by mail-wr1-f67.google.com with SMTP id z5so9712612wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 21:49:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uxqe04vSOcU8OZuG1995FHYQPVJrBbffFrxqkHPEHWc=;
        b=Or0WhZNy36G2z+2STZQsKN3ZHxTmdrJMfn98qkKrn08OQ+5VyeYVUmBhBF+3BUSWiQ
         D4TIoc3MMihEjNntBMOwcImXMaH+APNke3VFk0in3/hRNUjuzgvK/XYkaOHe73m/MMQ7
         1nT+2omOXCwtQdNH28IMaz26O8RSrqWYHNQpB14vbLLMOi5jgQjC4LDr6D2jmHIFeN2e
         FcOQg50LDameKzr73sDbDPm5PO+ci/I/KuP1UXY4DyCP4eh+NcmheUG5//y3cIFhhy9h
         cPNgv8V06IWO8J+05hqVxtDulWrqwsMU0JJ81zyXmvZzh1bylLsd++OXFxHC6thSKcig
         HVPw==
X-Gm-Message-State: AA+aEWa9uIpuYPu+DtS6UVuzz28+KgfrEDQnJUu3A3H39UT9IXAmTjaj
        VTLHE/9VvfLtytmKjyW1eAT2+VFhOyT6s0zPaqg=
X-Google-Smtp-Source: AFSGD/X+LAPjiTv0Y72Z7zOTuTixheITq5tffMhpMQ0kNkRr+uUFNePKski38KN0qG5G+HVz4JZvfuRo23X/hbJDUZU=
X-Received: by 2002:adf:aa94:: with SMTP id h20-v6mr16206177wrc.216.1543038589890;
 Fri, 23 Nov 2018 21:49:49 -0800 (PST)
MIME-Version: 1.0
References: <20181122012708.491151844@goodmis.org> <20181122012802.894046175@goodmis.org>
 <20181123000118.GB25952@sejong> <20181123123732.0dd3c237@vmware.local.home>
In-Reply-To: <20181123123732.0dd3c237@vmware.local.home>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 24 Nov 2018 14:49:34 +0900
Message-ID: <CAM9d7chQf8iETU6Lm4tN5CBR3VUOtYm1w76bhrbcNoK9pT43xg@mail.gmail.com>
Subject: Re: [RFC][PATCH 02/14] fgraph: Have set_graph_notrace only affect
 function_graph tracer
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, frederic@kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>, mark.rutland@arm.com,
        kernel-team@lge.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 2:37 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 23 Nov 2018 09:01:18 +0900
> Namhyung Kim <namhyung@kernel.org> wrote:
>
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> Thanks Namhyung!

It'd be nice if you cc me for the whole patchset (and other tracing
patches) next time.

Thanks,
Namhyung
