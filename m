Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C5FECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 23:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7A020881
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 23:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTzZiJ6e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA7A020881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbeIPE0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 00:26:05 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:38334 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725199AbeIPE0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 00:26:04 -0400
Received: by mail-yb1-f194.google.com with SMTP id e190-v6so673905ybb.5;
        Sat, 15 Sep 2018 16:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CvMkcrWZRH/l/aK5xopx8IXm96uD3to4XPZgq6vZ8P4=;
        b=cTzZiJ6e64shSqORm5vwBnH1YpvMO8+IX/ues73k6p6BmaPWEgMKlNBCsMm1alRT7W
         EKVU0et+j9RJZbw9/qEEk5HdTGoQuBZgQ7EWwYV/xZCakOXzZRGz0E2POYnskj0zfB9u
         SSFt9a6gD66cJ6jy3G4pxqPEeworALaqmAnEyj8CUoa9rTgEe2vKjut1SRaFpu8948UL
         9IuYFoHnwwp++B4kjDIMz0BXS42dlOJ3Fc+FGrFjehbObkIppkQcUyrspZBot7C1Vq7/
         1Z86fGs6+0Rfmn7FYtWNl1kdcD3YvijOMIDfZBqpXqmwqETzpYLo01XsAKjKHvDyP17A
         qJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CvMkcrWZRH/l/aK5xopx8IXm96uD3to4XPZgq6vZ8P4=;
        b=SBF91eatBbFlrv8U27XDSLxWVQ28TrikQsnlfopCZRZ9DquJaqU7+6wxGQ3zrlStRF
         C6RiXWSa5rLnvI43FrMA8QXF15RJJrofqDHXnHuSYZbK4AqWyO8FmWs6m3yKhngjBN6H
         vqnz474co2bQ2cT+3niLTAlO62Si0sE5TjUKlET1Rt9O68d5/UUPXLunZo1U0aTSvI2O
         W7UI2mdo6QKcKguqUye+79pLgHLinFkiqGMgmEw/kYAgNWK92KW+Cdae2JADyYbqTStJ
         rldHyQOv6RghEG9xEIK4GyecGLe1OQNtJGHlS6QXlEsAGDp9+aM+dE6VzZPiBOXZ5ajj
         UQLA==
X-Gm-Message-State: APzg51B4JdV3my3H3BpswDnoEC164UuprNpyIYy859dsORCZejZ61qGU
        nXYUtL80w1fj9GbN92L52iwzsz06VTGdIGTg1Z0=
X-Google-Smtp-Source: ANB0VdaRSQ62X1xJlBF6YwVBr1jN+6+pdBoQN3zgdImQMoDTN7R71O3ZisvF5mU8r9Jnj+D74Fm9ofZX/BrVJimN7JM=
X-Received: by 2002:a5b:142:: with SMTP id c2-v6mr7794262ybp.32.1537052722555;
 Sat, 15 Sep 2018 16:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006364200575dfc280@google.com> <2f4ce251-cf84-8bd2-72fc-a3ff687d5188@I-love.SAKURA.ne.jp>
In-Reply-To: <2f4ce251-cf84-8bd2-72fc-a3ff687d5188@I-love.SAKURA.ne.jp>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 16 Sep 2018 02:05:11 +0300
Message-ID: <CAOQ4uxhmFsvy6y6NgcFPs4NF1Lg7J0h2VoWgiL8WfXdDz+Z0FQ@mail.gmail.com>
Subject: Re: INFO: task hung in fsnotify_connector_destroy_workfn (2)
To:     penguin-kernel@i-love.sakura.ne.jp
Cc:     syzbot+6fb572170402d311dd39@syzkaller.appspotmail.com,
        Jan Kara <jack@suse.cz>, syzkaller-bugs@googlegroups.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 15, 2018 at 8:26 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2018/09/15 11:33, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    11da3a7f84f1 Linux 4.19-rc3
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=141ffbca400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=9917ff4b798e1a1e
> > dashboard link: https://syzkaller.appspot.com/bug?extid=6fb572170402d311dd39
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136a60ae400000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+6fb572170402d311dd39@syzkaller.appspotmail.com
> >
>
> Since it kept printk()ing for at least 93 seconds, it might have kept for 150 seconds.
>
> [  174.614333] hid-generic 0000:0000:0000.0003: unknown main item tag 0x0
> [  268.196102] INFO: task kworker/u4:1:23 blocked for more than 140 seconds.
>
> Since the reproducer is simple, this might be lockup due to continuous printk().
> If syzbot can reliably reproduce this problem using the reproducer, try
> ratelimiting printk().

Right.. and I was able to reproduce after setting CONFIG_HID_GENERIC=y
but unless I am missing something, the core problem doesn't seem related to
fsnotify and $SUBJECT, so CCing HID maintainer.

Thanks,
Amir.
