Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuUV6T6B4T3ry1dG+9Hi3TJJ/jK9cue9PM86vvq0l6wJTMcMSoQDvNfi/m9+4UVbXBmUJUH
ARC-Seal: i=1; a=rsa-sha256; t=1521214923; cv=none;
        d=google.com; s=arc-20160816;
        b=lb1A2hpv3+AXNwliM5owlpUuB3H96CQT7E3pGPdbUQMVuFFHHeDoHrW15bvlvv5Jil
         tlTCgS4zIq6qX9Rl6TNeJeuWfDm+kAjL3VcstPhePipHXfjJ4c90YoUKipCnEEQPA+Ye
         djfVA0GxlFzxt/BuRNrr+gZrXk/Vd/lSXQtuouTIIPHUacUj2EuElT8JpytE0b+S46Ie
         k0BDWTwtqA/qM0iHn/xU86iNTIvBYN5i0MAmchlI3CeeurEdEB7f2gpYYJOww4Q/bFpB
         wdtb8Ohkwpl7+ZsjujJIN7wSrC3FBDF+pHbiOfcMjfCEqvjd1X4VhJirYLSHXalxBVBd
         RZcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AqSPoOyqjarANp6kXiJUSS2C+YetkSuHuxNODdzLCY0=;
        b=GYJGpiMgABagBv7ovOGBdkMAH1RRKQ2zHHVcL+y587eHaZ4Ez/+EgNt40e0d9YC2/t
         YlvpEvUiDXoArLO0uJuBtJ0KyA/Gji08FU2VQY8qOpPzHiJoRDPUI8q9Anj7EGQYS68I
         SiG8A72/AHev9VGGliXyEQFPPPeM9CIN5bpzN93Jjy6JHva5T8qDK2/LdvmS+xQA1hgW
         CwKs8McrBaMoH/rxpUDWMHjB6u+9AIJEyS0brBCAcEjv9nAj0ePdspYcuxA1XZGdCMbn
         jrb0bEru3zhBT5vekvMvbksExGV0zwwrWss4lgUtsKVKQuINqUmPgg5Gmtk3IK986K75
         tlWg==
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
Subject: [PATCH 4.15 065/128] xfrm: Fix xfrm_replay_overflow_offload_esn
Date: Fri, 16 Mar 2018 16:23:26 +0100
Message-Id: <20180316152340.008611247@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109093729326146?=
X-GMAIL-MSGID: =?utf-8?q?1595109459585047831?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
