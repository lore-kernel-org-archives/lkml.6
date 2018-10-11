Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DA5C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE77020841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="STj6+kh7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE77020841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbeJKPW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 11:22:28 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46698 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbeJKPW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 11:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eUq5KoeUf2ZhuPmYIlzMPQE+tvsftW4aCqlZygN6TFU=; b=STj6+kh7xbvBsWrDKBgPoYbLz
        uZW8uDp/3yXYx87QKVKJWjDZ9nZFVRpyK1aWYXXUS2FOQ+gEgz1s7IMTOnQb2U2rk5tBQxkNMs/bi
        U/QO+5KKXNqdnffbLyt9RMGH6zgYrClQb/R5GxDm7eq199T3BNwFGhpqk5TBAzbEuZDMpcJQ9f70P
        nMj4EsJY1XPCnQwRBPkH0i0m4ZZZgN8eisYJ2annUuCKnRhkTOX6SOgBf9YoyVS80k6KiBWbhWexg
        Oid95yU5kZoGMGkpHU283/C1DplOpDOVAMuVI7CVuSEmZur1zbED8cpcWL6cD8iHk8j1yOOfqPtps
        HOSzjYjag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gAVp5-0001wZ-9Z; Thu, 11 Oct 2018 07:55:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 10CB82028047E; Thu, 11 Oct 2018 09:55:52 +0200 (CEST)
Date:   Thu, 11 Oct 2018 09:55:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Cc:     target-devel <target-devel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Christie <mchristi@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 2/2] target: Fix target_wait_for_sess_cmds breakage with
 active signals
Message-ID: <20181011075552.GA2162@hirez.programming.kicks-ass.net>
References: <1539141790-13557-1-git-send-email-nab@linux-iscsi.org>
 <1539141790-13557-3-git-send-email-nab@linux-iscsi.org>
 <20181010084335.GN5728@hirez.programming.kicks-ass.net>
 <1539236412.6150.18.camel@haakon3.daterainc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539236412.6150.18.camel@haakon3.daterainc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 10:40:12PM -0700, Nicholas A. Bellinger wrote:
> Hey Peter & Co,
> 
> On Wed, 2018-10-10 at 10:43 +0200, Peter Zijlstra wrote:
> > On Wed, Oct 10, 2018 at 03:23:10AM +0000, Nicholas A. Bellinger wrote:
> > > From: Nicholas Bellinger <nab@linux-iscsi.org>
> > > 
> > > With the addition of commit 00d909a107 in v4.19-rc, it incorrectly assumes no
> > > signals will be pending for task_struct executing the normal session shutdown
> > > and I/O quiesce code-path.
> > > 
> > > For example, iscsi-target and iser-target issue SIGINT to all kthreads as
> > > part of session shutdown.  This has been the behaviour since day one.
> > 
> > Not knowing much context here; but does it make sense for those
> > kthreads to handle signals, ever? Most kthreads should be fine with
> > ignore_signals().
> > 
> 
> iscsi-target + ib-isert uses SIGINT amongst dedicated rx/tx connection
> kthreads to signal connection shutdown, requiring in-flight se_cmd I/O
> descriptors to be quiesced before making forward progress to release
> se_session.
> 
> By the point wait_event_lock_irq_timeout() is called in the example
> here, one of the two rx/tx connection kthreads has been stopped, and the
> other kthread is still processing shutdown.  So while historically the
> pending SIGINTs where not cleared (or ignored) during shutdown at this
> point, there is no reason why they could not be ignored for iscsi-target
> + ib-isert.
> 
> That said, pre commit 00d909a107 code always used wait_for_completion()
> and ignored pending signals.  As-is target_wait_for_sess_cmds() is
> called directly from fabric driver code and in one case also from
> user-space via configfs_write_file(), so AFAICT it does need
> TASK_UNINTERRUPTIBLE.
> 

Fair enough, thanks for the background. I'm always a bit wary when
kthreads need to deal with signals, but this seems OK.
