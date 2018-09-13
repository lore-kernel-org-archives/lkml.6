Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC67EC61CF0
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B1C20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B1C20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731184AbeIMTEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:04:12 -0400
Received: from mga03.intel.com ([134.134.136.65]:6893 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728699AbeIMTEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:04:12 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2018 06:54:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,369,1531810800"; 
   d="scan'208";a="69710185"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.160.116])
  by fmsmga007.fm.intel.com with ESMTP; 13 Sep 2018 06:54:16 -0700
Date:   Thu, 13 Sep 2018 22:00:57 +0800
From:   Yu Chen <yu.c.chen@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rui Zhang <rui.zhang@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Zhimin Gu <kookoo.gu@intel.com>,
        Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/4][v2] PM / hibernate: Check the success of generating
 md5 digest before hibernation
Message-ID: <20180913140057.GB8155@chenyu-desktop>
References: <cover.1536685746.git.yu.c.chen@intel.com>
 <afb1c18493fa3fb891a37752161e9f73a46fc2df.1536685746.git.yu.c.chen@intel.com>
 <alpine.DEB.2.21.1809131024500.1473@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809131024500.1473@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,
On Thu, Sep 13, 2018 at 10:26:39AM +0200, Thomas Gleixner wrote:
> On Wed, 12 Sep 2018, Chen Yu wrote:
> >  static bool hibernation_e820_mismatch(void *buf)
> > @@ -306,6 +307,7 @@ static bool hibernation_e820_mismatch(void *buf)
> >  int arch_hibernation_header_save(void *addr, unsigned int max_size)
> >  {
> >  	struct restore_data_record *rdr = addr;
> > +	int ret = -EINVAL;
> 
> What's the point of initializing ret?
> 
> >  	if (max_size < sizeof(struct restore_data_record))
> >  		return -EOVERFLOW;
> > @@ -333,7 +335,9 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
> >  
> >  	rdr->magic = RESTORE_MAGIC;
> >  
> > -	hibernation_e820_save(rdr->e820_digest);
> > +	ret = hibernation_e820_save(rdr->e820_digest);
> > +	if (ret)
> > +		return ret;
> >  
> >  	return 0;
> 
> And what;s the point of ret at all?
> 
> 	return hibernation_e820_save();
> 
> is effectivly the same.
> 
ret is useless, will change to 'return hibernation_e820_save()' here.
Thanks,
Yu
> Thanks,
> 
> 	tglx
