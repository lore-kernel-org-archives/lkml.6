Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AIpwx48FFfTLDiRpbW2SUjnZ2chz8Rh2QLbvtthlWKAhcuCoRr/G9xtklrcbx+TpuZ3mtTSnix5s
ARC-Seal: i=1; a=rsa-sha256; t=1523483846; cv=none;
        d=google.com; s=arc-20160816;
        b=t5TsSwHhzkIFJV/EN+j6XDWicnKe6TLtQDPenW1Z7xm0GpqEbmrr+ja+9V5Jr47lqd
         uWnjzmiqsgWJQIZAajlEF3JvQsprs8cDiKq5QdcGmPLJL/LASRSqyDEbeEkpANLgtO5u
         SJSj5kWeUz1leeQQOpIrI9fd0WpS75tJtjLxQ9/gi/Fl+Cv8BsX9vOi4GoHGem4zlmk9
         TfIJQcSScrdABBYWf8aeBqOfshO5VnC+cvjtuWzQcHtCWsEeBkpxowvg7sj93RhSwIbZ
         Dgh6lUQEqduPyotatHH+KuqIsyHLf2sZOcPEKRhaQQg9/Qp+ud2eCehItnFXGJ9J9I0p
         2dfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=9OySyEUnCnwqkzD1UKzw1UjKx0dRpYMs1dolz2RG4M4=;
        b=G0rhnHnoEVOuSpPbtZ67DGQ/dKG+Q63ss1lzHXiOFhx9ZBV8yfFR+6oJACcsyrQe4d
         7avRDC+tpTstcL1THLkToJruCujvtnQMcS9+jWQ4RaicHbWhBvE3tn8A/Diha2aPo2t3
         BLhBaqv4TAomr7HjG0zqwtOuBW6i1v3vABlQSlR4FIXg5az9JdLxWmh0KMlTqym+jnhf
         6x3ua2yRXj0IFv5P0ZDWUFSOaI4O0amY9QBSfBZLQ+Ym1wuXvz81GYFKjkE+D9d3x9S+
         zWKoNGXQcQBkiWgOwu+YGH9Hk3yY+/ZdopFQ/0SeEr1whs98MYYWPRjICGV67BpEZqE2
         /RVg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Thu, 12 Apr 2018 07:54:49 +1000
Subject: [PATCH 17/20] staging: lustre: use call_rcu() to free
 lu_object_headers
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152348368912.12394.12204341677623060724.stgit@noble>
In-Reply-To: <152348312863.12394.11915752362061083241.stgit@noble>
References: <152348312863.12394.11915752362061083241.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597488597449608198?=
X-GMAIL-MSGID: =?utf-8?q?1597488597449608198?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Using call_rcu to free lu_object_headers will allow us to use
rhashtable and get lockless lookup.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lustre/include/lu_object.h  |    6 +++++-
 drivers/staging/lustre/lustre/llite/vvp_object.c   |    9 ++++++++-
 drivers/staging/lustre/lustre/lov/lovsub_object.c  |    9 ++++++++-
 .../staging/lustre/lustre/obdecho/echo_client.c    |    8 +++++++-
 4 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/lustre/lustre/include/lu_object.h b/drivers/staging/lustre/lustre/include/lu_object.h
index d23a78577fb5..85066ece44d6 100644
--- a/drivers/staging/lustre/lustre/include/lu_object.h
+++ b/drivers/staging/lustre/lustre/include/lu_object.h
@@ -535,8 +535,12 @@ struct lu_object_header {
 	struct hlist_node       loh_hash;
 	/**
 	 * Linkage into per-site LRU list. Protected by lu_site::ls_guard.
+	 * memory shared with lru_head for delayed freeing;
 	 */
-	struct list_head	     loh_lru;
+	union {
+		struct list_head	loh_lru;
+		struct rcu_head		loh_rcu;
+	};
 	/**
 	 * Linkage into list of layers. Never modified once set (except lately
 	 * during object destruction). No locking is necessary.
diff --git a/drivers/staging/lustre/lustre/llite/vvp_object.c b/drivers/staging/lustre/lustre/llite/vvp_object.c
index 05ad3b322a29..48a999f8406b 100644
--- a/drivers/staging/lustre/lustre/llite/vvp_object.c
+++ b/drivers/staging/lustre/lustre/llite/vvp_object.c
@@ -251,13 +251,20 @@ static int vvp_object_init(const struct lu_env *env, struct lu_object *obj,
 	return result;
 }
 
+static void __vvp_object_free(struct rcu_head *rcu)
+{
+	struct vvp_object *vob = container_of(rcu, struct vvp_object, vob_header.coh_lu.loh_rcu);
+
+	kmem_cache_free(vvp_object_kmem, vob);
+}
+
 static void vvp_object_free(const struct lu_env *env, struct lu_object *obj)
 {
 	struct vvp_object *vob = lu2vvp(obj);
 
 	lu_object_fini(obj);
 	lu_object_header_fini(obj->lo_header);
-	kmem_cache_free(vvp_object_kmem, vob);
+	call_rcu(&vob->vob_header.coh_lu.loh_rcu, __vvp_object_free);
 }
 
 static const struct lu_object_operations vvp_lu_obj_ops = {
diff --git a/drivers/staging/lustre/lustre/lov/lovsub_object.c b/drivers/staging/lustre/lustre/lov/lovsub_object.c
index 13d452086b61..3626c2500149 100644
--- a/drivers/staging/lustre/lustre/lov/lovsub_object.c
+++ b/drivers/staging/lustre/lustre/lov/lovsub_object.c
@@ -70,6 +70,13 @@ int lovsub_object_init(const struct lu_env *env, struct lu_object *obj,
 	return result;
 }
 
+static void __lovsub_object_free(struct rcu_head *rcu)
+{
+	struct lovsub_object *los = container_of(rcu, struct lovsub_object,
+						 lso_header.coh_lu.loh_rcu);
+	kmem_cache_free(lovsub_object_kmem, los);
+}
+
 static void lovsub_object_free(const struct lu_env *env, struct lu_object *obj)
 {
 	struct lovsub_object *los = lu2lovsub(obj);
@@ -88,7 +95,7 @@ static void lovsub_object_free(const struct lu_env *env, struct lu_object *obj)
 
 	lu_object_fini(obj);
 	lu_object_header_fini(&los->lso_header.coh_lu);
-	kmem_cache_free(lovsub_object_kmem, los);
+	call_rcu(&los->lso_header.coh_lu.loh_rcu, __lovsub_object_free);
 }
 
 static int lovsub_object_print(const struct lu_env *env, void *cookie,
diff --git a/drivers/staging/lustre/lustre/obdecho/echo_client.c b/drivers/staging/lustre/lustre/obdecho/echo_client.c
index 767067b61109..16bf3b5a74e4 100644
--- a/drivers/staging/lustre/lustre/obdecho/echo_client.c
+++ b/drivers/staging/lustre/lustre/obdecho/echo_client.c
@@ -431,6 +431,12 @@ static int echo_object_init(const struct lu_env *env, struct lu_object *obj,
 	return 0;
 }
 
+static void __echo_object_free(struct rcu_head *rcu)
+{
+	struct echo_object *eco = container_of(rcu, struct echo_object, eo_hdr.coh_lu.loh_rcu);
+	kmem_cache_free(echo_object_kmem, eco);
+}
+
 static void echo_object_free(const struct lu_env *env, struct lu_object *obj)
 {
 	struct echo_object *eco    = cl2echo_obj(lu2cl(obj));
@@ -446,7 +452,7 @@ static void echo_object_free(const struct lu_env *env, struct lu_object *obj)
 	lu_object_header_fini(obj->lo_header);
 
 	kfree(eco->eo_oinfo);
-	kmem_cache_free(echo_object_kmem, eco);
+	call_rcu(&eco->eo_hdr.coh_lu.loh_rcu, __echo_object_free);
 }
 
 static int echo_object_print(const struct lu_env *env, void *cookie,
