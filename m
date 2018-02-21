Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227SPAZijQARQVcynqkXA2XS6Hgq/wWURXie/GDNv5Tvd2Srg72oTM2V6pNgODxZraKS6p0m
ARC-Seal: i=1; a=rsa-sha256; t=1519218194; cv=none;
        d=google.com; s=arc-20160816;
        b=FiWf5EP6HsrO8IyE4srETiUQc6VE/UIxcZxbOx136AhuhK5MPSwWjDX4oAQks5GJNd
         2Zrr7H/Pslh5R1bUyTvAypqDJrEKtt9m0hFK7YRy+6t9AtJbHafDZhxd9ConFpf/c0QO
         XkdMw/4yMtJOjuHu3HEtdUHr+aSF3VNbtSQRWmuAIS3xnllaPopI99xATVsnQtudFD2J
         ucV0BgiU5xtkMMPbk/5sUtxgO5G2eAYJ7SWT0LKGuEcyz9Wwquxsj9hgfTM6ZxpGsoAR
         CuRqhz0NTnk9Rf8vEZ067JjrPKiTqDnr6JymhrUayfZrni3RjZ7U7DDVYMHhKCrtNdPn
         pMUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aHGILldO9BV7+dkvVa4+BPwNriruQYGDY7yo1BKmpAM=;
        b=Iac4Q1hmk0YeRHMGvEi6glChNFl6pkiw248zjCbBTduH18vC3pwuwYmxUFfU5YvRud
         L55miGYvJRRdu7dDm0e/JmsqyElNlwVvy4rKM2B6+ZyUDHzsJwYsE880MqM2RJcNZOup
         NJZtNL2IyBzJIfwxTJsLtjGTT4kQziR/mNWBHZ+9rWgEuodYyG1+Cb196VqOMC7ePrtu
         0HLMtawAPHHKJJ0jPRrmwyYWKF6b7ViAhfExL3gqRejLNYJfAZhffJ/bAPKF94a0lxvC
         JbPGMYf4AeQBTQPDzuojYLZR86KfTTg93y31IyRyafYKJ6z/OAeYXaDb3jROAa4dZycB
         +Kbg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Rich Felker <dalias@libc.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.14 121/167] seq_file: fix incomplete reset on read from zero offset
Date: Wed, 21 Feb 2018 13:48:52 +0100
Message-Id: <20180221124531.122460958@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015737726433241?=
X-GMAIL-MSGID: =?utf-8?q?1593015737726433241?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miklos Szeredi <mszeredi@redhat.com>

commit cf5eebae2cd28d37581507668605f4d23cd7218d upstream.

When resetting iterator on a zero offset we need to discard any data
already in the buffer (count), and private state of the iterator (version).

For example this bug results in first line being repeated in /proc/mounts
if doing a zero size read before a non-zero size read.

Reported-by: Rich Felker <dalias@libc.org>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Fixes: e522751d605d ("seq_file: reset iterator to first record for zero offset")
Cc: <stable@vger.kernel.org> # v4.10
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/seq_file.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -181,8 +181,11 @@ ssize_t seq_read(struct file *file, char
 	 * if request is to read from zero offset, reset iterator to first
 	 * record as it might have been already advanced by previous requests
 	 */
-	if (*ppos == 0)
+	if (*ppos == 0) {
 		m->index = 0;
+		m->version = 0;
+		m->count = 0;
+	}
 
 	/* Don't assume *ppos is where we left it */
 	if (unlikely(*ppos != m->read_pos)) {
