Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161503AbeBNRtS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:49:18 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:57324 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161300AbeBNRtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:49:17 -0500
From: Richard Weinberger <richard@sigma-star.at>
To: Enrico Weigelt <lkml@metux.net>
Cc: Aleksa Sarai <asarai@suse.de>,
        Linux Containers <containers@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: plan9 semantics on Linux - mount namespaces
Date: Wed, 14 Feb 2018 18:50:29 +0100
Message-ID: <4042675.OEy7g9C5ya@blindfold>
In-Reply-To: <e924b563-44c6-d678-a6cc-1181f4b820d5@metux.net>
References: <0f058286-a432-379b-f559-f2fe713807ab@metux.net> <60748622.exvCVAzLTp@blindfold> <e924b563-44c6-d678-a6cc-1181f4b820d5@metux.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 14. Februar 2018, 18:21:12 CET schrieb Enrico Weigelt:
> On 14.02.2018 16:17, Richard Weinberger wrote:
> >  From taking a *very* quick look into busybox source, I suspect this
> >  should fix> 
> > it:
> > 
> > diff --git a/util-linux/unshare.c b/util-linux/unshare.c
> > index 875e3f86e304..3f59cf4d27c2 100644
> > --- a/util-linux/unshare.c
> > +++ b/util-linux/unshare.c
> > @@ -350,9 +350,9 @@ int unshare_main(int argc UNUSED_PARAM, char **argv)
> > 
> >   		 * in that user namespace.
> >   		 */
> >   		
> >   		xopen_xwrite_close(PATH_PROC_SETGROUPS, "deny");
> > 
> > -		sprintf(uidmap_buf, "%u 0 1", (unsigned)reuid);
> > +		sprintf(uidmap_buf, "0 %u 1", (unsigned)reuid);
> > 
> >   		xopen_xwrite_close(PATH_PROC_UIDMAP, uidmap_buf);
> > 
> > -		sprintf(uidmap_buf, "%u 0 1", (unsigned)regid);
> > +		sprintf(uidmap_buf, "0 %u 1", (unsigned)regid);
> > 
> >   		xopen_xwrite_close(PATH_PROC_GIDMAP, uidmap_buf);
> >   	
> >   	} else
> >   	if (setgrp_str) {
> 
> hmm, now it works, but only when strace'ing it.
> that's really strange.

On my box, with my patch applied, also busybox works now.
 
> But still I wonder whether user_ns really solves my problem, as I don't
> want to create sandboxed users, but only private namespaces just like
> on Plan9.

Well, I'd be surprised if that works out of the box.
Since you're posting on LKML I assumed you're hacking the kernel to support 
plan9-alike namespaces...

Thanks,
//richard

-- 
sigma star gmbh - Eduard-Bodem-Gasse 6 - 6020 Innsbruck - Austria
ATU66964118 - FN 374287y
