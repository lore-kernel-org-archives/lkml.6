Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD6EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC6D21780
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:38:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC6D21780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732519AbeKNTkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 14:40:52 -0500
Received: from mga06.intel.com ([134.134.136.31]:22214 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbeKNTkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 14:40:51 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2018 01:38:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,231,1539673200"; 
   d="scan'208";a="100131111"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga003.jf.intel.com with ESMTP; 14 Nov 2018 01:38:20 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gMrcp-0006up-El; Wed, 14 Nov 2018 11:38:19 +0200
Date:   Wed, 14 Nov 2018 11:38:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Qian Cai <cai@gmx.us>,
        linux-kernel@vger.kernel.org, "Tobin C. Harding" <me@tobin.cc>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: WARNING: CPU: 26 PID: 64391 at lib/vsprintf.c:2193
 set_precision+0x84/0x90
Message-ID: <20181114093819.GL10650@smile.fi.intel.com>
References: <1542128132.12945.19.camel@gmx.us>
 <20181113172920.GI10650@smile.fi.intel.com>
 <1542135498.12945.20.camel@gmx.us>
 <20181113142317.379dbaf7@vmware.local.home>
 <20181113230511.5di75uyht7ecdcvl@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113230511.5di75uyht7ecdcvl@pathway.suse.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 12:05:12AM +0100, Petr Mladek wrote:
> On Tue 2018-11-13 14:23:17, Steven Rostedt wrote:
> > On Tue, 13 Nov 2018 13:58:18 -0500
> > Qian Cai <cai@gmx.us> wrote:
> > 
> > > > Care to print the len and name parameters before this line?  
> > > len = 60612; name =
> > 
> > How big are pages on arm64? Because we shouldn't get to this path if
> > the string is bigger than PAGE_SIZE. But I know that on PPC64,
> > PAGE_SIZE can be 64K, and 60612 is less than that. Thus, if we get
> > there, the test is against signed int:16 (16 bit signed integer) that
> > can go up to most 32768. If the string size is bigger than that, you
> > would get this error.
> > 
> > I would just say to ignore it.
> 
> I tend to agree.
> 
> > The only thing that can happen if
> > someone does this is to trigger the warning. Unless if it is considered
> > a form of DOS, where userspace just bombards the console by triggering
> > this waring.
> 
> We are actually on the safe side because it is WARN_ONCE().
> 
> > But I don't see a problem with the actual design. There's
> > no reason we should be processing string variables bigger than 32768 in
> > vsprintf.
> 
> It is not even needed in this case. The string is limited also by
> MODULE_NAME_LEN.

At least not in this code.

Are you proposing to replace strlen(name) with strnlen(name, MODULE_NAME_LEN)?


-- 
With Best Regards,
Andy Shevchenko


