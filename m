Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+xUD1foIHhXGtaeKW5aEYnNo8DP5iqi3K1qwTp/K3nNMMcCvqOT9Wd3v7iHlC8+/6kVcqT
ARC-Seal: i=1; a=rsa-sha256; t=1523981209; cv=none;
        d=google.com; s=arc-20160816;
        b=gz6AC1ozoqSCpVt/C9f2K7OSB5sRNx1s2pQSgZUtox1N1VG65Q+hj9o5hIuzUgzMVY
         i/G4vRdyHxbQ3SYJBf3Axhr+6+MjHkeaLWearmJWj1rxdL6OYJumLsfzLQ4Hv42H3v5c
         siKzixPS4e/mTHnYMCLufau/Jo1xjZt1geA948GMIK/5m5a78km1TqzRWlJASIj/cuPp
         LSh09NxR/PcwUgO5W3uAENvEUgYLmtKXhgSPdkGPwwJTKqlWUP0EfOnsJe5FeNOiRgVs
         sPnsBn8qoGzKS/sCr7n+DxCSm7YOPhdpWjiX+5hAi4aW4UObyk/95ymZlfNsHP4moiG2
         Pfgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=D/9nfwdTy/YRGTdp/OU6eV1qVEFlDXfTwTChas/R5R0=;
        b=n0nDoPZ5VYDPtlecKaxtOKGiQTzkgrBKHw52L0RkOJ+l85F1ZramUT/DH5aseY4LJq
         s4NcFwPhBxc/CxFQIzzNZ4ZBOjqcChPHqo4u1LH9V5ag7YTdixCxBtfX4MIpBuB7JGQ2
         Cu4JQKPwBcY/3zHtSzFJ1Ei2JXEAdwgJKJqP1SGDWApWBycnd58vC+o8JaxxUn1VE7RR
         +KJF3lY3qgpk9jWHxlF9QiqKJd+yShqDd3sJxtY/zWCpDU4bvOB0YWPuDoCwQwyA+gti
         YFz+aY9AO/bPett90Ju9D08r04LjpBOkumgFs6KTNzK3Gepg7Gi2oEslnYD2Yt8UklvF
         Xr4g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.14 09/49] media: v4l: vsp1: Fix header display list status check in continuous mode
Date: Tue, 17 Apr 2018 17:58:48 +0200
Message-Id: <20180417155715.453427333@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155715.032245882@linuxfoundation.org>
References: <20180417155715.032245882@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009701678571338?=
X-GMAIL-MSGID: =?utf-8?q?1598010121203507319?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

commit 613928e85317b945c863bb893f5737d2f22f5425 upstream.

To allow dual pipelines utilising two WPF entities when available, the
VSP was updated to support header-mode display list in continuous
pipelines.

A small bug in the status check of the command register causes the
second pipeline to be directly afflicted by the running of the first;
appearing as a perceived performance issue with stuttering display.

Fix the vsp1_dl_list_hw_update_pending() call to ensure that the read
comparison corresponds to the correct pipeline.

Fixes: eaf4bfad6ad8 ("v4l: vsp1: Add support for header display lists in continuous mode")

Cc: "Stable v4.14+" <stable@vger.kernel.org>
Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/platform/vsp1/vsp1_dl.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/media/platform/vsp1/vsp1_dl.c
+++ b/drivers/media/platform/vsp1/vsp1_dl.c
@@ -508,7 +508,8 @@ static bool vsp1_dl_list_hw_update_pendi
 		return !!(vsp1_read(vsp1, VI6_DL_BODY_SIZE)
 			  & VI6_DL_BODY_SIZE_UPD);
 	else
-		return !!(vsp1_read(vsp1, VI6_CMD(dlm->index) & VI6_CMD_UPDHDR));
+		return !!(vsp1_read(vsp1, VI6_CMD(dlm->index))
+			  & VI6_CMD_UPDHDR);
 }
 
 static void vsp1_dl_list_hw_enqueue(struct vsp1_dl_list *dl)
