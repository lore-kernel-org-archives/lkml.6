Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/yhieLYVohlQDxk1SzZfPfyw+DKhsLi6idRjXagg7Hx6lV3pZZTsD2K1l0mNoH7ciQm031
ARC-Seal: i=1; a=rsa-sha256; t=1524405770; cv=none;
        d=google.com; s=arc-20160816;
        b=o95VpFfyWk7UbN4d5kHDm3QQ9dHqByRUj+VgJTGHTnUzKbMUQ/okkzFVYksA2FjIyz
         yTsG7MoGCgbCLnL9DBz1LMxXaT84gH38xBxhMFposp67q7BYqa8wxneczYHzesGHZZW2
         2zHgzP+hQ9phhIHAU0jgYK1vz9pQh2zb3KzsYo03MWmz1dl22qfYUSzEvSg/X0/pBheB
         C4AYXj47tlRkGj5M4oL1S7XQlVupyEOA4pnNAzpysICs9ZOEwofBGIgqB8i3ibymwdh7
         VztB0XGF3Tu8G0Gg3E6Y169qlIGLsnMyD4/j5XbvRO8EdzvdAQLn+VVvWaVO3jm2COu3
         gQWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=o/Yk9BARfwitab1PdLUFa9oqdKAI6E163OxlZku/p8c=;
        b=PsGot3aD03v+tm7XmYXGWg8TN2rIAEqfmyRKZGDftN7DEpV1T1T2Hp8uqV7470Fv4d
         HHV7Pxu0ss7dp4/fbZC55oM8b1g6q9qAHIyZRXhIsbBSP9FuAYFTpd60vZce7rIaly7L
         +1OTPSMyZOb7u5r8LfQlItIo0zPvOgd9hgCbApRyNRIgKvkK/wJzLT1nTXG6FczT5KSM
         Lef6uVGV8VKUYGd/G95/udC+9jMLvRZZYVtSoaU0ULFmIY3drjFvOv/5cCNX+YWTa9oX
         ZNBcIhDPfRc0AgTPVPM4mgxl05DoyTV9rn9aEhLx78bH59x4lTjmvmjPT0GVQTz8FGWy
         xl+w==
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
Subject: [PATCH 4.16 187/196] orangefs_kill_sb(): deal with allocation failures
Date: Sun, 22 Apr 2018 15:53:27 +0200
Message-Id: <20180422135113.929812421@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455304867595864?=
X-GMAIL-MSGID: =?utf-8?q?1598455304867595864?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -579,6 +579,11 @@ void orangefs_kill_sb(struct super_block
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
