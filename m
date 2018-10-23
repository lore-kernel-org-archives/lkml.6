Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DB8C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B825820813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1VHvmEEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B825820813
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbeJXC3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 22:29:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbeJXC3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 22:29:35 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 699A120671;
        Tue, 23 Oct 2018 18:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540317907;
        bh=R4KpHg/vibBHyOE2VlSTvPP6bhjBkOc+Oh/8G8JdH3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1VHvmEEvoCTiEKslJxUDz6o1VT7VqEmuSxq95Bz2dlViRy0pVwx+5lV0qSubikFWo
         Eh+DHwpY5vhCxpDRg8WuGm3mkS91p2DUOwtlgLZTbShXqtBXcFnB2wpcce+kgMrMK5
         1heSisSSk75YZ+QtT80raIcz4LRKh2m9dmExSv0U=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id CE554142C5E; Tue, 23 Oct 2018 15:05:03 -0300 (-03)
Date:   Tue, 23 Oct 2018 15:05:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     David Miller <davem@davemloft.net>
Cc:     jolsa@redhat.com, dzickus@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: perf overlapping maps...
Message-ID: <20181023180503.GA6114@kernel.org>
References: <20181022161613.GF2945@krava>
 <20181022.105842.1364583912952511294.davem@davemloft.net>
 <20181023063452.GB20075@krava>
 <20181023.105405.364015687995752826.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023.105405.364015687995752826.davem@davemloft.net>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 23, 2018 at 10:54:05AM -0700, David Miller escreveu:
> From: Jiri Olsa <jolsa@redhat.com>
> Date: Tue, 23 Oct 2018 08:34:52 +0200
> 
> > I'm not sure about using the misc field bit defined/used by userland,
> > in case there's some new one comming in future for fork event..
> > 
> > but the only other way I can think of now is adding new 'user' event
> > for that, but that ended up as a bigger change (attached)
> > 
> > I think if we make some 'big enough' comment about the bit usage,
> > your change is better.. will you post or should I?
> 
> There might be something else we can do to implement this, and I think
> making a whole new event for what is an application internal problem
> is overkill.

agreed, I saw this earlier today and thought about "use cpumode" but got
sidetracked with processing other patches :-\ see below.
 
> What is kind of silly about how all of the synthetic events work is
> that we throw away a lot of information by tossing the events over to
> the generic event processing engine of the perf tool.
> 
> So we generate the events knowing the thread, context, PID, cpu, etc.
> and then we lose all of that information, and the event processing
> engine has to look all of it up again.
> 
> This is also, BTW, the reason we have dependencies on synthetic event
> emission ordering.  F.e. this comes up wrt. COMM and FORK events.
> 
> I understand that this design allows the perf tool types to define a
> private function to dispatch the events, as is appropriate for what
> the tool is doing.
> 
> But the side effect of this design is that it means it is hard to pass
> internal state around, outside of the event object itself.
> 
> Anyways, I'll look into this and see if there is a better way to
> implement this.

IIRC this was first done for 'perf record', where we have to stash those
events in the perf.data file, to then, later, 'perf report' to process
those, so when working on 'perf top', it just reuses that machinery.

Sure, with some love and care 'perf top' could do better and update all
the data structures directly :-)

Anyway, have you guys considered tweaking using event->header.misc |=
PERF_RECORD_MISC_USER? The kernel leaves that as zero for the
PERF_RECORD_FORK it emits:

static void perf_event_task(struct task_struct *task,
                              struct perf_event_context *task_ctx,
                              int new)
{
        struct perf_task_event task_event;

        if (!atomic_read(&nr_comm_events) &&
            !atomic_read(&nr_mmap_events) &&
            !atomic_read(&nr_task_events))
                return;

        task_event = (struct perf_task_event){
                .task     = task,
                .task_ctx = task_ctx,
                .event_id    = {
                        .header = {
                                .type = new ? PERF_RECORD_FORK : PERF_RECORD_EXIT,
                                .misc = 0,
                                .size = sizeof(task_event.event_id),
                        },
<SNIP>
 
void perf_event_fork(struct task_struct *task)
{
        perf_event_task(task, NULL, 1);
        perf_event_namespaces(task);
}

#define PERF_RECORD_MISC_CPUMODE_UNKNOWN        (0 << 0)
#define PERF_RECORD_MISC_KERNEL                 (1 << 0)
#define PERF_RECORD_MISC_USER                   (2 << 0)

- Arnaldo
