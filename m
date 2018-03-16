Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvsLK88e6EqMPdb8cNVro0oz/j+YpfGk6tKwz98RsTE/x4NvrL3iyVUrkQsWH2MyqFbTaKv
ARC-Seal: i=1; a=rsa-sha256; t=1521214308; cv=none;
        d=google.com; s=arc-20160816;
        b=l4duC42P91CqE4SuK4/pLDP9zDnseIq7d0YPihJJgL1nVEiXLrrpLlMpEx6AC7YsWI
         g40sSvRLKQUI3cvHZVRIEbeLIk+A67Ug1atnzY+ny1ToRmLxt8BSO76wP7CqyO7S0zCR
         XiVO81IxZ3jfR105ka9vwzxOXKF0UMNxPaDCY582dQtFNvDoSMiXgUKzBC54EEcLip/X
         7NfeXph/njAdb2xoGTWK5mVmpuqeFeOlnHWL/pc4OGL+euzjm4ohJmj3tpuDxcfNto3D
         uE7FhEaPNI7qxrYyQ8h4N0hUoSRQ4a6zGIKunNFeUZ1j6esWO+BnX/8y8Xa0c+se+cTT
         dTuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pwboRZEfZ+r0XIt8ulwYyoANQOgG4SLIkNnyjxSBiH0=;
        b=iqpvZro5mKQ4BhQEUlobz/KWIkPXv6rUzUQgoL2Cp1i4KuDLOhCNuSOma+XZI46wua
         TafWDyeGAs9oE5w4vlb5NH9/ZBaSWziUQVf9+LDM03y7tjmITeiNKMIabu1UPly3d7Qm
         CWkJrzzBYPrpu+6weI+cyHM6Ax7Btsw4yUDSHvWLbjLvKPgCtdeol4RyrGQIz3P7qBGX
         cKtdGdU9lRGLm41D4cL3nxWFQethJO5p+vAxZTMnOx9jyc2HedxuQU9tNp3zeeIrkRXu
         sYQjAFO7lL7ZalexFaN1uGpNOKe21mbQ0GG1LhLq3pY3dZZCLGmrsoZtxq0ksYCLlEHr
         ytSw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	James Zhu <James.Zhu@amd.com>,
	Leo Liu <leo.liu@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.9 16/86] drm/amdgpu:Always save uvd vcpu_bo in VM Mode
Date: Fri, 16 Mar 2018 16:22:39 +0100
Message-Id: <20180316152318.404653287@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108814988263892?=
X-GMAIL-MSGID: =?utf-8?q?1595108814988263892?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -273,12 +273,15 @@ int amdgpu_uvd_suspend(struct amdgpu_dev
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
 
