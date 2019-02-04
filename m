Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0FFC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C262070C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549276747;
	bh=A/kervOIv3wlFdBNCVyDnK5UW3IVep3QBRZeyydVXH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WS7ZQrH/WyVCPstoHvoAnSK811ETHtZlG0LcLbKKLJM5fWRMSEzu1T87c/Lp1KbxZ
	 pPS/FKp+uQHXl56WE0O+L6P99scfcqUu3MG1y2s7kyl6aLtDU7H4akEG5sgs58ZlzI
	 /WQ8s52+I0uAKLWr0jBH3fTFHGjP1D3vwkfgM4+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbfBDKjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:39:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:36838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729589AbfBDKjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:39:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 046272075B;
        Mon,  4 Feb 2019 10:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276742;
        bh=A/kervOIv3wlFdBNCVyDnK5UW3IVep3QBRZeyydVXH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tu8Y0fUe2jCGVJ9xS+QBvZEG7N5SMHtltvYdO4ZHigynJguk+/KM5SNWPYluaZ0of
         UDG927tnTTL/GPUAjhMGahSRaoZZfSB6UzkT7NML6uMRlR3t3/Nn8C+YgiBPmKVWJ0
         U+HxUIJG3oKQjdpbgnE8u6O2zcuuyAMWlLlkVqQI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 3.18 24/31] CIFS: Do not count -ENODATA as failure for query directory
Date:   Mon,  4 Feb 2019 11:36:39 +0100
Message-Id: <20190204103602.987708933@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103557.903263774@linuxfoundation.org>
References: <20190204103557.903263774@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Shilovsky <pshilov@microsoft.com>

commit 8e6e72aeceaaed5aeeb1cb43d3085de7ceb14f79 upstream.

Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2pdu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -2309,8 +2309,8 @@ SMB2_query_directory(const unsigned int
 		if (rc == -ENODATA && rsp->hdr.Status == STATUS_NO_MORE_FILES) {
 			srch_inf->endOfSearch = true;
 			rc = 0;
-		}
-		cifs_stats_fail_inc(tcon, SMB2_QUERY_DIRECTORY_HE);
+		} else
+			cifs_stats_fail_inc(tcon, SMB2_QUERY_DIRECTORY_HE);
 		goto qdir_exit;
 	}
 


