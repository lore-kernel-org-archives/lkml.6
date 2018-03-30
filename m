Return-Path: <minchan.kim@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522373367; cv=none;
        d=google.com; s=arc-20160816;
        b=xK3JJt6QWepuoGr7GGWkNq/cQILiWMrZW0PMC2aix/smPLCJ/MzUL03R+5eFKg+oIj
         sFEj6ycW3v21onsX7dh50n37xySb9AvR36X2nv1e/SjixCielBNgXkETdidZ64PfcXHX
         zWZU3MFoJi2TXvbZn+nYFuWGuYKWbHHLAbCFQ6MTXC2vvjYZ8QLgX2wMwQFwm3wM5RBM
         tWQlmzz9k/FB8ez09rudx57CSlDAxDg68fD/ikIwiPyiFtWG70Oi3fOFigtUeOz7xmfy
         HwxYdLgQPIRBSpmi6vzbmg/u6vMRByGZtNXJn7uxAkdZUNipxsCjIPJD6+X+mOjdFlC9
         mTRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=sayygcNPwLdmM4szSNCkmzUagOZS0siTnqqwZd3iNAI=;
        b=KiAILuVV+HU+gfDtKoWbHx/Z0Y4zIiMIJFeJs9cVFw+rh9BQIIAJYneA/I3t360DHg
         gclF5kbtnLTGjnFuu9tGtUk8qEk19zJh7u8gUbvfUNni3i+gF8qmSlf6hilR7GjjhKcz
         k0iWTQy2/BYYJnGz5IhWGbuAjlljnNdWErh0JxLSA1YCOcV0sVZZEofTphutzJ7VunKJ
         Wj36t47THbHRfrksxHJAOjvbvH8fkfWw+y32UzMDND16/rixk031tZLpEXF2dkMrh7NH
         lZFVRgJHvsK3XfTIiWyvwCGseTs9k+uyDVHcZ9h3pSYTxUmeX1ab6DK8G0aNR1ZwmvXL
         znRg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=n4A35PqZ;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=n4A35PqZ;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
X-Google-Smtp-Source: AIpwx49/03+G/pfxYL5JFJ7aC+v8HGfuMXelwZGV51iuAB3Ha1rpb5PTjNp9N70LcfRw3LkoWRIP2Q==
Sender: Minchan Kim <minchan.kim@gmail.com>
Date: Fri, 30 Mar 2018 10:29:21 +0900
From: Minchan Kim <minchan@kernel.org>
To: Ganesh Mahendran <opensource.ganesh@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joe Perches <joe@perches.com>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Martijn Coenen <maco@android.com>
Subject: Re: [PATCH v5] ANDROID: binder: change down_write to down_read
Message-ID: <20180330012921.GB255979@rodete-desktop-imager.corp.google.com>
References: <20180329065424.203172-1-minchan@kernel.org>
 <CADAEsF8Y2CJsuom=9au0-uvZAALvrLTdTnrkxrGjW9C9F6hTVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADAEsF8Y2CJsuom=9au0-uvZAALvrLTdTnrkxrGjW9C9F6hTVg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596254032587353794?=
X-GMAIL-MSGID: =?utf-8?q?1596324177017461914?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Ganesh,

On Fri, Mar 30, 2018 at 09:21:55AM +0800, Ganesh Mahendran wrote:
> 2018-03-29 14:54 GMT+08:00 Minchan Kim <minchan@kernel.org>:
> > binder_update_page_range needs down_write of mmap_sem because
> > vm_insert_page need to change vma->vm_flags to VM_MIXEDMAP unless
> > it is set. However, when I profile binder working, it seems
> > every binder buffers should be mapped in advance by binder_mmap.
> > It means we could set VM_MIXEDMAP in binder_mmap time which is
> > already hold a mmap_sem as down_write so binder_update_page_range
> > doesn't need to hold a mmap_sem as down_write.
> >
> > Android suffers from mmap_sem contention so let's reduce mmap_sem
> > down_write.
> 
> Hi, Minchan:
> 
> It seems there is performance regression of this patch.

You mean "This patch aims for solving performance regression" not "This patch
makes performance regression"?

> 
> Do you have some test result of android app launch time or binderThroughput?

Unfortunately, I don't have any number. The goal is to reduce the number of
call mmap_sem as write-side lock because it makes priority inversion of threads
easily and that's one of clear part I spot that we don't need write-side lock.

Thanks.
