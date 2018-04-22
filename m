Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+U9RZxDZtDjhdJ3SKuwIn2qNQ7ZANXIB8LKfANiToC/jNB2KzhT5FcP5IkXyhYh1C0SJJG
ARC-Seal: i=1; a=rsa-sha256; t=1524405413; cv=none;
        d=google.com; s=arc-20160816;
        b=lhMO1y1iix7S4u/RAyaLaPcFsxNkO1sMARwXQU5g8nBoUAvX0J8LejKFA496Hnu8kI
         BHlP5Ptqb8/s9gL7xUNDlGz6Dw1vI8ioywclqaHSSy2iQham9/QM/TyWTDreQfgvxF8U
         mL8x+oaDLu2ecwpolMtTFPyKBdKG8JibVJFxjgCX4s69Z4GMC9Efyx4WfSgAOKmyvbMs
         tkZzUUa/21KkewVmQTwdlh3vJiHcf3McJvadUXTkbS7CEA7q7JGyGaeHXaZ78VsCLxGl
         s0RKfjK4CFo575VxUfc0CLn9JKH2rAbbi5ZdI5tu6PXb51dVNImzYU2nmIbK5qLwbu48
         kL9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/61b+6Y52gSAIDyrFrh/xs5F5Zef5NOIaJkRbdoXHf4=;
        b=sf8lzcMotCD2rwha+26TsaaSzfMOO1wGOoe3pUKmSChw89Y0nFtLuvSL2ON/MeJrch
         2tbBdWl+TGjtzQhnFKxLoF6cFlnZ9EK5mahnMZE8EfrGWT6h3QLzw/xdPySWw4JizrO5
         FKcm65nL8E7gCcP+lrfZKwZyr86uav5NXBcenKBiFfsuP1dk/5OJ2ypfyG+1sa5FWoFi
         rBd28juA+kPcNYtsg7F6vc2Nc7ALQ0siBo1wGkiy4ADDfH30Q/U66zjzSMjljcu7mdMf
         fb0s5FTicdoRZvCMR8B1i99HtBk/SMIxEXlB/CjMfyiTjjBj5FBXH8mW250sfa9upzY2
         l7uw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Jean Delvare <jdelvare@suse.de>
Subject: [PATCH 4.16 058/196] swiotlb: fix unexpected swiotlb_alloc_coherent failures
Date: Sun, 22 Apr 2018 15:51:18 +0200
Message-Id: <20180422135107.210672134@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454931004625825?=
X-GMAIL-MSGID: =?utf-8?q?1598454931004625825?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 9e7f06c8beee304ee21b791653fefcd713f48b9a upstream.

The code refactoring by commit 0176adb00406 ("swiotlb: refactor coherent
buffer allocation") made swiotlb_alloc_buffer almost always failing due
to a thinko: namely, the function evaluates the dma_coherent_ok call
incorrectly and dealing as if it's invalid. This ends up with weird
errors like iwlwifi probe failure or amdgpu screen flickering.

This patch corrects the logic error.

Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=1088658
Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=1088902
Fixes: 0176adb00406 ("swiotlb: refactor coherent buffer allocation")
Cc: <stable@vger.kernel.org> # v4.16+
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Cc: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/swiotlb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -732,7 +732,7 @@ swiotlb_alloc_buffer(struct device *dev,
 		goto out_warn;
 
 	*dma_handle = swiotlb_phys_to_dma(dev, phys_addr);
-	if (dma_coherent_ok(dev, *dma_handle, size))
+	if (!dma_coherent_ok(dev, *dma_handle, size))
 		goto out_unmap;
 
 	memset(phys_to_virt(phys_addr), 0, size);
