Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqARRZugNMwQ7zeCzyOIiLEMXRDWHJXxEqUNpooHx/hdW/KP/TVHqnrHwOunIjSI7x6ih65
ARC-Seal: i=1; a=rsa-sha256; t=1524838304; cv=none;
        d=google.com; s=arc-20160816;
        b=mtW45/o//VwMxUONeiSIoFCQ/BWJBliDuFmVjt+cC8YbdOecZx9qpBHxPcJsBSJf0p
         +tIgQYtcERochxszcNWfu40jpedOt2VblpusrE98y9xg44FOQzt+6LG1GAd34jQ1RE72
         eZ0HNtCRbRK1pN4FU30NknZCgbcGwz9n4qNmn/E4XsuvMJSfkn3tsjhvtUE7BEGyORbi
         NX09RB+d3i9sF4h63qKpW46N1gBkoRfJxQzN/KoahXUc+/+OCnh/eMtZ4QsJYkcOj6hY
         JxbcokKtxWoxDz4ljTTspMRSJr59PNNEEhvXr0Mi4e2hzAYt1BJh8pvz4KD7TrKtr0PN
         s2WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=mLZ0taQNOkblipXKj8kng6OuV61jxMkYTvvMaq/Sd2k=;
        b=HQ5czspqBZKFObilzpV1T9n4qDFlBpwPwt3q0F+oZnGih4IPlvSOiyHGAUswzsBr6q
         FvNGR1tJNKMQmtuRApmVNqnZ1UTj6khbcw/keqgb756ITH8NNix0mVt4UPuIshd+B2Qg
         ZWosWeD9cDH/yEgWz6KIaQkUPv21TBrUa1t43++V1msiFLjkgo8ykKrerIeKkhhA1wRH
         6YOSE/3mPXJWCZh45Ok/06JHvVZAgKy3+eUvEgifq8kXZ8xCM8qUXxsu/CghtqEcAsx0
         5eESwgk9aNqXexNaF+DyYJafJdkdNLTvqq8w5QmSnhtQjVRLnrmEHwFQRFio+Jhk5rve
         QhrQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C122189E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Igor Russkikh <igor.russkikh@aquantia.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 55/81] net: aquantia: Regression on reset with 1.x firmware
Date: Fri, 27 Apr 2018 15:58:57 +0200
Message-Id: <20180427135746.500749185@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908849814273358?=
X-GMAIL-MSGID: =?utf-8?q?1598908849814273358?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Igor Russkikh <igor.russkikh@aquantia.com>


[ Upstream commit cce96d1883dae4b79f44890e5118243d806da286 ]

On ASUS XG-C100C with 1.5.44 firmware a special mode called "dirty wake"
is active. With this mode when motherboard gets powered (but no poweron
happens yet), NIC automatically enables powersave link and watches
for WOL packet.
This normally allows to powerup the PC after AC power failures.

Not all motherboards or bios settings gives power to PCI slots,
so this mode is not enabled on all the hardware.

4.16 linux driver introduced full hardware reset sequence
This is required since before that we had no NIC hardware
reset implemented and there were side effects of "not clean start".

But this full reset is incompatible with "dirty wake" WOL feature
it keeps the PHY link in a special mode forever. As a consequence,
driver sees no link and no traffic.

To fix this we forcibly change FW state to idle state before doing
the full reset. This makes FW to restore link state.

Fixes: c8c82eb net: aquantia: Introduce global AQC hardware reset sequence
Signed-off-by: Igor Russkikh <igor.russkikh@aquantia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c |   16 +++++++++++
 1 file changed, 16 insertions(+)

--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c
@@ -48,6 +48,8 @@
 #define FORCE_FLASHLESS 0
 
 static int hw_atl_utils_ver_match(u32 ver_expected, u32 ver_actual);
+static int hw_atl_utils_mpi_set_state(struct aq_hw_s *self,
+				      enum hal_atl_utils_fw_state_e state);
 
 int hw_atl_utils_initfw(struct aq_hw_s *self, const struct aq_fw_ops **fw_ops)
 {
@@ -247,6 +249,20 @@ int hw_atl_utils_soft_reset(struct aq_hw
 
 	self->rbl_enabled = (boot_exit_code != 0);
 
+	/* FW 1.x may bootup in an invalid POWER state (WOL feature).
+	 * We should work around this by forcing its state back to DEINIT
+	 */
+	if (!hw_atl_utils_ver_match(HW_ATL_FW_VER_1X,
+				    aq_hw_read_reg(self,
+						   HW_ATL_MPI_FW_VERSION))) {
+		int err = 0;
+
+		hw_atl_utils_mpi_set_state(self, MPI_DEINIT);
+		AQ_HW_WAIT_FOR((aq_hw_read_reg(self, HW_ATL_MPI_STATE_ADR) &
+			       HW_ATL_MPI_STATE_MSK) == MPI_DEINIT,
+			       10, 1000U);
+	}
+
 	if (self->rbl_enabled)
 		return hw_atl_utils_soft_reset_rbl(self);
 	else
