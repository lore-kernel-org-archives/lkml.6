Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29D4C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6B52172C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6B52172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbeHTSJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 14:09:16 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55694 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeHTSJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 14:09:16 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1frlYP-0007dx-Fd; Mon, 20 Aug 2018 16:53:13 +0200
Date:   Mon, 20 Aug 2018 16:53:13 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Guenter Roeck <linux@roeck-us.net>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: Build failures with gcc 4.5 and older
In-Reply-To: <87ca655c-e73a-286f-e69d-30fed9d00d77@roeck-us.net>
Message-ID: <alpine.DEB.2.21.1808201652420.1551@nanos.tec.linutronix.de>
References: <20180814170904.GA12768@roeck-us.net> <20180814143655.3acd4bb211d44747f77e74f2@linux-foundation.org> <20180814221559.GA15888@roeck-us.net> <20180814160208.4f4dd7ca142912f5894ddddd@linux-foundation.org> <CA+55aFyU6p-da4j0TWQTEkvYDK_ymFDeTfBa9htYXrdH5gahgQ@mail.gmail.com>
 <87ca655c-e73a-286f-e69d-30fed9d00d77@roeck-us.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2018, Guenter Roeck wrote:
> On 08/14/2018 04:20 PM, Linus Torvalds wrote:
> > On Tue, Aug 14, 2018 at 4:02 PM Andrew Morton <akpm@linux-foundation.org>
> > wrote:
> > > 
> > > The m68k build still fails because 0cc3cd21657 ("cpu/hotplug: Boot HT
> > > siblings at least once") was evidently never tested on CONFIG_SMP=n.
> > > How could that come about - the patch is six weeks old??
> > 
> > Ehh, meet the joys of embargoes.
> > 
> > The code was tested (and people even found subtle arm64 problems due
> > to that testing), but because it couldn't be made public until today,
> > it didn't go through all the usual infrastructure we depend on.
> > 
> > But:
> > 
> > > kernel/cpu.c: In function 'boot_cpu_hotplug_init':
> > > kernel/cpu.c:2275:2: error: 'struct cpuhp_cpu_state' has no member named
> > > 'booted_once'
> > 
> > it should be fixed now in -git.
> > 
> > > @@ -490,6 +490,8 @@ struct mm_struct {
> > >   #endif
> > >          } __randomize_layout;
> > > 
> > > +       int wibble;
> > > +
> > 
> > Can we call this something informative? Like
> > 
> >          int __gcc_4_4_is_garbage_that_shouldnt_be_used;
> > 
> > or something?
> > 
> > That is, if we actually want to really drag out this whole pointless
> > pain of allowing ancient compilers?
> > 
> > Guys, at some point we need to switch to 4.6. The people who feel the
> > pain today *will* feel the pain at some point. Just get it over with
> > already.
> > 
> 
> For my part I am all for making gcc 4.6 mandatory.

No objections from my side.

Thanks,

	tglx
