Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18F2C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895242146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107356;
	bh=2m+cJE6Ie9DsgQyXYqbvZvbFORsttAsEPIx9879M02Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P7Zj96wdQ/L/kZkF46s4E50HtuFUx2p/hUJIbn3HxdDHVVCrXOGpotqRDhVdPWA2v
	 iS5hJf/FT5bnxNG895XlOHLPJ8FDe2gagnl3i8FIxF263jlLp8rfYiwfzuuZDWyb8y
	 TGbaSN6KVw+45BqQimso01J07t6hgTW5knROLgHQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 895242146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbeLFOmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:42:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:46814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730473AbeLFOmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:42:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 595A021479;
        Thu,  6 Dec 2018 14:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107350;
        bh=2m+cJE6Ie9DsgQyXYqbvZvbFORsttAsEPIx9879M02Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OGEEZKhq2413QsMVerI+ttirL79/2YqLNNHmlf7tzFJJ9BXM3UNpnjO9gMP9ADvG7
         zqzuZdvA+PvnjZ6TeHMRHTL0/RJqzTkcG9uQF7CPnjdcNoEE9VE79LUYPgpTl0ht3R
         BPUup7PQydL2svozF9l4x7gpCsPsP37kMXnJ0Xdc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Laura Abbott <labbott@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH 4.14 29/55] kgdboc: Fix restrict error
Date:   Thu,  6 Dec 2018 15:39:03 +0100
Message-Id: <20181206143003.301611791@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143001.749982936@linuxfoundation.org>
References: <20181206143001.749982936@linuxfoundation.org>
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
 


