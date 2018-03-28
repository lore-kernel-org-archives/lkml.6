Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753904AbeC1Wii (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 18:38:38 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55369 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753431AbeC1Wig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 18:38:36 -0400
X-Google-Smtp-Source: AIpwx4/j9WHdq6Oin/blTRmJS7vQdx4dkkmWTmN/C1I6t/1zlztqwLGCFeMUVmOnrNRinVtTwvMWKg==
Date: Thu, 29 Mar 2018 01:38:32 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: register filesystem last
Message-ID: <20180328223832.GA4557@avx2>
References: <20180309222709.GA3843@avx2>
 <20180309144938.d308e0bf98fb6b5bbcb82189@linux-foundation.org>
 <20180310000634.GA12443@avx2>
 <20180328044823.GT30522@ZenIV.linux.org.uk>
 <20180328072657.GA2063@avx2>
 <20180328144748.GU30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328144748.GU30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 03:47:49PM +0100, Al Viro wrote:
> On Wed, Mar 28, 2018 at 10:26:57AM +0300, Alexey Dobriyan wrote:
> > On Wed, Mar 28, 2018 at 05:48:23AM +0100, Al Viro wrote:
> > > On Sat, Mar 10, 2018 at 03:06:34AM +0300, Alexey Dobriyan wrote:
> > > > On Fri, Mar 09, 2018 at 02:49:38PM -0800, Andrew Morton wrote:
> > > > > On Sat, 10 Mar 2018 01:27:09 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > > > > 
> > > > > > As soon as register_filesystem() exits, filesystem can be mounted.
> > > > > > It is better to present fully operational /proc.
> > > > > > 
> > > > > > Of course it doesn't matter because /proc is not modular
> > > > > > but do it anyway.
> > > > > > 
> > > > > > Drop error check, it should be handled by panicking.
> > > > > 
> > > > > So... shouldn't we add a call to panic()?
> > > > 
> > > > via FS_PANIC flag, yes. I have a patch somewhere.
> > > > There are 104 filesystems ATM, some internal, some not.
> > > > Some modular, some not.
> > > 
> > > You do realize that the only case when register_filesystem() fails is
> > > "another driver has already registered filesystem type with the same
> > > name"?  Is there *ever* a case when
> > > 	* you could expect that to happen and
> > > 	* panic would be a sane response?
> > 
> > It is for standartizing all those error checks in init sequence by
> > removing them. Modules won't have FS_PANIC.
> 
> Huh?  Again, _when_ is that thing appropriate?  To register_filesystem()
> failure in non-modular case you need several builtin fs drivers to
> try and register fs types with the same name.  In this particular
> case, you need another in-kernel filesystem called "proc" registered
> first.
> 
> It's not about extreme oom early in the boot or anything like that -
> plain and simple badly modified and misconfigured kernel.

At this point I'm not sure if we agree or disagree.

If register fails at init time it can mean that strncmp() is buggy,
or memory corruption already happened (file_system_type instances aren't
const after all). In all cases it is appropriate to panic exactly
because "regular" name collision will never happen.
