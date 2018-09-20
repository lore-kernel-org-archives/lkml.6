Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B06ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02642147D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V4TgC8bV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B02642147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732489AbeITWJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:09:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46452 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387856AbeITWIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:08:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id b129-v6so4655953pga.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 09:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qxKmeptjfUa2vEoMofymSdiWJ6eFCYZf96mgiQ1zm+w=;
        b=V4TgC8bV4oO1RGfvT+IaUyyihurzZ5EZzb3X4NL8Iwaqb3LUtxcqUh4oeWfeKyApZr
         twIA8oX20bRdkCtJOv8lleQcDx/pE/p5AE+9J4GF2I/FJXDnD5QWrb0MSorGa14zmV4r
         14oi/OYEVPJN0TmWQO728xeaqTOg18JqE5JT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qxKmeptjfUa2vEoMofymSdiWJ6eFCYZf96mgiQ1zm+w=;
        b=Mo/eDIPjQx/oK0xz+/Sf/UZuDHTAoqHDw4oGeoqawUKSeakmVGdJe9Rqgp726ujCEN
         wX3qa7HJUUk2ThDP3qsxCili3oWxOoeLuJJUOK3eiwack1mwkExR3sYRlXaqO/0DjqVG
         c8DVIng9wnQcgR7bDf4QTa5CFgDmdmeBbZvX5sF04V5xiCXIUIPiEOEf9dtlxZebUtdc
         318A/KRc62FhJP1rPbcVIc8SKJYBM8QIdshuVPXZ6D7jVmZmOB6WUM6zQjviQwpV+7kb
         VAVxOU0OLZQWsNviwamJWF7VtIK+1fz7Wqlng9HsMw3qDHl4dwPRHI6zDcbt+HEemutS
         7chQ==
X-Gm-Message-State: APzg51Aj2sAEgoSqAsnge6wqJQfuUUgRaRZd3eJR6ZiuLpTNnxh2226/
        16BIWx59ntU/g0qv32uAIfcdXitshcE=
X-Google-Smtp-Source: ANB0VdYjp8PYYMUUOof7sqaHQs7KaAcqqJsTYhKAzFip8yP4yFpzQ42PiwAOdkQoQu1Q4xPXeOcjYg==
X-Received: by 2002:a62:9541:: with SMTP id p62-v6mr42693655pfd.194.1537460632344;
        Thu, 20 Sep 2018 09:23:52 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id h4-v6sm25918546pgp.13.2018.09.20.09.23.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 09:23:48 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH security-next v2 08/26] LSM: Record LSM name in struct lsm_info
Date:   Thu, 20 Sep 2018 09:23:20 -0700
Message-Id: <20180920162338.21060-9-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920162338.21060-1-keescook@chromium.org>
References: <20180920162338.21060-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for making LSM selections outside of the LSMs, include
the name of LSMs in struct lsm_info.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 02ec717189f9..543636f18152 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2040,16 +2040,20 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
 				char *lsm);
 
 struct lsm_info {
+	const char *name;	/* Populated automatically. */
 	int (*init)(void);
 };
 
 extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
 
 #define DEFINE_LSM(lsm)							\
+	static const char __lsm_name_##lsm[] __initconst		\
+		__aligned(1) = #lsm;					\
 	static struct lsm_info __lsm_##lsm				\
 		__used __section(.lsm_info.init)			\
 		__aligned(sizeof(unsigned long))			\
 		= {							\
+			.name = __lsm_name_##lsm,			\
 
 #define END_LSM	  }
 
-- 
2.17.1

