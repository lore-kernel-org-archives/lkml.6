Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE7BC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D672146F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789037;
	bh=8t18uHIhbkGwalwcRwG5B2TS9Of+Sa4dj1V2ZYDv6GQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SR5BEwCAZ6dFwci2Kpp6F64mVS451w9ASolRSseJ0MGzI0QjF5Thnayml1F/Pjuta
	 hWFh9hahOxaEzrA7drBYFoqkZfa7DRCkEiNt3ilsKnHIFwaPRsnTDjgwEf1xXa0jvU
	 ZKEE4IPs2U34u8vZAzDTzx1MedImPo1z6EWuFjzY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D672146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbeLNMD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:03:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:48152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730389AbeLNMDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:03:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C74432147C;
        Fri, 14 Dec 2018 12:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789032;
        bh=8t18uHIhbkGwalwcRwG5B2TS9Of+Sa4dj1V2ZYDv6GQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bXKVpB8rjTwut7Y6dbdtOGD+5g8rMfPuQAz4G1zg4bf44eg8WQ3JNwx4fAq81RLFN
         cNEimrc37OoMKzW3u9IgP6EBslFg6HL+x/bmnmIslMm+0h5f3+Imq3buJJjGcOI9MK
         WKksFli/KE+qOQCyM1em+0Mhivaf0hy7nGwHJg/s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Farman <farman@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 045/142] s390/cio: Fix cleanup when unsupported IDA format is used
Date:   Fri, 14 Dec 2018 12:58:50 +0100
Message-Id: <20181214115748.853361435@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
2.19.1



