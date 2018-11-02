Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC986C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760BF20848
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDTf23z/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 760BF20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbeKCEAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:00:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbeKCEAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:00:53 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B51CC20848;
        Fri,  2 Nov 2018 18:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184758;
        bh=/HbvoncNZ7Ls3FMHoJ0QbLAMfzjMcGeWbbnNMYWHz2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FDTf23z/t3YISKa0TpPh9DMky6tTHGHP16EJ1p0tciRKXzXilIvsf50nGJZ9tPPCQ
         emQT/pipXBjO2jJ9nnzfK3Szddx4nSoDw8kdp99quQE74YjsRIO1MBfdMEBxJPt50G
         OJOGoPxC2P8KMDVaW2wXGgFX+R/mGseQ+SXyURT0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Menion <menion@gmail.com>,
        Laurence Oberman <loberman@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 088/143] scsi: sd: Remember that READ CAPACITY(16) succeeded
Date:   Fri,  2 Nov 2018 19:34:33 +0100
Message-Id: <20181102182904.819410248@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 597d74005ba85e87c256cd732128ebf7faf54247 ]

The USB storage glue sets the try_rc_10_first flag in an attempt to
avoid wedging poorly implemented legacy USB devices.

If the device capacity is too large to be expressed in the provided
response buffer field of READ CAPACITY(10), a well-behaved device will
set the reported capacity to 0xFFFFFFFF. We will then attempt to issue a
READ CAPACITY(16) to obtain the real capacity.

Since this part of the discovery logic is not covered by the first_scan
flag, a warning will be printed a couple of times times per revalidate
attempt if we upgrade from READ CAPACITY(10) to READ CAPACITY(16).

Remember that we have successfully issued READ CAPACITY(16) so we can
take the fast path on subsequent revalidate attempts.

Reported-by: Menion <menion@gmail.com>
Reviewed-by: Laurence Oberman <loberman@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/sd.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -2498,6 +2498,8 @@ sd_read_capacity(struct scsi_disk *sdkp,
 				sector_size = old_sector_size;
 				goto got_data;
 			}
+			/* Remember that READ CAPACITY(16) succeeded */
+			sdp->try_rc_10_first = 0;
 		}
 	}
 


