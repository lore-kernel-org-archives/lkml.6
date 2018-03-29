Return-Path: <minchan.kim@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522288917; cv=none;
        d=google.com; s=arc-20160816;
        b=OfCZlvBOxfLwD1SxxQnW9Pz0MC59XllxjZ34jk1n8oVVyVWuvj539ad9gzCNvBFD31
         PwA/QEZuWL+nZEVsgnALe6wvMjS3WJQpu4ywf8AchXfqSu8z4EnRrQ8d5MPVyuuXg2X+
         h1N++BipAyIfBID22yARmfG+TlydYhHTgzmR6OKEGIQl4x669ia5YUgK7sgAfzvWltzP
         I+rU7gkSgz8AkQYmCWorjgkbko96mgYZMSILfqKP57BTmsNBkb9HW3fsaFFFWbV+0buu
         LUlslLxEmbp7wWcwQS8WVXR7L81ESmXCBcs14TMVSQgIE9A8LE8AWwe8p/E9oYwq0Fbd
         YqtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:sender:dkim-signature:arc-authentication-results;
        bh=GameBzFzQgFN/0quAhiEU/14cqbgHj5v2QsGu19VhS0=;
        b=jsfwt6dTqnzPZpTM3j5itvQMZIvPtU5zKOd3CKxKyHwaYR9d/nOGNkKd4PlPXMgRkM
         oPabkDhSWPIrDYUYOQBRU4CbaHSq9xIFsb7tmNh+CcYqxM2W2VumLoc/Gmdu6sNAr5Y5
         eD4j20yV21Gq6sZb1Cn0Y/hyA2u3fhtVJUAk2Mh9hrD01xfY/3Ka6iT7sX7gssQC4eVo
         wlM6KXRGnvjVfkjEzkkenYejNRcgTH9ip1TK5+VPR/j/I2qod8/FSxTa3l4wxLO1l4v/
         6VAuZYDaaV51OxYs4atCQVv14dMMML06/OEF3FjzouwC1fgiR7AcfaVByEx3ifzVeGV+
         ts3g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=T0Ati9dp;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=T0Ati9dp;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
X-Google-Smtp-Source: AIpwx4+18wyNG40kT+O/u5LeqZrEZ0iz5zZwUAae+M9n7F2Pka0EuxiICxnSk70+4AFBT1rNxqqQRw==
Sender: Minchan Kim <minchan.kim@gmail.com>
Date: Thu, 29 Mar 2018 11:01:51 +0900
From: Minchan Kim <minchan@kernel.org>
To: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Todd Kjos <tkjos@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Martijn Coenen <maco@android.com>
Subject: Re: [PATCH v2] ANDROID: binder: change down_write to down_read
Message-ID: <20180329020151.GA91696@rodete-desktop-imager.corp.google.com>
References: <20180329010040.96760-1-minchan@kernel.org>
 <CAMP5Xge2bFr2d9zss_Qi49RE7NsRTQpA0q7s_uwmMw4x3_ceug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMP5Xge2bFr2d9zss_Qi49RE7NsRTQpA0q7s_uwmMw4x3_ceug@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596231778699320743?=
X-GMAIL-MSGID: =?utf-8?q?1596235623756906638?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 06:59:41PM -0700, Arve Hjønnevåg wrote:
> On Wed, Mar 28, 2018 at 6:00 PM, Minchan Kim <minchan@kernel.org> wrote:
> > binder_update_page_range needs down_write of mmap_sem because
> > vm_insert_page need to change vma->vm_flags to VM_MIXEDMAP unless
> > it is set. However, when I profile binder working, it seems
> > every binder buffers should be mapped in advance by binder_mmap.
> > It means we could set VM_MIXEDMAP in bider_mmap time which is
> > already hold a mmap_sem as down_write so binder_update_page_range
> > doesn't need to hold a mmap_sem as down_write.
> >
> > Android suffers from mmap_sem contention so let's reduce mmap_sem
> > down_write.
> >
> > Cc: Todd Kjos <tkjos@google.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Martijn Coenen <maco@android.com>
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> > From v1:
> >   * remove WARN_ON_ONCE - Greg
> >   * add reviewed-by - Martijn
> >
> > Martijn, I took your LGTM of v1 as Reviewed-by. If you don't like it
> > or want to change it to acked-by, please, tell me.
> >
> >  drivers/android/binder.c       | 2 +-
> >  drivers/android/binder_alloc.c | 6 +++---
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > index 764b63a5aade..9a14c6dd60c4 100644
> > --- a/drivers/android/binder.c
> > +++ b/drivers/android/binder.c
> > @@ -4722,7 +4722,7 @@ static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
> >                 failure_string = "bad vm_flags";
> >                 goto err_bad_arg;
> >         }
> > -       vma->vm_flags = (vma->vm_flags | VM_DONTCOPY) & ~VM_MAYWRITE;
> > +       vma->vm_flags |= (VM_DONTCOPY | VM_MIXEDMAP) & ~VM_MAYWRITE;
> 
> Why did you change this to |=? You are no longer clearing VM_MAYWRITE.

Oops, Thanks for pointing out.
I will respin.
