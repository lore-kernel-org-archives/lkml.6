Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48T7+sLfAHVCt1GhD0WCGkkQwNFi5pCUAtW9uQCkWso66XidDLzC7igNaRnZ3z4lSMkBzWj
ARC-Seal: i=1; a=rsa-sha256; t=1523473261; cv=none;
        d=google.com; s=arc-20160816;
        b=nreNo3jcDSRcp+h7y/NNsqsHK+R+nTgiPc1fCwWltC/GSazb+h05G6gYPF9oNApW9k
         FI/8bbRKHQfeQkYTpgPO2p1AEwudlQfUGJHVkPdNHA7cLfs4osg3RZptAZjoczS8Zh9s
         OAC2COX1e5ybYrKPUblhhjlpKnz7mKzNnzNq0EvwjdFbtMm6HMo9koEzgCe7NPFygIcV
         oDgpUk2PXCkQqAuio31lOvaMEd+Oux8GlW8IzGeBSMFBR4s3Tgmv3WYMwJNsrUfr2IRP
         bMEUq1m9IUK2csJrlpeFJpfJE2kBF6xSliL8xGYbU+sU/9uJ/KOc7vqridqXapYCmMsM
         3prw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7PurB4qAMDp3foLufyb01zTde4D286UZVISAhMOZbGU=;
        b=agwyxG3xtpMG3oISMn1ihHws+FmXBkjQUbSMoaC2TLyEJBiF/FvOzzcQMWETeI5HYH
         bBMV66JwrEp75OyjVFBkgN/nVBWwxSA6K0+WSkYt39hSOOyjcz65CHHBfSH2iSIhz2KK
         a9WaaxTsuLE6LPD/oKGSOGOT+5RpcMlxn4VzlsVf83THVWqIey2mOB6xjKf/4YKRm9j0
         6LGJC/UwfGFmNG2itOZmbsgXpBM55IWyoeRSNCYHBRRajim3AkEvKNPC+Xgtl3NkshyI
         tNmjZDBG59S9n80cnxnHiDNI8R0g4+avOcJTaTQOL2WOe5BdXALHzRGNuxZihyid6B08
         MtUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 184/310] drm/omap: fix tiled buffer stride calculations
Date: Wed, 11 Apr 2018 20:35:23 +0200
Message-Id: <20180411183630.526777341@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476210269715612?=
X-GMAIL-MSGID: =?utf-8?q?1597477498572700666?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomi Valkeinen <tomi.valkeinen@ti.com>


[ Upstream commit cc8dd7661ccc2d8dc88921da8e6cc7c2fcdb0341 ]

omap_gem uses page alignment for buffer stride. The related calculations
are a bit off, though, as byte stride of 4096 gets aligned to 8192,
instead of 4096.

This patch changes the code to use DIV_ROUND_UP(), which fixes those
calculations and makes them more readable.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/omapdrm/omap_gem.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/omapdrm/omap_gem.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem.c
@@ -195,7 +195,7 @@ static void evict_entry(struct drm_gem_o
 	size_t size = PAGE_SIZE * n;
 	loff_t off = mmap_offset(obj) +
 			(entry->obj_pgoff << PAGE_SHIFT);
-	const int m = 1 + ((omap_obj->width << fmt) / PAGE_SIZE);
+	const int m = DIV_ROUND_UP(omap_obj->width << fmt, PAGE_SIZE);
 
 	if (m > 1) {
 		int i;
@@ -442,7 +442,7 @@ static int fault_2d(struct drm_gem_objec
 	 * into account in some of the math, so figure out virtual stride
 	 * in pages
 	 */
-	const int m = 1 + ((omap_obj->width << fmt) / PAGE_SIZE);
+	const int m = DIV_ROUND_UP(omap_obj->width << fmt, PAGE_SIZE);
 
 	/* We don't use vmf->pgoff since that has the fake offset: */
 	pgoff = ((unsigned long)vmf->virtual_address -
