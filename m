Return-Path: <jinb.park7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520335370; cv=none;
        d=google.com; s=arc-20160816;
        b=tcw9SRqRJ+9hLNQqm8QmSt+ywTa9WdE+5sVD7wD9OLUrnULAzf/a29PS6/hEU1V+AW
         Pu8uaOeXDJpqeJo2H0mrNk9kXJIWeDVT8KhZvNBNX/V7GswQzW96idMEB+SKoHMfXrNq
         Cs6BSEviMf1RgTHehWHvgoqD5TLpAcbC2o8ndyVhrQXCxxGGQIbIbC8pQ7x1wUfvhzD1
         /awPJFPetiypE7aeHne1tA5ZHAoG5KPxEh0d/BD+4bSf0zJ1S7Lcbxec0UwVhsMr69X0
         myYMZCScl5xAIlHjkxQ/AXiDGxNsDNtpNml7JSNoTsKJ8O+DK2m33GUJB3bAZeI5ObUE
         sP0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=PB5p/v89tu0o4I175OEjSoX/f0w7bSlM0/LZNjgFgEU=;
        b=Xq8Ahxb6Ecn2z+t65PP4jselSaEXJhuwUMnybNBNWeUVJ6fT6Xq1y1BL+0PNsIIolB
         Jwrhl4mWEwOgz6o6SfRlFnTNSEanTgkYlip+yDwgxnjrR3BcAkc4ZXUaXP5mE6XPQoPz
         bxRYtTRwVtzn1FVeJEljyaSdgM+Ik4M/l3HvUOmUkgBU1pF01ItToeJWmZE25FuowdY7
         VEB+VgII5/pkRyGAaMYkAefPjAZxspjhCBrGEHO5NyfzNAe6HhknVedv5ByDyYQnuGj3
         /57RWYukOV2iLM+azmboJVZjRvI9FN+Lrmuf6pEsshIvog00IlOEZt78ul52k4G30NWZ
         Xnzg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MWxx6H13;
       spf=pass (google.com: domain of jinb.park7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jinb.park7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MWxx6H13;
       spf=pass (google.com: domain of jinb.park7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jinb.park7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvCghsxxEKKacuPhn1d+vLVHpv2GlcXe8hJqI3CHqevu/GG6Q3XOfqqLGHwccldimPUMfzrSQ==
Date: Tue, 6 Mar 2018 20:22:41 +0900
From: Jinbum Park <jinb.park7@gmail.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org, vladimir.murzin@arm.com,
	keescook@chromium.org, will.deacon@arm.com, mark.rutland@arm.com,
	catalin.marinas@arm.com
Subject: [PATCH] arm: mm: Kconfig: Disable KUSER_HELPERS in ARMv6 or later as
 default
Message-ID: <20180306112241.GA5938@pjb1027-Latitude-E5410>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594187181647482868?=
X-GMAIL-MSGID: =?utf-8?q?1594187181647482868?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Codes for KUSER_HELPERS can be abused as ROP gadaget,
So that It's better to disable that as if possible.

Since over ARMv6 has ldrex/strex at user-space,
NEED_KUSER_HELPERS is not selected for over ARMv6.

But, Even though NEED_KUSER_HELPERS is not selected,
current configuration enable KUSER_HELPERS as default.

* as-is

- Enable KUSER_HELPERS as default even though over ARMv6.
- User can disable KUSER_HELPERS.

* to-be

- Disable KUSER_HELPERS in ARMv6 or later as default.
- User can enable KUSER_HELPERS for compatibility.

This change removes the unnecessary configuration that has security-risk.

Signed-off-by: Jinbum Park <jinb.park7@gmail.com>
---
 arch/arm/mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 7f14acf..40e5fe5 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -840,7 +840,7 @@ config NEED_KUSER_HELPERS
 config KUSER_HELPERS
 	bool "Enable kuser helpers in vector page" if !NEED_KUSER_HELPERS
 	depends on MMU
-	default y
+	default y if NEED_KUSER_HELPERS
 	help
 	  Warning: disabling this option may break user programs.
 
-- 
1.9.1
