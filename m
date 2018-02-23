Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2259jeG1TcdmZpZmNjPCRLlzrB0Gg/suE+Cnm+lkGrS7kz/Yxt7FCmNbw2VmwJaBpRBeEYcY
ARC-Seal: i=1; a=rsa-sha256; t=1519412119; cv=none;
        d=google.com; s=arc-20160816;
        b=lWMADF2fq8qAfuYON1P9y3uKb6uj/54MlbnYT/nYwd0hA8kghd2XFcfk6bLOat26tx
         +IDcQuPXqgXCkZg02bGaWSSHqOEN49pSuj9IUEXLWofKwoxaE+4C/EICT5ctDMXynFqo
         w/OhPZflf68RbnyaP/SvuP36Ul8XQULKp8QLD5ZEfr4vgjttTIYoDfpMFKf5yxkSpqmf
         dgIM+ZQE0O4YVuJEXWRHu1lrEhifbqhNOvohpMjQ0RQku+Jba6xexDYwxIOJM45SGZle
         HVOLK562KWufIAXFRuzgfNyfsmOKt+NHkzJ6AW5MlqOzdEl0+z9DXaZWakmn8p8wC6BS
         Qtew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pFiNDA89ownhVZutObJX/IjjRsxBiFLWWat7tSsukOk=;
        b=CSklMn7CHobTp472to21/vwNS2DpL9UFjN9o9aNees7+uwjVV4apWwTvRiWzbZovVK
         oVYcwKILJIqhv0D8rJR8UcptIumPA1Nu06uvEb5UbGjUH51XfH5p3HUIO4u88TY3PlcL
         g7CdMAEhW4/akoMGCZRZmPJNwRlcWqCbWGT9DvHJa/U7hYuFdF6Cc5NPmLSawwpz3sxC
         djxI1sgYuCTHPkGdHWNhasa4u23PxbTfmexuYPrv/EuPNUHZrKvjsKXXk2Zk5Vxs3TBs
         yq+IVFImgIFeVvgc6LXqY5sW0pdXyTEeiZDG53/jUcEFrJ75QZfit07JCFzSfK6dsR70
         A91Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dexuan Cui <decui@microsoft.com>,
	Cathy Avery <cavery@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jorgen Hansen <jhansen@vmware.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 114/159] VSOCK: fix outdated sk_state value in hvs_release()
Date: Fri, 23 Feb 2018 19:27:02 +0100
Message-Id: <20180223170757.120018791@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593219082477475157?=
X-GMAIL-MSGID: =?utf-8?q?1593219082477475157?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Hajnoczi <stefanha@redhat.com>


[ Upstream commit c9d3fe9da094a9a7a3d3cd365b334b822e05f5e8 ]

Since commit 3b4477d2dcf2709d0be89e2a8dced3d0f4a017f2 ("VSOCK: use TCP
state constants for sk_state") VSOCK has used TCP_* constants for
sk_state.

Commit b4562ca7925a3bedada87a3dd072dd5bad043288 ("hv_sock: add locking
in the open/close/release code paths") reintroduced the SS_DISCONNECTING
constant.

This patch replaces the old SS_DISCONNECTING with the new TCP_CLOSING
constant.

CC: Dexuan Cui <decui@microsoft.com>
CC: Cathy Avery <cavery@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Jorgen Hansen <jhansen@vmware.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/vmw_vsock/hyperv_transport.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -488,7 +488,7 @@ static void hvs_release(struct vsock_soc
 
 	lock_sock(sk);
 
-	sk->sk_state = SS_DISCONNECTING;
+	sk->sk_state = TCP_CLOSING;
 	vsock_remove_sock(vsk);
 
 	release_sock(sk);
