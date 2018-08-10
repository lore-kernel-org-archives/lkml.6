Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AD3C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38CF22405
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="akqjv2ii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A38CF22405
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbeHJQf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 12:35:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727209AbeHJQf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 12:35:56 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0F6E223FE;
        Fri, 10 Aug 2018 14:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533909952;
        bh=N5F5zy5LKMLTxUk8qPTB8sy6Xe50g7oS+8nY3+w+pK0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=akqjv2iiB9ZqWF2RdJ3Z6NWQYZXutCQixrlyehEAJ/Vj9WXuJCTR5S7J3nt3Dr2yt
         6T49aQ1S+jpMp8VVJ7KJi579982dA6qDRY96BOg+Q/ZMVOgq3ziL44cDUTBZdZ6ovq
         QlW3jV6kB4iNirVpssC29zVW/8PYQCRVl0IYTg7M=
Message-ID: <1533909950.1918.10.camel@kernel.org>
Subject: Re: [PATCH v3 4/7] tracing: Add conditional snapshot
From:   Tom Zanussi <zanussi@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
Date:   Fri, 10 Aug 2018 09:05:50 -0500
In-Reply-To: <20180810070225.GC479@sejong>
References: <cover.1533753152.git.tom.zanussi@linux.intel.com>
         <d16a83f8320015c6d7cb6659e554bebe03eaabec.1533753152.git.tom.zanussi@linux.intel.com>
         <20180810070225.GC479@sejong>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-10 at 16:02 +0900, Namhyung Kim wrote:
> On Thu, Aug 09, 2018 at 09:34:14AM -0500, Tom Zanussi wrote:
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > Currently, tracing snapshots are context-free - they capture the
> > ring
> > buffer contents at the time the tracing_snapshot() function was
> > invoked, and nothing else.  Additionally, they're always taken
> > unconditionally - the calling code can decide whether or not to
> > take a
> > snapshot, but the data used to make that decision is kept
> > separately
> > from the snapshot itself.
> > 
> > This change adds the ability to associate with each trace instance
> > some user data, along with an 'update' function that can use that
> > data
> > to determine whether or not to actually take a snapshot.  The
> > update
> > function can then update that data along with any other state (as
> > part
> > of the data presumably), if warranted.
> > 
> > Because snapshots are 'global' per-instance, only one user can
> > enable
> > and use a conditional snapshot for any given trace instance.  To
> > enable a conditional snapshot (see details in the function and data
> > structure comments), the user calls tracing_snapshot_cond_enable().
> > Similarly, to disable a conditional snapshot and free it up for
> > other
> > users, tracing_snapshot_cond_disable() should be called.
> > 
> > To actually initiate a conditional snapshot,
> > tracing_snapshot_cond()
> > should be called.  tracing_snapshot_cond() will invoke the update()
> > callback, allowing the user to decide whether or not to actually
> > take
> > the snapshot and update the user-defined data associated with the
> > snapshot.  If the callback returns 'true', tracing_snapshot_cond()
> > will then actually take the snapshot and return.
> > 
> > This scheme allows for flexibility in snapshot implementations -
> > for
> > example, by implementing slightly different update() callbacks,
> > snapshots can be taken in situations where the user is only
> > interested
> > in taking a snapshot when a new maximum in hit versus when a value
> > changes in any way at all.  Future patches will demonstrate both
> > cases.
> > 
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > ---
> 
> [SNIP]
> > @@ -1741,9 +1788,16 @@ static inline bool
> > event_command_needs_rec(struct event_command *cmd_ops)
> >  	return cmd_ops->flags & EVENT_CMD_FL_NEEDS_REC;
> >  }
> >  
> > +typedef bool (*cond_update)(struct trace_array *tr, void
> > *cond_data);
> > +
> 
> I think it's better having "fn_t" suffix like 'cond_update_fn_t'.
> 

Yeah, makes sense, will change.

Thanks,

Tom

