Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48YU5PqPfjTyp8cfnpPUETbQAqwXI2WwRASBexoDZTAeQR68JBUHV8gp2oepYDbYv7H2QNv
ARC-Seal: i=1; a=rsa-sha256; t=1524405351; cv=none;
        d=google.com; s=arc-20160816;
        b=J8ge6xUqvuwXz0j8j1W3wgOFgl/jzwXdoIrRBZE75ddRC6PwoCsNK+bDL1oxC+oiA5
         QVZkT0J/1mvJUIwPPkLf9PJiwU/hTaS4Ld/Xi07IVxQLk0Fi74Pa5CQPBBHKltvy/k6I
         gSaqPBimA3M+7y0SbPFMpqR0A0I1DOC8uK37SwGJBgIViECfZ+NhOAY4QbG3OGNfjafb
         SFS8S6mzpzaxmdIsiziZxRisiWkpMc8sJ0giCf+T0BXatC3dhGH9m8njSv4leppT+lG5
         5fcpHDXkkWRQrjluVxU/spMDi4PGP2a31iPLWnefrZAuxN/Ixl/aoLefM9F+65w31Bod
         35jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=r9nKFUQVhSGBcToAjREZVwHuy9rWfgurWXHUwPLhzuU=;
        b=d/uPKl92NhoWffTFBVBFNGqotHNrUdo3dazUd7ZDxp3szWOv5f5vVEoF+hpuLS2fsE
         i21gYaaml6FyoXdg8XnHSuOlxx947Yr6fX7tCt3kW5YWyjTYzigrBasoR2leBc73utfv
         No1+PjeT2MYqHQUv0VlFL7pgAcgEUzudDjuNA7ewSgnKw1W9yICts6PtS1SXtGayjmgu
         pHjmflb85zzWy6XEp4KzII978g3/osp2NlrA8YEpdYqFD23I1X2D4gDK2huwbl2yjVFd
         3lLneZldT2i1poND68VPx2awVujQ0apxUs7SZf4PLotc6eFAHShsLDeo4aaOl5+Z4Ds4
         czTw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 4.16 034/196] media: vsp1: Fix BRx conditional path in WPF
Date: Sun, 22 Apr 2018 15:50:54 +0200
Message-Id: <20180422135105.866270090@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454865520411391?=
X-GMAIL-MSGID: =?utf-8?q?1598454865520411391?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kieran Bingham <kieran.bingham@ideasonboard.com>

commit 639fa43d59e5a41ca8c55592cd5c1021fea2ab83 upstream.

When a BRx is provided by a pipeline, the WPF must determine the master
layer. Currently the condition to check this identifies pipe->bru ||
pipe->num_inputs > 1.

The code then moves on to dereference pipe->bru, thus the check fails
static analysers on the possibility that pipe->num_inputs could be
greater than 1 without pipe->bru being set.

The reality is that the pipeline must have a BRx to support more than
one input, thus this could never cause a fault - however it also
identifies that the num_inputs > 1 check is redundant.

Remove the redundant check - and always configure the master layer
appropriately when we have a BRx configured in our pipeline.

Fixes: 6134148f6098 ("v4l: vsp1: Add support for the BRS entity")

Cc: stable@vger.kernel.org
Suggested-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/platform/vsp1/vsp1_wpf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/platform/vsp1/vsp1_wpf.c
+++ b/drivers/media/platform/vsp1/vsp1_wpf.c
@@ -452,7 +452,7 @@ static void wpf_configure(struct vsp1_en
 			: VI6_WPF_SRCRPF_RPF_ACT_SUB(input->entity.index);
 	}
 
-	if (pipe->bru || pipe->num_inputs > 1)
+	if (pipe->bru)
 		srcrpf |= pipe->bru->type == VSP1_ENTITY_BRU
 			? VI6_WPF_SRCRPF_VIRACT_MST
 			: VI6_WPF_SRCRPF_VIRACT2_MST;
