Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224o7DDkwN6/Gj5whzWUnvLZ6ORa8VjO+YyDCqjFgtxKp8pLSDyJzN4s0llLZG8KpxrInvZq
ARC-Seal: i=1; a=rsa-sha256; t=1519218680; cv=none;
        d=google.com; s=arc-20160816;
        b=QeUG7BT+JB23ifwrRlIwWL0ouVkz5LCMPdTQDpCekvLUjgzG3zzxU8vI3QAHtehwNZ
         SJVWclr+fpFSfOVey8pi7oteLD2obbxdHQ8GoqpRiDKQEyEO0nE2vH10+qJmrITrBq0B
         n+BlyQ3tXWvc7HMsR4aJwAUBVzPbxAXc+rGxA6YeM3bv6IrS15V57E4TFQOoV5O3ognf
         lTJGXpz/B3dfy/0K3AaUrNFe/QV57N3cEY1gyXjV14rPP3xdjrmT7M5YcbnpQYnQBoWz
         Ft+e9Y/VTTd1vaUQH1qN7x6uHNdQEFSAYZqZAMwROimfFSxwdK3FPb5Aoke9tey/Au1p
         EKVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KymspB6CWKflwrGr9q1k0fcFoPV4maxk1JUY0i5+c4U=;
        b=PhK09HJqJtUBo5UQHubP1CucYY7xBvvlU+TV3Y3b7+Q33Sas2FIxmf15CatgAz43oP
         erlcW/41S/nQyDismclQiPGsM66OGhTLP/7xdh9sqdGwXgPZrW0RvWN8/iYkcozk3IZn
         i6epMHP54wPJ37xxdvI2I8O+NyPtPTsjlSqzlcknj461agfcNBo/mG1qZwzcCLLvIeTJ
         x1i5HL6cPBW+C48/fO+KNmZfaTlf2du1pGua6GKM2491fCFtAHk3uvvKqTtV9XiLAU6c
         bJtOidpBUl4MPgTCh+iaEs2IcuzPvFbz0igiZTBcIxbGLxYdPuF/v5/o2cmHzbLM9CoX
         C/CQ==
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
Subject: [PATCH 4.15 124/163] seq_file: fix incomplete reset on read from zero offset
Date: Wed, 21 Feb 2018 13:49:13 +0100
Message-Id: <20180221124537.001351159@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015737726433241?=
X-GMAIL-MSGID: =?utf-8?q?1593016246656267599?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
