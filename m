Return-Path: <moritz.fischer@ettus.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522338183; cv=none;
        d=google.com; s=arc-20160816;
        b=Lz2OpHY27GqBjJiCvdW4g9t42dEY9uOazOyzkPkpYjpfyG5vgIgZVpNAlj+GwMnzkz
         RiMWiH6BvI9pfZnx8R1ytyBQzoOcPZZNN078QeDk4Rjhya1F6CQ0kbufoEDO6mXigf7E
         1Lm21VpYbZkvBhHxtc+1P/vrlg1Un2CQo+sT0S4QvKWVGMxxCXEIuD3khGIdrEWGOmsE
         I+WsR4iqDpC6XQL0GwOYjuxD6nTaFCxQxTqV60EdDCOt8OCYwMRcMMOwcloOlo8LHGKk
         oknMmEmA0va2NU1ljNzwzCWJyDkepS06bIgymwRi+IUrzMVz+aL5TteTlD9TbKWfnP0J
         Bhpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=QjQJk1wJhy6BgxO4zN3hgx2qHe+Md9MXP35/yJaIzRo=;
        b=c9IurPEe6lXwxNX3nk0aeuyzm6wv0iYjQ0nsc063v6Y2mLTEDSQ6/oD1/Z1kODTxBs
         xkmxsepf4gyqoiFE21LvqPe0wv7G05bHs5z1I1/Alv/cOp9sIt/uX/VavG8ZT8Lathgy
         pt7ygaQE8QlcXQv/bms6y7B+XZvn+x9lJJUiLRtcNvwIoHIgH4TPSgCCXdeVr7NOjyuE
         rWKSHjIPqCAQcnh1MToGgirRICuvyZrMc6aMA/gIoJ6FYlO/u/pphJk75doa+N+3kQRc
         t2EHSe0JqLtcRT7G3ZGCfb91pf7d9de6C9lRtECObz4Joho7BszVl6YMe8LNWuMHP8Us
         2t6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of moritz.fischer@ettus.com) smtp.mailfrom=moritz.fischer@ettus.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of moritz.fischer@ettus.com) smtp.mailfrom=moritz.fischer@ettus.com
X-Google-Smtp-Source: AIpwx4+6jxBaXRWPAdLxmYu07/NBmq/25pDV+KCTdZF+8gzlwSnEtg3fvS2OZHEhlFImLEZlC+fvfQ==
From: Moritz Fischer <mdf@kernel.org>
To: gregkh@linuxfoundation.org
Cc: atull@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 5/6] fpga: fpga-region: comment on fpga_region_program_fpga locking
Date: Thu, 29 Mar 2018 08:36:57 -0700
Message-Id: <20180329153658.11614-6-mdf@kernel.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180329153658.11614-1-mdf@kernel.org>
References: <20180329153658.11614-1-mdf@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596287283378994827?=
X-GMAIL-MSGID: =?utf-8?q?1596287283378994827?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alan Tull <atull@kernel.org>

Add a comment to the header of fpga_region_program_fpga()
regarding locking of the bridges.

Signed-off-by: Alan Tull <atull@kernel.org>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/fpga-region.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index 660a91b9e246..3af960e24558 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -95,6 +95,11 @@ static void fpga_region_put(struct fpga_region *region)
  * fpga_region_program_fpga - program FPGA
  * @region: FPGA region
  * Program an FPGA using fpga image info (region->info).
+ * If the region has a get_bridges function, the exclusive reference for the
+ * bridges will be held if programming succeeds.  This is intended to prevent
+ * reprogramming the region until the caller considers it safe to do so.
+ * The caller will need to call fpga_bridges_put() before attempting to
+ * reprogram the region.
  * Return 0 for success or negative error code.
  */
 int fpga_region_program_fpga(struct fpga_region *region)
-- 
2.16.2
