Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtN/695lZrud+Xu0sApNxuy/0fQBQ0/UH089OxfILriDETvio7e0tsbVpcmLtjtRVYvY+jx
ARC-Seal: i=1; a=rsa-sha256; t=1521214417; cv=none;
        d=google.com; s=arc-20160816;
        b=yZ9sKUyg0Cln/JjmOpB/In+CB2/QKGo3+OawPbD0MPwLm7BQVx8TF/3YloxAo90w7t
         gFMr+drwkccqg3Oc1UbETsKsf36e1/yuq7JJL7X9L9jl4RbBzJ4KRnOaNFkxEHt9T1GX
         GvPkIIG8aaa+kiwvt8Qb1UA66pJMB6PM7Eh6GDkJX/5v/ZEop57K+7xiHQlqADwgd3S+
         SwlpqD+LKyIRY1bQZB17E9ylOtigaGkHSQQqz911x2/fV5sd40qovQ4UszJMjjoq1Aws
         0heevyHsf5b9Z7wOk5sklBqknxBb3flpap6L7y4bq4SLbOHg807yLUQNm1j1JO/09di9
         hZ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jy4fgDvvLtdCtv9aetXcS3R4+668ZiL7Bb6aEZqLUDI=;
        b=eIC4aROcJNNxNX4epqBYzyduBCQaPphxaLP5YFwYJUY5AZlqfJ2RrUdKJs4nEaRQEw
         7yof7RQGKF7/bxKttZ9arr9iIAIh3wb3aerTSl17sYs3d0/s4J8vhLK8sM3jEaxAXSi3
         7pkp+NB/iNAhVe7xnY01uJM9PdYj2BAePXPO62g9yYRJtqH0NYy1AWSH9+8SynuUFhut
         L0GWJzy9DuenWmRX/+0/rRupwFgM+785vi4J/Bw+rU/qPIxg4XQkuGjma8zxb0IQ0K+5
         jVUJy1KVDYGEm+sg/lZ7YdYIQkTSzFCYriC4VRVfc4WGpmy6WQDg5QkGM3CFfD+KAhAW
         G0qA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tony Lindgren <tony@atomide.com>,
	Dan Murphy <dmurphy@ti.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.9 51/86] ARM: omap2: hide omap3_save_secure_ram on non-OMAP3 builds
Date: Fri, 16 Mar 2018 16:23:14 +0100
Message-Id: <20180316152320.856535974@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108569878736834?=
X-GMAIL-MSGID: =?utf-8?q?1595108929006380951?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
