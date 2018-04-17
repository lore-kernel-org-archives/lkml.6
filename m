Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+E/FJzhxTJLLR21Kq9GO+yM1sSbRajFlMChgG+9Z7dtmM4+oj55vnf4uwUrVZ8TzNGtS9o
ARC-Seal: i=1; a=rsa-sha256; t=1523981004; cv=none;
        d=google.com; s=arc-20160816;
        b=xBkP/vBJs7c+LYioA0KtnlXSEOcVDAauZ+Cxn2gOx9zkxe5uSjw0M2vQpy1mAkay7N
         T8DqER2wZ2iE+mFCojg9AaZqokZD9u9aUbJb2buP8jLyOt0gKFQcUttWnAxg00yuZOrs
         VqGjgRbshnJ85vepLCli79kpc8AZTwguV659aQElwSGzgy/xcbsTBEU6a3hKzCaiJzTY
         R6psTTuA8vQCCsM5ahDSDjsr7KhzlhDv5R97GN+rGXELZgB1sr3YThYBE9pN3LLrn1rL
         tJtNjnLDTwwk/1ip5YVoEmDVveVRpXqSGrThHGhjx3PYhlz3s2vFxvPEVVH5R6CsOzQY
         cDJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZkbgjT2xzC7Qj6ePMxFiYkOrQHjxpYMbNvsAEOTq7kU=;
        b=r8NeKB0AtOf5Sif12i5z4eeCBtLcp67RlWwdlgfq808gnu24w59+q8G8R72VfpPDC3
         7gvYtTWUa68yvxPDhQBuozofanA4d7G1YDP+DeGWE8cZlrXFt4AOOhsmC5JFGlH47Caf
         qcMZ6He9IDSjT3OKz7jo1mpAQnR5uU6PBSwB1kcPxVGA06+9vpYh4FCdPhiPASXi0I9T
         9fy3jaF0UYO6DIUHfJRQHBltH094BwPQGdqTzOauZlZtOoPoUEhCMJSASQAQD+qabcFQ
         V/FZ4aGrqaGXajur8yV52U5lLMlJT5l7bitDy/L2oKO1YZl0Buu5BeU2CJCcxaZIb3G7
         crTA==
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
Subject: [PATCH 4.15 13/53] media: v4l: vsp1: Fix header display list status check in continuous mode
Date: Tue, 17 Apr 2018 17:58:38 +0200
Message-Id: <20180417155723.780119465@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009701678571338?=
X-GMAIL-MSGID: =?utf-8?q?1598009905704919343?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -509,7 +509,8 @@ static bool vsp1_dl_list_hw_update_pendi
 		return !!(vsp1_read(vsp1, VI6_DL_BODY_SIZE)
 			  & VI6_DL_BODY_SIZE_UPD);
 	else
-		return !!(vsp1_read(vsp1, VI6_CMD(dlm->index) & VI6_CMD_UPDHDR));
+		return !!(vsp1_read(vsp1, VI6_CMD(dlm->index))
+			  & VI6_CMD_UPDHDR);
 }
 
 static void vsp1_dl_list_hw_enqueue(struct vsp1_dl_list *dl)
