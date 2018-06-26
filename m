Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEC5C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60DA12697D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60DA12697D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965663AbeFZOkD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 10:40:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965499AbeFZOkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 10:40:02 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61EA025C24;
        Tue, 26 Jun 2018 14:40:01 +0000 (UTC)
Date:   Tue, 26 Jun 2018 10:39:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Namit Gupta <gupta.namit@samsung.com>,
        linux-kernel@vger.kernel.org, pankaj.m@samsung.com,
        a.sahrawat@samsung.com, himanshu.m@samsung.com
Subject: Re: [PATCH] printk: remove unnecessary kmalloc() from syslog during
 clear
Message-ID: <20180626103959.79e92a35@gandalf.local.home>
In-Reply-To: <20180626124332.62isabqkefpgqpgk@pathway.suse.cz>
References: <CGME20180620135951epcas5p3bd2a8f25ec689ca333bce861b527dba2@epcas5p3.samsung.com>
        <20180620135951epcas5p3bd2a8f25ec689ca333bce861b527dba2~54wyKcT0_3155531555epcas5p3y@epcas5p3.samsung.com>
        <20180625133705.7zsg2rkw4xtyg6ie@pathway.suse.cz>
        <20180625103704.49811ec1@gandalf.local.home>
        <20180625144407.GB443@tigerII.localdomain>
        <20180626124332.62isabqkefpgqpgk@pathway.suse.cz>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jun 2018 14:43:32 +0200
Petr Mladek <pmladek@suse.com> wrote:

> On Mon 2018-06-25 23:44:07, Sergey Senozhatsky wrote:
> > On (06/25/18 10:37), Steven Rostedt wrote:  
> > > 
> > > Is IMHO rather ugly.  
> > 
> > Either way works for me. So I'll leave it to you and Petr to decide :)
> >   
> > > And the original patch has one more advantage. If buf and clear are
> > > both NULL/zero, we don't take any locks.  
> > 
> > But we never use syslog_print_all(buf = NULL, clear = false). It's either
> > NULL/true [move forward clear idx, do not copy to user], or !NULL/use defined
> > value [copy to user, move or don't move clear idx forward]  
> 
> Yup, I suggest the following version as a compromise. It has the code
> duplication but I agree that it is negligible. Otherwise, it looks
> cleaner.
> 

This looks fine. For proper history though, what I do in this case,
would be to make this into two patches. One with Namit's original
patch, and then a second that removes the code duplication (your patch).

-- Steve

