Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933022AbeBVPSf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:18:35 -0500
Received: from mga05.intel.com ([192.55.52.43]:10713 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932846AbeBVPST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:18:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,377,1515484800";
   d="scan'208";a="20015780"
From: Anna Karbownik <anna.karbownik@intel.com>
To: mchehab@kernel.org, bp@alien8.de, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: dan.carpenter@oracle.com, tony.luck@intel.com, jim.m.snow@intel.com,
        qiuxu.zhuo@intel.com, lukasz.odzioba@intel.com,
        krzysztof.paliswiat@intel.com, anna.karbownik@intel.com
Subject: [PATCH 1/1] EDAC, sb_edac: Fix out of bound write during DIMM configuration on KNL
Date: Thu, 22 Feb 2018 16:18:13 +0100
Message-Id: <1519312693-4789-1-git-send-email-anna.karbownik@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: akarbown <anna.karbownik@intel.com>

In one of the previous patches we decreased NUM_CHANNELS from 8 to 4, but
it is not enough for Knights Landing which supports up to 6 channels.

This caused unattended writes to pvt->mirror_mode and pvt->tolm variables
which don't pay critical role on KNL code path, so driver was somehow functional.

The easiest way of fixing it is to change NUM_CHANNELS to 6.
An alternative solution would be to restructure KNL part of the driver to
2MC/3channel representation.

Fixes: 3286d3eb906c ("EDAC, sb_edac: Drop NUM_CHANNELS from 8 back to 4")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Anna Karbownik <anna.karbownik@intel.com>
---
 drivers/edac/sb_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index f34430f..8721002 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -279,7 +279,7 @@ static inline int sad_pkg(const struct interleave_pkg *table, u32 reg,
  * sbridge structs
  */
 
-#define NUM_CHANNELS		4	/* Max channels per MC */
+#define NUM_CHANNELS		6	/* Max channels per MC */
 #define MAX_DIMMS		3	/* Max DIMMS per channel */
 #define KNL_MAX_CHAS		38	/* KNL max num. of Cache Home Agents */
 #define KNL_MAX_CHANNELS	6	/* KNL max num. of PCI channels */
-- 
1.8.3.1

--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.
