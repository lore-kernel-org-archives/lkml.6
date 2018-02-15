Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227/HU8FoS/Rwkgcq25+lSJpg6arDGSC0OVjRruocexSQNBg7A/tswmfWE9YJAYW0IzBH9Lo
ARC-Seal: i=1; a=rsa-sha256; t=1518709391; cv=none;
        d=google.com; s=arc-20160816;
        b=h20niNjCTuh/T9RATBCQlHXISR5XXE5uzdfxsQrwn7IccCW18NZoLCDH1uq23kigyM
         92FvCQUTN/dBEin9uM26EWnNPfkkIpMJ7km4fkG014V9jaqwPbR8pL85MS+eWe4Qwy/F
         Y5IT3IIc019OQO2ZTSdte1ytKhdtIRJFEK20k0EvpAV5HwYt5x4B9rDt+5Z8qhTVuwdt
         h1gQrVQegOtyEW5tYHCQfAqauN/j/LF7EbC/96AiMr7GUGvvbVfeMwhgNCV7S6M/TDNM
         2Z3i7qobmYSS7S6xzs2NzN44h9qJI9MY4d2hIif+IdHQy4WlCB6fMCoaeaVRQzrma73U
         BdbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PEnAaVQIXDOaOAZcQT5TDwMV2FklhWaVwpNHFRWWbYQ=;
        b=QWo2dcxx8jxCbnxfcmYpbNCBWh28kZBClofuYv7gQmV4lh0rNT50tVuBpnPGrFHGQH
         ZdOFeF0Ka5DnIY7aSU/NxI5GI7o2bhaV2bv4PngOHuAGhgfGkrRwkuc/hWocEe9gD5Ia
         W0W3781vxbeMjOryzlGz9tZ81AQqyl0xjyXcrCfPQBAQUgafdD74S35OJfToHtaNavF+
         VO5BIgRkfIcZSCao6YMWg+wfKKlbARP6zyFWkDbPfcoxV8Z9BTG3//oVQn6vLheJxv8P
         dboK3cCQf3GiK1kpv3mSs234PcbYCMnB1Qb2uAZu373OgKs7s9WYz4DvXMfCpmNRlpHD
         mDDg==
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
Subject: [PATCH 4.15 101/202] NFS: reject request for id_legacy key without auxdata
Date: Thu, 15 Feb 2018 16:16:41 +0100
Message-Id: <20180215151718.592915136@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480977954456519?=
X-GMAIL-MSGID: =?utf-8?q?1592482218461200434?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
