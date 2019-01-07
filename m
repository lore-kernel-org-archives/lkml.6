Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52B7C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93990217D4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866778;
	bh=mfNnM41Naq/mgPFbtmD7i2QBs0YV8KsU+5aqXkT9KHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C9B5knVEPeAdA90pL0RPaShm8BDZRl14ANUBTxtsgiULeotLjlsNis4L50oCNfRgW
	 c2a0wLSiB5i4QBierLTwi4ZNuIEiDOrW4fXgZWhLpIANR4sC63SMFy/kQM8/SjToqj
	 lgM9mMRSKWYFxrs1zObOTzihmf+9UiYt8wR2I9ko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731653AbfAGNM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:12:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:51888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731339AbfAGNER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:04:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BFD821736;
        Mon,  7 Jan 2019 13:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866257;
        bh=mfNnM41Naq/mgPFbtmD7i2QBs0YV8KsU+5aqXkT9KHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CloBi3208OrFj4GcgDDcvnuCsOXykq51JdE4XJjch3YAH/f2X1nWmOBNIPSTfiJ6N
         wQYdOwaqP66/SgcE3Og4Rr+GyaBOjM+7Debi5IHPbDQea+5cye6lN+oU2ZZ0Gaigjx
         fSLauQ/RzlATsMoOOaZg6Y9ykS8C5NamPo+gkpnE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH 4.14 099/101] tpm: tpm_try_transmit() refactor error flow.
Date:   Mon,  7 Jan 2019 13:33:27 +0100
Message-Id: <20190107105338.159667198@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
References: <20190107105330.372621917@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomas Winkler <tomas.winkler@intel.com>

commit 01f54664a4db0d612de0ece8e0022f21f9374e9b upstream.

First, rename out_no_locality to out_locality for bailing out on
both tpm_cmd_ready() and tpm_request_locality() failure.
Second, ignore the return value of go_to_idle() as  it may override
the return value of the actual tpm operation, the go_to_idle() error
will be caught on any consequent command.
Last, fix the wrong 'goto out', that jumped back instead of forward.

Cc: stable@vger.kernel.org
Fixes: 627448e85c76 ("tpm: separate cmd_ready/go_idle from runtime_pm")
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/tpm/tpm-interface.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -479,13 +479,15 @@ static ssize_t tpm_try_transmit(struct t
 
 	if (need_locality) {
 		rc = tpm_request_locality(chip, flags);
-		if (rc < 0)
-			goto out_no_locality;
+		if (rc < 0) {
+			need_locality = false;
+			goto out_locality;
+		}
 	}
 
 	rc = tpm_cmd_ready(chip, flags);
 	if (rc)
-		goto out;
+		goto out_locality;
 
 	rc = tpm2_prepare_space(chip, space, ordinal, buf);
 	if (rc)
@@ -549,14 +551,13 @@ out_recv:
 		dev_err(&chip->dev, "tpm2_commit_space: error %d\n", rc);
 
 out:
-	rc = tpm_go_idle(chip, flags);
-	if (rc)
-		goto out;
+	/* may fail but do not override previous error value in rc */
+	tpm_go_idle(chip, flags);
 
+out_locality:
 	if (need_locality)
 		tpm_relinquish_locality(chip, flags);
 
-out_no_locality:
 	if (chip->ops->clk_enable != NULL)
 		chip->ops->clk_enable(chip, false);
 


