Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AIpwx49TL8nkYmsV2CEcQrnC2bebTRmENGbnbNFaPyCnCdp26WbIhv3zBgQpWwiMF5LGGpvm0BPe
ARC-Seal: i=1; a=rsa-sha256; t=1522297678; cv=none;
        d=google.com; s=arc-20160816;
        b=xQWwdlTGODselbM61Mgecsh9H9HAdQMY0jLxi8iVCVnddwRa5LtrWD4wUpP83j8Iih
         i7FsRbT7DZHmIAymkhfYgooc7dVrnbZjkXirjkM+iYmGvX/sRaQU6w1E37UrXAc1Fj9N
         oBF/4+2w0/GlIKvf6CAdNIw2f/K3IWCbbQ+8xqtAnb38TI/eUx+t8Ji5v6EpqhJyVzTl
         SbIPyxu93pnM+PKqAGwDqJ/WHPton/NXnHBa3JwfMRaMyZyqAJh6ouv80tzLlv5Z6VVs
         a7bJhHWN2kVesILQxOdw4+93IKK6C9VWv2fYtSCIDjennaS7jSPcUmo47NJRgIE7SJjO
         dwWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=GQwHaswxJkU/NYqDnGu5IQadXf9QjrXc/PVoXUiDJ8I=;
        b=y9PAxVhUUmoXZtKi1/wdwNjNRZopjScaUkC+NIwoVUh8bSUlbsTSLpwFSMRT3Wi8Nc
         k0CE9onGzuu4ZE3J3OIow4DO5rZnM+mivFzuK3am+k5wV+Q8rlnnwDb5wf3YJRO0UoFd
         BCOJnV8k8gAZOd8vYQ+BQ0UIKiNY+m//xKRpfhvUXY9FlxSDGWgvR2cQdOPhEjg69Jg3
         whlIFFcZ76LuuX3lGwRACpv+XyUs5RhW2ctZqx8Rxw5JLESOTEVUm2lWDK5YwO+6HrT0
         U+SUfGgEeCVaykcb+caDiG2cG9UinWwhkAVBRQeYzG1kkhTlBJMPPFhIX5JrcrrdnnE4
         M00w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Thu, 29 Mar 2018 15:26:48 +1100
Subject: [PATCH 07/17] staging: lustre: ldlm: free resource when
 ldlm_lock_create() fails.
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152229760844.27689.4330202028940942080.stgit@noble>
In-Reply-To: <152229732768.27689.4800156943561963977.stgit@noble>
References: <152229732768.27689.4800156943561963977.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596244811383185492?=
X-GMAIL-MSGID: =?utf-8?q?1596244811383185492?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

ldlm_lock_create() gets a resource, but don't put it on
all failure paths. It should.

Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lustre/ldlm/ldlm_lock.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/lustre/lustre/ldlm/ldlm_lock.c b/drivers/staging/lustre/lustre/ldlm/ldlm_lock.c
index b8fd778d9832..614caa4a9b0e 100644
--- a/drivers/staging/lustre/lustre/ldlm/ldlm_lock.c
+++ b/drivers/staging/lustre/lustre/ldlm/ldlm_lock.c
@@ -1551,8 +1551,10 @@ struct ldlm_lock *ldlm_lock_create(struct ldlm_namespace *ns,
 		return ERR_CAST(res);
 
 	lock = ldlm_lock_new(res);
-	if (!lock)
+	if (!lock) {
+		ldlm_resource_putref(res);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	lock->l_req_mode = mode;
 	lock->l_ast_data = data;
@@ -1595,6 +1597,8 @@ struct ldlm_lock *ldlm_lock_create(struct ldlm_namespace *ns,
 	return ERR_PTR(rc);
 }
 
+
+
 /**
  * Enqueue (request) a lock.
  * On the client this is called from ldlm_cli_enqueue_fini
