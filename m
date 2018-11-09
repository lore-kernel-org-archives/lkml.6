Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B2FC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3EE420827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="IwQyYFs5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3EE420827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbeKJIzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:55:18 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45989 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbeKJIx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:53:56 -0500
Received: by mail-lf1-f67.google.com with SMTP id b20so2478052lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 15:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nANHeFyvBLgMF/1/CYgktpwTu+kzhyl1G3GzMBxrNhg=;
        b=IwQyYFs5Vn/Vl3OQYL8DLH/GIjAwR2yRm1GO+jU55Z37GuQdfweWEL2WtHjfmn9MgV
         ZzBBmofQRJRL2iV49k66nXAvP9jVee9G8T+2WibCvvnbxvqNwyDpl5Bhs+lQy4Wrr1bL
         aEOqcqirgsTsrnhhhi9AhpVwPXIeCb18OwN/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nANHeFyvBLgMF/1/CYgktpwTu+kzhyl1G3GzMBxrNhg=;
        b=adQNS3+EfmrpmyjvuLw+nkOaWuvl9bsSiFTxTLZOpYNu4GFYrnp7cdkgZUKQKW9kh+
         ITGDryv6a+ZBgv/vpbX93f0XpPhQZlH30dmFZ/2Lfp+65iH7mpffj5YvxYS4l0PLGmFL
         QVsGR/DnOYHs5gzWQnark8KzBpsrFlE8OVt7cfTHe3ihj3cZhpALQatzuFWRzosXh37y
         rOw2zxQl7hFD5VhdtF3YAKpz9w7nchQ4E1H8YqYAwWiOteUTLJehxmlULfgp5NFwXQl8
         lCZG6bqp/oQYvn2UrK5e1C8FVO/h5GVgmjV2ncCQt9K1VE1hWfZsaxzEGgdSQDg3sk4/
         Xhtw==
X-Gm-Message-State: AGRZ1gLOrQUFWt4DMpcBOR7l5YKcIji54eXXHkOQQau9Dr6v86eisRkk
        6j2c7NxPnIZOrNYXDuTRifl4YQ==
X-Google-Smtp-Source: AJdET5d90N4nVcgo8LwdqlDZ13RKe2rh3Dsu2BIjtIfAX3hck2fin8+dZ3/RXOwSIuan+/ujLGSmXQ==
X-Received: by 2002:a19:f813:: with SMTP id a19mr6264356lff.67.1541805070615;
        Fri, 09 Nov 2018 15:11:10 -0800 (PST)
Received: from prevas-ravi.prevas.se (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id x16sm1584012lff.26.2018.11.09.15.11.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 15:11:10 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 09/23] dynamic_debug: use pointer comparison in ddebug_remove_module
Date:   Sat, 10 Nov 2018 00:10:07 +0100
Message-Id: <20181109231021.11658-10-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181109231021.11658-1-linux@rasmusvillemoes.dk>
References: <20181009112013.14238-1-linux@rasmusvillemoes.dk>
 <20181109231021.11658-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we store the passed-in string directly in ddebug_add_module, we
can use pointer equality instead of strcmp. This is a little more
efficient, but more importantly, this also makes the code somewhat more
correct:

Currently, if one loads and then unloads a module whose name happens to
match the KBUILD_MODNAME of some built-in functionality (which need not
even be modular at all), all of their dynamic debug entries vanish along
with those of the actual module. For example, loading and unloading a
core.ko hides all pr_debugs from drivers/base/core.c and other built-in
files called core.c (incidentally, there is an in-tree module whose name
is core, but I just tested this with an out-of-tree trivial one).

Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/dynamic_debug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 2155e0e23530..ab81155f928d 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -929,9 +929,10 @@ int ddebug_remove_module(const char *mod_name)
 
 	mutex_lock(&ddebug_lock);
 	list_for_each_entry_safe(dt, nextdt, &ddebug_tables, link) {
-		if (!strcmp(dt->mod_name, mod_name)) {
+		if (dt->mod_name == mod_name) {
 			ddebug_table_free(dt);
 			ret = 0;
+			break;
 		}
 	}
 	mutex_unlock(&ddebug_lock);
-- 
2.19.1.6.gbde171bbf5

