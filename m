Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4421C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC322087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCUaPYXh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC322087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732511AbeJICF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:05:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbeJICF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:05:27 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17A8C204FD;
        Mon,  8 Oct 2018 18:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024739;
        bh=A26M3ZC0TDc0FiEWakmvr+uL9581k0hvVEhNyWz/Ifs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cCUaPYXhK4H4v3Q1ZPkGa/8eU6+8fXZWAFk8+eqCY6A3U50oQYOvn0B5Ke4p6wJap
         LdW0PA5LcbQixxlaDXj2fDDyBpIrk6XU47uPnpFKsl4YIRTnIfSNOeuqpQTMJWXhzR
         Eyy4KEo8MiCnguLCfYIIBJ8thafeOCtkptZqnhkI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heinz Mauelshagen <heinzm@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 114/168] dm raid: fix rebuild of specific devices by updating superblock
Date:   Mon,  8 Oct 2018 20:31:34 +0200
Message-Id: <20181008175624.380273043@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
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

From: Heinz Mauelshagen <heinzm@redhat.com>

[ Upstream commit c44a5ee803d2b7ed8c2e6ce24a5c4dd60778886e ]

Update superblock when particular devices are requested via rebuild
(e.g. lvconvert --replace ...) to avoid spurious failure with the "New
device injected into existing raid set without 'delta_disks' or
'rebuild' parameter specified" error message.

Signed-off-by: Heinz Mauelshagen <heinzm@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-raid.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3126,6 +3126,11 @@ static int raid_ctr(struct dm_target *ti
 		set_bit(RT_FLAG_UPDATE_SBS, &rs->runtime_flags);
 		rs_set_new(rs);
 	} else if (rs_is_recovering(rs)) {
+		/* Rebuild particular devices */
+		if (test_bit(__CTR_FLAG_REBUILD, &rs->ctr_flags)) {
+			set_bit(RT_FLAG_UPDATE_SBS, &rs->runtime_flags);
+			rs_setup_recovery(rs, MaxSector);
+		}
 		/* A recovering raid set may be resized */
 		; /* skip setup rs */
 	} else if (rs_is_reshaping(rs)) {


