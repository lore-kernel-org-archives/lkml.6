Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49RmKEsPcnOam9gkwtYLVuofQHCAnGXU8861kcks6KVmDJuh3CctHXDkuJTkoy27N34TGEr
ARC-Seal: i=1; a=rsa-sha256; t=1523980857; cv=none;
        d=google.com; s=arc-20160816;
        b=C2x0ewO4SrHGCAk+IkzIv160hIdOnV/SFPr6MEop74WfRRrddxRNFrJjwgaujcLKbV
         6rMiJdgTIJwRGZYTxR70WonGaX3xMdaiDfRh5RftYO10dHTMZXREq1gAus5rJK/w7xgY
         KPxTuI7VO8cF+P7t08UO6YQ6mhq+lo73jaogYUMuRTfj1WcG8Fe8AuDyWi+D9tM1kCbU
         60/tZKr8jbb2oMlhMgxammV7ol2mtkdOhhB8kpPlzhtny5L1aHJ0KwuUP/kHj6wdGqVp
         RWFC/uC1Opy2EDoPA4tU5DIjZi/li6k3wFgUV8noCYZNXpjMNG9/yPKucZulqUv+wnor
         +Y1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=d7SFz7bmi7l+PJTs5FHigWgCeTKWG6D7L8Lz1IWU7yM=;
        b=iTYrAhmmxYi0WCE2jLMxiygJBIhLg0ay/x4uSPGTy3MvwDwVdsEnNM/OsAM5LCglIQ
         Pw3L6rW+j3paVx6IO7yB572a638tT7gYCEz6KiNrhsWw3TdQ5vMiaBEf3iCKC7/AgiHR
         5fZfkMAKDNTFEkWAwHKjxmqG8M9/SFLzehdAfVuv4HpemTzn1q8IMpQNz8lETVwThe7s
         BJf3487Eek77bp40aAe+bbxXzqVy13N4CT5Im8fGSqywNUMr+XInCjcnA85jL6XkfB8a
         9zRN3Fg20wWXkks3lvoazCksNNoEoY6UL2KdoRhTXtKvMqslks9NvtmvyGL1nu8wICab
         fWXA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Auger <eric.auger@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 08/68] vhost: Fix vhost_copy_to_user()
Date: Tue, 17 Apr 2018 17:57:21 +0200
Message-Id: <20180417155749.679643795@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009751810796107?=
X-GMAIL-MSGID: =?utf-8?q?1598009751810796107?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Auger <eric.auger@redhat.com>


[ Upstream commit 7ced6c98c7ab7a1f6743931e28671b833af79b1e ]

vhost_copy_to_user is used to copy vring used elements to userspace.
We should use VHOST_ADDR_USED instead of VHOST_ADDR_DESC.

Fixes: f88949138058 ("vhost: introduce O(1) vq metadata cache")
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vhost/vhost.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -744,7 +744,7 @@ static int vhost_copy_to_user(struct vho
 		struct iov_iter t;
 		void __user *uaddr = vhost_vq_meta_fetch(vq,
 				     (u64)(uintptr_t)to, size,
-				     VHOST_ADDR_DESC);
+				     VHOST_ADDR_USED);
 
 		if (uaddr)
 			return __copy_to_user(uaddr, from, size);
