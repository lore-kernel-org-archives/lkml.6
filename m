Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvCjU8mBjJbtLFnkA1NiVmShNG6on4nAE9TMKylh4a6eTFgYr+i3PEnOAnQ1eLZw8Ev9C7c
ARC-Seal: i=1; a=rsa-sha256; t=1519981102; cv=none;
        d=google.com; s=arc-20160816;
        b=VUZmYe2V0pF0vz/xMnZd25bfcw+HYFvXqrD2eSvGLeb4e2LtNHvXdVz6V0TpoahT5g
         tkF2ULd4eQXgqvqqRv3jmqkV2z8/ZRanLWLmnyeStAF+5mWnA5FIBJR5Z5ArEI/kKsV2
         HonLfFFIkO526v+z7avxZScm42UX7SMZ700J4bQJtNPIi/n9JEn+Lqf7EvNYQicFDwXp
         sFiYZJNeF+Oz598o2/N/8czpsTC/KOw2hYHQLEYqy/1ul0mEmp90bV7YcXJhtu5nqjcg
         obZvVgYrQLZKWAdlByCp4CvA6qiHJMRqZcrsQ8v87LEm0hp/Y5T2gv7C5WtLJdqNe82v
         gqIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=m/PmhkCuLUke9Qn+ye+Tgxrb+uITZjnyBiTEGnfP7S4=;
        b=t6rI2WEtakz1zM8vo0ruHeMlKLtFA7u3pAuihrdVVfn5/alQ1TOx7esNhOdot0eYzO
         IKX6ceaRkdX3ZM57TuLR0E30XtkEFPRekrHvIiKJQt3SUbOB1TArh2fQf2Oa6J5rQ1gZ
         QHZaoXXUs7ssCjxyocN9KDrOA/byqt9fv6cfZwNf9jW+Wp39CK+A1fiP981R9YGy431G
         CQstpuZwC0KljfhNMOhd+7e5WbRFYe8+4j4bPiJKwgexAYsfErgUqKrvPm7Q0fwGcOqx
         vsyeGkh0ges+k68f0Afy2xsu2wNAFgEjmU1QAqrXjtgtxmaAHvQGI9XeDrvjr06Xo2PH
         Gf8A==
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
Subject: [PATCH 4.9 14/56] drm/nouveau/pci: do a msi rearm on init
Date: Fri,  2 Mar 2018 09:51:00 +0100
Message-Id: <20180302084450.347327488@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815522892231705?=
X-GMAIL-MSGID: =?utf-8?q?1593815704333476743?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 
