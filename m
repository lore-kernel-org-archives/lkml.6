Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49HwWZZ+Jr7anJCbiyChALWITu09O3OBd7/2W1qOX4iNaqh0Rbeuxfwqy8T2Xd9a0Hj8+Ws
ARC-Seal: i=1; a=rsa-sha256; t=1524406004; cv=none;
        d=google.com; s=arc-20160816;
        b=E9wwbNdnmxyG5wC3v0LA5kQFsHlBUpOcAziwuWekqcFl5eDZsbVCYtb2F3GWOlCMtJ
         kY/BZWGvd497yrV7DlOoQmKaYHkXDJojeoi50z/8lzSwVudpJPYABGBtg2didhZzUJp8
         zd3OxhROGwhZAtqeELpdbIoC0vBXMLBfNs+veyyhCegMz9F+uuVHtfgM+GsOSpDe7Cx1
         okFMj0/DPGabH1/+SjGne2FkM4MyoWsWahrlzaxlf3ibT5IpSQrCyhy1V2IwVXetEDzv
         Db0GSyV627KwLKqVIRJcYPapvp3g8L/WRTT8rSz9HtaEm21gb+p3P790jp2wysKMtrTS
         cBrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=eNK/f0KJKi/df5oMhM8haXzDthu4noxCexSq1LS2A1Q=;
        b=r/vgi00zGghHyZqd38QLC8bmr3q39UYfvfU/8mSPyhztvNmK5CXlY7BTn0JjrXrqqU
         pukccA1urhBcBtBlTfwGP3StHypvnDZ7obe9xnCen4Wexjnk2e8Qj+u8EJxUVVXUyjmZ
         gPj+/FtJeUpZcA1z7vKa3cC370SLiUTPlevTDfGVRw0W13v82GS/wMNqJUad58M8ffxz
         yIL4Kba2jv/jnUJjVEzggq68XY0JuIHdy0O0/+x+MnVfJKl1jvrn6v7TVUK8Z/oYq3pn
         oLGXuLucL3ZFxpzUatc5lwbmDjFsPFBuYXJh6bq0/Y4K9KNtoiHn6IYx9xvcJzZbX/EK
         USoQ==
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
Subject: [PATCH 4.14 078/164] ext4: limit xattr size to INT_MAX
Date: Sun, 22 Apr 2018 15:52:25 +0200
Message-Id: <20180422135138.644419814@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455027376066510?=
X-GMAIL-MSGID: =?utf-8?q?1598455549767804875?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -194,10 +194,13 @@ ext4_xattr_check_entries(struct ext4_xat
 
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
