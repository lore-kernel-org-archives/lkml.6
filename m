Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28989C41518
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECCCC218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548360255;
	bh=qxisTebjMyVqJuR4TACGyNmq5ZsbrXHpkGsJLX2TXA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PJFdvnyiGjpOhfImu57f/EmNK2kIx8MvojZwC7oTJ5KH1ywylSz1L5PQb3PBLt7nF
	 wSgjHyzVLyHiua0VMDFW1BU5fzcdpNUsMqW2TmxxRJOVqlSs+le2UJPG9hhSYmOZNS
	 H95sFt0dRVuPaTM+9rndDA+1IaGQ3Ztucvzzx2jg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731714AbfAXTbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:31:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:59630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731702AbfAXTbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:31:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 149B8218E2;
        Thu, 24 Jan 2019 19:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358307;
        bh=qxisTebjMyVqJuR4TACGyNmq5ZsbrXHpkGsJLX2TXA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WWDJ2AJ0Oo5DEK22OAy++QYMaw6PTHbVFR264uNVJxQEbxu/HTy3+ftRsdKAoqSqs
         EdPjTxjGFoJHjyX4bbTOEslEe141rDe6XBdEpt386dS2Nabw/BywtMupIL1pbn0OVX
         067bq7lht+griulsTNwT9JN/oVu8c0N95AKDspbo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 26/63] media: firewire: Fix app_info parameter type in avc_ca{,_app}_info
Date:   Thu, 24 Jan 2019 20:20:15 +0100
Message-Id: <20190124190158.080959629@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190155.176570028@linuxfoundation.org>
References: <20190124190155.176570028@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit b2e9a4eda11fd2cb1e6714e9ad3f455c402568ff ]

Clang warns:

drivers/media/firewire/firedtv-avc.c:999:45: warning: implicit
conversion from 'int' to 'char' changes value from 159 to -97
[-Wconstant-conversion]
        app_info[0] = (EN50221_TAG_APP_INFO >> 16) & 0xff;
                    ~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
drivers/media/firewire/firedtv-avc.c:1000:45: warning: implicit
conversion from 'int' to 'char' changes value from 128 to -128
[-Wconstant-conversion]
        app_info[1] = (EN50221_TAG_APP_INFO >>  8) & 0xff;
                    ~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
drivers/media/firewire/firedtv-avc.c:1040:44: warning: implicit
conversion from 'int' to 'char' changes value from 159 to -97
[-Wconstant-conversion]
        app_info[0] = (EN50221_TAG_CA_INFO >> 16) & 0xff;
                    ~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
drivers/media/firewire/firedtv-avc.c:1041:44: warning: implicit
conversion from 'int' to 'char' changes value from 128 to -128
[-Wconstant-conversion]
        app_info[1] = (EN50221_TAG_CA_INFO >>  8) & 0xff;
                    ~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
4 warnings generated.

Change app_info's type to unsigned char to match the type of the
member msg in struct ca_msg, which is the only thing passed into the
app_info parameter in this function.

Link: https://github.com/ClangBuiltLinux/linux/issues/105

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/firewire/firedtv-avc.c | 6 ++++--
 drivers/media/firewire/firedtv.h     | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/media/firewire/firedtv-avc.c b/drivers/media/firewire/firedtv-avc.c
index 5bde6c209cd7..b243e4a52f10 100644
--- a/drivers/media/firewire/firedtv-avc.c
+++ b/drivers/media/firewire/firedtv-avc.c
@@ -968,7 +968,8 @@ static int get_ca_object_length(struct avc_response_frame *r)
 	return r->operand[7];
 }
 
-int avc_ca_app_info(struct firedtv *fdtv, char *app_info, unsigned int *len)
+int avc_ca_app_info(struct firedtv *fdtv, unsigned char *app_info,
+		    unsigned int *len)
 {
 	struct avc_command_frame *c = (void *)fdtv->avc_data;
 	struct avc_response_frame *r = (void *)fdtv->avc_data;
@@ -1009,7 +1010,8 @@ out:
 	return ret;
 }
 
-int avc_ca_info(struct firedtv *fdtv, char *app_info, unsigned int *len)
+int avc_ca_info(struct firedtv *fdtv, unsigned char *app_info,
+		unsigned int *len)
 {
 	struct avc_command_frame *c = (void *)fdtv->avc_data;
 	struct avc_response_frame *r = (void *)fdtv->avc_data;
diff --git a/drivers/media/firewire/firedtv.h b/drivers/media/firewire/firedtv.h
index 345d1eda8c05..5b18a08c6285 100644
--- a/drivers/media/firewire/firedtv.h
+++ b/drivers/media/firewire/firedtv.h
@@ -124,8 +124,10 @@ int avc_lnb_control(struct firedtv *fdtv, char voltage, char burst,
 		    struct dvb_diseqc_master_cmd *diseqcmd);
 void avc_remote_ctrl_work(struct work_struct *work);
 int avc_register_remote_control(struct firedtv *fdtv);
-int avc_ca_app_info(struct firedtv *fdtv, char *app_info, unsigned int *len);
-int avc_ca_info(struct firedtv *fdtv, char *app_info, unsigned int *len);
+int avc_ca_app_info(struct firedtv *fdtv, unsigned char *app_info,
+		    unsigned int *len);
+int avc_ca_info(struct firedtv *fdtv, unsigned char *app_info,
+		unsigned int *len);
 int avc_ca_reset(struct firedtv *fdtv);
 int avc_ca_pmt(struct firedtv *fdtv, char *app_info, int length);
 int avc_ca_get_time_date(struct firedtv *fdtv, int *interval);
-- 
2.19.1



