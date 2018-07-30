Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BDBC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADCF320870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="PmuS9fI4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADCF320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731973AbeGaAEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:04:05 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39829 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbeGaAEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:04:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id a11-v6so7993700pgw.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 15:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OxMSe7YAOB0t1WLkNWLZWO7EX9YmyhlpLisj6e0VyCs=;
        b=PmuS9fI4BY4b8eHvLyzT6InmtWBeN7+o0DyW1oYcN6ZL9JFKzZlLfrTZU5FA2oH0n5
         ucM5b+xIDqQJFwJoTLYUvJH1LmgRfKogd4cMC/ahAdO0bTTeAtPT0gEK9IlKtoz1/OBU
         bk2dXGJf79zsd3k4DV8YRV4W/5fh12RztMYFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OxMSe7YAOB0t1WLkNWLZWO7EX9YmyhlpLisj6e0VyCs=;
        b=b8uJv+RG5DymLDpbD4HVwrECa0XvZIyRxZ/AeA8pj8pYTHiFW96UZlGS4GUFmIHf4C
         3GRZNSkpMfNLhsEp4RxZpO/T/zxtT34ia7vOD+qvVCX2F17wg1rg9JxxlkpXKTrl1j41
         lmBCchNXS6dwXxqANRsyB5vHRhdN6HYsiWi4MqEs5yBY9dbTlWWHsIyAJ+Qyjr7J05PL
         xcc4aYo3iKm0zCcNqIvYde6NcvHSdGvZtVIM2tpHzXZRgZDFXHZBEA6XYHVFmw99/qwn
         H7Af4Oj+WN7xQHEqVh39jswPTm9X/kngDi5IfhsGMcOWT1L6Scen4W4KzmHzY8jVDj++
         9bKQ==
X-Gm-Message-State: AOUpUlFLh31945BL/gIZbVn9vUg2GN7AaAZY+NTl0d1E7MlWWu7b4R2g
        YTQmahy+/7uhgWswN+6xlOm7pw==
X-Google-Smtp-Source: AAOMgpe8YB2eljpL3RXbg+t4U/G2PKg5i2S4m1y6YYeNdVqlmrt4NbH1EUPF1bLwVyrv0gBRE2F0cA==
X-Received: by 2002:a63:195e:: with SMTP id 30-v6mr17792153pgz.192.1532989618668;
        Mon, 30 Jul 2018 15:26:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id x66-v6sm29710348pff.123.2018.07.30.15.26.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 15:26:58 -0700 (PDT)
Date:   Mon, 30 Jul 2018 15:26:57 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Colascione <dancol@google.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Chenbo Feng <fengc@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joelaf@google.com>,
        Alexei Starovoitov <ast@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>
Subject: Re: [RFC] Add BPF_SYNCHRONIZE bpf(2) command
Message-ID: <20180730222657.GA197142@joelaf.mtv.corp.google.com>
References: <CAADnVQL=yTRvNLun2_oiwDvUvpvTV9=pOLyNhu=_cQ2sX04p5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQL=yTRvNLun2_oiwDvUvpvTV9=pOLyNhu=_cQ2sX04p5w@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 29, 2018 at 06:57:06PM +0300, Alexei Starovoitov wrote:
> On Fri, Jul 27, 2018 at 10:17 PM, Daniel Colascione <dancol@google.com> wrote:
> > On Sat, Jul 14, 2018 at 11:18 AM, Joel Fernandes <joel@joelfernandes.org>
> > wrote:
> >>
> >> By the way just curious I was briefly going through kernel/bpf/arraymap.c.
> >> How are you protecting against load-store tearing of values of array map
> >> updates/lookups?
> >>
> >> For example, if userspace reads an array map at a particular index, while
> >> another CPU is updating it, then userspace can read partial values /
> >> half-updated values right? Since rcu_read_lock is in use, I was hoping to
> >> find something like rcu_assign_pointer there to protect readers against
> >> concurrent updates.  Thanks for any clarification.
> >
> >
> > I'm also curious about the answer to this question.
> 
> i'm not sure I understand the question.
> bpf_map_type_array is a C-like array.
> There is no locking of elements.
> If single program executing on two cpus
> and accesses the same value it will collide.
> Same goes for user space vs prog parallel access.
> bpf long_memcpy is an attempt to provide minimal
> level of automicity when values are aligned and
> size==long.

Thanks for the answer. I think you answered the question.

Regards,

- Joel
