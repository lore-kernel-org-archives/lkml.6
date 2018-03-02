Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsoGkOEhTnC2FXusQP76B11U3bKvFtLz1uiShs/mbEDriVwVpmTtWgeXS4z+UvT6EVMqVCy
ARC-Seal: i=1; a=rsa-sha256; t=1519981439; cv=none;
        d=google.com; s=arc-20160816;
        b=OcN69k6y9L02ymyvUokYSCrXvCJRJ2Eg9rSVqh5UMhO+f2ON6jTzBxs7lB23qi/Cy8
         qxNArQOUnHG/QAeyzxb+DBArQFRzAKuZKYkAKy0jIhYjpKvx94R2XQrV69pXfdRcxfV2
         n4qijJG/Cg8xW86Kp65g11fzHGnkkwOA8t2FRcwZGLOsypsL86H0/GEmDLWmcnfQyDu3
         Yo800DP9ILjskmBTJ+9Asp6JB6VycfTNAM9XIIAsw8/hQ0kd1VwJD/mmbqS5bC8uzp/Z
         bUZB3a0W2ftYrzAVKLLoaVxbmxMcDiP5YW3vFaRm96Ds+KaWHf4B1Iztou80tICjQXQE
         VQ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Vv9gYyTwkQ9KIbuuafGjq/BD/aiYQ7U/nmGrXItkc/U=;
        b=CiHPLCcyc98YZfllOj7T/a10E1dgsmxzI9+tGn55/axYI3MGpt9rIx4hEXh5Zsg1Ay
         XSItf6mN2lD8y+FJfia0RgFwUrtkIkjyyGznkGonBp7T8ZCPClx+BFH7MRRsPw7kA5Fb
         EJVgA6WtQ2+n56S8fEseQEHQ14nufZE5dMbc+GJAfofbMqttAxTa18LMaw1MT8IQolqe
         eQlLmIgkMWdkQ3TEqFCeltzatThZAYGqpVDIBT0D5evivC3HZMikqkQ82pukxUJ3qyGc
         vVbSkkIlozmAahVwt2RQgC2yrEB2rRDoLdagjZJgoVTzfOXS8zx5yvch6hueIyiPdA5J
         huhA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	John Fastabend <john.fastabend@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 090/115] bpf: sockmap missing NULL psock check
Date: Fri,  2 Mar 2018 09:51:33 +0100
Message-Id: <20180302084507.494931061@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593816057474558782?=
X-GMAIL-MSGID: =?utf-8?q?1593816057474558782?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Fastabend <john.fastabend@gmail.com>


[ Upstream commit 5731a879d03bdaa00265f8ebc32dfd0e65d25276 ]

Add psock NULL check to handle a racing sock event that can get the
sk_callback_lock before this case but after xchg happens causing the
refcnt to hit zero and sock user data (psock) to be null and queued
for garbage collection.

Also add a comment in the code because this is a bit subtle and
not obvious in my opinion.

Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/sockmap.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/kernel/bpf/sockmap.c
+++ b/kernel/bpf/sockmap.c
@@ -588,8 +588,15 @@ static void sock_map_free(struct bpf_map
 
 		write_lock_bh(&sock->sk_callback_lock);
 		psock = smap_psock_sk(sock);
-		smap_list_remove(psock, &stab->sock_map[i]);
-		smap_release_sock(psock, sock);
+		/* This check handles a racing sock event that can get the
+		 * sk_callback_lock before this case but after xchg happens
+		 * causing the refcnt to hit zero and sock user data (psock)
+		 * to be null and queued for garbage collection.
+		 */
+		if (likely(psock)) {
+			smap_list_remove(psock, &stab->sock_map[i]);
+			smap_release_sock(psock, sock);
+		}
 		write_unlock_bh(&sock->sk_callback_lock);
 	}
 	rcu_read_unlock();
