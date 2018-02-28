Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752460AbeB1K3L (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:29:11 -0500
Received: from mga14.intel.com ([192.55.52.115]:4534 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752150AbeB1K3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:29:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,405,1515484800";
   d="scan'208";a="204352977"
Message-ID: <1519813744.10722.258.camel@linux.intel.com>
Subject: Re: [PATCH v1 2/4] x86/pci: Re-use new dmi_get_bios_year() helper
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jean Delvare <jdelvare@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Date: Wed, 28 Feb 2018 12:29:04 +0200
In-Reply-To: <20180226172832.7bf82336@endymion>
References: <20180222125923.57385-1-andriy.shevchenko@linux.intel.com>
         <20180222125923.57385-2-andriy.shevchenko@linux.intel.com>
         <20180226172832.7bf82336@endymion>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-02-26 at 17:28 +0100, Jean Delvare wrote:

> > -	if (dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL) && year
> > < 2008) {
> > -		if (iomem_resource.end <= 0xffffffff)
> > -			pci_use_crs = false;
> > -	}
> > +	if ((dmi_get_bios_year() < 2008) && (iomem_resource.end <=
> > 0xffffffff))
> > +		pci_use_crs = false;
> 
> You are changing the behavior here, when DMI does not provide a BIOS
> date. Beforehand, the test would fail and pci_use_crs would be left
> alone. After your change, dmi_get_bios_year() will return 0, and
> "0 < 2008" is true, so pci_use_crs is set to false.

Hmm... Indeed.

> I have no opinion on what this driver should do in such case,

I would assume that no BIOS date is related to prehistoric firmwares and
 using _CRS would sound weird on them.

>  but I
> certainly wouldn't expect a change of behavior from a "use a helper
> instead of open-coding" kind of patch.

Agree.

> I don't think you can safely assume that the code calling
> dmi_get_bios_year() will always do the right thing when 0 is being
> returned. It's up to the calling code to decide what the default
> behavior should be.

That's correct.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
