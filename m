Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtKOG/ZLWyi4j0sp5REr8iTG2jBxB3S+0ysDs7+/E9km9J/SBPIn77svAjqYLP8PkwfO/YY
ARC-Seal: i=1; a=rsa-sha256; t=1519980929; cv=none;
        d=google.com; s=arc-20160816;
        b=iChThJr44uittd1stCZzM0M4xKDiR2xTt3Oq8BkjWU4cpxcstQd/BswP7qC5sQsq36
         9Ytf3wnMTYKamACP/1RNtk2xytlGFslMwS5gw0dLX+pPokclNQu8/L5JDFLd0I+2cQvk
         YatFjlH+Hqp4vcR3VcWng/yUKiWJ3z6BrsAJwt3VXmM6/0RJyFt2zij/Ow3BMlDCcdun
         kmMK9YRkzgCPlYUg3+imJV/3gLPB69V+MK69FCsQInx+3MUwAWME0fpJP9IsdE/49O5P
         twKE2Q85G21QeSjASldWtEe2A1JI+UM1kqUaO+B85rr9wJmmjZPzHH+gsII8O2f0it3i
         3brA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7eeqeqAO8C+SkQybWGVJx9TX3OeYb6EC0pp2IhKkM20=;
        b=WFpwAGOPwYRM1kn1+o9mAizsdz1mBeujB6M2C32iud7XPqWo2weP2TGn9atfJNNCzk
         B9KmsLgWPL9I3ZQU0rwADkxvI3htc6SbuT7De/fP4GdXcXT5tnjTroIo16JYUzeBD961
         BRReXVXq/WrR1Qv/uLCuCqMPyLCz5NjENtippJIkGfIyYwds4Tz7TUdcmlF9QBRK7OHX
         Wk37husTFK8ioJGjPV6o9+cgK7XvhMPCM8wQoY+q1ga6UIt0r6oNx2oBNrTr+y+wEBlT
         cx14ldt/oJ3Ohr0XUNRhmwy3H9Iw37CH5s2Mpxxsc62lgi3Ja/CFCwRpXVTDYB6ZfxY9
         P58A==
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
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 07/34] drm/nouveau/pci: do a msi rearm on init
Date: Fri,  2 Mar 2018 09:51:03 +0100
Message-Id: <20180302084436.470546495@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084435.842679610@linuxfoundation.org>
References: <20180302084435.842679610@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815522892231705?=
X-GMAIL-MSGID: =?utf-8?q?1593815522892231705?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/base.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/base.c
@@ -127,6 +127,13 @@ nvkm_pci_init(struct nvkm_subdev *subdev
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
 
