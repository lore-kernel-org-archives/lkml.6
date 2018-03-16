Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvVkOObyjay9qhtlvCoEXdNwRqxMqpdU30avVfYZ8lGvLzpTWBL8EoFkT+JujZ3MFq9thfw
ARC-Seal: i=1; a=rsa-sha256; t=1521214709; cv=none;
        d=google.com; s=arc-20160816;
        b=u/iD2M2ptKIj/pGhF3TxUqZ4mDNoKWzZ46zBisTyYmDMywEW1okGBPuJ7G6woYC2QJ
         xH36/Q5h2UVkrfrtVaFCyR/QG9ecyf1zUFOxxFA5zCN2P1vurravAQqjR/ByMm98LSho
         4GCcJeyk3oe9oqfLGR0GHHPqFE7XuhQaDAhYwc2XWcR8pgj32wNfcgwgX8DvcSXxTtNT
         c2fRuvBaPltQOSKo4c4dgiHS4yRPWcNFFBVoW1g/qtNytRjmHR1a0i7zhnaoDJjfy63r
         2+Vm3cybQnBRMHYZsC6u9fzomDf5IbafToWmroZU6eg8YWTAx88dxPjhG7rF61OIYD0o
         sWpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dOBUzLU2BXHtFQBWNDfdt5lF8Jm9UDwYykxChu9TTtA=;
        b=yv4x6HaXVp10d69OahN7ggBvZVFrN5XzmQz969dNN8KkM94SJJQJfjvud0SWVwktrw
         jfqrgGV0J3JVmOtlz8K6Xs4ngYHuWgM6eWOc6/dNNBJDpiGWoFN7kQUvsUn8UxqpMYR9
         wkgQ1v7ju9RkZLXTTZJUpNSvda511KPn0KM1sWGl20m1zgbErQnb6PVOp9N26XJdilXZ
         AvJawVGiB96c/cgGS8CXyZOVyEmSu2DGBXmiRfS4ayhHGRtxkhojYq1kixXdgzjEuYe3
         DrySHWog/j1LNS/aYIU2v7RG1aEz0rC3+gu1/UiK2uCCJK01MAkI0UQOydLwQEP/mhuc
         G4VQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 100/109] ASoC: nuc900: Fix a loop timeout test
Date: Fri, 16 Mar 2018 16:24:09 +0100
Message-Id: <20180316152335.306771391@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109235197887360?=
X-GMAIL-MSGID: =?utf-8?q?1595109235197887360?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>


[ Upstream commit 65a12b3aafed5fc59f4ce41b22b752b1729e6701 ]

We should be finishing the loop with timeout set to zero but because
this is a post-op we finish with timeout == -1.

Fixes: 1082e2703a2d ("ASoC: NUC900/audio: add nuc900 audio driver support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/nuc900/nuc900-ac97.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/soc/nuc900/nuc900-ac97.c
+++ b/sound/soc/nuc900/nuc900-ac97.c
@@ -67,7 +67,7 @@ static unsigned short nuc900_ac97_read(s
 
 	/* polling the AC_R_FINISH */
 	while (!(AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON) & AC_R_FINISH)
-								&& timeout--)
+								&& --timeout)
 		mdelay(1);
 
 	if (!timeout) {
@@ -121,7 +121,7 @@ static void nuc900_ac97_write(struct snd
 
 	/* polling the AC_W_FINISH */
 	while ((AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON) & AC_W_FINISH)
-								&& timeout--)
+								&& --timeout)
 		mdelay(1);
 
 	if (!timeout)
