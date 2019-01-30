Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A7BC282D9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A1BD21473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbfA3NmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:42:22 -0500
Received: from mga04.intel.com ([192.55.52.120]:23257 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfA3NmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:42:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2019 05:42:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,540,1539673200"; 
   d="scan'208";a="140090226"
Received: from wchen25-mobl9.ccr.corp.intel.com ([10.249.173.109])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jan 2019 05:42:20 -0800
Message-ID: <1548855738.2161.5.camel@intel.com>
Subject: Re: [PATCH] thermal/intel_powerclamp: fix __percpu declaration of
 worker_data
From:   Zhang Rui <rui.zhang@intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 30 Jan 2019 21:42:18 +0800
In-Reply-To: <1548855476.2161.2.camel@intel.com>
References: <20190119161523.87999-1-luc.vanoostenryck@gmail.com>
         <20190130095917.7uxdxrjvtaeydcol@pathway.suse.cz>
         <1548855476.2161.2.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 三, 2019-01-30 at 21:37 +0800, Zhang Rui wrote:
> On 三, 2019-01-30 at 10:59 +0100, Petr Mladek wrote:
> > 
> > On Sat 2019-01-19 17:15:23, Luc Van Oostenryck wrote:
> > > 
> > > 
> > > This variable is declared as:
> > > 	static struct powerclamp_worker_data * __percpu worker_data;
> > > In other words, a percpu pointer to struct ...
> > > 
> > > But this variable not used like so but as a pointer to a percpu
> > > struct powerclamp_worker_data.
> > > 
> > > So fix the declaration as:
> > > 	static struct powerclamp_worker_data __percpu *worker_data;
> > > 
> > > This also quiets Sparse's warnings from __verify_pcpu_ptr(),
> > > like:
> > >   494:49: warning: incorrect type in initializer (different
> > > address
> > > spaces)
> > >   494:49:    expected void const [noderef] <asn:3> *__vpp_verify
> > >   494:49:    got struct powerclamp_worker_data *
> > > 
> > > Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> > > ---
> > >  drivers/thermal/intel/intel_powerclamp.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/thermal/intel/intel_powerclamp.c
> > > b/drivers/thermal/intel/intel_powerclamp.c
> > > index 7571f7c2e..c7cba20bd 100644
> > > --- a/drivers/thermal/intel/intel_powerclamp.c
> > > +++ b/drivers/thermal/intel/intel_powerclamp.c
> > > @@ -101,7 +101,7 @@ struct powerclamp_worker_data {
> > >  	bool clamping;
> > >  };
> > >  
> > > -static struct powerclamp_worker_data * __percpu worker_data;
> > > +static struct powerclamp_worker_data __percpu * worker_data;
> > Makes perfect sense. I wonder why I wrote it in the wrong order.
> > 
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > 
> applied and queued for next -rc.
> 
well, just with a minor change to get rid of checkpatch warning.

ERROR: "foo * bar" should be "foo *bar"
#121: FILE: drivers/thermal/intel/intel_powerclamp.c:104:
+static struct powerclamp_worker_data __percpu * worker_data;

total: 1 errors, 0 warnings, 8 lines checked

thanks,
rui
> thanks,
> rui
> 
> > 
> > Best Regards,
> > Petr
