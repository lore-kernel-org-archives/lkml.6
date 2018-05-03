Return-Path: <axboe@kernel.dk>
ARC-Seal: i=1; a=rsa-sha256; t=1525361820; cv=none;
        d=google.com; s=arc-20160816;
        b=DRPP7cHUojqxZseKZufnYDVINfK819e13ORk1RQ+c+LyqIkdWUG/usUwDZEODvGGtH
         dfBXCIH+D2s9ITYUuon1Chb+tt43Dj6VUVyOZxFRw4xR4Gj2rN3zQZm1GBemPN5pi2CH
         udsGTIpsIf9MUG7mtecm5ZFS1OoqtpwYP1e+kvsRCn4XaGB20ypvh1kARyDU/rklofOB
         JoiKqCzgYTN6a70A9OJNgXc0Wt6ECFc1N3YFyjqUZLNhx9N844TPuILfCFNAiEooNof6
         EyBvELoH85z6sfSIPqE5vxQpFDswdQrdvW5v+MxDFU308ZLVuWWEIag6WjOf2VTApAeZ
         Z1ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=Y2AOU4bMAM1LYmkU6mF2laC0jM/eVfs2WsiWjIQUv10=;
        b=JXEYs3KLQ58tPuNHUpbmj1b9G6ZVSQILqLSmIQg7293URVBHfWfCONS2mOXo3pLgmx
         I12jAkxnkJqOQnas9s4IWwm6xMiBSFS9huQpr1kFcRuGze4Oj3gm+rY3IRGDAgRXt4Ho
         +8gJ1mF0p2OafXNfZNGWFWG1xWsDMEkEfdnrPKD8zcp81v1ZGfM/ZIgGzaAt9SIbJHLF
         0apmOkt0Rl0onM25FX3IxPkR2FtoMMEra4qHJS/P7A1noD9xriSa5a6USDVPg9TmwtIh
         tj7w6AcYeoHOXPNxIYBjb/t7SOQf8FQ7tOpVumF2NfYEowiBJ604KDXQJewaCJ3Hx3p2
         p6Cw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel-dk.20150623.gappssmtp.com header.s=20150623 header.b=eu1UCTTJ;
       spf=pass (google.com: domain of axboe@kernel.dk designates 209.85.220.41 as permitted sender) smtp.mailfrom=axboe@kernel.dk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel-dk.20150623.gappssmtp.com header.s=20150623 header.b=eu1UCTTJ;
       spf=pass (google.com: domain of axboe@kernel.dk designates 209.85.220.41 as permitted sender) smtp.mailfrom=axboe@kernel.dk
X-Google-Smtp-Source: AB8JxZrPhYDVQNTN7BQ631xuYGgBHaxIQr0OKCC8w2OACqFtxrrtozdudZZIx6SiSwSC/Z5ce6DafQ==
Subject: Re: KASAN: use-after-free Read in debugfs_remove (2)
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 syzbot <syzbot+db48ce201b524603190a@syzkaller.appspotmail.com>,
 syzkaller-bugs@googlegroups.com, weiping zhang
 <zhangweiping@didichuxing.com>, Jan Kara <jack@suse.cz>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
References: <000000000000fbda89056a818f20@google.com>
 <a5b6e0ff-ad8e-18f4-8c24-cdfafe4e3883@I-love.SAKURA.ne.jp>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7156e8d9-4c4a-1a98-2767-3508b9b3798f@kernel.dk>
Date: Thu, 3 May 2018 09:36:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <a5b6e0ff-ad8e-18f4-8c24-cdfafe4e3883@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598532704298959546?=
X-GMAIL-MSGID: =?utf-8?q?1599457796377597249?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/23/18 4:34 AM, Tetsuo Handa wrote:
> From be88e559ec13f49b1c3aec2457c14c70f6b1926a Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Mon, 23 Apr 2018 11:21:03 +0900
> Subject: [PATCH] bdi: Fix use after free bug in debugfs_remove()
> 
> syzbot is reporting use after free bug in debugfs_remove() [1].
> 
> This is because fault injection made memory allocation for
> debugfs_create_file() from bdi_debug_register() from bdi_register_va()
> fail and continued with setting WB_registered. But when debugfs_remove()
> is called from debugfs_remove(bdi->debug_dir) from bdi_debug_unregister()
>  from bdi_unregister() from release_bdi() because WB_registered was set
> by bdi_register_va(), IS_ERR_OR_NULL(bdi->debug_dir) == false despite
> debugfs_remove(bdi->debug_dir) was already called from bdi_register_va().
> 
> Fix this by making IS_ERR_OR_NULL(bdi->debug_dir) == true.
> 
> [1] https://syzkaller.appspot.com/bug?id=5ab4efd91a96dcea9b68104f159adf4af2a6dfc1

Applied for 4.17, thanks.

-- 
Jens Axboe
