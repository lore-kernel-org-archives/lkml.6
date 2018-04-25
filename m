Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AB8JxZpIhf3Cv/fHrAhX9CdWlTW1xs28Snme7j1f7F23OI06/N8XdmDOvKMI8RFhldXswErCSIVu
ARC-Seal: i=1; a=rsa-sha256; t=1524652733; cv=none;
        d=google.com; s=arc-20160816;
        b=MZo91XXZja10fzP2aGFDw789VMd+9vzUz6jN6DBTJamFOPqp/AJxkhlAlhePraVFj8
         CMh/Kd0yqdlbJdus4g8I+jmwWf56snhjMGV4okaZ7aBiEIMYN6fHJISJtPgP8DG8Ysga
         /Sc0Dzs2q4egvAJYqL64nSWXFGtxqmJg+3GIJdMIgtBIwWFvvp7jitS3lFxGkHjMYQMx
         noimQzoyrT0cQCcL2NVFhb+yGxA8xMge6qN5x7cgeT+ec22NKS54BY+tHUuTK8CpM38s
         HShliKtyBC+HUOU2YfveGaJ31nLsXEDGhi1Zcun0LKhPPrFt43kkb2ddyi1WSqRvHz60
         SFcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aBgoYylHLffuEKY85Qq3WJgeeJgDsLn6+nWrDNxcx4M=;
        b=RBJtKpl5ZffpaGo48bp7sEPWOC1YV2gU4QSo+HiwmltjRTDlZ7NPg2+ukDjTFwAnH0
         +/o5+W4PUBTr3iaBGEM39cVFbaBy5QKTO7mLfz0yI9YplQ7KNbu96XPmcT/CNCyV1w7o
         NCT6D/TK+7+RPthyhCPH3yVwgBxbBXd72w60HTKJSFV94hPHMv7pyvnglNOv6vOVWPu7
         6kBeTabJsLS8zKCruKmDRHc9uD1ONP7dxPQ+X5x+/YYym4ifvq/5LnhoY8iZXRTRTT9c
         DbLK8MASP0S4vBVG52syXEA95IqXO8f7YKs1FezW/fDXvHY2Qi14v5TmjjnKxLP0jnmR
         gefg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 049/183] ubifs: Fix uninitialized variable in search_dh_cookie()
Date: Wed, 25 Apr 2018 12:34:29 +0200
Message-Id: <20180425103244.527151465@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714265069543698?=
X-GMAIL-MSGID: =?utf-8?q?1598714265069543698?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert@linux-m68k.org>


[ Upstream commit c877154d307f4a91e0b5b85b75535713dab945ae ]

fs/ubifs/tnc.c: In function ‘search_dh_cookie’:
fs/ubifs/tnc.c:1893: warning: ‘err’ is used uninitialized in this function

Indeed, err is always used uninitialized.

According to an original review comment from Hyunchul, acknowledged by
Richard, err should be initialized to -ENOENT to avoid the first call to
tnc_next().  But we can achieve the same by reordering the code.

Fixes: 781f675e2d7e ("ubifs: Fix unlink code wrt. double hash lookups")
Reported-by: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ubifs/tnc.c |   21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

--- a/fs/ubifs/tnc.c
+++ b/fs/ubifs/tnc.c
@@ -1890,35 +1890,28 @@ static int search_dh_cookie(struct ubifs
 	union ubifs_key *dkey;
 
 	for (;;) {
-		if (!err) {
-			err = tnc_next(c, &znode, n);
-			if (err)
-				goto out;
-		}
-
 		zbr = &znode->zbranch[*n];
 		dkey = &zbr->key;
 
 		if (key_inum(c, dkey) != key_inum(c, key) ||
 		    key_type(c, dkey) != key_type(c, key)) {
-			err = -ENOENT;
-			goto out;
+			return -ENOENT;
 		}
 
 		err = tnc_read_hashed_node(c, zbr, dent);
 		if (err)
-			goto out;
+			return err;
 
 		if (key_hash(c, key) == key_hash(c, dkey) &&
 		    le32_to_cpu(dent->cookie) == cookie) {
 			*zn = znode;
-			goto out;
+			return 0;
 		}
-	}
 
-out:
-
-	return err;
+		err = tnc_next(c, &znode, n);
+		if (err)
+			return err;
+	}
 }
 
 static int do_lookup_dh(struct ubifs_info *c, const union ubifs_key *key,
