Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+pZlczdXe4L5+NnRCfMg4/J5Cd9XYbg9no5cjmz+O0o4ksAe6VNrH3W/7NByv63ELxIZUi
ARC-Seal: i=1; a=rsa-sha256; t=1522346640; cv=none;
        d=google.com; s=arc-20160816;
        b=AZph/UxSoKtPkfUpBsiFquyJ6hZmuaRGEIEQYNWoeCgzydMOI2+q8ULpqnG2m4NBtc
         Go9OyqHHGSh3ENRRp3QPgJ8UMz0WB/6T05xAFNNIlA+hkMtfapDYFAmIKyIDBtwNvTCw
         0CEx6UYGCU2SsH39NWCmK0jegpIDxOklvkmzPe/vTzf9BVIGGCB4ONQg4sNWBOslSGI1
         FzBZ55SMURtRIBv/HzPWqxOZz3kx5CNsAQ7O/LPRpjejn+eUv831nqvBK3PoOI3Q0WQJ
         cWnkgK7ODH96wDk3VIZE7+oLcLLSEgtUwpGFZXhorjz9LQvnXeMa34LwXWFgJ0I/NMwI
         f1Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9i8e2zCDEpyAXLE9XR6gwiA04iJqyTN5w5d+N+0QEdU=;
        b=JA2TWcXGTqXcpSVxAO56JvFvhXwMc1ZjiJHddE9C6gkYtAIxkgoTveuq7T8IjxU2OR
         Lh+B2hIUYM43D3FA1oxsAM0yCQ028/NvVF1VzODdB3ebxtymy6It2FnnRakL6lUHqDm+
         y1XGKdk8PE1SIG5HlziqqgXXRUbqvEvbL+0dTXLKS/D/FbbUqJ45nG0dxTEyrgkIlhro
         xB3I0lWLQA7RB0FS1cVetBGHrOi3lqkjbnwk9mpi5SDZct0I7xN/qmpS47nO/wTB/0hO
         jU5FWZLoLFM1mV644mPdKNEyLOZD93NodaQ2VyVfjDFCcvLFa8pD0K68kJmp3zAT7UCx
         DPkA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arkadi Sharshevsky <arkadis@mellanox.com>,
	Jiri Pirko <jiri@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 47/47] team: Fix double free in error path
Date: Thu, 29 Mar 2018 20:00:28 +0200
Message-Id: <20180329175733.524885124@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296150991249448?=
X-GMAIL-MSGID: =?utf-8?q?1596296150991249448?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arkadi Sharshevsky <arkadis@mellanox.com>


[ Upstream commit cbcc607e18422555db569b593608aec26111cb0b ]

The __send_and_alloc_skb() receives a skb ptr as a parameter but in
case it fails the skb is not valid:
- Send failed and released the skb internally.
- Allocation failed.

The current code tries to release the skb in case of failure which
causes redundant freeing.

Fixes: 9b00cf2d1024 ("team: implement multipart netlink messages for options transfers")
Signed-off-by: Arkadi Sharshevsky <arkadis@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/team/team.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2395,7 +2395,7 @@ send_done:
 	if (!nlh) {
 		err = __send_and_alloc_skb(&skb, team, portid, send_func);
 		if (err)
-			goto errout;
+			return err;
 		goto send_done;
 	}
 
@@ -2681,7 +2681,7 @@ send_done:
 	if (!nlh) {
 		err = __send_and_alloc_skb(&skb, team, portid, send_func);
 		if (err)
-			goto errout;
+			return err;
 		goto send_done;
 	}
 
