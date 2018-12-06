Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2BDC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87382082B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107449;
	bh=tN9s3rO3hJIZPU3zYjWeCebcgQfHfyUb7pwWtc3Pu7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HOeBjwJjVD3qMQX/rd/A87lbhImhv96CzpjQ18tDwRq3rKD/auZLc3E5yEXKPWiMF
	 1q5o6DjhlrWxZ6N+4qft4vrntxZYyGHXQJkBdnm5GiupsOFRgRfKKplxuC0+p2hw92
	 9aIiD7IIacUZgmbnkzvRLqJo01JADtFjRzhdV1JI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87382082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbeLFOoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:44:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:48626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730209AbeLFOoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:44:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2171820661;
        Thu,  6 Dec 2018 14:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107442;
        bh=tN9s3rO3hJIZPU3zYjWeCebcgQfHfyUb7pwWtc3Pu7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nRrFxhhTI+JO+3EcLgNww6egthvefisJ7czojl+br7lAVbkuuM80ARB0f2/ODkXpA
         aqsT99xTpVlhXMYDKSkLR83UZgMhXOwxlQFNFo2x5eP8bX1QNq9HJKd/HjWPsWTmPr
         q4rdVOiAzpgJv+qqh0Qh0T+ETDEuuwaArO16AXlU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 54/55] net: qed: use correct strncpy() size
Date:   Thu,  6 Dec 2018 15:39:28 +0100
Message-Id: <20181206143004.650713862@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143001.749982936@linuxfoundation.org>
References: <20181206143001.749982936@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

commit 11f711081af0eb54190dc0de96ba4a9cd494666b upstream.

passing the strlen() of the source string as the destination
length is pointless, and gcc-8 now warns about it:

drivers/net/ethernet/qlogic/qed/qed_debug.c: In function 'qed_grc_dump':
include/linux/string.h:253: error: 'strncpy' specified bound depends on the length of the source argument [-Werror=stringop-overflow=]

This changes qed_grc_dump_big_ram() to instead uses the length of
the destination buffer, and use strscpy() to guarantee nul-termination.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/qlogic/qed/qed_debug.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/qlogic/qed/qed_debug.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_debug.c
@@ -3590,10 +3590,8 @@ static u32 qed_grc_dump_big_ram(struct q
 	total_blocks = big_ram->num_of_blocks[dev_data->chip_id];
 	ram_size = total_blocks * BIG_RAM_BLOCK_SIZE_DWORDS;
 
-	strncpy(type_name, big_ram->instance_name,
-		strlen(big_ram->instance_name));
-	strncpy(mem_name, big_ram->instance_name,
-		strlen(big_ram->instance_name));
+	strscpy(type_name, big_ram->instance_name, sizeof(type_name));
+	strscpy(mem_name, big_ram->instance_name, sizeof(mem_name));
 
 	/* Dump memory header */
 	offset += qed_grc_dump_mem_hdr(p_hwfn,


