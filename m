Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48/97JqPqLLlp8r1CjALqHnU4lvz8794VI6a/YcpfRU+TmbBi+PSBgo/L2LnIYZguqz6pYg
ARC-Seal: i=1; a=rsa-sha256; t=1523473351; cv=none;
        d=google.com; s=arc-20160816;
        b=v1y4KE8HDkQpDp16EIobWNnyvjGgVnUC1CgLRgKn+AaABWFThwQOVSlNN6hzkYwnCN
         3wxh2Zd9rO8OifiOme0iOqBJKmkqRTigaBZGrygeZYuB4tX0UrvzWda3ZcRX6KubPDQC
         K5ANUvP6GogePouBb0A2TajlJzrt7wBfRYK/2VCiIt3spMfHuVkGni1YmUdpAsf3OOqz
         UGDuRnJzgYG8yFifxF6CctRMbO+parI1U6b+3NU/D4G+7KP5NXix5it9kRSSyIRisEx/
         LGy9nUEemB0pLKTrSEJHNdm8iz70ywS2csCm/EXR+15a3MNrcR6+zUhX2s6Lr8ntuFh8
         uC+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ES0OLoyVX01xlPQc8iT23uegxpe3O7Mu5UgGigxT9Xo=;
        b=DeK7oKI4G2yhEdGphUKs5sK/klEOX922RY34f0b9iDpY/hp26RXNsD5q4Aoyrn625a
         0VbfxMnpDx6zlon3X5rGw2mbgzKmlmLd5ER3uPK4tyMbnxQ6KRtoRdvRgK5t9XsoSudF
         nsAP9a8/LCVOrxH56F181yF5Z+TK0seXMqfyVRvDyfvUNS6BZ1HyowwwsqYAyCPaTLy1
         jY98mq8cy0ECCgaSSM4K8U53lfYd0TVmab1Jz38jcRwdkJZ46OzHab1HL5gj3w/VhQA3
         oRRcvnblKKi95oRBmb82H4se/DJKF0cWZr4YWSvKZnup/ddNB+z15AXDmOpnZXBLZIOB
         23Og==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Raju Rangoju <rajur@chelsio.com>,
	Steve Wise <swise@opengridcomputing.com>,
	Doug Ledford <dledford@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 182/310] RDMA/iw_cxgb4: Avoid touch after free error in ARP failure handlers
Date: Wed, 11 Apr 2018 20:35:21 +0200
Message-Id: <20180411183630.431115360@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477593649411535?=
X-GMAIL-MSGID: =?utf-8?q?1597477593649411535?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Raju Rangoju <rajur@chelsio.com>


[ Upstream commit 1dad0ebeea1cd890b8892523f736916e245b0aef ]

The patch 761e19a504af (RDMA/iw_cxgb4: Handle return value of
c4iw_ofld_send() in abort_arp_failure()) from May 6, 2016
leads to the following static checker warning:
	drivers/infiniband/hw/cxgb4/cm.c:575 abort_arp_failure()
	warn: passing freed memory 'skb'

Also fixes skb leak when l2t resolution fails

Fixes: 761e19a504afa55 (RDMA/iw_cxgb4: Handle return value of
c4iw_ofld_send() in abort_arp_failure())
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Raju Rangoju <rajur@chelsio.com>
Reviewed-by: Steve Wise <swise@opengridcomputing.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/cxgb4/cm.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -488,6 +488,7 @@ static int _put_ep_safe(struct c4iw_dev
 
 	ep = *((struct c4iw_ep **)(skb->cb + 2 * sizeof(void *)));
 	release_ep_resources(ep);
+	kfree_skb(skb);
 	return 0;
 }
 
@@ -498,6 +499,7 @@ static int _put_pass_ep_safe(struct c4iw
 	ep = *((struct c4iw_ep **)(skb->cb + 2 * sizeof(void *)));
 	c4iw_put_ep(&ep->parent_ep->com);
 	release_ep_resources(ep);
+	kfree_skb(skb);
 	return 0;
 }
 
@@ -569,11 +571,13 @@ static void abort_arp_failure(void *hand
 
 	PDBG("%s rdev %p\n", __func__, rdev);
 	req->cmd = CPL_ABORT_NO_RST;
+	skb_get(skb);
 	ret = c4iw_ofld_send(rdev, skb);
 	if (ret) {
 		__state_set(&ep->com, DEAD);
 		queue_arp_failure_cpl(ep, skb, FAKE_CPL_PUT_EP_SAFE);
-	}
+	} else
+		kfree_skb(skb);
 }
 
 static int send_flowc(struct c4iw_ep *ep)
