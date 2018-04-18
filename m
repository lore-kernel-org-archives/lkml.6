Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbeDRROJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 13:14:09 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50114 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752077AbeDRROI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 13:14:08 -0400
Date: Wed, 18 Apr 2018 19:13:47 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/MCE, EDAC/mce_amd: Save all aux registers on SMCA
 systems
Message-ID: <20180418171347.GH4795@pd.tnic>
References: <20180402195707.42875-1-Yazen.Ghannam@amd.com>
 <20180417172102.GA3633@pd.tnic>
 <CY4PR12MB15574493593120818D9BFE11F8B70@CY4PR12MB1557.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CY4PR12MB15574493593120818D9BFE11F8B70@CY4PR12MB1557.namprd12.prod.outlook.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 06:30:34PM +0000, Ghannam, Yazen wrote:
> We could but it's an issue of documentation and testing the older systems.
> 
> My first pass at this was to unconditionally read the registers because my
> understanding was that registers that aren't accessible would be read-as-zero.
> I thought this was a common MCA implementation. But Tony pointed out that
> this isn't the case on Intel systems. This is the case on recent AMD systems. But
> I don't know if it's the case on older systems which may or may not have
> followed the Intel implementation more closely.

So if our worry is the #GPs, we can always use the rdmsr*_safe()
variants and look at the return value. And dump a invalid value like
0xdeadbeef or so, if the read failed.

But if any bit of info we've gotten this way, helps us debug an MCE,
we're already golden!

> For example,
> 
> Deferred error occurs:
> - MCA_{STATUS,ADDR,DESTAT,DEADDR} all have valid data.
> 
> MCE occurs
> - MCA_{STATUS,ADDR} are overwritten with non-zero data.
> - MCE handler clears MCA_STATUS. MCA_ADDR is non-zero.
> 
> DFR handler finds MCA_STATUS[Deferred] is clear, so it saves
> MCA_DESTAT and MCA_DEADDR which is 0.
> 
> If !m->addr (which has MCA_DEADDR), then we read MCA_STATUS
> which has the address from the MCE.

The code could use a shorter version of this as a comment to state why
we're doing it. Because it is not obvious.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
