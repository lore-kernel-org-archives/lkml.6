Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182439-1521807364-2-12426551830719074060
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521807364; b=sObuS8tfqsbHkE81SxlfDKIwFsTEHcgPGO7qdvfrmshOZTP
    UaQE/TZ+0oTIMHLObXadBS1J1L4tv7jSG9N98fo7G+1wUnSDhsmb3s8UT41abVDc
    5wMyZyfHrH5tU6jEXP8Qx9VQbzFwZw49O1j6VH/7CF9/oQ1IRbTHi5dywVOQ3YA8
    lJvs+csesSTYFUmW7OT51OFxGXVzoN0XJir+CmTlEGEzZeHXrwkmxU8dbghv8Uka
    OGBjV7P9Q6sL+Ux/nvUFLB+XHzsoYM1Jso9Cft9BRYehfWXWxhgDYBYNGIUoJApJ
    b3Pgn4+Jfvgo7RssZCD8RTCpFK2ZWf7iYnrMjww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521807364; bh=LrfZaTtgAjLTS9ZvcgzX0AoecR
    xn2Q0/FMgDrSRj97g=; b=IZqn8xUmDSRT2d1aonk5ERSdbFUpebYouplknpblRL
    4Eqw6M7iyOz/quZgFQyh9Ho5zxYXGxSQ2fAZlUuxijfkGi0svvc9qF9joMr3q5z4
    1An5s/5eO8wDVfoL5avtEkYJu5IIKf5MkH5MpC8IhZKooEebQ7Z2aQBOH+6s8In5
    E/MoIzbCimkjHYrZXuSPMR90+tdCZCUTpVGcYOLrsppM+TK2c/nd82KnMJrPYO2v
    PQmC9fgxkNJNwWiIdJZU6vCVeVLsIYKMsb+dsANsWWKuXczOy3gsAs6hJ3xL6BaN
    Hp8jIYqya24I4ocnLcPI9/iO8UTieO9tH4XZKag1HS3A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbeCWMPs (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 08:15:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34110 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752166AbeCWJ4t (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:56:49 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 26/84] watchdog: Fix potential kref imbalance when opening watchdog
Date: Fri, 23 Mar 2018 10:53:40 +0100
Message-Id: <20180323095415.845552638@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>


[ Upstream commit 4bcd615fad6adddc68b058d498b30a9e0e0db77a ]

If a watchdog driver's open function sets WDOG_HW_RUNNING with the
expectation that the watchdog can not be stopped, but then stops the
watchdog anyway in its stop function, kref_get() wil not be called in
watchdog_open(). If the watchdog then stops on close, WDOG_HW_RUNNING
will be cleared and kref_put() will be called, causing a kref imbalance.
As result the character device data structure will be released, which in
turn will cause the system to crash on the next call to watchdog_open().

Fixes: ee142889e32f5 ("watchdog: Introduce WDOG_HW_RUNNING flag")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/watchdog/watchdog_dev.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -769,6 +769,7 @@ static int watchdog_open(struct inode *i
 {
 	struct watchdog_core_data *wd_data;
 	struct watchdog_device *wdd;
+	bool hw_running;
 	int err;
 
 	/* Get the corresponding watchdog device */
@@ -788,7 +789,8 @@ static int watchdog_open(struct inode *i
 	 * If the /dev/watchdog device is open, we don't want the module
 	 * to be unloaded.
 	 */
-	if (!watchdog_hw_running(wdd) && !try_module_get(wdd->ops->owner)) {
+	hw_running = watchdog_hw_running(wdd);
+	if (!hw_running && !try_module_get(wdd->ops->owner)) {
 		err = -EBUSY;
 		goto out_clear;
 	}
@@ -799,7 +801,7 @@ static int watchdog_open(struct inode *i
 
 	file->private_data = wd_data;
 
-	if (!watchdog_hw_running(wdd))
+	if (!hw_running)
 		kref_get(&wd_data->kref);
 
 	/* dev/watchdog is a virtual (and thus non-seekable) filesystem */
