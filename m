Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq62HUCM2QLcpjj6eijGCihP/MayGHVK32eDU+Qvk22BeXDUTC2waW+nGFujI8iStnCW7Rw
ARC-Seal: i=1; a=rsa-sha256; t=1526631517; cv=none;
        d=google.com; s=arc-20160816;
        b=KrtpLQKkRpsds30LFCQKGrEWq0QjYsn1SK0WsTG0vhNveq/n5gjWar3zavQKH9MOM2
         TyP1f2NfRTsAoi/bEWkCzoOQEMXp9ovwAMKv/pn2Aap8No7T8ne2/3VsmMqiN3Sl4tlR
         ue86oks0/tp8k1HhTZeVe7+8hJRnVAlpxix9dbUTknlYdo5IBjlO8TeOKlkbwT1EOz8G
         n8TYeIofuutijNxulZsJZkFOqQDph84vZ/GlY6xN53wRr+xEMfn45CZ94DL2HGnFyxKC
         ik9/38MVosS6UqKhovbKz3e/dmVZDByEOl4JlYxqBCmvT04+8TY9EY7OfXt9jIUhwVfj
         xljg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=ktJMDuOhQWGg22sFdN7c8OsSI2t/SE6qkoqEPL/pZZE=;
        b=BoiIeuo4KqsflaYeVaT1+Zwnz1agJ2d2Mxh0DdQxj5AkSM93y48QTOOx43CXt2F+tH
         OK+uadgqgnUPLkKhsiguKUGcjz4P+UAWBe6MpYHXltw3K3lxnLMe2PteI4qmSWRGAZAH
         Hd9xJh1DrHXCd2vrVeZ+9ODCL2dXKAvbWH5wh6PmR3SpVsuUJQBsIRJdCrqHctdRA4ze
         ruAZSkZP/++F3PkngRUVsWBbfRkrlnam9FK70iQrPAwIiW3SUZKNooXyH1OHwOyrGsY4
         ZdAoqYD5NoLo3dYcrwS0ntQ3sNJl6zcU4G9L0eluy6nO9Dhsi4DiNwSKN3lbdzbTq4yE
         HijA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=pHHpCgpi;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=pHHpCgpi;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mohammed Gamal <mgamal@redhat.com>,
	Stephen Hemminger <sthemmin@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 48/55] hv_netvsc: Fix net device attach on older Windows hosts
Date: Fri, 18 May 2018 10:15:44 +0200
Message-Id: <20180518081459.671970578@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789169912233667?=
X-GMAIL-MSGID: =?utf-8?q?1600789169912233667?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mohammed Gamal <mgamal@redhat.com>

[ Upstream commit 55be9f25be1ca5bda75c39808fc77e42691bc07f ]

On older windows hosts the net_device instance is returned to
the caller of rndis_filter_device_add() without having the presence
bit set first. This would cause any subsequent calls to network device
operations (e.g. MTU change, channel change) to fail after the device
is detached once, returning -ENODEV.

Instead of returning the device instabce, we take the exit path where
we call netif_device_attach()

Fixes: 7b2ee50c0cd5 ("hv_netvsc: common detach logic")
Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
Reviewed-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/rndis_filter.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -1282,7 +1282,7 @@ struct netvsc_device *rndis_filter_devic
 		   rndis_device->link_state ? "down" : "up");
 
 	if (net_device->nvsp_version < NVSP_PROTOCOL_VERSION_5)
-		return net_device;
+		goto out;
 
 	rndis_filter_query_link_speed(rndis_device, net_device);
 
