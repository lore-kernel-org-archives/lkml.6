Return-Path: <shea@shealevy.com>
X-Google-Smtp-Source: AG47ELtWTQjm/66KmFHoUtC2xjcEmI4g/S+lXywCEm1mT3FEunR+zcp4/D/+X7uQELojJGQ1DKkc
ARC-Seal: i=1; a=rsa-sha256; t=1522269439; cv=none;
        d=google.com; s=arc-20160816;
        b=vEeEhD5v9j2vo0BIgjzUsRQPDyK3LEk8P0jdRj6D+TtvaS8hS1SIhj0LzXbh3BPiy1
         9NSITId1qi9CfGZkg5Xttp+qxgC4HMe7Y5omt1j2ES/Bv3DxsYLK5QcEakqxzBHA4B64
         rqlB5P3032niRuNdC80uoPK2WztdMscuJ6QiLx0eemB5ZABO3JFr/AKs55eIxVJLF2HP
         iuh0H81dI/tgpzU6Xk6e6JnyWp4hL27n3Stay6GpkKFUk1rIg41kDHnZa8RJBoVLrIkC
         7/FRXYqOqv+lt7N8D92r6ov2A6cwrUni/Mr1GqUyOUeKGqThGXHuNoOorue1mCnJDeqG
         DFeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=YHlar/vuZ69qyNH5x6AjCWemVsW7AIUJWUxd+OmphKM=;
        b=uUKwuEYBEzjJXkaqUnbWbQ+eh9Jlz5SepTTW42XrUHpJjNbjKm8csFZDVediW2gP1y
         GyaS7kyZXSsvVm86GIFVyEMmYBWNrlO6B0wp65BpkoLudVrIVzIZUJrM2iGhvXhOqmDA
         TwU5Sti0jrwYXUyS/18V6Skf34Ec1gfXP05WKqXO5aJ610qapnUTRweW1Qnp0vBgbUN2
         ldM3uDicCA/9RZjqCZdnywp4XVTo+OGByWq1oYUy4R2wVFC99KBE5Yp/nbK+b2O8H5q3
         w3u0PuP45ZCG2xniV1R6fk+IxNtDEO2nIjSreR5PCwa3/s8ucvUpD+PGvy2LFsEk2Y/g
         glwg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of shea@shealevy.com designates 216.40.44.205 as permitted sender) smtp.mailfrom=shea@shealevy.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of shea@shealevy.com designates 216.40.44.205 as permitted sender) smtp.mailfrom=shea@shealevy.com
X-Session-Marker: 7368656140736865616C6576792E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,,:::::::::::::::::::,RULES_HIT:41:355:379:541:800:960:965:966:973:988:989:1260:1345:1359:1534:1539:1567:1711:1714:1730:1747:1777:1792:1978:2196:2199:2393:2559:2562:3138:3139:3140:3141:3142:3876:3877:4321:4385:4390:4395:4605:5007:6114:6261:6642:10004:10848:11026:11473:11658:11914:12555:12895:13069:13311:13357:14181:14384:14394:14721:21080:21451:21627,0,RBL:71.235.10.46:@shealevy.com:.lbl8.mailshell.net-62.4.0.191 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:ff,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:23,LUA_SUMMARY:none
X-HE-Tag: trip39_3fb509c365724
X-Filterd-Recvd-Size: 1630
From: Shea Levy <shea@shealevy.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Shea Levy <shea@shealevy.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Deepa Dinamani <deepa.kernel@gmail.com>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH v4 01/16] initrd: Add weakly-linked generic free_initrd_mem.
Date: Wed, 28 Mar 2018 16:36:44 -0400
Message-Id: <20180328203659.18692-2-shea@shealevy.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180328203659.18692-1-shea@shealevy.com>
References: <20180328152714.6103-1-shea@shealevy.com>
 <20180328203659.18692-1-shea@shealevy.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596215199335064200?=
X-GMAIL-MSGID: =?utf-8?q?1596215199335064200?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Shea Levy <shea@shealevy.com>
---
 init/initramfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/init/initramfs.c b/init/initramfs.c
index 7e99a0038942..c8fe150f958a 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -526,6 +526,11 @@ extern unsigned long __initramfs_size;
 #include <linux/initrd.h>
 #include <linux/kexec.h>
 
+void __init __weak free_initrd_mem(unsigned long start, unsigned long end)
+{
+       free_reserved_area((void *)start, (void *)end, -1, "initrd");
+}
+
 static void __init free_initrd(void)
 {
 #ifdef CONFIG_KEXEC_CORE
-- 
2.16.2
