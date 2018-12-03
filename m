Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEED5C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9159A20848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9159A20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbeLCKzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:55:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:49304 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725888AbeLCKzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:55:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 21BECAE58;
        Mon,  3 Dec 2018 10:55:20 +0000 (UTC)
Date:   Mon, 3 Dec 2018 11:55:17 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        gregkh@linuxfoundation.org, keescook@google.com, shuah@kernel.org,
        joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org, robh@kernel.org,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com, frowand.list@gmail.com,
        knut.omang@oracle.com
Subject: Re: [RFC v3 03/19] kunit: test: add string_stream a std::stream like
 string builder
Message-ID: <20181203105517.vbedwygttxxbdtan@pathway.suse.cz>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-4-brendanhiggins@google.com>
 <20181130032924.GH18410@garbanzo.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130032924.GH18410@garbanzo.do-not-panic.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-11-29 19:29:24, Luis Chamberlain wrote:
> On Wed, Nov 28, 2018 at 11:36:20AM -0800, Brendan Higgins wrote:
> > A number of test features need to do pretty complicated string printing
> > where it may not be possible to rely on a single preallocated string
> > with parameters.
> > 
> > So provide a library for constructing the string as you go similar to
> > C++'s std::string.
> 
> Hrm, what's the potential for such thing actually being eventually
> generically useful for printk folks, I wonder? Petr?

printk() is a bit tricky:

   + It should work in any context. Any additional lock adds risk of a
     deadlock. Especially the NMI and scheduler contexts are problematic.
     There are problems with any other code that might be called
     from console drivers and calls printk() under a lock.

   + It should work also when the system is out of memory. Especially
     atomic context is problematic because we could not wait for
     memory reclaim or swap.

   + We also do to the best effort to get the message out on the
     console. It is important when the system is about to die.
     Any extra buffering layer might cause delay and avoid seeing the
     message.

From this point of views, this API is not generally usable with printk().

Now, the question is how many of the above fits also for unit testing.
At least, you might need to be careful when allocating memory in
atomic context.

BTW: There are more existing printk APIs: Well, I admit the they are
not easily reusable in unit testing:

   + printk() is old, crappy code, complicated with all the
     cornercases and consoles.

   + include/linux/seq_buf.h is simple buffering. It is used primary
     for sysfs output. It might be usable if you add support for
     loglevel and use big enough buffer. I quess that you should
     flush the buffer regularly anyway.

   + trace_printk() uses lockless per-CPU buffers. It currently does not
     support loglevels. But it might be pretty interesting choice as well.


I do not say that you have to use one of the existing API. But you
might consider them if you encouter any problems and maintaining
your variant gets complicated.

Best Regards,
Petr
