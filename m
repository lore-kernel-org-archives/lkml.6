Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELudLjJjr45JoMgOAROq+HZwMsUw4rm14XkQ7rBrWU9gq/omeScPSnFkfpzSD2YAlPWBT/eY
ARC-Seal: i=1; a=rsa-sha256; t=1521214334; cv=none;
        d=google.com; s=arc-20160816;
        b=hwhwDDzZzo+TkaunB1xT3VIXVgGt4IxzfSwwKr4QPU5nHHD1kiwg+Jt0EB40n3hYpR
         jnFdlhUrdE1+e+y+VhtB6ZeqxVaGXBmbegQvfVTTZ6CDfEQjQYybwYHQ8vm1S9OzzWuw
         GYbzMmqG1oWhitl6lwbYRG5tyz8gEjpRcSHybefUkZ6VWqpMB1jEwAuoeD7+TCUPdUlH
         XGipzodkMUIT2G1C59+1HKOUbVK11+9620QelutXlAZ9L9caf0DaBgbWEz2SQyrBVkKZ
         tBYHYoSNb/8m/6OUqvr4pOirQA853EyQC+0K/vcAuBei9Z+gg37ANeT3WXp+1G6hfgsT
         0Wtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9bQ4q5mHygtxe85xGfI+RCPDd9pbzKO4JZQbzvUyD5Y=;
        b=lr5bMC/RVJY0AApgp7Vz7Z5ereQG4n953EYB9/yIKK7fph6jcwVfIyTpe97HMAbH6V
         +hYfFNfqgpLnSiLJX+CsoBb7fLfDpp+Yj56kJEd7mF72oIYAEuPaVbtjwvPgvMGhVrp+
         ZcFDDHNVoeU0q1WVqXrWMRYFL3V85oTK6bNfK36r7MyEFU2+kDsYI9lKa51UNPT8PzVJ
         kCmfFr3FixillDggUy2eYDzeK1gZZ7HAtkQ8fpaYgBzlacTWAGHApaUAA00P6m+uD3Lj
         jkNEb9dyMaE9UgBu0LWvWGDAK1pthxd1rkQq+waxww1LqO0i1TPc2Bzua0zbDOgHxYMy
         redg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+845a53d13171abf8bf29@syzkaller.appspotmail.com,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.9 58/86] netfilter: ebtables: CONFIG_COMPAT: dont trust userland offsets
Date: Fri, 16 Mar 2018 16:23:21 +0100
Message-Id: <20180316152321.326160653@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108472340745037?=
X-GMAIL-MSGID: =?utf-8?q?1595108842315834973?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit b71812168571fa55e44cdd0254471331b9c4c4c6 upstream.

We need to make sure the offsets are not out of range of the
total size.
Also check that they are in ascending order.

The WARN_ON triggered by syzkaller (it sets panic_on_warn) is
changed to also bail out, no point in continuing parsing.

Briefly tested with simple ruleset of
-A INPUT --limit 1/s' --log
plus jump to custom chains using 32bit ebtables binary.

Reported-by: <syzbot+845a53d13171abf8bf29@syzkaller.appspotmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bridge/netfilter/ebtables.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -2031,7 +2031,9 @@ static int ebt_size_mwt(struct compat_eb
 		if (match_kern)
 			match_kern->match_size = ret;
 
-		WARN_ON(type == EBT_COMPAT_TARGET && size_left);
+		if (WARN_ON(type == EBT_COMPAT_TARGET && size_left))
+			return -EINVAL;
+
 		match32 = (struct compat_ebt_entry_mwt *) buf;
 	}
 
@@ -2087,6 +2089,15 @@ static int size_entry_mwt(struct ebt_ent
 	 *
 	 * offsets are relative to beginning of struct ebt_entry (i.e., 0).
 	 */
+	for (i = 0; i < 4 ; ++i) {
+		if (offsets[i] >= *total)
+			return -EINVAL;
+		if (i == 0)
+			continue;
+		if (offsets[i-1] > offsets[i])
+			return -EINVAL;
+	}
+
 	for (i = 0, j = 1 ; j < 4 ; j++, i++) {
 		struct compat_ebt_entry_mwt *match32;
 		unsigned int size;
