Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3722AC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1DA2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RORH4pWY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1DA2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbeJYWoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:44:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727877AbeJYWoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:44:08 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5C872054F;
        Thu, 25 Oct 2018 14:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476673;
        bh=JHt2FEyUHhx4buYNYjus5OpLvd5xdvNhhG9N71hSCB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RORH4pWYTwzQ43dqub+E+Y3ZKYxJaPNCQGIOqtBhQdOgj/7/GMuZxglAs4NbsZ+LD
         XHOQ3TRdDMi83P50SgliC1+j+/jjDNI7VR02tRx3C/jJXT22U6fNiuvNuPUOUaYGGG
         mFrz7XZBayV8BbAmvAwRa/Fj4dtlSTZWYO53uqUg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Milan Broz <gmazyland@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 13/46] dm integrity: fail early if required HMAC key is not available
Date:   Thu, 25 Oct 2018 10:10:20 -0400
Message-Id: <20181025141053.213330-13-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141053.213330-1-sashal@kernel.org>
References: <20181025141053.213330-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Milan Broz <gmazyland@gmail.com>

[ Upstream commit e16b4f99f0f79682a7efe191a8ce694d87ca9fc8 ]

Since crypto API commit 9fa68f62004 ("crypto: hash - prevent using keyed
hashes without setting key") dm-integrity cannot use keyed algorithms
without the key being set.

The dm-integrity recognizes this too late (during use of HMAC), so it
allows creation and formatting of superblock, but the device is in fact
unusable.

Fix it by detecting the key requirement in integrity table constructor.

Signed-off-by: Milan Broz <gmazyland@gmail.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-integrity.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 898286ed47a1..b10e4c5641ea 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -2547,6 +2547,9 @@ static int get_mac(struct crypto_shash **hash, struct alg_spec *a, char **error,
 				*error = error_key;
 				return r;
 			}
+		} else if (crypto_shash_get_flags(*hash) & CRYPTO_TFM_NEED_KEY) {
+			*error = error_key;
+			return -ENOKEY;
 		}
 	}
 
-- 
2.17.1

