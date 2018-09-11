Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAE0C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835CD20854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEu+0uY7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 835CD20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbeIKOqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:46:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43593 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbeIKOqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:46:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id v66-v6so11960465pgb.10;
        Tue, 11 Sep 2018 02:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z/FvY28wIs+g/+qtMYzrRtNCxGp6YIuGvttNUQH69Dg=;
        b=PEu+0uY7y0cq0Cu3aPqw1055Br+bvnuZcIFrKjn7vQqHVaVklm+JdbPfB3zHDip1hX
         6bz3W2Pr1Vo7lMh+/QZwS3Lha5gUZqVn7en+1Ho+TGyc017s8RdCrPKk/U92eIGUpf/Y
         lm3eFMh799YIS3abZWcoSmBO5Cv9h04uIFKVYKYkYoRM88AhrXHsLh3a9/PpbR5LeV3z
         adoWH9BYSwugmdCNTHpeMHuvn/0H0vEfEAhH+qDsRXUZ8bcJKfDoQ+EkuWd3CLh1DnRL
         zyYcG4xzpG2BOgf/PHCw52jPyFu+USyKUhSwwsrs88oHqXHMse/mGWeYtTSqGDjbNAt6
         EJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z/FvY28wIs+g/+qtMYzrRtNCxGp6YIuGvttNUQH69Dg=;
        b=k9CmOPo7z8RB76ti1Q+M+H5SXZ9GW/GLZh4cF3gUTIEBIVgbC6LQcUWeyuqZp9X280
         BgSmHvN84PQ186M0pwdE/BdG81L8sIjeH/IJqXrIaG+Xopa5R3RtgbvUs0Fo9E3xJ5in
         fRpy5KXdrRg9u35j403a56eEYhHoddeNHOef3vpw9HH2gyuZ10iKB6RYJjuM0tDirIkN
         WsrDShb4isisV1lXFtJSx3fEBPCI9QhQ6YYNxELxCfOuxiUWawzPNQSp0sEpAI4KW26s
         q1DQvraD0Tds2oz0vUG3MgKPkuRFZWqXADKfMhM/70aSyK5VimDD+t+/tRxtpVnQlv6c
         krQw==
X-Gm-Message-State: APzg51CpnwwgK8OC9kKXwRA3cLm3kaUuPlhB3GvqwvR3asWyA6jvL5Qe
        3tdn3ZRhgi2ZytyW6oLAARQ=
X-Google-Smtp-Source: ANB0Vdb2VnRCbpFG/t2DTl6JiH9C0er37xjzWupOtGWR/SFsuU6R8Sw7o1lPhouk6Wf+/YRe2JSx/Q==
X-Received: by 2002:a62:1544:: with SMTP id 65-v6mr28339417pfv.178.1536659301216;
        Tue, 11 Sep 2018 02:48:21 -0700 (PDT)
Received: from masabert (150-66-115-91m5.mineo.jp. [150.66.115.91])
        by smtp.gmail.com with ESMTPSA id i25-v6sm37013134pfi.150.2018.09.11.02.48.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 02:48:20 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id 8DD20200B62; Tue, 11 Sep 2018 18:48:13 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     qla2xxx-upstream@qlogic.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        himanshu.madhani@cavium.com, giridhar.malavali@cavium.com,
        linux-scsi@vger.kernel.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] scsi: qla2xxx: Fix comment in MODULE_PARM_DESC in qla2xxx
Date:   Tue, 11 Sep 2018 18:48:11 +0900
Message-Id: <20180911094811.12681-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Default value of ql2xasynctmfenable for qla2xxx driver was
set to 1 in commit 043dc1d7e8501.
But comment in MODULE_PARAM_DESC was not modified.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 drivers/scsi/qla2xxx/qla_os.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 42b8f0d3e580..fe5404be73c5 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -204,7 +204,7 @@ int ql2xasynctmfenable = 1;
 module_param(ql2xasynctmfenable, int, S_IRUGO);
 MODULE_PARM_DESC(ql2xasynctmfenable,
 		"Enables issue of TM IOCBs asynchronously via IOCB mechanism"
-		"Default is 0 - Issue TM IOCBs via mailbox mechanism.");
+		"Default is 1 - Issue TM IOCBs via mailbox mechanism.");
 
 int ql2xdontresethba;
 module_param(ql2xdontresethba, int, S_IRUGO|S_IWUSR);
-- 
2.19.0

