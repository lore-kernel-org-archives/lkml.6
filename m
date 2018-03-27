Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48G/LeORIhAlDyppMNybvzHwvCcctt+4DZJKRquUWDyq48d2ZuaE45FZ/lKD/O3N1eXB/80
ARC-Seal: i=1; a=rsa-sha256; t=1522168744; cv=none;
        d=google.com; s=arc-20160816;
        b=XPfIXVxqQU4wPnmVESEmd39Sc3tetDMkG1U838kRGzCzwA6MKgD1Mq503SRZVgG3T7
         TzJ2fNJ3a4DROjiQcn06ARQ6fmmSR0U8SzyvMxcTVfOth9ayjJV5MG2+UQggE3QBF81D
         jvQ0CwuTxmn91+LCZxe3UGL7Lo5adWCBpe/E0jL89RDVPQ4v6Qnjk2vp3+/6zWEFb+bj
         Q+rjLkZ7M0mVlvDt6r7Bm1I/wsvLrQSG/1ynWkr+YHje9ef1/M4sRAXoiZC0N4cVCtO1
         m5Qrr9VUQDOpnvEEj/oyPGDUACCUM1DXPQk0VkT9R/Mb3aQHBgh0ljK14ioIOg+31mqb
         ITNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=J5fqk7G8CIh7dDT9rqyclFm8Nt3S/wL3qghf038KHiw=;
        b=ao1qYhzYr76ImVJYRyBudW3FU4m0RC3SkStVgR32H9enJupXfZkU1IdK1hgLW4lizi
         xPrVovvrs8hp+vV21lZAArCSt5K+2Dg/Dr7r5kSh/p9S8OdaBqM7/yMZg/5MAVQh72ad
         HREjUMBFib9PTPehu2zB5NPmFwHfL0fvI25fsBxrjMZUGkuf86iktDLgnNbvfdYeNBMw
         cMts6ArP6yalEIy5DHBsLeCfD4a0wJSc7NJWZ883hei5dEw8wj1J+xNfa1drif/h/xsA
         Dym5n6dhdD2WqYRGeeejAWDcFJoZh2nLcrksgpuki+hW+2levM7VFdzf+MTrJCONDT7s
         3AgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dirk Behme <dirk.behme@de.bosch.com>,
	Mark Craske <Mark_Craske@mentor.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.15 017/105] mmc: core: Disable HPI for certain Micron (Numonyx) eMMC cards
Date: Tue, 27 Mar 2018 18:26:57 +0200
Message-Id: <20180327162758.561006743@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109305254640768?=
X-GMAIL-MSGID: =?utf-8?q?1596109613531900867?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dirk Behme <dirk.behme@de.bosch.com>

commit dbe7dc6b9b28f5b012b0bedc372aa0c52521f3e4 upstream.

Certain Micron eMMC v4.5 cards might get broken when HPI feature is used
and hence this patch disables the HPI feature for such buggy cards.

In U-Boot, these cards are reported as

Manufacturer: Micron (ID: 0xFE)
OEM: 0x4E
Name: MMC32G
Revision: 19 (0x13)
Serial: 959241022  Manufact. date: 8/2015 (0x82)  CRC: 0x00
Tran Speed: 52000000
Rd Block Len: 512
MMC version 4.5
High Capacity: Yes
Capacity: 29.1 GiB
Boot Partition Size: 16 MiB
Bus Width: 8-bit

According to JEDEC JEP106 manufacturer 0xFE is Numonyx, which was bought by
Micron.

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
Signed-off-by: Mark Craske <Mark_Craske@mentor.com>
Cc: <stable@vger.kernel.org> # 4.8+
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/core/card.h   |    1 +
 drivers/mmc/core/quirks.h |    6 ++++++
 2 files changed, 7 insertions(+)

--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -82,6 +82,7 @@ struct mmc_fixup {
 #define CID_MANFID_APACER       0x27
 #define CID_MANFID_KINGSTON     0x70
 #define CID_MANFID_HYNIX	0x90
+#define CID_MANFID_NUMONYX	0xFE
 
 #define END_FIXUP { NULL }
 
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -109,6 +109,12 @@ static const struct mmc_fixup mmc_ext_cs
 	 */
 	MMC_FIXUP_EXT_CSD_REV(CID_NAME_ANY, CID_MANFID_HYNIX,
 			      0x014a, add_quirk, MMC_QUIRK_BROKEN_HPI, 5),
+	/*
+	 * Certain Micron (Numonyx) eMMC 4.5 cards might get broken when HPI
+	 * feature is used so disable the HPI feature for such buggy cards.
+	 */
+	MMC_FIXUP_EXT_CSD_REV(CID_NAME_ANY, CID_MANFID_NUMONYX,
+			      0x014e, add_quirk, MMC_QUIRK_BROKEN_HPI, 6),
 
 	END_FIXUP
 };
