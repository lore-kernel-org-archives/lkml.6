Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755449AbeDTOea (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:34:30 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:39866 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755421AbeDTOe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:34:27 -0400
X-Google-Smtp-Source: AIpwx4+ZsgFiQgXKKNjeP/034I2Xju/zOoP9gk921cachdI/XbVjdVna6nzJAB0W/0By7j3DIj33xLGf2K3RNzMfTBA=
MIME-Version: 1.0
X-Originating-IP: [176.63.54.97]
In-Reply-To: <F7C1033B-A155-4DA9-A686-AD39BA4CCC03@fb.com>
References: <20180418174014.1592871-1-songliubraving@fb.com>
 <CAELBmZB2XX=qEOLAdvGG4cPx4GEntcSnWQquJLUK1ongRj35cA@mail.gmail.com>
 <CAELBmZBvt=9p8muDsRucR_06kmia9vKT6CMfZbHjQL97N4aFag@mail.gmail.com> <F7C1033B-A155-4DA9-A686-AD39BA4CCC03@fb.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 20 Apr 2018 16:34:25 +0200
Message-ID: <CAJfpegsjgK3-q00qX2A9eopDydKXxSBMwprL8XZH5w=g2BvBZQ@mail.gmail.com>
Subject: Re: [PATCH v2] tracing: fix bad use of igrab in trace_uprobe.c
To: Song Liu <songliubraving@fb.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Howard McLauchlan <hmclauchlan@fb.com>, Josef Bacik <jbacik@fb.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 6:37 PM, Song Liu <songliubraving@fb.com> wrote:
>
>
>> On Apr 19, 2018, at 7:44 AM, Miklos Szeredi <miklos@szeredi.hu> wrote:
>>
>> On Thu, Apr 19, 2018 at 10:58 AM, Miklos Szeredi <miklos@szeredi.hu> wrote:
>>> On Wed, Apr 18, 2018 at 7:40 PM, Song Liu <songliubraving@fb.com> wrote:

>>>>        *arg++ = '\0';
>>>>        filename = argv[1];
>>>>        ret = kern_path(filename, LOOKUP_FOLLOW, &path);
>>>>        if (ret)
>>>> -               goto fail_address_parse;
>>>> -
>>>> -       inode = igrab(d_real_inode(path.dentry));
>>
>> Also, where has the d_real_inode() gone?
>>
>> Looks like we need tu->inode back, since the return value of
>> d_real_inode() may change over time.   I'd do the "tu->inode =
>> d_real_inode(tu->path.dentry)" just before first use (i.e. when
>> enabling the tracepoint).
>>

>
> Do we need mechanism to prevent the return value of d_real_inode()
> to change? Would the following sequence happen?
>
>     create trace_uprobe
>     enable trace_uprobe (uprobe_register)
>     d_real changes
>     disable trace_uprobe (uprobe_unregister get wrong inode?)

Yes.

>
> Another case might be:
>
>     create trace_uprobe
>     enable trace_uprobe (uprobe_register)
>     disable trace_uprobe (uprobe_unregister)
>     d_real changes
>     enable trace_uprobe (do we need new inode for uprobe_register)

Probably a good idea to use the new one, but doesn't really matter.
Do the one that's simpler.

This corner case is simply not interesting (modifying a binary while
it is being debugged with uprobe).  Let's just concentrate on making
this crash and leak free.

Thanks,
Miklos
