Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsWAuA8ipjs17GcnzkeIxua5iaXXQH3UoMw7LBkfc2lPgtIG5vykxbeeKzRgXN2VOq/FahN
ARC-Seal: i=1; a=rsa-sha256; t=1521800413; cv=none;
        d=google.com; s=arc-20160816;
        b=bQMU/d2Ka+ccHSi+Gk1VBPsMjOJUkVwtuOL79e3sD4umqKzj5Vvr5BP0CLv/lagNbp
         zQukc73VMhGMPwCNfytfUpm3vHEtuysn2JAh0w0takzgHRaVc7penqdfa/uuB/n/X9aZ
         PFEE1zOl/IaMaVihy6sPoDiAV4IjTqDkTC6GmL3k1mHjebBe9Qvvc8D/IXVCeH+GKsM+
         SYMcn5I0A1NNA+ekVcFUjN3Pnz/b5Il2h5Q0/cOAV7HWnyhZWtCFUN/1KIXPc7j3XSjG
         P9eMgk9T0uvbqb9jJsSI6mXZxwGGyWYJYPfwkWPzzOig9Wo4YlzE2dPsY/bRE5YU6a0g
         6/ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sSWv9M+VdHXsbOBISqRl43O0ObHTvSMJBSDUpQhUZjE=;
        b=AmkfACOfMMrdN5q5T++zXAKiV/f5n979SZA/Q9meMllEv0Omp8W3PMBXSGMiH/Ykcq
         T+LljKdUMYiAZF0rbX/EBREBs5dL84/kLNq5QMMiSzdpN82CjrNXnRBKD98I/tBP3ETy
         1EnCQQa7d4MvTWBO4d2xy547Py1kbnpE5M1zinaQQUU6IhffT2V5pzCb3UWnQYZOEcVw
         qhnzWahGn0ATaukS/ceLWyk51zx3BQFaBraKot1vZkfVTjLfthNUhjUFeVetDu0UwAsl
         Evzv+9y4UuTj/YBmc4FbporESAbKBiLlr5V1i7yrv6dLMijFa1BRF/APt7WRHidFHLga
         BCTw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 44/47] drm/omap: DMM: Check for DMM readiness after successful transaction commit
Date: Fri, 23 Mar 2018 10:55:35 +0100
Message-Id: <20180323094250.001533219@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722059717859686?=
X-GMAIL-MSGID: =?utf-8?q?1595723390074543779?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Ujfalusi <peter.ujfalusi@ti.com>


[ Upstream commit b7ea6b286c4051e043f691781785e3c4672f014a ]

Check the status of the DMM engine after it is reported that the
transaction was completed as in rare cases the engine might not reached a
working state.

The wait_status() will print information in case the DMM is not reached the
expected state and the dmm_txn_commit() will return with an error code to
make sure that we are not continuing with a broken setup.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
+++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
@@ -280,7 +280,12 @@ static int dmm_txn_commit(struct dmm_txn
 				msecs_to_jiffies(1)) <= 0) {
 			dev_err(dmm->dev, "timed out waiting for done\n");
 			ret = -ETIMEDOUT;
+			goto cleanup;
 		}
+
+		/* Check the engine status before continue */
+		ret = wait_status(engine, DMM_PATSTATUS_READY |
+				  DMM_PATSTATUS_VALID | DMM_PATSTATUS_DONE);
 	}
 
 cleanup:
