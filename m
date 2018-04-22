Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48UIKmh/iUIifufjrZ6va3zDTDollAvhQehZ8TmosR1+os29RkW+RguhOMolf+KLyt0u4DH
ARC-Seal: i=1; a=rsa-sha256; t=1524405375; cv=none;
        d=google.com; s=arc-20160816;
        b=J7mVpkt3kfC8pVBBP9tuwz4SoArfQvp5EITf1cUpFkMuXjAG4ddlQBwxPztvDQE/x5
         JpCbZww4fLAuAlZlPLrN0/r5dPZbfoHJ6BfX/zHudgp4/4WEakCYeajxqy4Sy8xLmgDB
         eaXE5qsfEWRAB0oZEQ3zkV9i5t41rGq2oEZQ7VzIfKQTaeC9opSQqfPiN/c5X4FmgPN4
         Kt5+CUWEW14n7K/9Ugt8kB6kBAqhoxPdfcClcs0ZSy+QnKod8ee3kX0oExkVBPjujxgx
         mN3tdRAo3Fbt2osWoAI30MMXN3sryE6OgV3DCg0Ss3b9XB38F3mqBITxvyDIkZiYomF2
         THCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gt8ECclKXQU+uTW+2XYlmjim1XM2LWbXT7RdWfyiZ0U=;
        b=QI32Ceuv65DR5zFljWj9muHVECm30biGhzyHZBifx+Ajqo6fP84WE5X3kjU+X+Tv8u
         vlCE21hQpwl7KICwUwvATgI157WtDBUyayhM/d9bEmtUY2e5Mt3ZmRaXFjR5LNCrA9Yg
         Px/zAqnGk0AHF9omX4/FXmesQQF4UTCMCrSvYQoxV5xOVhgl3qwPBhtfH7rD/opSGhB+
         KNsQvZQUybetlH7pnU7tJWHxRryZE4WvtxsLU1YcJ6iD0UE64zRAZ6evFPXHoojP43eR
         MeJliNk/uVXCwaBWoCEg/UszKmMa61u5deN7F+83i700c0DjSmuCj3mBR1ZQIzkM8dUN
         2EUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Balbir Singh <bsingharora@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ralph Campbell <rcampbell@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Evgeny Baskakov <ebaskakov@nvidia.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.16 009/196] mm/hmm: fix header file if/else/endif maze
Date: Sun, 22 Apr 2018 15:50:29 +0200
Message-Id: <20180422135104.678777004@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454891463634432?=
X-GMAIL-MSGID: =?utf-8?q?1598454891463634432?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jérôme Glisse <jglisse@redhat.com>

commit b28b08de436a638c82d0cf3dcdbdbad055baf1fc upstream.

The #if/#else/#endif for IS_ENABLED(CONFIG_HMM) were wrong.  Because of
this after multiple include there was multiple definition of both
hmm_mm_init() and hmm_mm_destroy() leading to build failure if HMM was
enabled (CONFIG_HMM set).

Link: http://lkml.kernel.org/r/20180323005527.758-3-jglisse@redhat.com
Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Acked-by: Balbir Singh <bsingharora@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Evgeny Baskakov <ebaskakov@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/hmm.h |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -498,23 +498,16 @@ struct hmm_device {
 struct hmm_device *hmm_device_new(void *drvdata);
 void hmm_device_put(struct hmm_device *hmm_device);
 #endif /* CONFIG_DEVICE_PRIVATE || CONFIG_DEVICE_PUBLIC */
-#endif /* IS_ENABLED(CONFIG_HMM) */
 
 /* Below are for HMM internal use only! Not to be used by device driver! */
-#if IS_ENABLED(CONFIG_HMM_MIRROR)
 void hmm_mm_destroy(struct mm_struct *mm);
 
 static inline void hmm_mm_init(struct mm_struct *mm)
 {
 	mm->hmm = NULL;
 }
-#else /* IS_ENABLED(CONFIG_HMM_MIRROR) */
-static inline void hmm_mm_destroy(struct mm_struct *mm) {}
-static inline void hmm_mm_init(struct mm_struct *mm) {}
-#endif /* IS_ENABLED(CONFIG_HMM_MIRROR) */
-
-
 #else /* IS_ENABLED(CONFIG_HMM) */
 static inline void hmm_mm_destroy(struct mm_struct *mm) {}
 static inline void hmm_mm_init(struct mm_struct *mm) {}
+#endif /* IS_ENABLED(CONFIG_HMM) */
 #endif /* LINUX_HMM_H */
