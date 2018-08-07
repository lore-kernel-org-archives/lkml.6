Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3520C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3AF2176D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="IfrZbrAb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3AF2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389716AbeHGRCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:02:50 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33521 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733061AbeHGRCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:02:49 -0400
Received: by mail-qt0-f194.google.com with SMTP id c15-v6so18140348qtp.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 07:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=0pGeOlRzI/9Tc9XEirnVYMpmtykiLJ9/YbHVQr+nFuI=;
        b=IfrZbrAbJx4lZDkI+3KPnuTtpXB+hVvx4uxqHfZSjj8hdUMhJHkb+qJBnV7DBhf4FJ
         oyPkomuWWck3R2XKU5plP+QBoZkLyl8Dxekh/ea6R/ivKx6h1kD8skEPAPBOO9Q5vZQ8
         J+qZpPwPCrf7EYCfOyhDQoqfG9X1IpUF855v64fUwpLZ3Omql4CMQUl10aCF9ayw4NGj
         KG1gxhykL0XEorT8UakQEbXF0ekRjmy9h2aSpXIdHa/LCSCQrNrNRlXqCcL+l6wK+Shv
         BvVBINz+5ze2BtUcDlf4lM4HyuxYYQ4TKYjbvdSkrpCkmSIvfHpk+yP8ttYkaB3av5f4
         +DvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=0pGeOlRzI/9Tc9XEirnVYMpmtykiLJ9/YbHVQr+nFuI=;
        b=R8X+9WTihYb0/Gc7n9/KdxEazfVXKAR5Odd17Lr6F9ZChxhDvNbRt7Lcxb0gxBv4Dx
         ZhQTxgbOjRDbc5gMFB645DcU95f1Bo5tO6v0kTDLR5ZdRL5aRD+sQbkPhKKoAbJLQkDa
         gGT8PUdBOH/bF2rPpl9cbfFq1eZtJaXAGyRyqyQc6ViouOpTIY1ZVjr1FycdutjP5sPt
         K5FxOzATWHgTNcHbMMVyDeYyRBF6BauywhY1hK1Eeq3ICzvUrhr3ckakwIXydV1gotIu
         HK4ss5LubGwgkvonV4B3JXK4EDNhpie06JKqJdEUcVRRFlRLgKnuBY69c1k4qeURKA2W
         dKcQ==
X-Gm-Message-State: AOUpUlEeVrsrv8Z6C7+gc92BgKGhi+spNqqHhRYJ9FibGmKFxUCGjYUP
        0DTLM6Cum0RrdWk2VN4OOO9laQ==
X-Google-Smtp-Source: AAOMgpfQbmd7JnSgGWLtrhNpGCZzuTw/KOr+NYNjD3G7BMmKWIgKo3Lz66J14yI+RE7CUBbEyAgrng==
X-Received: by 2002:a0c:fac4:: with SMTP id p4-v6mr17215802qvo.179.1533653288780;
        Tue, 07 Aug 2018 07:48:08 -0700 (PDT)
Received: from ?IPv6:2600:1003:b02d:a97a:b058:3527:6454:4e37? ([2600:1003:b02d:a97a:b058:3527:6454:4e37])
        by smtp.gmail.com with ESMTPSA id y132-v6sm910067qkb.56.2018.08.07.07.48.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 07:48:08 -0700 (PDT)
Date:   Tue, 07 Aug 2018 10:48:05 -0400
User-Agent: K-9 Mail for Android
In-Reply-To: <20180807103410.4fe203cb@gandalf.local.home>
References: <20180730222423.196630-1-joel@joelfernandes.org> <20180730222423.196630-4-joel@joelfernandes.org> <20180806155058.5ee875f4@gandalf.local.home> <CAJWu+oqvpev_EZC38_mi+UNRCxS8GqNVagHyGM4dUjruzKgwgQ@mail.gmail.com> <20180806214300.13e63523@gandalf.local.home> <CAJWu+oqZi2W9OYAn2xu17fdrBitQs4Gti4LxWmtx5B-EYtNMmA@mail.gmail.com> <20180807094954.5137972d@gandalf.local.home> <446AE5F2-39E0-46B6-8E0B-207E003DBF20@google.com> <20180807103410.4fe203cb@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v12 3/3] tracing: Centralize preemptirq tracepoints and unify their usage
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
From:   Joel Fernandes <joelaf@google.com>
Message-ID: <C1CB990F-8232-4168-89A8-E8C13B660B0B@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On August 7, 2018 10:34:10 AM EDT, Steven Rostedt <rostedt@goodmis=2Eorg> =
wrote:
>On Tue, 07 Aug 2018 10:10:59 -0400
>Joel Fernandes <joelaf@google=2Ecom> wrote:
>
>> On August 7, 2018 9:49:54 AM EDT, Steven Rostedt
><rostedt@goodmis=2Eorg> wrote:
>> >On Tue, 7 Aug 2018 06:33:35 -0700
>> >Joel Fernandes <joelaf@google=2Ecom> wrote:
>> > =20
>> >> Thanks, also one more thing I noticed in your patch,
>> >> lockdep_hardirqs_off needs to be called before all other probes
>but
>> >> you're calling it after=2E This is why I registered it with INT_MAX:
>> >>=20
>> >> register_trace_prio_irq_disable(lockdep_hardirqs_off, NULL,
>INT_MAX);
>> >>=20
>> >> Without it you may get annotation warnings=2E Thanks, =20
>> >
>> >Interesting=2E I was following the old way where we called the tracing
>> >code before calling the lockdep code (all hard coded and not from
>> >trace events)=2E Is this have something to do with calling the code
>from
>> >a tracepoint?
>> >
>> >Do you have an example that could trigger the warning?
>> > =20
>>=20
>> I remember the warnings but can't remember now how I triggered them=2E
>> I think I saw them with the irqsoff tracer or irq trace events
>> running, with lockdep turned on=2E
>
>I'll see if I can trigger it=2E I'll run this all through my tests=2E

Ok=2E

>> Also an irq disable probe that does a lockdep assert that irqs are
>> disabled could trigger it?
>>=20
>
>You mean if someone add a tracepoint callback to the irq disable
>tracepoint, and did a lockdep assert to make sure interrupts are
>disabled?

Yes that's what I meant=2E

Thanks,

- Joel

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
