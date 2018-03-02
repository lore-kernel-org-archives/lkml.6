Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuh3EL3TVOC6wrpbMWXXPH5kow8QcZXxVg5nWbhSufgQqf9HXOaBVdIoZ8NcPuBhVwxhfoi
ARC-Seal: i=1; a=rsa-sha256; t=1519980976; cv=none;
        d=google.com; s=arc-20160816;
        b=k37gNNu3CR3qv4VJ3F1MuIM7BkcNwbM2a5UrMts3+TFx/nXi0W9rs1v/XqdZ1j4TBB
         SfkE3IrLdh1b4bjjmy0UOWRJrvVuFgSirq6sOVcgoCd4wjKzt+eVkLec8qH0SFy3e5F3
         zorQZj3OQPLojjophoZHhkVBqNFY0ATqNcy6POoqkGjrWSMxwsEcBwX/VnvviG+EI2QX
         WSLUg4XYmY9uRGQTNJbObDYT9Sw8WjjpuwVHO2ORAMXAOwF8qarw3zqmtMT7h/Nf7SVw
         zptLuHKHa3MoRtTszJ0BgmIckZDwpF/nuP1h3Yu/e/d552QQZVKkKso2RoeD1afEhvoj
         yZJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=N2buhIoZiKX5fH578LlKx/tGvcV3HUWKVesJ0Y5Kw3Y=;
        b=DpLb6fHAqqgManVypAomb1iN1ZiM3fG+3LQhGjtg1O78sTAPJP4xqdyDaBl6cKvJXo
         BI48BZZd4CWzRg3A9Wlk3Lch+LYhT5IVjIqniYcqXWdUnuZ/l0u6aCrzNgU66JnCqfeZ
         JTRuD3QMRKt7sCACpbnsuHG1p+zPan6z0abt6xUvuy2dx1+fbkNGAD4fZGes5vddJdz+
         9XZFoARoKov9uw22lpS190xUN30QDQwnXPe3SY3Pc9WtnPTqErfWPewzNhXWftnMnG7F
         8eoi1LOAHK8rCTX/FRpjBv6CJly6Vlg4URnKzov9d0ORlWKyjJrmZGn65kV7ByfEAMs8
         r/4w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Keith Busch <keith.busch@intel.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 05/56] nvme: check hw sectors before setting chunk sectors
Date: Fri,  2 Mar 2018 09:50:51 +0100
Message-Id: <20180302084449.910446680@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815572088438650?=
X-GMAIL-MSGID: =?utf-8?q?1593815572088438650?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keith Busch <keith.busch@intel.com>


[ Upstream commit 249159c5f15812140fa216f9997d799ac0023a1f ]

Some devices with IDs matching the "stripe" quirk don't actually have
this quirk, and don't have an MDTS value. When MDTS is not set, the
driver sets the max sectors to UINT_MAX, which is not a power of 2,
hitting a BUG_ON from blk_queue_chunk_sectors. This patch skips setting
chunk sectors for such devices.

Signed-off-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1204,7 +1204,8 @@ static void nvme_set_queue_limits(struct
 		blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
 		blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
 	}
-	if (ctrl->quirks & NVME_QUIRK_STRIPE_SIZE)
+	if ((ctrl->quirks & NVME_QUIRK_STRIPE_SIZE) &&
+	    is_power_of_2(ctrl->max_hw_sectors))
 		blk_queue_chunk_sectors(q, ctrl->max_hw_sectors);
 	blk_queue_virt_boundary(q, ctrl->page_size - 1);
 	if (ctrl->vwc & NVME_CTRL_VWC_PRESENT)
