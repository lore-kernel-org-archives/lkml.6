Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv2iiKr702Hq6KR3zPpJB1uv/WofA+OSZ1hLoxereOVwT/EiygU4OhOz/I61PodMXfRYl+1
ARC-Seal: i=1; a=rsa-sha256; t=1520451710; cv=none;
        d=google.com; s=arc-20160816;
        b=x36+nXW6nlVqJBhd9uTijtycY0vVEppfoJKEBFC1anCxi93KUJ83ICa6x35xfE7pe1
         sE8vqFtb//wlYsEBy16BDBEYVCpdQIWU+sZ1Mq0k7ejn+ca8xRbxWKnzkXYjfkkIUvxG
         61u0vBlYTxzR6+7fnaW0qdSEY6gucALu8P4WKVhAzFPhwOAAEMqryjV/kJb+Sg6YiNuv
         8ylK8I5smq1BiZxs/i5L/5pIGftCKWZ6QUTepg3v9Mkt/BCl4YG+4Mk7vgeaSpDD/b/Y
         Bp44DRqkIVek0vLmF14ZMLVwEMx6F57/gxb5DgJn/XtWB7X++0aKkDGFwqDcdExkr2TA
         Rh8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1YzYHNotYC+sPQrEJs+4JJvRkKgN+QHL90fy7Cwrzbo=;
        b=jStRinaWVMx8K/DuSRdwTcrcDxn+xeFDvvAn7jKaV1kkFseciBTGLDqFMQdyEbCb6S
         hnJGGxwsak4S6YMnhVKVB52We6k0mwup/yLeZ91zVXaDQvehv6njmBXIAf37E0Mtod/8
         SnlejKI6O12RwfgnsPFTAJ2DMWRhzH8Yz0SrIXtbmNyaYNio4aeRRosr6CTAEoIdhnlz
         mtQyEJ2k5K3OBFim/vLHG4gKYutlKcZqEN+2Eaal6RoTgwGQYnTX9TiwEuocIM3fl1QN
         EF8ifUnZRO4uK3t7kpMcgTbtuzGdBYNAwH44V+U8u45ly4h5VNXEvW0db4vcAiHqFzV1
         eAlQ==
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
Subject: [PATCH 4.15 063/122] net/sched: cls_u32: fix cls_u32 on filter replace
Date: Wed,  7 Mar 2018 11:37:55 -0800
Message-Id: <20180307191738.432422321@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309172826180715?=
X-GMAIL-MSGID: =?utf-8?q?1594309172826180715?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -928,7 +928,8 @@ static int u32_change(struct net *net, s
 		if (TC_U32_KEY(n->handle) == 0)
 			return -EINVAL;
 
-		if (n->flags != flags)
+		if ((n->flags ^ flags) &
+		    ~(TCA_CLS_FLAGS_IN_HW | TCA_CLS_FLAGS_NOT_IN_HW))
 			return -EINVAL;
 
 		new = u32_init_knode(tp, n);
