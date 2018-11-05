Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCF7C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E0620825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="N5dnRJDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E0620825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbeKEVWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:22:52 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:34213 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbeKEVWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:22:52 -0500
Received: by mail-io1-f67.google.com with SMTP id d80-v6so6300715iof.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 04:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=INE4F7eMlMFaNe4Bag5Zo/AnE6xVDxA9XZ9Ko7krn8k=;
        b=N5dnRJDAkmuI54dSJ8XiC33zDEBFPnxZ+rUuaW2KIvM7zr7Q1ddEu2yrlD9QWDIgal
         BWSLIV3zc+vTAn6zVuK4wg0us33x2bfdQxC2f2Ylzspj+PHlJZVlTmJhn0jfN/S+P4F2
         LtYm9hvzfrw/V2lvBLbJCxPUHPlWnTtI126sY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=INE4F7eMlMFaNe4Bag5Zo/AnE6xVDxA9XZ9Ko7krn8k=;
        b=L1i2v4p44kE1tO5REC60erjX4c6eds0oNJFghVxxO1plMsZTHcdTUkOR36gDbhTE00
         d5giez7CV8COV69cKtHxzZNdmtOG5dJ3BG3zPVdznUb6PHzzdE6d1e7JaHQ6qf7s6MQC
         +phALPvZkrhuwvgoIDkXQLXjgbTHU+PXkuU0RuCt5fv/PPw9OL+XFJWXHV3Gcetm7af+
         zBTi7KpJLZArMU1IMi8LqpJlisGMRhNoe3aSSWIJeU0Ex4r1Z3xsZ3YeuXqaFR/Nt4W8
         cSTbHZvu6WXf97gIyhqITmuF6MYpXulwoas7cc8iWY/bzAVl0MssXB6UlUOpTYoQVIW2
         lo3Q==
X-Gm-Message-State: AGRZ1gJfvFIwjqhlJAFm/Xn/b2xpwIIMgbZHGLa/A0jPFrcYyPkX/X0q
        rFIKvRJlUHlD97BhrzHRaUuLm2ej4fBjM8ZXOqvYAw==
X-Google-Smtp-Source: AJdET5eAeWbLOW8bXBAlCIsg9WrA2frZCSuF+TAcZ7ovoJGkkDD21JRqFoHl1uAOsOGd4AkH3Aq3xFfvXMiGHUQAqQQ=
X-Received: by 2002:a6b:15c5:: with SMTP id 188-v6mr17363996iov.246.1541419406514;
 Mon, 05 Nov 2018 04:03:26 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:ac42:0:0:0:0:0 with HTTP; Mon, 5 Nov 2018 04:03:24 -0800 (PST)
X-Originating-IP: [94.21.144.184]
In-Reply-To: <CAJfpegsNzxc3c=ojjYHgdiKiHXXutOkKCUAO131cifwKyLhqOg@mail.gmail.com>
References: <000000000000c25cca0579982a05@google.com> <CACT4Y+YLFp4OXRyroL8coE5Mw6yMdbajKPeu8kzkHunVGypx0Q@mail.gmail.com>
 <CAJfpegsNzxc3c=ojjYHgdiKiHXXutOkKCUAO131cifwKyLhqOg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 5 Nov 2018 13:03:24 +0100
Message-ID: <CAJfpegtGz2Z4c4mGE+LMC9ZoEQd9wJtL=segqrFo72-g4MdAig@mail.gmail.com>
Subject: Re: INFO: task hung in fuse_sb_destroy
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+6339eda9cb4ebbc4c37b@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="0000000000002d2cee0579e9ac92"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000002d2cee0579e9ac92
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 5, 2018 at 11:40 AM, Miklos Szeredi <miklos@szeredi.hu> wrote:
> On Thu, Nov 1, 2018 at 12:05 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
>> On Thu, Nov 1, 2018 at 11:49 AM, syzbot
>> <syzbot+6339eda9cb4ebbc4c37b@syzkaller.appspotmail.com> wrote:
>>> Hello,
>>>
>>> syzbot found the following crash on:
>>>
>>> HEAD commit:    59fc453b21f7 Merge branch 'akpm' (patches from Andrew)
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=15fb2447400000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=ea045471e4c756e8
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=6339eda9cb4ebbc4c37b
>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178a105d400000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16651133400000
>>
>>
>> I can easily reproduce this.
>
> I can't reproduce on my meager dual core notebook.
>
>>
>> The repro gives me a task hanged at:
>>
>> # cat /proc/7563/task/*/stack
>> [<0>] fuse_wait_aborted+0x20b/0x320
>> [<0>] fuse_sb_destroy+0xe2/0x1d0
>> [<0>] fuse_kill_sb_anon+0x15/0x20
>> [<0>] deactivate_locked_super+0x97/0x100
>> [<0>] deactivate_super+0x2bb/0x320
>> [<0>] cleanup_mnt+0xbf/0x160
>> [<0>] __cleanup_mnt+0x16/0x20
>> [<0>] task_work_run+0x1e8/0x2a0
>> [<0>] exit_to_usermode_loop+0x318/0x380
>> [<0>] do_syscall_64+0x6be/0x820
>> [<0>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> [<0>] 0xffffffffffffffff
>>
>> I double checked that writing to /sys/fs/fuse/connections/44/abort did
>> not help (the only entry in fuse/connections). Wrote multiple times,
>> and tried to kill the task, nothing helps.
>
> What's the output of
>
> cat /sys/fs/fuse/connections/NN/waiting
>
> ?

I think I found the culprit.  Does the attached patch fix it?

Thanks,
Miklos

--0000000000002d2cee0579e9ac92
Content-Type: text/x-patch; charset="US-ASCII"; name="fuse-fix-leaked-notify-reply.patch"
Content-Disposition: attachment; 
	filename="fuse-fix-leaked-notify-reply.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jo49ao720

LS0tCiBmcy9mdXNlL2Rldi5jIHwgICAgNCArKystCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pCgotLS0gYS9mcy9mdXNlL2Rldi5jCisrKyBiL2ZzL2Z1c2Uv
ZGV2LmMKQEAgLTE3MTUsOCArMTcxNSwxMCBAQCBzdGF0aWMgaW50IGZ1c2VfcmV0cmlldmUoc3Ry
dWN0IGZ1c2VfY29uCiAJcmVxLT5pbi5hcmdzWzFdLnNpemUgPSB0b3RhbF9sZW47CiAKIAllcnIg
PSBmdXNlX3JlcXVlc3Rfc2VuZF9ub3RpZnlfcmVwbHkoZmMsIHJlcSwgb3V0YXJnLT5ub3RpZnlf
dW5pcXVlKTsKLQlpZiAoZXJyKQorCWlmIChlcnIpIHsKIAkJZnVzZV9yZXRyaWV2ZV9lbmQoZmMs
IHJlcSk7CisJCWZ1c2VfcHV0X3JlcXVlc3QoZmMsIHJlcSk7CisJfQogCiAJcmV0dXJuIGVycjsK
IH0K
--0000000000002d2cee0579e9ac92--
