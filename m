Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225eHn0Pa/+zpOZOrXW70JgBZg6z7rGBuaiUIXv9esaeq7owdt5KTlrATWiyJQzteK8l6vKO
ARC-Seal: i=1; a=rsa-sha256; t=1518708493; cv=none;
        d=google.com; s=arc-20160816;
        b=FI7vysBbynRizwATGbC94qBEclNc0TICIChcqNffB5dcKVqqRERFXD+8YiXOhtPBgz
         JFCTZVwpmKG9quORAYBpTvbTg+AVWY5vzIfiChalk1Bm7M0T+P/BE/rjipieVVu9VX6z
         6AxMHYon3tdimFOEsVb1ZRZMHcpnHQo2DPLEa5Z452VPWnFwLuwPkFPJIxGa9JxjNwer
         SMRhQ5sV/F/h/Uhkb670Kmp9h3bNQ/svs8u5KYAR9iK3r1Trd1bKInZOOsRSYzAIlbMM
         SnU80sOJ137Q2v0CtiE12/c5rOaKfozJrkqoh3CS+i64NP+5de5wDQzA5wHeVEH7n1oM
         CORA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FLqpZoeduAMfK3SRJg8Uj98AXqCrG25X4nTpFqc6CIw=;
        b=poI/p6Wvuc21RaHnx6fKgwc65y5jpXyhjQ0JRS0j1VB/5UL9KwldKLD6qc8M+w6VwM
         M/9J6tETID0mi0pfpeZ8ZRvdbOSvUAhabPHSLloqBXn2x8lJi1LNcuNyLi8pDcK+l52D
         OKvCyYzebNuOC0WQCsESdXyOx1XKjgyPwDSgRSbeQvllWuPpGZq589E81a/e+o0Xy+lz
         FzLhnMRYCe5FWvuwLiBwpYrLUbNa5YJpCFN+cZC2TAGvLxHrzb5GJ0UyFXmxg3iQKIPu
         4qVkwm4zG0OWXga3Vt5OjkzQEcQQ671w2meYhjidRNegFOKvm3qTro35yvuCTedJ6WH+
         Tw/w==
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
Subject: [PATCH 4.9 25/88] NFS: reject request for id_legacy key without auxdata
Date: Thu, 15 Feb 2018 16:16:52 +0100
Message-Id: <20180215151226.151984706@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480977954456519?=
X-GMAIL-MSGID: =?utf-8?q?1592481276656452124?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -567,9 +567,13 @@ static int nfs_idmap_legacy_upcall(struc
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
