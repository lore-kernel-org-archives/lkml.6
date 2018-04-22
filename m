Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49dEz35C8WCmhGvimintdYWGJWHhC/pnpSGIr9dSZqe8xhdb7XlPxCJzpYKI3FcSS3CODNB
ARC-Seal: i=1; a=rsa-sha256; t=1524405505; cv=none;
        d=google.com; s=arc-20160816;
        b=h7bBmWOXsRgR5Hqqiroq3b7T2jbXgxshVYbrFSuqjX1VXlfoML+nzf2s2Rh3pvOjhK
         arcTZHslPw2UgBzB7ChpicsQAORXyFsc8W4Bv4EkP/5o8x0QIcbJCwbGu6J0ttPpitlP
         dF98hRFTqjwM3eXFyjoab5ZV6mYai0uTj/7e4MOuzk5ayX6hYTLmjL1IBsAtl6rG6GS4
         BJyMsoMlFk0CYeFqWOlSlrFXyASCL5Hom9HkwCuMRNglHyFTUDJTJ4KjiltrBExH4U46
         /uF4jeSExwQvZTFgjAngFrBXMZwXqWVbXSzj7EXCIsrxQ/rJBwZ+odGg/FzRn6tlMM1v
         ddzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WLn3kjtOvwRmPu6jGwKDhLD8Wl7vN1RHEKiOAGANfLY=;
        b=pOYAL7q5dkZGjOruWaOgkhnk+0MRIdkslD2W3XNJFVfmlsJ9PIxMxC/TCs3DjPxgxd
         yED6Rwf0Qqu1S2OmFczABauW7fICeqH75Fq624SHxng+6Z3nm3qbVK0YHj32U/8jPmb7
         GXq0RA98ViwdmcMg5v1MnZUfqFRW1WtdNuQ97XCAESlQPgd6OaZLvW+DXLcNFViU51iW
         whfu5ZXIhYvnWJ+u7G6jmSRTK3Y6lAu2j+Pz/aXaUSCEwLP4KQFcLWENCu804OVi9LlY
         +vJVc8jxD12VsL+I8649ocjiluoJ+x741sHFhz5v4KH2iJ+xk9uG5mhnBp+FjlhYhI8q
         axvA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Wen Xu <wen.xu@gatech.edu>,
	Eric Biggers <ebiggers@google.com>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.16 092/196] ext4: limit xattr size to INT_MAX
Date: Sun, 22 Apr 2018 15:51:52 +0200
Message-Id: <20180422135109.046443853@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455027376066510?=
X-GMAIL-MSGID: =?utf-8?q?1598455027376066510?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit ce3fd194fcc6fbdc00ce095a852f22df97baa401 upstream.

ext4 isn't validating the sizes of xattrs where the value of the xattr
is stored in an external inode.  This is problematic because
->e_value_size is a u32, but ext4_xattr_get() returns an int.  A very
large size is misinterpreted as an error code, which ext4_get_acl()
translates into a bogus ERR_PTR() for which IS_ERR() returns false,
causing a crash.

Fix this by validating that all xattrs are <= INT_MAX bytes.

This issue has been assigned CVE-2018-1095.

https://bugzilla.kernel.org/show_bug.cgi?id=199185
https://bugzilla.redhat.com/show_bug.cgi?id=1560793

Reported-by: Wen Xu <wen.xu@gatech.edu>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Fixes: e50e5129f384 ("ext4: xattr-in-inode support")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/xattr.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -195,10 +195,13 @@ ext4_xattr_check_entries(struct ext4_xat
 
 	/* Check the values */
 	while (!IS_LAST_ENTRY(entry)) {
-		if (entry->e_value_size != 0 &&
-		    entry->e_value_inum == 0) {
+		u32 size = le32_to_cpu(entry->e_value_size);
+
+		if (size > INT_MAX)
+			return -EFSCORRUPTED;
+
+		if (size != 0 && entry->e_value_inum == 0) {
 			u16 offs = le16_to_cpu(entry->e_value_offs);
-			u32 size = le32_to_cpu(entry->e_value_size);
 			void *value;
 
 			/*
