Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsY+rpGtEi9rpFOpLCdXMXArihYycvTT0qEs4EPr1pZ+PaJJh996qn39E2V2d/Y7Luo9XcO
ARC-Seal: i=1; a=rsa-sha256; t=1521800175; cv=none;
        d=google.com; s=arc-20160816;
        b=lG8drVEIES+/qLMJyMtScRZcEL3fZ/Y6ccr9jVrC2pQC/CGsJHZc+E5k2sGV42HXpd
         xzDMqQUAEU1WwmtbjaGDajYjYS7IqVlRemKhMlFrRuRCcoGLVlScTkDRJFHFIldl2/XT
         8lmKad2ewiBbvTv9alLK/V9XwVs2yxjWYTnCtXr0331Nni0nI0cRsdJAu+/T1QLJJgyl
         UdhetN50yP7MqbU+ALnJjFjMFBXWdsPj8kqOJe9E1k+xR6AMvmZkbkrTF2AV2bllqgcL
         mWARzzCMP8Y9LEOpTR4I4hgOw27xiJ1S1fSFqS7Lst2VcUW8hJHmFtwh0lRd6Zpvh5Iq
         S5wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ggyNcff1GN10+ZSIp3MSdYwdYQP4KTZKjkmr9OExrAE=;
        b=RCUXQaJ/ouI1DD2zDYgv+oEp8tnOGSeAgv2G7FC1Gp84lccIxx/Zx55ZdlDJoyraL9
         /xUdmjeNYdVl9+IZIvfWLUH8xt6JyWhkxhTBtEg/0QaLY22Z22bjg8lQ2QCakVOT0g/o
         COQjVzGhyafwjIIFhW9X0vDxPOcg6uZlBRBnPs4TYQx+uszSSSe7g46K7J7GccIRaaIr
         XDdISKrqzl1Ug0NgR4v22UN+CjeFgiIhtQ1JesYmaHX9N+e62JVDTMBNJZyxuaHhD2np
         hwdJUHx18UjkAmPUJj0qw4jEa6j74+ASEbuhgP2gsAGf5nJ6p52fsIF+MSImv5Q+ftW9
         QN4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Prakash Kamliya <pkamliya@codeaurora.org>,
	Sharat Masetty <smasetty@codeaurora.org>,
	Rob Clark <robdclark@gmail.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 75/97] drm/msm: fix leak in failed get_pages
Date: Fri, 23 Mar 2018 10:55:02 +0100
Message-Id: <20180323094201.783718616@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595721904913881579?=
X-GMAIL-MSGID: =?utf-8?q?1595723140636159632?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Prakash Kamliya <pkamliya@codeaurora.org>


[ Upstream commit 62e3a3e342af3c313ab38603811ecdb1fcc79edb ]

get_pages doesn't keep a reference of the pages allocated
when it fails later in the code path. This can lead to
a memory leak. Keep reference of the allocated pages so
that it can be freed when msm_gem_free_object gets called
later during cleanup.

Signed-off-by: Prakash Kamliya <pkamliya@codeaurora.org>
Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>
Signed-off-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/msm/msm_gem.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -89,14 +89,17 @@ static struct page **get_pages(struct dr
 			return p;
 		}
 
+		msm_obj->pages = p;
+
 		msm_obj->sgt = drm_prime_pages_to_sg(p, npages);
 		if (IS_ERR(msm_obj->sgt)) {
+			void *ptr = ERR_CAST(msm_obj->sgt);
+
 			dev_err(dev->dev, "failed to allocate sgt\n");
-			return ERR_CAST(msm_obj->sgt);
+			msm_obj->sgt = NULL;
+			return ptr;
 		}
 
-		msm_obj->pages = p;
-
 		/* For non-cached buffers, ensure the new pages are clean
 		 * because display controller, GPU, etc. are not coherent:
 		 */
@@ -119,7 +122,10 @@ static void put_pages(struct drm_gem_obj
 		if (msm_obj->flags & (MSM_BO_WC|MSM_BO_UNCACHED))
 			dma_unmap_sg(obj->dev->dev, msm_obj->sgt->sgl,
 					msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
-		sg_free_table(msm_obj->sgt);
+
+		if (msm_obj->sgt)
+			sg_free_table(msm_obj->sgt);
+
 		kfree(msm_obj->sgt);
 
 		if (use_pages(obj))
