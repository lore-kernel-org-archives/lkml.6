Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226qwQ/isKjlvHcmb+nWIh35cWG2P9Ev4X9XrgmoqkUKfbc5WMqYCtvrbOeGQy9phXKRB7mb
ARC-Seal: i=1; a=rsa-sha256; t=1517591135; cv=none;
        d=google.com; s=arc-20160816;
        b=QT5AcLNjybB64NwHCkzkWXGd3LFmGfsLQ2ZXcV+kE2ikeYBreFOZspRcFfOXCgVXLO
         qlA1i0s3kEDWWfGdzE0lAzLcLB+xX2FORhTlDUMO5FhjCG18lwFdOAVpIcwstRdYMraz
         +kmoYGFtk3W7IB+ua5tuqxPFRyBk8aiL9IW2SA2so9nrHQeYLa9B2ew9qQNsCwv1feiT
         jBZL8QGerT7Va+jy4Ukkou9MqHCyCmQ5OP0bZBTTY0No4C2wQQ3slldHYJIcBcf0rNFA
         W069DEBQh3E81qHSUqDa2DNGuTappzyme5kKesApoB7M8y8tz0x6YICyZMkm0NAzupTJ
         kCqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=D/Yqnn3gj+4RxvYMahiDE9yxK1s3D3AzvVUctMMTJHA=;
        b=ATBJcUoq3FHt8SP4Rpqjh40E+wRN1E52bilnRxF8RGfiI+YZIj5bkfDVyBXgzeRJKU
         zvdnyPULIV9SuqIWZlmNAtpuVkWCNb5cK//XKO974qBa4eKm2iiw1a6sExT+1mJ1mRjL
         V4vLTmQoY5zENDuHEX9eMMB4yXcEXwVLG0dd82WKbewjjGqMg3ekf+F7pRAu8T2DCAUO
         U/t5+a0V1QzC7C/SVtHoevdvXmrlGMZ2N60woWuPYdsv302D35nulcQiEUBqyoLHljZp
         qs03VjEUGUcNjFKmDqvPrsImfdK/dqv9OEdElTaFxk+whFD3gi4C//zebs8hbotG+SxB
         Io2A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>,
	Subhash Jadavani <subhashj@codeaurora.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 64/86] scsi: ufs: ufshcd: fix potential NULL pointer dereference in ufshcd_config_vreg
Date: Fri,  2 Feb 2018 17:58:24 +0100
Message-Id: <20180202140828.538551432@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309395625912256?=
X-GMAIL-MSGID: =?utf-8?q?1591309643152346220?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>


[ Upstream commit 727535903bea924c4f73abb202c4b3e85fff0ca4 ]

_vreg_ is being dereferenced before it is null checked, hence there is a
potential null pointer dereference.

Fix this by moving the pointer dereference after _vreg_ has been null
checked.

This issue was detected with the help of Coccinelle.

Fixes: aa4976130934 ("ufs: Add regulator enable support")
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Reviewed-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/ufs/ufshcd.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -5327,12 +5327,15 @@ static int ufshcd_config_vreg(struct dev
 		struct ufs_vreg *vreg, bool on)
 {
 	int ret = 0;
-	struct regulator *reg = vreg->reg;
-	const char *name = vreg->name;
+	struct regulator *reg;
+	const char *name;
 	int min_uV, uA_load;
 
 	BUG_ON(!vreg);
 
+	reg = vreg->reg;
+	name = vreg->name;
+
 	if (regulator_count_voltages(reg) > 0) {
 		min_uV = on ? vreg->min_uV : 0;
 		ret = regulator_set_voltage(reg, min_uV, vreg->max_uV);
