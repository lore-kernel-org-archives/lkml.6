Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2269RlYRMxq28UWyjwjoyVje72OkRkQ7LK+VH8vs6K+TkhhCZmzDdtKhQFr0+zanLaCzdiuw
ARC-Seal: i=1; a=rsa-sha256; t=1519218713; cv=none;
        d=google.com; s=arc-20160816;
        b=OJdptgl11ImXG4Ra1CksbdSZ3BC4onTtEtuTO1OzFfq+sTSf9x3kQ2vy+/l+Hln+xt
         Sj67oSh1fdgqDXoh6uVhJa79aEzbE+bFw1U7J/mrRiYV8vPu+Bw4w8L5hK9LrsyKg9hq
         EhCYdqSLdoC6TN9kqqcHWKK629t53nDKjzXCgiRWft7HRBX4izdajfZsTf2mS+f9Yw4y
         KgJuoc/IVdRWiayHHt9JgAZB6IUYeDf6zifs/q/GKfh7IALQrC+1t1NqMyqqOHL+qpV4
         CKMNBPd2EoaCVwC8hz81qDhQj7eGU+CgXa9gWc4ryp/9rrzN2/SPbBhkMBwjkcWIhHa9
         PJxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=j+47s1km7n8F2boy2fe8THKWmKU2sFQkPQnDdX4tDug=;
        b=qMKRq+uIoWw8GoQO+vEn62zW3wZ6iiLqLSTxfH4Qq35mNP/v3YtD9cBiYvA0EihqE6
         ZG58WjvY0E4tVHerTl5IG66xqskHEY+ZxxDF8kr74IbmNPjtu11BiagasIzVREcnX64I
         MvmMOwPtwTxK2Luw6KwVcLbxEid6PKor683CXt8Zo9m+/ARnHpLHINDLmBSSiTSZf7JV
         7PO6eB8FGEtOwMP4QOAdvEzq5qs4f8VS1Q9onFmha5XOpcWkeG/I3GW4ttOvqm1S0V2Q
         cQQbtSye1dhweHb2BWNC7s6xy+RMWi29e/2kOsAJ9sq7RrE9RXkLW34x4GEiXC829ktE
         BCUg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michal Kalderon <Michal.Kalderon@cavium.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 4.15 130/163] xprtrdma: Fix BUG after a device removal
Date: Wed, 21 Feb 2018 13:49:19 +0100
Message-Id: <20180221124537.316025776@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015764650252725?=
X-GMAIL-MSGID: =?utf-8?q?1593016281988026455?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

commit e89e8d8fcdc6751e86ccad794b052fe67e6ad619 upstream.

Michal Kalderon reports a BUG that occurs just after device removal:

[  169.112490] rpcrdma: removing device qedr0 for 192.168.110.146:20049
[  169.143909] BUG: unable to handle kernel NULL pointer dereference at 0000000000000010
[  169.181837] IP: rpcrdma_dma_unmap_regbuf+0xa/0x60 [rpcrdma]

The RPC/RDMA client transport attempts to allocate some resources
on demand. Registered buffers are one such resource. These are
allocated (or re-allocated) by xprt_rdma_allocate to hold RPC Call
and Reply messages. A hardware resource is associated with each of
these buffers, as they can be used for a Send or Receive Work
Request.

If a device is removed from under an NFS/RDMA mount, the transport
layer is responsible for releasing all hardware resources before
the device can be finally unplugged. A BUG results when the NFS
mount hasn't yet seen much activity: the transport tries to release
resources that haven't yet been allocated.

rpcrdma_free_regbuf() already checks for this case, so just move
that check to cover the DEVICE_REMOVAL case as well.

Reported-by: Michal Kalderon <Michal.Kalderon@cavium.com>
Fixes: bebd031866ca ("xprtrdma: Support unplugging an HCA ...")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Tested-by: Michal Kalderon <Michal.Kalderon@cavium.com>
Cc: stable@vger.kernel.org # v4.12+
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sunrpc/xprtrdma/verbs.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1476,6 +1476,9 @@ __rpcrdma_dma_map_regbuf(struct rpcrdma_
 static void
 rpcrdma_dma_unmap_regbuf(struct rpcrdma_regbuf *rb)
 {
+	if (!rb)
+		return;
+
 	if (!rpcrdma_regbuf_is_mapped(rb))
 		return;
 
@@ -1491,9 +1494,6 @@ rpcrdma_dma_unmap_regbuf(struct rpcrdma_
 void
 rpcrdma_free_regbuf(struct rpcrdma_regbuf *rb)
 {
-	if (!rb)
-		return;
-
 	rpcrdma_dma_unmap_regbuf(rb);
 	kfree(rb);
 }
