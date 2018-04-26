Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755640AbeDZLUY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:20:24 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43860 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754743AbeDZLUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:20:21 -0400
Date: Thu, 26 Apr 2018 13:19:46 +0200
From: Borislav Petkov <bp@alien8.de>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Tyler Baicar <tbaicar@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>, linux-kernel@vger.kernel.org,
        devel@acpica.org
Subject: Re: [RFC PATCH v3 2/3] acpi: apei: Do not panic() on PCIe errors
 reported through GHES
Message-ID: <20180426111946.GA15009@pd.tnic>
References: <20180416215903.7318-1-mr.nuke.me@gmail.com>
 <20180425203957.18224-1-mr.nuke.me@gmail.com>
 <20180425203957.18224-3-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180425203957.18224-3-mr.nuke.me@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 03:39:50PM -0500, Alexandru Gagniuc wrote:
> @@ -932,7 +971,7 @@ static void __process_error(struct ghes *ghes)
>  static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
>  {
>  	struct ghes *ghes;
> -	int sev, ret = NMI_DONE;
> +	int sev, asev, ret = NMI_DONE;
>  
>  	if (!atomic_add_unless(&ghes_in_nmi, 1, 1))
>  		return ret;
> @@ -945,8 +984,9 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
>  			ret = NMI_HANDLED;
>  		}
>  
> +		asev = ghes_actual_severity(ghes);
>  		sev = ghes_severity(ghes->estatus->error_severity);

So renaming ghes_deferrable_severity() to ghes_actual_severity() is not
a big change. And that's not what I meant.

I'd like to see here:

		 sev = ghes_severity(ghes);

and inside you do all the required mapping/severity processing/etc. And
you can rename the current ghes_severity() to ghes_map_cper_severity()
or whatever...

> -		if (sev >= GHES_SEV_PANIC) {
> +		if ((sev >= GHES_SEV_PANIC) && (asev >= GHES_SEV_PANIC)) {

... so that this change doesn't happen and there are not two severities
queried but a single one.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
