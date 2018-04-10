Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48GmZTA+0Xbew3CUgOeGGxBW341jP1Mwt0g1uC8Yd5DvNlNEJVYDKOKok1qHgWTeyzJA73a
ARC-Seal: i=1; a=rsa-sha256; t=1523399393; cv=none;
        d=google.com; s=arc-20160816;
        b=ZINyCirKGGKzNOoUUbqCnG5jhblCuqfxWVAROlFIC14k7w7RLhbl2H1+3WM3wM48xa
         EkvVrCMpgAtMMgkhgArynHkotAVFgwr/lJ/GKNJXn8tuQvwFYjkutFtSTNLIJLlD3V/R
         0gRWla6OeLQiD/z7NNk5NzAdCX9oEcr2rxFSpaXj9kkUgLTGLjauypqrM5R6hmTiSXjW
         NDqk/cGpdggpfEL9a2+pDQ2VKOehl2mihwsNhVDgbf3kAj6J793Ska1xopeyNUv1n7cE
         ibMHxszzRsSnftMFj73efsQh1NzchvQFFruExbMSmntFaT+AfRiErqYKg0/L/vnJcVDt
         usRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rfR/oYd0B8Ja1ZQQnd8R8HDBNC5ypBgn3ufXVywj0A8=;
        b=OCV3SdcaFIWuS01AIvvyuZD0gZIOJApNNU+w+J3taAgPLzahT5SAEe3DF7jNV7hAuS
         XAUUUBV3wxNZsuq3xUqxfuqjY+XV6wnXuTfheYDkv+FtTGeZc/jwCD6lZBh6qAKfpEeN
         KZWW9P6eXZwadYzKJOPQsqFk31pwozxq7EsATpwsM/KfE498R9/3ozBBbgTziEK4CyCS
         CzPjVuYlshsqcMw/25yvUaDQlTsDRDSX804G+hpRvOFmUmpysX7qrQFrGHHzXNtgmh9D
         nZCCLhw1x91FTiII98yi6b3zRTqUf318IRf5zzBWH2Mdepsh3ftA3P3inUjGph46xQQP
         c6Ow==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yintian Tao <yttao@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 091/168] drm/amd/powerplay: fix memory leakage when reload (v2)
Date: Wed, 11 Apr 2018 00:23:53 +0200
Message-Id: <20180410212804.132870137@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400041956836318?=
X-GMAIL-MSGID: =?utf-8?q?1597400041956836318?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yintian Tao <yttao@amd.com>


[ Upstream commit a25513e7b9b15c318ec44113682e988829aef746 ]

add smu_free_memory when smu fini to prevent memory leakage

v2: squash in typo fix (Yintian) and warning (Harry)

Signed-off-by: Yintian Tao <yttao@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
@@ -648,6 +648,12 @@ int smu7_init(struct pp_hwmgr *hwmgr)
 
 int smu7_smu_fini(struct pp_hwmgr *hwmgr)
 {
+	struct smu7_smumgr *smu_data = (struct smu7_smumgr *)(hwmgr->smu_backend);
+
+	smu_free_memory(hwmgr->device, (void *) smu_data->header_buffer.handle);
+	if (!cgs_is_virtualization_enabled(hwmgr->device))
+		smu_free_memory(hwmgr->device, (void *) smu_data->smu_buffer.handle);
+
 	kfree(hwmgr->smu_backend);
 	hwmgr->smu_backend = NULL;
 	cgs_rel_firmware(hwmgr->device, CGS_UCODE_ID_SMU);
