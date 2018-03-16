Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt+22RH+H0/XYiG92t3v0ReaV9Rt0Z5H1OhIm29WEb3tL7yjBKFAjtby3mpA/U9cUroPK0T
ARC-Seal: i=1; a=rsa-sha256; t=1521215065; cv=none;
        d=google.com; s=arc-20160816;
        b=XaoDemQJaSexpd6IGn1EX6Wv3YA2sieOZjGXC3x19G+qT+dXE60D4tZeICJoA8kG6S
         ePd2eQPBg91h6UQsqYdzsi8Hoayigt2mXgWFRMlaYFG5vAR0LT3QeDws+lxElUkR/ur9
         QU/XJ34rauc+9FI5+p0kdzb73FzjWWF5qXbXdb6F9BZ0Fe4hOdMXuwce5mglnQd2eINV
         +YyElFUeAljeLeJY7HoMi6OTHga1s9XmUiU+VaMOmSFRwnuHcO1YpYv8nJIkKCzrWgav
         qyHimIHrE+X1pnw/O+KO4+1qIW/Fd6e8wprjhlEYTcOznvplKd8nfNidqB9wQ365Pi0+
         9cJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nLN38iHFyU1TD3TzCy7maQD5FsSgqFjWM3BNzeUSbc8=;
        b=wa2akmkhU5jE1fT7QY2ftUq0CSkaGCKid418wxMuQVP0C+dyOz8jshAReI68p3knr9
         xZMfRE7lhS4VBbDDo/hRbK5AbjJEW33fSVfwbXmdu07OVkDsqJgQB0wg19vNndUIQOC5
         3RADXvfpIBXs86CQwPLQe+DzFiZio0xzqTMcnBydwugC4lLKTm4tzE3kyHLgXQVqfaaO
         pqT66jteHTFnXxM0KsKnjyACtxGJlMh1DyyoW1nFAuU6l8zN/4Gffo6DXoEmXybjJ4tM
         ta9Wz0oS3th+SWGO+viOuTT14qSqxZ3vjkIR9N8pRywXEtL9mhoMW1KRrktP3Tkl4xw/
         4ySg==
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
Subject: [PATCH 4.15 080/128] drm/amdgpu:fix random missing of FLR NOTIFY
Date: Fri, 16 Mar 2018 16:23:41 +0100
Message-Id: <20180316152340.636044751@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109211229389408?=
X-GMAIL-MSGID: =?utf-8?q?1595109608843545603?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -282,9 +282,17 @@ static int xgpu_ai_mailbox_rcv_irq(struc
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
