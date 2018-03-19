Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs4+SSnM/NaVn/oh/OMdaCtUjOxzWjVjnR1Kdeu5nD7WfOFGB6jdQScN87yMI/B3/L61srQ
ARC-Seal: i=1; a=rsa-sha256; t=1521483838; cv=none;
        d=google.com; s=arc-20160816;
        b=etmWmsAvb/XQgcyj7ZlfAkyjWQ5TAH9tS+7XuYxzWJsSAolFoFckRZFXh3Ul8co0Kj
         OKt+IXLOnps0Jxmc3uQdis+jaEMx1cC01mA8cEmHNwOfTnhWXHpTrstWWqKoOdPx6c80
         eHjn/5FetG5JtqcYkEN7Orsb78aYauGrEuQwv3IVMBXmFyXmfxE3aT7+i4KtKYSTtQpg
         cLCx/b/exip89+IcvYdWp4O2hAu741KoIlVX9J9n7W024EAiw+Xwa1+l9xrVd41r/+/k
         agts0843OZ6lY1HBsCmhBZUcILECkGmiivDSW/w7gTXMTuYNFaN3rSnG6Vyyk6OS8fIr
         692Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ls7srhmD5ZgAJsuZDFs2YtRa77mda9+9aHqi82hPCxY=;
        b=KEl0TmjRA1wyK+Q1esPjeWgMKcSKR74xX7spcvzEAqusf2byBL09zEMcyEXjbQk4hQ
         dt8d8wGWtbv10s/vp3bSXeryRg0Yg1Iqc4yjzL/+mhSq6mtXWsVJfUHCWKmPvmTt8Hk5
         wYwHyoA6VEAFrEny9YMNNRuz/I7DEFof3CIM9+ho22OGrsfmq99giEcWLsEpFMBOqXG3
         vJmWSTlJcC1EjEAU/3m1t+34sucpFKvNf/QzxjERKXCfdIXG7+9/LLI2DDW147PfCT2+
         uH5w/UTGf63DkjEBqlwTdKrH2cftMl00ERjWiPECsWDbSINQs+XfiEldL2uEcRvCxdhs
         BHZw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 134/241] [media] v4l: vsp1: Register pipe with output WPF
Date: Mon, 19 Mar 2018 19:06:39 +0100
Message-Id: <20180319180756.740776187@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391437205592630?=
X-GMAIL-MSGID: =?utf-8?q?1595391437205592630?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>


[ Upstream commit 1531a208ed861e4bd287444f9466ffcf98383de2 ]

The DRM object does not register the pipe with the WPF object. This is
used internally throughout the driver as a means of accessing the pipe.
As such this breaks operations which require access to the pipe from WPF
interrupts.

Register the pipe inside the WPF object after it has been declared as
the output.

Fixes: ff7e97c94d9f ("[media] v4l: vsp1: Store pipeline pointer in rwpf")

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/vsp1/vsp1_drm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/media/platform/vsp1/vsp1_drm.c
+++ b/drivers/media/platform/vsp1/vsp1_drm.c
@@ -596,6 +596,7 @@ int vsp1_drm_init(struct vsp1_device *vs
 	pipe->bru = &vsp1->bru->entity;
 	pipe->lif = &vsp1->lif->entity;
 	pipe->output = vsp1->wpf[0];
+	pipe->output->pipe = pipe;
 
 	return 0;
 }
