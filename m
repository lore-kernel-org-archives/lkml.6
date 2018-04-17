Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+lmMQNrS3E9puFpRynuSv1ws8HXE6zu7c9mRC9tm78m7cm7rsMv4Yb1RRcQgAZrpq+3Iuc
ARC-Seal: i=1; a=rsa-sha256; t=1523980933; cv=none;
        d=google.com; s=arc-20160816;
        b=xt+Zo1iy3nuk/U+j/VdG5kCJosL6GoCguPuscc6gepvgfonwXJ9aRZGitEDECeG8MC
         sMRsi0OCuNgh2rMsp81cQYxfO+LO9ZTqa+6xW2+y5YVy5luj2NmY46HyYyLD08klEIuO
         fHeLxzFQVBLTNdhn6T9dUG8Cdw5AKUNTSx2SYcFHfcsB1pZJNDhQzCrPs6sEAtGlGzOW
         nDzp1SZhZ7tICP3Wlc0ZLqR7ru2o48OyRji4T0t9W4s/17k7Y4TfgQ/YIpv3Voa4MNWn
         BQ2pGx41oFSJBQ0A96bZdWa2SwGYghIpAw9WPGDqYE+i7UrD8M5fD+lm4wNcAMb1y25o
         4DVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MP6mw65up9mvZxH/pQNQyqn50/Xu3roxdO0px3YmZc8=;
        b=i3kfnsj90t4Rs3AoqUb8PTB0zZvis1RaaAk3gjifT8jB6ai9sQ/EgGcBXlCYflUPVO
         UYGbuU2Zi4alQYKzk3ln+GcUkKVKmK7TSIXGd+O+9HKv9NZTmaOgxdTLyIaOaTjdHeQk
         pixOaVH00UF3SYb6kfXpuoXqOHOmfZMjGehYMX1SaFvR/9jr1XtddrzT5vbCW8jfJ+q8
         VEhA4QeWP+Cvg7d0y3PeF0dzQdht4BAuQSR7FIRhYlhYi3NI3k1KBKaxs6D41ax7SNJ0
         /uVwzeM0WuLJevQdLlL0KhjeKFNlh7ogpI+TJjKd1fj0axo4JOfKH0I3o8mei16ajHzx
         1MXw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Serge Hallyn <serge@hallyn.com>,
	John Johansen <john.johansen@canonical.com>
Subject: [PATCH 4.16 55/68] apparmor: fix display of .ns_name for containers
Date: Tue, 17 Apr 2018 17:58:08 +0200
Message-Id: <20180417155751.583001796@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009831116787143?=
X-GMAIL-MSGID: =?utf-8?q?1598009831116787143?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Johansen <john.johansen@canonical.com>

commit 040d9e2bce0a5b321c402b79ee43a8e8d2fd3b06 upstream.

The .ns_name should not be virtualized by the current ns view. It
needs to report the ns base name as that is being used during startup
as part of determining apparmor policy namespace support.

BugLink: http://bugs.launchpad.net/bugs/1746463
Fixes: d9f02d9c237aa ("apparmor: fix display of ns name")
Cc: Stable <stable@vger.kernel.org>
Reported-by: Serge Hallyn <serge@hallyn.com>
Tested-by: Serge Hallyn <serge@hallyn.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/apparmor/apparmorfs.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -1189,9 +1189,7 @@ static int seq_ns_level_show(struct seq_
 static int seq_ns_name_show(struct seq_file *seq, void *v)
 {
 	struct aa_label *label = begin_current_label_crit_section();
-
-	seq_printf(seq, "%s\n", aa_ns_name(labels_ns(label),
-					   labels_ns(label), true));
+	seq_printf(seq, "%s\n", labels_ns(label)->base.name);
 	end_current_label_crit_section(label);
 
 	return 0;
