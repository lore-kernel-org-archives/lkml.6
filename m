Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+JmuzH2BPyjqMkO2h4v6HASiuA/187/9wQeWVHEbeyNT+mDrIQ5+c2EahZRWhDI/C9Zx5R
ARC-Seal: i=1; a=rsa-sha256; t=1524405345; cv=none;
        d=google.com; s=arc-20160816;
        b=bn+HPHFSHp6MMxTOUR8rYg0lnar3WSyu6EQqSZg7jaUZdr1084BR4j4KQ5EAodSqE7
         RfMtfu+8ykP8dH3HS7ryV0t8AWU4CFzPoqAYz6QCoIASv2ok0MjxxmBWlZvgF4DnHwc8
         viFf0p4JN3EIxPMEw8VN0prHlXxqWiuE5oRruqzgqpveQAZlxiHAo/tlMNSz5uGkV+N0
         sKPC3L56eGQWYPaTyQ1+f62kKU6Kes4oGxk66/hSvzL9+/Ceun4Ofds4/R1/wyD+8H20
         lTpnzRTv0PBYpVULgy8uUovf3+Ua144Wzf/WYe/Rp85We0FrUyxtaVdLiIIgzwclqYy9
         /rWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ud6eJlbW8WbpRsyP1vwPw34ggXACzQ0PDrAY5O6+YU4=;
        b=APTrn8+5Q1FT9x5Y0btzX6kAfhlxxC8SgBEXqj5a5B5qX0zrmK1dtps9s7r8Yr754W
         oW9ETFbZ/cQF3da4zyIAXfPmvCRoYdKQ30B7Y434pXlJYwnzRYue1K9/M52q1mWb1G1m
         47Qd+/ihSQouQumGB0uagr6VHVqqJRFCKACm/zeawrB2uvXgz2MU7YD+dFo+YUJQH27B
         Oe8IWBmOsJcTzNUxMBmnvd95+9+pw8R/YoS/FyBfvMI8S9b9gS44ALXOz2qIAJlErne0
         ScYmPC+4OEQ4qu+mRLibN3NCGo+UE7WzDkuRmikT/7flrP/Y7fh2qwFmAx9/ozWIdjvm
         9fcQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.16 032/196] media: vivid: check if the cec_adapter is valid
Date: Sun, 22 Apr 2018 15:50:52 +0200
Message-Id: <20180422135105.760782426@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454859637949340?=
X-GMAIL-MSGID: =?utf-8?q?1598454859637949340?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hverkuil@xs4all.nl>

commit ed356f110403f6acc64dcbbbfdc38662ab9b06c2 upstream.

If CEC is not enabled for the vivid driver, then the adap pointer is NULL
and 'adap->phys_addr' will fail.

Cc: <stable@vger.kernel.org>      # for v4.12 and up
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/platform/vivid/vivid-vid-common.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/media/platform/vivid/vivid-vid-common.c
+++ b/drivers/media/platform/vivid/vivid-vid-common.c
@@ -874,7 +874,8 @@ int vidioc_g_edid(struct file *file, voi
 		return -EINVAL;
 	if (edid->start_block + edid->blocks > dev->edid_blocks)
 		edid->blocks = dev->edid_blocks - edid->start_block;
-	cec_set_edid_phys_addr(dev->edid, dev->edid_blocks * 128, adap->phys_addr);
+	if (adap)
+		cec_set_edid_phys_addr(dev->edid, dev->edid_blocks * 128, adap->phys_addr);
 	memcpy(edid->edid, dev->edid + edid->start_block * 128, edid->blocks * 128);
 	return 0;
 }
