Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46469C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039E321780
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKCnrNzr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 039E321780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404952AbeKLIZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:25:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:32774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731220AbeKLIZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:25:10 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 547CD21707;
        Sun, 11 Nov 2018 22:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975712;
        bh=JQaJ0ou2VdLo2NH7UQXIl6e+Y7E211ZmvsLt+598RSE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HKCnrNzrEiyOv0VeYEycW77cX4b/7hUapkMc50vRnVc41sOeWij9uP+OoIXlVLP52
         1dBH2xNevbzkWklVds4eoVUWi9jOoJsUgNRHZXn2HAC0jP2KUSfB3Jlwev/jdzjIWy
         nBJl7tdah5UUM0mqYw/singH/9zpojrxukQ+Gho0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve French <stfrench@microsoft.com>,
        Aurelien Aptel <aaptel@suse.com>
Subject: [PATCH 4.9 106/141] smb3: allow stats which track session and share reconnects to be reset
Date:   Sun, 11 Nov 2018 14:26:05 -0800
Message-Id: <20181111221642.718374940@linuxfoundation.org>
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

From: Steve French <stfrench@microsoft.com>

commit 2c887635cd6ab3af619dc2be94e5bf8f2e172b78 upstream.

Currently, "echo 0 > /proc/fs/cifs/Stats" resets all of the stats
except the session and share reconnect counts.  Fix it to
reset those as well.

CC: Stable <stable@vger.kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/cifs_debug.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/cifs/cifs_debug.c
+++ b/fs/cifs/cifs_debug.c
@@ -284,6 +284,9 @@ static ssize_t cifs_stats_proc_write(str
 		atomic_set(&totBufAllocCount, 0);
 		atomic_set(&totSmBufAllocCount, 0);
 #endif /* CONFIG_CIFS_STATS2 */
+		atomic_set(&tcpSesReconnectCount, 0);
+		atomic_set(&tconInfoReconnectCount, 0);
+
 		spin_lock(&GlobalMid_Lock);
 		GlobalMaxActiveXid = 0;
 		GlobalCurrentXid = 0;


