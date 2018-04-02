Return-Path: <minchan.kim@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522653101; cv=none;
        d=google.com; s=arc-20160816;
        b=qzwrYKQ19fZY4P34CGDeONeJ7LBX1PxrzSssynxuzxcCm35UDUJZxxGPv/n/tB3gT5
         TQTDjEZvJCGBiOcZfYwVM1auVDIkYqwy636xKh0IPF1sK/CV0YALPyBYP0TiidGwVh1W
         oX9ctqxf3CmvQbPSpK9Id3e+0mN3A4kxh/cvmLq6Ge9Vgb51qxoKY0cw9PkhjFcyLSF7
         ZAcXiNBBAixj+fGb3nQ5wF//ObleeMz0UYTUMykO6Gh1xZkHjCOjaQRfPLEm1tBYkcQL
         DUTDU3JGqljJjzCW3GrYX7lwSEDHRHC1KxvXDbuPFH/395odLYsqTWImd3sMbHXHFhvp
         PyGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=USK8weOBojMRp/5oYi/VxDiJXwY+fCbzOW6XaF/xbGQ=;
        b=aJshE0LXaLMoYnB/Q80L5lRbuAyT/gWtfESF93fQpQU5mKGUh13XqBjfXWbSOJtaD1
         TUC/GLJ8rzST8hWSEBmI1N6oHILiA9s7VSDRwFcc1Xuk3GqWv5W6q/XouPVhKCzYJzax
         a23IPYYaiGE6QsP29Vz72ot+zxRoJ/V4sSThO0I1lzQfW6oJBJFyCwTXMDTyx5qt/N8z
         L0Z7syfak7CSlHCqgxiLQNPUc9ncHlxokZpE8ReLY+gUgFPcKYxSkDnNPIWYjOeTOYeM
         q5SM2G4/eS7BRCywgTZudePEEfHii2WkO1QM8xTIJYD8G/XTTsDFL1hxaVAz6fNaJt6W
         btpA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=p/cSt4g9;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=p/cSt4g9;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
X-Google-Smtp-Source: AIpwx49bcGyhRFfHvijwy90RtNG3TJhA0mIJBWXzZr8/boUuo3Ae/0wmLIGECufO11d232hA0cc0gA==
Sender: Minchan Kim <minchan.kim@gmail.com>
Date: Mon, 2 Apr 2018 16:11:33 +0900
From: Minchan Kim <minchan@kernel.org>
To: Ganesh Mahendran <opensource.ganesh@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Joe Perches <joe@perches.com>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@google.com>, Martijn Coenen <maco@android.com>
Subject: Re: [PATCH v5] ANDROID: binder: change down_write to down_read
Message-ID: <20180402071133.GA62369@rodete-desktop-imager.corp.google.com>
References: <20180329065424.203172-1-minchan@kernel.org>
 <CADAEsF8Y2CJsuom=9au0-uvZAALvrLTdTnrkxrGjW9C9F6hTVg@mail.gmail.com>
 <20180330012921.GB255979@rodete-desktop-imager.corp.google.com>
 <20180330100407.GB19140@kroah.com>
 <20180402063448.GA250086@rodete-desktop-imager.corp.google.com>
 <CADAEsF8_vptm7p2y2ekj8m6t=bz4pwC1+np7r2-YnAKbnEsA4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADAEsF8_vptm7p2y2ekj8m6t=bz4pwC1+np7r2-YnAKbnEsA4w@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596254032587353794?=
X-GMAIL-MSGID: =?utf-8?q?1596617498845791956?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 02, 2018 at 02:46:14PM +0800, Ganesh Mahendran wrote:
> 2018-04-02 14:34 GMT+08:00 Minchan Kim <minchan@kernel.org>:
> > On Fri, Mar 30, 2018 at 12:04:07PM +0200, Greg Kroah-Hartman wrote:
> >> On Fri, Mar 30, 2018 at 10:29:21AM +0900, Minchan Kim wrote:
> >> > Hi Ganesh,
> >> >
> >> > On Fri, Mar 30, 2018 at 09:21:55AM +0800, Ganesh Mahendran wrote:
> >> > > 2018-03-29 14:54 GMT+08:00 Minchan Kim <minchan@kernel.org>:
> >> > > > binder_update_page_range needs down_write of mmap_sem because
> >> > > > vm_insert_page need to change vma->vm_flags to VM_MIXEDMAP unless
> >> > > > it is set. However, when I profile binder working, it seems
> >> > > > every binder buffers should be mapped in advance by binder_mmap.
> >> > > > It means we could set VM_MIXEDMAP in binder_mmap time which is
> >> > > > already hold a mmap_sem as down_write so binder_update_page_range
> >> > > > doesn't need to hold a mmap_sem as down_write.
> >> > > >
> >> > > > Android suffers from mmap_sem contention so let's reduce mmap_sem
> >> > > > down_write.
> >> > >
> >> > > Hi, Minchan:
> >> > >
> >> > > It seems there is performance regression of this patch.
> >> >
> >> > You mean "This patch aims for solving performance regression" not "This patch
> >> > makes performance regression"?
> >> >
> >> > >
> >> > > Do you have some test result of android app launch time or binderThroughput?
> >> >
> >> > Unfortunately, I don't have any number. The goal is to reduce the number of
> >> > call mmap_sem as write-side lock because it makes priority inversion of threads
> >> > easily and that's one of clear part I spot that we don't need write-side lock.
> >>
> >> Please always run the binderThroughput tests when making binder changes
> >> (there is a binder test suite in the CTS Android tests), as that ensures
> >> that you are not causing performance regressions as well as just normal
> >> bug regressions :)
> >
> > Thanks for the information. I didn't notice that such kinds of tests for
> > binder. I will keep it in mind.
> >
> > Today, I have setup the testing for my phone and found testing was very
> > fluctuating even without my patch. It might be not good with my test
> > skill. I emulated user's behavior with various touch event. With it, I open
> > various apps and play with them several times. Before starting the test,
> > I did "adb shell stop && adb shell start && echo 3 > /proc/sys/vm/drop_caches"
> >
> > Such 15% noise was very easy to make it.
> >
> > Ganesh, How did you measure? What's the stddev?
> 
> Hi, Minchan:
> 
> Sorry for the late response, a little busy these days. :)
> 
> We have our own test tools to measure app launch time, or you can use
> android systrace to get the app launch time. We tested your V1 patch:
> https://patchwork.kernel.org/patch/10312057/
> and found app lunch time regression.

V1 had a bug with VM_MAYWRITE. Could you confirm it with v5?

Please tell me more detail. What apps are slower compared to old?
Every apps are slowed with avg 15%? Then, what's the stddev?

The reason I'm asking is as I mentioned, it would be caused by rw_semaphore
implementation and priority of threads which calls binder operation so I
guess it would be not deterministic.

When I had an simple experiment, it was very fluctuating as I expected.
(the testing enviroment might be not good in my side).
If it's real problem on real practice, better fix is not using write_lock
of mmap_sem(it's abusing the write-side lock)  but should adjust priority,
I think. What do you think?

Anyway, before the further discussion, we should confirm the root cause.

> 
> I will use binderThroghput tool to test the patch today or tomorrow.
> 

Thanks. I will do.
