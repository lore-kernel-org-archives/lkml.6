Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EB1C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE4720647
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE4720647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbeH1OGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 10:06:08 -0400
Received: from bastet.se.axis.com ([195.60.68.11]:32944 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbeH1OGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 10:06:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id DDDA41814A;
        Tue, 28 Aug 2018 12:14:13 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id tCvUjuVtkcov; Tue, 28 Aug 2018 12:14:13 +0200 (CEST)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id BC2591807C;
        Tue, 28 Aug 2018 12:14:12 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7DF21E07D;
        Tue, 28 Aug 2018 12:14:12 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 999101E07C;
        Tue, 28 Aug 2018 12:14:12 +0200 (CEST)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Tue, 28 Aug 2018 12:14:12 +0200 (CEST)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by seth.se.axis.com (Postfix) with ESMTP id 8D18B2147;
        Tue, 28 Aug 2018 12:14:12 +0200 (CEST)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id 850AE8016F; Tue, 28 Aug 2018 12:14:12 +0200 (CEST)
Date:   Tue, 28 Aug 2018 12:14:12 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv2] kmemleak: Add option to print warnings to dmesg
Message-ID: <20180828101412.mb7t562roqbhsbjw@axis.com>
References: <20180827083821.7706-1-vincent.whitchurch@axis.com>
 <20180827151641.59bdca4e1ea2e532b10cd9fd@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827151641.59bdca4e1ea2e532b10cd9fd@linux-foundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 03:16:41PM -0700, Andrew Morton wrote:
> On Mon, 27 Aug 2018 10:38:21 +0200 Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:
> 
> > Currently, kmemleak only prints the number of suspected leaks to dmesg
> > but requires the user to read a debugfs file to get the actual stack
> > traces of the objects' allocation points.  Add an option to print the
> > full object information to dmesg too.  This allows easier integration of
> > kmemleak into automated test systems since those kind of systems
> > presumably already save kernel logs.
> 
> "presumably" is a bit rubbery.  Are you sure this change is sufficienty
> useful to justify including it?  Do you have use-cases for it?

We (like every one else) have automated test infrastructure which test
our Linux systems.  With this option, running our tests with kmemleak is
as simple as enabling kmemleak and this option; the test infrastructure
knows how to save kernel logs, which will now include kmemleak reports.
Without this option, the test infrastructure needs to be specifically
taught to read out the kmemleak debugfs file.  Removing this need for
special handling makes kmemleak more similar to other kernel debug
options (slab debugging, debug objects, etc).

> 
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -593,6 +593,15 @@ config DEBUG_KMEMLEAK_DEFAULT_OFF
> >  	  Say Y here to disable kmemleak by default. It can then be enabled
> >  	  on the command line via kmemleak=on.
> >  
> > +config DEBUG_KMEMLEAK_WARN
> > +	bool "Print kmemleak object warnings to log buffer"
> > +	depends on DEBUG_KMEMLEAK
> > +	help
> > +	  Say Y here to make kmemleak print information about unreferenced
> > +	  objects (including stacktraces) as warnings to the kernel log buffer.
> > +	  Otherwise this information is only available by reading the kmemleak
> > +	  debugfs file.
> 
> Why add the config option?  Why not simply make the change for all
> configs?

No particular reason other than preserving the current behaviour for
existing users.  I can remove the config option if Catalin is fine with
it.

> 
> >  config DEBUG_STACK_USAGE
> >  	bool "Stack utilization instrumentation"
> >  	depends on DEBUG_KERNEL && !IA64
> > diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> > index 9a085d525bbc..22662715a3dc 100644
> > --- a/mm/kmemleak.c
> > +++ b/mm/kmemleak.c
> > @@ -181,6 +181,7 @@ struct kmemleak_object {
> >  /* flag set to not scan the object */
> >  #define OBJECT_NO_SCAN		(1 << 2)
> >  
> > +#define HEX_PREFIX		"    "
> >  /* number of bytes to print per line; must be 16 or 32 */
> >  #define HEX_ROW_SIZE		16
> >  /* number of bytes to print at a time (1, 2, 4, 8) */
> > @@ -299,6 +300,25 @@ static void kmemleak_disable(void);
> >  	kmemleak_disable();		\
> >  } while (0)
> >  
> > +#define warn_or_seq_printf(seq, fmt, ...)	do {	\
> > +	if (seq)					\
> > +		seq_printf(seq, fmt, ##__VA_ARGS__);	\
> > +	else						\
> > +		pr_warn(fmt, ##__VA_ARGS__);		\
> > +} while (0)
> > +
> > +static void warn_or_seq_hex_dump(struct seq_file *seq, int prefix_type,
> > +				 int rowsize, int groupsize, const void *buf,
> > +				 size_t len, bool ascii)
> > +{
> > +	if (seq)
> > +		seq_hex_dump(seq, HEX_PREFIX, prefix_type, rowsize, groupsize,
> > +			     buf, len, ascii);
> > +	else
> > +		print_hex_dump(KERN_WARNING, pr_fmt(HEX_PREFIX), prefix_type,
> > +			       rowsize, groupsize, buf, len, ascii);
> > +}
> 
> This will print to the logs OR to the debugfs file, won't it?

No, the information is always available in the debugfs file, even after
this patch.  The dmesg printing is in addition to that.  The code is
called with and without seq == NULL in different code paths.
