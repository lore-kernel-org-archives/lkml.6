Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/9cQfDv+JWbWI6lpUXUpRGQ5EJFeHrjG0FXUNuenCxFSErlI/UVx2fIp7XVWWRA9LIsguN
ARC-Seal: i=1; a=rsa-sha256; t=1524406213; cv=none;
        d=google.com; s=arc-20160816;
        b=IBGt0AbQw0dyQS5B8oVT+1Yd6L5PhXCPrnLzQcTwvXUQ8QpX3uoVUVEfuP8WFlzzu4
         yS5bVCW8ftqwyk0qAEBRYWTqrYWWYiviW038l5tMSjy2JXHc1ECMoNo7cxuWqisgyYHN
         26O+bMCUo5iVaMFxxOmez7KhiUAfaeJqg8Mn6gRiob5iSZyCr5tbCeEjJrtB4/nIQLK4
         Xpomf7MMwh0dOsOyFdmCzMSZ9VFKKFZuQs1j/VsU2kmHMtwu6dLz/ysOypwLMnbU2bTR
         KOnm6mRTo8ah0UqFBY23S/4pc9HRqpzKdqSP/O+mwqv9Xja4qi7hMmeYJHoFB/RfxGxi
         e7Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZjpZuEEPUxdGmRiT1CJ2l4PAmqnm8b/8Xzw+aD2Ee3k=;
        b=cYRkT/pTqmInIljnPwdIhDINVcvu3E5UiUXj7onlohXLbG666RoIGfgVyknRpiZkp1
         LSnnP49IgYwCBQX0EfBWzMQ1/qrNcgDTot6VUtl1tLQU/dcH0H3IDTg16oJfsF+U/8Pk
         VJEI9d7ZfzBdxgINRqPSCctjSZqFedaskkFxa/vglBDSOEIWV8+GCw9mAnexfqNlRIaO
         fDMDhar/cbNiRQNuVS+gwJCe7DCmoMXi15NpsiO41XC/JW5/Kdn5vRH0M1dXj+pUDoSf
         maIgcT/ZMRJe8JgAHQO0Wmjw6RwSijqQ0zHa9tL+LOuekDplBM7PmXcnfDzMzr1qmi9g
         suxA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	stable@kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.14 154/164] orangefs_kill_sb(): deal with allocation failures
Date: Sun, 22 Apr 2018 15:53:41 +0200
Message-Id: <20180422135141.877421597@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455304867595864?=
X-GMAIL-MSGID: =?utf-8?q?1598455769697375191?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit 659038428cb43a66e3eff71e2c845c9de3611a98 upstream.

orangefs_fill_sb() might've failed to allocate ORANGEFS_SB(s); don't
oops in that case.

Cc: stable@kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/orangefs/super.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -594,6 +594,11 @@ void orangefs_kill_sb(struct super_block
 	/* provided sb cleanup */
 	kill_anon_super(sb);
 
+	if (!ORANGEFS_SB(sb)) {
+		mutex_lock(&orangefs_request_mutex);
+		mutex_unlock(&orangefs_request_mutex);
+		return;
+	}
 	/*
 	 * issue the unmount to userspace to tell it to remove the
 	 * dynamic mount info it has for this superblock
