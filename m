Return-Path: <kernel-hardening-return-11842-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227G+9fJJJe79ub5YOkRncJBWgucvhBHByrnTZychdGIaHUgwThh5MapBa8REwp9Oh/0bZZN
ARC-Seal: i=1; a=rsa-sha256; t=1519175621; cv=none;
        d=google.com; s=arc-20160816;
        b=nsgeemnqVZm1Sr3TEM8rVUvmNLuqfbdJ6nqQQ7kNyMXGxns09VIA10umtBfC2Y+iIp
         oLVIw/Wr/us59hCWpiEsln0pqI01AghEYAEhwTQv3fwZajGMTZ4xL0k8Oq3DFcNtP3kZ
         UG5UUuQknOLf2KEcAITvCM7CgotkIP7e1hEbJcG/zS5bTCt1YRyagPkyPaGziP3ROWgy
         /TSbcTKVkaAR+7yOmgbdIWNb8swn9K/9H2MDO0rMLEBssHPAvPASuu9RcaHV4DivATA8
         NBYZJs+YObIyXMP9EhIok6ucf0wi02+tvRqBnBRwNUMb62k9G3Wuze6mpj9swgLOsDMf
         Xwrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=sHXLkDbyoOLxAFqvpD+Mk/KrvARUuBBOb3/j7JVFxQA=;
        b=JVBG7cSUiVprpqUHge/F4Ae9gypX9OJ5DkfRHE4SNQab8q4GY39z4LUPnsFreJZbIh
         0tH6pNX1R+GSwCR8xe5N4pktyrNURS4edq3ymF89olmmQop5c1hxeAZ/Al2lk6WBMYXq
         By9mmE8MctmW/xBMOKCOe4Z61MtcEPS6ABu8vuFfjUwdNBCwkmsglwRl+OreOHAdwRki
         nA8Ba/YPM6kG2WGUWNRwWEKHEqC5+3nCQ0vYMmggeBAZg8wFX3ah3OUwFlvyNtLi9h/b
         1QhDnnNgAH6fGdGtARaZuNRQXCGpJaGttCXBtJjwbbr/JcU0bUn8o3Nsr11XDW+gFbPQ
         PFEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11842-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11842-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11842-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11842-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Laura Abbott <labbott@redhat.com>
To: Alexander Popov <alex.popov@linux.com>,
	Kees Cook <keescook@chromium.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Laura Abbott <labbott@redhat.com>,
	kernel-hardening@lists.openwall.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] stackleak: Update for arm64
Date: Tue, 20 Feb 2018 17:13:02 -0800
Message-Id: <20180221011303.20392-2-labbott@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180221011303.20392-1-labbott@redhat.com>
References: <20180221011303.20392-1-labbott@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592971096374608879?=
X-GMAIL-MSGID: =?utf-8?q?1592971096374608879?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


arm64 has another layer of indirection in the RTL.
Account for this in the plugin.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 scripts/gcc-plugins/stackleak_plugin.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/gcc-plugins/stackleak_plugin.c b/scripts/gcc-plugins/stackleak_plugin.c
index 6fc991c98d8b..7dfaa027423f 100644
--- a/scripts/gcc-plugins/stackleak_plugin.c
+++ b/scripts/gcc-plugins/stackleak_plugin.c
@@ -244,6 +244,11 @@ static unsigned int stackleak_final_execute(void)
 		 * that insn.
 		 */
 		body = PATTERN(insn);
+		/* arm64 is different */
+		if (GET_CODE(body) == PARALLEL) {
+			body = XEXP(body, 0);
+			body = XEXP(body, 0);
+		}
 		if (GET_CODE(body) != CALL)
 			continue;
 
-- 
2.14.3
