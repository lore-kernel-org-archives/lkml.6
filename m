Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226DIwDpp5mxo1XSFyN08Mz/YGPJljuOHYFu/wE8bW1bAw6haPJaqs4Acr20WD6PdowINipJ
ARC-Seal: i=1; a=rsa-sha256; t=1518709378; cv=none;
        d=google.com; s=arc-20160816;
        b=EdWTVniwPemW3dHxpC8LnEFz/kOXhbN/nMg6OsxKDiKsjZJzkTw0uzgBXdAl1jyTkT
         xpR4uBm2bZn2K8c5ViHnWggSfes/EnIkeH9VJja2qq8uTE3EpqaE6FbWeJ5OMR2+N2c/
         RvBYyTq+U5ZImuD6nuJ6haSBzcO1U0I9lN6gvuG7r5D7aBmQ8SsjweRALntUtRhWfm5U
         3pzF10otQO+950IkjpibkmA5pjeUPz8Wwz38Jahs5ryctv5i22mbcR/xTFwx640pUYXZ
         BcbzPvpHNymT/95+sHmvgB5NmMlOsQ921evTrAs+mezkU5tDXXSSBvQikxHBCbO6wHHa
         gpig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VZpFa72QY9UQ5OrsjcEGziuAlZZe8L/1RIp4pG3h8B4=;
        b=AqDELwweNunoXuTfyWlHt4Ch+kPuatWVsZ5K6TL4qBqcIOxjptro3sv1V2yVKqGgGB
         LJqH1+nahlEULxGkFRodiW2G5ZbJhP3hLrzCaLrL2W80zTUCak+idGhtMEhOAmbhLeVP
         c/gynV+hpYZYnoaNY8qsIkEeSGvbG9UXKmMytWk5yBEWl1WnfohZhyLvSZoB0zgVAM1+
         dXDr3rFuIV0YyWwi/g66ANBdPRTElyhjJzW9AUEdhUe4PYpRC+hah9LvtW/S+zHkvux6
         z8HKgAqp9NOg47qHUWrbRjcn4T/ixYFT1RC2E76ASMnYleRW7SlomA/ZYrb2BW8oZReA
         oMCw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>,
	Trond Myklebust <trond.myklebust@primarydata.com>
Subject: [PATCH 4.15 097/202] nfs41: do not return ENOMEM on LAYOUTUNAVAILABLE
Date: Thu, 15 Feb 2018 16:16:37 +0100
Message-Id: <20180215151718.430400589@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481651451341949?=
X-GMAIL-MSGID: =?utf-8?q?1592482204932704700?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>

commit 7ff4cff637aa0bd2abbd81f53b2a6206c50afd95 upstream.

A pNFS server may return LAYOUTUNAVAILABLE error on LAYOUTGET for files
which don't have any layout. In this situation pnfs_update_layout
currently returns NULL. As this NULL is converted into ENOMEM, IO
requests fails instead of falling back to MDS.

Do not return ENOMEM on LAYOUTUNAVAILABLE and let client retry through
MDS.

Fixes 8d40b0f14846f. I will suggest to backport this fix to affected
stable branches.

Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
[trondmy: Use IS_ERR_OR_NULL()]
Fixes: 8d40b0f14846 ("NFS filelayout:call GETDEVICEINFO after...")
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/filelayout/filelayout.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -895,9 +895,7 @@ fl_pnfs_update_layout(struct inode *ino,
 
 	lseg = pnfs_update_layout(ino, ctx, pos, count, iomode, strict_iomode,
 				  gfp_flags);
-	if (!lseg)
-		lseg = ERR_PTR(-ENOMEM);
-	if (IS_ERR(lseg))
+	if (IS_ERR_OR_NULL(lseg))
 		goto out;
 
 	lo = NFS_I(ino)->layout;
