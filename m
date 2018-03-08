Return-Path: <kernel-hardening-return-12230-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvlqSulORJ83Zp3HuOj7tbTYg9v2vxJLe+Xq2AMK8KjSQuM6VfVzNagMED2E+asSQFtwBTu
ARC-Seal: i=1; a=rsa-sha256; t=1520490305; cv=none;
        d=google.com; s=arc-20160816;
        b=itmyCtoKss0tWcwaUTBfILym8VAmgNIrfguEkDWQhsgFws9s5Ebwoi3umCx5CzPqOf
         Y8kO7yLlS+5aBFG5frOquNZit7lIuhVG1TkEIyuTDUDEUIukZa0EEXID6VRKNFL/qokJ
         xDR+iBfnaVp4o611Ukai5gsZ1isHT6zKsBIKWAj6oRCZO2/VRkGKRZG5DmBJTKxafs5m
         xUFJTohFvdTxOj6AVLBpmpjJUKSgF+HjNXaCg05s6TIVXVUrPhA6wnAytWxu9PxI2xCE
         brkdJ8/G2LcllJdi9af9fTzhHYQQlbA+mNEM92T6VHfSX+D35K5AmQ5EZeW6sATvQ5q1
         VU6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=PjJ3Zh+IyVpYSpCqcL5wZHfJdZvzqGvNuIRiZAdJ78I=;
        b=I0SfAtPcD/gAzVGcMnXQ8puA01UKtodLQxc49DV2+EdftYxh/Ks4IwoRXsRBYmShmK
         bmRHkw8cj4o0JZ6hyLnk8Y+UpapOdFjuYqBh9w/J1TuF9pOZodbdtIre5xVN6D9G9Jp0
         riEh/WXSZQVjwdWafbaCypAB2aWNTDQ7V6BSYo131k4o2JB5AJ3oU6M7uakcP4m7JAQr
         9KAYKKI9EDJByss+ycI76W48eIq2AGO3oBDGk3XehRXvs9N8nrc0f0Av0mQjYUdAqG1+
         vuygb590HRpWONEFJh7glipVMS+N3Gd036vmwMa+GFp0OaSvubFyfRWzQWZvqOB3U39Z
         oPGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12230-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12230-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12230-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12230-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-IronPort-AV: E=Sophos;i="5.47,439,1515452400";
   d="scan'208";a="257421091"
Date: Thu, 8 Mar 2018 07:24:47 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Matthew Wilcox <willy@infradead.org>
cc: Kees Cook <keescook@chromium.org>,
    Andrew Morton <akpm@linux-foundation.org>,
    Matthew Wilcox <mawilcox@microsoft.com>, Linux-MM <linux-mm@kvack.org>,
    LKML <linux-kernel@vger.kernel.org>,
    Kernel Hardening <kernel-hardening@lists.openwall.com>,
    cocci@systeme.lip6.fr, Himanshu Jha <himanshujha199640@gmail.com>
Subject: Re: [PATCH 2/2] mm: Add kvmalloc_ab_c and kvzalloc_struct
In-Reply-To: <20180308025812.GA9082@bombadil.infradead.org>
Message-ID: <alpine.DEB.2.20.1803080722300.3754@hadrien>
References: <20180214182618.14627-1-willy@infradead.org> <20180214182618.14627-3-willy@infradead.org> <CAGXu5jL9hqQGe672CmvFwqNbtTr=qu7WRwHuS4Vy7o5sX_UTgg@mail.gmail.com> <alpine.DEB.2.20.1803072212160.2814@hadrien>
 <20180308025812.GA9082@bombadil.infradead.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592401933337716102?=
X-GMAIL-MSGID: =?utf-8?q?1594349643029472260?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Wed, 7 Mar 2018, Matthew Wilcox wrote:

> On Wed, Mar 07, 2018 at 10:18:21PM +0100, Julia Lawall wrote:
> > > Otherwise, yes, please. We could build a coccinelle rule for
> > > additional replacements...
> >
> > A potential semantic patch and the changes it generates are attached
> > below.  Himanshu Jha helped with its development.  Working on this
> > uncovered one bug, where the allocated array is too large, because the
> > size provided for it was a structure size, but actually only pointers to
> > that structure were to be stored in it.
>
> This is cool!  Thanks for doing the coccinelle patch!  Diffstat:
>
>  50 files changed, 81 insertions(+), 124 deletions(-)
>
> I find that pretty compelling.  I'll repost the kvmalloc_struct patch
> imminently.

Thanks.  So it's OK to replace kmalloc and kzalloc, even though they
didn't previously consider vmalloc and even though kmalloc doesn't zero?

There are a few other cases that use GFP_NOFS and GFP_NOWAIT, but I didn't
transform those because the comment says that the flags should be
GFP_KERNEL based.  Should those be transformed too?

julia
