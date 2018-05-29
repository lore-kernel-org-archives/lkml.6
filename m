Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965775AbeE2Sy2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:54:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:9092 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965425AbeE2SyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:54:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,457,1520924400";
   d="scan'208";a="43736671"
Date: Tue, 29 May 2018 11:54:25 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@suse.de>
Cc: "Williams, Dan J" <dan.j.williams@intel.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3 V2] x86/mce: Fix incorrect "Machine check from
 unknown source" message
Message-ID: <20180529185425.GA4174@agluck-desk>
References: <cover.1527283897.git.tony.luck@intel.com>
 <52e049a497e86fd0b71c529651def8871c804df0.1527283897.git.tony.luck@intel.com>
 <20180528204923.GB30792@zn.tnic>
 <20180529161549.GB935@agluck-desk>
 <20180529174105.GF19870@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7D31E24F@ORSMSX110.amr.corp.intel.com>
 <20180529175313.GG19870@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529175313.GG19870@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 07:53:14PM +0200, Borislav Petkov wrote:
> Nah, the cleanups will all go ontop. This is just a dirty branch to show
> my intention but yours go first and then the cleanup.


Couple of thoughts:

In "x86/mce: Carve out bank scanning code" you drop the extra
call to mce_severity() that I just added:

@@ -1310,10 +1318,8 @@ void do_machine_check(struct pt_regs *regs, long error_code)
 		 * fatal error. We call "mce_severity()" again to
 		 * make sure we have the right "msg".
 		 */
-		if (worst >= MCE_PANIC_SEVERITY && mca_cfg.tolerant < 3) {
-			severity = mce_severity(&m, cfg->tolerant, &msg, true);
+		if (worst >= MCE_PANIC_SEVERITY && mca_cfg.tolerant < 3)
 			mce_panic("Local fatal machine check!", &m, msg);
-		}
 	}

But "msg" won't have been filled in with the right message to match
the error in "m" (__mc_scan_banks() doesn't update "msg").



In "x86/mce: Exit properly when no banks to poll" you
leap right to the end.  I'm wondering whether this can
ever happen? I mean, if there are no machine check banks,
then how did we get a machine check?

Both the original, and your new code, skip the:

	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);

which seems bad. That leaves MCG_STATUS.MCIP set ... so a second
machine check would just reset the machine.

-Tony

P.S. What happened to my "part 3/3" (updating the Skylake quirk)
... does that belong in somebody else's tree?
