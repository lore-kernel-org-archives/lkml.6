Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/2y5aAhM34s6SSwKuZ7BxOhwkw5pmCfYG46vx8hoYCoJEC0A5j2DKINC1MHUK+xp4HLthz
ARC-Seal: i=1; a=rsa-sha256; t=1523021624; cv=none;
        d=google.com; s=arc-20160816;
        b=a/nR3TX2zeSy3DYxfoCl7RpoY/zS9U9l/Z+Pgpzl4NS8qQ3x8nGHlqGgjnpeK31X4+
         llNdV6mayURpPw0hT9xmL87DiO1MMmX1Cvo8YgB4NZSXPqcmxghADsv2/G40JKoJuIja
         5TnpD/f95t1pr7p+RbdSaupt2L4mJ6blHp3+hZYS0y/clnr/f0r7dFcK3A/mMql9WwTW
         iNjxPuPdZ9I18OB87oPeWvuQkUoBsr6PgQfo/Od+Js/gC+36hSGmkOlgW4EBmBMADDqf
         f1txihOSBB1n6N2gyABD9vZSAYsq8OcKpgPYMdru6PtP855r64NZDlqZqf1dZdbQZvip
         ePJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=o0bOkz4Dr0VcKMNR2ysvg0bm/3AxqFXneZhR+QK64Ic=;
        b=HueuH0lYJRFT9ti/IODxWKQl9U/4nQle5QfAr/frcsk4vVAxX4ELxIubrthuX6TdVe
         ZEzMA3kl3rSKZoDi1caW73f8tSPlq16ZoI473jWcrP6AD6jMEFVXaO2GJ5/vktvx5s+p
         qNaLWjcCPVeE/YoA9r4zAakHxku5v4uJAkzwbWfKj6ZIv3S8I8iqD9jcv2DtyWFHx7ug
         R3MxZgsyp9ZuWE/q8hNTpgpngIj47QFXyK9EExMMH6Pe02bTW9tTU8HiDAXQVk1dsHEh
         pZRM4MOI3tvXU8G0BDR2AEBhRTnzfgvNOHiVCjBtj7tlNeqMYRXU3Mk5wQrhS9EGMYtS
         LiNA==
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
Subject: [PATCH 4.9 004/102] ALSA: pcm: Use dma_bytes as size parameter in dma_mmap_coherent()
Date: Fri,  6 Apr 2018 15:22:45 +0200
Message-Id: <20180406084332.114569603@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003463496739680?=
X-GMAIL-MSGID: =?utf-8?q?1597003923274773213?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3410,7 +3410,7 @@ int snd_pcm_lib_default_mmap(struct snd_
 					 area,
 					 substream->runtime->dma_area,
 					 substream->runtime->dma_addr,
-					 area->vm_end - area->vm_start);
+					 substream->runtime->dma_bytes);
 #endif /* CONFIG_X86 */
 	/* mmap with fault handler */
 	area->vm_ops = &snd_pcm_vm_ops_data_fault;
