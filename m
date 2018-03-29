Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+tboOwuJN4jes24NLZ6rIBxjJNGU8FPcRgtCdWsQG2g9egHINEtckMKqqH6bQmXy9jG4bk
ARC-Seal: i=1; a=rsa-sha256; t=1522346602; cv=none;
        d=google.com; s=arc-20160816;
        b=nNkqpYRh+H8+HS4FxGn/UJONHGytNBrIk2bM7VS1LwcQgz9RJnUPtO2od+mYlHE/+w
         Zd7w00rQ2sjOvn33F72EHpRbHMXE3tJY/Baef42lnglQpOJfHY5Kcab/sH+7t5aTn3G1
         sqdI+9+D1GBZrxsUduATcuWJ52/IamrDsnbL7WDA+HFJUl1GJk2aat/xCg6hvQmpyVQi
         XMv32NZVTudT6VkhKNDCf33VrmpbDpKnj8VgOiuCYDmy8n9tU64Q0PJWolJsAbykLK1l
         h/3j8PFs4abTMweZxtBuem6e5UzOaNiv8bG5RnaRXmhq3ng3WDSx2mYNtwkD3DMKHJF+
         /WOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9PVnsUQnW+mMHNiKSm//pIdYyc8j+G1atxt4OReDQhM=;
        b=sbmyYeG83P22Zdu7IdNUEHLRcxWe/H1Wfoagi/Jj2/jZcGmn7V9t2I1O3w8hTCeIO7
         VkHyxxOK4EsWR80o0MgcSt65QSKn9W7qriAi89XpvnfLGQeY3+e19t5cW3BJi/mWqm/R
         G3GJMyAPBds149goHGo2uXB/fjVSDUKH61PlnuSf2IgUgU/q36oo0BMmgvHFhXaXtBSC
         NjXwhgkwTH/gOKfr+BidRhYNxC9Jf17QShh+xYqEkx4+/2OL0bTKZVwAUylgzY+7iJq+
         fly91VwwwHik8Mk4yW2GMHuofJwNHjIUO4Cl3MHtVfig7ouCVV3TfICd3q9KpulMtLG/
         Lk2Q==
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
Subject: [PATCH 4.15 41/47] net/iucv: Free memory obtained by kzalloc
Date: Thu, 29 Mar 2018 20:00:22 +0200
Message-Id: <20180329175732.929516413@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296110854357073?=
X-GMAIL-MSGID: =?utf-8?q?1596296110854357073?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
