Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226r7Ok/KMs+dBNbU6bvMuzxJ8nDCK9PbCgfEL7pH5Mb9PVnkxgATqW3OTiDQOeRBO3tXI4X
ARC-Seal: i=1; a=rsa-sha256; t=1517591609; cv=none;
        d=google.com; s=arc-20160816;
        b=VIXStjX6ma18xwxZPVV5QeexUV2Gj14SQHObOdDA6tJ8ZtKiA8/1mU1yueuOUTOV+w
         T/+bAWyoaFN+X4d6ZqWFKuvVZA29jMuYWWwcfoIIYVuTHX/emtmAH/A0sN19tCUUEn8b
         bnv43b0rsFf8BPSerJRh0D4n04ZmeKfxaNk903n+1y0MqaKj0q5VEBWUMBjPnaVsBuOh
         CbyUE7jhX9B2gk6uzQVmCgZCtAalaXemA2q9tIG2zSQ5D/Gm2eaZZSJF+lj1TkZKXO19
         QZKac2hGcdSTT3ekagVibMwr6IzR/Pnr3TPGArOXhxH5OgBE3ia2D1qyKiK4tmrX9uQ/
         5PkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=z5kxmCeqZzCrXzddlk1xfFAB2XhOV0DLQ4OO+eXBhaU=;
        b=sBnF4AcJfLye3OskLuTCqLtcaiJ6gfO07vM4jZX4tXzdq7LXey4XVX5wSmiRMAzAEr
         BLD4tt4jMJe0peqH//sQbNPUXGfB2bC4vbpLYNvsLgr5zwl935Lqk4D0rcisb7qws3cq
         EXangMOjjocnaFqwx/ur5M9CQJrmTBPgR+RA8jEAOm89QnTQF7WY3fcT7/sVJ39+I634
         akvRR9rPbRbpEBF5uihtN7I2LBk2tiu/e2FjBGpmfTeycnCDYgLiB4VpEBXhJ6p18JUa
         9YvkwlVoq2z4cAVjXbkiVbbHWGwBHP0+0V+GDr4mKvdtXsaz0wYkVnRkL0kg65NvUiH+
         arrg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 099/156] drm/amdgpu: dont try to move pinned BOs
Date: Fri,  2 Feb 2018 17:58:00 +0100
Message-Id: <20180202140844.696671999@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309650985590160?=
X-GMAIL-MSGID: =?utf-8?q?1591310139094527026?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Christian K�nig" <christian.koenig@amd.com>


[ Upstream commit 6edc6910ba4cd6eab309263539c8f09b8ad772bf ]

Never try to move pinned BOs during CS.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Michel Dänzer <michel.daenzer@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -403,6 +403,10 @@ static bool amdgpu_cs_try_evict(struct a
 		if (candidate->robj == validated)
 			break;
 
+		/* We can't move pinned BOs here */
+		if (bo->pin_count)
+			continue;
+
 		other = amdgpu_mem_type_to_domain(bo->tbo.mem.mem_type);
 
 		/* Check if this BO is in one of the domains we need space for */
