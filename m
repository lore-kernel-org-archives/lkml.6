Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F780C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3628C2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="omlm3VGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3628C2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbeLDLAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:00:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:45422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727269AbeLDLAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:00:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F29D6214DA;
        Tue,  4 Dec 2018 11:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921210;
        bh=MeofzYFr5REyrMmiKD6bf3cq0ZhKBvWaq3njKFqti3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=omlm3VGj/ILw8ZmUzaXb3SCzuekyx5OHg53GEPUJXO9YHj9Sbfi85mpBRkeMbXMQ3
         HAHvSygt53IUhqKXH9SEyGMeyIz2LB80cDWpF9scSDXGj0EqzbmZl9PEQPsSFMv5x9
         5EahSiO/m0tBOaaCK/wqfgAPYwRJrVPLnEta4Khk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>
Subject: [PATCH 4.19 124/139] staging: most: use format specifier "%s" in snprintf
Date:   Tue,  4 Dec 2018 11:50:05 +0100
Message-Id: <20181204103655.816375740@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

commit 13c45007e0a87e912da21223599583fdea677914 upstream.

Passing string ch_data_type[i].name as the format specifier is
potentially hazardous because it could (although very unlikely to)
have a format specifier embedded in it causing issues when parsing
the non-existent arguments to these.  Follow best practice by using
the "%s" format string for the string.

Cleans up clang warning:
format string is not a string literal (potentially insecure) [-Wformat-security]

Fixes: e7f2b70fd3a9 ("staging: most: replace multiple if..else with table lookup")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/most/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/most/core.c
+++ b/drivers/staging/most/core.c
@@ -351,7 +351,7 @@ static ssize_t set_datatype_show(struct
 
 	for (i = 0; i < ARRAY_SIZE(ch_data_type); i++) {
 		if (c->cfg.data_type & ch_data_type[i].most_ch_data_type)
-			return snprintf(buf, PAGE_SIZE, ch_data_type[i].name);
+			return snprintf(buf, PAGE_SIZE, "%s", ch_data_type[i].name);
 	}
 	return snprintf(buf, PAGE_SIZE, "unconfigured\n");
 }


