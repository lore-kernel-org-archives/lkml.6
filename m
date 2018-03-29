Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/ItnO36uBCRrVrwX4+C0pPjWFbh1h193SNCUyB/zYclgXBEjQLkFvrtddUKY0PLm9rWk+W
ARC-Seal: i=1; a=rsa-sha256; t=1522346792; cv=none;
        d=google.com; s=arc-20160816;
        b=J/ZuqF6Iz+G8o+TzP1pIz0H1YJ/bX+OolHD0hIva50dhwxezgiQEkUEsiILPouta5Y
         ZnWDUheHKVnjPZDEs2/xjxmKxU6+ZWDJsLQtVbYZ8tQj+p7rTgBUsuw0LmPx+GeDnj8d
         GsQtKIouEloC4rYtJabSaHcEkl/PyaZbeBavXwaoNnRGCmvUkyiz8JcK4GrUKmou4G27
         rkLLdQH7Uqh/B76ml5glHNys8y9EoIr49AiaN+KuQV0KNPAWluJ3B1dpZgbZLXNH3sjk
         FiP/yXq4phK3z4AAX8p+RdKk5g9QKecalv3HQ3IEiQRFcMZAzhrNsfReZSf2dEYWS91x
         Yv1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UERu3bm50BSOpSvT9OvkKYSzl3OJghHb0oaYF04LGLY=;
        b=Zdx0yx31+PZL2u71GlQKaXmKVz9yqao02iw61kD8+H46V8HkV34AD0JRFwVp/vAkqK
         CcJnimEs5cuoe3OgcwGk7m+sL4C3mGds95y3fHTdoGe2TTbsS0u/3EFGrwr76UWP/725
         O+P3AyCVZOPAeFoEEG41HnsQn26qNiCY3WTzRvOVIo+dCCcfLiLNCVkdo94js2dIROe0
         qNS9nXSz3eRYLo3BZ04NyNFRgoqmLJ3+I31EA8Fw4MDm3ID/cNhHSbK0Ni5X/nZC5ygd
         uHWVLENME13ZbXo/pcloS1SlVjqNW77DFXeqVRL/SqD67EG5hFGJ31D0yvr/BwTJsWfG
         83uw==
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
Subject: [PATCH 4.9 16/28] net/iucv: Free memory obtained by kzalloc
Date: Thu, 29 Mar 2018 20:00:35 +0200
Message-Id: <20180329175735.287436755@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175733.447823703@linuxfoundation.org>
References: <20180329175733.447823703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296110854357073?=
X-GMAIL-MSGID: =?utf-8?q?1596296310063604243?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2418,9 +2418,11 @@ static int afiucv_iucv_init(void)
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
