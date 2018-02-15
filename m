Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226AgEUJ7fvq4WPh/1LVN+5yxjKSkWpuV8ph+YTZICDKJ2B8cljmuC/fd/qZp200Yd7y+sn+
ARC-Seal: i=1; a=rsa-sha256; t=1518708869; cv=none;
        d=google.com; s=arc-20160816;
        b=UHVzllKruwtYJ3iL+axRP5iHUaJRThLw6dkAzdj4HRXrpPLHerrXs2MSDpqqIahPh3
         14b4IpPe44Tc1HDnsRcdgy/458hnbR/9Q/an//1+SlERBjDUFuidEpyv0FxXsqA1L3e8
         alLXllc6RQoCY+o5dyZcmO9h36EuzHU7IRmultwaWKDFn923UWC5igafTLCy84kQulCm
         qkHFTn9u4XI940tNz3JVikNL+q9aIyoS4O9kgIbZ4K765yTgjM4PzjPCyQ7ZjO2RacEs
         2JlVUnuT6jUY5/8Nj25FHVIKBWI/ETf7d/kkiZr7Kw1fI8UhcsO6L6w+b9EbKix3lKG0
         tPOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3BnCAWl2Vlgsk4rpu5FvicQ2lg6TXjtYFU4Ao04oGj4=;
        b=u/q3Nm5sLdWM/5JnGTs/OQ/LUEFhKCqOYSzVPJW94lQKMR6Y6iulq5VVrUYiWEZ9v9
         q/4yjndAOVHbK8w+/w8w9A8Z6ON5n8BU7vpai66TSWIQnuxFJNL9PkayTm7ex/MuCkBg
         Uks1S+E6eVl7kYO42OpvVKLo9AGAf1elIZQPdGrpLml0Cg9BDziJxBBpg9pOkRaTVJ6T
         +Ch7S8DULUcLho5vfusBQ1z6Sd4tHcH+Nb4JRAjiO1gw6pvmb3iR+d9OMV0v1nHmsn3V
         +JNGW4SG5Ed5iuq7R3WGbonEpYeyhhojCkk750mZZstcXG4+vcUia4fQOpFEhogqni2H
         0ERw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Ivan Vecera <ivecera@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.14 110/195] kernfs: fix regression in kernfs_fop_write caused by wrong type
Date: Thu, 15 Feb 2018 16:16:41 +0100
Message-Id: <20180215151711.205150931@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480732716912474?=
X-GMAIL-MSGID: =?utf-8?q?1592481671305295388?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Vecera <ivecera@redhat.com>

commit ba87977a49913129962af8ac35b0e13e0fa4382d upstream.

Commit b7ce40cff0b9 ("kernfs: cache atomic_write_len in
kernfs_open_file") changes type of local variable 'len' from ssize_t
to size_t. This change caused that the *ppos value is updated also
when the previous write callback failed.

Mentioned snippet:
...
len = ops->write(...); <- return value can be negative
...
if (len > 0)           <- true here in this case
        *ppos += len;
...

Fixes: b7ce40cff0b9 ("kernfs: cache atomic_write_len in kernfs_open_file")
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/kernfs/file.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -275,7 +275,7 @@ static ssize_t kernfs_fop_write(struct f
 {
 	struct kernfs_open_file *of = kernfs_of(file);
 	const struct kernfs_ops *ops;
-	size_t len;
+	ssize_t len;
 	char *buf;
 
 	if (of->atomic_write_len) {
