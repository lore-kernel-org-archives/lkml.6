Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+/AMFdptlpNAsdY5mYjUuHZmQb4HvWqlzV5vNZoUMNQTgCSYBzKgy9QyvKg5W2DtjdpEOQ
ARC-Seal: i=1; a=rsa-sha256; t=1524405907; cv=none;
        d=google.com; s=arc-20160816;
        b=xx7QnHlMBITDrAkbcaNhuKmpC3hhtuhOKaYOAWjX9L2u5ZrzJFbydG5Mwm105g8KPi
         6KLJZiAdISizMTQx6+a+LmJxxXIbGBM6am0F6QXY/2TJ43V/zVkq2h3NyiSSN+ztP3NC
         Jv7UxajIrIGuJnDW1pgFhoSTN58ErHh97PluNLuInWkZKpSi9sppGm7ddEikS1ZltV+0
         OgcYP9cM8huZBYfLvI3r/ZWRu+t0KKYat+fry6aUhi3U+VIeOsM2LwJH5OCaYkHIQPac
         pfJ5+mcRNaU3z15lUC8EsUTozhgwvMv0vwVg5AZJ+toGo/cNHNY8A/wqSo+sx0i2MBQl
         k3nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1l5lx4cEaIJ9QIaqZs9oMqEJQBHCd/KPbEutIoDnDJE=;
        b=hzPwxFo5xynRKj99RMZO9Rea50Vcn4zaWwqlzrPdXc2ps6yxlwlHwqMxPcYHofS/AH
         TWDNPLn1xXU21jvnmLkHVYT6jgrv8OfQ5mLTMrQ79dUXoZVbbnCV7ert9b/2QmL+CrU7
         g7FLhTZOFRCBkmkn/FjvBUnI6984VF+QgA/W4fcWPm7m0XUe7pSeBKBcSG+IKrnPdrzD
         G7uxxVxW9L3myErqGoKmuJ7HTrErHRvoOo6gAqLTy9LqBpJV78A/I8izON2Qi5XsV47H
         blZ4voMgZIW507A5TKPXv9tttk4MZ3umWQDMiZ1AQSBnK+Ji1c7xrLuD4SAVjE2b+fQt
         OeGg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ronnie Sahlberg <lsahlber@redhat.com>,
	Steve French <smfrench@gmail.com>
Subject: [PATCH 4.14 042/164] cifs: fix memory leak in SMB2_open()
Date: Sun, 22 Apr 2018 15:51:49 +0200
Message-Id: <20180422135137.134591398@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454973486249608?=
X-GMAIL-MSGID: =?utf-8?q?1598455448634916331?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ronnie Sahlberg <lsahlber@redhat.com>

commit b7a73c84eb96dabd6bb8e9d7c56f796d83efee8e upstream.

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <smfrench@gmail.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2pdu.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -1773,8 +1773,10 @@ SMB2_open(const unsigned int xid, struct
 		rc = alloc_path_with_tree_prefix(&copy_path, &copy_size,
 						 &name_len,
 						 tcon->treeName, path);
-		if (rc)
+		if (rc) {
+			cifs_small_buf_release(req);
 			return rc;
+		}
 		req->NameLength = cpu_to_le16(name_len * 2);
 		uni_path_len = copy_size;
 		path = copy_path;
@@ -1785,8 +1787,10 @@ SMB2_open(const unsigned int xid, struct
 		if (uni_path_len % 8 != 0) {
 			copy_size = roundup(uni_path_len, 8);
 			copy_path = kzalloc(copy_size, GFP_KERNEL);
-			if (!copy_path)
+			if (!copy_path) {
+				cifs_small_buf_release(req);
 				return -ENOMEM;
+			}
 			memcpy((char *)copy_path, (const char *)path,
 			       uni_path_len);
 			uni_path_len = copy_size;
