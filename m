Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424EEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284222070B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544808567;
	bh=J69UGZ0QTfOA0DiHzi61NpuKOQf+o1W+E1k+UCDDr5s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=rCtQxdWD+mIInJhqfmsuw5SLTUf1YvlpNrNm33/C1GbsVfe6oMlx7M926tf+AivmH
	 mFy6D7T41UkFKv/jLuZbfEUVK0Vv25ZUQf/gqVOW8fPEiHuDvQqeFp58RZvQlENJOX
	 2PQ11hOU8OcGfxyNeVtp7aupfACvXCIUnh+FTm2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbeLNR3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:29:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:44300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730083AbeLNR3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:29:24 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE110206C0;
        Fri, 14 Dec 2018 17:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544808564;
        bh=J69UGZ0QTfOA0DiHzi61NpuKOQf+o1W+E1k+UCDDr5s=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cYO9za2dvTyf0uvTmjKvbHC+UaBy/dSGG6nG6yTWV0pe2SYn8DIu2XACIGd/SjbWh
         dduhVXrwys6HWvt/l7SNfdKVScPdqqioW4xQChOcjzlKhjlHtY/0TrHYtVW1k/cGhY
         GA6UCEU7qIy1a1oHcT8JPtpnAu2qujVJaaIcMz6w=
Message-ID: <1544808561.10497.15.camel@kernel.org>
Subject: Re: [PATCH v8 20/22] tracing: Use hist trigger's var_ref array to
 destroy var_refs
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Date:   Fri, 14 Dec 2018 11:29:21 -0600
In-Reply-To: <20181215013119.dc796fd4d2d21535adb4cf6c@kernel.org>
References: <cover.1544483272.git.tom.zanussi@linux.intel.com>
         <4d6103ab7b4fdef81a82e2977b4005a26212a726.1544483273.git.tom.zanussi@linux.intel.com>
         <20181215013119.dc796fd4d2d21535adb4cf6c@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Sat, 2018-12-15 at 01:31 +0900, Masami Hiramatsu wrote:
> On Mon, 10 Dec 2018 18:01:34 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > Since every var ref for a trigger has an entry in the var_ref[]
> > array,
> > use that to destroy the var_refs, instead of piecemeal via the
> > field
> > expressions.
> > 
> > This allows us to avoid having to keep and treat differently
> > separate
> > lists for the action-related references, which future patches will
> > remove.
> 
> I'm not so sure, but this seems a bugfix... if so, please move this
> at
> the top of this series.
> 

No, none of these are bugfixes - patches 17-22 are just some additional
cleanup that try to make the code easier to follow after Namhyung's
comments that things were confusing here.

Actually, what I should probably do is make these a separate series..

Tom
