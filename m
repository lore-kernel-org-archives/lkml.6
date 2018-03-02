Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvUbUdQnOLYVV/zp9HSwEF/4oQ1zWcKwLw5gi9+mCcDjDgzxAEOKihnLyejJgHv8BbJYHwN
ARC-Seal: i=1; a=rsa-sha256; t=1519981216; cv=none;
        d=google.com; s=arc-20160816;
        b=vMmfcq5Gg/MKQQnopC/xXlKo/+gUuTneqxBfUG64nZEJV0+30VGbPLZ+aZT1/rOAVs
         j5bXjh6X6uPCGPMsuyqxudoA/ZVz5/6guodhxHKAv8s6caj1TQTCJhGXRN91HxIVSZon
         alBRNOSA14M/uSU5XcyrSrjgsuXCRl7pXGWBhAvVIsRs18Q/wAljkW+L0vkyB/vTPyhM
         7O4hj0NTbDAVS+XqlaOEWHveI8dqUR6JGyGyb4lxntdczlhG1pbtiAae/9aDRgHYvPWX
         ZifpL3MITlaVwKYNuzesQAtUqnAZbobhVPKMXVmN7QilFYCwBkyy4XZanBrZmGEMZeNh
         f+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=t4qIVdM7TwBjaHA+pR7UOAyAJu07+yYyyHqaFoZKXFw=;
        b=eIpvdXflfDpSnTyhPlel4+3y47p3fVdDKfbUyV53dBSA0L2v2gf4g8T+QJ0CvcbPyh
         kbk1x6vKPqFMWjiUWDVeUDq6Xy8zT0+47f6trUO8rBcWoWIPp0okZb3ghSg4vGgA+f5S
         Z5HjuHLFSSZDw9JA5lQaEg1S8j7HbDPZgfTTrF9ZMIejYVsRKmrfQ6kOyDPXOO/c8Tg5
         aVSCw2IITMeZflin8iMTbhgceHtsM0jlPajZfdjgYqzDy8wDiax/ojaodsTmjawfBAEf
         X8MLpGbgR7NGOwamPu0c7uhkVq+1deB5w+3zZohcnwUQ3kINnIgaDM3iX/EnTyIMOHEa
         IAjQ==
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
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 008/115] nvme: check hw sectors before setting chunk sectors
Date: Fri,  2 Mar 2018 09:50:11 +0100
Message-Id: <20180302084504.197208635@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815572088438650?=
X-GMAIL-MSGID: =?utf-8?q?1593815823327418817?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1515,7 +1515,8 @@ static void nvme_set_queue_limits(struct
 		blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
 		blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
 	}
-	if (ctrl->quirks & NVME_QUIRK_STRIPE_SIZE)
+	if ((ctrl->quirks & NVME_QUIRK_STRIPE_SIZE) &&
+	    is_power_of_2(ctrl->max_hw_sectors))
 		blk_queue_chunk_sectors(q, ctrl->max_hw_sectors);
 	blk_queue_virt_boundary(q, ctrl->page_size - 1);
 	if (ctrl->vwc & NVME_CTRL_VWC_PRESENT)
