Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELslICdbQlOs88ABtnfbbXHq/e1JHRrLTEG2gMoBhkYoFNPWwULQCp7r89xsQ0VaAypa5SpL
ARC-Seal: i=1; a=rsa-sha256; t=1519981226; cv=none;
        d=google.com; s=arc-20160816;
        b=myDo3wP6V2ZZ4UGFHlcWMdzCxuA1g6d/dDBRU0aS4+qPdWG+sDm1MfsRdWYiAmNSiG
         McDLoHrCZVc7fPmn0A6GQsezpzPIhOVKtn93ghImOlk1o3pc2SIheMr5w9rerLEmk9t8
         2av1Bptp6LzVO6GBhgtM7gdjmIouQd8qFUQJPyuc6oMjEKsLAcg8a+AEuTw8UmGXmgLE
         FO4BUErPi/2IUkS4f7zwNQBdWbjGeGaM9YUYEIGuMeu7NwU/CRz3mZBJWoVuiqx+nqZy
         7h1jiKh2oSVr6AmyJfWbL7CtgpEp6DAGDE7zzf6Q3eN/HH753aMKaNenlqeEk5FlQ+j3
         ZOwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=iKQGbJ88LtN8GjeLSr9nBXeG2dFlAkvEIycIB0ETZgc=;
        b=RaqBtQjnNzlkqzXhOCtBE2gqEkTR62UBOFIU4yXnM+swyg/PoyPNOqjrfeiJcQvlFI
         PaQbxcGc+ChWSF/vxDDL4vEyREJT9mZf9qa4g2rA0NoWxuhKBZggKfOETIWIR759xRu3
         q7C1GFXugV7cMbHzotT+WO0lZXYAiVvjE0JahgbqVu+5AZGqaF1gRdAGdsOvRD2Hkfky
         zUhwDfm0b65thIaAkAVCAN0fC+bWtN3QIBtk2A+N7oYUxkIkFdxZeBi15X3eG85aWRLM
         fQKqdAaV6S1c6EyB8J6VFJ1fZckCz+dR2XsteknoGmZ9qekM1zBY1q/7YeEs7QfqCxYw
         zk3g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Karol Herbst <kherbst@redhat.com>,
	Thierry Reding <treding@nvidia.com>,
	Ben Skeggs <bskeggs@redhat.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 021/115] drm/nouveau/pci: do a msi rearm on init
Date: Fri,  2 Mar 2018 09:50:24 +0100
Message-Id: <20180302084504.723619269@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815522892231705?=
X-GMAIL-MSGID: =?utf-8?q?1593815834900882475?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Karol Herbst <kherbst@redhat.com>


[ Upstream commit a121027d2747168df0aac0c3da35509eea39f61c ]

On my GP107 when I load nouveau after unloading it, for some reason the
GPU stopped sending or the CPU stopped receiving interrupts if MSI was
enabled.

Doing a rearm once before getting any interrupts fixes this.

Signed-off-by: Karol Herbst <kherbst@redhat.com>
Reviewed-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/base.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/base.c
@@ -136,6 +136,13 @@ nvkm_pci_init(struct nvkm_subdev *subdev
 		return ret;
 
 	pci->irq = pdev->irq;
+
+	/* Ensure MSI interrupts are armed, for the case where there are
+	 * already interrupts pending (for whatever reason) at load time.
+	 */
+	if (pci->msi)
+		pci->func->msi_rearm(pci);
+
 	return ret;
 }
 
