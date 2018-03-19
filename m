Return-Path: <mika.westerberg@linux.intel.com>
X-Google-Smtp-Source: AG47ELsX2Utin8w0bNSIGQgbnW2sn4Aqdk+gnRYqd/wB9pZi0Tggx8UxrjnViuZFeD0q9rE05Tdz
ARC-Seal: i=1; a=rsa-sha256; t=1521476833; cv=none;
        d=google.com; s=arc-20160816;
        b=ZVm7kl0jodpOl8MQvIhjnFh99qqDXP0b2zx0CuKD4LYHJxYzPciIld6IOhph7Zww0a
         EYCsYbDngYnGwJ+Jg/tZo/YagR61xNAWU8WXLrSdNG7gGJct9/w71G/egEhU5yUcEwDO
         0SuRd9QHsI0FDLYt6wvZAJtLZuO0s4owGKhCqybsUb7jxtieJJRpksummZRbS9ep4lHw
         SZSbQNv6pabt5+Q1IkCIWRj+0H+a9UCRIqpx+jBzuvrwv1UQGexsSPWn6jfe66z+3Kq8
         eN67iQLOcAZSFAOHlLqbdRKLyJaFC9OJRzLWInvTBqZkqrRRKsjbtw1Xz8lQS2OGCP/B
         uOxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=2icwzmy+QMXVvbdgKXt/L5Ge4/tI2skVFW6YJlNxt0U=;
        b=ajAF6HTZXlUKDYuF4tcRgwFRX+SnF/zTo0zaL2tyRdlKG+p5w5BHMtesbIGLF/+LkH
         FAwmAE7OkFMvxgTpG+rnxkQwhYuSv2DT1qBA1nUokTVXFwrIO1M+etTUwWjPmdSLNjHb
         4ceVX0tcp1odgwwZDFpr1tDouvKS+x8VwZayq/4MAsFJcbyBYNscUYXLmN3LvMXzq9h0
         68fMfxa/FCf4TKmQBpEGXqik0Nkj6ND0M2wEptKjYS1QwM2GAnO+7h+4FUkQs5V+/Wu6
         ZYH9xCDKjOL7ovLPu5OuY3YkX5lJxSlxujHFIWxWSe763rTtG99s3yEhDWX8COov4H6T
         aVpQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,331,1517904000";
   d="scan'208";a="43391209"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <yehezkel.bernat@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 19/19] thunderbolt: Prevent crash when ICM firmware is not running
Date: Mon, 19 Mar 2018 19:27:03 +0300
Message-Id: <20180319162703.5331-20-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319162703.5331-1-mika.westerberg@linux.intel.com>
References: <20180319162703.5331-1-mika.westerberg@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595384091718354688?=
X-GMAIL-MSGID: =?utf-8?q?1595384091718354688?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Lenovo ThinkPad Yoga 370 (and possibly some other Lenovo models as
well) the Thunderbolt host controller sometimes comes up in such way
that the ICM firmware is not running properly. This is most likely an
issue in BIOS/firmware but as side-effect driver crashes the kernel due
to NULL pointer dereference:

  BUG: unable to handle kernel NULL pointer dereference at 0000000000000980
  IP: pci_write_config_dword+0x5/0x20
  Call Trace:
   pcie2cio_write+0x3b/0x70 [thunderbolt]
   icm_driver_ready+0x168/0x260 [thunderbolt]
   ? tb_ctl_start+0x50/0x70 [thunderbolt]
   tb_domain_add+0x73/0xf0 [thunderbolt]
   nhi_probe+0x182/0x300 [thunderbolt]
   local_pci_probe+0x42/0xa0
   ? pci_match_device+0xd9/0x100
   pci_device_probe+0x146/0x1b0
   driver_probe_device+0x315/0x480
   ...

Instead of crashing update the driver to bail out gracefully if we
encounter such situation.

Fixes: f67cf491175a ("thunderbolt: Add support for Internal Connection Manager (ICM)")
Reported-by: Jordan Glover <Golden_Miller83@protonmail.ch>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Yehezkel Bernat <yehezkel.bernat@intel.com>
Cc: stable@vger.kernel.org
---
 drivers/thunderbolt/icm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 6b1041677604..2d2ceda9aa26 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -1452,6 +1452,9 @@ static int icm_firmware_reset(struct tb *tb, struct tb_nhi *nhi)
 	struct icm *icm = tb_priv(tb);
 	u32 val;
 
+	if (!icm->upstream_port)
+		return -ENODEV;
+
 	/* Put ARC to wait for CIO reset event to happen */
 	val = ioread32(nhi->iobase + REG_FW_STS);
 	val |= REG_FW_STS_CIO_RESET_REQ;
-- 
2.16.2
