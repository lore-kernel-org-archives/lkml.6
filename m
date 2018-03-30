Return-Path: <minchan.kim@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522377654; cv=none;
        d=google.com; s=arc-20160816;
        b=kfUe7pWRLbMkmTtaICPGQSuHPls5buyALECVEyW4PdfmQhmMECQf6MWuWdqV/CTCBh
         OUI5Itbsim1E3TOIcF7VgNN3qJi/4eAjOR+qKRmCvUC73QL21QhiOTpCsi+zRmhAEplT
         Eg6NfSCs0DJRL4UL8ZKBVgMlr7HyVzzNqsuyS/HSUTrjMHPxksZk4xOpbWTIp1l+qFki
         wp4nSHybfSo1iAwI2rTjbPbhb+6mQ9xWveduWAhvLSXQPWRKTIOVSk/Suj6NzkTIU1Pp
         2XM86GukDad+QwjA3jHTNaC2ygL2fCrayNAY7lA4XUP7uXBKpP5gHmIYhIM6za98usAp
         mVDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=HzAey2PHgNMBGX9QwaYWa0PqhpwmTWRs5M4wyJYzsK8=;
        b=xKk+Ay96XhGvBF1YkVDM3rdNtJPjNjy29Q70FGf2n5F9YBygHGvurZEJAu+dw4vIG2
         2LCY18R/lgI6Fwy4iYbJKDR5sDPOzfr6PgOdvNbEM4rxGh1L4ok2Q3KP9gotmcihz06S
         haGw+KtKvo5cj7myIdclV3RDuim/bYLA9bQ42yGmmfaRerQ16eQ/SdUnWjpcS+LhIz8m
         /ydnPP7ih/llohLXdyIlQycEq21EgIjXfbh3stXAw1Cn3WJJYntBYbanJOIM2hcgNv/d
         TcTsuHBQEZ8E9vNdqQBrTmQC6JLlaJbZxwkVCpXI405/O8k0f4odNX8lKZ3hM7KTgH25
         795w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JYt06ujF;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JYt06ujF;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
X-Google-Smtp-Source: AIpwx4/J2JFMDxgsrctKDF4CnJE9kGK358/fgBNaWqomkfuNbyGJZt59qjfgTj+VDGbOnlJYlikbZw==
Sender: Minchan Kim <minchan.kim@gmail.com>
Date: Fri, 30 Mar 2018 11:40:48 +0900
From: Minchan Kim <minchan@kernel.org>
To: Ganesh Mahendran <opensource.ganesh@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joe Perches <joe@perches.com>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Martijn Coenen <maco@android.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v5] ANDROID: binder: change down_write to down_read
Message-ID: <20180330024048.GC255979@rodete-desktop-imager.corp.google.com>
References: <20180329065424.203172-1-minchan@kernel.org>
 <CADAEsF8Y2CJsuom=9au0-uvZAALvrLTdTnrkxrGjW9C9F6hTVg@mail.gmail.com>
 <20180330012921.GB255979@rodete-desktop-imager.corp.google.com>
 <CADAEsF_B2Jt=OQetHLKqfSq=wU4SSzQYtTLjYExiS9a09na6zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADAEsF_B2Jt=OQetHLKqfSq=wU4SSzQYtTLjYExiS9a09na6zA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596254032587353794?=
X-GMAIL-MSGID: =?utf-8?q?1596328671907422306?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 30, 2018 at 09:39:03AM +0800, Ganesh Mahendran wrote:
> 2018-03-30 9:29 GMT+08:00 Minchan Kim <minchan@kernel.org>:
> > Hi Ganesh,
> >
> > On Fri, Mar 30, 2018 at 09:21:55AM +0800, Ganesh Mahendran wrote:
> >> 2018-03-29 14:54 GMT+08:00 Minchan Kim <minchan@kernel.org>:
> >> > binder_update_page_range needs down_write of mmap_sem because
> >> > vm_insert_page need to change vma->vm_flags to VM_MIXEDMAP unless
> >> > it is set. However, when I profile binder working, it seems
> >> > every binder buffers should be mapped in advance by binder_mmap.
> >> > It means we could set VM_MIXEDMAP in binder_mmap time which is
> >> > already hold a mmap_sem as down_write so binder_update_page_range
> >> > doesn't need to hold a mmap_sem as down_write.
> >> >
> >> > Android suffers from mmap_sem contention so let's reduce mmap_sem
> >> > down_write.
> >>
> >> Hi, Minchan:
> >>
> >> It seems there is performance regression of this patch.
> >
> > You mean "This patch aims for solving performance regression" not "This patch
> > makes performance regression"?
> 
> After applying this patch in our devices, app launch time increases
> about 15% in average.
> "This patch makes performance regression", yes, from the results, it
> is like this.
> 
> I will do more test of this patch.

Thanks for the testing. Every apps increases time?
I will appreciate if you confirm the problem again.

I guess the reason is currently rw_semaphore's preferrence for writer
at up_write so If binder uses down_read instead of down_write, binder
should compete other down_read callers at wake up time from up_write
and could lose wakeup chance if it is low priority. 

Anyway, I think it's abuse of using down_write to get lock holding
asap where it's down_read enough. I guess there is tradeoff based on
binder's priority. 
If we go to the speculative page faults or range-lock instad of mmap_sem,
the situation would be much improved.

Anyway, currently, I have no idea to overcome such prioriy inversion
problem from rw_semaphore and I believe generally changing from
down_read to down_write is good thing to prevent contention.

Ccing maintainers.
