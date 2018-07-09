Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4F7C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C053C208E2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qrm1SlQo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C053C208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933340AbeGISZj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 14:25:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932872AbeGISZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 14:25:38 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CDF7208E1;
        Mon,  9 Jul 2018 18:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531160737;
        bh=j5gbrZknnsZAdkB5FUTqnSynrxZpvgVQlz1VuesBGvc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Qrm1SlQox7CHNDQiRkneLEJK/rD40/bFIWI6A7LY4AkbXRD/rxEIKDGvJUiMGkzZn
         HEKz5gDU7cG6W4pyeEOMxl2QEUuVmIZxcW6ZMftmC1XVWQcOsHJWWUNFQS/mHyeEh8
         SD5zOcccJ7XQ3H4HXIH0yY4n+vOrJQAXueehd+SQ=
Message-ID: <1531160735.20374.17.camel@kernel.org>
Subject: Re: [PATCH v2 0/7] tracing: Hist trigger snapshot and onchange
 additions
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Date:   Mon, 09 Jul 2018 13:25:35 -0500
In-Reply-To: <20180708000006.5b93884b8123392ab2446809@kernel.org>
References: <cover.1530561352.git.tom.zanussi@linux.intel.com>
         <20180708000006.5b93884b8123392ab2446809@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Sun, 2018-07-08 at 00:00 +0900, Masami Hiramatsu wrote:
> Hi Tom,
> 
> On Mon,  2 Jul 2018 15:22:19 -0500
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > Hi,
> > 
> > This is v2 of the hist trigger snapshot and onchange additions
> > patchset.  It adds a couple fixes to problems flagged by the kbuild
> > test robot, but is otherwise the same as v1.
> > 
> > Changes since v1:
> > 
> >   - added missing tracing_cond_snapshot_data() definition for when
> >     CONFIG_TRACER_SNAPSHOT not defined
> >   - removed an unnecessary WARN_ON() in track_data_snapshot_print()
> > 
> > 
> > Original text:
> > 
> > This patchset adds some useful new functions to the hist
> > trigger code: a snapshot action and an onchange handler.
> > 
> > In order to make it easier to add these and in the process make the
> > code more generic, I separated the code into explicit 'handlers'
> > and
> > 'actions', handlers being things like 'onmax' and 'onchange', and
> > 'actions' being things like 'take a snapshot' or 'save some
> > fields'.
> 
> Sounds great!
> 
> By the way, it seems that nowadays the syntax of trigger is
> very complicated. For example, we can set some 'actions' without
> handlers, but this introduce new 'handlers' on it.
> 
> Could you consider not just extending it, but refactor it from
> the viewpoint of consistent and extensible syntax?
> 
> e.g. if we support
> 
> <actions> if <condition>
> 
> syntax, why we can not do 
> 
> <actions> onchange(<var>)

It seems that doing this would restrict you to only one handler e.g.
you could no longer do something like:

  ...:onchange($var1).save(...):onmax($var2).snapshot()

I'm not sure how you would do that with your syntax.

On the other hand, if the most common use case is just a single handler
  along with one or more actions, I think it would make sense to
provide a shorthand like you describe which just gets translated into
the longer more explicit form.  Or were you thinking of something more
radical?

Thanks,

Tom

> 
