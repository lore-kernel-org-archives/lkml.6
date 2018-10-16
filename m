Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D1FC5ACC9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534672089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/REjpon"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 534672089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbeJQBLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:11:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729271AbeJQBLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:11:33 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E8402089E;
        Tue, 16 Oct 2018 17:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710408;
        bh=rVb49w8mTFrRaevMqfIWVHbkuTSfXtsOaaV1DCLH6WM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g/REjponUVXIzsbSNZb0xQWj8udvS4kra4crRTtHxaOhtYF2BMcMLSgU5+2eUwLVc
         qbm3/62HGlKMI+9H5E5cpmy3EJtr8kgL226w05jN4K2K0L7aXub7sFQ/HDJ/wUWoNG
         ej6CZjmvIoBeEocN9rCiYvSNQLqA/vLikjUWN7cY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Farman <farman@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 4.14 067/109] s390/cio: Fix how vfio-ccw checks pinned pages
Date:   Tue, 16 Oct 2018 19:05:35 +0200
Message-Id: <20181016170528.477230719@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
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

From: Eric Farman <farman@linux.ibm.com>

commit 24abf2901b18bf941b9f21ea2ce5791f61097ae4 upstream.

We have two nested loops to check the entries within the pfn_array_table
arrays.  But we mistakenly use the outer array as an index in our check,
and completely ignore the indexing performed by the inner loop.

Cc: stable@vger.kernel.org
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Message-Id: <20181002010235.42483-1-farman@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/cio/vfio_ccw_cp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -172,7 +172,7 @@ static bool pfn_array_table_iova_pinned(
 
 	for (i = 0; i < pat->pat_nr; i++, pa++)
 		for (j = 0; j < pa->pa_nr; j++)
-			if (pa->pa_iova_pfn[i] == iova_pfn)
+			if (pa->pa_iova_pfn[j] == iova_pfn)
 				return true;
 
 	return false;


