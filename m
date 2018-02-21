Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226rkIQnAOdE09BFRVZB58BRzwfATfLNdh3/cOVXsz0wbyibFX7r9rhKGoOhZmdUUpGvIsN4
ARC-Seal: i=1; a=rsa-sha256; t=1519217919; cv=none;
        d=google.com; s=arc-20160816;
        b=UlnHpVfmnmoW1vkMPUIpzxXLKsBvyzorZVLaj/ZCcneuhbSg1mvLaaz6dC66UUEiBx
         osY7X+G1YNyI5azy4mBOq6v4Evv2FYgmbLXO+cD3pxamW+aErk7y9XnAMnnI+vkvo8i0
         up8TrI8hdSb90GczNQimJTIaelC74m8ggjWKNzfaAevOjySsOMtBkRnqknNAS4GxjVQe
         l3nolLAf638ZJdkdDP8oFgtxUCUbqNV6A1uAHooKiJ6TzjNXmnY+/DvWU98WoIuaoPRa
         3zpNIlMSmDhUx5kaYKjCbNXHUBd2IQBvbKjBeqKhL3yiDbHMaLZyI/YwAqjzQ5u+IEq4
         gqVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=l/S8ijsTLzkXN47tsM/w8hJG2S5fz6UgnAfKpAveq64=;
        b=w3GFetc3Tb46LcgD5cAwAmVK2Rvq1aNt/SBlBVUUlPtfIT9zTq1Ne31b1Tr5k5fTpU
         j+Zc3RKqUnPB+d6ALfakJO/bC7m4gzQ26INyABn57OX+VTx/mdkWo+9aFO3/oCQzRFKt
         8wARlItkOqMDkVl+OcaCwuc/8wkaqmc02nphUvHQgESRc7kPh9SWFKTdBOci1Ei9SP1G
         jC2plHZ7c1/lObCWk7Y3UjQqyQixOMWdQ5LmIXPVwh4xhJH7rrldoVq8IJFiNbxNgPZy
         DlFvZPMt1g3LGYeIw7kCdLu48YsQVJp4JNuYx9iuPPsnzlYizw7WHop8mDnMUrJ7Rbg1
         Hanw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Lyude Paul <lyude@redhat.com>,
	Chris Wilson <chris@chris-wilson.co.uk>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.14 024/167] dma-buf: fix reservation_object_wait_timeout_rcu once more v2
Date: Wed, 21 Feb 2018 13:47:15 +0100
Message-Id: <20180221124525.938218796@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015448910696170?=
X-GMAIL-MSGID: =?utf-8?q?1593015448910696170?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian König <ckoenig.leichtzumerken@gmail.com>

commit 5bffee867df7494ecd32c1e6ec4e8fc934c521b7 upstream.

We need to set shared_count even if we already have a fence to wait for.

v2: init i to -1 as well

Signed-off-by: Christian König <christian.koenig@amd.com>
Cc: stable@vger.kernel.org
Tested-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180122200003.6665-1-christian.koenig@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma-buf/reservation.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/dma-buf/reservation.c
+++ b/drivers/dma-buf/reservation.c
@@ -455,13 +455,15 @@ long reservation_object_wait_timeout_rcu
 					 unsigned long timeout)
 {
 	struct dma_fence *fence;
-	unsigned seq, shared_count, i = 0;
+	unsigned seq, shared_count;
 	long ret = timeout ? timeout : 1;
+	int i;
 
 retry:
 	shared_count = 0;
 	seq = read_seqcount_begin(&obj->seq);
 	rcu_read_lock();
+	i = -1;
 
 	fence = rcu_dereference(obj->fence_excl);
 	if (fence && !test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags)) {
@@ -477,14 +479,14 @@ retry:
 		fence = NULL;
 	}
 
-	if (!fence && wait_all) {
+	if (wait_all) {
 		struct reservation_object_list *fobj =
 						rcu_dereference(obj->fence);
 
 		if (fobj)
 			shared_count = fobj->shared_count;
 
-		for (i = 0; i < shared_count; ++i) {
+		for (i = 0; !fence && i < shared_count; ++i) {
 			struct dma_fence *lfence = rcu_dereference(fobj->shared[i]);
 
 			if (test_bit(DMA_FENCE_FLAG_SIGNALED_BIT,
