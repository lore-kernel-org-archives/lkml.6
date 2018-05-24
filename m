Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoX04u5+QSs2KzhmlxokleqrPrQ06QRLPcBz/iPzEpMgzNAVXG2B5npDJhRV6+tSDJsX/Ce
ARC-Seal: i=1; a=rsa-sha256; t=1527155946; cv=none;
        d=google.com; s=arc-20160816;
        b=Wur7hvT+w/rUfzUhJJJcEJ7vMaZsxOLf2f1vbDB+hcYQZYnsCnYz7T67VNbOWQbTVR
         lD1z8OJRvWGAOR6di+hrB1ykIFgNHKpwqzzi+Z+ef1ByU5T0JzHTkTtIy1kbK/+7nsNy
         Obup4+19pSOZr8nTSNzOAzVXuY3GOtpur69sV+SVxRMbaT96imz51X0lEH6oxesMOh0A
         yBPeX6lnk45rV3h1oRdZ/Iglkc2q9DHsapQviBm94ZdteG8BdZHuwpJRDAmlX+SYb4UG
         M5ILv1PXgeDSLK13VgJZ791tJLR4R9eJ9hAd2tQu6DgNXq/l9+oa8odWP8b+uk2Hsy7q
         1bGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=fT6O2vCKgA2vvgUnwFSewmEL3zqMblHrkbTd7OfLQOw=;
        b=RfyeCLAwVCVkk+hum9Ei3RdNujf8qeVEtbIFO9AEOTPAEWsay/b40zwTh6cB0chJjU
         LxAZLy+HfD7ISILNFsK8JukqcAu0eXS7JfyVmZcufIDpoMlxzFwAByrm4A+3mpZRBpiI
         1ij7NMl19767wZX7P+vygJSA89pPnL3Q0A0pryfdUMfxuTuyLsr+5tLDi1jfVyGgKH8u
         wFqte06Yz87b/438QMQJzmmIrIo+oP1+uchvwNAhPDnk3YDoweBT/njH0X47QbAQgIqB
         SheYodDztYOSrPKATMnpArljv2HepIK7BInHZgPxND5sSnuh9TpT3rbAIzEHHuprYsHn
         yqPA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=zZtxkpAr;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=zZtxkpAr;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Saeed Mahameed <saeedm@mellanox.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Israel Rukshin <israelr@mellanox.com>,
	kbuild test robot <lkp@intel.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 001/161] net/mlx5: Fix build break when CONFIG_SMP=n
Date: Thu, 24 May 2018 11:37:06 +0200
Message-Id: <20180524093018.518558261@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601339073820003217?=
X-GMAIL-MSGID: =?utf-8?q?1601339073820003217?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Saeed Mahameed <saeedm@mellanox.com>

commit e3ca34880652250f524022ad89e516f8ba9a805b upstream.

Avoid using the kernel's irq_descriptor and return IRQ vector affinity
directly from the driver.

This fixes the following build break when CONFIG_SMP=n

include/linux/mlx5/driver.h: In function ‘mlx5_get_vector_affinity_hint’:
include/linux/mlx5/driver.h:1299:13: error:
        ‘struct irq_desc’ has no member named ‘affinity_hint’

Fixes: 6082d9c9c94a ("net/mlx5: Fix mlx5_get_vector_affinity function")
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
CC: Randy Dunlap <rdunlap@infradead.org>
CC: Guenter Roeck <linux@roeck-us.net>
CC: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Israel Rukshin <israelr@mellanox.com>
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/mlx5/driver.h |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1271,17 +1271,7 @@ enum {
 static inline const struct cpumask *
 mlx5_get_vector_affinity_hint(struct mlx5_core_dev *dev, int vector)
 {
-	struct irq_desc *desc;
-	unsigned int irq;
-	int eqn;
-	int err;
-
-	err = mlx5_vector2eqn(dev, vector, &eqn, &irq);
-	if (err)
-		return NULL;
-
-	desc = irq_to_desc(irq);
-	return desc->affinity_hint;
+	return dev->priv.irq_info[vector].mask;
 }
 
 #endif /* MLX5_DRIVER_H */
