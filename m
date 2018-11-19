Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBC4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7A12146D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v2WzWCcL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D7A12146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387749AbeKTDGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:06:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:40836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732796AbeKTDGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:06:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92E152086A;
        Mon, 19 Nov 2018 16:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645762;
        bh=4z2sZzJJx50sHVM58NtbSOixY6nHYALCmdP+MUDS4fY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v2WzWCcLnczGv47yuLQGl0bsHq4o06FD+iMRnyYh8xVDubJ5IjsDFd/Cz3brVW3bD
         zi00LuKR0KQgI95vYjzXnft+sXcoNhJfF+CJFR43apVNRbbRLsSRiy8S71i5g6MFAi
         DNBOG4MuhMVuJ0UiffwM5ib2zHsnkKoUmCfHgzsA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quinn Tran <quinn.tran@cavium.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.18 042/171] scsi: qla2xxx: shutdown chip if reset fail
Date:   Mon, 19 Nov 2018 17:27:18 +0100
Message-Id: <20181119162626.637910184@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <quinn.tran@cavium.com>

commit 1e4ac5d6fe0a4af17e4b6251b884485832bf75a3 upstream.

If chip unable to fully initialize, use full shutdown sequence to clear out
any stale FW state.

Fixes: e315cd28b9ef ("[SCSI] qla2xxx: Code changes for qla data structure refactoring")
Cc: stable@vger.kernel.org  #4.10
Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -6515,7 +6515,7 @@ qla2x00_abort_isp(scsi_qla_host_t *vha)
 					 * The next call disables the board
 					 * completely.
 					 */
-					ha->isp_ops->reset_adapter(vha);
+					qla2x00_abort_isp_cleanup(vha);
 					vha->flags.online = 0;
 					clear_bit(ISP_ABORT_RETRY,
 					    &vha->dpc_flags);


