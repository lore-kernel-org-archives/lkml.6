Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E9AC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 01:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4BA120811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 01:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4BA120811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbeLLBtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 20:49:24 -0500
Received: from mga09.intel.com ([134.134.136.24]:37150 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbeLLBtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 20:49:24 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2018 17:49:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,343,1539673200"; 
   d="scan'208";a="117869477"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.160.132])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Dec 2018 17:49:22 -0800
Date:   Wed, 12 Dec 2018 09:56:57 +0800
From:   Yu Chen <yu.c.chen@intel.com>
To:     joeyli <jlee@suse.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Rui Zhang <rui.zhang@intel.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH][RFC v2] ACPI: acpi_pad: Do not launch acpi_pad threads
 on idle cpus
Message-ID: <20181212015656.GA25427@chenyu-desktop>
References: <1525521202-32519-1-git-send-email-yu.c.chen@intel.com>
 <20181210063153.GO5327@linux-l9pv.suse>
 <20181211031220.GA23975@chenyu-desktop>
 <20181211083754.GE28555@linux-l9pv.suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211083754.GE28555@linux-l9pv.suse>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Tue, Dec 11, 2018 at 04:37:54PM +0800, joeyli wrote:
> Hi Yu Chen,
> 
> Thanks for your response!
> 
> On Tue, Dec 11, 2018 at 11:12:21AM +0800, Yu Chen wrote:
> > Hi Joey,
> > On Mon, Dec 10, 2018 at 02:31:53PM +0800, joeyli wrote:
> > > Hi Chen Yu and ACPI experts,
> > > 
> > > On Sat, May 05, 2018 at 07:53:22PM +0800, Chen Yu wrote:
> > > > According to current implementation of acpi_pad driver,
> > > > it does not make sense to spawn any power saving threads
> > > > on the cpus which are already idle - it might bring
> > > > unnecessary overhead on these idle cpus and causes power
> > > > waste. So verify the condition that if the number of 'busy'
> > > > cpus exceeds the amount of the 'forced idle' cpus is met.
> > > > This is applicable due to round-robin attribute of the
> > > > power saving threads, otherwise ignore the setting/ACPI
> > > > notification.
> > > > 
> > > > Suggested-by: Lenny Szubowicz <lszubowi@redhat.com>
> > > > Suggested-by: Len Brown <lenb@kernel.org>
> > > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > > Cc: Lenny Szubowicz <lszubowi@redhat.com>
> > > > Cc: Len Brown <lenb@kernel.org>
> > > > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > Cc: Rui Zhang <rui.zhang@intel.com>
> > > > Cc: linux-acpi@vger.kernel.org
> > > > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > > 
> > > Do you have any news for this patch? Why it did not merged by kernel
> > > maineline?
> > > 
> > We are evaluating if this could be integrated into idle injection framework.
> > May I know if there's any requirement/background from SUSE on this?
> > 
> 
> I am also looking at your patch and idle injection framework. Currently I do not
> have good suggestion for your patches yet. But I will try to ready my knowledge when
> you send out new version.
>
Thanks. I mean, does SUSE get report from customers who encountered this issue?
BTW, may I know the status of the encryption hibernation please?(Usin the TPM?)

Best,
Yu(Ryan)
> Thanks a lot!
> Joey Lee 
