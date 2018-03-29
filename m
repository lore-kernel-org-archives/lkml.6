Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+ELKrkgI6dwCHOYfH47aWL16xcZlNzgHA37uJnrdig0DQWEjcMobyjYc1xi5WuXJPRUu18
ARC-Seal: i=1; a=rsa-sha256; t=1522346764; cv=none;
        d=google.com; s=arc-20160816;
        b=A6/0SmpcLpJSO4+I3gRPFOc4gghoo8Et+0u0Q5DBUn0LFmvyQrEm19fcPWCEhYTvQG
         bRT2ek3Nt9u3PIaUYGbnVg8kSR5dlzm2TqK7ENjDcgVwDvkAVgfYJQs2a656Gb76IwAo
         vpBn6rGxBRX3l61YdzbU/+bOveR2PhOcNVp6d+BBAkZ4aDb3J4cHDEgxHS9MjE/CSSHf
         p2Gf+f9++vZ6EL68sznAy17g3+OmYAkriaVWKN8m0irgl6auHKuet+bq4roUPxCiLPXD
         SF0TFZNLII5HreTgdv5pCHBesSrLq+Tv9pZmEU3qJgwYbeemvO15zQJ7PuO7KP0lctkj
         56Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fU4rMPOybr77mPWNkZ/u6+4Ts1AHK6hMzdCi1o3iwrw=;
        b=r8ZSoVtyS3CYqLJ/zn9H7SxBZHUpmnBxk3CJ/cUgHIigUFVtvOnYmWMPt2/4bMKcEP
         FOfP6hkSRr5DE568WA5sl+19jQ8e4vTWSpEvwlONScLB+c1vby1VZnN2MzncwyvjxUv2
         CO5kB9b3iWjHqsTnB9yhIb9ih5kANKLFgWLEbRaCHWr/dij1ACnaD3geskWlyXMosE/y
         MjIiii4xgDbzgvJKFL4zh0w94dpF1EZHUc5pWF9aUTtqEdmMOamYllZUaaqe6bePwc9v
         RZHhJWmMRwE3f6jmpSTVXwxUtbnFJnuWNtk8R30gvYmSW//oEWG/d79yqCxbsovJ8zSU
         SZPg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arvind Yadav <arvind.yadav.cs@gmail.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Ursula Braun <ursula.braun@de.ibm.com>,
	Julian Wiedmann <jwi@linux.vnet.ibm.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 28/43] net/iucv: Free memory obtained by kzalloc
Date: Thu, 29 Mar 2018 20:00:23 +0200
Message-Id: <20180329175733.075810114@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175730.190353692@linuxfoundation.org>
References: <20180329175730.190353692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296110854357073?=
X-GMAIL-MSGID: =?utf-8?q?1596296280353147580?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arvind Yadav <arvind.yadav.cs@gmail.com>


[ Upstream commit fa6a91e9b907231d2e38ea5ed89c537b3525df3d ]

Free memory by calling put_device(), if afiucv_iucv_init is not
successful.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Ursula Braun <ursula.braun@de.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/iucv/af_iucv.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -2433,9 +2433,11 @@ static int afiucv_iucv_init(void)
 	af_iucv_dev->driver = &af_iucv_driver;
 	err = device_register(af_iucv_dev);
 	if (err)
-		goto out_driver;
+		goto out_iucv_dev;
 	return 0;
 
+out_iucv_dev:
+	put_device(af_iucv_dev);
 out_driver:
 	driver_unregister(&af_iucv_driver);
 out_iucv:
