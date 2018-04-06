Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48gDGNUMBk/BxtCykMdyU1g7+VpVD18Q55w2eRAa7oyPcicTQdrZJDpJEQpWE0qez9I3qqJ
ARC-Seal: i=1; a=rsa-sha256; t=1523021931; cv=none;
        d=google.com; s=arc-20160816;
        b=HwR+Q9qleBLuwm8LeoRF9R5hUwvcs63fwbogMRBsKpBZiiRL/89n19VH3Y/Ejrfqn5
         QZ9haxBxX9zPAoEO7JcHxtEl0fe53/Tk4LdRiun2/Wx2O2EPoi8Y6rr6duGE+Qb7gtQ4
         f0OoZMo6kg+0Uc9DoPEyhn/EGl3xXJxOaNJWSNV4/CVBzxK1m+BFCFcBpppxxhlbaOeK
         q7D9l6IRcc/DL5dM+SXElZql2pAr5j/0j9laZkVb4FboJIVGA6hHUalCFbe5q4aTQcTR
         oNXMz4I/KVRPmerIVC0bs1B5NY96MfAdNVPYJJPaqQ0PCs46uwmFCytpA1RWv8B+1k66
         Qe1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ERIzokCL13LdLyvBTPTVnYUe2EMWPfluFRtoS119IvI=;
        b=jEBGoaWARSEUGZJgIreq9pInWw54EpMuzhxXARgtQytrwT4+RrFnI49L0Bvrp35JQB
         p6ydCyeuyfcnY4Y5NM+26Ce9xSXU9RdsKXpedryTOHqo5BLjoFeBX3w/MT6Gzv8zOGin
         NOob0hBzbp2GRxK+fsZyDs6A6d3NAU9LZbFIKiuV9HWrzNK8QoThRnASbKDjQejAO5g8
         86zVTEnHda2vmzGP8zAFsm08AI+v/t+mkWHv5viel9serluldm4S+dtsaHMGhPEG5+WS
         e9qd6V+hkdBXSTxGZFGv6HVibk8U8eEng59AJs2j8BXugsTz2enPdVzZAYpRMBn3m8gF
         xQrQ==
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
Subject: [PATCH 4.14 08/67] ALSA: pcm: Use dma_bytes as size parameter in dma_mmap_coherent()
Date: Fri,  6 Apr 2018 15:23:38 +0200
Message-Id: <20180406084342.408242968@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003463496739680?=
X-GMAIL-MSGID: =?utf-8?q?1597004245037953666?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3424,7 +3424,7 @@ int snd_pcm_lib_default_mmap(struct snd_
 					 area,
 					 substream->runtime->dma_area,
 					 substream->runtime->dma_addr,
-					 area->vm_end - area->vm_start);
+					 substream->runtime->dma_bytes);
 #endif /* CONFIG_X86 */
 	/* mmap with fault handler */
 	area->vm_ops = &snd_pcm_vm_ops_data_fault;
