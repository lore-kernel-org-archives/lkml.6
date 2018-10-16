Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D328C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559662089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1pOTutw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 559662089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbeJQBFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:05:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727947AbeJQBFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:05:40 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F151C21476;
        Tue, 16 Oct 2018 17:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710057;
        bh=Fd3j+mkBz2lgy1TkHdF3+7QyC2uCCJ5Xm/maT4pWQNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I1pOTutw90YFLlCdDdmRctEi/ALYxhZ+3VAvaAGRKKWElaheiwd+K1MsAjWYnHInL
         1Ha1mEoHW7s6lj6h0qaer4SyOhiTpMvnZQ8JGhZ7/X4YqgLo0TpQE9Toc+9O/j2cPf
         dWebBvwOfTsIECnFslbLxirr6LnWfHa9VQIrtDKc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 091/135] bpf: btf: Fix end boundary calculation for type section
Date:   Tue, 16 Oct 2018 19:05:21 +0200
Message-Id: <20181016170521.639981592@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin KaFai Lau <kafai@fb.com>

[ Upstream commit 4b1c5d917d34f705096bb7dd8a2bd19b0881970e ]

The end boundary math for type section is incorrect in
btf_check_all_metas().  It just happens that hdr->type_off
is always 0 for now because there are only two sections
(type and string) and string section must be at the end (ensured
in btf_parse_str_sec).

However, type_off may not be 0 if a new section would be added later.
This patch fixes it.

Fixes: f80442a4cd18 ("bpf: btf: Change how section is supported in btf_header")
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/btf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1844,7 +1844,7 @@ static int btf_check_all_metas(struct bt
 
 	hdr = &btf->hdr;
 	cur = btf->nohdr_data + hdr->type_off;
-	end = btf->nohdr_data + hdr->type_len;
+	end = cur + hdr->type_len;
 
 	env->log_type_id = 1;
 	while (cur < end) {


