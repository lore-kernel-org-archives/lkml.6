Return-Path: <kernel-hardening-return-13194-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZoj/s+y6ZhadNwJQfyye7GCDSDNvdcnCCXgvn8H5knwBPVH2he7k8LkgUKdgXx62UDt4Hlo
ARC-Seal: i=1; a=rsa-sha256; t=1525297864; cv=none;
        d=google.com; s=arc-20160816;
        b=nacXP2C1+QA+YdkF/fWzhLmX3AoaRxRQO+gm+F1oPSMOTKTn0QPWcF/R3XNaKSsDhu
         yAklwkXsM5JlSov6k90cL+11oTlZuYfXJynTcHzRB18Y1s+cKVzNeC7oGeycrOrb9U2f
         vCuVbkPoWejUUcYBphvGT+T4Y/bFZ9+AK8LmKw1CFx6vetU5CVnv6sfx7OaWOmXqJe8K
         Yxv7QzLEYeHRw6BVrRYuvlU1SKL6txIfW6PfPAxXQVw1FD7A6kiCAkv9fGmewKhN4Tgq
         WxgAwA5P2ds1XUHKPR6u0Q9mzc1/j03gBLWJLAitMd0yMAtkgEkM6JkYQE2DSPS3Gwol
         DKYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=185/k19+nHHxfesZBXZutwF5+DAIAAPGMUr2kJ+QW94=;
        b=fm4oVGqgTiKkr1nhuM+P4Dni3v8B2oaJJke1+5G5WdXUjPyv+lUlW5LvPy6U8gTZcB
         hT9QJNiX6Z5xpa5kF5ZtM2xPa0CLfUNRMhifYAq7ucLiOIT+SC0pALkyXFltkDATRJG0
         uOnFS9TfYzrbOR1gUbi9GnqFDvR1buHNAcTjHvvM3KWi+GqnRHwo2xUxkq8XVyko8hGV
         AJX4LwhoQKpeKeTY3lYm18NPPz5w0iVOUnwQTaVu/85zmzJY4vSmsloZBHnQLweMOw1i
         r+m0XEalS3PR2uFwAN54R9GvO5/DBZqlxUwsC/h9Patd+Fg0vIeg/rhmcpbnEIKOobfP
         R3jg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13194-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13194-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13194-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13194-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 2 May 2018 14:50:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Igor Stoppa <igor.stoppa@gmail.com>
Cc: mhocko@kernel.org, keescook@chromium.org, linux-mm@kvack.org,
 kernel-hardening@lists.openwall.com, linux-security-module@vger.kernel.org,
 willy@infradead.org, labbott@redhat.com, linux-kernel@vger.kernel.org,
 igor.stoppa@huawei.com
Subject: Re: [PATCH 0/3 v2] linux-next: mm: Track genalloc allocations
Message-Id: <20180502145044.373c268eeaaa9022b99f9191@linux-foundation.org>
In-Reply-To: <20180502010522.28767-1-igor.stoppa@huawei.com>
References: <20180502010522.28767-1-igor.stoppa@huawei.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599312393247232673?=
X-GMAIL-MSGID: =?utf-8?q?1599390733956227069?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed,  2 May 2018 05:05:19 +0400 Igor Stoppa <igor.stoppa@gmail.com> wrote:

> This patchset was created as part of an older version of pmalloc, however
> it has value per-se, as it hardens the memory management for the generic
> allocator genalloc.
> 
> Genalloc does not currently track the size of the allocations it hands
> out.
> 
> Either by mistake, or due to an attack, it is possible that more memory
> than what was initially allocated is freed, leaving behind dangling
> pointers, ready for an use-after-free attack.
> 
> With this patch, genalloc becomes capable of tracking the size of each
> allocation it has handed out, when it's time to free it.
> 
> It can either verify that the size received is correct, when free is
> invoked, or it can decide autonomously how much memory to free, if the
> value received for the size parameter is 0.
> 
> These patches are proposed for beign merged into linux-next, to verify
> that they do not introduce regressions, by comparing the value received
> from the callers of the free function with the internal tracking.
> 
> For this reason, the patchset does not contain the removal of the size
> parameter from users of the free() function.
> 
> Later on, the "size" parameter can be dropped, and each caller can be
> adjusted accordingly.
> 
> However, I do not have access to most of the HW required for confirming
> that all of its users are not negatively affected.
> This is where I believe having the patches in linux-next would help to
> coordinate with the maintaiers of the code that uses gen_alloc.
> 
> Since there were comments about the (lack-of) efficiency introduced by
> this patchset, I have added some more explanations and calculations to the
> description of the first patch, the one adding the bitmap.
> My conclusion is that this patch should not cause any major perfomance
> problem.
> 
> Regarding the possibility of completely changing genalloc into some other
> type of allocator, I think it should not be a showstopper for this
> patchset, which aims to plug a security hole in genalloc, without
> introducing any major regression.
> 
> The security flaw is clear and present, while the benefit of introducing a
> new allocator is not clear, at least for the current users of genalloc.
> 
> And anyway the users of genalloc should be fixed to not pass any size
> parameter, which can be done after this patch is merged.
> 
> A newer, more efficient allocator will still benefit from not receiving a
> spurious parameter (size), when freeing memory.
> 
> ...
> 
>  Documentation/core-api/genalloc.rst |   4 +
>  include/linux/genalloc.h            | 112 +++---
>  lib/Kconfig.debug                   |  23 ++
>  lib/Makefile                        |   1 +
>  lib/genalloc.c                      | 742 ++++++++++++++++++++++++++----------
>  lib/test_genalloc.c                 | 419 ++++++++++++++++++++

That's a big patch, and I'm having trouble believing that it's
justified?  We're trying to reduce the harm in bugs (none of which are
known to exist) in a small number of drivers to avoid exploits, none of
which are known to exist and which may not even be possible.

Or something like that.  Perhaps all this is taking defensiveness a bit
too far?

And a bitmap is a pretty crappy way of managing memory anyway, surely? 
If this code is indeed performance-sensitive then perhaps a
reimplementation with some standard textbook allocator(?) is warranted?
