Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990E1C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EFEA205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EFEA205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeJPXxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:53:14 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:33593 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbeJPXxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:53:14 -0400
Received: by mail-yw1-f65.google.com with SMTP id m127-v6so9120412ywb.0;
        Tue, 16 Oct 2018 09:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BX4sro4ywhShct4ehpwMTR6jYTtEXaYngqn1gkErvqc=;
        b=BVfn8BGJaWTNjwpxBrb+qMHa8bsGpjRpjB/vYoK+waPr4/iPCWglAwBjOGiliaD64A
         w2hFYK5Eq48JBoHH5APUG8t3lJkjWn0pER050xwuZb3XO9vq/0FMyFY4wXBzoRz+DAVV
         19Tds+AckF9pmgzXo6ajWQeXv9FTRblX0w9J9zqeVa0J6mMlfiX13IDQJHAG7USxjIz7
         39yKP6R5hiVRBTQ8FeX5p2O7M8Flkdlk0tcStN4HudEh5Qz3+zNZcLoT4L0Y465xIQ9w
         VJ59v0xAYFE/DsTIRJfZPAoEj6DQIgGH8qwbmzi09URTuQvBlSVy6zOfc9mTmpnHj095
         uZqA==
X-Gm-Message-State: ABuFfoiFc15S6pFONcu09iGXMbepw1hFaU3/y+4rrL662qUKcDZMIS1+
        GFAjvQW2k04cY3TpLOw3nGo=
X-Google-Smtp-Source: ACcGV62dvCwomsxtFLIhQW8X5URBGcYQbvqGcn5B31+vZVCp17k5ei84QlTJNQvQvpOUMgvbTPPhBg==
X-Received: by 2002:a0d:e547:: with SMTP id o68-v6mr12150569ywe.287.1539705727233;
        Tue, 16 Oct 2018 09:02:07 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::7:b03f])
        by smtp.gmail.com with ESMTPSA id z130-v6sm4600907ywd.91.2018.10.16.09.02.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 09:02:06 -0700 (PDT)
Date:   Tue, 16 Oct 2018 12:02:03 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     valdis.kletnieks@vt.edu
Cc:     Theodore Ts'o <tytso@mit.edu>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [BUG] ext4/block null pointer crashes in linux-next
Message-ID: <20181016160203.GA88193@dennisz-mbp.dhcp.thefacebook.com>
References: <13987.1539646128@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13987.1539646128@turing-police.cc.vt.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladis,

On Mon, Oct 15, 2018 at 07:28:48PM -0400, valdis.kletnieks@vt.edu wrote:
> So I finally had a chance to find a replicator and finish bisecting this and:
> 
> [/usr/src/linux-next] git bisect good
> e2b0989954ae7c80609f77e7ce203bea6d2c54e1 is the first bad commit
> commit e2b0989954ae7c80609f77e7ce203bea6d2c54e1
> Author: Dennis Zhou (Facebook) <dennisszhou@gmail.com>
> Date:   Tue Sep 11 14:41:35 2018 -0400
> 
>     blkcg: cleanup and make blk_get_rl use blkg_lookup_create
> 
> I was able to do a bit of sleuthing with strace, and I tracked it down to one of
> several execve() calls that 'rpm' makes with my replicating test case.
> 
>  grep execve /root/rpm-exec-strace 
> execve("/usr/bin/rpm", ["rpm", "-Uvh", "--force", "dracut-049-4.git20181010.fc30.x8"...], 0x7ffc9d967d80 /* 33 vars */) = 0
> [pid 119212] execve("/bin/sh", ["/bin/sh", "/usr/src/redhat/tmp/rpm-tmp.w7fu"..., "0", "0"], 0x7ffdfe17d480 /* 33 vars */) = 0
> [pid 119213] execve("/sbin/ldconfig", ["/sbin/ldconfig"], 0x558ccf928ac0 /* 33 vars */) = 0
> [pid 119216] execve("/bin/sh", ["/bin/sh", "/usr/src/redhat/tmp/rpm-tmp.bIKt"..., "0", "0"], 0x7ffdfe17d480 /* 33 vars */) = 0
> [pid 119217] execve("/usr/bin/systemd-run", ["/usr/bin/systemd-run", "/usr/bin/systemctl", "start", "man-db-cache-update"], 0x56360645d290 /* 33 vars */) = 0
> [pid 119221] execve("/bin/sh", ["/bin/sh", "/usr/src/redhat/tmp/rpm-tmp.OGWg"..., "0", "0"], 0x7ffdfe17d480 /* 33 vars */) = 0
> [pid 119920] execve("/usr/bin/systemctl", ["/usr/bin/systemctl", "daemon-reload"], 0x55c0f5d43c30 /* 33 vars */) = 0
> 
> The ldconfig and systemctl commands run just fine stand-alone, so I'm suspecting the
> calls to run the temp files - it's quite possible that execve() gets invoked on them before
> writeback has actually gotten the data to the disk - though that shouldn't matter.
> 
> But I managed to trigger a different traceback. I cd /usr/src/redhat/tmp, and I
> did an 'rm *' - and never got a prompt back. Traceback out of pstore below.
> 
> Now here's the weird part - I'd already unmounted, fsck'ed, and remounted the
> file system before the 'rm *'.  And thinking that there was one file with a
> busted inode that passed fsck.ext4's sniff test, I did:
> 
> cd /usr/src/redhat/tmp
> for i in `find . -type f`; do sleep 5; echo $i; rm $i; done
> 
> and that worked just fine. Nothing left in that directory but . and ..  
> I then re-ran my rpm-based replicator and it blew up again.
> 
> Traceback of the rm crash (I have *no* idea why it has systemd-tmpfile as Comm:
> as none of the tmpfile config reference /usr/src at all, and the config says it
> shouldn't have been running at the time of the crash, and I can't replicate as
> the directory is now empty...)
> 

Thanks for testing and reporting this! Do you mind sending me your
reproducer?

Thanks,
Dennis
