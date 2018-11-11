Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55BFC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB6F20839
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIWJ8XMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB6F20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732987AbeKLJpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:45:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:37238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732619AbeKLIST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:19 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDCEB215EA;
        Sun, 11 Nov 2018 22:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975303;
        bh=OxqoB3U0UqRa9EepOiuIIJg50XpkAyFB1Vz90F3aV+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FIWJ8XMUUELe1sewVNaMjsVQUeGuWlw/ZNaWKjSdckDTI2b04LFwugVq7/0jaCvYy
         XtVBGe207a3AmgKvpSjFwRd8CFn6go9Vhz2N8QhenZxR484T7vCtc9N6L6ipzibbBW
         FMpc027YDXMMN41ZDYukLYxwU1XdbMySmz9U3XPg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH 4.19 268/361] tpm: fix response size validation in tpm_get_random()
Date:   Sun, 11 Nov 2018 14:20:15 -0800
Message-Id: <20181111221654.813027669@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

commit 84b59f6487d82d3ab4247a099aba66d4d17e8b08 upstream.

When checking whether the response is large enough to be able to contain
the received random bytes in tpm_get_random() and tpm2_get_random(),
they fail to take account the header size, which should be added to the
minimum size. This commit fixes this issue.

Cc: stable@vger.kernel.org
Fixes: c659af78eb7b ("tpm: Check size of response before accessing data")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/tpm/tpm-interface.c |    3 ++-
 drivers/char/tpm/tpm2-cmd.c      |    4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -1322,7 +1322,8 @@ int tpm_get_random(struct tpm_chip *chip
 		}
 
 		rlength = be32_to_cpu(tpm_cmd.header.out.length);
-		if (rlength < offsetof(struct tpm_getrandom_out, rng_data) +
+		if (rlength < TPM_HEADER_SIZE +
+			      offsetof(struct tpm_getrandom_out, rng_data) +
 			      recd) {
 			total = -EFAULT;
 			break;
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -329,7 +329,9 @@ int tpm2_get_random(struct tpm_chip *chi
 			&buf.data[TPM_HEADER_SIZE];
 		recd = min_t(u32, be16_to_cpu(out->size), num_bytes);
 		if (tpm_buf_length(&buf) <
-		    offsetof(struct tpm2_get_random_out, buffer) + recd) {
+		    TPM_HEADER_SIZE +
+		    offsetof(struct tpm2_get_random_out, buffer) +
+		    recd) {
 			err = -EFAULT;
 			goto out;
 		}


