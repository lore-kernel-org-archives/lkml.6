Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A75C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB2820879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUdakJUA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB2820879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbeLEJhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:37:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:40306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727976AbeLEJh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:37:29 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8D9720850;
        Wed,  5 Dec 2018 09:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002648;
        bh=CzIHmHTGwpsMWT1VDKf4sdRM57J5S0WCjdXI5uxDU9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rUdakJUAyRdZOkmGWjgB4HLmLl4yLlWSeg0vBz1jwaeSwAY4ddN88LdV+GsDKEDvu
         myLHuN72kEs1uPBgCqO6EWqdSfQ+pYvKvT9JE1EejZD2hFUgxM7d+OiZ4JhGc1bAij
         NDpjnKOh3uptBwh2G8+bKrtjtCXlUWYx0kFegMP4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Eric Farman <farman@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 026/123] s390/cio: Fix cleanup when unsupported IDA format is used
Date:   Wed,  5 Dec 2018 04:34:18 -0500
Message-Id: <20181205093555.5386-26-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Farman <farman@linux.ibm.com>

[ Upstream commit b89e242eee8d4cd8261d8d821c62c5d1efc454d0 ]

Direct returns from within a loop are rude, but it doesn't mean it gets
to avoid releasing the memory acquired beforehand.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
Message-Id: <20181109023937.96105-3-farman@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/cio/vfio_ccw_cp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index ef5ab45d94b3..70a006ba4d05 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -387,8 +387,10 @@ static int ccwchain_calc_length(u64 iova, struct channel_program *cp)
 		 * orb specified one of the unsupported formats, we defer
 		 * checking for IDAWs in unsupported formats to here.
 		 */
-		if ((!cp->orb.cmd.c64 || cp->orb.cmd.i2k) && ccw_is_idal(ccw))
+		if ((!cp->orb.cmd.c64 || cp->orb.cmd.i2k) && ccw_is_idal(ccw)) {
+			kfree(p);
 			return -EOPNOTSUPP;
+		}
 
 		if ((!ccw_is_chain(ccw)) && (!ccw_is_tic(ccw)))
 			break;
-- 
2.17.1

