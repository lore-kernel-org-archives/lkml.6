Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1DCC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B4720645
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B4720645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeJQCRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 22:17:00 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:45106 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeJQCQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 22:16:59 -0400
Received: by mail-yw1-f67.google.com with SMTP id v198-v6so9299723ywg.12;
        Tue, 16 Oct 2018 11:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GcRjA4Jb7umDUNIbsQL98jdxT0N/Qga24xICECqf7I8=;
        b=WRmKaoZhXi7Q9OTEJBjRY9Mev4rmh1wkg9U9ZLCoP3zric6f6IeNXYXat8fZb4FLNl
         IE6uNsBhQhlbaV2OAJ8o7m2bLdDTAl01bnfXDwiSoqinRo+GCN646fgucRl/9fr0ct4o
         GNBkv9VqHVhVlinS8bK0wuIyiUfxx2rr2vsq2yFPxnL7lI5+wSTZZEyJEC7Gs9RJidkP
         cGCB2dRQpUXESsMpa8iw8mMUkMUowN8XVaOen3ju4lIcn3pt5indwitMuQ/wWn0vyQTH
         +mDv58ncfFJ6j4QqwAYTmnrr5nBWgVB3QZSTx4vOdEUy0ixcpurk9FTmEtbhCvhLiW/h
         kfBQ==
X-Gm-Message-State: ABuFfojF1EoLKnOkpOg2wWn8ntHPF3Pu7Nk4u04BDRyqBQPs139orC3V
        nhiMDge+YM9hIShvR26Mrmo=
X-Google-Smtp-Source: ACcGV61lt1TbdpuuZmqc7vfQKrE9zzw0OnnplRdHOsHYn+5YAKmwaPpZUTpB6/sR17OkF5NnA+CK4w==
X-Received: by 2002:a81:118f:: with SMTP id 137-v6mr12994234ywr.412.1539714316615;
        Tue, 16 Oct 2018 11:25:16 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::7:b03f])
        by smtp.gmail.com with ESMTPSA id s3-v6sm3778856ywc.72.2018.10.16.11.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 11:25:15 -0700 (PDT)
Date:   Tue, 16 Oct 2018 14:25:13 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     valdis.kletnieks@vt.edu
Cc:     Theodore Ts'o <tytso@mit.edu>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [BUG] ext4/block null pointer crashes in linux-next
Message-ID: <20181016182513.GA9886@dennisz-mbp.dhcp.thefacebook.com>
References: <13987.1539646128@turing-police.cc.vt.edu>
 <20181016160203.GA88193@dennisz-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016160203.GA88193@dennisz-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 12:02:03PM -0400, Dennis Zhou wrote:
> Hi Vladis,
> 
> On Mon, Oct 15, 2018 at 07:28:48PM -0400, valdis.kletnieks@vt.edu wrote:
> > So I finally had a chance to find a replicator and finish bisecting this and:
> > 
> > [/usr/src/linux-next] git bisect good
> > e2b0989954ae7c80609f77e7ce203bea6d2c54e1 is the first bad commit
> > commit e2b0989954ae7c80609f77e7ce203bea6d2c54e1
> > Author: Dennis Zhou (Facebook) <dennisszhou@gmail.com>
> > Date:   Tue Sep 11 14:41:35 2018 -0400
> > 
> >     blkcg: cleanup and make blk_get_rl use blkg_lookup_create
> > 
> > I was able to do a bit of sleuthing with strace, and I tracked it down to one of
> > several execve() calls that 'rpm' makes with my replicating test case.
> > 
> >  grep execve /root/rpm-exec-strace 
> > execve("/usr/bin/rpm", ["rpm", "-Uvh", "--force", "dracut-049-4.git20181010.fc30.x8"...], 0x7ffc9d967d80 /* 33 vars */) = 0
> > [pid 119212] execve("/bin/sh", ["/bin/sh", "/usr/src/redhat/tmp/rpm-tmp.w7fu"..., "0", "0"], 0x7ffdfe17d480 /* 33 vars */) = 0
> > [pid 119213] execve("/sbin/ldconfig", ["/sbin/ldconfig"], 0x558ccf928ac0 /* 33 vars */) = 0
> > [pid 119216] execve("/bin/sh", ["/bin/sh", "/usr/src/redhat/tmp/rpm-tmp.bIKt"..., "0", "0"], 0x7ffdfe17d480 /* 33 vars */) = 0
> > [pid 119217] execve("/usr/bin/systemd-run", ["/usr/bin/systemd-run", "/usr/bin/systemctl", "start", "man-db-cache-update"], 0x56360645d290 /* 33 vars */) = 0
> > [pid 119221] execve("/bin/sh", ["/bin/sh", "/usr/src/redhat/tmp/rpm-tmp.OGWg"..., "0", "0"], 0x7ffdfe17d480 /* 33 vars */) = 0
> > [pid 119920] execve("/usr/bin/systemctl", ["/usr/bin/systemctl", "daemon-reload"], 0x55c0f5d43c30 /* 33 vars */) = 0
> > 
> > The ldconfig and systemctl commands run just fine stand-alone, so I'm suspecting the
> > calls to run the temp files - it's quite possible that execve() gets invoked on them before
> > writeback has actually gotten the data to the disk - though that shouldn't matter.
> > 
> > But I managed to trigger a different traceback. I cd /usr/src/redhat/tmp, and I
> > did an 'rm *' - and never got a prompt back. Traceback out of pstore below.
> > 
> > Now here's the weird part - I'd already unmounted, fsck'ed, and remounted the
> > file system before the 'rm *'.  And thinking that there was one file with a
> > busted inode that passed fsck.ext4's sniff test, I did:
> > 
> > cd /usr/src/redhat/tmp
> > for i in `find . -type f`; do sleep 5; echo $i; rm $i; done
> > 
> > and that worked just fine. Nothing left in that directory but . and ..  
> > I then re-ran my rpm-based replicator and it blew up again.
> > 
> > Traceback of the rm crash (I have *no* idea why it has systemd-tmpfile as Comm:
> > as none of the tmpfile config reference /usr/src at all, and the config says it
> > shouldn't have been running at the time of the crash, and I can't replicate as
> > the directory is now empty...)
> > 
> 
> Thanks for testing and reporting this! Do you mind sending me your
> reproducer?
> 
> Thanks,
> Dennis

I've spent some time thinking about this, and this is my guess at what
is happening without seeing your reproducer. The system is under memory
pressure and a new cgroup is being created. The cgroup allocation fails
causing the request_list code to fallback and walk up the blkg tree.
There is special handling for the root cgroup, but I missed that case
and it fails there I believe.

In addition to sending me the reproducer and your config, can you please
try the patch below?

Thanks,
Dennis

---
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index b7fd08013de2..1e76ceebeb5d 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -597,7 +597,7 @@ static inline struct request_list *blk_get_rl(struct request_queue *q,
 	if (unlikely(!blkg))
 		blkg = __blkg_lookup_create(blkcg, q);
 
-	if (!blkg_tryget(blkg))
+	if (blkg->blkcg == &blkcg_root || !blkg_tryget(blkg))
 		goto rl_use_root;
 
 	rcu_read_unlock();
