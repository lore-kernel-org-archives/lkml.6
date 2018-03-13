Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuTZqmU1TjEZLcj6cQjGyD56EaCEiOmLjGUnrHCHpk3pnpAcHsHnlABCDOLNNLKOMmeJQKT
ARC-Seal: i=1; a=rsa-sha256; t=1520954953; cv=none;
        d=google.com; s=arc-20160816;
        b=whwSTK2mpUpty9UXp5E0ICXJseDz4PkR/RhTE0aGCOmVuyyB/2yP8WJwuutfQ1iCGc
         3m6gczcvHtkt+Ofr2uftUOtz5mMKJ1ar0fMxyvw+nOIcCBGpYc0gTLlZCgAUWF/8z7cw
         9dq+pn6MsOm1z8vBKb23n7ZaluscV50lTabR2czihLbhcsxZyF315SJTnb6a/481DlWA
         D6ujcy3FVNK4Pyt+0JjFQuk3U44Ql64LIGMJ4vnOFxFNXyHco/DDqp0pcRxqVswz90Eq
         r1cSS9IkFiWRvmv2pBnkY0A7tgakIBKE2DOvVwGSKsK7K2klRc7JayJBGT47+f4UHNgU
         OCzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qfK749L/vvAhKFBf6Y09p7cYxXhgHpX61RaeWtzoNcY=;
        b=ZvxwzInLIo4P+cvrsE632ChD+gv2CLDpSDu/xoCkS/1Z2axS7k7yjSxinlXUbYwlb2
         4L7Qbu5KIzJM6jrNQNBk25AwclonfsYj0nLcEfxzSahWwz7LnWXCI2BFyDjDWOVBb+UI
         GRedFNRTRoZWXlMY2SmArj8GAVJOF39691F8hdbt+MoLsFq9kv1aB6vKn9mD+j58LARz
         XDaOoh3rJJlFFsfcePoTHfs//HytSj0ef7bJxJeUj5tV+rxewI1TinF+ihISApbCf7fb
         FhJ+9vUT1vRQ/GTH+8+hCrQunNQotuUXKQuVC8OM9iMGN1K/6A+nZ9v1vTNtKDdv9Sw8
         Zl+A==
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
Subject: [PATCH 4.15 038/146] drm/amdgpu:Always save uvd vcpu_bo in VM Mode
Date: Tue, 13 Mar 2018 16:23:25 +0100
Message-Id: <20180313152323.484999456@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836860732334519?=
X-GMAIL-MSGID: =?utf-8?q?1594836860732334519?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -297,12 +297,15 @@ int amdgpu_uvd_suspend(struct amdgpu_dev
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
 
