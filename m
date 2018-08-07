Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B979C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BC221734
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="kwh4xhfk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0BC221734
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389894AbeHGRjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:39:07 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:43281 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732639AbeHGRjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:39:06 -0400
Received: by mail-qt0-f195.google.com with SMTP id f18-v6so18225812qtp.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 08:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=5B1TdJu2Qh9fd0GmHRRWoolQndpA8w2fXS0SNDL9aW0=;
        b=kwh4xhfk2/K4JYpenJAhGW5KJwyU6uCCzDdRx+MNpHE44rGhye1qGGFrPzqiyWKmF4
         tG8V3PxW0YEh00SmvDakhtqZJTahc16CJrdC4tHPoVvEAkRU2Fm8tql/h5GCsNjjLQTs
         G+wLLrm0LO8rwaP/j8slwGl9PviojpItq32d5nKN8Nq3Kq96iV+44MxwXGxYkvUYCT3C
         PQGQXG0+kyIZYfaTF4d2z9V6YYMx5fwR0c5rerwdNxcTlmTm5ny002QGTfZYIJwpPLCP
         J4gqa3iVPjbRE2RROKPKT5Sv0yvauDR85IqWvlF0SIdTTGEm9N5gSLwnWBWpfzNummDq
         hgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=5B1TdJu2Qh9fd0GmHRRWoolQndpA8w2fXS0SNDL9aW0=;
        b=K6b+1/Aw42dww9L8JIAUB201zwTgcRSqF+j4XZEIZdr98kk/NollFWhefmB1Dfkp1i
         vuFEHyP0hjNx4f5rXumiVt5VOo3AKIq2c76w1z8mLE0nUSJKaBXL9X65qnvPZ8uGf9yY
         Dr5KJEe08XXuFD+ee9qyCjPjt3gwJzUmJryVRqszUStWdYwk240Xx3Gsgkj9zrNjoqRu
         v2uoV5CkdyLW7U4boQEDHjNvk6b8OuTqycmAV1CfBYA7Jc5l6HKqNY+EHV90Q5dgwrD3
         s6McvtMX7Ur0fL/1Vi40UJIu/QZxJol4jYtXj184Uhymr8zot8kKlwxdoUsbxOHBDuku
         enEw==
X-Gm-Message-State: AOUpUlH18Jr/6QuTTbiwcZd4fPnk/WeZvn+AOp2lgCD7REhCrGm1YDsu
        41yp4/kZnrrzw6nt2UoYsFSiYQLfgfBtgA==
X-Google-Smtp-Source: AAOMgpc5LWXd29yozCEbxT+rnDRuXThD/KT9NfA8qy5S7Ry40wxf+j5ZsEJ+s/S+KFq9Tn1ksjSz8g==
X-Received: by 2002:ac8:2bea:: with SMTP id n39-v6mr19550894qtn.292.1533655456301;
        Tue, 07 Aug 2018 08:24:16 -0700 (PDT)
Received: from ?IPv6:2600:1003:b02d:a97a:b058:3527:6454:4e37? ([2600:1003:b02d:a97a:b058:3527:6454:4e37])
        by smtp.gmail.com with ESMTPSA id h51-v6sm1134244qte.17.2018.08.07.08.24.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 08:24:15 -0700 (PDT)
Date:   Tue, 07 Aug 2018 11:24:13 -0400
User-Agent: K-9 Mail for Android
In-Reply-To: <20180807110906.3a1b0ac4@gandalf.local.home>
References: <20180730222423.196630-1-joel@joelfernandes.org> <20180730222423.196630-4-joel@joelfernandes.org> <20180806155058.5ee875f4@gandalf.local.home> <CAJWu+oqvpev_EZC38_mi+UNRCxS8GqNVagHyGM4dUjruzKgwgQ@mail.gmail.com> <20180806214300.13e63523@gandalf.local.home> <CAJWu+oqZi2W9OYAn2xu17fdrBitQs4Gti4LxWmtx5B-EYtNMmA@mail.gmail.com> <20180807094954.5137972d@gandalf.local.home> <446AE5F2-39E0-46B6-8E0B-207E003DBF20@google.com> <20180807103410.4fe203cb@gandalf.local.home> <C1CB990F-8232-4168-89A8-E8C13B660B0B@google.com> <20180807110906.3a1b0ac4@gandalf.local.home>
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
Message-ID: <6B9E5DC9-0859-41B4-9B72-A7D85E9EA2AD@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On August 7, 2018 11:09:06 AM EDT, Steven Rostedt <rostedt@goodmis=2Eorg> =
wrote:
>On Tue, 07 Aug 2018 10:48:05 -0400
>Joel Fernandes <joelaf@google=2Ecom> wrote:
>
>> >You mean if someone add a tracepoint callback to the irq disable
>> >tracepoint, and did a lockdep assert to make sure interrupts are
>> >disabled? =20
>>=20
>> Yes that's what I meant=2E
>
>That sounds like a "Doctor, it hurts me when I do this" problem ;-)

Haha, yes true=2E But just to clarify, I didn't do this to see the problem=
 but noticed it with turning on existing things=2E :-) but I see your point=
=2E=2E=2E

Thanks,

- Joel

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
