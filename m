Return-Path: <opensource.ganesh@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522651574; cv=none;
        d=google.com; s=arc-20160816;
        b=bJZ1gqLyZWrbVPBkg4+ciehspcD6/Q6A2Y3/PyNSXP/Xb5hbfv4z3J1NkZrvi8ikeK
         3IUMYWgIoZsGDO9/15ZuehKgjAKj3D3sWUYg7mCODX4CyGGLMj/fqNgp7/FblfoY1edg
         uuCJ1YyT297sUS7i0GeLropbKhZ/xWwm9hMSLcTzumdERsDoRL5MXqqH9GVzp7azhsXD
         ycCMwo2VDXtBddYqd6n4/m89m68E4AoDsPaOs7ZMGxT+9vG5MxS7vjz7eOPdxdeHGsUx
         htJwORB4bZ+bZZiwNTHUVJWnV/1EiN3zKWM0t7h+pvEm4VDF8XyXbAmvF9C+LF+v5oXY
         J0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=1hfZy5K2fZ99yu5evPoFCgTHFEwpe/0snBed+Vb4XkE=;
        b=l7R09qTAMJNg0ftbnwCL0eiLF5/88O7brrzSoysGN8dK8misKx0Y4dDA6kgEDuXcqX
         KAglIh9JBE0U99rzXlPG5qJAwiAgGqJK3yLumSNdAMXdlyQSt+3j3xawNVEBhnnEEHeC
         yCQ/qboar/g4JqD4ZVUgUUl7ve1uSjrFci9b5qCzDn9K/EwCsX1pHXWct+qM26w8HOuY
         J4F4OCmWCKlPmFgfxMqT1P9cps8C4J9TEM8KjK/239jsu2WvfBtusX1yD5GQI8ZZeff+
         zYsfjNIdSzGqBumBGzN7SlUAXLKrpqAtbWfDUfNQE7/CIF4ui8gU36kY7gnWIFlfx3il
         +V6w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Xk4tYAE0;
       spf=pass (google.com: domain of opensource.ganesh@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=opensource.ganesh@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Xk4tYAE0;
       spf=pass (google.com: domain of opensource.ganesh@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=opensource.ganesh@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49KW1p1A8Vydhq+jQ4sG9/u/dyG+5tv8L1QNxB2re/z9wxD7If5OFJMBr+bVMVtt914AO/IrO+Bdph3diYOREM=
MIME-Version: 1.0
In-Reply-To: <20180402063448.GA250086@rodete-desktop-imager.corp.google.com>
References: <20180329065424.203172-1-minchan@kernel.org> <CADAEsF8Y2CJsuom=9au0-uvZAALvrLTdTnrkxrGjW9C9F6hTVg@mail.gmail.com>
 <20180330012921.GB255979@rodete-desktop-imager.corp.google.com>
 <20180330100407.GB19140@kroah.com> <20180402063448.GA250086@rodete-desktop-imager.corp.google.com>
From: Ganesh Mahendran <opensource.ganesh@gmail.com>
Date: Mon, 2 Apr 2018 14:46:14 +0800
Message-ID: <CADAEsF8_vptm7p2y2ekj8m6t=bz4pwC1+np7r2-YnAKbnEsA4w@mail.gmail.com>
Subject: Re: [PATCH v5] ANDROID: binder: change down_write to down_read
To: Minchan Kim <minchan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>,
	Joe Perches <joe@perches.com>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
	Todd Kjos <tkjos@google.com>, Martijn Coenen <maco@android.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596254032587353794?=
X-GMAIL-MSGID: =?utf-8?q?1596615897720555737?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-04-02 14:34 GMT+08:00 Minchan Kim <minchan@kernel.org>:
> On Fri, Mar 30, 2018 at 12:04:07PM +0200, Greg Kroah-Hartman wrote:
>> On Fri, Mar 30, 2018 at 10:29:21AM +0900, Minchan Kim wrote:
>> > Hi Ganesh,
>> >
>> > On Fri, Mar 30, 2018 at 09:21:55AM +0800, Ganesh Mahendran wrote:
>> > > 2018-03-29 14:54 GMT+08:00 Minchan Kim <minchan@kernel.org>:
>> > > > binder_update_page_range needs down_write of mmap_sem because
>> > > > vm_insert_page need to change vma->vm_flags to VM_MIXEDMAP unless
>> > > > it is set. However, when I profile binder working, it seems
>> > > > every binder buffers should be mapped in advance by binder_mmap.
>> > > > It means we could set VM_MIXEDMAP in binder_mmap time which is
>> > > > already hold a mmap_sem as down_write so binder_update_page_range
>> > > > doesn't need to hold a mmap_sem as down_write.
>> > > >
>> > > > Android suffers from mmap_sem contention so let's reduce mmap_sem
>> > > > down_write.
>> > >
>> > > Hi, Minchan:
>> > >
>> > > It seems there is performance regression of this patch.
>> >
>> > You mean "This patch aims for solving performance regression" not "This patch
>> > makes performance regression"?
>> >
>> > >
>> > > Do you have some test result of android app launch time or binderThroughput?
>> >
>> > Unfortunately, I don't have any number. The goal is to reduce the number of
>> > call mmap_sem as write-side lock because it makes priority inversion of threads
>> > easily and that's one of clear part I spot that we don't need write-side lock.
>>
>> Please always run the binderThroughput tests when making binder changes
>> (there is a binder test suite in the CTS Android tests), as that ensures
>> that you are not causing performance regressions as well as just normal
>> bug regressions :)
>
> Thanks for the information. I didn't notice that such kinds of tests for
> binder. I will keep it in mind.
>
> Today, I have setup the testing for my phone and found testing was very
> fluctuating even without my patch. It might be not good with my test
> skill. I emulated user's behavior with various touch event. With it, I open
> various apps and play with them several times. Before starting the test,
> I did "adb shell stop && adb shell start && echo 3 > /proc/sys/vm/drop_caches"
>
> Such 15% noise was very easy to make it.
>
> Ganesh, How did you measure? What's the stddev?

Hi, Minchan:

Sorry for the late response, a little busy these days. :)

We have our own test tools to measure app launch time, or you can use
android systrace to get the app launch time. We tested your V1 patch:
https://patchwork.kernel.org/patch/10312057/
and found app lunch time regression.

I will use binderThroghput tool to test the patch today or tomorrow.

Thanks.

> Please let me know how you measure without noise so I'd like to reproduce
> the result in my phone.
>
> I will do binderThroghput test, too.
>
>
