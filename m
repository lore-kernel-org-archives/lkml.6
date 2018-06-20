Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F04C1B0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D7320883
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D7320883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754382AbeFTPeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:34:46 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:51519 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754335AbeFTPeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:34:44 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0Lj9jT-1g3dAS0Q0d-00dXvs; Wed, 20 Jun 2018 17:34:27 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>
Cc:     y2038@lists.linaro.org, linux-ext4@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] jbd2: replace current_kernel_time64 with ktime equivalent
Date:   Wed, 20 Jun 2018 17:33:02 +0200
Message-Id: <20180620153322.54221-5-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180620153322.54221-1-arnd@arndb.de>
References: <20180620153322.54221-1-arnd@arndb.de>
X-Provags-ID: V03:K1:XB5O87moimnOK3P1rqIZynulXeYHVuVcxg64p/U2NlN+GmgBkoY
 TCFvu8hRg9UWSg2wkde0gQ+dWGdUtr5rnK7BdNJ36bBDvg4fdUui7HuPA6ZBoSpHKV5J8+S
 G8Toirw7QhINkYpvFawbcLb8WPhq2XMk/HXvq9kTKN4dNc9OQZk1GIYw0MY0U4a61PGElbv
 Fak9GQlMOlngjlz88BfhQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JQ8pSVmYQzY=:N7amg/iW1b8mUo9Srs39/M
 cI6sGpvuFHlDX3kVz5tvgF5YBOSc14BW+2vKHDQCKAV1SW22h7haZwHAli+gq0NqZsK9jaa2W
 BDNTphg7bmHAWRcUdETQyNXjlWrwtO75rzPMelD+H7oe6jjYYtu2SB6OtD1aREQ76+1A8z//a
 gg0ut8DHXNK3+K6WYN3JEJNn2yac3aZ9JpsCpbrW3oQ3zpR/bXIqL8edui6Q0z81Ocf9IJs33
 aZgE+5MBFixWOhBmbRZaU0sY29TcFd3Rc7tLxQxOf9WxmYBDmLdMUW3xSZcLAPQ411ouywD1L
 TL2yJ2ia8iWggLRnFaN8XvVVnoy1Piw2XrkC5e4j4bWmm/Tbfq9QvhgJvc+OrtmVV0BFTO5xY
 9QJ6yqEZS97tdjEUMSLhoFn+twzRatzMp5lWN3cUdzBOQiuoatH4qzTO6lvTdUIb9IWL7HHVs
 gWwnN40Z7XyctS0eVv9J0TmnEqpt/Nvfkyt0pOLG6QVIfWTciK2utHB3+nwOTli9l9x8zOSCH
 wryUAkYCWPBxKqT3XVeM0On7eDTSR2gZTlw8JqowTnbk38HYbLYkYEVWb3anbRRSP7ASlZxiM
 eSCEj9NohomPsAeYCN5K5ujMZCU1Z8id/WwYgQ/ymN4VkkPteXWF7MU+sET5W/xHvOBGSaDLY
 z73TR2F+AWY5iyHLgXnGrjGYsTmXE8/wVfCK+SRAEJv2yUbHaAioQmLNU6V01LzlOc2g=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

jbd2 is one of the few callers of current_kernel_time64(), which
is a wrapper around ktime_get_coarse_real_ts64(). This calls the
latter directly for consistency with the rest of the kernel that
is moving to the ktime_get_ family of time accessors.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/jbd2/commit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 8de0e7723316..150cc030b4d7 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -121,7 +121,7 @@ static int journal_submit_commit_record(journal_t *journal,
 	struct commit_header *tmp;
 	struct buffer_head *bh;
 	int ret;
-	struct timespec64 now = current_kernel_time64();
+	struct timespec64 now;
 
 	*cbh = NULL;
 
@@ -134,6 +134,7 @@ static int journal_submit_commit_record(journal_t *journal,
 		return 1;
 
 	tmp = (struct commit_header *)bh->b_data;
+	ktime_get_coarse_real_ts64(&now);
 	tmp->h_commit_sec = cpu_to_be64(now.tv_sec);
 	tmp->h_commit_nsec = cpu_to_be32(now.tv_nsec);
 
-- 
2.9.0

