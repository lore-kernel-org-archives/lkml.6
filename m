Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227i+nDwhtN0066ErS280PmCsAUCE3CWWLwn9i0PtQVXuyhQ/s2YTUKUwAY9dgmNOqzQGb4D
ARC-Seal: i=1; a=rsa-sha256; t=1518708863; cv=none;
        d=google.com; s=arc-20160816;
        b=ZCZ2O0PIzrvHMyCnpcmgBX5cesU6l1Mzq/gFkXBGjENvpqX9G30UXnj4vsi30DchVe
         Rhl52qPPSz+gYup5E3v+Q5wffWn1XWh0S5Odm6A5ZJh1qORjotJwh6vIzUPFKlJqhcZ2
         Kq7laFGzERqOdrurzCfPOJTsodxLKc6IkqUngOY3ThnyHnhs2pATcRi9byUthM8o2kQD
         thij/yUjXyNZn8SUqGH71os+GPRKfc+jwZjHqvfHxsFwrHy5t+17aDpZMne+3vQovhSh
         c5Dp3flNqMhdpURi0E49XceKwyo7lFJpHQDQl5eg9lWkmTxJPc0MQ4ttiz3HCL8sIU1k
         GodQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dmLHSof0MU7t2Dgnnnc5NO1RZrFsWHe0p3yWmh8f4yY=;
        b=lRmw/tSRNGJYl2lCwbc8ElU8oduaFav3KMCpuPK+YNHXvZ8lRzElXQ6AOReO6tD7Lb
         wyILlcSYYzoZdN6nU02sEcRut3sJvbma5es/XhyphwC1O0BKCYBCJzQei8dDBhuV51/M
         W8uiTfc0WUxMpP43P/4EA6LNn/pd/v6zEUukWL1wYN/Sz32ok6CryeNkszEYDKSqW1Wm
         0T9kdKjqSJfnfode/yyVuvxhw8xtkE9MqWp6V58rGUQEg95rjFr5M8mebNnT0B8uNtoo
         P9pL30lq+bX3DEVxv3vcxeCP40GYOR7BH948Vcx9phb0t3CKQLNJ/vymIXXTJKqUu0b9
         CfiA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+5dfdbcf7b3eb5912abbb@syzkaller.appspotmail.com,
	Eric Biggers <ebiggers@google.com>,
	Trond Myklebust <trondmy@gmail.com>
Subject: [PATCH 4.14 108/195] NFS: reject request for id_legacy key without auxdata
Date: Thu, 15 Feb 2018 16:16:39 +0100
Message-Id: <20180215151711.089553032@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480977954456519?=
X-GMAIL-MSGID: =?utf-8?q?1592481665759507535?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 49686cbbb3ebafe42e63868222f269d8053ead00 upstream.

nfs_idmap_legacy_upcall() is supposed to be called with 'aux' pointing
to a 'struct idmap', via the call to request_key_with_auxdata() in
nfs_idmap_request_key().

However it can also be reached via the request_key() system call in
which case 'aux' will be NULL, causing a NULL pointer dereference in
nfs_idmap_prepare_pipe_upcall(), assuming that the key description is
valid enough to get that far.

Fix this by making nfs_idmap_legacy_upcall() negate the key if no
auxdata is provided.

As usual, this bug was found by syzkaller.  A simple reproducer using
the command-line keyctl program is:

    keyctl request2 id_legacy uid:0 '' @s

Fixes: 57e62324e469 ("NFS: Store the legacy idmapper result in the keyring")
Reported-by: syzbot+5dfdbcf7b3eb5912abbb@syzkaller.appspotmail.com
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Trond Myklebust <trondmy@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/nfs4idmap.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/fs/nfs/nfs4idmap.c
+++ b/fs/nfs/nfs4idmap.c
@@ -568,9 +568,13 @@ static int nfs_idmap_legacy_upcall(struc
 	struct idmap_msg *im;
 	struct idmap *idmap = (struct idmap *)aux;
 	struct key *key = cons->key;
-	int ret = -ENOMEM;
+	int ret = -ENOKEY;
+
+	if (!aux)
+		goto out1;
 
 	/* msg and im are freed in idmap_pipe_destroy_msg */
+	ret = -ENOMEM;
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		goto out1;
