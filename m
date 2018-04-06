Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4++oM52Ewaw7eLxdPzFtdETPwf4N12HeFzKV2+YSA8a7wck3rtT+w58RfFU+e4nnw2IQFzL
ARC-Seal: i=1; a=rsa-sha256; t=1523021227; cv=none;
        d=google.com; s=arc-20160816;
        b=JID1sHsDmfhsv+8IqvmboliRBvLP19Q9a2yHebOV0VgrApWigdSfqLuT3WLxP0D9E8
         p7INlvNiuTvEy+GeyDtlEGCL9K2acfIuVAKhistmheKDWnzlHCym9/OU11xE/LomGG+U
         vZ81Jld5ZReGrr69WxXMGMeHUJBjNe8c6Wo3qThFXlDITaY7xDNfBAK55byjULZEzUtH
         V2wEe9FvSBqqENFzbJJPzGNeNJyFT2WOy6UtlsrIYPRBLAqQ/2k8+kd7trfc2LVcRTqW
         /91MCZ9SKAegeK7cBSgeebzGhkhaBmFt1ZcnxZ3rR7CYD6I3l8CL5bRzVEZS8Z/kPUOF
         LqEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mE2z0BNCg9V0Pr6r09h+tN+ZHBAo6YgfJHVMbvOT+Xc=;
        b=jMDRFrhvyRVr+sDBYQq+caoAIF5n9NP71715s++PrXIjMPrbJzRg5ObA27paYj6I4d
         OtD9XEllwXrj5L88bLPSQtnMc5qN9bklyVlj5GAt6shOdG7lfdCPytfOSzoMt7sJUhFR
         JnOaZgUJU00Drihu0J7N6ZHnkNkPniahZr/gOT301Oc3kewhwnV8fXg+jzB9p7DlJUzN
         R5/gawxjbOtt6igN0w1UJalA6dUFoll/+yjK3yfNrwQAtnUbKbzgRF0EvbzNrlYTQkLv
         +IV94sNh/1zwVj3AYFMZMPvLfdd/tHwb2D/sPJbT64ALMq9URTaz3z6BvA5l+8LHVYkB
         Y4cw==
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
Subject: [PATCH 3.18 12/93] drm: udl: Properly check framebuffer mmap offsets
Date: Fri,  6 Apr 2018 15:22:41 +0200
Message-Id: <20180406084225.501275097@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003506606174512?=
X-GMAIL-MSGID: =?utf-8?q?1597003506606174512?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -256,10 +256,15 @@ static int udl_fb_mmap(struct fb_info *i
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
