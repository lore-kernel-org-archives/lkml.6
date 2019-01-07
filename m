Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69843C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E87420859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864559;
	bh=GxRqCTkHQ1OeMbR4nuuXhqIClCNiFebthZZ9DA6OSNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P++uroHzgsmeD+7/AkIec/4yURRDAsVT396E3iASTBD01VxRMBcE4OFs0P5JIU1Vz
	 ispST6DkwGSvDxRC7y6ajpByPg2ZS6koNfkzoWnUd8Io7u31bh8hailvVXIroYxP54
	 vXgULX2us6IncEMSOhKauFDbfQtxMGfa8JHGHFFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfAGMf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:35:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:50332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbfAGMfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:35:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7294D218AD;
        Mon,  7 Jan 2019 12:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864555;
        bh=GxRqCTkHQ1OeMbR4nuuXhqIClCNiFebthZZ9DA6OSNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=osqWPGTqPT6UyOphknijjeciZp5Yyj2JqMNZ5bdill7h2AxeJPeJGn26FxSlvvHXc
         2bxoiGrTx/GzOkxd58hL5OG6RzBNZOkWIFdn8nqCXnNcLN6hDFTi11slXPyXaKdGx4
         LHFZ8rjqp2KeN7JjMALWjSbakvABkqdr6XZ39d8A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.20 048/145] staging: bcm2835-audio: double free in init error path
Date:   Mon,  7 Jan 2019 13:31:25 +0100
Message-Id: <20190107104443.713804379@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 649496b603000135683ee76d7ea499456617bf17 upstream.

We free instance here and in the caller.  It should be only the caller
which handles it.

Fixes: d7ca3a71545b ("staging: bcm2835-audio: Operate non-atomic PCM ops")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -143,7 +143,6 @@ vc_vchi_audio_init(VCHI_INSTANCE_T vchi_
 		dev_err(instance->dev,
 			"failed to open VCHI service connection (status=%d)\n",
 			status);
-		kfree(instance);
 		return -EPERM;
 	}
 


