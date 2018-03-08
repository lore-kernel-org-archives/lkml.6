Return-Path: <kernel-hardening-return-12224-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsv73z6xI3YNX3ouWUStMrW1meBaCp8otXzA2Wg6+0CUQ3Y3g233JdVc0NP9V3JSIU2FBpw
ARC-Seal: i=1; a=rsa-sha256; t=1520477923; cv=none;
        d=google.com; s=arc-20160816;
        b=mUbei6UlN1s+U2KtS5tMOTwP0QlLL2nzTqpkbGyQMTUdwXODCUUUsdNzVv74liJwlp
         YG6RLzxFA4LXCXbrI3HTsulbD/HdILYh/HYMzSjdAJn75u19uZ9dDAthlXkjqhiBrFyf
         UuUZ7LzIurNEv5Amyka/FZtZjjzFLN9kaQ4VAEPRaBfayr3knpVXCUvUVQj8fdJouZ2L
         UggZZD6bcQcoGUS02aClb5tDBXR1tbbcnpw3VQ4zb7jQXkdg46ODt1dYqS7pokx2dAki
         e4eGcEOePzu0MJyod//cEho2+MECYPKrMFAlG2BJk59n4VSAUvpz1uvGye2jrRpLMhQd
         Px5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=BmcxDUnZwYNbw7sVHu9E/snWfrKvdrtGD+55rLIgsac=;
        b=0o3vnijh0IMg2/UdC4GvxGrzWGjd4nn9wno2mbdpjdtOSSlkEUU84DdK1gmKyPRmL0
         aStV/TnRqC1nc8c/b1yVIjmYzKnCo8VWGI2tVkeUqBHSVu8CqAoBvatgt9VqbpxlYMs8
         Di6w5q85Z+OSH1cuVxciRLCp50CIREgD2gP/cCpnpzR7c3hxF51nOFF44WO8w5udJzmM
         I51/65AU3qM947KSTBE0TZDmsJ5sGWAyD/iKQWbqV5+9JvlHo1XvZd0d5Q7TImaSpvmR
         9xsLu32zWJir+8tw52WEWGdc29lxtoOkMTruzAIDWvlbbCRI7PcSBtxKQHctTeHPfhro
         ewHg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=eSLf0CLo;
       spf=pass (google.com: domain of kernel-hardening-return-12224-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12224-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=eSLf0CLo;
       spf=pass (google.com: domain of kernel-hardening-return-12224-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12224-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 7 Mar 2018 18:58:12 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <mawilcox@microsoft.com>,
	Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	cocci@systeme.lip6.fr, Himanshu Jha <himanshujha199640@gmail.com>
Subject: Re: [PATCH 2/2] mm: Add kvmalloc_ab_c and kvzalloc_struct
Message-ID: <20180308025812.GA9082@bombadil.infradead.org>
References: <20180214182618.14627-1-willy@infradead.org>
 <20180214182618.14627-3-willy@infradead.org>
 <CAGXu5jL9hqQGe672CmvFwqNbtTr=qu7WRwHuS4Vy7o5sX_UTgg@mail.gmail.com>
 <alpine.DEB.2.20.1803072212160.2814@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1803072212160.2814@hadrien>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592401933337716102?=
X-GMAIL-MSGID: =?utf-8?q?1594336659585046033?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 07, 2018 at 10:18:21PM +0100, Julia Lawall wrote:
> > Otherwise, yes, please. We could build a coccinelle rule for
> > additional replacements...
> 
> A potential semantic patch and the changes it generates are attached
> below.  Himanshu Jha helped with its development.  Working on this
> uncovered one bug, where the allocated array is too large, because the
> size provided for it was a structure size, but actually only pointers to
> that structure were to be stored in it.

This is cool!  Thanks for doing the coccinelle patch!  Diffstat:

 50 files changed, 81 insertions(+), 124 deletions(-)

I find that pretty compelling.  I'll repost the kvmalloc_struct patch
imminently.
