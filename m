Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx499IVo5kvhcAaAcaDCT4IrOTBEB3Um7yyhwX9+vGlhM4nwSK4oNtoG26+BwIaxsr5kK1thQ
ARC-Seal: i=1; a=rsa-sha256; t=1523021186; cv=none;
        d=google.com; s=arc-20160816;
        b=NQnqbpj9KusUQRw7NZ9RznIOQJ7P0/x4zayLqntFIlJGWEjyHM8Gqp2I2O1HIDKCeC
         LttFoPhGvhuIj4XijikJ4umhLbAkZ763gS4AKdCe7bd90shTi+TrbGZ4+nb3NbQT/JCN
         DY7C8C6smEC2DuCJ2frAPOUZCqD5cYSGih4c9taY4VHPtmUN/XFO0+3Mmtj7x8rfJJXR
         RVjjMNXWp/ojj5Sv3K05RhpywL6KIe0iGR9sRPjazqtv1p01gK5jM9jaNcU/X53Z+9eT
         2OpNxlosaL4wxi3/B88i9ZvvHdaiEMTdrEw/27pKMa0L1517huASamV+SRDzfF1KvLMK
         gb2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hNaYCU6TTFsNS46s2lFMfcsm/JOXKvxMNJETP0MGk9c=;
        b=Iu+TOzoTVgD8KqfPYGYHruztxLmLBdXEYwl3HF00k8eSx6ULFQS313poXfY4MKvxaF
         PWEIDzRzxptDsDRKLPCgR679PrQXYLeWu3/+yj55/DJHk2Pr8Aib4bsjciryYbRmgzpN
         M/O231hHytgfFX/OiDarKLPLkzRqCzXtZj0otDPFlz6TzQsGJ+oeuCoo9Pdp0iqdk7Si
         VlsW8OsqPK7/dXqyAAlwSCXloYdGkdgyKuCpLqlb4yLUg4m3a+ccliTz1lr5gfjKTWDj
         TmJQhqbHnFpHYVNDUsUtLSWluJN4QOGjSL1ZMg5gFGwVCcEDgjDAnkIBByhYzcn0bQzG
         aejQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Stefan Roese <sr@denx.de>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3.18 38/93] ALSA: pcm: Use dma_bytes as size parameter in dma_mmap_coherent()
Date: Fri,  6 Apr 2018 15:23:07 +0200
Message-Id: <20180406084226.616251208@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003463496739680?=
X-GMAIL-MSGID: =?utf-8?q?1597003463496739680?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Roese <sr@denx.de>

commit 9066ae7ff5d89c0b5daa271e2d573540097a94fa upstream.

When trying to use the driver (e.g. aplay *.wav), the 4MiB DMA buffer
will get mmapp'ed in 16KiB chunks. But this fails with the 2nd 16KiB
area, as the page offset is outside of the VMA range (size), which is
currently used as size parameter in snd_pcm_lib_default_mmap(). By
using the DMA buffer size (dma_bytes) instead, the complete DMA buffer
can be mmapp'ed and the issue is fixed.

This issue was detected on an ARM platform (TI AM57xx) using the RME
HDSP MADI PCIe soundcard.

Fixes: 657b1989dacf ("ALSA: pcm - Use dma_mmap_coherent() if available")
Signed-off-by: Stefan Roese <sr@denx.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/pcm_native.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3394,7 +3394,7 @@ int snd_pcm_lib_default_mmap(struct snd_
 					 area,
 					 substream->runtime->dma_area,
 					 substream->runtime->dma_addr,
-					 area->vm_end - area->vm_start);
+					 substream->runtime->dma_bytes);
 #elif defined(CONFIG_MIPS) && defined(CONFIG_DMA_NONCOHERENT)
 	if (substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV &&
 	    !plat_device_is_coherent(substream->dma_buffer.dev.dev))
