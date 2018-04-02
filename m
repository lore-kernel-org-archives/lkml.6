Return-Path: <minchan.kim@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522650895; cv=none;
        d=google.com; s=arc-20160816;
        b=UJRb1IZzEIqoTh8H67rrVdH8nQCl9XzuoPq6oDgp+cZXMDrLzjY48Hc5ARbFGRsyxD
         KCnoWP1GcV7+EQvP/Sz+yzVzCmISwcLIppS1Qrb5it2kzttCbpIpt5BZGBsNor6tQ8KK
         Cbd0cIMlg38gVGPEod+qvUNR+3kH/iNZTDescJ0eHwpm51hkjCrognSAUptyjyONwJcD
         HfxNepsAvV+NP8+JKpW55OBJW/4ovEvaUy4Btyjdzt09VYDHcfy6FJTYnO2Tid875fMU
         QmRaUmc/uFrE9mmCFRlNEgwRwEAe4tRiKpQPJ4zDqY9RTgyRnqRYjuO5i04PGtmfgwwa
         EQKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=QbmgbsINsLrJOChnfJu5xAny15eRmwFjCeAwW048jDw=;
        b=ckMJq1F2sIeAnVeBgJ15R9ZhhgPSUiIJNKMN+MlKdom376+JsfX5g4yp2apEQuxOWR
         zAODJnI6Yp2VohxD35XSUE1ct4vCnpLQAF3hAQHeLEMtARt0pf92vR73gzYEDxK4yy5t
         v5sHfz1TDMM07AFRF3btOEgURp8Bf6oivvVcPdX0CwP3M4Wo/EXl6hWLYr2nW/UCcIin
         T8DDFi0OLZc9Hjf2SW8OXbD6qKrvEMqINJhea0JaO5yNEQPl+HcN9V27YMuBm0+c54sd
         igiUeM3M4dHpGeGbb+tyEPPnMxchM/2MCI/HPvv4rAprNRjFMEXxtJDsgSEqrAV7Epxz
         Flcw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IzHXhpBg;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IzHXhpBg;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
X-Google-Smtp-Source: AIpwx4/JZuxjf7tb4zIEgRNm9xp64tmaqc9nRS1YwHeWnlxQ/Gsuy161WYLclrnr1no7dTKWSgrSUg==
Sender: Minchan Kim <minchan.kim@gmail.com>
Date: Mon, 2 Apr 2018 15:34:48 +0900
From: Minchan Kim <minchan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ganesh Mahendran <opensource.ganesh@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>, Joe Perches <joe@perches.com>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@google.com>, Martijn Coenen <maco@android.com>
Subject: Re: [PATCH v5] ANDROID: binder: change down_write to down_read
Message-ID: <20180402063448.GA250086@rodete-desktop-imager.corp.google.com>
References: <20180329065424.203172-1-minchan@kernel.org>
 <CADAEsF8Y2CJsuom=9au0-uvZAALvrLTdTnrkxrGjW9C9F6hTVg@mail.gmail.com>
 <20180330012921.GB255979@rodete-desktop-imager.corp.google.com>
 <20180330100407.GB19140@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330100407.GB19140@kroah.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596254032587353794?=
X-GMAIL-MSGID: =?utf-8?q?1596615185166381375?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 30, 2018 at 12:04:07PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Mar 30, 2018 at 10:29:21AM +0900, Minchan Kim wrote:
> > Hi Ganesh,
> > 
> > On Fri, Mar 30, 2018 at 09:21:55AM +0800, Ganesh Mahendran wrote:
> > > 2018-03-29 14:54 GMT+08:00 Minchan Kim <minchan@kernel.org>:
> > > > binder_update_page_range needs down_write of mmap_sem because
> > > > vm_insert_page need to change vma->vm_flags to VM_MIXEDMAP unless
> > > > it is set. However, when I profile binder working, it seems
> > > > every binder buffers should be mapped in advance by binder_mmap.
> > > > It means we could set VM_MIXEDMAP in binder_mmap time which is
> > > > already hold a mmap_sem as down_write so binder_update_page_range
> > > > doesn't need to hold a mmap_sem as down_write.
> > > >
> > > > Android suffers from mmap_sem contention so let's reduce mmap_sem
> > > > down_write.
> > > 
> > > Hi, Minchan:
> > > 
> > > It seems there is performance regression of this patch.
> > 
> > You mean "This patch aims for solving performance regression" not "This patch
> > makes performance regression"?
> > 
> > > 
> > > Do you have some test result of android app launch time or binderThroughput?
> > 
> > Unfortunately, I don't have any number. The goal is to reduce the number of
> > call mmap_sem as write-side lock because it makes priority inversion of threads
> > easily and that's one of clear part I spot that we don't need write-side lock.
> 
> Please always run the binderThroughput tests when making binder changes
> (there is a binder test suite in the CTS Android tests), as that ensures
> that you are not causing performance regressions as well as just normal
> bug regressions :)

Thanks for the information. I didn't notice that such kinds of tests for
binder. I will keep it in mind.

Today, I have setup the testing for my phone and found testing was very
fluctuating even without my patch. It might be not good with my test
skill. I emulated user's behavior with various touch event. With it, I open
various apps and play with them several times. Before starting the test,
I did "adb shell stop && adb shell start && echo 3 > /proc/sys/vm/drop_caches"

Such 15% noise was very easy to make it.

Ganesh, How did you measure? What's the stddev?
Please let me know how you measure without noise so I'd like to reproduce
the result in my phone.

I will do binderThroghput test, too.
