Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbeCZU2D (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 16:28:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:48326 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751150AbeCZU2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 16:28:01 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,365,1517904000";
   d="scan'208";a="214852188"
Date: Mon, 26 Mar 2018 13:27:56 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 2/2] x86/MCE: Always save MCA_{ADDR,MISC,SYND} register
 contents
Message-ID: <20180326202756.6qqqgjdjnx6ggng2@agluck-desk>
References: <20180326191526.64314-1-Yazen.Ghannam@amd.com>
 <20180326191526.64314-2-Yazen.Ghannam@amd.com>
 <20180326193526.GK25548@pd.tnic>
 <DM5PR12MB1916CB8536B257923AC76CA7F8AD0@DM5PR12MB1916.namprd12.prod.outlook.com>
 <20180326200955.GG28372@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180326200955.GG28372@pd.tnic>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 10:09:55PM +0200, Borislav Petkov wrote:
> On Mon, Mar 26, 2018 at 08:05:37PM +0000, Ghannam, Yazen wrote:
> > Sure, I can do that. But I didn't think it was necessary because it doesn't hurt
> > to read the registers whether or not the valid bits are set.
> 
> No, this needs to be AMD-specific because it will confuse people using
> Intel machines.

Worse than confusion it may even cause a crash on Intel. Quoting the
Intel SDM:

  15.3.2.3 IA32_MCi_ADDR MSRs

  The IA32_MCi_ADDR MSR contains the address of the code or data memory
  location that produced the machine- check error if the ADDRV flag in
  the IA32_MCi_STATUS register is set (see Section 15-7, “IA32_MCi_ADDR
  MSR”).  The IA32_MCi_ADDR register is either not implemented or
  contains no address if the ADDRV flag in the IA32_MCi_STATUS register
  is clear. When not implemented in the processor, all reads and writes
  to this MSR will cause a general protection exception.

Ditto for the MISC register.  Please don't read them unless
the ADDRV/MISCV bits are set in the corresponding STATUS
register.

Thanks

-Tony
