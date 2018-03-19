Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELss09ml4HxryOGprasBGOlwKVjhJCFmxuvmpBUxXvTn3LJ7f5sw7FlHDIk/424u82HFngGI
ARC-Seal: i=1; a=rsa-sha256; t=1521483717; cv=none;
        d=google.com; s=arc-20160816;
        b=jtXlwYFZKdcc97RRprcMkFaGVv8uLjEdaejLBXmkpZ2cGc2rugrevrq0GZ2uvIRRCZ
         xb1sMAOClbnRRjYXWL1WL/RjxJLp1wwR1T+0s/aqH3Oys5XPriHWTE+NIkXDzXiKhboU
         +z8vJFFgNnN77x7OHINyy8hdzxnSNjCzJL6gGH25z/sQOAbhP+qja2qFkfjBgmJir6GM
         SFxqNF3u6QVzDR8m8rbiT/OA4T6gur3bGOAYAtgAjR1FLwIMkwrhBBeFdlJNGS3Z5mH1
         k6ZATt/97nFfCHlvwNClD26nUNgxwpBng0J1oZPMLCVlyCe57Vx3Y6xXbQEdaxLBAGxt
         8INw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AQzxnS9kCHI3++f5WE47+0ROa53f0L0ijgib99gUsoM=;
        b=XTALuE1xYLWheA9ZzjRP2wLTiCjrdcZmOkoIjEo75hIFeOJnbQd0ZgsqHjDNV3pQam
         L/mFeNuXHKjP3JV/vHz+HV2uIqx2/T21KqY1ddVyfIENtxwEcyBacQ+VmAotizBH+tDf
         ibh1rNN18flftS6UHQQ7R936I2AQW6wFhFvsdbgvUcfZMo3DuB+KU2YO/G69dWdXFX17
         YPiMnXbHfv5CAkjMAYXyxJ32xGu0bcBZ2m12zb4Vb4qi2cOuGjUV3vLfzo2ybSlGEqDq
         9e6P4w2fyn264HV/cu9+cPwHxsI97vqNi/6AF2fUs/SYoSYX5nb58TahqPFa5kp41adz
         07tA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Gao Feng <fgao@ikuai8.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 064/241] tcp: sysctl: Fix a race to avoid unexpected 0 window from space
Date: Mon, 19 Mar 2018 19:05:29 +0100
Message-Id: <20180319180753.852247878@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390523266264934?=
X-GMAIL-MSGID: =?utf-8?q?1595391310210969511?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gao Feng <fgao@ikuai8.com>


[ Upstream commit c48367427a39ea0b85c7cf018fe4256627abfd9e ]

Because sysctl_tcp_adv_win_scale could be changed any time, so there
is one race in tcp_win_from_space.
For example,
1.sysctl_tcp_adv_win_scale<=0 (sysctl_tcp_adv_win_scale is negative now)
2.space>>(-sysctl_tcp_adv_win_scale) (sysctl_tcp_adv_win_scale is postive now)

As a result, tcp_win_from_space returns 0. It is unexpected.

Certainly if the compiler put the sysctl_tcp_adv_win_scale into one
register firstly, then use the register directly, it would be ok.
But we could not depend on the compiler behavior.

Signed-off-by: Gao Feng <fgao@ikuai8.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/tcp.h |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1265,9 +1265,11 @@ void tcp_select_initial_window(int __spa
 
 static inline int tcp_win_from_space(int space)
 {
-	return sysctl_tcp_adv_win_scale<=0 ?
-		(space>>(-sysctl_tcp_adv_win_scale)) :
-		space - (space>>sysctl_tcp_adv_win_scale);
+	int tcp_adv_win_scale = sysctl_tcp_adv_win_scale;
+
+	return tcp_adv_win_scale <= 0 ?
+		(space>>(-tcp_adv_win_scale)) :
+		space - (space>>tcp_adv_win_scale);
 }
 
 /* Note: caller must be prepared to deal with negative returns */
