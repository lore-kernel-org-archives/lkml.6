Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32150C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03BD42087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277280;
	bh=VMEEJBZ7xBti8XqAUsUV+drPEGEYCyaKU3pOcLTN+0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MMx8wI+03hnVwd6zsYaa5zOwthMP9BESCtvoEIscQ59i9Swu3lD/28O4LtoAlQYoE
	 SWKIO+6BnrOK3NIjvV79PfMjr0r4RBmWU28UMVH4tHuMQkQrWxcHNJlsB5DoKoadQH
	 krG6YvyZ3DAB1VFTuUOYGa05n5zO1U0Y/ny27y2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731733AbfBDKr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:47:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:46066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729719AbfBDKrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:47:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB6082070C;
        Mon,  4 Feb 2019 10:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277275;
        bh=VMEEJBZ7xBti8XqAUsUV+drPEGEYCyaKU3pOcLTN+0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FQ30iksEYQMrvxPVP1N5rTra9tWgms9HsOUOM6LTdmCY5NamUcm/towbcb2+w+I4t
         xOJlEI3ojMChFVkYGAS4Bsf7JIM2c3wozPWDDOPfL70hkTGMUWzwlY3eDWBazumxQJ
         QF3WBoddfg8HGywRw4cCi1Lia/SwkL+iX/slmJk0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.19 33/74] CIFS: Do not count -ENODATA as failure for query directory
Date:   Mon,  4 Feb 2019 11:36:46 +0100
Message-Id: <20190204103623.677342302@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103619.714714157@linuxfoundation.org>
References: <20190204103619.714714157@linuxfoundation.org>
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
@@ -3714,8 +3714,8 @@ SMB2_query_directory(const unsigned int
 		    rsp->sync_hdr.Status == STATUS_NO_MORE_FILES) {
 			srch_inf->endOfSearch = true;
 			rc = 0;
-		}
-		cifs_stats_fail_inc(tcon, SMB2_QUERY_DIRECTORY_HE);
+		} else
+			cifs_stats_fail_inc(tcon, SMB2_QUERY_DIRECTORY_HE);
 		goto qdir_exit;
 	}
 


