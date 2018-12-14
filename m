Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117E7C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C88FA20892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544791394;
	bh=NjFm7mLiW5o1rE+OpVrr6zIPqwDa5YRFwMM3Nia2mXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ar8qtaa1fkMsv/UfRfiWYrhWoaKw4+hhdGv3G7GWgZZFgfgDAFYU6JPU1jAfMApb6
	 etXTqtOAdXW3imERonoK6mPEbdl/f4eD8vupTa9sA4Am4G+XN7fI2exYJ4SqB6ky0j
	 yKlkZio/D7eTEXbJDBpm+wI8dX8zvpKr+hOHKCZ8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C88FA20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbeLNMnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:43:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:45240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730013AbeLNMCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:02:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0AF62146E;
        Fri, 14 Dec 2018 12:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544788940;
        bh=NjFm7mLiW5o1rE+OpVrr6zIPqwDa5YRFwMM3Nia2mXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PQmV0pBztrnEboX/YqrF6x7TgQ7BltcyhfjrTom5iy4JAnrhf3Or2m9ui8S6Vl39a
         3OzZZ7Q6E4FFHqbW30QP0NUTyFfy16QWu2KyA/szA8SZCuZSbGcNZJVVjjfrIqwvH+
         8XiN5vnW2YhTErD4ITUV9O8KeZYqccDlWrqYVbYI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 032/142] tools: bpftool: prevent infinite loop in get_fdinfo()
Date:   Fri, 14 Dec 2018 12:58:37 +0100
Message-Id: <20181214115748.337244816@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

[ Upstream commit 53909030aa29bffe1f8490df62176c2375135652 ]

Function getline() returns -1 on failure to read a line, thus creating
an infinite loop in get_fdinfo() if the key is not found. Fix it by
calling the function only as long as we get a strictly positive return
value.

Found by copying the code for a key which is not always present...

Fixes: 71bb428fe2c1 ("tools: bpf: add bpftool")
Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index b3a0709ea7ed..fcaf00621102 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -304,7 +304,7 @@ char *get_fdinfo(int fd, const char *key)
 		return NULL;
 	}
 
-	while ((n = getline(&line, &line_n, fdi))) {
+	while ((n = getline(&line, &line_n, fdi)) > 0) {
 		char *value;
 		int len;
 
-- 
2.19.1



