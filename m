Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsQDB5I5SeSh0W/FlEjF4tuviEIIuqvS516cNmPeGQ4FNO8zeuOE0YfVbzbUZJmGa9j1W2i
ARC-Seal: i=1; a=rsa-sha256; t=1519410847; cv=none;
        d=google.com; s=arc-20160816;
        b=zAEKZGtI9aiinD38dsGcV/0sx1wcboOmaqkLSH2qB5LVTatY9IKEvtDhBmE+ASRwqk
         QjaT28Gb0n73RfSaFPPBSIEdBZg2zFpYBx3MaDW1Jto4/8aMQzPe+1ZgOsBM1I2MdLV0
         rebFRDZ6QXo4sccSV+c3nr5LdcLv4LgamxK9jwXs1mSYECUGiqn2v0NoSBuUlkc+PVGY
         Yij5kiVYEfTbf2I62QIUszDjtyczlR5VaAzJ5lBDR+cKxJJO204cmDG0jIf4rjorb07n
         5Axm+VM8DH4nQSbzWzqPL9eNvWZoz4qYudTjLT4LkD8DuFfL1GJVD/rnkZw2yjWgXP2O
         4Z6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RQsuOXjABKvuGkNd3mQIR2RTK1ZcaCOwXz7RtFGjmik=;
        b=VRc+hksujj/ddQqf0/5GDN55NO977W36blh1bmjhkKoEsDnFZhm7JN1L2S7TtpaG2y
         SI2W9nz8x0rx3Bm5CfyT6/0N0KcGEgK9bstrN/Dpyep279nmOTONLZ2KqH6tpY7Na1mm
         cglbhwS5W8KQoTF2wJPNJ5QobOA9oKEgrpgki3j/e4W0OMdNdrY8eZ6Axw3ruqudKZFB
         Kjx0bswgsBD1PF5Bbfa/x/mh0DClTaiERG5D3e1NiemluBTr1LWyYa9nsJbEF6gT4Etd
         cy1WK/nodicexVEdS80QrAWXTAl0GOtPkw89+bE6POKmTD8cz0y5u7Uydumg3bIcd86V
         /2oQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Keerthy <j-keerthy@ti.com>,
	Tony Lindgren <tony@atomide.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 032/193] ARM: AM33xx: PRM: Remove am33xx_pwrdm_read_prev_pwrst function
Date: Fri, 23 Feb 2018 19:24:25 +0100
Message-Id: <20180223170331.132737512@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217578605588769?=
X-GMAIL-MSGID: =?utf-8?q?1593217749051953028?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keerthy <j-keerthy@ti.com>


[ Upstream commit b6d6af7226465b6d11eac09d0be2ab78a4a9eb62 ]

Referring TRM Am335X series:
http://www.ti.com/lit/ug/spruh73p/spruh73p.pdf

The LastPowerStateEntered bitfield is present only for PM_CEFUSE
domain. This is not present in any of the other power domains. Hence
remove the generic am33xx_pwrdm_read_prev_pwrst hook which wrongly
reads the reserved bit fields for all the other power domains.

Reading the reserved bits leads to wrongly interpreting the low
power transitions for various power domains that do not have the
LastPowerStateEntered field. The pm debug counters values are wrong
currently as we are incrementing them based on the reserved bits.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-omap2/prm33xx.c |   12 ------------
 1 file changed, 12 deletions(-)

--- a/arch/arm/mach-omap2/prm33xx.c
+++ b/arch/arm/mach-omap2/prm33xx.c
@@ -176,17 +176,6 @@ static int am33xx_pwrdm_read_pwrst(struc
 	return v;
 }
 
-static int am33xx_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
-{
-	u32 v;
-
-	v = am33xx_prm_read_reg(pwrdm->prcm_offs, pwrdm->pwrstst_offs);
-	v &= AM33XX_LASTPOWERSTATEENTERED_MASK;
-	v >>= AM33XX_LASTPOWERSTATEENTERED_SHIFT;
-
-	return v;
-}
-
 static int am33xx_pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)
 {
 	am33xx_prm_rmw_reg_bits(AM33XX_LOWPOWERSTATECHANGE_MASK,
@@ -357,7 +346,6 @@ struct pwrdm_ops am33xx_pwrdm_operations
 	.pwrdm_set_next_pwrst		= am33xx_pwrdm_set_next_pwrst,
 	.pwrdm_read_next_pwrst		= am33xx_pwrdm_read_next_pwrst,
 	.pwrdm_read_pwrst		= am33xx_pwrdm_read_pwrst,
-	.pwrdm_read_prev_pwrst		= am33xx_pwrdm_read_prev_pwrst,
 	.pwrdm_set_logic_retst		= am33xx_pwrdm_set_logic_retst,
 	.pwrdm_read_logic_pwrst		= am33xx_pwrdm_read_logic_pwrst,
 	.pwrdm_read_logic_retst		= am33xx_pwrdm_read_logic_retst,
