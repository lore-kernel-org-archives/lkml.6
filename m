Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo1ugWBhYn82mTqnxrNCYWW8BkxEfRirPmxZY2XO9jXcI293kiDpHB17Z7bwLnArIRvDciQ
ARC-Seal: i=1; a=rsa-sha256; t=1526937945; cv=none;
        d=google.com; s=arc-20160816;
        b=oegcEiUZjHkWjdyEgujtKNLOztdrKC9MiM82TNeHgW2zcSQ93Ll6WIKXJdDnEY4bde
         OxMgwSSM00NZXPyCLLMdOVY3fY85jSFeimHapugol3lIlq3/ntaPY68s3twjgBh7u8g+
         VnCs+0ok9jiUAKfyN5RQzv1cqccpiytmODxiji2BkiKtKnTGQo/GUqHikoTlGd1ks4tn
         Q1rSbIzlFt1wwe8MUzdDCCP7Fov3azTPFLJRDyKh5gAgxtw9rOVddHhJkdTosxt5KMt4
         gkTz6lxbRPNHzk6U/nmxq6+f0z6uz7KtoFAGyfkqrhMAAVXbGzJFa4c2yC4SiJ4twrHX
         GXnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=g+YtajbKzoIwyXVZE2W7/0tNaktCTsuXv6GrBjAVYeU=;
        b=E5n5D6IaqBv8KPD0jX+QgaKN6p8fCqrmBqN3UIvDuKa3BQmj50Bo40OC1q5ovkleq2
         Sz1UtnM0z/vteAuuasWWMSHnNUCdrKLWixR/dBQKHmoroWqsHueuK67og0a9cLJmabz4
         gcFBZqSYeWcVnlatKTJ20Mw9AtH2fXCQam+6jQQUMgYVEoQIOvUBA8wKqSFDQ/A10pXH
         AUusxP/cgWt/qB5WmalkvcaOZkTSh/3qFqoaNkf6yqFvnsMyRSNX01fsEF6vuYa5m4HC
         kQF0xKw0Q/qfntyq9rMHJXWAMIPmTOyzvimtcTLtrzms081bWt0qwPJopVoL2ia8OMAS
         sZgg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=W0+GOpMC;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=W0+GOpMC;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.16 083/110] seccomp: Use PR_SPEC_FORCE_DISABLE
Date: Mon, 21 May 2018 23:12:20 +0200
Message-Id: <20180521210513.573183959@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109984171479301?=
X-GMAIL-MSGID: =?utf-8?q?1601110483656965560?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit b849a812f7eb92e96d1c8239b06581b2cfd8b275 upstream

Use PR_SPEC_FORCE_DISABLE in seccomp() because seccomp does not allow to
widen restrictions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/seccomp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -239,7 +239,7 @@ static inline void spec_mitigate(struct
 	int state = arch_prctl_spec_ctrl_get(task, which);
 
 	if (state > 0 && (state & PR_SPEC_PRCTL))
-		arch_prctl_spec_ctrl_set(task, which, PR_SPEC_DISABLE);
+		arch_prctl_spec_ctrl_set(task, which, PR_SPEC_FORCE_DISABLE);
 }
 
 static inline void seccomp_assign_mode(struct task_struct *task,
