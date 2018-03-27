Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48vUjv1E09UVlYT4ReSLpQ/cFkkGe93XZRuKF/sJhOz43yhS/mzRcUEK6fpe+gqrxJm9sXO
ARC-Seal: i=1; a=rsa-sha256; t=1522168869; cv=none;
        d=google.com; s=arc-20160816;
        b=ai9vmch//dkICAathNs5vp5WuQMRKMnVviIFwAc0VdJM9r52CNS3xG+4TWeihnZ7BZ
         LneCHOL6Xb+aWmJqN0po6BkBLyDu1hcuZSpmhb+apegmrqVevyNlCSw+xbJWZKa5H+fo
         IEwbsUMfr1ob/wf3cDxdrQne6EVQVlLpEmKbS3K1TWwZgWJNXVH1l2zaIrqAsg0rcQt+
         5zEl6hizBaqwrHlqciW3G4tHapdCegYSXk2u16/6XvjTyD/ICtLKGdB7KVW79Z1J1IFG
         xQNfKC33amzOt03/6CS01JVBqwYdA3NvHZPlQo/Qsneh8mNF7SFgWZLjm92beQ8KHh4v
         +1ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pUwsRkExcLckLtpVONmpsYC01McNmWGIyIm61kZfSOY=;
        b=U1nak2I1HJohV98NWvx2Fv9ywlk22mTrVaISNsIIXlNexaZZQi5PRM3XtZYpnFB0I+
         I+HfthpE6sqR16Pef0XcHOI7P9eX46XUolPyMPiAQbfxhoRoSSeyiNM8a6r8BSupWcGg
         012O/aqYJSGeRWz2InkQOQ9krehnP9PXmpEqUFlo8VEHsJ4sWrkH72k4/lQgePBiJrkg
         jLN6yqWlrTcJc3XyIbCBuoxEcbMKkZOcDQo77fSNRQVHspVlBAH1A0CNmHZTwHpZdIEQ
         7rvc6lrfjBI4rRHP6FELNFimJ6mwsdRAC1yMslcTSijMb7yUlVMJYit+SAqa1xUjsq2h
         iFkA==
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
Subject: [PATCH 4.15 061/105] drm: udl: Properly check framebuffer mmap offsets
Date: Tue, 27 Mar 2018 18:27:41 +0200
Message-Id: <20180327162801.325325885@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109000301718631?=
X-GMAIL-MSGID: =?utf-8?q?1596109744548056735?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
