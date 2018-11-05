Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663E6C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2481F2081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2481F2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbeKEWww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:52:52 -0500
Received: from mga09.intel.com ([134.134.136.24]:11610 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbeKEWww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:52:52 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 05:33:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,468,1534834800"; 
   d="scan'208";a="97736864"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga003.jf.intel.com with ESMTP; 05 Nov 2018 05:33:02 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gJf01-0005RK-Cb; Mon, 05 Nov 2018 15:33:01 +0200
Date:   Mon, 5 Nov 2018 15:33:01 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI / PMIC: xpower: fix IOSF_MBI dependency
Message-ID: <20181105133301.GE10650@smile.fi.intel.com>
References: <20181102110653.118257-1-arnd@arndb.de>
 <20181102151644.GB10650@smile.fi.intel.com>
 <CAK8P3a2ESTVLG3q0LgDmjqa_LbYhLCeqYW3Jod6WUCh2fwFOZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2ESTVLG3q0LgDmjqa_LbYhLCeqYW3Jod6WUCh2fwFOZg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 11:07:34PM +0100, Arnd Bergmann wrote:
> On 11/2/18, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Nov 02, 2018 at 12:06:43PM +0100, Arnd Bergmann wrote:

> >> -	depends on MFD_AXP20X_I2C && IOSF_MBI
> >> +	depends on MFD_AXP20X_I2C && IOSF_MBI=y
> >
> > To me sounds like
> >
> > select IOSF_MBI would be more appropriate here.
> 
> It looks like we have a mix of the two two, with most drivers
> using 'select' and only a few ones using 'depends on'. Mixing
> the two often leads to trouble, especially for user-visible
> symbols.
> 
> Making it a hidden symbol that is always selected is probably
> fine, but then every driver selecting it must also use 'depends
> on X86 && PCI'.

I doubt every is a correct word here. Whenever driver uses IOSF_MBI it implies
X86 and PCI (or should have those dependencies in mind already).

But I agree that hide it and select as a library would make more sense than the
current state of affairs.

-- 
With Best Regards,
Andy Shevchenko


