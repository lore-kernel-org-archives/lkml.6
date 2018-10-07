Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC724C6787E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ABB720882
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VwSmjlCp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ABB720882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeJHGzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 02:55:11 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40869 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbeJHGzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 02:55:10 -0400
Received: by mail-pl1-f196.google.com with SMTP id 1-v6so9203194plv.7
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 16:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0q8EfWT03t0QCT05DDVi7T9b5F55I4jNnoh3aLJcUXs=;
        b=VwSmjlCpkyW0GrzO6Hx1jNKz0zjr6KGOSTdQNiLZFTD9dBegGsgRNzA/WogU2WUUkN
         QrA/XtFadESUaTQet26NExcfpNUaYN0BUniEBAvJW2/GfspaCM9EQL+P4W2uxNLsdXoO
         FeJr3/fo8LgPjIsduxVcc8gHHaUgPOSrZ+ZyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0q8EfWT03t0QCT05DDVi7T9b5F55I4jNnoh3aLJcUXs=;
        b=YK6ftiK3LyCl136QWG6WnkkP36hyKwwVr4QOI18StBGJlPhn0pFjbvSLPfNUJanhTS
         i41idXPB8hIpD1pKG8Ap2TLgCMyFup21umZWGx0EFxxb9uGeEWiVMz0ASjcbZriuXqB/
         STO7iGy9aBPGXwpXscsPEAbTS7cW203kk4vMaTJCNZan4SCOjlbw+l9qfc9nlt3wcbRH
         X1kve1yayH9Y0ejt4z0XawerXhPYkUeWqgVARpV/y2z4/btgZgePbq7nhBfy6wUiYGr7
         yCti0pndbWivlaXgclrRtJIjG+ny+F+CcDfXJkaQthf+dn9TAZTipU50ZMj2qZaeDKcx
         ZYGg==
X-Gm-Message-State: ABuFfoi4eQ0+GDMlQz5IkK5Z27MQODB7OlTuElQ1py7EE0HMOhA3+ZV0
        g0oWEfQSnyPu5fCMggKw8qkjSu6Xe0w=
X-Google-Smtp-Source: ACcGV61gb2pHUfQ8Xbeper2nKj6KlqlHNgUUU5xuns0PjGz8jplgUY8kF0Qdi2t02n4nL4ti3XAaCw==
X-Received: by 2002:a17:902:7043:: with SMTP id h3-v6mr21777620plt.103.1538955973835;
        Sun, 07 Oct 2018 16:46:13 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id y10-v6sm24200433pgi.85.2018.10.07.16.46.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 16:46:13 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH] usb: typec: Fix copy/paste on typec_set_vconn_role() kerneldoc
Date:   Sun,  7 Oct 2018 16:46:12 -0700
Message-Id: <20181007234612.94364-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This must have been copy pasted from the function above. Fix it.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/usb/typec/class.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 00141e05bc72..5db0593ca0bd 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1322,7 +1322,7 @@ void typec_set_pwr_role(struct typec_port *port, enum typec_role role)
 EXPORT_SYMBOL_GPL(typec_set_pwr_role);
 
 /**
- * typec_set_pwr_role - Report VCONN source change
+ * typec_set_vconn_role - Report VCONN source change
  * @port: The USB Type-C Port which VCONN role changed
  * @role: Source when @port is sourcing VCONN, or Sink when it's not
  *
-- 
Sent by a computer through tubes

