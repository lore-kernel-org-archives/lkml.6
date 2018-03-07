Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsUX9GLAqOUdh2Aei2iUhh8C58XG6wtqBsn5ZJicfFdsgjXvV1hXret5QH+QOSUyryUxRYM
ARC-Seal: i=1; a=rsa-sha256; t=1520452067; cv=none;
        d=google.com; s=arc-20160816;
        b=AHmOuICs3iHWzw9Y2daw8PSbwHuJK66KKxJ9rbBt0lE0Zlj+9yMNgt4gKmznbRRQoP
         w9dOB1JH0CX8gYFNMFB3KpDAtZqjSWF0OoSFc/PauQVZgaofAbKDakWTgpfABnAj+33I
         op0RhZFBaNi2R2/hQrnixPCR4z78rnrNUtSuwpO8cuyfDt23SkCFmuF8LdZL4/0wuwPq
         V+TKSqr4cSlOOLeClPK1vG34IkRhmBlITQ1vQuZk55eCPldQ9tGnCmjOjEV4DPO2eP8p
         Ob8lcgkEJQag1jVbNHfpneJMfRNigKpcYTSRrj1vK5Kshvaft6jVwaLyrYaQLFpmQfIr
         p4XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7qYCIGxTGV3obfUCey1+Ub5URZD7jM5bL3LP9a7VGog=;
        b=ue3JOldOWgYSa5wbYlBb+dCEF2QPOOl976ONiLKQEhPxN3bXi+AyPUNI9teLS496vo
         be0VIJxAM87uczy1EwBOJ9DvpfEbB6VMZZIUo4rGd3Wc9rAEOlRsna1+y+jpRawnDcZt
         EIMjE1uaqm7xMnImueII8fpGZUzr7UnYTG4t/jRIsUariIJ2Re0LtuGJkEscWaI97ayA
         okciy0+KQmDTV7lV3kFbc877FllpWu9l09Fn7Zx7f+2ysfpKO52v1MO3kmos/nzR0P2p
         nz2BPODoq57K04qw+t9GtRVhaM1TUV94s3wPNx3xtWuQeKZVVCJiMzmdhW+8xh/xk6mZ
         G3Nw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ivan Vecera <ivecera@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 058/110] net/sched: cls_u32: fix cls_u32 on filter replace
Date: Wed,  7 Mar 2018 11:38:41 -0800
Message-Id: <20180307191047.042343240@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309172826180715?=
X-GMAIL-MSGID: =?utf-8?q?1594309547208123032?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Vecera <ivecera@redhat.com>


[ Upstream commit eb53f7af6f15285e2f6ada97285395343ce9f433 ]

The following sequence is currently broken:

 # tc qdisc add dev foo ingress
 # tc filter replace dev foo protocol all ingress \
   u32 match u8 0 0 action mirred egress mirror dev bar1
 # tc filter replace dev foo protocol all ingress \
   handle 800::800 pref 49152 \
   u32 match u8 0 0 action mirred egress mirror dev bar2
 Error: cls_u32: Key node flags do not match passed flags.
 We have an error talking to the kernel, -1

The error comes from u32_change() when comparing new and
existing flags. The existing ones always contains one of
TCA_CLS_FLAGS_{,NOT}_IN_HW flag depending on offloading state.
These flags cannot be passed from userspace so the condition
(n->flags != flags) in u32_change() always fails.

Fix the condition so the flags TCA_CLS_FLAGS_NOT_IN_HW and
TCA_CLS_FLAGS_IN_HW are not taken into account.

Fixes: 24d3dc6d27ea ("net/sched: cls_u32: Reflect HW offload status")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/cls_u32.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -927,7 +927,8 @@ static int u32_change(struct net *net, s
 		if (TC_U32_KEY(n->handle) == 0)
 			return -EINVAL;
 
-		if (n->flags != flags)
+		if ((n->flags ^ flags) &
+		    ~(TCA_CLS_FLAGS_IN_HW | TCA_CLS_FLAGS_NOT_IN_HW))
 			return -EINVAL;
 
 		new = u32_init_knode(tp, n);
