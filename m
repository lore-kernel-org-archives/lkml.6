Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE8FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25117206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lkcl.net header.i=@lkcl.net header.b="FpRMy0mj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfANSz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 13:55:57 -0500
Received: from lkcl.net ([217.147.94.29]:57917 "EHLO lkcl.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbfANSz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 13:55:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lkcl.net; s=201607131;
        h=Content-Type:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version; bh=UgPEpsYplQ+nwiBi1solNWUZPjge1BGJ7RbLHRkFro0=;
        b=FpRMy0mjl1/WIfq+zLmtDcTdOK7QIxO3IRAPDT5oDIMivm/ba/KQ1I5x4Pd52oQt83ko9Y1teW6kneG18LyH3Z0gRjflUbYA8UN4dFTF1/rgqHfcUC1SN/wg9zHEUWbTsKQK/SDNNzCF1uxx3Q/ZgsKrSjzNmmAh5gFGEvtDqz8=;
Received: from mail-lf1-f49.google.com ([209.85.167.49])
        by lkcl.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <lkcl@lkcl.net>)
        id 1gj7Ot-0006DI-7x
        for linux-kernel@vger.kernel.org; Mon, 14 Jan 2019 18:55:55 +0000
Received: by mail-lf1-f49.google.com with SMTP id u18so35174lff.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 10:55:39 -0800 (PST)
X-Gm-Message-State: AJcUukejweCSulEPPLI+hnSJifpQbnDH3pddvfdwkcvYa7X4tpaSzGUg
        9TFtgVeE7ifAkeItzlyV6Fw/1zh1E6ISABPyn8U=
X-Google-Smtp-Source: ALg8bN7Igx6GL9p+qLzWTHIWtarNCGxvU9PNNceBFYL/E+1AaU+VfYaqDyIdWCmo0DPLV4jY2Kouw2Ex4ZhfOLjoPJg=
X-Received: by 2002:a19:5059:: with SMTP id z25mr14169890lfj.120.1547492134114;
 Mon, 14 Jan 2019 10:55:34 -0800 (PST)
MIME-Version: 1.0
References: <CAPweEDyvUdGvwy4u5qoA2QgDow0npZBMqjeMiU2RqzrJ_q4Omw@mail.gmail.com>
In-Reply-To: <CAPweEDyvUdGvwy4u5qoA2QgDow0npZBMqjeMiU2RqzrJ_q4Omw@mail.gmail.com>
From:   Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Date:   Mon, 14 Jan 2019 18:55:22 +0000
X-Gmail-Original-Message-ID: <CAPweEDyV487=EWqAibc5g_yhtuvy3w2qabCSOqh32q38rrXLSw@mail.gmail.com>
Message-ID: <CAPweEDyV487=EWqAibc5g_yhtuvy3w2qabCSOqh32q38rrXLSw@mail.gmail.com>
Subject: [RFC] spectre hardware-software cooperative mitigation
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, please cc me on replies. Hardware discussion may be found here:
https://groups.google.com/forum/?nomobile=true#!topic/comp.arch/mzXXTU2GUSo

I am designing a new processor, based on RISCV, that is intended as a
hybrid GPU VPU and CPU. For various reasons, it needs to be a
multi-issue Out of Order engine. The innocent question was therefore
asked, "how is Spectre to be dealt with?" which threw a massive
spanner in the works.

The processor is being designed to use multi-issue as a means to
implement Vector Processing. For example: for predicated elements,
several instructions (one per element) will be thrown into the
*standard* multi-issue instruction queue, and cancelled only when the
register containing the predicate mask is available and has been
decoded. Thus, resources are taken up that will affect and be affected
by other instructions, which is the very definition of Spectre timing
attacks.

ooops.

Standard Spectre mitigation would completely destroy the performance
and viability of the project's Vector Engine, as well as many other
features.

So I have a proposal that, if correct and implemented, may be adopted
by other architectures as a mitigation solution that allows out of
order to continue to be used. It is a collaborative solution that
specifically requires explicit instructions to be added (and called)
at the aporopriate time(s).

The issue with Spectre attacks is that untrusted code may cause past
OR FUTURE instructions to change the amount of time in which they will
complete. An in-order architecture does not have this problem (except
where pipeline stalls occur), as there is always [almost always]
enough resources available that allow instructions (pipelines) to
proceed without blocking.

OoO typically has resource bottlenecks that are affected by other
instructions. The whole POINT of an OoO design is to run ahead,
utilising these resources speculatively and, duh, out of order.

To deal with absolutely every possible flaw in the OoO paradigm is a
total nightmare. Performance as people are discovering is utterly
trashed. Code complexity both in software terms and hardware terms
goes mental. Intel had to REMOVE hyperthreading from its latest
processors, the crossover timing leakage is that bad.

There is another way to ensure that untrusted code cannot affect
secure code: clear out the "internal state" of the processor before
letting it proceed to run the untrusted code.

In this way it becomes impossible for untrusted code to ascertain the
state of the processor, because it has been reset back to a known
uniform (blank) state.

This REQUIRES an actual instruction that programs (and the kernel) may
call. It is NOT ENOUGH that the linux kernel try to deal with
absolutely every possible situation automatically, and it is a total
nightmare to even try.

It is also not enough that the hardware try to deal with this on its
own: that is insanely complex as well. The only real safe way is to
abandon all of the benefits of OoO and go back to in-order SINGLE
issue performance levels.

Clearly, both options are not viable or acceptable.

A hybrid solution is a reasonable compromise, that may even be
possible to implement right now, with code that, on processors that do
not have the proposed new instruction, issues sufficient NOPs (or
other suitably researched instructions) such that they create a
"processor internal state" firebreak between secure and untrusted
code.

The hardware version of the firebreak opcode would WAIT until the
processor internal state has cleared out. All outstanding speculative
instructions would be cancelled. All instructions waiting for
pipelines to complete would be waited for until they had completed,
and their results written to the register file. Only then would the
processor be allowed to proceed.

It is not enough to have these "firebreak" calls done automatically by
the linux kernel: they need to be part of standard applications. An
example is firefox, which has a single process for javascript. Specre
atracks have been shown to exist using untrusted arbitrary javascript,
and if that javascript is being executed by a single process, then it
is the responsibility of that process to call the "firebreak" just
before allowing the untrusted javascript to execute.

This is going to be a mammoth task. The alternatives are to continue
as things are, which is a mess that cannot be cleaned up by either of
(mutually exclusive) hardware or software alone.

Thoughts and feedback appreciated.

l.
