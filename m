Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELukXoEn/fYAY34BwbFFdVokxcLwqkrlgao//AzVn6p/6h49zgU9m/au+3SdkkHkugKv843a
ARC-Seal: i=1; a=rsa-sha256; t=1521800184; cv=none;
        d=google.com; s=arc-20160816;
        b=NEMNYvmcWX83yrZ6mwIPFf9L5X1kZQKARC8+CRMxdVeoSsP1/97DL12QWnHLrOStod
         5RjxCkNsbk9nh9n/YVfMXeO3Fmau5DyF9hjL9k/AMm9VbJBZ1xel+pNG08k5B0EZBP9V
         VEepa02UIyIG0/JzLdSTkze1iZKONcyxMK04UceGda6m9mdo5w7Vneq67CgY0yS4xOXF
         GLsliYvn0hGnwQjaxU0C702lnJ9sP0OH7C6YONVkho/MWWn+bJDceiFkAaqjSgxih6xO
         Uz0t0aBZjgZWuEL60GEJGRztoVeGa07BL5E0CL0VUV0S3hdA50wQhPOwdNWvu8Pu/uGu
         s2Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=iTmMcQX3UvQKcWNUlRr8CddgbFWzcUhKIGZN1c2EvJc=;
        b=eUi2VxlE7LxMhCBLpFRQ7yWYAuEObDyCfHDZBdVeBAx5LcKsqdIgDSvGpjDIDMMAXh
         8cj8nBrAXzY3qZJ1qWHGRMQ8cpjC9BFSfUnYa/Z9sToAi3cTlxSS9nFiieC+4pjGMdM0
         1Gv8tgK3tH5Ausr/TKW5v7DWAQIJuwFJxJFOKtG41idZeJF4Sd1Ff/wSc10pN5ostDM5
         efk9MZPd7c79gCsElHf0lR820WjpCynpv3vg+54NuxmtUeU0zwqn3QWxPG/uc0oSrsBw
         35qB4kQoIXwUtSEqBDAD0qKxv1zeBT2RB5dybPNXcgl3q/m74AOC6zwuzEKzNRb4sFQm
         Jk0w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 78/97] media: bt8xx: Fix err bt878_probe()
Date: Fri, 23 Mar 2018 10:55:05 +0100
Message-Id: <20180323094201.936884743@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595721938241360348?=
X-GMAIL-MSGID: =?utf-8?q?1595723149633337233?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


[ Upstream commit 45392ff6881dbe56d41ef0b17c2e576065f8ffa1 ]

This is odd to call 'pci_disable_device()' in an error path before a
coresponding successful 'pci_enable_device()'.

Return directly instead.

Fixes: 77e0be12100a ("V4L/DVB (4176): Bug-fix: Fix memory overflow")

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/pci/bt8xx/bt878.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/media/pci/bt8xx/bt878.c
+++ b/drivers/media/pci/bt8xx/bt878.c
@@ -422,8 +422,7 @@ static int bt878_probe(struct pci_dev *d
 	       bt878_num);
 	if (bt878_num >= BT878_MAX) {
 		printk(KERN_ERR "bt878: Too many devices inserted\n");
-		result = -ENOMEM;
-		goto fail0;
+		return -ENOMEM;
 	}
 	if (pci_enable_device(dev))
 		return -EIO;
