Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CF7ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E590321019
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEn7CBte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E590321019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbeKIHmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:42:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:33998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730464AbeKIHmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:42:16 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28A6420892;
        Thu,  8 Nov 2018 22:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714686;
        bh=uS8ODJin2t4kCJ+0QSG4AAzFKmCaqOmNDh75U4vawzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JEn7CBteeI9Vbd4HV5tUyKEQct07h6KWQORbXPdP0/wFeiQ3NSQn0G42QT/l0ehz0
         fbFv3iRDDuenVDs5U+FmQqOvlNWS6+jurjYVxSubmuryub6zUFaT3m7bk7aZL7G8CL
         4GPh49acsWtFlZ285wXDT13rjxhi08eisAMaS7aU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Petru-Florin Mihancea <petrum@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 063/171] libata: fix error checking in in ata_parse_force_one()
Date:   Thu,  8 Nov 2018 13:50:33 -0800
Message-Id: <20181108215132.133863493@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit f7cf69ae171592d133c69b9adaa5de7cfb6038ea ]

ata_parse_force_one() was incorrectly comparing @p to @endp when it
should have been comparing @id.  The only consequence is that it may
end up using an invalid port number in "libata.force" module param
instead of rejecting it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Petru-Florin Mihancea <petrum@gmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=195785
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 73d636d35961..a166359ad5d4 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6781,7 +6781,7 @@ static int __init ata_parse_force_one(char **cur,
 	}
 
 	force_ent->port = simple_strtoul(id, &endp, 10);
-	if (p == endp || *endp != '\0') {
+	if (id == endp || *endp != '\0') {
 		*reason = "invalid port/link";
 		return -EINVAL;
 	}
-- 
2.17.1



