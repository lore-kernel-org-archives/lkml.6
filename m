Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs23HMQ/9uJcgBqkIMPpLDaQP1W/UY9ENs77uVVdjnFllCcCSxQ4Q8u4vqLs+hWCC8etqrZ
ARC-Seal: i=1; a=rsa-sha256; t=1521483639; cv=none;
        d=google.com; s=arc-20160816;
        b=t3e7fGrusTl7bJb8CL/o7oTec31cw8Xg2oig5VhNgL22TsZ1pBjqjv/P15/dnPOHL7
         wSiFRrJcocTX+/wsnAQNULqU/COquYgdgH6QjT4RGcKwh2XOoUZ/gs2Kvmm6nxZWuKiP
         PlO73GPijRvlbq9ugdWKRkYr5Mic912iQLQJJn1iOOiOrV3+oT4ds940bCEFTXO9DUYr
         JziM5vcZWnJSMBcOrSlfBTmgm2DDTc5PTXF78hpHumu6Oo9INOfyWz3py2snTjqrjCGX
         ssO7+06y5QLY+CuNUCkjbCslLMoZ3CkeZGWT2JzGpsgYiDaZk0AK6Eyj5mCBykNC0Q1V
         Zj2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rHaZRoX4Iitc3yEyjnxYrHqUZNQBVDNaNf6prpAfzYs=;
        b=SFq9mZz95AOxfa4Rb2HloRd5kvIBYnkXOaqWWi94CAXT5brlpvPe/0/DOl4X55xHLR
         OZneEUbtMGdWJQqfBNtz6KU6nvmbnxipzgSy9VtO+iIfH7KMshRqhnBjtyFARbjJDkIC
         06OTfzdkTrlmi4hLBF2JtvoxiWW76KVW8fXPa30o0RtTraSu4m2bzO5bfYz8tUSN+8tm
         zh25QeKLRVTQq3FqJ0jEX419kbSKbOa17Ejk/plmwvtEiQSRmJKn9rSm7HzRf5x9uVyi
         wDQVq9Vikwq7K4QzJJo7BRwb2hhcnMSdm+BxwvIOVirj2byW5z9rs1BP6dp52VOsIrBJ
         3kCA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Al Cooper <alcooperx@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 027/241] ARM: brcmstb: Enable ZONE_DMA for non 64-bit capable peripherals
Date: Mon, 19 Mar 2018 19:04:52 +0100
Message-Id: <20180319180752.292056472@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391229318140221?=
X-GMAIL-MSGID: =?utf-8?q?1595391229318140221?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Cooper <alcooperx@gmail.com>


[ Upstream commit 3c51b9c7f1fae00c25f1e34da649a288e3fea1ae ]

Some Host Controller hardware blocks, like the OHCI, EHCI and SDIO
controllers, have hardware blocks that are not capable of doing 64 bit
DMA. These host controllers fail on boards with >3GB of memory because
the memory above 3GB is located physically >= 0x100000000 and can only
be accessed using 64 DMA. The way Linux is currently configured for
BRCMSTB systems, the memory given to drivers for DMA through functions
like dma_alloc_coherent() comes from CMA memory and CMA memory is taken
from the top of physical memory. When these drivers get a DMA buffer
with an address >=0x100000000, they end up dropping the upper 32 bit of
the address causing the hardware to DMA to incorrect memory, typically
BMEM (custom memory carveout). This issue was discovered on a
BCM97449SSV_DDR4 system with 4GB or memory.

The fix is to enable CONFIG_ZONE_DMA. On ARM systems this makes sure
that all DMA memory is located within the first 32 bits of address
space.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-bcm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -199,6 +199,7 @@ config ARCH_BRCMSTB
 	select BRCMSTB_L2_IRQ
 	select BCM7120_L2_IRQ
 	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
+	select ZONE_DMA if ARM_LPAE
 	select SOC_BRCMSTB
 	select SOC_BUS
 	help
