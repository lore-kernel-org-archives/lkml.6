Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D5BC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF2820661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107490;
	bh=1d2EiBSh3RaBucDrfAOGMeRh3XdBvqAlH7ggcHKPCpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mGuCmHDt9v81eJpHflmhB5W1W1d08k7ldUWgCgkIfnRAdwgk89bU3TSl7L0VBH9Fd
	 8uBpezW1MLTB67MypTZGMo2823N12W1EgWIZKggjneaO5v42AEjo0ogGA8jHQL8ec+
	 AY7VJ450pbq1IWpuyfKKQ2eMrf4zZmNtz3kRV6Yg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF2820661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbeLFOot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:44:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:49456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730926AbeLFOop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:44:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0485E20892;
        Thu,  6 Dec 2018 14:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107484;
        bh=1d2EiBSh3RaBucDrfAOGMeRh3XdBvqAlH7ggcHKPCpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1oqSRRETB05AnI1zB8PCKwakGYx6WYrSz7MMjTYgEwAUHNSI5eDP8rnFjmUEMrkwK
         4veJaaLfA78dn62mAm9cMwb6w/dJ4HFb+x6NFEZo7PsqqXFt9stsGCiJniSs4NSvaJ
         wsdM2zZuDY24pJrKGpV8F89X81BAuH2FkHxsGixg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Laura Abbott <labbott@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH 4.9 023/101] kgdboc: Fix restrict error
Date:   Thu,  6 Dec 2018 15:38:22 +0100
Message-Id: <20181206143012.936493654@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Laura Abbott <labbott@redhat.com>

commit 2dd453168643d9475028cd867c57e65956a0f7f9 upstream.

There's an error when compiled with restrict:

drivers/tty/serial/kgdboc.c: In function ‘configure_kgdboc’:
drivers/tty/serial/kgdboc.c:137:2: error: ‘strcpy’ source argument is the same
as destination [-Werror=restrict]
  strcpy(config, opt);
  ^~~~~~~~~~~~~~~~~~~

As the error implies, this is from trying to use config as both source and
destination. Drop the call to the function where config is the argument
since nothing else happens in the function.

Signed-off-by: Laura Abbott <labbott@redhat.com>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/kgdboc.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -162,15 +162,13 @@ static int configure_kgdboc(void)
 {
 	struct tty_driver *p;
 	int tty_line = 0;
-	int err;
+	int err = -ENODEV;
 	char *cptr = config;
 	struct console *cons;
 
-	err = kgdboc_option_setup(config);
-	if (err || !strlen(config) || isspace(config[0]))
+	if (!strlen(config) || isspace(config[0]))
 		goto noconfig;
 
-	err = -ENODEV;
 	kgdboc_io_ops.is_console = 0;
 	kgdb_tty_driver = NULL;
 


