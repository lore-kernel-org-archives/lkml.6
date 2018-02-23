Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226s/2W0JW2HZL3jN5zKjuZ/ImxUSmJuEWOOgJ9hkAJmM3feZX6i9OrrfrdeRNBMVYY4Gdq1
ARC-Seal: i=1; a=rsa-sha256; t=1519411026; cv=none;
        d=google.com; s=arc-20160816;
        b=xl91regLCuiiCYLkRg25yfDoZk5VhHtwRL+4f7ow2FByfipRIQxG42GXvKg7vgSXym
         iiHk2PlZNhBF4KBIT035zBNtIR0bNRJMmAzUAXIGiqJhulbqQVVDihDlEiL8FrwMlxvk
         4MAztc4oEBpkn4P0/HdRyeQp2uGWEBRFx0837UfLRwVCfPRDOVjV1fqD1sIvmTOASqof
         oiYwRCTBj0cMti7lwrhx6zSLuI61J24NCHCZpGKoMjVNqqoNl2TZKEwCqs4D9aGUFznE
         EwQ+dhA7WvOzFWgLM5c9x6qBcTz1CBpS3nnd6X9GVbuLC+RSM+VkT+0GtDKuQdP0185O
         spKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=v39AaBdXlaf9V4fXlc+/OcGklOeT1waAxf3K9S/lc5k=;
        b=abFj0mrGRJwEQu+rat9dyrcdN08IuwlsmwahRq/beRVnaKZJdIAHLBNBQu6FT8YK9v
         vqK4Mxj4sYAUSci7CiwdiSlZWQch0pxp+kn4wPIre0K3j8sHR1t819g32PkK3gDi4Ljm
         IEXSX2wNTzMLmreqdfLQXwVO6mPz1wQSMLfRyUVdKdtL5cgc2QB3pYDcl4QHgohN23WN
         bsCtTYnIA2NB7xveNdsRW+H4OMIA/z55+Ek1CHjqwO2B+c8208ivCnZ6UsRIcKgS1j6t
         mxpbLVpbP26s2Ui8vdioVM4tnm5y0Qz8hbFG4OVKoc/YXKVdtubv1uAPWfUOmHe2g/A5
         gqMQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 4.4 095/193] fbdev: sis: enforce selection of at least one backend
Date: Fri, 23 Feb 2018 19:25:28 +0100
Message-Id: <20180223170340.887101881@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217935954581915?=
X-GMAIL-MSGID: =?utf-8?q?1593217935954581915?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 5b833fea4377577eafecb888141a05470922ef25 upstream.

The sis framebuffer driver complains with a compile-time warning
if neither the FB_SIS_300 nor FB_SIS_315 symbols are selected:

drivers/video/fbdev/sis/sis_main.c:61:2: warning: #warning Neither CONFIG_FB_SIS_300 nor CONFIG_FB_SIS_315 is se

This is reasonable because it doesn't work in that case, but it's
also annoying for randconfig builds and is one of the most common
warnings I'm seeing on ARM now.

This changes the Kconfig logic to prevent the silly configuration,
by always selecting the FB_SIS_300 variant if the other one is
not set.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/fbdev/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1506,6 +1506,7 @@ config FB_SIS
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	select FB_BOOT_VESA_SUPPORT if FB_SIS = y
+	select FB_SIS_300 if !FB_SIS_315
 	help
 	  This is the frame buffer device driver for the SiS 300, 315, 330
 	  and 340 series as well as XGI V3XT, V5, V8, Z7 graphics chipsets.
