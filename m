Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+mIrF7Dz5wf9W2XHqXQ0syhlpdYRJm/nRuog3la1bDLkos/0LtjS1UV6P8ViC0JcsfGGST
ARC-Seal: i=1; a=rsa-sha256; t=1522168576; cv=none;
        d=google.com; s=arc-20160816;
        b=AJmJDZYyvg8aOUfgiqKr83miJ7UDAbo8NPs/o8y0ov6niQ59soteI74mcoUm6Iverc
         Jmo+NMvOrf1o/IbLrQCINDMKrU8Yv92fIR+Aclxc3PJDPsiycwUfbYPFvOzAIFJVPp+V
         oo8CItRVAL5MEjb6IVMIKSskhdFa26UpeEuW81qdHn6j9jx2kBB9SRa2Vj7S6EPRtyVS
         z039H4bMbWT5VsWynXI3eRRKhSm5jTkHoOTv7Y1JFvuBaW05TYx741RL0vHpU9l/pp1P
         TilXhrMHtFkrbmxj13vxSvANxd3DNIewQ/0TYE6R4eTPywOV6SsgsXGqa51hML5CAHOC
         8UBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zPXcZQm7bUc5WSWGJjvgNiEoaiIGtElcj42CZzdAtUQ=;
        b=FyYblmtlYJnxOwGdtExcsduxgk2XhArL1gwJjjm9HysvZylcTavhlkabHpbqDIMKrR
         xMNTXtBHnn9Rqo2U7LjZeNWmnjR6NoLks2PYUB0HjO1wQ1watHA98sQJaNe+u52z++lL
         4h6lVPomUXA36ZHKqau5lYDUFqdOH899NyyvYuq26eie10V+ruKzmD1qCF3uFMZ290Wi
         hbhp0EDTJoEBrFgwnrsYGwGxjsGHklvh6JJLon6IJboygtJcdG8f9ZMb1SqAElXVVBGM
         EGHqZy9/iQNe6n6SUFzIzwNFR3yUFG466BKVVxjpj3DHb2VEVqXNMtYWa/2oIjZK/OyO
         Kh9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eyal Itkin <eyalit@checkpoint.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 4.14 057/101] drm: udl: Properly check framebuffer mmap offsets
Date: Tue, 27 Mar 2018 18:27:29 +0200
Message-Id: <20180327162753.489597499@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109000301718631?=
X-GMAIL-MSGID: =?utf-8?q?1596109436760822787?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 3b82a4db8eaccce735dffd50b4d4e1578099b8e8 upstream.

The memmap options sent to the udl framebuffer driver were not being
checked for all sets of possible crazy values.  Fix this up by properly
bounding the allowed values.

Reported-by: Eyal Itkin <eyalit@checkpoint.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20180321154553.GA18454@kroah.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/udl/udl_fb.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/udl/udl_fb.c
+++ b/drivers/gpu/drm/udl/udl_fb.c
@@ -159,10 +159,15 @@ static int udl_fb_mmap(struct fb_info *i
 {
 	unsigned long start = vma->vm_start;
 	unsigned long size = vma->vm_end - vma->vm_start;
-	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
+	unsigned long offset;
 	unsigned long page, pos;
 
-	if (offset + size > info->fix.smem_len)
+	if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT))
+		return -EINVAL;
+
+	offset = vma->vm_pgoff << PAGE_SHIFT;
+
+	if (offset > info->fix.smem_len || size > info->fix.smem_len - offset)
 		return -EINVAL;
 
 	pos = (unsigned long)info->fix.smem_start + offset;
