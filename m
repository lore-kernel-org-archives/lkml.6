Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF32ECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 21:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17CF4208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 21:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17CF4208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbeJRFSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 01:18:09 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40264 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbeJRFSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 01:18:08 -0400
Received: by mail-qt1-f193.google.com with SMTP id b4-v6so31858490qtc.7;
        Wed, 17 Oct 2018 14:20:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z5N42SE15vLGSaeXRwXiC/wqscOsPOQ9tRgCgL795TI=;
        b=TgnF2UvIasQLAtS1jGd18F5J/4hRd0dOCtWvlHiz7tnFqihWeFQB77yRRWwEYW6PZw
         DSBb8WQ+v9ForlpQtMHDMl86gLx4hAKfCN+8qFkRP8rP280v9ultc6fylTlODCsIhx+I
         tNgVFef2Q67SfQ6GDjlUd7novShw63EOFgX/Y0o1P+9R2TGaMBNnqbNhJVB1umnLrGob
         ijsBiW62jSDpRADwmdUcckLFxC9KyxJr6bqX111ijwwq4vMkv21LJ5D3rpvsrRg2KJAx
         HVN5HnT5fvK1mttAU7AIhn1cpDyUTtkvYrfgnudg2NQ5H95+CmXsuVcDoehcTCOCHhXY
         pzqg==
X-Gm-Message-State: ABuFfoil/ZynCNGrVpzEBl7eTKHM/IGIA6u38DCXOyhqCadYG6FZoDCC
        Rws+kG2RQpfy2wy18IqQU7VSXxN2Ipc=
X-Google-Smtp-Source: ACcGV60Oc9WhIYTVuq8jbZEYIcmQXXhZ4dfjPEWXUd0dWhO6xkvoNri0eamBLDc9/dAhIrcNpYOMxw==
X-Received: by 2002:aed:3882:: with SMTP id k2-v6mr25405081qte.345.1539811234971;
        Wed, 17 Oct 2018 14:20:34 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::5:df1a])
        by smtp.gmail.com with ESMTPSA id l18-v6sm1186346qki.83.2018.10.17.14.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 14:20:33 -0700 (PDT)
Date:   Wed, 17 Oct 2018 17:20:29 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     valdis.kletnieks@vt.edu
Cc:     Dennis Zhou <dennis@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [BUG] ext4/block null pointer crashes in linux-next
Message-ID: <20181017212029.GA85639@dennisz-mbp.dhcp.thefacebook.com>
References: <13987.1539646128@turing-police.cc.vt.edu>
 <20181016160203.GA88193@dennisz-mbp.dhcp.thefacebook.com>
 <20181016182513.GA9886@dennisz-mbp.dhcp.thefacebook.com>
 <13448.1539791255@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13448.1539791255@turing-police.cc.vt.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 11:47:35AM -0400, valdis.kletnieks@vt.edu wrote:
> On Tue, 16 Oct 2018 14:25:13 -0400, Dennis Zhou said:
> 
> > > >  grep execve /root/rpm-exec-strace
> > > > execve("/usr/bin/rpm", ["rpm", "-Uvh", "--force", "dracut-049-4.git20181010.fc30.x8"...], 0x7ffc9d967d80 /* 33 vars */) = 0
> 
> > > Thanks for testing and reporting this! Do you mind sending me your
> > > reproducer?
> 
> See above. An 'rpm' command blows it up....
> 
> > I've spent some time thinking about this, and this is my guess at what
> > is happening without seeing your reproducer. The system is under memory
> > pressure and a new cgroup is being created. The cgroup allocation fails
> > causing the request_list code to fallback and walk up the blkg tree.
> > There is special handling for the root cgroup, but I missed that case
> > and it fails there I believe.
> 
> Hmm... I boot to single-user, do a cd, and run 'rpm -Uvh --force' on an RPM
> that was already installed. (I originally hit this with 'dnf', but running 'dnf
> update' wouldn't trigger a crash if the system was up to date.  To make a
> bisect workable, I ended up using RPM to re-install an already installed
> package or 3 triggered it as well.
> 
> That's a consistent reproducer for me.  rpm does an execve() (actually,
> it does 5), and one of them goes kablam.  I've also managed to hit it
> once doing an 'rm'.
> 
> And my laptop has 16G of ram.  Shouldn't be any memory pressure at all in
> single-user mode.  So it looks like you fixed a bug, but not the one I was hitting.
> 
> > In addition to sending me the reproducer and your config, can you please
> > try the patch below?
> 
> Tried the patch, didn't make a difference. So there's at least one more bug
> out there to find. :)
> 
> Config attached.

I apologize, but I'm having a hard time reproducing this myself. I am
not able to hit this issue in my qemu instance with linux-next built
with your config. I have been running 'rpm -Hvh --force fio.rpm' several
times and haven't seen the issue.

Would it be possible for you to create a minimal qemu image that
reproduces the issue as I'm having issues reproducing it with my setup?
Additionally, I've added some more debug text in the diff below. If you
could apply that and send me the full dmesg that would be great. Lastly,
can you just confirm for me that the commit before, f0fcb3ec89f3
"blkcg: remove additional reference to the css", isn't seeing this
issue?

Thanks,
Dennis
---
diff --git a/block/blk-core.c b/block/blk-core.c
index 4dbc93f43b38..1b56cec40301 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1538,6 +1538,19 @@ static struct request *get_request(struct request_queue *q, unsigned int op,
 
 	rl = blk_get_rl(q, bio);	/* transferred to @rq on success */
 retry:
+	printk_once(KERN_INFO "dennis zhou");
+	if (q != rl->q) {
+		printk(KERN_INFO "dennis: q %px != rl->q %px", q, rl->q);
+		if (bio && bio->bi_blkg)
+			printk(KERN_INFO "dennis: bio: %px, root: %px",
+			       bio->bi_blkg->blkcg, &blkcg_root);
+	}
+	if (!q)
+		printk(KERN_INFO "dennis: q is null!");
+	if (!rl)
+		printk(KERN_INFO "dennis: rl is null!");
+	if (!rl->q)
+		printk(KERN_INFO "dennis: rl->q is null!");
 	rq = __get_request(rl, op, bio, flags, gfp);
 	if (!IS_ERR(rq))
 		return rq;
