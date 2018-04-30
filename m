Return-Path: <jannh@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525097779; cv=none;
        d=google.com; s=arc-20160816;
        b=cGt/EEtkNmhwBNDR//zlHFyuDMo1GVwC0NyVBwrEDqW94BlwdzUeqL2GjpwmqMKk9E
         f3+aqutVXWHJBHU53k3JM6+c9xzl1+/nwBrcF+32+Ji6Qb4pjiK637B4oM0jWQ+ImlCh
         GyXjM7ia7LmchLQwof5dLdSZErjWfYeVWz+Q3p2ebBnV2n5VlQlBte9GymagMhTDnr3f
         v2H3Do5bUjL3Hp3epyunqchtdgOP1krKeJ6+lHtYhaYnvdEfQBo0rxHF9eqhmRJGXnjo
         WpljkSkvHX5M8jk76Gwq140f/GUilnKoc+VpjNFEnmYNjPc2XoWoKC2aKfPk13YsgyX+
         YUtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=GF4TRdXr6U2AcLxVEEAisZhyiMp/y9KGG2H0jo/Rw5E=;
        b=ZmSchWVB8QvbZJHSyg/QPH6H1MW9lK0QWOyz1L1sLgcxh0QA77JTilgrybr+fODzx0
         7bokTsffIzuZD8y31MhSNRAbH86+zGYx/OKSO3AsnZAIRnt72DQkr3nj6V0dEBcTgelx
         dJzG4RnIDdaEjn53sIanVlO5X/PBndTB5KQKmBfrEIj0q56J16kOiVKPxQemM0HzLy0m
         6egcuUVp8Fbf4ixMBha0/CdYzd9kfRjuIfUgNROdGyp0/S4OzWvwos0sARWNRj886IPn
         LMMzOwEYda7KQQkRJlQJXGl06yGKzg9IjramAt9tONmBwrO36Xb1oyD+U08SvB/5q3P5
         khMQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=P3dQ/m9g;
       spf=pass (google.com: domain of jannh@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jannh@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=P3dQ/m9g;
       spf=pass (google.com: domain of jannh@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jannh@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AB8JxZp2VH7elQ2b2jQW1VKwCFTsn6EA13itNunq8EGInJ5EgRfV2oOv9kCWxMBx/JRaIq5Yv/TZRClIypoM0lOnqXc=
MIME-Version: 1.0
In-Reply-To: <20180427134936.GA31171@kroah.com>
References: <20180427123547.15727-1-tmricht@linux.ibm.com> <20180427134936.GA31171@kroah.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 30 Apr 2018 16:15:58 +0200
Message-ID: <CAG48ez3WW49fGaNkG4rd7aFB7HXRKe24Yh_w55JWoG3Cz1HN2A@mail.gmail.com>
Subject: Re: [PATCH v2] inode: debugfs_create_dir uses mode permission from parent
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Kees Cook <keescook@chromium.org>, Thomas Richter <tmricht@linux.ibm.com>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, brueckner@linux.vnet.ibm.com,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>,
	kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598885939373348657?=
X-GMAIL-MSGID: =?utf-8?q?1599180929721801510?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 3:49 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> I'm going to add Kees and the kernel-hardning list here, as I'd like
> their opinions for the patch below.
>
> Kees, do you have any problems with this patch?  I know you worked on
> making debugfs more "secure" from non-root users, this should still keep
> the intial mount permissions all fine, right?  Anything I'm not
> considering here?
>
> thanks,
>
> greg k-h
>
> On Fri, Apr 27, 2018 at 02:35:47PM +0200, Thomas Richter wrote:
>> Currently function debugfs_create_dir() creates a new
>> directory in the debugfs (usually mounted /sys/kernel/debug)
>> with permission rwxr-xr-x. This is hard coded.
>>
>> Change this to use the parent directory permission.

AFAICS no inodes in debugfs have handlers for the ->rename, ->mkdir,
->create inode ops. What is write permission on debugfs directories
useful for?
