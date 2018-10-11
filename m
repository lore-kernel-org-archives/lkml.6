Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7558DC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C5B20652
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lez1L5ed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C5B20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbeJKXGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:06:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbeJKXGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:06:48 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F261D20652;
        Thu, 11 Oct 2018 15:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272345;
        bh=E6jQoOm5wAwmLlbZOpf6uezWVlTnd4hDM20wqf+cTXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lez1L5edG3Q44CRkk5PwQVQVwZXHjrmuLwT8m4LBr0QQryGOt2ZNqhv0dQ4//amNr
         UQfm4akjRuN+rta01drqg9eBlKX7MRBsaE0d6bZoFx1k0fXH3Ui3n8W3ryalSbPsFY
         jsg0RDtA22sCL5mlNIGQ2fS3gh0SjbYBhZrH83M8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Kuhn <jkuhn@barracuda.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 077/120] fs/cifs: dont translate SFM_SLASH (U+F026) to backslash
Date:   Thu, 11 Oct 2018 17:34:18 +0200
Message-Id: <20181011152552.991175082@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jon Kuhn <jkuhn@barracuda.com>

[ Upstream commit c15e3f19a6d5c89b1209dc94b40e568177cb0921 ]

When a Mac client saves an item containing a backslash to a file server
the backslash is represented in the CIFS/SMB protocol as as U+F026.
Before this change, listing a directory containing an item with a
backslash in its name will return that item with the backslash
represented with a true backslash character (U+005C) because
convert_sfm_character mapped U+F026 to U+005C when interpretting the
CIFS/SMB protocol response.  However, attempting to open or stat the
path using a true backslash will result in an error because
convert_to_sfm_char does not map U+005C back to U+F026 causing the
CIFS/SMB request to be made with the backslash represented as U+005C.

This change simply prevents the U+F026 to U+005C conversion from
happenning.  This is analogous to how the code does not do any
translation of UNI_SLASH (U+F000).

Signed-off-by: Jon Kuhn <jkuhn@barracuda.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/cifs_unicode.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/fs/cifs/cifs_unicode.c
+++ b/fs/cifs/cifs_unicode.c
@@ -136,9 +136,6 @@ convert_sfm_char(const __u16 src_char, c
 	case SFM_LESSTHAN:
 		*target = '<';
 		break;
-	case SFM_SLASH:
-		*target = '\\';
-		break;
 	case SFM_SPACE:
 		*target = ' ';
 		break;


