Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+ckPr2fXe2g7OgulCJIBDGO7u6DKqwyADs+Mxal+ydV2Hqa0JnKlQHGsn0k1UzRk9ItRcb
ARC-Seal: i=1; a=rsa-sha256; t=1522346885; cv=none;
        d=google.com; s=arc-20160816;
        b=GJQDDzp0Rq3uIzxcV1//ZK7qD5mj/Pba7JJezQPxXGcv6roV8sunBLoweM/F9Y4qxK
         DkYHsbyNJ/GrOq+oBFY23EHfgk820+QDALfLA4OL7E+cP0oFETzM/30z2MnOyzV79tfI
         UnnwXTqkrLAOqNNHto0tN+pQwGEKgBral5oiX3IZlU+eu/XjhpUIa1g4wZLCB3+b1NtJ
         UzPi8TZOPo0kyNzqoGPYHfwvl/aTcusQC6Y82tsYI+aylGAYvD6vs3mTIETQvfHT9pFF
         febFqB/cUkaHLjG6FbjAbSxlQkzKhMc63nQ7Np4t47tClU3ZNE1kcAVXDB0QS/zc+FaL
         xwbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0VPd7G0psDavAOjcccOGPKk8DI9V+bnthQRtoB7+QZE=;
        b=rArfCxobLJnJe0OZcqm3/YmZfVBDTlhT4a9rI6XT4/cfJdWxxs+mUXhUF37JI1wiQj
         N2GRiwK5a6szvrnMfqBfu972nHXTL3zQVOKsCUb9Ac2qe9iDwtRyPDBltKwz7DgFRnaP
         qtChHjecGtN8RaqIPEaYmCUcc/H5cQHxJZ2eT3hg4d6ijKLzE+fSNKltVUcR6d+am2z9
         ENZvWxmkPnvwW8mWOAphu0ySzJBttKuA2wOPOe/ouSs3O0XZm4Ki8dq7gwVfQ4OgEGTV
         Tes7xZTfSvEoqZeTC77wmrSFv8ibB1jsJ4f64K9zYpHt0lLz1ZauxYbMaiDNVxnRqatY
         tVVA==
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
Subject: [PATCH 4.4 09/20] net/iucv: Free memory obtained by kzalloc
Date: Thu, 29 Mar 2018 20:00:45 +0200
Message-Id: <20180329175742.274916677@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175741.886181131@linuxfoundation.org>
References: <20180329175741.886181131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296110854357073?=
X-GMAIL-MSGID: =?utf-8?q?1596296407942449484?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2381,9 +2381,11 @@ static int afiucv_iucv_init(void)
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
