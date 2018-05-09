Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935482AbeEIQeN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 12:34:13 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:53971 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933573AbeEIQeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 12:34:11 -0400
X-Google-Smtp-Source: AB8JxZpLFUd0JatgFnw0PqbgsEwLKOPmzk0fOSD4uYFeKG2w/MbZ3cngJHpENzUXTepw2FvEDpMxvw==
Date: Wed, 9 May 2018 19:34:07 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: test /proc/*/fd a bit (+ PF_KTHREAD is ABI!)
Message-ID: <20180509163407.GA16034@avx2>
References: <20180505000414.GA15090@avx2>
 <20180508153920.9e74e1ab86a8b10e8ddf09a0@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180508153920.9e74e1ab86a8b10e8ddf09a0@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 03:39:20PM -0700, Andrew Morton wrote:
> On Sat, 5 May 2018 03:04:14 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> > This field is struct task_struct::flags in decimal!
> > Check is done by testing PF_KTHREAD flags like we do in kernel.
> > 
> > 	PF_KTREAD value is a part of userspace ABI !!!
> 
> erk.  Well if there's a need the we could export and support some
> stable interface.  I wonder how ps determines this.

Turned out ps (from procps-ng) reads /proc/*/cmdline and if read()
returns 0 prints [] brackets. This is unreliable as

	execve("", NULL, NULL);

exists and processes can empty their argv/envp area.

It can do sorting based on "flags" field, so we hopefully can just mask
most of the bits.

At least it deals with ->comm containing ')' right.
