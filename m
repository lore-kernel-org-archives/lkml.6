Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqbG5FONFjInax1ejor0wWQSuexOVi9yoL2tCKXzyVFpvKX/gaQg/6OcTa7Rvlb6nj5PXw8
ARC-Seal: i=1; a=rsa-sha256; t=1526280793; cv=none;
        d=google.com; s=arc-20160816;
        b=FqkIR1EFGXCm0hFpKVH0n0g11+EFiJDy5KZ+n5ueRAM/IFbrpPXVVLRCQfpitfxcYl
         jdS4WcK/LwkH7C+ecxOvDPWDtmoVcfw/CKuoibf3g5GMUB/qOYowk5BtlvBG0gOltkSW
         zVs3WmNBbCKvnkiVXBD6JVZJnR5TuWHj8zFsagmZetdDUKpXNWVeEg73mUs2hGs6lUH6
         CDYwHGvEBJH2MRw2UCWOLF3Lfylld4/yQgxtu5oAgdrxJCEKlaste8XE+MGfJ3E+sz+f
         uM7ySZUgfPhXZrNr7/WVt2NwiD4Fq04KvbzZuCVRr5DMo5IsYBy+4khdx5daiwDF9CS1
         8LmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=spV7c41ZQUcbfxqASjMsHqec+cGmrkl3OHTSEI+r4Ww=;
        b=DaHvY9Hr/NNNsrE2LBsi8zyYKztrteiyTQ1XHyi6CakCMjqjQ/seOcn0f9mMW/GjJu
         5Jd4zHaQ7mVzsAph0tJ2N2+87XHZQJ5rAChtNXnbNR2vxXK+Nhbd70/yIFPQqhwmapxF
         Nsn3aw7aX7fOI9mm9U1fs06Km0NphuNJFO/uuIRBnkiZzcpYBlhLWd5UQnEjOhUvVjvJ
         N/fpRlZtpv3jCw98u1aQD4BEyrm550lgGv8FkpGbfjx1Q0sIYpXwJmK8tTKHrG6J340s
         /xLTyxcbSqY227SK+3PqBIKmS6rDvE0EYsQMPtNSAKp3kyBK45MgS+GhC8lmmBupKj0a
         jKCA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=t8qztNpL;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=t8qztNpL;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 34/56] net: fix rtnh_ok()
Date: Mon, 14 May 2018 08:48:39 +0200
Message-Id: <20180514064758.079254201@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421242429293362?=
X-GMAIL-MSGID: =?utf-8?q?1600421409579767892?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit b1993a2de12c9e75c35729e2ffbc3a92d50c0d31 upstream.

syzbot reported :

BUG: KMSAN: uninit-value in rtnh_ok include/net/nexthop.h:11 [inline]
BUG: KMSAN: uninit-value in fib_count_nexthops net/ipv4/fib_semantics.c:469 [inline]
BUG: KMSAN: uninit-value in fib_create_info+0x554/0x8d20 net/ipv4/fib_semantics.c:1091

@remaining is an integer, coming from user space.
If it is negative we want rtnh_ok() to return false.

Fixes: 4e902c57417c ("[IPv4]: FIB configuration using struct fib_config")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/net/nexthop.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/net/nexthop.h
+++ b/include/net/nexthop.h
@@ -6,7 +6,7 @@
 
 static inline int rtnh_ok(const struct rtnexthop *rtnh, int remaining)
 {
-	return remaining >= sizeof(*rtnh) &&
+	return remaining >= (int)sizeof(*rtnh) &&
 	       rtnh->rtnh_len >= sizeof(*rtnh) &&
 	       rtnh->rtnh_len <= remaining;
 }
