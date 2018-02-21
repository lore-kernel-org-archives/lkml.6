Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754403AbeBUMsb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 07:48:31 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:33793 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751745AbeBUMs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 07:48:27 -0500
From: Rolf Evers-Fischer <embedded24@evers-fischer.de>
To: kishon@ti.com
Cc: lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>,
        Rolf Evers-Fischer <embedded24@evers-fischer.de>
Subject: [PATCH 1/2] pci: endpoint: Free func_name after last usage
Date: Wed, 21 Feb 2018 13:47:06 +0100
Message-Id: <20180221124707.26308-2-embedded24@evers-fischer.de>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124707.26308-1-embedded24@evers-fischer.de>
References: <20180221124707.26308-1-embedded24@evers-fischer.de>
X-Provags-ID: V03:K0:N+ZaH66EdDk7JSSnfxx4X+djMeq5qrjlAzVFu8KOPKZC/FEyp+N
 ytm2cH7YWELTDGN6eopJdbHaPg35sU8j6ZHZjvNUzfo470QnfxUsnsqDtUk3Jdl6Y20xLsu
 DjnmtenyjlvAw9Nzbkg/cf+aqUoR+0Exthm3A/u2wSIsMNKrJv+d5Zs4+vu5OmSKKjTiiVt
 Q0UY9su6ZF9X04dK8ZZDw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bJ+k+z9gjVI=:jjUhmOSYmkeY6ZEJzTUgDS
 X89mBQog1C583QvHJFexPhOD0CmzeVZFikqt3rbc93CzIkDE35Nup+odQd8e9pztJzg/avZAp
 ZFdEZBKkzjOkboEkfzgwHBrMmRAjiSzdbWx483jV222oNh3XgW6exGSkVlas7QbeN6oHYpTrv
 oOWndM+CXDbI4co/6ICxxI+zhjJSZI9xU3xF3zHwYTmAAnH4Qx8w/+RwdBtLf930XfNiEBZUs
 Hm3J+/8r75xSRPCHGEBXGrgLvFvRbyPC/mjr+GbgBE5XDZfHm1psh2Jk9ldGdsUTC9a9je3BX
 s4KCd1rcqXmu27y4lZHqICfk4iatiAcypKqD7BGJ95VI7pk9iuTNwASLPevDg1JFf4tznuvvn
 q5w2F88A8QlCGKjp+OMrme9jX/Jcx0nlZubtgKa0qdg0jVwqp8PHrQ7HNT0MQ76ygc8XCPgBt
 znH+JvzCA9h+VZiNyj/Gn2fQwDjMl90q+OlOGidC92/njewA7P56VzKNz7QYqZy+GvhamRPdb
 L/w14wNJ+S0heaF16olyAEu1vkYQGeJ6NySOtEqAsFikelJEW5MRWe1W4H4k4ENxkq7mkwHXl
 vo5o489cDRW+vvR1JxLBPT38KdXp7M4ZoiSxwpsqRFO7FKNKDUuYZGxzEWI/7/w6tZ6G1lnRV
 8RxXIMyxHNXywfSBVvs53hnZ/DZGZjRcLaQAO5U43TRJIbascs2fw/Z7Gfp3l7xHZSOnAPUk6
 n5toqTRO7iJphgI7pVM3yZ3aUr5XTkqdnD4JOw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>

This commit decreases the number of jump labels and ensures
that the next commit doesn't increase the number of occurrences
of 'kfree(func_name)'.

Change-Id: I0d1b6fd652395b85f82b11c43bf9b7db512854d1
Signed-off-by: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
Signed-off-by: Rolf Evers-Fischer <embedded24@evers-fischer.de>
---
 drivers/pci/endpoint/pci-epf-core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 766ce1dca2ec..23d0e128d1a5 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -220,9 +220,10 @@ struct pci_epf *pci_epf_create(const char *name)
 	*buf = '\0';
 
 	epf->name = kstrdup(func_name, GFP_KERNEL);
+	kfree(func_name);
 	if (!epf->name) {
 		ret = -ENOMEM;
-		goto free_func_name;
+		goto free_epf;
 	}
 
 	dev = &epf->dev;
@@ -238,16 +239,12 @@ struct pci_epf *pci_epf_create(const char *name)
 	if (ret)
 		goto put_dev;
 
-	kfree(func_name);
 	return epf;
 
 put_dev:
 	put_device(dev);
 	kfree(epf->name);
 
-free_func_name:
-	kfree(func_name);
-
 free_epf:
 	kfree(epf);
 
-- 
2.16.2
