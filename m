Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1679C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC29520989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbfA3NiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:38:00 -0500
Received: from mga09.intel.com ([134.134.136.24]:61845 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfA3Nh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:37:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2019 05:37:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,540,1539673200"; 
   d="scan'208";a="112319069"
Received: from wchen25-mobl9.ccr.corp.intel.com ([10.249.173.109])
  by orsmga006.jf.intel.com with ESMTP; 30 Jan 2019 05:37:57 -0800
Message-ID: <1548855476.2161.2.camel@intel.com>
Subject: Re: [PATCH] thermal/intel_powerclamp: fix __percpu declaration of
 worker_data
From:   Zhang Rui <rui.zhang@intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 30 Jan 2019 21:37:56 +0800
In-Reply-To: <20190130095917.7uxdxrjvtaeydcol@pathway.suse.cz>
References: <20190119161523.87999-1-luc.vanoostenryck@gmail.com>
         <20190130095917.7uxdxrjvtaeydcol@pathway.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 三, 2019-01-30 at 10:59 +0100, Petr Mladek wrote:
> On Sat 2019-01-19 17:15:23, Luc Van Oostenryck wrote:
> > 
> > This variable is declared as:
> > 	static struct powerclamp_worker_data * __percpu worker_data;
> > In other words, a percpu pointer to struct ...
> > 
> > But this variable not used like so but as a pointer to a percpu
> > struct powerclamp_worker_data.
> > 
> > So fix the declaration as:
> > 	static struct powerclamp_worker_data __percpu *worker_data;
> > 
> > This also quiets Sparse's warnings from __verify_pcpu_ptr(), like:
> >   494:49: warning: incorrect type in initializer (different address
> > spaces)
> >   494:49:    expected void const [noderef] <asn:3> *__vpp_verify
> >   494:49:    got struct powerclamp_worker_data *
> > 
> > Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> > ---
> >  drivers/thermal/intel/intel_powerclamp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/thermal/intel/intel_powerclamp.c
> > b/drivers/thermal/intel/intel_powerclamp.c
> > index 7571f7c2e..c7cba20bd 100644
> > --- a/drivers/thermal/intel/intel_powerclamp.c
> > +++ b/drivers/thermal/intel/intel_powerclamp.c
> > @@ -101,7 +101,7 @@ struct powerclamp_worker_data {
> >  	bool clamping;
> >  };
> >  
> > -static struct powerclamp_worker_data * __percpu worker_data;
> > +static struct powerclamp_worker_data __percpu * worker_data;
> Makes perfect sense. I wonder why I wrote it in the wrong order.
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
applied and queued for next -rc.

thanks,
rui

> Best Regards,
> Petr
