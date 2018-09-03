Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7A2C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B3820658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B3820658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731870AbeICV7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:59:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49010 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbeICV7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:59:54 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 62A72A95;
        Mon,  3 Sep 2018 17:38:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH 4.18 104/123] tpm: Return the actual size when receiving an unsupported command
Date:   Mon,  3 Sep 2018 18:57:28 +0200
Message-Id: <20180903165723.925085589@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>

commit 36a11029b07ee30bdc4553274d0efea645ed9d91 upstream.

The userpace expects to read the number of bytes stated in the header.
Returning the size of the buffer instead would be unexpected.

Cc: stable@vger.kernel.org
Fixes: 095531f891e6 ("tpm: return a TPM_RC_COMMAND_CODE response if command is not implemented")
Signed-off-by: Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/tpm/tpm-interface.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -423,7 +423,7 @@ static ssize_t tpm_try_transmit(struct t
 		header->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
 		header->return_code = cpu_to_be32(TPM2_RC_COMMAND_CODE |
 						  TSS2_RESMGR_TPM_RC_LAYER);
-		return bufsiz;
+		return sizeof(*header);
 	}
 
 	if (bufsiz > TPM_BUFSIZE)


