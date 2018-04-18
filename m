Return-Path: <gustavo@embeddedor.com>
X-Google-Smtp-Source: AIpwx4+FKZfjVMo6ghto1/eYcLgHPAVrtkt/8Il2CLsnr2Cp4+IG/Bl9pdV+LDxaGeSYEBJtJcjh
ARC-Seal: i=1; a=rsa-sha256; t=1524055819; cv=none;
        d=google.com; s=arc-20160816;
        b=CzCpz+49I5eqKEPWWzwCQ9bCutP3neWy1L2gqmeY6JUcUrSj016hkOmFCcLq/SBTYe
         NOuroIwjhm0k3KwtA1lpDxU4igNuVfEkIPjcBDm6TIIhA6k7TlwhVVVgVPJoHO5O/bg+
         OCxjUgtmFLHyU45qRfGbhWHG2Yr8Reh1zS30OU5r4zmhKQ3dk9t9RrMIXrcu3E3ETPWA
         YMPmiTe89DxZFs+qUpUMS/HGNXsN8X0OBnTaXi5tr1wiBM/FATBXt24lDd5C0biftIiL
         Kqqj92PPJpbn/Q6dK66B8T5cM7sAAuqm+934MH1W76zdKwWZ5EgrNH5vN/rZ+8DB94AD
         oqdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=bc6GnhqgLEYRImjtBip58vamWjDzse+HfkKSdtA2lBc=;
        b=uLKQomqZq1smDDnb11AQWKZB5yVnfM6MysCmrFr5HQlR1L5+TE0s34WJcYCgClr5BW
         a2yJ0lHSmZkb3BozhUKQZO+lWtEESAnhh4rsohtLQuJRRfolqNVZ8JnEs3iFGHwUAV0v
         SCEK59F+h/0AGEy86BSpUqguYTtDYN7IdOseK5BMns58BIHictPOMNlpZCD94Ua0dQRe
         gjFwh+I5tS3d/sNO+uvkTpR9k9iM5tIayQYI/12ZMZh0RCg/T8dhYF9MKTfiyM/dchRq
         kwlt5yo2qDNkpMcR33QCKKW8s22aUSJjlGkw8wiIiKvqdHvXvMWMXulJwdM8bwuc6fgw
         nSeg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.45.2 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.45.2 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
X-Authority-Reason: nr=8
Date: Wed, 18 Apr 2018 07:50:16 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] staging: media: davinci_vpfe: fix spin_lock/unlock imbalance
Message-ID: <20180418125016.GA25606@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - linuxfoundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.145.54.118
X-Source-L: No
X-Exim-ID: 1f8mXS-000EH2-2t
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.145.54.118]:58532
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598088354667190914?=
X-GMAIL-MSGID: =?utf-8?q?1598088354667190914?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

It seems that this is a copy-paste error and that the proper
variable to use in this particular case is video_out2 instead
of video_out.

Addresses-Coverity-ID: 1467961 ("Copy-paste error")
Fixes: 45e46b3bbe18 ("[media] davinci: vpfe: dm365: resizer driver based on media framework")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/staging/media/davinci_vpfe/dm365_resizer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/davinci_vpfe/dm365_resizer.c b/drivers/staging/media/davinci_vpfe/dm365_resizer.c
index df6d55e..2b79747 100644
--- a/drivers/staging/media/davinci_vpfe/dm365_resizer.c
+++ b/drivers/staging/media/davinci_vpfe/dm365_resizer.c
@@ -1060,7 +1060,7 @@ static void resizer_ss_isr(struct vpfe_resizer_device *resizer)
 	/* If resizer B is enabled */
 	if (pipe->output_num > 1 && resizer->resizer_b.output ==
 	    RESIZER_OUTPUT_MEMORY) {
-		spin_lock(&video_out->dma_queue_lock);
+		spin_lock(&video_out2->dma_queue_lock);
 		vpfe_video_process_buffer_complete(video_out2);
 		video_out2->state = VPFE_VIDEO_BUFFER_NOT_QUEUED;
 		vpfe_video_schedule_next_buffer(video_out2);
-- 
2.7.4
