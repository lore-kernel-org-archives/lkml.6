Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225179S8uJ2nT5BpkwWEvunke0jNxFscvSyLZV0hCUClnkng0vvNblSMjenRC4H07EMZSmZo
ARC-Seal: i=1; a=rsa-sha256; t=1517591739; cv=none;
        d=google.com; s=arc-20160816;
        b=QJo3+xf3Qf/ifEe9MI9YvXNI5K3g9SDfJJnchOyv2jzCkMHk1vKZ4jRcAHYY7Zetkp
         tPjjix7OPPWEAu/mQGPnYfPeoOQmLm/64p0Usv8pEnOTZhZEM1wQKrKEpTeKXnWZmYRl
         O4Th6SrMYtohPAGFQBk3J0ZDiDanyk21ur/waBnehaOtCZPLNDDlm8xAythpTKxmEXct
         IPYL4bviF/EYvvkodm0A1HX4NkU2+zIp8KYbYKPF2WwY/9giZtDM/xQEMJw98r24kgSJ
         Zq2C98cNscnumDdbBeA6oNHN/Q0EUQXNsraO8RKXmcafjf4UXxaNfgrM7FGTBgq7GL21
         3orQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2z87AcXbG6R3JVWQQaiwZDB0I7lV3r85YKyWBwall9M=;
        b=DAUn7quZlDiwOHeE19pEuvTowUMWWLXLAWZgNFXlibxPgSH2r9X+YSONQFIp5BSMR0
         zPXSrsq6dp7t8dU7aym3MAH/s5NuyRZ25tKTrpoALAxQVxBwjsnVM289C1HHn9Fop9TS
         kgC++D2voDU5ZUYYVS6iElVKwAld1jdW9VTQOQwPrXLyX1VuTzN8NskdiEvUb7FPhync
         kQQ76f7K+VLhsbNAell+8j7/kUiLl3N5kCnlIuXy5vpejnQRGWAV+RlpBdpGKP8kYF5L
         3yrOCtaxKA5MJDDhJhqMWQkDOC4roHz56MYBfp5eo+6VjAQmxczFPCoCuPZEnvC+W0JG
         hxDA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dmitry Eremin <Dmitry.Eremin@intel.com>,
	Andreas Dilger <andreas.dilger@intel.com>
Subject: [PATCH 4.15 27/55] staging: lustre: separate a connection destroy from free struct kib_conn
Date: Fri,  2 Feb 2018 17:58:45 +0100
Message-Id: <20180202140828.999834330@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309667378861377?=
X-GMAIL-MSGID: =?utf-8?q?1591310275935665184?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Eremin <dmitry.eremin@intel.com>

commit 9b046013e5837f8a58453d1e9f8e01d03adb7fe7 upstream.

The logic of the original commit 4d99b2581eff ("staging: lustre: avoid
intensive reconnecting for ko2iblnd") was assumed conditional free of
struct kib_conn if the second argument free_conn in function
kiblnd_destroy_conn(struct kib_conn *conn, bool free_conn) is true.
But this hunk of code was dropped from original commit. As result the logic
works wrong and current code use struct kib_conn after free.

> drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
> 3317  kiblnd_destroy_conn(conn, !peer);
>                           ^^^^ Freed always (but should be conditionally)
> 3318
> 3319  spin_lock_irqsave(lock, flags);
> 3320  if (!peer)
> 3321      continue;
> 3322
> 3323  conn->ibc_peer = peer;
>       ^^^^^^^^^^^^^^ Use after free
> 3324  if (peer->ibp_reconnected < KIB_RECONN_HIGH_RACE)
> 3325      list_add_tail(&conn->ibc_list,
>                          ^^^^^^^^^^^^^^ Use after free
> 3326                    &kiblnd_data.kib_reconn_list);
> 3327  else
> 3328      list_add_tail(&conn->ibc_list,
>                          ^^^^^^^^^^^^^^ Use after free
> 3329                    &kiblnd_data.kib_reconn_wait);

To avoid confusion this fix moved the freeing a struct kib_conn outside of
the function kiblnd_destroy_conn() and free as it was intended in original
commit.

Fixes: 4d99b2581eff ("staging: lustre: avoid intensive reconnecting for ko2iblnd")
Signed-off-by: Dmitry Eremin <Dmitry.Eremin@intel.com>
Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c    |    7 +++----
 drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.h    |    2 +-
 drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c |    6 ++++--
 3 files changed, 8 insertions(+), 7 deletions(-)

--- a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c
+++ b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c
@@ -826,14 +826,15 @@ struct kib_conn *kiblnd_create_conn(stru
 	return conn;
 
  failed_2:
-	kiblnd_destroy_conn(conn, true);
+	kiblnd_destroy_conn(conn);
+	LIBCFS_FREE(conn, sizeof(*conn));
  failed_1:
 	LIBCFS_FREE(init_qp_attr, sizeof(*init_qp_attr));
  failed_0:
 	return NULL;
 }
 
-void kiblnd_destroy_conn(struct kib_conn *conn, bool free_conn)
+void kiblnd_destroy_conn(struct kib_conn *conn)
 {
 	struct rdma_cm_id *cmid = conn->ibc_cmid;
 	struct kib_peer *peer = conn->ibc_peer;
@@ -896,8 +897,6 @@ void kiblnd_destroy_conn(struct kib_conn
 		rdma_destroy_id(cmid);
 		atomic_dec(&net->ibn_nconns);
 	}
-
-	LIBCFS_FREE(conn, sizeof(*conn));
 }
 
 int kiblnd_close_peer_conns_locked(struct kib_peer *peer, int why)
--- a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.h
+++ b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.h
@@ -1016,7 +1016,7 @@ int  kiblnd_close_peer_conns_locked(stru
 struct kib_conn *kiblnd_create_conn(struct kib_peer *peer,
 				    struct rdma_cm_id *cmid,
 				    int state, int version);
-void kiblnd_destroy_conn(struct kib_conn *conn, bool free_conn);
+void kiblnd_destroy_conn(struct kib_conn *conn);
 void kiblnd_close_conn(struct kib_conn *conn, int error);
 void kiblnd_close_conn_locked(struct kib_conn *conn, int error);
 
--- a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
+++ b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
@@ -3314,11 +3314,13 @@ kiblnd_connd(void *arg)
 			spin_unlock_irqrestore(lock, flags);
 			dropped_lock = 1;
 
-			kiblnd_destroy_conn(conn, !peer);
+			kiblnd_destroy_conn(conn);
 
 			spin_lock_irqsave(lock, flags);
-			if (!peer)
+			if (!peer) {
+				kfree(conn);
 				continue;
+			}
 
 			conn->ibc_peer = peer;
 			if (peer->ibp_reconnected < KIB_RECONN_HIGH_RACE)
