Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx486PQxcvT+N9IX8vlgSIiEdlfYuC/DAl/FRmsgYVK0Bd8eFKa1YrwcoeTyleqc7osoxXJ/y
ARC-Seal: i=1; a=rsa-sha256; t=1523022079; cv=none;
        d=google.com; s=arc-20160816;
        b=NQXCb28J4KTcaltZDI3LbUDwjJjYxs0+AJXoWPzva5MapCO08QucMPxlRa/YleMDWZ
         ZujrredoxX15AsFcf4ec07G3En0Lpv6zrDiWAosoDx8e63FHhu9BE+GvTyKvPSTJfGgN
         TOXzw8ZT++JY5FFAZu6tMSU1uOj9R4bFsrf5ZER0KJJTDe+ULChKCvAGr8l0bZp1+yrO
         IOBOywIjoIfn8uKlqR+9GR1NWimchJcpAlJ3CgiGOvz4S8JVTRq33ydNQs5CCczw5Z/Q
         3ueGwGFjoQWfLglLpvQ2XrSVsdXneC5siOXtMfGjysMG0AuimNA+sMRFMR4CBcvn7V25
         KeRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YHmnzCY3+6yoda0d74iXlBkTUE6ezSLkpUKXHbfDJtI=;
        b=JWT7VmVnp4Yc6MQmUz+h4iyofm3aV00SjggCViIrEGbUvIFakkmmOB1PbzbTYfnLbo
         YfgFl2kZ12yCfOE+2T74OMrguOIQParAmOoqUBi3VkZrhMURnDUu5WFpUoX0KJd/wK9w
         pyi/m6OJvSgPm8I8FQn7YWjdwm8IblvG0H5HYazBCt9OK6Zki36JVp7CsjcW6y4BqDwG
         GgBpxdlMnNT/iBt51CG2KbslU5JP8fshs5v1+wuZIDtElaruBztQgD/IcHqfUrxtxjfp
         HqlbAEb+tpIeoxQb3b330TABDsvgLgH1VZH1g5p4TAUhTUWWUWXIyvIB64SepHhLHZ76
         I5lA==
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
Subject: [PATCH 4.15 08/72] ALSA: pcm: Use dma_bytes as size parameter in dma_mmap_coherent()
Date: Fri,  6 Apr 2018 15:23:43 +0200
Message-Id: <20180406084350.199553868@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003463496739680?=
X-GMAIL-MSGID: =?utf-8?q?1597004400305264385?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3422,7 +3422,7 @@ int snd_pcm_lib_default_mmap(struct snd_
 					 area,
 					 substream->runtime->dma_area,
 					 substream->runtime->dma_addr,
-					 area->vm_end - area->vm_start);
+					 substream->runtime->dma_bytes);
 #endif /* CONFIG_X86 */
 	/* mmap with fault handler */
 	area->vm_ops = &snd_pcm_vm_ops_data_fault;
