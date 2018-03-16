Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt3COXGzDEgBhEm+ISKStlRR/LVrHL128jxwdY6qXQMCQfd0au9YVmBSBskeeS3dmm794Jn
ARC-Seal: i=1; a=rsa-sha256; t=1521214574; cv=none;
        d=google.com; s=arc-20160816;
        b=RpHzKimPFCXW+ByOuKsE+LvqwJi3SpMxmJ+mjEjB6SPc0P2PZC5RzHy5+JsXwqmwOG
         9ZdHCvCZf2dE/Z5c1Teew2yszaE3a9OWCg9w8mAbLlg9JFRrSsb9zxo+rMmxo47MxPpe
         gW5h8H7W34UrkLRjdxnH8nAOtU0lgr/9OAQOYPeSoDWjT3CvgyES1Ty6ch/7ohfJXOY7
         SjnOo8MGTBtbYxIKtAO5U+aGpzrVa5NNxNxbbAnvaJri3wd0wXxmERVxWAtIOnyQCF6r
         PovpPSLhj4l3e6Fptc9u5xQopmce+VxdOKIXoCfAaxqvTO7GJt4Ejy6LYn/2HqIxSH6/
         dxlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=txbLnoIWiGhyJDlaqKrzfPVoAebu74T3mf3qusmgkoI=;
        b=d24r208uXO/B21b+12A9PUhzzk0bPTZNP2+UfyR3W6xJ/QYr/aFZCS+s8TwsBif4Vg
         3njB+CctYBco9JwwXMKwFCEqD0DJ6f8XwvKFN388xZFH1BGEnrAM8fV0Q8qKicO3fP7U
         9UIAsf4hLU9BUM89vNiSPQhHMbeNzSKWsAyCoEtBtTas1rcF+Gphpo1RZbi01cVkYSxq
         jxCYSp7r/iB0fdGJZjdUWUk/U2FDG+EsLg+jT+8AZmmwWWh/6jG1Xl7F6bFlLFYzhTpk
         XLPiyCCMSt9FFtk/uyUveyd5OKxUxUffNv83zACqNzQntD1uNLqkN5aVuG2MpiumBBNF
         hnLw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yossef Efraim <yossefe@mellanox.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 054/109] xfrm: Fix xfrm_replay_overflow_offload_esn
Date: Fri, 16 Mar 2018 16:23:23 +0100
Message-Id: <20180316152332.896959188@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109093729326146?=
X-GMAIL-MSGID: =?utf-8?q?1595109093729326146?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yossef Efraim <yossefe@mellanox.com>


[ Upstream commit 0ba23a211360af7b6658e4fcfc571970bbbacc55 ]

In case of wrap around, replay_esn->oseq_hi is not updated
before it is tested for it's actual value, leading function
to fail with overflow indication and packets being dropped.

This patch updates replay_esn->oseq_hi in the right place.

Fixes: d7dbefc45cf5 ("xfrm: Add xfrm_replay_overflow functions for offloading")
Signed-off-by: Yossef Efraim <yossefe@mellanox.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/xfrm/xfrm_replay.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/net/xfrm/xfrm_replay.c
+++ b/net/xfrm/xfrm_replay.c
@@ -666,7 +666,7 @@ static int xfrm_replay_overflow_offload_
 		if (unlikely(oseq < replay_esn->oseq)) {
 			XFRM_SKB_CB(skb)->seq.output.hi = ++oseq_hi;
 			xo->seq.hi = oseq_hi;
-
+			replay_esn->oseq_hi = oseq_hi;
 			if (replay_esn->oseq_hi == 0) {
 				replay_esn->oseq--;
 				replay_esn->oseq_hi--;
@@ -678,7 +678,6 @@ static int xfrm_replay_overflow_offload_
 		}
 
 		replay_esn->oseq = oseq;
-		replay_esn->oseq_hi = oseq_hi;
 
 		if (xfrm_aevent_is_on(net))
 			x->repl->notify(x, XFRM_REPLAY_UPDATE);
