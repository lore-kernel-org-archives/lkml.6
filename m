Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752150AbeEKQaT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 12:30:19 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58666 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750950AbeEKQaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 12:30:17 -0400
Date: Fri, 11 May 2018 18:29:51 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Alex G." <mr.nuke.me@gmail.com>
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Tyler Baicar <tbaicar@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        devel@acpica.org
Subject: Re: [RFC PATCH v4 3/3] acpi: apei: Do not panic() on PCIe errors
 reported through GHES
Message-ID: <20180511162951.GH12705@pd.tnic>
References: <20180430212836.7807-1-mr.nuke.me@gmail.com>
 <20180430213358.8319-1-mr.nuke.me@gmail.com>
 <20180430213358.8319-3-mr.nuke.me@gmail.com>
 <20180511154039.GD12705@pd.tnic>
 <8e3c0cc6-9c5c-85ce-650c-8f498f5907da@gmail.com>
 <20180511160253.GF12705@pd.tnic>
 <45b7be09-c9b3-8006-6ea0-36b4ff38607c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <45b7be09-c9b3-8006-6ea0-36b4ff38607c@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 11:12:25AM -0500, Alex G. wrote:
> > I think *you* didn't get it: IS_ENABLED(CONFIG_ACPI_APEI_PCIEAER) is not
> > enough of a check to confirm that there actually *is* an AER driver to
> > handle the errors. If you really want to make sure the driver is loaded
> > and functioning, then you need an explicit registering mechanism or some
> > other way of checking it really is there and handling errors.
> 
> config ACPI_APEI_PCIEAER
> 	bool "APEI PCIe AER logging/recovering support"
> 	depends on ACPI_APEI && PCIEAER
> 	help
> 	  PCIe AER errors may be reported via APEI firmware first mode.
> 	  Turn on this option to enable the corresponding support.
> 
> PCIAER is not modularizable. QED

QED my ass.

Read the f*ck my email again: the presence of the *code* is
not enough of a check to confirm the error has been handled.
aer_recover_work_func() can fail as that kfifo_put() in
aer_recover_queue() can too.

You need an *actual* confirmation that the error has been handled
properly and *only* *then* not panic the system. Otherwise you are
potentially leaving those errors unhandled.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
