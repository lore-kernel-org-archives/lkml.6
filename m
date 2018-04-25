Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49q89aU44dP/ZQqIN1QDocZvBJCg0fd5Z5YfuCatnvySe20zdmBR952HggthAjyyi4lEOgc
ARC-Seal: i=1; a=rsa-sha256; t=1524652929; cv=none;
        d=google.com; s=arc-20160816;
        b=NjMIoGjxKeqLhwJIw44IcebPX1+ADu4weASl0/D2kMAheWClsw0GtTY1v/G9/LLC1Q
         HFnx+ibl0LMJlxkXamsm3HVRYRpYwWPWa7WSvIGIpkGe+MVQs3BeLiuCgohw8utVytHt
         Z0YIkylED5ufbhQxq14WjtOCsTHZBFb6xPzMHYK3SGxFgqgVelzEGZJ285D1oAMfpGWc
         r80Jv9yxH4+a5v20dTZ35NiEL4kp1+/o4ibET635qp/ZDuzFnBnhRCUB1Q1z9m2u6Zv8
         L7nAKtxHcQWenvIytz8UdjPBDp6zuGPbOXzAwINPLYob3pIibj4mjQNfaRQU/M4KLjkf
         1pQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=00wPiMhpP52CDYQa9NPW/bYWZfL4n5fnl73yioSg1as=;
        b=XOCsUJKxcl+NvHYGsoGeMa9TDT0/JIbT0Vhfr0Tu4XN+aipj3RPBCa6/MkIzVUp//E
         hRyySgHM3EpDCtCP8NDQnV67T4O4nYqVXc3D8u4ODrzH4hGnCcxB9k9LJ/Rwi/Gxv8R1
         IVEFin7170xkjRoI9DzDCWL48tSsndjKTrRmPObvHjqiul2FwvvH5mNWm7rORK09hJzM
         WRXswwhP2oqy7RkAPiVCSGpGockmeGP/J9Mee8UqGqXH4BAZS/HjlHpMqyihBfElL0WD
         1TFw4repXM5E+qxyff2Gz+CVFqSNFgueBwpQrHGjCMA0+YCyfhS4HJhnxm/sx0SLSa3Y
         VOCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alex Estrin <alex.estrin@intel.com>,
	Dennis Dalessandro <dennis.dalessandro@intel.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 122/183] IB/ipoib: Fix for potential no-carrier state
Date: Wed, 25 Apr 2018 12:35:42 +0200
Message-Id: <20180425103247.334573052@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714469834197851?=
X-GMAIL-MSGID: =?utf-8?q?1598714469834197851?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Estrin <alex.estrin@intel.com>


[ Upstream commit 1029361084d18cc270f64dfd39529fafa10cfe01 ]

On reboot SM can program port pkey table before ipoib registered its
event handler, which could result in missing pkey event and leave root
interface with initial pkey value from index 0.

Since OPA port starts with invalid pkey in index 0, root interface will
fail to initialize and stay down with no-carrier flag.

For IB ipoib interface may end up with pkey different from value
opensm put in pkey table idx 0, resulting in connectivity issues
(different mcast groups, for example).

Close the window by calling event handler after registration
to make sure ipoib pkey is in sync with port pkey table.

Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Alex Estrin <alex.estrin@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -2273,6 +2273,9 @@ static struct net_device *ipoib_add_port
 			      priv->ca, ipoib_event);
 	ib_register_event_handler(&priv->event_handler);
 
+	/* call event handler to ensure pkey in sync */
+	queue_work(ipoib_workqueue, &priv->flush_heavy);
+
 	result = register_netdev(priv->dev);
 	if (result) {
 		printk(KERN_WARNING "%s: couldn't register ipoib port %d; error %d\n",
