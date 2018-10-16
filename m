Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1211C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 20:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7485721470
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 20:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5QyBWaK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7485721470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbeJQEnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 00:43:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbeJQEnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 00:43:21 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 120E62145D;
        Tue, 16 Oct 2018 20:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539723069;
        bh=PDOqq6tG0BdvR+bbHD3tslL8kNeYxtxJZOpmO2xD98s=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=J5QyBWaKO6T42/97kirKrluHZvc1PtzbaJdzLw4j0m78HuR8QmRE8ST4LOFYD+HHs
         fFbK/GfXkb9AmMrLAbUQwZgPhg5Uaylt7GD74yBeZwXK6OnUKJXVKkAZZ5EWUNmZ46
         GuhaNU+pI31zuztsrj2eRqONEtoqUNjRr0wsT5jU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Steven Rostedt <rostedt@goodmis.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <0b014d85-9988-0bf5-7b72-911dbbcdadfc@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        Kees Cook <keescook@chromium.org>,
        "Joel Fernandes \(Google\)" <joel@joelfernandes.org>,
        Geliang Tang <geliangtang@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pramod Gurav <gpramod@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
References: <1cae8f10-55f5-20ce-9105-30af6f88bd6e@codeaurora.org>
 <472db11e-49a6-a1ee-e298-791ee1bbb10b@codeaurora.org>
 <20181016141610.639b9000@gandalf.local.home>
 <accdce6d-8fd2-9f15-d4cd-704cbf0b32eb@codeaurora.org>
 <20181016144123.24c47b38@gandalf.local.home>
 <7781815e-cba2-9e36-db6d-268298747876@codeaurora.org>
 <20181016150328.3450d718@gandalf.local.home>
 <c94103d2-ed5d-bf43-fc71-c60e108f303e@codeaurora.org>
 <20181016151516.786b16cc@gandalf.local.home>
 <0b014d85-9988-0bf5-7b72-911dbbcdadfc@codeaurora.org>
Message-ID: <153972306834.5275.7510298070540576604@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
Date:   Tue, 16 Oct 2018 13:51:08 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sai Prakash Ranjan (2018-10-16 12:35:57)
> On 10/17/2018 12:45 AM, Steven Rostedt wrote:
> > On Wed, 17 Oct 2018 00:36:05 +0530
> > Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
> > =

> >> On 10/17/2018 12:33 AM, Steven Rostedt wrote:
> >>> On Wed, 17 Oct 2018 00:31:03 +0530
> >>> Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
> >>>    =

> >>>> Haa seems like you are right! With "ftrace=3Dfunction
> >>>> ftrace_filter=3Dmsm_read" , I can trigger the crash, but
> >>>> sadly "ftrace_notrace=3Dmsm_read" also crashes.
> >>>
> >>> So there's more than one problem area.
> >>>
> >>> What about ftrace_notrace=3Dm*
> >>>
> >>> ?
> >>>    =

> >>
> >> That too crashes.
> >>
> > =

> > Which compiler are you using and can you send me your config.
> > =

> Config attached.
> =

> Compiler: aarch64-linux-gnu-gcc (Linaro GCC 6.3-2017.02) 6.3.1 20170109
> =

> > I wonder if there's something screwing up with the way ftrace nops are
> > working on this board.
> > =

> > A couple things of note, 1) it works fine after boot up. 2) it crashes
> > in the initcall code, so it's not due to ftrace being enabled too early.
> > =

> > I'd like to see the full command line as well. I bet if you remove the
> > qcom,msm-uartdm from the command line, and had just ftrace=3Dfunction, =
it
> > may also boot fine too. Can you try that?
> > =

> =

> Kernel command line: root=3D/dev/disk/by-partlabel/rootfs rw rootwait =

> ftrace=3Dfunction ftrace_notrace=3Dm* earlycon console=3DttyMSM0,115200n8
> =

> qcom,msm-uartdm is not in command line, it is the earlycon. So without =

> earlycon(bootconsole), board boots fine as we discussed earlier.
> =


Have you tried with earlycon and no ftrace things on the commandline?

 root=3D/dev/disk/by-partlabel/rootfs rw rootwait earlycon console=3DttyMSM=
0,115200n8

If earlycon is causing problems, it sounds like this may be another case
of earlycon uart handing off to the uart driver and that failing because
something gets printed while the uart is transitioning from the earlycon
console to the kernel boot console. I recall the uart would trample on
itself in interesting ways.

