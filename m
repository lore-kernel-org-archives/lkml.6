Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F0DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBC8214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uhh74hDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFBC8214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390575AbeKLI4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:56:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:51248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390325AbeKLIWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:11 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7099E2243E;
        Sun, 11 Nov 2018 22:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975534;
        bh=R+IyGCFzj7hf+02l2LR5nw4DkAm4ruD42J91Uw88rNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uhh74hDV0RBbtGKWKok3t4So0POWT9fDMJRLRtw95nK5NebYaB17dHfoSfKDT9NQK
         LtoTegXvDcuhsWDtG9NV3HCFDSj8V37FQOPww2L96J7+jL8ZL7xxyT4TD0Sq12IToi
         SX/eOCkJJpnhR6ZlPtUMZeEGVnWedxUC2zIpsRUI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sanskriti Sharma <sansharm@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 048/222] perf tools: Free temporary sys string in read_event_files()
Date:   Sun, 11 Nov 2018 14:22:25 -0800
Message-Id: <20181111221652.408366596@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
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

From: Sanskriti Sharma <sansharm@redhat.com>

[ Upstream commit 1e44224fb0528b4c0cc176bde2bb31e9127eb14b ]

For each system in a given pevent, read_event_files() reads in a
temporary 'sys' string.  Be sure to free this string before moving onto
to the next system and/or leaving read_event_files().

Fixes the following coverity complaints:

  Error: RESOURCE_LEAK (CWE-772):

  tools/perf/util/trace-event-read.c:343: overwrite_var: Overwriting
  "sys" in "sys = read_string()" leaks the storage that "sys" points to.

  tools/perf/util/trace-event-read.c:353: leaked_storage: Variable "sys"
  going out of scope leaks the storage it points to.

Signed-off-by: Sanskriti Sharma <sansharm@redhat.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Joe Lawrence <joe.lawrence@redhat.com>
Link: http://lkml.kernel.org/r/1538490554-8161-6-git-send-email-sansharm@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/trace-event-read.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/tools/perf/util/trace-event-read.c
+++ b/tools/perf/util/trace-event-read.c
@@ -350,9 +350,12 @@ static int read_event_files(struct peven
 		for (x=0; x < count; x++) {
 			size = read8(pevent);
 			ret = read_event_file(pevent, sys, size);
-			if (ret)
+			if (ret) {
+				free(sys);
 				return ret;
+			}
 		}
+		free(sys);
 	}
 	return 0;
 }


