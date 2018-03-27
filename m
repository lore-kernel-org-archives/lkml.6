Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+paBAnSAnoP23bpU2DHD6Ml0IP8JgZfBc8l/jbsujarWwk8oLPJCfkboKdBOXe0Kn81xfI
ARC-Seal: i=1; a=rsa-sha256; t=1522168531; cv=none;
        d=google.com; s=arc-20160816;
        b=R5BC/mH1gVheKw9jmg269pkYQ4sBrIeplbCsRCANwtYQInBnKA0FZZ8WGJ3tLtH+nN
         O/DXm5Llp8IW0EfrwLHrrWV/x8HVM0FAhJMpSM3TzQF22hgyUaY47Y0PxK3nwittSUfN
         JCxUTvj1UOOQ6ozehXSpG072ohAsi4OOpb3FvGYY4r3XQfnq+onrSFLmPQOab79YnSpm
         v9QQgQ3GFg4TL/mLEom1sVzLj0TTdZj5aIqN5sIVzIuFYGHoKDAbtJHhguG7d78i4WrI
         uqoaxZiY70ufPAPb7sPgNqqpEN27qBVKemGStqJBl4x7AuegmfyFFd6PuI79saVIy3J6
         nK2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bQqdmmekBAUXBqDKOKRFzs9Xqx+C0hhFZ+wt1JEsrig=;
        b=eijQcw/KEhBdKF8R8jDoUcJnGPPutcbYfDmBI+7RKjoKX3UBrARPM3vnUsa+1sautv
         /+tkdLhA2OAL5LEH3ToAr5VjRkSuIrypGzpHgZLl6DTvfDsmDrBRnFvOQHxCQFPn8jhL
         vSDC7faosQM1IklvsjQlD6ZqFDXvP2yLpGdxSvAe/QMQ32lHYcVbU8L8Rr1lVLdZHYy9
         qGkBr79Ppjt7N+zBcbrnbiT34Xx77skDCPQp0mFK3Hx/kpN+P27WQgXQijzokMb0v7P8
         EbR/IvY52hiUmK+6unm0RLqhF53bq+R5mYyOYTv22KTEpURuOfAXMi1Oyrim2OK8G/hy
         N30g==
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
Subject: [PATCH 4.14 043/101] cgroup: fix rule checking for threaded mode switching
Date: Tue, 27 Mar 2018 18:27:15 +0200
Message-Id: <20180327162752.666971002@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109390159171631?=
X-GMAIL-MSGID: =?utf-8?q?1596109390159171631?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3148,6 +3148,16 @@ static int cgroup_enable_threaded(struct
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
