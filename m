Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1D9C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3105220847
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojs4+2V/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3105220847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730889AbeKCD7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:59:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729339AbeKCD7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:59:13 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E8942082D;
        Fri,  2 Nov 2018 18:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184658;
        bh=/98sbzyUNEKQweW3TiI439NWBuOUkUebtaGY+AvRrQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ojs4+2V/5w+BXUf0QIWLDyjX7kGjRePNAOeI/OOZP1IvF3wM/eE8rU1kfOrem+212
         sTtSOPG6o8yRrHGRsaZwyuaJeVLouVb7lxtDtcVyAbHrVGNuNWZPHGBU42qKS7OZhU
         srWLCqsWpR2nFFLGEC09vJ/BZM/2gGnVhb83zzwc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Milan Broz <gmazyland@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 062/143] dm integrity: fail early if required HMAC key is not available
Date:   Fri,  2 Nov 2018 19:34:07 +0100
Message-Id: <20181102182902.092522847@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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



