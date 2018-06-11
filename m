Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B11FEC004E4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 23:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68EAC20839
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 23:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68EAC20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933219AbeFKXSs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 19:18:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49120 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932775AbeFKXSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 19:18:47 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.103])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7FEF912C3;
        Mon, 11 Jun 2018 23:18:46 +0000 (UTC)
Date:   Mon, 11 Jun 2018 16:18:45 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Davidlohr Bueso <dbueso@suse.de>, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] ipc: Limit sysctl value to IPCMNI
Message-Id: <20180611161845.6164d3a6c2df353fe11895bf@linux-foundation.org>
In-Reply-To: <s5ha7s43167.wl-tiwai@suse.de>
References: <20180608134949.12672-1-tiwai@suse.de>
        <20180608141659.8a517b128c756b4d0b813c9e@linux-foundation.org>
        <s5ha7s43167.wl-tiwai@suse.de>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 09 Jun 2018 08:48:48 +0200 Takashi Iwai <tiwai@suse.de> wrote:

> On Fri, 08 Jun 2018 23:16:59 +0200,
> Andrew Morton wrote:
> > 
> > On Fri,  8 Jun 2018 15:49:49 +0200 Takashi Iwai <tiwai@suse.de> wrote:
> > 
> > > Currently shmmni proc entry accepts all entered integer values, but
> > > the practical limit is IPCMNI (32768).  This confuses user as if a
> > > bigger value were accepted but not applied correctly.
> > > 
> > > This patch changes the proc entry to use *_minmax variant to limit the
> > > accepted values accordingly.
> > 
> > Waiman Long was working on a (vastly more complicated) patchset to
> > address this.
> 
> That's great.  Any patch available for testing?

I think
http://lkml.kernel.org/r/1520885744-1546-1-git-send-email-longman@redhat.com
is the most recent version.

> 
> > > --- a/ipc/ipc_sysctl.c
> > > +++ b/ipc/ipc_sysctl.c
> > > @@ -99,6 +99,7 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
> > >  static int zero;
> > >  static int one = 1;
> > >  static int int_max = INT_MAX;
> > > +static int ipcmni = IPCMNI;
> > >  
> > >  static struct ctl_table ipc_kern_table[] = {
> > >  	{
> > > @@ -120,7 +121,9 @@ static struct ctl_table ipc_kern_table[] = {
> > >  		.data		= &init_ipc_ns.shm_ctlmni,
> > >  		.maxlen		= sizeof(init_ipc_ns.shm_ctlmni),
> > >  		.mode		= 0644,
> > > -		.proc_handler	= proc_ipc_dointvec,
> > > +		.proc_handler	= proc_ipc_dointvec_minmax,
> > > +		.extra1		= &zero,
> > > +		.extra2		= &ipcmni,
> > >  	},
> > >  	{
> > >  		.procname	= "shm_rmid_forced",
> > 
> > What is the back-compatibility situation here?
> 
> It's obviously an error to set such a high value and suppose that it
> were accepted.  So relying on that behavior must be broken in
> anyway...

Well the present behaviour is to convert higher values downwards, yes?

int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
{
	kuid_t euid;
	kgid_t egid;
	int id, err;

	if (limit > IPCMNI)
		limit = IPCMNI;

So if someone out there is presently setting this to 999999 then their
kernel will work just fine.  After your proposed change, it will no
longer do so - the tuning attempt will fail with -EINVAL.

It really does us no good to say "you shouldn't have been doing that". 
The fact that they *are* doing it and that it works OK is the kernel
developers' fault for not applying suitable checking on day one.  I
think we're stuck with continuing to accept such input.

