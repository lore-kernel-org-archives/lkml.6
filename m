Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49kRvczxIw13JKjsxpCMPec6rzOz8NT3fpVDh9dpHVuDbMbxA2XbBUr9F2kRq9zrSty9tnp
ARC-Seal: i=1; a=rsa-sha256; t=1522168820; cv=none;
        d=google.com; s=arc-20160816;
        b=NSyuWTsKSCr1tYr688szKtvpyFL+14p67M1HCC1HI4i8Lr0/mSmKpq8lUxdCNshnVD
         UMF/IuEALhbtNUpYlnTCG/Jspr/OoqGQpW9fUo2oIk8SQFnPsknUtSjGZiGs0qNgMs/W
         voqbfB2ONFWkpm9Jfr5QJ7SvEzwkn+mCwVc+pYUthG5zacxrOXBnWSYX+gm4OWtnlUic
         08q+kbkCBgp9ugCXy7XeuXCUzzQofkresllNbzaCb1N9ftfq8ZVhDC0OvbsiM0WJFxUS
         20Bnwki8+fHXLuB/kZjCn+TvNIEktOSL5lQdJkSlHy3RISrZl7/nLCCq5eNqCXgXfNdZ
         k3rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xuwFfDzxbg8QO+nTnZd4D7c1AGqKk19/WM5EWSFl0rY=;
        b=TwEkwnO34tN7+niDSuQNgUqPrcMOUwrDtD9ZyBk89CBxo3BBM+5weUtCijFEr/f/6B
         1jSuBT/ZHP1GiOkibad6rOMrFq0bjWRuzPRfDI4jd8fyl4ugd4YQJD18Del4z9LBrwIP
         Saz8FrDUKSqhz27EVruZTIYwWl10fG+i8eNBTztoZ6qYmFJKlDZXrxGrXUTYADfEBkt7
         iUuAlDIbzLr+ztGEgWw/oQzpTUiX+h6L/l64WjQpQvWFTtQAQzcRu+jcl+0T0egvSXll
         4rcbBU1D+9Sn6hejv0ytV4lo59j7FBOQ5daYfgY3keFnPzr6QtYGDb5Q5uQ2Qp12tRVi
         u9pA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.15 044/105] cgroup: fix rule checking for threaded mode switching
Date: Tue, 27 Mar 2018 18:27:24 +0200
Message-Id: <20180327162759.956869678@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109390159171631?=
X-GMAIL-MSGID: =?utf-8?q?1596109692685918447?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tejun Heo <tj@kernel.org>

commit d1897c9538edafd4ae6bbd03cc075962ddde2c21 upstream.

A domain cgroup isn't allowed to be turned threaded if its subtree is
populated or domain controllers are enabled.  cgroup_enable_threaded()
depended on cgroup_can_be_thread_root() test to enforce this rule.  A
parent which has populated domain descendants or have domain
controllers enabled can't become a thread root, so the above rules are
enforced automatically.

However, for the root cgroup which can host mixed domain and threaded
children, cgroup_can_be_thread_root() doesn't check any of those
conditions and thus first level cgroups ends up escaping those rules.

This patch fixes the bug by adding explicit checks for those rules in
cgroup_enable_threaded().

Reported-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: 8cfd8147df67 ("cgroup: implement cgroup v2 thread support")
Cc: stable@vger.kernel.org # v4.14+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/cgroup/cgroup.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3183,6 +3183,16 @@ static int cgroup_enable_threaded(struct
 	if (cgroup_is_threaded(cgrp))
 		return 0;
 
+	/*
+	 * If @cgroup is populated or has domain controllers enabled, it
+	 * can't be switched.  While the below cgroup_can_be_thread_root()
+	 * test can catch the same conditions, that's only when @parent is
+	 * not mixable, so let's check it explicitly.
+	 */
+	if (cgroup_is_populated(cgrp) ||
+	    cgrp->subtree_control & ~cgrp_dfl_threaded_ss_mask)
+		return -EOPNOTSUPP;
+
 	/* we're joining the parent's domain, ensure its validity */
 	if (!cgroup_is_valid_domain(dom_cgrp) ||
 	    !cgroup_can_be_thread_root(dom_cgrp))
