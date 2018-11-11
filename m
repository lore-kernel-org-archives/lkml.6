Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68ACC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF2E21508
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="or5077ux"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF2E21508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391139AbeKLIgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:36:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:57504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390249AbeKLIXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:23:32 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56D21223D8;
        Sun, 11 Nov 2018 22:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975615;
        bh=QyH75mlSMFzvkFUSSXhht9Gf7rGKuJuog/6be4hwcQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=or5077uxXVH/JNFqrpkXDC0sudXqBX/Xe9/xAG/lNL5G/QpGVzyirM3Hzc+56r0fH
         ulWERheYFjXnzHp6OOCbEbfXELUSFhtEKvHNlXqu7JvMDGFjgGjILjiRdlmsoYEVp2
         oEuUtMnNeUEv4YwaK+X7E4Uau+9Qs/VrTgQ+8W4Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 022/141] perf cpu_map: Align cpu map synthesized events properly.
Date:   Sun, 11 Nov 2018 14:24:41 -0800
Message-Id: <20181111221630.785198849@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221627.853046496@linuxfoundation.org>
References: <20181111221627.853046496@linuxfoundation.org>
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

From: David Miller <davem@davemloft.net>

[ Upstream commit 0ed149cf5239cc6e7e65bf00f769e8f1e91076c0 ]

The size of the resulting cpu map can be smaller than a multiple of
sizeof(u64), resulting in SIGBUS on cpus like Sparc as the next event
will not be aligned properly.

Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Fixes: 6c872901af07 ("perf cpu_map: Add cpu_map event synthesize function")
Link: http://lkml.kernel.org/r/20181011.224655.716771175766946817.davem@davemloft.net
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/event.c |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -839,6 +839,7 @@ void *cpu_map_data__alloc(struct cpu_map
 	}
 
 	*size += sizeof(struct cpu_map_data);
+	*size = PERF_ALIGN(*size, sizeof(u64));
 	return zalloc(*size);
 }
 


