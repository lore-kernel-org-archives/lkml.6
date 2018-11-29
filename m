Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9BFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32268205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNhq0wjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32268205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbeK3BWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:22:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:44058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728190AbeK3BWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:22:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AD1A21019;
        Thu, 29 Nov 2018 14:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501012;
        bh=6sp7bgyZ3Jd5R1lrU88yA7Ifhqti8H69YBWTD6z4SkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pNhq0wjFfagQUIesDpZOL6VFfTQqQJgnFLhIAX3dOWzLcuxN4XkL20mRtDs96+PTF
         6kdejRhC9t3ZhAcBod6bml+FbNV1Efh9YjmCsSjhQm9dxuPVZmI8d6xesuzF6Qk1lV
         x3wuNr+kgWCA8VXb/LFwnqalw+dnRJsaO8Afd2hg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 3.18 79/83] scsi: qla2xxx: do not queue commands when unloading
Date:   Thu, 29 Nov 2018 15:12:37 +0100
Message-Id: <20181129140142.551530931@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140138.002176596@linuxfoundation.org>
References: <20181129140138.002176596@linuxfoundation.org>
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

From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>

commit 04dfaa53a0b6e66b328a5bc549e3af8f8b6eac02 upstream.

When the driver is unloading, in qla2x00_remove_one(), there is a single
call/point in time to abort ongoing commands, qla2x00_abort_all_cmds(),
which is still several steps away from the call to scsi_remove_host().

If more commands continue to arrive and be processed during that
interval, when the driver is tearing down and releasing its structures,
it might potentially hit an oops due to invalid memory access:

    Unable to handle kernel paging request for data at address 0x00000138
    <...>
    NIP [d000000004700a40] qla2xxx_queuecommand+0x80/0x3f0 [qla2xxx]
    LR [d000000004700a10] qla2xxx_queuecommand+0x50/0x3f0 [qla2xxx]

So, fail commands in qla2xxx_queuecommand() if the UNLOADING bit is set.

Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Acked-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_os.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -687,6 +687,11 @@ qla2xxx_queuecommand(struct Scsi_Host *h
 	srb_t *sp;
 	int rval;
 
+	if (unlikely(test_bit(UNLOADING, &base_vha->dpc_flags))) {
+		cmd->result = DID_NO_CONNECT << 16;
+		goto qc24_fail_command;
+	}
+
 	if (ha->flags.eeh_busy) {
 		if (ha->flags.pci_channel_io_perm_failure) {
 			ql_dbg(ql_dbg_aer, vha, 0x9010,


