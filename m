Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id cw4iOpI/GVtTXAAAmS7hNA
	; Thu, 07 Jun 2018 14:22:11 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DDEDD608BF; Thu,  7 Jun 2018 14:22:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 559DF6063F;
	Thu,  7 Jun 2018 14:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 559DF6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933624AbeFGOWI (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:22:08 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39429 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933068AbeFGOJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:10 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbA-0005Zo-Ju; Thu, 07 Jun 2018 15:09:08 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb7-00032y-83; Thu, 07 Jun 2018 15:09:05 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        syzbot+f7b556d1766502a69d85071d2ff08bd87be53d0f@syzkaller.appspotmail.com,
        "Eric Biggers" <ebiggers@google.com>, "Tejun Heo" <tj@kernel.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.992094030@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 229/410] libata: remove WARN() for DMA or PIO command
 without data
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

From: Eric Biggers <ebiggers@google.com>

commit 9173e5e80729c8434b8d27531527c5245f4a5594 upstream.

syzkaller hit a WARN() in ata_qc_issue() when writing to /dev/sg0.  This
happened because it issued a READ_6 command with no data buffer.

Just remove the WARN(), as it doesn't appear indicate a kernel bug.  The
expected behavior is to fail the command, which the code does.

Here's a reproducer that works in QEMU when /dev/sg0 refers to a disk of
the default type ("82371SB PIIX3 IDE"):

    #include <fcntl.h>
    #include <unistd.h>

    int main()
    {
            char buf[42] = { [36] = 0x8 /* READ_6 */ };

            write(open("/dev/sg0", O_RDWR), buf, sizeof(buf));
    }

Fixes: f92a26365a72 ("libata: change ATA_QCFLAG_DMAMAP semantics")
Reported-by: syzbot+f7b556d1766502a69d85071d2ff08bd87be53d0f@syzkaller.appspotmail.com
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/ata/libata-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5139,8 +5139,7 @@ void ata_qc_issue(struct ata_queued_cmd
 	 * We guarantee to LLDs that they will have at least one
 	 * non-zero sg if the command is a data command.
 	 */
-	if (WARN_ON_ONCE(ata_is_data(prot) &&
-			 (!qc->sg || !qc->n_elem || !qc->nbytes)))
+	if (ata_is_data(prot) && (!qc->sg || !qc->n_elem || !qc->nbytes))
 		goto sys_err;
 
 	if (ata_is_dma(prot) || (ata_is_pio(prot) &&
