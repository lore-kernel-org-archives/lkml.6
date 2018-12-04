Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AEDC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E564214C1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:21:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E564214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbeLDTVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:21:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:36652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbeLDTVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:21:45 -0500
Received: from vmware.local.home (unknown [208.91.3.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAA32206B7;
        Tue,  4 Dec 2018 19:21:44 +0000 (UTC)
Date:   Tue, 4 Dec 2018 14:21:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     mingo@redhat.com, catalin.marinas@arm.com, will.deacon@arm.com,
        keescook@chromium.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] tracing: add cond_resched to ftrace_replace_code()
Message-ID: <20181204142142.4e2e2169@vmware.local.home>
In-Reply-To: <20181204141908.76e7afa5@vmware.local.home>
References: <20181204191229.6851-1-anders.roxell@linaro.org>
        <20181204141908.76e7afa5@vmware.local.home>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018 14:19:08 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > @@ -2435,6 +2438,13 @@ void __weak ftrace_replace_code(int enable)
> >  			/* Stop processing */
> >  			return;
> >  		}
> > +		/*
> > +		 * Some archs calls this function with interrupts or preemption
> > +		 * disabled. Howeve, other archs don't and this can cause a

typo "However". But could you write it this way:

	"However, for other archs that can preempt, this can cause an
	tremendous unneeded latency."

Thanks!

-- Steve

> > +		 * tremendous unneeded latency.
> > +		 */  
> 
> Actually, could you move the comment up where schedulable gets set?
> 
> Thanks!
> 
> -- Steve
> 
> > +		if (schedulable)
> > +			cond_resched();
> >  	} while_for_each_ftrace_rec();
> >  }
> >    
> 

