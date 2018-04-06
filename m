Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48zVFvy19/uw0p1cEQ5gq5IAUw8MxmrTUW6Hsjg+AVlweHHL+50ZJ3z9mQ6TgHYDZHI2It7
ARC-Seal: i=1; a=rsa-sha256; t=1523021312; cv=none;
        d=google.com; s=arc-20160816;
        b=oDVCyhBzHe8HWAetQ50JtWs/reArpH0Z/G34+EUMhsBFox3lMQb5eGIKcpd+aXngyi
         hrqUbp2XAMR1KbpSzjzFjSbSxz9PflJ1FtT5+9zzoDaT51wiD1BKUmlBmMjDSxAftdUY
         OEXORxKc7kGx3gTERzq8HYaJfxLufX4DNOACPBfNMmNSuEUl1SAmJWwG+OsZHe9FzYf8
         OS3QPGbRMbRUrr8aByNoknD5HE/A6kd2yM47U+fT0u65f1Kf0IsCyYX9MB6a1YlGCeAl
         8EIE4kAr+Nk2uNAu2eHEvkPvWUtLFmjMH7oux5sWQW9V1CUlivdawZMnJ9A3D6LdQTSu
         AHxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SHJD5i69urDocs4ivC71eAkavdxC77WeiiIeqDJGnDg=;
        b=UvlUbCh/+aA3JTbrL27nVG3O8k3IC7/+Pk62Sl4lyZhVoXlemIO2t83q37hU+8DIk+
         w+7pK7UNARyDMJvWd5urxmd+cJZT6Rzel5rCsK3Sya8TrLjDfWz9+5RIa1VrlVp6Y8rk
         PBK3Qi4eBBGLNpX5FcASReqDz96DbeDy4Ax5lWIvfM1zk3aNR7y3hGbjJPU2HwUP4TvP
         ypsutubkLUsd1ZAoBebvntN8lvoTVLvIoEk5KifWRqPj/yfw0eeqZ2WJTDHnXzXRbjMZ
         CJXvSK1LWHmYa+MxZcCybKjVdKwvL1pL6loUEYzLD61OA/Dbp/xX9oipbe+KmR5FpKLR
         POqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 3.18 52/93] xfrm: Refuse to insert 32 bit userspace socket policies on 64 bit systems
Date: Fri,  6 Apr 2018 15:23:21 +0200
Message-Id: <20180406084227.189247954@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003595252777127?=
X-GMAIL-MSGID: =?utf-8?q?1597003595252777127?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steffen Klassert <steffen.klassert@secunet.com>

commit 19d7df69fdb2636856dc8919de72fc1bf8f79598 upstream.

We don't have a compat layer for xfrm, so userspace and kernel
structures have different sizes in this case. This results in
a broken configuration, so refuse to configure socket policies
when trying to insert from 32 bit userspace as we do it already
with policies inserted via netlink.

Reported-and-tested-by: syzbot+e1a1577ca8bcb47b769a@syzkaller.appspotmail.com
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
[use is_compat_task() - gregkh]
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/xfrm/xfrm_state.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1845,6 +1845,11 @@ int xfrm_user_policy(struct sock *sk, in
 	struct xfrm_mgr *km;
 	struct xfrm_policy *pol = NULL;
 
+#ifdef CONFIG_COMPAT
+	if (is_compat_task())
+		return -EOPNOTSUPP;
+#endif
+
 	if (!optval && !optlen) {
 		xfrm_sk_policy_insert(sk, XFRM_POLICY_IN, NULL);
 		xfrm_sk_policy_insert(sk, XFRM_POLICY_OUT, NULL);
