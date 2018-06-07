Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id lY7vHHtIGVttSAAAmS7hNA
	; Thu, 07 Jun 2018 15:01:37 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F221B607E7; Thu,  7 Jun 2018 15:01:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D00A56074D;
	Thu,  7 Jun 2018 15:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D00A56074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935882AbeFGPBd (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:01:33 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41388 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934809AbeFGPB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:01:28 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbv-0005hJ-CS; Thu, 07 Jun 2018 15:09:55 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvaz-0002lV-S4; Thu, 07 Jun 2018 15:08:57 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "linux-edac" <linux-edac@vger.kernel.org>,
        "David Daney" <david.daney@cavium.com>, linux-mips@linux-mips.org,
        "James Hogan" <jhogan@kernel.org>, "Borislav Petkov" <bp@suse.de>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.280586232@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 067/410] EDAC, octeon: Fix an uninitialized variable
 warning
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <jhogan@kernel.org>

commit 544e92581a2ac44607d7cc602c6b54d18656f56d upstream.

Fix an uninitialized variable warning in the Octeon EDAC driver, as seen
in MIPS cavium_octeon_defconfig builds since v4.14 with Codescape GNU
Tools 2016.05-03:

  drivers/edac/octeon_edac-lmc.c In function ‘octeon_lmc_edac_poll_o2’:
  drivers/edac/octeon_edac-lmc.c:87:24: warning: ‘((long unsigned int*)&int_reg)[1]’ may \
    be used uninitialized in this function [-Wmaybe-uninitialized]
    if (int_reg.s.sec_err || int_reg.s.ded_err) {
                        ^
Iinitialise the whole int_reg variable to zero before the conditional
assignments in the error injection case.

Signed-off-by: James Hogan <jhogan@kernel.org>
Acked-by: David Daney <david.daney@cavium.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: linux-mips@linux-mips.org
Fixes: 1bc021e81565 ("EDAC: Octeon: Add error injection support")
Link: http://lkml.kernel.org/r/20171113161206.20990-1-james.hogan@mips.com
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/edac/octeon_edac-lmc.c | 1 +
 1 file changed, 1 insertion(+)

--- a/drivers/edac/octeon_edac-lmc.c
+++ b/drivers/edac/octeon_edac-lmc.c
@@ -79,6 +79,7 @@ static void octeon_lmc_edac_poll_o2(stru
 	if (!pvt->inject)
 		int_reg.u64 = cvmx_read_csr(CVMX_LMCX_INT(mci->mc_idx));
 	else {
+		int_reg.u64 = 0;
 		if (pvt->error_type == 1)
 			int_reg.s.sec_err = 1;
 		if (pvt->error_type == 2)
