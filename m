Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D827C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF55D20872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217885;
	bh=GIGnzlXA1SWguAjiIfPfv78g9wL/E4V/xPh+zO3m6DU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AqaHwywaRjNfEcROjpBlgLS5EhzUfLlIYzPGMrW2GlcsCq0XoweIdUH0LMkjpcLpK
	 2h4SXjcJN/4DJjKpDoxBDnq2Vp+Rx5qv2sJQjBBwUPjPvQEINYJgHtHIVotcKjpWJc
	 fB2i8xpJ/U6IevevF1GTeOAV+DbWeEL52OJBvWig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404660AbfAKOoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:44:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:37554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403916AbfAKOoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:44:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10A90206B6;
        Fri, 11 Jan 2019 14:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217876;
        bh=GIGnzlXA1SWguAjiIfPfv78g9wL/E4V/xPh+zO3m6DU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jHgle3YCvCucnyVhbt09TAsuXOdNccsSQMCdMkHWcovhHIocS9B7WkJp/g883XbeM
         R/Qi+UP+0hyfwHQpGpeNu1QgFo5OFSyZ6U3Ibgq3tISC6hZeGI/G/qYydVu0t1iFKD
         0qCCPS8Al66mUVi+J42AQCVIge+OcNGLZZcHj/is=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        David Teigland <teigland@redhat.com>, stable@kernel.org
Subject: [PATCH 4.20 31/65] dlm: lost put_lkb on error path in receive_convert() and receive_unlock()
Date:   Fri, 11 Jan 2019 15:15:17 +0100
Message-Id: <20190111131100.620353979@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131055.331350141@linuxfoundation.org>
References: <20190111131055.331350141@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Averin <vvs@virtuozzo.com>

commit c0174726c3976e67da8649ac62cae43220ae173a upstream.

Fixes 6d40c4a708e0 ("dlm: improve error and debug messages")
Cc: stable@kernel.org # 3.5

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/dlm/lock.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -4180,6 +4180,7 @@ static int receive_convert(struct dlm_ls
 			  (unsigned long long)lkb->lkb_recover_seq,
 			  ms->m_header.h_nodeid, ms->m_lkid);
 		error = -ENOENT;
+		dlm_put_lkb(lkb);
 		goto fail;
 	}
 
@@ -4233,6 +4234,7 @@ static int receive_unlock(struct dlm_ls
 			  lkb->lkb_id, lkb->lkb_remid,
 			  ms->m_header.h_nodeid, ms->m_lkid);
 		error = -ENOENT;
+		dlm_put_lkb(lkb);
 		goto fail;
 	}
 


