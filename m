Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3450EC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE84E214DC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nanometrics.ca header.i=@nanometrics.ca header.b="dqPAxg4U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE84E214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nanometrics.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbeJJAte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:49:34 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:46233 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbeJJAte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:49:34 -0400
Received: by mail-io1-f54.google.com with SMTP id t7-v6so1779017ioj.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 10:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nanometrics.ca; s=google;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=vZSeOx2Q9Ui+kq8iX3OPdKa7b/GGe9nX6s8iZnEDncA=;
        b=dqPAxg4UxrEzKXljLBMYP2ybFjG2S42Z0KdqVcL6kVhXVkc4juPZ7A9tOUOmz2xUtC
         BLcsfBM+ujkX24ccMO7Je1YW+3m2wkGo/14WzgYI18NvwtC5nJ2lmuxIy6Yo/I/EE39x
         9JA3BxWrZvKeG25KlqOniEYlR7h8wZ28RKJSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=vZSeOx2Q9Ui+kq8iX3OPdKa7b/GGe9nX6s8iZnEDncA=;
        b=Ttd6JzbfYYiwm2gOuHB6K/PNhy8ZY90qNihZjOC9KmyYlc5PloR3/m5UK5bafqWCuU
         KAhOdFuea3E4Y5rIp/YJPw5GgfIE3EhbrcEp/61g4o8lj9jvt50JKqlpLqIyRE05Waiw
         KwxbVRa2lEF9GesCg8iR6ZjIFSJtbpJL1+nOjsiMxZ3gLV2G7vgpIGqgxNrTXaY/8Z42
         cTCKl5TyAH8KjfixW8XJK/1PAUZ70vYfb3FHlqxBpAFVHvdlEXNHYYvFCn39reIXa2gx
         y8lyA3GTIKylPJUcNbysJNudDCE85tix66SXMfoJh4tgLb8sOHdtvp3vRGGQlInk3tyH
         +BTA==
X-Gm-Message-State: ABuFfogSRUB5j7GoJU/tsW6ldGZFsZSOl3ex46V3xJ0fAioOWDhaMvPJ
        J3Ea+i9b5tqIdYaeTyLsRbkeoxNj7s4sdfpBNSwc59t42mYYNZUNNtmtK/wxx7SQHDl2W95+ZOH
        ZmyP+oONASNaVarm6+l7UGw==
MIME-Version: 1.0
X-Google-Smtp-Source: ACcGV61OsBwTugqIqetgES1ZfQ0vrJm1SS/Md/PAJAFBar4o0Vj5Zjcp3eGcmOJhwDRczShW3dBnMw==
X-Received: by 2002:a6b:310d:: with SMTP id j13-v6mr20443904ioa.250.1539106291528;
        Tue, 09 Oct 2018 10:31:31 -0700 (PDT)
Received: from jamesnuss-kubuntu.nanometrics.ca ([72.142.127.130])
        by smtp.gmail.com with ESMTPSA id c24-v6sm6321018iod.44.2018.10.09.10.31.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 10:31:30 -0700 (PDT)
From:   James Nuss <jamesnuss@nanometrics.ca>
To:     linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] mmc-utils: update version number to 0.2
Date:   Tue,  9 Oct 2018 13:31:11 -0400
Message-Id: <56075121aed5797c838824a541d896a083b4fd30.1539103468.git.jamesnuss@nanometrics.ca>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1539103468.git.jamesnuss@nanometrics.ca>
References: <cover.1539103468.git.jamesnuss@nanometrics.ca>
In-Reply-To: <cover.1539103468.git.jamesnuss@nanometrics.ca>
References: <cover.1539103468.git.jamesnuss@nanometrics.ca>
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mmc.c b/mmc.c
index f2c714c..660b62e 100644
--- a/mmc.c
+++ b/mmc.c
@@ -26,7 +26,7 @@
 
 #include "mmc_cmds.h"
 
-#define MMC_VERSION	"0.1"
+#define MMC_VERSION	"0.2"
 
 #define BASIC_HELP 0
 #define ADVANCED_HELP 1
-- 
2.7.4


-- 
This message is intended exclusively for the individual or entity to which 
it is addressed. This communication may contain information that is 
proprietary, privileged, confidential or otherwise legally exempt from 
disclosure. If you are not the named addressee, or have been inadvertently 
and erroneously referenced in the address line, you are not authorized to 
read, print, retain, copy or disseminate this message or any part of it. If 
you have received this message in error, please notify the sender 
immediately by e-mail and delete all copies of the message.
