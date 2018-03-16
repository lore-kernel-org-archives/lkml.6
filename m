Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtFNK7c6SPoW+YjzWaFx+GvLeoEjx2uTTWvXd6HdKrvsvhB0C3HjANAyz1+Q7v1IRqiVjBj
ARC-Seal: i=1; a=rsa-sha256; t=1521214686; cv=none;
        d=google.com; s=arc-20160816;
        b=wt/2IsSfi47NWmikcDKI+9SQ8zfPN3eXQQOyhGvIaDAOwk2RH+kuEZt4S5eZX80wPJ
         56g1G3Y0khiH43RjIBwfSnxEiqFABJh1oswlrXYKL8UTevji0mOSCZ7puzDGoT8gTvba
         +nTcY26F427vdbCAsGVRYe9oUwNEs0xaXYOBnOnRYiZbRsW4VTgySl9Lt3SxksvQaJe/
         8Ak8sFogqBAA0yfyTqhi998thZgYnqyKD9WTDXAT/F3/C88669dLauM3MQPObUaSP6z9
         FTnr3TVqdloSICMQuLqgxpmnS4j+IdAyi5XDRObqr0N/BdAe0bpHqr/bcd3/5/0KDTWc
         ZXQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=G1zM9bp/mIbvHJr5MqVW58TugdJUFfBlhYNB/p0YSb0=;
        b=mWU9OC3YHz4CGQTN/4COnud1QQXxYHF1baErCHMQ+OI6EfFHGAE8GWBkr5e+bTCbXC
         kYuwA1SphIXQgL06jrKbvz7uAoOdm4xoAnGj3ffwBliIWl55UR15eYBLDRR6RVFNqU1P
         AhM4PXv2HQV3TVsNCYBMHOrxCMEVF4KzNysNxWZOiR7r8zob/UKRQ3BlP/UiTFPRCP/8
         XyhtyTw673AVZotu4btguZQGwfKUsM8gfBbNAa85B2S8ptmstwF76tAStTNfHEwPwJwE
         l/cRy/oABHFmpDI8f0c0BKYF/GzCuyMf9X3s1ydFa6AscGIYg5k7X8ZKxuuvurvoNW09
         eRkQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Monk Liu <Monk.Liu@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 066/109] drm/amdgpu:fix random missing of FLR NOTIFY
Date: Fri, 16 Mar 2018 16:23:35 +0100
Message-Id: <20180316152333.579970276@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109211229389408?=
X-GMAIL-MSGID: =?utf-8?q?1595109211229389408?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Monk Liu <Monk.Liu@amd.com>


[ Upstream commit 34a4d2bf06b3ab92024b8e26d6049411369d1f1a ]

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -276,9 +276,17 @@ static int xgpu_ai_mailbox_rcv_irq(struc
 		/* see what event we get */
 		r = xgpu_ai_mailbox_rcv_msg(adev, IDH_FLR_NOTIFICATION);
 
-		/* only handle FLR_NOTIFY now */
-		if (!r)
-			schedule_work(&adev->virt.flr_work);
+		/* sometimes the interrupt is delayed to inject to VM, so under such case
+		 * the IDH_FLR_NOTIFICATION is overwritten by VF FLR from GIM side, thus
+		 * above recieve message could be failed, we should schedule the flr_work
+		 * anyway
+		 */
+		if (r) {
+			DRM_ERROR("FLR_NOTIFICATION is missed\n");
+			xgpu_ai_mailbox_send_ack(adev);
+		}
+
+		schedule_work(&adev->virt.flr_work);
 	}
 
 	return 0;
