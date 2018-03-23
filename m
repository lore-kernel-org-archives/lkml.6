Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521806036-2-7384687872247915316
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
    t=1521806036; b=Wm4BEeRdW+rYiLenrATT4G293L0gRQqaMnjPIZOQEQ1bIHj
    msnyl1hTbP/cyqbWn9Yi0hjMmEdml/6/+I75r+wOxK3ThM2TyOwLy8EmdnsTciKq
    IQpPw1+Uzx7ZhDtQgeDbrYjBqEkJ86c0jyZol61ML+VDYMaUGknYahh3diMJsWq9
    So95zHvLaamL+UXFo1REaF545PLanKS2VVu63bDJZIytrZGfl8WKIMFJgtfmErch
    hwWhnBBuQh7U4azQQcPqlOa/0bu+hMpninUY+zq0cLuC0tJ7wWIClX9OZI7o/1uU
    lykIevbLhDZfAcggsWexUnMH33SfThlHXBi57DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806036; bh=qmvxrf9OopyHZubcjUAOqpdxNr
    +SmUH+A6BOnfE7h74=; b=k7UOOFl+weJt4SqKnEqLg6KAkFzntmQ0ctlqq6SaBR
    yV+4JKjCuRtyzp3ZVJhV+qjLDkZXB+19BbM8ech0ehVvPqyhsxkt6OnPrjhivq7F
    vhtsxJ1I5YqYz3e/oNOIdA83gQlW9h1RAmtDpTfPRkXep25Pcgrja70lroP0uV3a
    tdqJv39ql+IiFw706aj57Byq6TffovtGWYA+stCYuTPYl3316uaZNshhogqsg0CX
    LfuZOmyvESsWJMUPwR+0sgkruG0YM7c320k7E+LdCk/vJk36xCu4PqkLDAwH6HsJ
    MfNwlcfrhSfSKnMnUqYrCkPp3tzDbtuA80EN7OHbxEAQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
        id S1753968AbeCWKBm (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:01:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37988 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751966AbeCWKBk (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:01:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 22/77] watchdog: Fix potential kref imbalance when opening watchdog
Date: Fri, 23 Mar 2018 10:53:56 +0100
Message-Id: <20180323094143.684670232@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -768,6 +768,7 @@ static int watchdog_open(struct inode *i
 {
 	struct watchdog_core_data *wd_data;
 	struct watchdog_device *wdd;
+	bool hw_running;
 	int err;
 
 	/* Get the corresponding watchdog device */
@@ -787,7 +788,8 @@ static int watchdog_open(struct inode *i
 	 * If the /dev/watchdog device is open, we don't want the module
 	 * to be unloaded.
 	 */
-	if (!watchdog_hw_running(wdd) && !try_module_get(wdd->ops->owner)) {
+	hw_running = watchdog_hw_running(wdd);
+	if (!hw_running && !try_module_get(wdd->ops->owner)) {
 		err = -EBUSY;
 		goto out_clear;
 	}
@@ -798,7 +800,7 @@ static int watchdog_open(struct inode *i
 
 	file->private_data = wd_data;
 
-	if (!watchdog_hw_running(wdd))
+	if (!hw_running)
 		kref_get(&wd_data->kref);
 
 	/* dev/watchdog is a virtual (and thus non-seekable) filesystem */
