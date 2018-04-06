Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+jeTDioIaa3HcptfNKH/yuVixDityXtFX0K/Ofah6k/r3neudDrtZr2y9w/4sxhQOeV6Jd
ARC-Seal: i=1; a=rsa-sha256; t=1523021153; cv=none;
        d=google.com; s=arc-20160816;
        b=qwuTc1KQsBjpZ8Ukj4o2DPrvtkAtn9+5hjyqEAXV2WFBxob4c8q9JSQ6087CxGg9oy
         JBwit1te7EEoplHMVcmdgXNifeHSVycVFj2xOxmh2uB3dKb3bQIadzI49b9IfcG2cLRN
         zoUJ9YsqlW0siF/zc/XR3IYvYZooqcZy15tuFUsl+RI17i6rMCSuBhNDUNT+hSgy4bdN
         Qfy+4HGSZb7GwqA7WCsXWKOJr+fWSWoZJdihydvBcwMYCl3qK7S5PmLlB1rTJ3DcsELw
         egELgDsy4liBEyVTspiMVi5oZeeOFsAqIuOZIPa8h4HWrN60uaZwPyNHj5I02qz8aiiM
         sZ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LNd5Me8FbR9koSLbwUwjNipJxnUvx+MiDy4W7WmST/4=;
        b=bl3yvDruKoSXbZnZV8WyeyGtQ2841D1V4u2N1BRu6AsxCYJY9+rn3Dr2gRNnbSnBQ/
         ZloWB6Rr1QgKmrJYzz8DHKLqiPJetICyLuGiLcYwCbdgg7HGnzxWxSXn6hZzw+FyxOMB
         Cag99JOk2BC3WfvVVdLQCSvrSeLfQiHqqOE8pzjlEpQRjBYGAQJ/qJWBJepbwppgpimx
         C8vK0fLXx5NzWeLDQbDjqS1/PM2qZeGKigUu6kQrkE8qUPTSUWbqorCJgQKcaF6AEB+U
         JORbtqbcOGHIDikCVmvif+ILUBOlw3pYlxeW0msz0MNjyZgGN8JyE6dbGC2FXSBL2T7x
         OJpg==
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
Subject: [PATCH 3.18 27/93] net/iucv: Free memory obtained by kzalloc
Date: Fri,  6 Apr 2018 15:22:56 +0200
Message-Id: <20180406084226.140435325@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003428977377855?=
X-GMAIL-MSGID: =?utf-8?q?1597003428977377855?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2383,9 +2383,11 @@ static int afiucv_iucv_init(void)
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
