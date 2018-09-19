Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9C4ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F626214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L7dG8IPZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F626214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732623AbeISXq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:46:29 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46215 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeISXq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:46:28 -0400
Received: by mail-pl1-f194.google.com with SMTP id t19-v6so3022814ply.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 11:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=gf4EIDAAMwHRdiQuZXpaa1Oh3ACpC76ItHZ1frX+SWY=;
        b=L7dG8IPZRm+kDIPY8pi3aM9OMkF66KPQg7YA2lWg37EVqhsiV1i5uHHJfHbziaTE6o
         AQpAeDIQOiTpufoKBIsaNGbQXl/trdNXPDytAWNgeGbfa1IWi/XlWavYWT0AirEGJ5dO
         J/7cKKuaGE6GtUWPGNbi0HY9eQPN/AXZgAtwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=gf4EIDAAMwHRdiQuZXpaa1Oh3ACpC76ItHZ1frX+SWY=;
        b=Bg8KbaNCEXxkqL9tCmDTR2ScD6kTsX0ikiFyzaDyIZYebwF1oprOKqebA1ONSg0mSZ
         UGP7hlZknsZp1UshZGBX4sgW83EKd4ugEyMRi2Gf61d5Cfi97qKScu9w1O8EuZI4rwho
         M/Xl4oIQOaS5kwlgGhEZ1nj1CLjtmJJiuiX/F30+rDXde+3eYyRRq7zJ48tk92L201/1
         7woNBVfgsg0CWkz6B2FZJRx0sferUkdwHRBnKGIUUUp2Actd0YrM1R1/EDMOn9dB8W4g
         qlHqtE2XXA0Uk8L1LXE7zTl9soiOVP3NH7fzDzXmAAtPW4iuHEk6Fz8ZFEM3OQSSstno
         BAlA==
X-Gm-Message-State: APzg51DogcAN4EILLfQm4SkRsd47aCjsFSHvVx3v6q+I6x3JcLWiKv4T
        ZR74JxrlQ9ByDkIOhn2orfUasw==
X-Google-Smtp-Source: ANB0VdZlSfkXOcADWJKV6O7EGO0imHnpi6m7sB+BhpfQ2jG4+WOyRkQURi10Xl8mnyVVD4IqEsQR/A==
X-Received: by 2002:a17:902:9a06:: with SMTP id v6-v6mr35725698plp.316.1537380444796;
        Wed, 19 Sep 2018 11:07:24 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id a90-v6sm52463696pfg.106.2018.09.19.11.07.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 11:07:23 -0700 (PDT)
Date:   Wed, 19 Sep 2018 11:07:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Davidlohr Bueso <dbueso@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ipc/shm: Use ERR_CAST() for shm_lock() error return
Message-ID: <20180919180722.GA15073@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This uses ERR_CAST() instead of an open-coded cast, as it is casting
across structure pointers, which upsets __randomize_layout:

ipc/shm.c: In function ‘shm_lock’:
ipc/shm.c:209:9: note: randstruct: casting between randomized structure pointer types (ssa): ‘struct shmid_kernel’ and ‘struct kern_ipc_perm’

  return (void *)ipcp;
         ^~~~~~~~~~~~

Fixes: 82061c57ce93 ("ipc: drop ipc_lock()")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 ipc/shm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index 4cd402e4cfeb..1c65fb357395 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -206,7 +206,7 @@ static inline struct shmid_kernel *shm_lock(struct ipc_namespace *ns, int id)
 	 * Callers of shm_lock() must validate the status of the returned ipc
 	 * object pointer and error out as appropriate.
 	 */
-	return (void *)ipcp;
+	return ERR_CAST(ipcp);
 }
 
 static inline void shm_lock_by_ptr(struct shmid_kernel *ipcp)
-- 
2.17.1


-- 
Kees Cook
Pixel Security
