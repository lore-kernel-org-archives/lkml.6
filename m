Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D938C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C7E20652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38C7E20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754827AbeFTJOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:14:40 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:44455 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754299AbeFTIdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:33:47 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue005 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LrGGm-1gChuk1us0-0135sI; Wed, 20 Jun 2018 10:33:42 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     David Howells <dhowells@redhat.com>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        linux-cachefs@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] cachefiles: avoid deprecated get_seconds()
Date:   Wed, 20 Jun 2018 10:31:10 +0200
Message-Id: <20180620083339.766780-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:5u9IqHPzy3OlmTSEzyeONOP86GAngA6lrWFV9i7lcKSXY2Edgx7
 X/9UXKcQEMZP6Jy35BvMYKRsKGKDGj0560PJrHGvsO0H5OUBlNavWiQwCmM2t3wp9dQ7nWr
 XMrnKkShGcZXFJAw7nj6kByAYg+hk0Y+Eytw9Z0fhQPTtqhcdYfmXGWlRrNY3KusvXOz2bn
 gXIzB4kxsRjw+XORDD4gA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cAuOoTufQ3I=:npO72s62Ui7Rz2uDl7mhS5
 jmkkB2nJNG0jc1JtDprUsarxkQ69UVWrPhWgnNXzbBpNeaAPWoRlE7CqnlEo5nYVF522jzjEb
 emdoSbmM14lBkRB54xhVCesUorT33/kh5lONckrwxydLSpEPehBNJ25HxUxjHQli1nkTIiILB
 ztO6icLWx9+xDSbX+06LnNtTnsxnEPOawnajOXqYnkqI7rnrbpQ8bQnzf12t/VbH3HdAenYEV
 2opUU+1ri7yD8CW+bGKKhJgIvPJ5NwMCSPgC/OZTyO1p7L1u+5gxADOKtAw1i9LCq+Kx/E9CI
 NC/qEoOH1MSQvBvjCZ+CJnUWibDj0KAUreC89eW1cO9uAl3q+4ih1EPWJdMq3E8My2U0uqPUI
 MJrrPwJmdjLQTuvxnjmnbz7FqhaqUAmdw5OOWrKgQ8KeHTwfrTMdKit1GU/qsUHoQAWuC2WmH
 WZrVdRbYjYmy9cakC0lFeOqUm3sZKrTwC9CuHZFOtF2tdTq1ecU5JH8ukzwQfUDciDjAL0eLW
 KMOM/9b82OSCTKdfJnemIpKUiYq9KfzPYmiRdF0SO0TeGUgB3ialtM/WgbHEQ+wYGCbCY82pE
 XAtUnjuQKV/5MGdbB84TTYWSGHmIMwaALmO4kvvCzBlPLcIMdxAp4Ds0qdfR4aYmDnkorLtdm
 XbXH/qPDKx1IPOBwNd1JD/aXD71lmkMJGH75WK+pG+vHY6iXChIBqMFMbpjwL2ioq77M=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_seconds() returns an unsigned long can overflow on some architectures
and is deprecated because of that. In cachefs, we cast that number to
a a 32-bit integer, which will overflow in year 2106 on all architectures.

The overflow probably isn't harmful in the end, since the timestamps are
only used to make the file names unique, but they don't strictly have to
be in monotonically increasing order. Moving to ktime_get_real_seconds()
avoids the deprecated interface, the question is whether we should still
truncate to 32 bits.

In this patch, I decided to not overflow, but instead to extend the
file names using the 64-bit timestamp, so they will be 17 characters
after 2106 rather than 16.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/cachefiles/namei.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index ab0bbe93b398..5705e29d4506 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -297,7 +297,7 @@ static int cachefiles_bury_object(struct cachefiles_cache *cache,
 {
 	struct dentry *grave, *trap;
 	struct path path, path_to_graveyard;
-	char nbuffer[8 + 8 + 1];
+	char nbuffer[16 + 8 + 1];
 	int ret;
 
 	_enter(",'%pd','%pd'", dir, rep);
@@ -336,8 +336,8 @@ static int cachefiles_bury_object(struct cachefiles_cache *cache,
 
 try_again:
 	/* first step is to make up a grave dentry in the graveyard */
-	sprintf(nbuffer, "%08x%08x",
-		(uint32_t) get_seconds(),
+	sprintf(nbuffer, "%08llx%08x",
+		(uint64_t) ktime_get_real_seconds(),
 		(uint32_t) atomic_inc_return(&cache->gravecounter));
 
 	/* do the multiway lock magic */
-- 
2.9.0

