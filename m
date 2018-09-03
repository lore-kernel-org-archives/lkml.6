Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5142C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF3A20869
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF3A20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbeICRmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:42:52 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:43623 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbeICRmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:42:52 -0400
Received: by mail-it0-f72.google.com with SMTP id z72-v6so686899itc.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 06:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=MNOpxBFUbC0nphZF99A5sHwOWeR1VO8L0Yw9ft2o04c=;
        b=UXWTnQb1tVJIG3aWSkR1f2IE2KGesgy7In2YEsWIqEisXaANQqQLeQ9D80/CnB3RzJ
         Ua4akEQza9WfyXf8urRxQM1QBJpdE7onEEPsSWcoRfpGxApjanEKtkECb/KCk6XbLNFc
         /G/V2a5SnsGxZYtwW1YaHdJnmwsa9Jca3J6wMWUxYKBWShXZYntPZJLNeqmXPhFuY/7W
         D4utG4dWVWNfshuOwYXhP+uOgE5oxFjY/cwzyIFjI/3qngSv4c6fO5U6jPGAzZ7nA6BC
         8c7R4FwEQRMV9HrvUcy1BPOJ0WdppoMju+cRbgcf18nln840zxXt/f9I/MfQLwi7WVSe
         Oabw==
X-Gm-Message-State: APzg51DymleDNNsLoMPgnZwWYeJlcwenglz7umNI6n9/MHMb5kfB40OL
        j7EWmorrUeqWQrt9RuD1w0O2eAundk4ZaMKgQX4WIuuRr/GV
X-Google-Smtp-Source: ANB0VdYnOGnrLazBw8jzJp9iMw5lFnE8RaaAM+2NxkLWwe7DrozxBhVpvlrbo1Va3k28UK6LOepv9xMIWQyERZ8K/u4wMwh3x8Nb
MIME-Version: 1.0
X-Received: by 2002:a24:2193:: with SMTP id e141-v6mr4002025ita.2.1535980962204;
 Mon, 03 Sep 2018 06:22:42 -0700 (PDT)
Date:   Mon, 03 Sep 2018 06:22:42 -0700
In-Reply-To: <s5ha7oyhg0v.wl-tiwai@suse.de>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a25ae50574f76ff0@google.com>
Subject: Re: Re: KMSAN: uninit-value in snd_midi_event_encode_byte
From:   syzbot <syzbot+194dffdb8b22fc5d207a@syzkaller.appspotmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel-bounces@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 03 Sep 2018 03:53:03 +0200,
> syzbot wrote:

>> syzbot has found a reproducer for the following crash on:

>> HEAD commit:    28f0ca98eadf kmsan: don't instrument do_syscall_64() and  
>> _..
>> git tree:       https://github.com/google/kmsan.git/master
>> console output: https://syzkaller.appspot.com/x/log.txt?x=10556c92400000
>> kernel config:   
>> https://syzkaller.appspot.com/x/.config?x=3431f03869413153
>> dashboard link:  
>> https://syzkaller.appspot.com/bug?extid=194dffdb8b22fc5d207a
>> compiler:       clang version 8.0.0 (trunk 339414)
>> syz repro:       
>> https://syzkaller.appspot.com/x/repro.syz?x=123a520a400000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16068dc1400000

>> IMPORTANT: if you fix the bug, please add the following tag to the  
>> commit:
>> Reported-by: syzbot+194dffdb8b22fc5d207a@syzkaller.appspotmail.com

>> ==================================================================
>> BUG: KMSAN: uninit-value in snd_midi_event_encode_byte+0x569/0xff0
>> sound/core/seq/seq_midi_event.c:195
>> CPU: 1 PID: 1659 Comm: kworker/1:1H Not tainted 4.19.0-rc1+ #40
>> Hardware name: Google Google Compute Engine/Google Compute Engine,
>> BIOS  Google 01/01/2011
>> Workqueue: events_highpri snd_vmidi_output_work
>> Call Trace:
>>   __dump_stack lib/dump_stack.c:77 [inline]
>>   dump_stack+0x14b/0x190 lib/dump_stack.c:113
>>   kmsan_report+0x183/0x2b0 mm/kmsan/kmsan.c:956
>>   __msan_warning+0x70/0xc0 mm/kmsan/kmsan_instr.c:645
>>   snd_midi_event_encode_byte+0x569/0xff0  
>> sound/core/seq/seq_midi_event.c:195
>>   snd_vmidi_output_work+0x34e/0x5b0 sound/core/seq/seq_virmidi.c:161
>>   process_one_work+0x1605/0x1f40 kernel/workqueue.c:2153
>>   worker_thread+0x11a2/0x2590 kernel/workqueue.c:2296
>>   kthread+0x465/0x4a0 kernel/kthread.c:247
>>   ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:416

>> Uninit was stored to memory at:
>>   kmsan_save_stack_with_flags mm/kmsan/kmsan.c:256 [inline]
>>   kmsan_save_stack mm/kmsan/kmsan.c:271 [inline]
>>   kmsan_internal_chain_origin+0x128/0x210 mm/kmsan/kmsan.c:573
>>   __msan_chain_origin+0x69/0xc0 mm/kmsan/kmsan_instr.c:482
>>   __snd_rawmidi_transmit_peek sound/core/rawmidi.c:1103 [inline]
>>   snd_rawmidi_transmit+0xa75/0xbf0 sound/core/rawmidi.c:1228
>>   snd_vmidi_output_work+0x2ac/0x5b0 sound/core/seq/seq_virmidi.c:159
>>   process_one_work+0x1605/0x1f40 kernel/workqueue.c:2153
>>   worker_thread+0x11a2/0x2590 kernel/workqueue.c:2296
>>   kthread+0x465/0x4a0 kernel/kthread.c:247
>>   ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:416

>> Uninit was created at:
>>   kmsan_save_stack_with_flags mm/kmsan/kmsan.c:256 [inline]
>>   kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:181
>>   kmsan_kmalloc+0x98/0x100 mm/kmsan/kmsan_hooks.c:91
>>   __kmalloc_node+0x7bf/0x11c0 mm/slub.c:3828
>>   kmalloc_node include/linux/slab.h:555 [inline]
>>   kvmalloc_node+0x19d/0x3e0 mm/util.c:423
>>   kvmalloc include/linux/mm.h:577 [inline]
>>   snd_rawmidi_runtime_create sound/core/rawmidi.c:132 [inline]
>>   open_substream+0x3c8/0xaa0 sound/core/rawmidi.c:276
>>   rawmidi_open_priv+0x347/0x1000 sound/core/rawmidi.c:327
>>   snd_rawmidi_open+0x7d4/0x1120 sound/core/rawmidi.c:424
>>   soundcore_open+0x9be/0xa60 sound/sound_core.c:597
>>   chrdev_open+0xc26/0xdb0 fs/char_dev.c:417
>>   do_dentry_open+0xce6/0x1740 fs/open.c:771
>>   vfs_open+0xaf/0xe0 fs/open.c:880
>>   do_last fs/namei.c:3418 [inline]
>>   path_openat+0x1799/0x6870 fs/namei.c:3534
>>   do_filp_open+0x259/0x610 fs/namei.c:3564
>>   do_sys_open+0x630/0x940 fs/open.c:1063
>>   __do_sys_open fs/open.c:1081 [inline]
>>   __se_sys_open+0xad/0xc0 fs/open.c:1076
>>   __x64_sys_open+0x4a/0x70 fs/open.c:1076
>>   do_syscall_64+0xb8/0x100 arch/x86/entry/common.c:291
>>   entry_SYSCALL_64_after_hwframe+0x63/0xe7
>> ==================================================================

> This looks like some small race at virmidi reading and the buffer
> handling, which should be almost harmless by itself.
> Nevertheless, the fix should be easy, just replacing kvmalloc() with
> kvzalloc(), as below.

> Let's check whether this works.

> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git  
> topic/rawmidi-fixes

KMSAN bugs can only be tested on https://github.com/google/kmsan.git tree
because KMSAN tool is not upstreamed yet.
See  
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#kmsan-bugs  
for details.



> Takashi

> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: rawmidi: Initialize allocated buffers

> syzbot reported the uninitialized value exposure in certain situations
> using virmidi loop.  It's likely a very small race at writing and
> reading, and the influence is almost negligible.  But it's safer to
> paper over this just by replacing the existing kvmalloc() with
> kvzalloc().

> Reported-by: syzbot+194dffdb8b22fc5d207a@syzkaller.appspotmail.com
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   sound/core/rawmidi.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

> diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
> index 69517e18ef07..08d5662039e3 100644
> --- a/sound/core/rawmidi.c
> +++ b/sound/core/rawmidi.c
> @@ -129,7 +129,7 @@ static int snd_rawmidi_runtime_create(struct  
> snd_rawmidi_substream *substream)
>   		runtime->avail = 0;
>   	else
>   		runtime->avail = runtime->buffer_size;
> -	runtime->buffer = kvmalloc(runtime->buffer_size, GFP_KERNEL);
> +	runtime->buffer = kvzalloc(runtime->buffer_size, GFP_KERNEL);
>   	if (!runtime->buffer) {
>   		kfree(runtime);
>   		return -ENOMEM;
> @@ -655,7 +655,7 @@ static int resize_runtime_buffer(struct  
> snd_rawmidi_runtime *runtime,
>   	if (params->avail_min < 1 || params->avail_min > params->buffer_size)
>   		return -EINVAL;
>   	if (params->buffer_size != runtime->buffer_size) {
> -		newbuf = kvmalloc(params->buffer_size, GFP_KERNEL);
> +		newbuf = kvzalloc(params->buffer_size, GFP_KERNEL);
>   		if (!newbuf)
>   			return -ENOMEM;
>   		spin_lock_irq(&runtime->lock);
> --
> 2.18.0

