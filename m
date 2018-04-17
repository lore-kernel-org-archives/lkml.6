Return-Path: <moritz.fischer@ettus.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523936677; cv=none;
        d=google.com; s=arc-20160816;
        b=Ap6EfOlsQ4K8d9z8bvld1UY5sxqjafgM9vJ6WCmZJwGwxyb4gBKeldYleN5TgpBgK6
         7LyB+kHzbocTslQio+0V5F16n3hzkbVbgorF513/j/QqsxqUvfOUHi3vnzpbJ+tDsNUE
         vAAmPrxbUi83rn5Y5rmj7AJ1/jh7CCP9ZOuLWJ+ZKyIdvzcwi218mcxUvfKApRABQcAp
         T/kvAh/v8P+i/YVkGT24IL6TZR4x0hNmfnK5XUD20P49QQYjq5Ph04xKupCTuAnV4Eby
         f9YMpKbYPTBD5wyU9FnX/CsAEBTWoZBiLNmjSf7UsGVUDYSRI/t/hI0uowJdNdxwfqFP
         Xecw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=ZB51aBgJpqlbKmr78UxCbUwx+qwLv1LY2G3eF+/2FQQ=;
        b=poqVtSNSnrLN2z/BezLBVbhzyuAuFgUina/ToZncK5vWU/DkC5hDn7xWCvI2TcIcL7
         drogNFB1nqDuvZ02XQpFMGYyXn5/aEwY2KWs10CBJbdEjVfrPfaIrdgsj4e6qZqnZtlj
         dcs1IJDSrRG6chbTLNX5NRgwR8uUbKP5/wH5S/iz/DbRb6LZ7/sYInRroD109cDw45wr
         EhR9edtjMBqARkW9NqrlPqwoOjg4wTGbo/b1BSJCajrlRk97mWjQA643RT2YVhnO+TC+
         nK/cJyxwqcL3QupVweAHItZ36TV9iJZGBWhrPaAgiS2T3bBuqeOSVaEGzNS5RVYalMWk
         Midg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of moritz.fischer@ettus.com) smtp.mailfrom=moritz.fischer@ettus.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of moritz.fischer@ettus.com) smtp.mailfrom=moritz.fischer@ettus.com
X-Google-Smtp-Source: AIpwx48jsoiLrXhY5FxnMya0rk4eOpf5M8jOprzfzDLDUE0Le5tMg+JILaKDYvma9pdvRQZZDlAdrg==
From: Moritz Fischer <mdf@kernel.org>
To: gregkh@linux-foundation.org
Cc: linux-fpga.vger@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	atull@kernel.org,
	robh+dt@kernel.org,
	Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 3/3] fpga: fpga-region: comment on fpga_region_program_fpga locking
Date: Mon, 16 Apr 2018 20:43:37 -0700
Message-Id: <20180417034337.8855-4-mdf@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417034337.8855-1-mdf@kernel.org>
References: <20180417034337.8855-1-mdf@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597963425463552459?=
X-GMAIL-MSGID: =?utf-8?q?1597963425463552459?=
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
index edab2a2e03ef..cb0603e07ff8 100644
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
2.17.0
