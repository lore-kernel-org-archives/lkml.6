Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D894BC46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B34720862
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JedbMW9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B34720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbeKHMXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 07:23:01 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44757 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbeKHMXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 07:23:01 -0500
Received: by mail-pl1-f196.google.com with SMTP id s5-v6so8790480plq.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 18:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y/4UZToq2tS4oiFhUNEOOeGVB+rjNz76jbrKyvnBxYQ=;
        b=JedbMW9iEIhDjyw4LZzcmjFHYl6/f1pYsw6G5EVG2+iwkJYzprnVr5z4D8AdgbWwXR
         mFyBLCnj7OvlBdLXOfe7qNkm/fCQHPFVQnuryUogXNzgjbL935ZIakJRm1NnwkokpvYp
         4A5EWs/vVG707lAKV6Xk0XyZiHVyTE5+UEFvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y/4UZToq2tS4oiFhUNEOOeGVB+rjNz76jbrKyvnBxYQ=;
        b=IluEqyV6tTCbaOTmRQ19xtMPrgzIfxaETRM93xGXv6H3pNwjyOHzyhgcM5UMqKnHEV
         vSou+Z2E377T2SSbDPGgKVfGhch9/BmqMNrFzVCfrURWJ0PFMs0WdvNptSG1Mg3d7GzD
         ttJ2fHmDk4IgFm9e7cPGsUaoRmlg2VMHJa6bF1TALvcAKMq/4dP2FnKqLBpzYjSP6CQq
         KHypRvrMpY+k3DqPObj13LuqW/e0i7pqT2gYm3bkRjJsmWwfEKWomd1KZ4+fYXBJO6ya
         ivvoLz2614IBoD4rjp6ADKfkHABlsScLl+Fhu/q7vegdlIOlMoI1d5J6eifrOyD7MUcu
         Yxdw==
X-Gm-Message-State: AGRZ1gKvd6eydpfkmYQ3BkndFBEyrAGi3xSNZfb3PvC4wBzD5mSOsQrC
        fvnT9axGdLWR8iqyH76Op8zLhA==
X-Google-Smtp-Source: AJdET5cT/+M7MZMdagPnMdswq4YBieDBgi/+0Zij1dxaZGHxZ01f8mgeRxuxIWkmSw13A2VmPrf3Jg==
X-Received: by 2002:a17:902:aa8d:: with SMTP id d13-v6mr2881327plr.74.1541645385505;
        Wed, 07 Nov 2018 18:49:45 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id x14-v6sm2271519pfe.178.2018.11.07.18.49.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 18:49:44 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Benson Leung <bleung@chromium.org>
Cc:     Lee Jones <lee.jones@linaro.org>, <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Shawn Nematbakhsh <shawnn@chromium.org>,
        Alexandru Stan <amstan@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        RaviChandra Sadineni <ravisadineni@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 1/2] platform/chrome: straighten out cros_ec_get_{next,host}_event() error codes
Date:   Wed,  7 Nov 2018 18:49:38 -0800
Message-Id: <20181108024939.174321-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cros_ec_get_next_event() is documented to return 0 for success and
negative for errors. It currently returns negative for some errors, and
non-negative (number of bytes received) for success (including some "no
data available" responses as zero). This mostly works out OK, because the
callers were more or less ignoring the documentation, and only treating
positive values as success (and indepdently checking the modification of
'wakeup').

Let's button this up by avoiding pretending to handle event/wakeup
distinctions when no event info was retrieved (i.e., returned 0 bytes).
And fix the documentation of cros_ec_get_host_event() and
cros_ec_get_next_event() to accurately describe their behavior.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
v1 -> v2:
 * don't make as many changes to the API -- just fix the documentation
   and a few corner cases instead
---
 drivers/platform/chrome/cros_ec_proto.c | 4 ++--
 include/linux/mfd/cros_ec.h             | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index b6fd4838f60f..fff67b389c87 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -580,7 +580,7 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev, bool *wake_event)
 
 	if (!ec_dev->mkbp_event_supported) {
 		ret = get_keyboard_state_event(ec_dev);
-		if (ret < 0)
+		if (ret <= 0)
 			return ret;
 
 		if (wake_event)
@@ -590,7 +590,7 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev, bool *wake_event)
 	}
 
 	ret = get_next_event(ec_dev);
-	if (ret < 0)
+	if (ret <= 0)
 		return ret;
 
 	if (wake_event) {
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index e44e3ec8a9c7..de8b588c8776 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -317,7 +317,9 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev);
  * @wake_event: Pointer to a bool set to true upon return if the event might be
  *              treated as a wake event. Ignored if null.
  *
- * Return: 0 on success or negative error code.
+ * Return: negative error code on errors; 0 for no data; or else number of
+ * bytes received (i.e., an event was retrieved successfully). Event types are
+ * written out to @ec_dev->event_data.event_type on success.
  */
 int cros_ec_get_next_event(struct cros_ec_device *ec_dev, bool *wake_event);
 
@@ -329,7 +331,7 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev, bool *wake_event);
  * events raised and call the functions in the ec notifier. This function
  * is a helper to know which events are raised.
  *
- * Return: 0 on success or negative error code.
+ * Return: 0 on error or non-zero bitmask of one or more EC_HOST_EVENT_*.
  */
 u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev);
 
-- 
2.19.1.930.g4563a0d9d0-goog

