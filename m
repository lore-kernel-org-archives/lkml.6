Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06175C04E87
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9AF9216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="ZheSHKsU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9AF9216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbeI1ATA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:19:00 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38408 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbeI1AS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:18:59 -0400
Received: by mail-ed1-f66.google.com with SMTP id x8-v6so5867658eds.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 10:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3Gm1dPbYL0xuWI3ULCZGB4Vn02KOLqVYdbubTdPf5ew=;
        b=ZheSHKsUDX2/1ui/M2Yeg4XuaxwFUUTmEDORywTuVokXhCdLo/yotzId22FYT+VlmK
         0W6/4zDphgvue2HpAHDwYEPdQNrE2NfQ1tuIdzz6Oh/LExymYMcjCcf9GYHDiKKEhZFJ
         6wGXNLM2u8lNWKhKiu4Wkz6g3bhWZkqzrjC/G0PAHuT4FR9bx4R2QNSJmYI8qF6LZL3N
         LtJJe4hff6KkKeD+fTGJFQS7wpVoG33dUB8cc93PJ4tWrO7rUzx4GpN6bisi4yGHxAot
         vKIhFYNkfqqTzDJNdx8Cn7JV1yMFf4ERWT1euDiQ8vE3QffcnU5GdPMRqyXSqiyW2S6l
         oi3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3Gm1dPbYL0xuWI3ULCZGB4Vn02KOLqVYdbubTdPf5ew=;
        b=I2/jLwgG84IFNIF+Cpydxt3htv4VbSZ5wX0iZ3KFq7nt72AWZZt7EUbtDlbi4VAVIN
         rYahpEE5iBULLtFdYMqzWewB8QmrMaxTKaxySgOmJtUnSaLKT+6jcDDYd0doLg6L5XWs
         KORpMf8HIxr8HvWn5Sc3dS9hwtLgHcwP13rIPaHrBxFvHldSLKT6vE8DccJTZ8go+b+1
         hPWOr4x0HXDdCZ4B+D09LNNwUTS71Hx+Gq74SOPciTpsLcJQ5PfDcVV/sYjqxaDAaTFf
         IAeH3qm2zCih/BFUAhbPYlAFWKlYv/0c0QFzgCrCh1ch381N0KI07RgfYjlVnMqzq5I5
         yKiQ==
X-Gm-Message-State: ABuFfoiJoNixGfvOvX3VStNVPfNT3eunY9zEg7rgmFeMM5XOd/JzYU7j
        8Ikd56SOJpJwgz3qSj3PGnPKJg==
X-Google-Smtp-Source: ACcGV631gh+1sj/PQuri3kacPfaUvUYLBDQmVJ7GhLLEdEli06pSzXZJZlmipigegxeMLVdIm8uK6Q==
X-Received: by 2002:a50:d307:: with SMTP id g7-v6mr7366256edh.221.1538071172070;
        Thu, 27 Sep 2018 10:59:32 -0700 (PDT)
Received: from localhost.localdomain (fa-padur-binz.ediscom.de. [212.204.40.18])
        by smtp.gmail.com with ESMTPSA id a9-v6sm1532606edi.26.2018.09.27.10.59.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 10:59:31 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     jbenc@redhat.com, davem@davemloft.net, dsahern@gmail.com,
        stephen@networkplumber.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Brauner <christian@brauner.io>
Subject: [PATCH net-next 1/7] rtnetlink: add RTM_GETADDR2
Date:   Thu, 27 Sep 2018 19:58:51 +0200
Message-Id: <20180927175857.3511-2-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180927175857.3511-1-christian@brauner.io>
References: <20180927175857.3511-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various userspace programs (e.g. iproute2) have sent RTM_GETADDR
requests with struct ifinfomsg. This is wrong and should have been
struct ifaddrmsg all along as mandated by the manpages. However, dump
requests so far didn't parse the netlink message that was sent and
succeeded even when a wrong struct was passed along.

Currently, the message is parsed under the assumption that the correct
struct ifaddrmsg is sent down. If the parsing fails the kernel will
still fulfill the request to preserve backwards compatability but a
rate-limited message that there were leftover bytes after parsing the
message is recorded in dmesg. It has been argued that this is
unacceptable [1].

But various new features that got and will get added to RTM_GETADDR make
it necessary to definitely know what header was passed along.
This is currently not possible without resorting to (likely unreliable)
hacks such as introducing a nested attribute that ensures that
RTM_GETADDR which pass along properties such as IFA_TARGET_NETNSID
always exceed RTM_GETADDR requests that send down the wrong struct
ifinfomsg [2]. Basically, multiple approaches to solve this have been
shut down. Furthermore, the API expressed via RTM_GETADDR is apparently
frozen [3] so the wiggle room at this point seems very much zero.

The correct solution at this point seems to me to introduce a new
RTM_GETADDR2 request. This way we can parse the message and fail hard if
the struct is not struct ifaddrmsg and can safely extend it in the
future. Userspace tools that rely on the buggy RTM_GETADDR API will
still keep working without even having to see any log messages and new
userspace tools that want to make user of new features can make use of
the new RTM_GETADDR2 requests.

[1]: https://lists.openwall.net/netdev/2018/09/25/59
[2]: https://lists.openwall.net/netdev/2018/09/25/75
[3]: https://lists.openwall.net/netdev/2018/09/26/166

Signed-off-by: Christian Brauner <christian@brauner.io>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Benc <jbenc@redhat.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>
---
 include/uapi/linux/rtnetlink.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
index 46399367627f..e167f90c3d7a 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -157,6 +157,9 @@ enum {
 	RTM_GETCHAIN,
 #define RTM_GETCHAIN RTM_GETCHAIN
 
+	RTM_GETADDR2 = 106,
+#define RTM_GETADDR2  RTM_GETADDR2
+
 	__RTM_MAX,
 #define RTM_MAX		(((__RTM_MAX + 3) & ~3) - 1)
 };
-- 
2.17.1

