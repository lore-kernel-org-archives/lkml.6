Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvWP82jBu6vZ+LovmCDGXN+S+aH+uJKt6mxRY2nPC+XN9NP4rXMEGuTsenIDG5uYJDiLg++
ARC-Seal: i=1; a=rsa-sha256; t=1521482966; cv=none;
        d=google.com; s=arc-20160816;
        b=qoP91L2MllrpihDGMQf7Dyq64uu9DOISX7FYOAOE9p/MMdqW+G8MLyZa7u3xWZCFqY
         aiE/B05SqSsaJwy2BjpX7WILd/SvrVxc/fTxeQkkfMofhYHT6s4N6/gmaINSnvNmtMFn
         v5APDjPEh1/llALG0FE2TtyBxHQwkq4q3B1tECeDMM3RbDBjgJgBggkm1Y0HI3Q87KLm
         5FxYVMq8PKKcPjL1lemB5pJffg/dpttYefZ2kkonksCi1l5FTrAVr+sE4ceqTCK/UyEF
         d+rp1H3wJCbBxHelc08vEBmybYuvYZOqhs+2lF1RRC8lXLgLDgx8Y5NjBJja0VNv4XI/
         Rlcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aEvHe6ZjpgOkBnEXoHJct4qrd530IDZZU1hgMyx90Po=;
        b=dWF0a6zzQnRUgHkCGs6R1YBSNh6NA26sFnBqGS+SzOFJPihrlrYObA1gV5Cb6i2uLz
         iQ7GY9Jj+UqMFRu6WH9xaHorGbci8ZsDumROYzl/mlP7URPS8ZE1SZQDJap2b/ChJG7i
         he8oLfcxSRY+Cf7UF529IA0zpRmGpNXpO9Eewv5odrDECubNUuxTK1ZxHoUuCIZsh+MG
         hCJHUov7LorM4AvyS/4LylJGUQfUJNNRraCmzht28f2PwHY1PfjHitlePWQjq2xOVcrt
         I5YQhnRBtie0hnF/rKY1Au0Z6IQsvpH8n0hi0kXS6r4ddTnBNxeGzmlUabydlTqGdfft
         JihQ==
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
Subject: [PATCH 3.18 19/68] tcp: sysctl: Fix a race to avoid unexpected 0 window from space
Date: Mon, 19 Mar 2018 19:05:57 +0100
Message-Id: <20180319171830.571358571@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390523266264934?=
X-GMAIL-MSGID: =?utf-8?q?1595390523266264934?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1099,9 +1099,11 @@ void tcp_select_initial_window(int __spa
 
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
