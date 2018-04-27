Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoGgkZNtozw5RG9IJHy7lJFbI4GhsVltLjbrm6vaPPLoDa3TkiOas+OxvDM82nkRW1ZMbie
ARC-Seal: i=1; a=rsa-sha256; t=1524838321; cv=none;
        d=google.com; s=arc-20160816;
        b=kkmxWkMigOeMa6WTB9wZVi1dHL0F4pmOIDG+GhqVkWeCrLyUr4rtZodVAxvkp+1FX4
         1pIDhQ2GR0bdiyAXI1wk9U67N6CF+jGy57lQsiJaOV/rYpX8wP+h6GeIFnQUppg9SiMP
         kLIxkIIYrXxIyTw7YObR6AhoRW9XK1SEpTLvWUC/VDIwR4RB1R+QVtnYR0zWNGqLbe4k
         FMB9yJUVLQ3QT43nhL8o5wMwAXFrA8LqtZ4/r4oBitrup8SBsjl7wd4NhdMEdS/BQYw4
         ftRuFAkGk6uJNDHZLFGwJWuQcTDxINQSA3/KF3iA8LfA01xXuEi+Bmwx91Ha3cHGpix1
         jWZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=zjHRU3U62LIvrWGVV8ihEUcuxBZt+GY5SII+aYKzDzE=;
        b=dLf0oyYqorwb5681PxqGXMvvUGGEDzWKhUJNbjgmMbn0pVL4AQ12vGe62GyMwpZ7Wv
         QnPhIpK56KUkaHqgP3baAVjVgrgdvbqYb9XvBxxaPrzj2TVizRbHPDJ7ZZhK5iHWM/SV
         HJx+1YvDQi+BDrKIEQCj0BqAHZMBmAavzrvSuQq98Fj056yEDl/elwWDTY8xlRm3vMie
         M/QbYGELHdToQgdGPNT03Hh9lToOjZITgDDzMjLV30Fy744Cj9cbLbbluL/TyeOJ4ZUg
         M98SEKi+VJGwL2L/+etj3p8qCHD3elXgTZ/foNoGjWPwLD3lNxATr5e5jGdpmkQI5wzS
         61xg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA77D21892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzbot <syzbot+9369930ca44f29e60e2d@syzkaller.appspotmail.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Morris <james.morris@microsoft.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 4.16 61/81] commoncap: Handle memory allocation failure.
Date: Fri, 27 Apr 2018 15:59:03 +0200
Message-Id: <20180427135746.913943828@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908648105259176?=
X-GMAIL-MSGID: =?utf-8?q?1598908867688754751?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit 1f5781725dcbb026438e77091c91a94f678c3522 upstream.

syzbot is reporting NULL pointer dereference at xattr_getsecurity() [1],
for cap_inode_getsecurity() is returning sizeof(struct vfs_cap_data) when
memory allocation failed. Return -ENOMEM if memory allocation failed.

[1] https://syzkaller.appspot.com/bug?id=a55ba438506fe68649a5f50d2d82d56b365e0107

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: 8db6c34f1dbc8e06 ("Introduce v3 namespaced file capabilities")
Reported-by: syzbot <syzbot+9369930ca44f29e60e2d@syzkaller.appspotmail.com>
Cc: stable <stable@vger.kernel.org> # 4.14+
Acked-by: Serge E. Hallyn <serge@hallyn.com>
Acked-by: James Morris <james.morris@microsoft.com>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/commoncap.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -449,6 +449,8 @@ int cap_inode_getsecurity(struct inode *
 				magic |= VFS_CAP_FLAGS_EFFECTIVE;
 			memcpy(&cap->data, &nscap->data, sizeof(__le32) * 2 * VFS_CAP_U32);
 			cap->magic_etc = cpu_to_le32(magic);
+		} else {
+			size = -ENOMEM;
 		}
 	}
 	kfree(tmpbuf);
