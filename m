Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu3JHq8GvYISayKNCZaWAT5mXaSRK4M/X46D1UK//+/ntXykEr77RFmDWq63RtNFjYcv5IP
ARC-Seal: i=1; a=rsa-sha256; t=1519412276; cv=none;
        d=google.com; s=arc-20160816;
        b=aHxj1uXizmUckKsG/ZKM331ljd21FnMfE65p6pg/O7lamXT2SI8UZWl20PTdPUWiQN
         x1NGSdXBRTSBFwyJwrGatkjp0Cl65E3dg109wHVkd+XpXU9rk0moc28QJjPJ3C1qKxWs
         OwGv29Aq/4Cpfxioe2NTTAder6eQ9a7Xf2/UVi9zHguzVsb0doby/dZYRJIswI3nwrBo
         AvBe97eZ0PjPwJ7jI7OMZ8E5x9RD24Qxw27QodZNWl+IxUw4mgBHObK0tfW5ByI+Yc8S
         QYQKpliBzKrnsCK/iKR6q7nIU2/eUSNjCoiE5G/L3ant9LGQNdED8+S5vB38lPjtHThO
         iosQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=elhcKPbeOxmSl7/QH3MFBIqtw8woLl9QpcS8Ac+f8+g=;
        b=h2haV+ITpBKlRyaDQii++MVMhGkTPwQpsHSRcz3Lwb6XHz0iFeJKOi0uXn07hXoWkm
         7ZIX5umdHo09B5Ag57RMVg8dvhKKuvT5UJ9v+ivV5THZPKpjAN+m8PFaT9ahe79dgwVi
         ea3Rp0MR/4CTPQXLpZEfxatq1zYZyzt/OylfT/AqysV5FUFchbNzYv14PuY1Yq7j2XgG
         Pm8AEO03Xk3Z4utrvLURqoJA7Xf4SayBDp9YlavQ8JHVyqpkboV7azSfAZkWf6iZTabh
         Ke9XSR5v4UbmPE9CTylcT7wVEHXaiI0/92Ou8hSMcaF3kHQtRWt/DLW0Bpn/hq0WtP+3
         +A0w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot <syzkaller@googlegroups.com>,
	Paul Moore <paul@paul-moore.com>,
	William Roberts <william.c.roberts@intel.com>
Subject: [PATCH 4.15 04/45] selinux: ensure the context is NUL terminated in security_context_to_sid_core()
Date: Fri, 23 Feb 2018 19:28:43 +0100
Message-Id: <20180223170715.973981040@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217554793974221?=
X-GMAIL-MSGID: =?utf-8?q?1593219247420292635?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Moore <paul@paul-moore.com>

commit ef28df55ac27e1e5cd122e19fa311d886d47a756 upstream.

The syzbot/syzkaller automated tests found a problem in
security_context_to_sid_core() during early boot (before we load the
SELinux policy) where we could potentially feed context strings without
NUL terminators into the strcmp() function.

We already guard against this during normal operation (after the SELinux
policy has been loaded) by making a copy of the context strings and
explicitly adding a NUL terminator to the end.  The patch extends this
protection to the early boot case (no loaded policy) by moving the context
copy earlier in security_context_to_sid_core().

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Reviewed-By: William Roberts <william.c.roberts@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/selinux/ss/services.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1413,27 +1413,25 @@ static int security_context_to_sid_core(
 	if (!scontext_len)
 		return -EINVAL;
 
+	/* Copy the string to allow changes and ensure a NUL terminator */
+	scontext2 = kmemdup_nul(scontext, scontext_len, gfp_flags);
+	if (!scontext2)
+		return -ENOMEM;
+
 	if (!ss_initialized) {
 		int i;
 
 		for (i = 1; i < SECINITSID_NUM; i++) {
-			if (!strcmp(initial_sid_to_string[i], scontext)) {
+			if (!strcmp(initial_sid_to_string[i], scontext2)) {
 				*sid = i;
-				return 0;
+				goto out;
 			}
 		}
 		*sid = SECINITSID_KERNEL;
-		return 0;
+		goto out;
 	}
 	*sid = SECSID_NULL;
 
-	/* Copy the string so that we can modify the copy as we parse it. */
-	scontext2 = kmalloc(scontext_len + 1, gfp_flags);
-	if (!scontext2)
-		return -ENOMEM;
-	memcpy(scontext2, scontext, scontext_len);
-	scontext2[scontext_len] = 0;
-
 	if (force) {
 		/* Save another copy for storing in uninterpreted form */
 		rc = -ENOMEM;
