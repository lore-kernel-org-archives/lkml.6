Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+gTtW8udTpbvJiHGPKiNSV3D7Yvquicb0VhVqv819S1BWTUyB3XY2IfDVUHVL81hA7r3U+
ARC-Seal: i=1; a=rsa-sha256; t=1523021364; cv=none;
        d=google.com; s=arc-20160816;
        b=P38OJ2JVwVBsq4B43UGL7wZGpcrx4lKHsKeZTVe3zoStGsjck5RtAssOUFrMTZB/XE
         V396JIfv7PpvBgd+OYVhajWiWZZUxP3+x2WcMzNSNSxNmITtyEpEt7/o6ta6/baRJt4q
         2zKXKs3d5ZLm7dAEj6mQOboAMWOlCUkhXegY85gLAe386meUE9Lto4POLJoqkMn1lJu/
         45wUybPmw+L8F33yD6V8Ys0aHFEp75wCkGBQWy+rGfptnRR9Uu9HqgerKVhEa1Mgoh1r
         bmgODi0e/pdBr/eyqa5ZjCg0jtiq3g5tuvPGGYc/P9/SeV8G5v076fsyOse005egMngO
         z5ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XiR2EPOUqbGNLQ7FSGKJqi5RhReS43ILzV1xNHBjTds=;
        b=rd8L8979kxxvKjPp9jQlf7gQT5Gcvco/drEZfjENRi7XTU/7SnImDtwAKt5ZEDkU+m
         epBBS1ktYTB8cFh1t8lPL64MSsYRKK8WwFBYkTKBjcj2uixcst3TI9lN/w/1bH74zv+a
         mjOTEuMQ0v5U/Jc/hWHFMoIxoJnGTAMEJaJZYduSAEKErCIIIYEdPZlgW4+aNl8c91+X
         Vj1cfXkv8KAWzifchNn17JZ0++hRfXu5DhEJVkykb70O0WAQG0s734urCJaIgl4Apm8L
         Y/aLxpeL1jx7M4lQElu2s0ri1RYN0mrS+T7xgjg/RJnSp7CGRi4toNesloiTWoRc7XR8
         xnlA==
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
Subject: [PATCH 4.4 02/72] ALSA: pcm: Use dma_bytes as size parameter in dma_mmap_coherent()
Date: Fri,  6 Apr 2018 15:23:03 +0200
Message-Id: <20180406084305.359462661@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003463496739680?=
X-GMAIL-MSGID: =?utf-8?q?1597003649477970940?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3408,7 +3408,7 @@ int snd_pcm_lib_default_mmap(struct snd_
 					 area,
 					 substream->runtime->dma_area,
 					 substream->runtime->dma_addr,
-					 area->vm_end - area->vm_start);
+					 substream->runtime->dma_bytes);
 #endif /* CONFIG_X86 */
 	/* mmap with fault handler */
 	area->vm_ops = &snd_pcm_vm_ops_data_fault;
