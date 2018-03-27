Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48xdVaUPMnxAPWvqrj7Uazh2/x1Od5x/JfGZ/MpcWptkhoIsImm/D6xNCe7SOyvcJ5zRWui
ARC-Seal: i=1; a=rsa-sha256; t=1522168301; cv=none;
        d=google.com; s=arc-20160816;
        b=HzzRQ0JuI4lYJhhVODitMnPX3FG/cv4oiVQpHH8kzue+4JzroB0MJDqqM4bYo/qyxM
         UxMON2ljOIozH4kBnSICtYT34ZDHQcft+lZcjaQ5r709k7Ns6KxHcraI96mR3yqFb4wH
         5KRmfYdf/72GKvH40/L9ZxpA8sIdruVjK/aOveZrtKTzlOnDxEcsgocU/QuZrLbde8AF
         ceATjM7MebDoqCNpjcMNL5g03Derdnm8RPeVhJ6A8uHMo0fq7C6t1o7rm+ISEpsflRIB
         UjfbPPfAEOvJW3aAWEKDn7+lGWu5pHGoUwKExSlYt0rJJdTu4XaOL3ZukCpt8QqUpzxM
         ZasQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xu2WbqOtjIaNPkWzajSd/btPcIUGKS2AHW1+gG8xXdc=;
        b=cB0AmE184xBbkU8s/AtKm2BJivVLlSbewRdijB1jkLEKjRW1w5AXjb1bY6SvfgPXbe
         +SM7FwOta2+u9Q1n6FPmyHwYEIyMJ3rQUMCLuGxg8tKqA4w5k2EQ+ey8MhXJn2fg4VNC
         pdz5XegiesXma9ewrrqr4Nerl+ry4ryKz/6C8burKzZmUUFubK0s2k9GE3j7xe2iJpv/
         ZF329YYA4Pyh6eU/LpUIhtru2QTjhrzCWYm54Nju9jc2j98pfXP3BIn6kE51FRAycw4m
         1IYpprSBhO3WVA/jIjZvKlLGpimUGVscIHcYeo19dr5QIs/2cPGfRUzypyAUTzRj/mAc
         xSPQ==
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
Subject: [PATCH 4.9 31/67] drm: udl: Properly check framebuffer mmap offsets
Date: Tue, 27 Mar 2018 18:27:23 +0200
Message-Id: <20180327162728.725387463@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109000301718631?=
X-GMAIL-MSGID: =?utf-8?q?1596109149225681305?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -158,10 +158,15 @@ static int udl_fb_mmap(struct fb_info *i
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
