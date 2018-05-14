Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp4g/nS2yL+x+Zs7UdMZ1JB46w4nddjonKf1lWwaoOEp2AmR/FQUaIfHfDPBXbDjoTpppYg
ARC-Seal: i=1; a=rsa-sha256; t=1526280750; cv=none;
        d=google.com; s=arc-20160816;
        b=HDxi7Zv9rwjHEboBRzCXHwQIt53yvL4Y1xyqA1HUN+h6vLk/q1rXxnHUf7uygfkAsz
         bgvw0VLLJYyeVi2IWi9tk2LmljvGkHIFBRReG3a0AgonmqIDDKH4r1EPHC5cxXOQaO7n
         ZqMcdPAEjC3t+3k66lF9P4o2NWEKioWxWeqdVqPnlLAQ8aUjNtCXuaKsYLtNpbo8TQRe
         rlkSYd6vy5a2FOVmvofq37BHnJTthb/lIABGFF95+iI4LN84Gnnlob7obB57F53lWJvj
         AZZ6WuJlD/ewruVJFCD9LCl2A0R2ZxhNVw9CabQEQqrfA3q64GFMGaIppQ255onhJSBy
         fsAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=I5Zs9xNzKYNneblktpwgkmt3/71D/ULZech7zyrHVvk=;
        b=j000+qoYephVpinsk5JE1UxG3zTtZaNS6yCAAlJ43U2HlA/W9BiFmWnMax6IllryRv
         kMODuF3Grp2dzg3aT2mqorHZ4IBTLRJfx29wDMk37iGEZfs+8DiHHhBql+m8LOC/qjbN
         BuviIcz8aXMsKey9CH/F5bGZ9Ba1rVJWtN6nqlv/Fk+lXojlMT3Z0is+uGVBKe6sipmG
         mTwv4d7ebC0ufDIMqm+VMrXeLIATwDGyVtD2NfCki77O670uy/Oie2on53J0LnMU1hDj
         TuuQ/gJg92D1HtW/4LXr9PJqfoT4nSvmpktGGwrQP7/I3H9mnyAfnkCS8fnpgAG4qXQ8
         lX1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=mTCOucvE;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=mTCOucvE;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yi Zhao <yi.zhao@windriver.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Nathan Harold <nharold@google.com>
Subject: [PATCH 4.4 43/56] xfrm_user: fix return value from xfrm_user_rcv_msg
Date: Mon, 14 May 2018 08:48:48 +0200
Message-Id: <20180514064758.800723206@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421364023497129?=
X-GMAIL-MSGID: =?utf-8?q?1600421364023497129?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yi Zhao <yi.zhao@windriver.com>

commit 83e2d0587ae859aae75fd9d246c409b10a6bd137 upstream.

It doesn't support to run 32bit 'ip' to set xfrm objdect on 64bit host.
But the return value is unknown for user program:

ip xfrm policy list
RTNETLINK answers: Unknown error 524

Replace ENOTSUPP with EOPNOTSUPP:

ip xfrm policy list
RTNETLINK answers: Operation not supported

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Nathan Harold <nharold@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/xfrm/xfrm_user.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2480,7 +2480,7 @@ static int xfrm_user_rcv_msg(struct sk_b
 
 #ifdef CONFIG_COMPAT
 	if (is_compat_task())
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 #endif
 
 	type = nlh->nlmsg_type;
