Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsk/BUTxdG7t3YnLbz34IY4IgbpGsylqxea1jTz9jD7Jnczr3b38RPQpW07TO0o2VeW4MZm
ARC-Seal: i=1; a=rsa-sha256; t=1521800251; cv=none;
        d=google.com; s=arc-20160816;
        b=0yvWCGjTbecKORUOkskMwYqIxnx9uAS6+Zxh35PY0NUlUbA6tJtqr6H1KgbaE5J0bn
         9RY6u3sd/nJ4cyotsCKM7HDSG6eCReq31GMshKO7jjPM2BSeE7XAwqxcUmprB2onB7n8
         hO/GLwLljvz7POjdshyq+WFfwT0HKga4g4UloHNP2K95GHgYzD8h0jwplJjjsJ0SBPqw
         Qb4JpAJOutd74mWM/7fWkFWcC2iR5HSPNfjvcJ//fJv/AC78rPakkj5tHBdgHXdCaUDC
         +hiPqQuwDKgDmobtlK+sZ/eIF+SNeremTU7Tm1Q5AGPtp2/9gzWTJxWjQTXR6F/U7EvC
         2fMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TX9GS+2oqC+OH9jONtZOG6UM44qmy6B9Ec+phwj16YE=;
        b=nJ6QDUqjvVF8d357EMsFRWOn1aNO7NpyC2By9fjBHGoWdrQVWS6KRspyJaZ1Oj40sE
         BcmA8jm0ly31tSfFHHZyM4SUFDdiJmc3MbufDUgmhgSIaVOwhA30sMUF44zv8yQxkS34
         /uYECYH2fjdFPoC4tK+sh4rU29ATZ+0vAxtprqi2n+CWuB7tJMN4J70WAs6K9HsNq49k
         019iwEin14N2mpx6cRHe/NtlOxEJWu4N3RB9EhHnnDQUw/xUvpB0ViJNMcQ380bhIWMs
         +UhyU7qYeAWXC5+WzvNoLgiCjyDXlxaXRDy4m3Z4tZ6oZmHyeo4mTpgNySeKj7RwsIi7
         cuFw==
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
Subject: [PATCH 4.4 87/97] drm/omap: DMM: Check for DMM readiness after successful transaction commit
Date: Fri, 23 Mar 2018 10:55:14 +0100
Message-Id: <20180323094202.361754447@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722059717859686?=
X-GMAIL-MSGID: =?utf-8?q?1595723220695005197?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -288,7 +288,12 @@ static int dmm_txn_commit(struct dmm_txn
 				msecs_to_jiffies(100))) {
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
