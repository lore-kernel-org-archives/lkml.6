Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225ucsOHKy8tCs/0A5PtTzkP0viOUVwHq2u+WSruHhMwiaTmOWdj98DhzdO6i3eMdIxcUmeL
ARC-Seal: i=1; a=rsa-sha256; t=1518708850; cv=none;
        d=google.com; s=arc-20160816;
        b=hCm7bSR7DvjZ4Ro5zvXk7njoF0rbx1Lw4FdsqytrtIbOxrQTV2eJ0ZbFPi59xCAWZJ
         pPuNyFJQrMjkCF3jPqlhbJi0I/y9hentSjkoIEkIaE43uNQ1ibCPcv10jRSt+rJGhYRJ
         nLgOHGXxAod1u0r3Ay8VOaoC1PHH3SAnrAFPkvAeYxTJk0MmEjxLueCeS7J1v/3DtYZF
         fgcXUwIyO9MxXUy7CSDji77qEIAzZLEccGwaI2+YWnms/Y2W5s1vvdTIKMJQwuLmvPyi
         ebYe67thkAQoOaxXBh2Lpjgtx+1BAsKoy6Ot9acBdUF/qmIWngjoKv++zUYhNhkBOGt0
         PoJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=e5E27cT65QOE2lF49OYEGEtlrri2Px8pK26XG4rpRYs=;
        b=O+tUbe7Q4SSd+hJ2zWwOdXCbsrqcgOJZp6zzoyg4i+cSWN/yE8RhWs/yerTNspQfGP
         ux29cUBazBF75z9FaZqR5+O/v9783v8hTmRycaLvvtend7rSwoPE+CSXeRM/o3YrMIF+
         MxMzhWZVmyYejGqtRrq/10dKTWI9Onyac+0wOR/khWUCsbLE5ZXnR6Zx66XIpa0teUSh
         /w6Vd6wFUUrbbbXz1nAluU0qCmzd0tc/LRJsHi0CraII/WDjRgpSP/uu6xazqa9HWkJR
         qj0kaVLpusY1csvabZKPs19GW4Pkvju+Z9C3LMkEmpPs02khEGPLHDDfAX71mAjVstAD
         jp7Q==
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
Subject: [PATCH 4.14 104/195] nfs41: do not return ENOMEM on LAYOUTUNAVAILABLE
Date: Thu, 15 Feb 2018 16:16:35 +0100
Message-Id: <20180215151710.892803902@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481651451341949?=
X-GMAIL-MSGID: =?utf-8?q?1592481651451341949?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
