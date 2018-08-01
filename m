Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2788BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB652083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB652083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407371AbeHATOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:14:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52106 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404728AbeHATOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:14:51 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8AAD9C3C;
        Wed,  1 Aug 2018 17:28:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Theodore Tso <tytso@mit.edu>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 073/144] fscrypt: use unbound workqueue for decryption
Date:   Wed,  1 Aug 2018 18:51:40 +0200
Message-Id: <20180801164955.139267207@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801164949.023217860@linuxfoundation.org>
References: <20180801164949.023217860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

[ Upstream commit 36dd26e0c8d42699eeba87431246c07c28075bae ]

Improve fscrypt read performance by switching the decryption workqueue
from bound to unbound.  With the bound workqueue, when multiple bios
completed on the same CPU, they were decrypted on that same CPU.  But
with the unbound queue, they are now decrypted in parallel on any CPU.

Although fscrypt read performance can be tough to measure due to the
many sources of variation, this change is most beneficial when
decryption is slow, e.g. on CPUs without AES instructions.  For example,
I timed tarring up encrypted directories on f2fs.  On x86 with AES-NI
instructions disabled, the unbound workqueue improved performance by
about 25-35%, using 1 to NUM_CPUs jobs with 4 or 8 CPUs available.  But
with AES-NI enabled, performance was unchanged to within ~2%.

I also did the same test on a quad-core ARM CPU using xts-speck128-neon
encryption.  There performance was usually about 10% better with the
unbound workqueue, bringing it closer to the unencrypted speed.

The unbound workqueue may be worse in some cases due to worse locality,
but I think it's still the better default.  dm-crypt uses an unbound
workqueue by default too, so this change makes fscrypt match.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/crypto/crypto.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -517,8 +517,17 @@ EXPORT_SYMBOL(fscrypt_initialize);
  */
 static int __init fscrypt_init(void)
 {
+	/*
+	 * Use an unbound workqueue to allow bios to be decrypted in parallel
+	 * even when they happen to complete on the same CPU.  This sacrifices
+	 * locality, but it's worthwhile since decryption is CPU-intensive.
+	 *
+	 * Also use a high-priority workqueue to prioritize decryption work,
+	 * which blocks reads from completing, over regular application tasks.
+	 */
 	fscrypt_read_workqueue = alloc_workqueue("fscrypt_read_queue",
-							WQ_HIGHPRI, 0);
+						 WQ_UNBOUND | WQ_HIGHPRI,
+						 num_online_cpus());
 	if (!fscrypt_read_workqueue)
 		goto fail;
 


