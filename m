Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/eL3094N2f1WSIP+XGnd2afFArEzwZlts9ERSgd2qT4BHHET1S/AlmhxEksSR2U1cbt7Dw
ARC-Seal: i=1; a=rsa-sha256; t=1524405897; cv=none;
        d=google.com; s=arc-20160816;
        b=RkSq6tsCZdSD6pvhXHfzzbfjhxGTndWwrSeNUjFOsHWX5s6Pkcx+ouIi93sxiH4Irv
         HbW8bKw5m1q4N1cbHBu+5ZYh1dWEaRisaiK5Dwo7mtxCVHJ1lnOWPzTXM7oXZILt2God
         tKsB9rEzG4GPB7FHGB37eXjQyiRko5segHPhKb1pXjwu7XgXElJPp0WUr02hcNKB8Dlq
         W8Elt5YZJdnB9XlWsc+HVWvYJVHo8MlGW7EVb1/SIf8+ffb/5Zt1ZWRrj+L3BdKJC+WJ
         xiuu7owCIPTkFb3bt1WVpZRd5Ts7HMQPy6OjYVH6dJKlwUaJuJQaAmrH456tRII1QY93
         XtaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/+1tNgfVWXYHgKPZ2Y3vOrmf4j/HKKRWCeiam7Xg0qc=;
        b=O1pE/09J9SNFSf8cAAjs4eBQK/Y2gT/Q1DOI6aWheY2Z8jfH1HDqzebO2CcwtJAME+
         +uLrWWpXC7si95l9Gusks/510upJZCyPetvWomddUR2lvvTg79OEMWpc1mL7ZPoEQ0QC
         9Ndz2lGC5KW2tu93LZzKxOuBm/J8xqyRd5ocx7/a019AqwyzeHpvwNH7K/yswyPMOrSN
         NLL639mkAiRZyGs+JkBxM9HUKi+B209IlSWlSm7syAvRiv8Kx3yVz5CV40osl1tN0KSC
         dh+mNYBRyqAm0GNGsIqfnAQEHyLVIzPan+X2ft8l6REAqG76viwuFiAD7QuUziSawCS4
         dFdw==
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
Subject: [PATCH 4.14 031/164] media: vsp1: Fix BRx conditional path in WPF
Date: Sun, 22 Apr 2018 15:51:38 +0200
Message-Id: <20180422135136.683314245@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454865520411391?=
X-GMAIL-MSGID: =?utf-8?q?1598455438179977248?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
