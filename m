Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C718C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE4520871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2dF6o8gl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE4520871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387416AbeKLITF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:19:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:39860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731062AbeKLITE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:04 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E1BB21104;
        Sun, 11 Nov 2018 22:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975348;
        bh=E2GsH9iqi6ZkW5ki9lsnmQ6tle8fmacNnHGaUQqcwrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2dF6o8gli6RLNHlsVfYspxYrNcqpBING0vsj1GcFjY/ndPmenAK2M4FDiaoGNku1V
         wZqnbuZwhqKuwax0kX9pWsOZLkfxfG1cSCvsNKE2AAQ2PQ0ObOq5KP3qcUga70vXFJ
         3SOLslE0hX2xCDq+Ax+7NrAjSBRsg64K51580By4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Nicolas Pitre <nico@linaro.org>
Subject: [PATCH 4.19 358/361] vt: fix broken display when running aptitude
Date:   Sun, 11 Nov 2018 14:21:45 -0800
Message-Id: <20181111221702.092206116@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 943210ba807ec50aafa2fa7b13bd6d36a478969b upstream.

If you run aptitude on framebuffer console, the display is corrupted. The
corruption is caused by the commit d8ae7242. The patch adds "offset" to
"start" when calling scr_memsetw, but it forgets to do the same addition
on a subsequent call to do_update_region.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Fixes: d8ae72427187 ("vt: preserve unicode values corresponding to screen characters")
Reviewed-by: Nicolas Pitre <nico@linaro.org>
Cc: stable@vger.kernel.org	# 4.19
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/vt/vt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1551,7 +1551,7 @@ static void csi_K(struct vc_data *vc, in
 	scr_memsetw(start + offset, vc->vc_video_erase_char, 2 * count);
 	vc->vc_need_wrap = 0;
 	if (con_should_update(vc))
-		do_update_region(vc, (unsigned long) start, count);
+		do_update_region(vc, (unsigned long)(start + offset), count);
 }
 
 static void csi_X(struct vc_data *vc, int vpar) /* erase the following vpar positions */


