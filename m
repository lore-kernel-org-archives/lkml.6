Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224GlCglm/+c8kfNnj1g+S2Kcs7CTJYjz+5e70WKXWeThS2xcS/vmwXTkX48THfiglK/eoMh
ARC-Seal: i=1; a=rsa-sha256; t=1519411709; cv=none;
        d=google.com; s=arc-20160816;
        b=InatdW7WKRnIUIIZJIvilKb+GATvu40GVW5apcDxCB/Gi9Uh/uoRBG2cDY7KkJ7AzG
         VK/H8kykN1NKlI7f1C/8VEkGhsf66YXyKptJECrORHdZehWbKBqCPh02CbphkEYGK72k
         PkSwDa7m3QS9KYJKvGix5xdAJ0DUe2oryHDZKNqhWFDcIMz4M2L8f90JG9/o4MWbJPFl
         D1oYHClfG088vo0UWxs+htA4g3Eh0pCwyz1OxV3cvTtvRkwJnke4kc5b0f/G/TLlSAUj
         PYSSN+lcsr8/htA/btnTyF18rMz67lf1mUl1tblRsVNj0u/twwStpVgwXLmV/wbIAqVL
         DL6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=R3usJtKKmHLikk168/9FOiTbZeXdKPWWulxuh5uK6Fs=;
        b=vpAm9MdF/KxzoUpW2iZrfXxkedJuREhH/iNq+wW22hfo2po06/9yD6h/yYewhltl6w
         usZIXhIH9+kbPi+7+EnZUoUCu/Ysd0gLDzUgyk5tCEZNIRwd74Bj4GDPsIZuxijUSXag
         Op2VLRKXk5JGAFksF1oq9VpeGjT4KQLW8DntsWJWZtf2/DYVnRKzuCAKL0fiiYA6Wgkb
         hFOAZjRtCXJ2UTiMUwX9ShutwCH2yyfFum/4xGKvta0tLdxGSoakxTdYMA0yq9EvNBb/
         nerQ8a45W4mhteAk0BVLvDdctyIpeHeZNEjiNxz1GkopV4kp7I1lD4S2kfocwro/RvjQ
         yYGg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.9 137/145] spi: bcm-qspi: shut up warning about cfi header inclusion
Date: Fri, 23 Feb 2018 19:27:23 +0100
Message-Id: <20180223170742.426320243@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218652822449350?=
X-GMAIL-MSGID: =?utf-8?q?1593218652822449350?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_MTD_CFI is disabled, we get a warning for this spi driver:

include/linux/mtd/cfi.h:76:2: #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work. [-Werror=cpp]

The problem here is a layering violation that was fixed in mainline kernels with
a larger rework in commit 054e532f8f90 ("spi: bcm-qspi: Remove hardcoded settings
and spi-nor.h dependency"). We can't really backport that to stable kernels, so
this just adds a Kconfig dependency to make it either build cleanly or force it
to be disabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -156,6 +156,7 @@ config SPI_BCM63XX_HSSPI
 config SPI_BCM_QSPI
 	tristate "Broadcom BSPI and MSPI controller support"
 	depends on ARCH_BRCMSTB || ARCH_BCM || ARCH_BCM_IPROC || COMPILE_TEST
+	depends on MTD_NORFLASH
 	default ARCH_BCM_IPROC
 	help
 	  Enables support for the Broadcom SPI flash and MSPI controller.
