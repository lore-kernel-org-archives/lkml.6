Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF51C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97492217F9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549276986;
	bh=l01eCw/J+T4/yWaOANNsZ3DXdwrynzpwYDfGv9nWbk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LA9Z8IHdxSdRDbc1TOWL/IW8ZIUW3HHL0NnpVcCneF63hH/l25SEtJUfjLTl5K/OB
	 +FipAC6B60pN/ZEC2m4TljjJaBjUmmKbuVhZVTlompqxYfIoKHCF7gf/PS1jq7GAwz
	 1ub/bjFcNsH2N7BOSkmesUXE3tvqB0ATNMoMN15g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbfBDKnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:43:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:40904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730645AbfBDKnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:43:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91BC4217F9;
        Mon,  4 Feb 2019 10:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276980;
        bh=l01eCw/J+T4/yWaOANNsZ3DXdwrynzpwYDfGv9nWbk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DEb7hp0E5XwXhEy+1Iwvqb2n7G7LOY2DkaW0U9GBwbFRG7iFQ49E9zhivDuBADOwg
         itnZzo3P4To8Zh5z+MCLXK3rrbaydwvCiRbZRdhF4isW7//0onCW//+RUesS199FeC
         o5tK2Kr2b4HlyWClREWVGt785HKvSJsyOE14/NJg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.9 13/30] CIFS: Do not count -ENODATA as failure for query directory
Date:   Mon,  4 Feb 2019 11:36:51 +0100
Message-Id: <20190204103607.695986164@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103605.271746870@linuxfoundation.org>
References: <20190204103605.271746870@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2686,8 +2686,8 @@ SMB2_query_directory(const unsigned int
 		if (rc == -ENODATA && rsp->hdr.Status == STATUS_NO_MORE_FILES) {
 			srch_inf->endOfSearch = true;
 			rc = 0;
-		}
-		cifs_stats_fail_inc(tcon, SMB2_QUERY_DIRECTORY_HE);
+		} else
+			cifs_stats_fail_inc(tcon, SMB2_QUERY_DIRECTORY_HE);
 		goto qdir_exit;
 	}
 


