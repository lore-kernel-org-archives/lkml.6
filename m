Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9DEC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF95C21479
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF95C21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730584AbeHPVsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:48:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57406 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730575AbeHPVsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:48:16 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DB3E1CB7;
        Thu, 16 Aug 2018 18:48:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.18 13/22] crypto: x86/sha256-mb - fix digest copy in sha256_mb_mgr_get_comp_job_avx2()
Date:   Thu, 16 Aug 2018 20:45:29 +0200
Message-Id: <20180816171557.032567231@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180816171556.502583508@linuxfoundation.org>
References: <20180816171556.502583508@linuxfoundation.org>
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

From: Eric Biggers <ebiggers@google.com>

commit af839b4e546613aed1fbd64def73956aa98631e7 upstream.

There is a copy-paste error where sha256_mb_mgr_get_comp_job_avx2()
copies the SHA-256 digest state from sha256_mb_mgr::args::digest to
job_sha256::result_digest.  Consequently, the sha256_mb algorithm
sometimes calculates the wrong digest.  Fix it.

Reproducer using AF_ALG:

    #include <assert.h>
    #include <linux/if_alg.h>
    #include <stdio.h>
    #include <string.h>
    #include <sys/socket.h>
    #include <unistd.h>

    static const __u8 expected[32] =
        "\xad\x7f\xac\xb2\x58\x6f\xc6\xe9\x66\xc0\x04\xd7\xd1\xd1\x6b\x02"
        "\x4f\x58\x05\xff\x7c\xb4\x7c\x7a\x85\xda\xbd\x8b\x48\x89\x2c\xa7";

    int main()
    {
        int fd;
        struct sockaddr_alg addr = {
            .salg_type = "hash",
            .salg_name = "sha256_mb",
        };
        __u8 data[4096] = { 0 };
        __u8 digest[32];
        int ret;
        int i;

        fd = socket(AF_ALG, SOCK_SEQPACKET, 0);
        bind(fd, (void *)&addr, sizeof(addr));
        fork();
        fd = accept(fd, 0, 0);
        do {
            ret = write(fd, data, 4096);
            assert(ret == 4096);
            ret = read(fd, digest, 32);
            assert(ret == 32);
        } while (memcmp(digest, expected, 32) == 0);

        printf("wrong digest: ");
        for (i = 0; i < 32; i++)
            printf("%02x", digest[i]);
        printf("\n");
    }

Output was:

    wrong digest: ad7facb2000000000000000000000000ffffffef7cb47c7a85dabd8b48892ca7

Fixes: 172b1d6b5a93 ("crypto: sha256-mb - fix ctx pointer and digest copy")
Cc: <stable@vger.kernel.org> # v4.8+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/crypto/sha256-mb/sha256_mb_mgr_flush_avx2.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/crypto/sha256-mb/sha256_mb_mgr_flush_avx2.S
+++ b/arch/x86/crypto/sha256-mb/sha256_mb_mgr_flush_avx2.S
@@ -265,7 +265,7 @@ ENTRY(sha256_mb_mgr_get_comp_job_avx2)
 	vpinsrd	$1, _args_digest+1*32(state, idx, 4), %xmm0, %xmm0
 	vpinsrd	$2, _args_digest+2*32(state, idx, 4), %xmm0, %xmm0
 	vpinsrd	$3, _args_digest+3*32(state, idx, 4), %xmm0, %xmm0
-	vmovd   _args_digest(state , idx, 4) , %xmm0
+	vmovd	_args_digest+4*32(state, idx, 4), %xmm1
 	vpinsrd	$1, _args_digest+5*32(state, idx, 4), %xmm1, %xmm1
 	vpinsrd	$2, _args_digest+6*32(state, idx, 4), %xmm1, %xmm1
 	vpinsrd	$3, _args_digest+7*32(state, idx, 4), %xmm1, %xmm1


