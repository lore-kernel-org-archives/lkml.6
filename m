Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86722C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B52C20652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B52C20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966625AbeFSPL7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:11:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:21841 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966193AbeFSPL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:11:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2018 08:11:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,243,1526367600"; 
   d="scan'208";a="233823556"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga005.jf.intel.com with ESMTP; 19 Jun 2018 08:11:57 -0700
Date:   Tue, 19 Jun 2018 08:11:32 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 5/8] x86/umwait.c: Add sysfs interface to show tsc_khz
Message-ID: <20180619151131.GA112652@romley-ivt3.sc.intel.com>
References: <1529118375-90191-1-git-send-email-fenghua.yu@intel.com>
 <1529118375-90191-6-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1806191104070.1692@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806191104070.1692@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 11:08:46AM +0200, Thomas Gleixner wrote:
> On Fri, 15 Jun 2018, Fenghua Yu wrote:
>  
> > +static ssize_t tsc_khz_show(struct device *dev, struct device_attribute *attr,
> > +			    char *buf)
> > +{
> > +	return sprintf(buf, "%d\n", tsc_khz);
> > +}
> > +
> >  static DEVICE_ATTR_RW(umwait_disable_c0_2);
> > +static DEVICE_ATTR_RO(tsc_khz);
> 
> The right place to expose that information is the VDSO and a helper
> function which allows to convert from nsec to TSC.

Sure. I will do that.

> 
> >  static struct attribute *umwait_attrs[] = {
> >  	&dev_attr_umwait_disable_c0_2.attr,
> > @@ -92,6 +100,15 @@ static int __init umwait_init(void)
> >  	if (ret)
> >  		return ret;
> >  
> > +	/* Only add the tsc_khz interface when the value is known. */
> 
> Why so? The only reason why you don't want to expose TSC frequency is when
> it's not constant frequency.

> > +	if (boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)) {
> 

Thanks.

-Fenghua
