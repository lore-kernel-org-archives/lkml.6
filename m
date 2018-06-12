Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2C9B3C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 23:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E049520891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 23:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E049520891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934898AbeFLXgJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 19:36:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36994 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934156AbeFLXgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 19:36:03 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EA859FDC;
        Tue, 12 Jun 2018 23:36:02 +0000 (UTC)
Date:   Tue, 12 Jun 2018 16:36:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Davidlohr Bueso <dbueso@suse.de>, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] ipc: Limit sysctl value to IPCMNI
Message-Id: <20180612163601.bef7f58dadda2832b36db3f6@linux-foundation.org>
In-Reply-To: <s5htvq8zf2n.wl-tiwai@suse.de>
References: <20180608134949.12672-1-tiwai@suse.de>
        <20180608141659.8a517b128c756b4d0b813c9e@linux-foundation.org>
        <s5ha7s43167.wl-tiwai@suse.de>
        <20180611161845.6164d3a6c2df353fe11895bf@linux-foundation.org>
        <s5htvq8zf2n.wl-tiwai@suse.de>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2018 08:36:32 +0200 Takashi Iwai <tiwai@suse.de> wrote:

> > Well the present behaviour is to convert higher values downwards, yes?
> > 
> > int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
> > {
> > 	kuid_t euid;
> > 	kgid_t egid;
> > 	int id, err;
> > 
> > 	if (limit > IPCMNI)
> > 		limit = IPCMNI;
> > 
> > So if someone out there is presently setting this to 999999 then their
> > kernel will work just fine.  After your proposed change, it will no
> > longer do so - the tuning attempt will fail with -EINVAL.
> > 
> > It really does us no good to say "you shouldn't have been doing that". 
> > The fact that they *are* doing it and that it works OK is the kernel
> > developers' fault for not applying suitable checking on day one.  I
> > think we're stuck with continuing to accept such input.
> 
> Hm, that's one concern, yes.
> 
> OTOH, we do secretly ignore the input value, and this isn't what's
> expected by user, either.  Moreover, user-space has no slightest idea
> which value can be accepted and which not.
> 
> Actually I posted it just because of requests from customers who
> needed to raise the bar, but didn't notice the effect.
> 
> Maybe another possible solution would be to add another proc entry to
> handle this correctly, and make the old one only for compatibility.

Yes, I guess so.  Just leave the old tunable alone.  Possibly we
could add a printk_once("please switch to the new interface").
