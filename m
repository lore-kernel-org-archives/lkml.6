Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD631C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 21:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75BD72171F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 21:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544907700;
	bh=0ntFjkLax+h+m+5ABLI8ZX5Z9N5HcWceIC3au+YT+lY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=DsVW5ry55F0QS1jwwOwBHZ+jXffRGThVhFAnz2Cx10cMJfeNta2plG+gsIi+Jmu9z
	 f7QXHzyae7NoTUzpV0b0vGKmDq0kORz06wCzL6Nq/9D3MrfIF9yQLjP4dbWN1Rs85L
	 2N4clj+GBtE3uVNxc4M2w8jHCGs/zgNZ1Ame9gCU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbeLOVBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 16:01:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:46370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727928AbeLOVBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 16:01:39 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50FC920578;
        Sat, 15 Dec 2018 21:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544907698;
        bh=0ntFjkLax+h+m+5ABLI8ZX5Z9N5HcWceIC3au+YT+lY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=M0DK+55P1o2ulH0Ej5f/TxRyMTWdt/chWJrR0Q0D20aopuRKnpKW2yAGPnr3Np+Su
         EYeDeSoWjXmVGXKfdtYEdnUM8eI5F61BQ3wFveOuelrDgQvgVqApFmCA9VvIHPFsRB
         NpRc0BmB7qLSm0wHNF71id5sIu6DP4FDVP/rAlfc=
Message-ID: <1544907696.10497.17.camel@kernel.org>
Subject: Re: [PATCH v8 20/22] tracing: Use hist trigger's var_ref array to
 destroy var_refs
From:   Tom Zanussi <zanussi@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, vedang.patel@intel.com,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        julia@ni.com, linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Date:   Sat, 15 Dec 2018 15:01:36 -0600
In-Reply-To: <CAM9d7ciW3cHVFLeuP+pdC-+1fnGMkRnfwGsbeKX_Zj30f-r4hA@mail.gmail.com>
References: <cover.1544483272.git.tom.zanussi@linux.intel.com>
         <4d6103ab7b4fdef81a82e2977b4005a26212a726.1544483273.git.tom.zanussi@linux.intel.com>
         <20181215013119.dc796fd4d2d21535adb4cf6c@kernel.org>
         <1544808561.10497.15.camel@kernel.org>
         <CAM9d7ciW3cHVFLeuP+pdC-+1fnGMkRnfwGsbeKX_Zj30f-r4hA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,

On Sat, 2018-12-15 at 15:50 +0900, Namhyung Kim wrote:
> Hi Tom and Masami,
> 
> On Sat, Dec 15, 2018 at 2:29 AM Tom Zanussi <zanussi@kernel.org>
> wrote:
> > 
> > Hi Masami,
> > 
> > On Sat, 2018-12-15 at 01:31 +0900, Masami Hiramatsu wrote:
> > > On Mon, 10 Dec 2018 18:01:34 -0600
> > > Tom Zanussi <zanussi@kernel.org> wrote:
> > > 
> > > > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > > > 
> > > > Since every var ref for a trigger has an entry in the var_ref[]
> > > > array,
> > > > use that to destroy the var_refs, instead of piecemeal via the
> > > > field
> > > > expressions.
> > > > 
> > > > This allows us to avoid having to keep and treat differently
> > > > separate
> > > > lists for the action-related references, which future patches
> > > > will
> > > > remove.
> > > 
> > > I'm not so sure, but this seems a bugfix... if so, please move
> > > this
> > > at
> > > the top of this series.
> > > 
> > 
> > No, none of these are bugfixes - patches 17-22 are just some
> > additional
> > cleanup that try to make the code easier to follow after Namhyung's
> > comments that things were confusing here.
> > 
> > Actually, what I should probably do is make these a separate
> > series..
> 
> Agreed, I also think it's getting bigger and having these cleanups
> before the actual change would make things little bit easier IMHO.
> 

Yep, that's what I'll do then.

Thanks,

Tom

