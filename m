Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E3EC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A757620834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A757620834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbeLDF6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 00:58:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:55776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbeLDF6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 00:58:06 -0500
Received: from vmware.local.home (unknown [184.48.106.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D11472146D;
        Tue,  4 Dec 2018 05:58:04 +0000 (UTC)
Date:   Tue, 4 Dec 2018 00:58:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, srikar@linux.vnet.ibm.com,
        mhiramat@kernel.org, liu.song.a23@gmail.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        ananth@linux.vnet.ibm.com, alexis.berlemont@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Subject: Re: [PATCH] Uprobes: Fix kernel oops with delayed_uprobe_remove()
Message-ID: <20181204005803.787578e7@vmware.local.home>
In-Reply-To: <9f73b926-b3a5-2519-3a9e-91de35899a6e@linux.ibm.com>
References: <20181114081921.26484-1-ravi.bangoria@linux.ibm.com>
        <20181114160600.GD13885@redhat.com>
        <556c2aa5-550d-d96f-7ed2-549d8f3d803b@linux.ibm.com>
        <20181115124317.GA23272@redhat.com>
        <9f73b926-b3a5-2519-3a9e-91de35899a6e@linux.ibm.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Dec 2018 11:52:41 +0530
Ravi Bangoria <ravi.bangoria@linux.ibm.com> wrote:

> Hi Steve,
> 
> Please pull this patch.
> 

Please send a v2 version of the patch with the updated change log. And
should it have a Fixes and be tagged for stable?

-- Steve

> Thanks.
> 
> On 11/15/18 6:13 PM, Oleg Nesterov wrote:
> > On 11/15, Ravi Bangoria wrote:  
> >>
> >> There could be a race between task exit and probe unregister:
> >>
> >>   exit_mm()
> >>   mmput()
> >>   __mmput()                     uprobe_unregister()
> >>   uprobe_clear_state()          put_uprobe()
> >>   delayed_uprobe_remove()       delayed_uprobe_remove()
> >>
> >> put_uprobe() is calling delayed_uprobe_remove() without taking
> >> delayed_uprobe_lock and thus the race sometimes results in a
> >> kernel crash. Fix this by taking delayed_uprobe_lock before
> >> calling delayed_uprobe_remove() from put_uprobe().
> >>
> >> Detailed crash log can be found at:
> >>   https://lkml.org/lkml/2018/11/1/1244  
> > 
> > Thanks, looks good,
> > 
> > Oleg.
> >   

