Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs72VT7F5LkUkYoNPrF4mMMOE9ID9IRxAndVOiboU0c28inMXzjJqSP5l9V+XK3y6pVY4jc
ARC-Seal: i=1; a=rsa-sha256; t=1520955310; cv=none;
        d=google.com; s=arc-20160816;
        b=mrmrCdO3/R8r1dpfObPOAxJf1QIRSHhfPrjEhU8gr63KynBtjNahC6kY/O6N8FwGST
         N5+dsqWiOs4gGlThH9Jay29UrT3+J7aOKJwmWr3XwGYgxWDDQPYbmXOM2bie3T+H1hRi
         z0W+R+YWieK278/3qIxdd0tVuD8/sgC2YPcGRr5N1Ijdl5Ls2KyotMN8KCblUjJSUjAF
         fzI3buvEX20lll5u9d7ESJ3Q/0x8I7sCBvzXrB/Ih0osyNN1/eHWTZsM8c7CU8cdRIkG
         MdDUYDVL/IaX8upwb89ftVdlFwP/zjrDyPnIZc6f0wy9N5jaarsX/tI1HQf4bL04jBrK
         jHyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SLoM55vpuxBg+fd0AHGeriYXjv1LKCr/lfAVgG+YwJI=;
        b=DVtnfGkKafHrOecNVVJt49mNmTLqo6VGH+2e7iTDk0elXiOIMGA7YirdiQndn4PBhM
         mVecLZg2Hh+llsSUIVaAhp/SJ/FD0PgWax1ECdEw9ZQ50m5noZLqnR0OPesHvalT1TVc
         ADL9jpbFPBh24CH1sZ6EAkkzxSu3b08DByJ2W1Ck/b6Zean84I0ljb5MaURpCyxear2w
         JUZgM3yJLcjFje2curuNUb7f1bQKXe4lO/Sv+z6VobznP2rZKwFwKhynmZ3I8UnhO13x
         kTqvhmh7rWagj79NaLx64f88nl62e2Fl6n78rORv7xPym20wwr/aFwe2gGsGblaKNTua
         jt5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tony Lindgren <tony@atomide.com>,
	Dan Murphy <dmurphy@ti.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.14 006/140] ARM: omap2: hide omap3_save_secure_ram on non-OMAP3 builds
Date: Tue, 13 Mar 2018 16:23:29 +0100
Message-Id: <20180313152458.583753794@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837235580148592?=
X-GMAIL-MSGID: =?utf-8?q?1594837235580148592?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 863204cfdae98626a92535ac928ad79f4d6b74ff upstream.

In configurations without CONFIG_OMAP3 but with secure RAM support,
we now run into a link failure:

arch/arm/mach-omap2/omap-secure.o: In function `omap3_save_secure_ram':
omap-secure.c:(.text+0x130): undefined reference to `save_secure_ram_context'

The omap3_save_secure_ram() function is only called from the OMAP34xx
power management code, so we can simply hide that function in the
appropriate #ifdef.

Fixes: d09220a887f7 ("ARM: OMAP2+: Fix SRAM virt to phys translation for save_secure_ram_context")
Acked-by: Tony Lindgren <tony@atomide.com>
Tested-by: Dan Murphy <dmurphy@ti.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/mach-omap2/omap-secure.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm/mach-omap2/omap-secure.c
+++ b/arch/arm/mach-omap2/omap-secure.c
@@ -73,6 +73,7 @@ phys_addr_t omap_secure_ram_mempool_base
 	return omap_secure_memblock_base;
 }
 
+#if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
 u32 omap3_save_secure_ram(void __iomem *addr, int size)
 {
 	u32 ret;
@@ -91,6 +92,7 @@ u32 omap3_save_secure_ram(void __iomem *
 
 	return ret;
 }
+#endif
 
 /**
  * rx51_secure_dispatcher: Routine to dispatch secure PPA API calls
