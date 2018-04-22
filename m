Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/1XQ7GN69YTQGmWEt4damhO9x/PNhV78wO+dk/KB3Vb+CF3jlx2JgNpNS9iXmCvNC94eKU
ARC-Seal: i=1; a=rsa-sha256; t=1524405889; cv=none;
        d=google.com; s=arc-20160816;
        b=gzSBGvKimTSb1hNbDg/sB4oHrZzN2ym9Oa+SiDVyWIyWO3OHtUh1Dpb8Z21umSDIbI
         x4svSSiq/nNkVghbPrF5D9QhYx2V97nOcAk4Rxcj/uvLySpBRkWmPlh0hDhHaumzSweI
         c9jM1syDLPh4VIjGM8s8vLeuXKUoSE2Hrxd2iKJITgcNOt2lLCQllQJjw5E4bEk6bihO
         wPzmsb9q6yOX1FKrx/utMY2p4IGq9Ik89/Uz3fiROanncBznIrs+PNtxUOfDh4iOlr6n
         MpWUFB4B/GA4x7FJMqzbyOGEmNLidbdhwP0nMFgvkBsM9lKsXsN+89tSV917ZIR/9U/B
         B4wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=85U65jFoCYn+56MLwCfzzrDOnf2VBpEaRCZDMcoc118=;
        b=gv1BSHLmkMyUuEIAkRwArm4oo1C/YFcvlufB6Eo5f5isHBJyL/jJUFWPU9D7A+mVrU
         siUud67ci0MjzHJgWnpOXyrDqdGtNgMHoifM7LFFUHG+DTj/tXc58O2HPPTyr8rMmqi0
         Y5eWy9vs1FY/GReUxv93+mxDoaVr3KqIg8dGQ4nPZ8qvvWYn2njGRQvUEKBF0CX35bfL
         sU9CeP5su/T+v00tFiGUMaudew0zDCvF5U1TVtRud1TWQfD+GVQwORHJfAvugqB8+918
         8AaejONJ+bjMmF/eyCluCA23+QzCU/pm6mF+c3v2my9JI9JUvZhvOkfYRbQ9jBeE+RHw
         v1mw==
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
Subject: [PATCH 4.14 008/164] mm/hmm: fix header file if/else/endif maze
Date: Sun, 22 Apr 2018 15:51:15 +0200
Message-Id: <20180422135135.736647459@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454891463634432?=
X-GMAIL-MSGID: =?utf-8?q?1598455429872593729?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
