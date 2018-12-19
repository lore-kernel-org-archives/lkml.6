Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B40C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B514B218D0
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545231763;
	bh=pfPoC7qOLzRhQUVpLIvtuFLSq5LXrY8T0LKX4sdskCI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=pQMY6i4f3VnFKpLM2LnEGBwthJjOPDlabBV+lLdGrb7fObQqBJ4dxB78LAzACAGv3
	 kGlMBCPJ2xHObwpWX2atYMBumEfYucwpNvppnGldvANUKYhJgtzNl+9+S1ZEz3jm8O
	 jjk6tnbjuJNprmJs9HrvKa+8WtsNdZ9XAB4rTYOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbeLSPCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:02:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:35244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727973AbeLSPCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:02:39 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA86E20874;
        Wed, 19 Dec 2018 15:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545231758;
        bh=pfPoC7qOLzRhQUVpLIvtuFLSq5LXrY8T0LKX4sdskCI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=oG0CQ+8WSnwF5Tu8VQapSwdmx+BP3dnH/RFTuF1aUV74MXOYDEJCJ4LCJ76GwNf3G
         HTd2RhYVRKY4dSjIQuf0BZcrzMXKecwRvtI9Ntr7ppVNwVD2gtZRBVQYOeGvYXA8VV
         jClHmYc/nY0GR6HKg1RWXgvw460/EHcQ9A2GTTCc=
Message-ID: <1545231756.4491.3.camel@kernel.org>
Subject: Re: [PATCH 0/7] tracing: Hist trigger var-ref cleanup and comments
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Date:   Wed, 19 Dec 2018 09:02:36 -0600
In-Reply-To: <20181219212739.d5ec4edf7443c3dc1448c8d2@kernel.org>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
         <20181219212739.d5ec4edf7443c3dc1448c8d2@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-12-19 at 21:27 +0900, Masami Hiramatsu wrote:
> Hi Tom,
> 
> On Tue, 18 Dec 2018 14:33:19 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > Hi,
> > 
> > This patchset is a standalone series broken out of the v8 version
> > of
> > the 'tracing: Hist trigger snapshot and onchange additions'
> > patchset.
> > 
> > It's a series of changes resulting from some suggestions from
> > Namhyung
> > for making the variable-reference handling code more understandable
> > through some refactoring and comments.
> > 
> > It also added a new patch changing all strlen() to sizeof() for
> > string
> > constants, in trace_events_hist.c
> > 
> > Also, in the 'tracing: Remove open-coding of hist trigger var_ref
> > management' patch, in create_var_ref(), moved the saving of
> > ref_field
> > and update of ref_field->var_ref_idx into the 'if' as pointed out
> > by
> > Dan Carpenter/smatch 0-day robot.
> > 
> > It doesn't introduce any functional changes and can be applied
> > independently of the other patchset.
> 
> OK, now it is very clear to me :-)
> 
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> for the series.
> 

Thanks, Masami!

Tom

