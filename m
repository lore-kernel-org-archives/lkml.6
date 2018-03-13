Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtZypCDgqjjaOlpkiL2yfsPTCkYJqrTgOc+l+qd/PuQr/xj15ViJLG2cHzbxc2b/dAwUp5P
ARC-Seal: i=1; a=rsa-sha256; t=1520955518; cv=none;
        d=google.com; s=arc-20160816;
        b=xGw1GoYj35qb0ZduqsIuZreFvOGcv4p8zOIecKDaPmzPlw1m9euPIfZ6ymVDjw0f/X
         4Yo24rQiW3SbBa50CRs2rltX7RrYZylgKcuM3t/jHQzisEnDGY09l6ifYV0NRBQyGJyr
         aIKExRMxEUOl3ReXWAyEY1Iro64R0rT4ooPJOo5jiMwTYMnswmojSKBk30XZjYE2N8bD
         aDzFsXKBj16Egom6GHJrbOjZdN2Nj/JfKd2ZEgwh4N5Kc2IHtiOA7oTyQYXyYtGgUcmB
         oLW5QIUJxlegkhEntqUH0XBtzj6kdUiJl4+fGTAApQGdOU/aGxfFaqqFO9UCoKei2bwR
         kVYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wBxfw7eeDfZHAIXp5Ru0AWcacuzaKeCHCfg6JtLXImI=;
        b=qiA9IFaSjbb9BCtmqGPlUXCSCFy8+hAI2aJZyCfba4ELYJ29Ueq1BmLWeACG3T0gVm
         itZtD62o8cOBVOgiCNwD54p+nxWC7tDMzsXY+IxuygrK7956hMRUOshbw53L/wk3EnjK
         cFnIDGIDbTvB7YjoLd6Yw8hCtzPIDwGmbeFyDiNfidb3LAuH6L0aBINWy75LaHi+3/RW
         2aBQv6vNdr5RJcObbHVsJWYJryeYqvWAgaLHPCq4HEpbLAfRHGXUKoKB5pa298/tK2nZ
         jGmVdVSLQx6mXvnF+c/0bxkmCVbvMfaQPcZrxgK20LcYjO7f5qk6phCT1B9dSoGOB78P
         MUnA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	James Zhu <James.Zhu@amd.com>,
	Leo Liu <leo.liu@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.14 077/140] drm/amdgpu:Always save uvd vcpu_bo in VM Mode
Date: Tue, 13 Mar 2018 16:24:40 +0100
Message-Id: <20180313152503.326313512@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836860732334519?=
X-GMAIL-MSGID: =?utf-8?q?1594837453589284412?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Zhu <James.Zhu@amd.com>

commit f8bee6135e167f5b35b7789c74c2956dad14d0d5 upstream.

When UVD is in VM mode, there is not uvd handle exchanged,
uvd.handles are always 0. So vcpu_bo always need save,
Otherwise amdgpu driver will fail during suspend/resume.

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=105021
Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -293,12 +293,15 @@ int amdgpu_uvd_suspend(struct amdgpu_dev
 	if (adev->uvd.vcpu_bo == NULL)
 		return 0;
 
-	for (i = 0; i < adev->uvd.max_handles; ++i)
-		if (atomic_read(&adev->uvd.handles[i]))
-			break;
+	/* only valid for physical mode */
+	if (adev->asic_type < CHIP_POLARIS10) {
+		for (i = 0; i < adev->uvd.max_handles; ++i)
+			if (atomic_read(&adev->uvd.handles[i]))
+				break;
 
-	if (i == adev->uvd.max_handles)
-		return 0;
+		if (i == adev->uvd.max_handles)
+			return 0;
+	}
 
 	cancel_delayed_work_sync(&adev->uvd.idle_work);
 
