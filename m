Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751430AbeBWLJn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 06:09:43 -0500
Received: from mail.skyhub.de ([5.9.137.197]:35298 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750910AbeBWLJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 06:09:42 -0500
Date: Fri, 23 Feb 2018 12:09:24 +0100
From: Borislav Petkov <bp@alien8.de>
To: Anna Karbownik <anna.karbownik@intel.com>
Cc: mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.carpenter@oracle.com,
        tony.luck@intel.com, jim.m.snow@intel.com, qiuxu.zhuo@intel.com,
        lukasz.odzioba@intel.com, krzysztof.paliswiat@intel.com
Subject: Re: [PATCH 1/1] EDAC, sb_edac: Fix out of bound write during DIMM
 configuration on KNL
Message-ID: <20180223110924.GB4981@pd.tnic>
References: <1519312693-4789-1-git-send-email-anna.karbownik@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1519312693-4789-1-git-send-email-anna.karbownik@intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 04:18:13PM +0100, Anna Karbownik wrote:
> From: akarbown <anna.karbownik@intel.com>
> 
> In one of the previous patches we decreased NUM_CHANNELS from 8 to 4, but

We say which patch it was.

Anyway, corrected and applied the below, thanks.

---
From: Anna Karbownik <anna.karbownik@intel.com>
Date: Thu, 22 Feb 2018 16:18:13 +0100
Subject: [PATCH] EDAC, sb_edac: Fix out of bound writes during DIMM
 configuration on KNL

Commit

  3286d3eb906c ("EDAC, sb_edac: Drop NUM_CHANNELS from 8 back to 4")

decreased NUM_CHANNELS from 8 to 4, but this is not enough for Knights
Landing which supports up to 6 channels.

This caused out-of-bounds writes to pvt->mirror_mode and pvt->tolm
variables which don't pay critical role on KNL code path, so the memory
corruption wasn't causing any visible driver failures.

The easiest way of fixing it is to change NUM_CHANNELS to 6. Do that.

An alternative solution would be to restructure the KNL part of the
driver to 2MC/3channel representation.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Anna Karbownik <anna.karbownik@intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: jim.m.snow@intel.com
Cc: krzysztof.paliswiat@intel.com
Cc: lukasz.odzioba@intel.com
Cc: qiuxu.zhuo@intel.com
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: <stable@vger.kernel.org>
Fixes: 3286d3eb906c ("EDAC, sb_edac: Drop NUM_CHANNELS from 8 back to 4")
Link: http://lkml.kernel.org/r/1519312693-4789-1-git-send-email-anna.karbownik@intel.com
[ Massage commit message. ]
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/edac/sb_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index f34430f99fd8..872100215ca0 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -279,7 +279,7 @@ static const u32 correrrthrsld[] = {
  * sbridge structs
  */
 
-#define NUM_CHANNELS		4	/* Max channels per MC */
+#define NUM_CHANNELS		6	/* Max channels per MC */
 #define MAX_DIMMS		3	/* Max DIMMS per channel */
 #define KNL_MAX_CHAS		38	/* KNL max num. of Cache Home Agents */
 #define KNL_MAX_CHANNELS	6	/* KNL max num. of PCI channels */
-- 
2.13.0

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
