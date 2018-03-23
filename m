Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuJNB3/x9HkGiRsKvzYvbHLeZ1hFT8HfMiKfBAova6mY1hE7Ayhlsos818bVKAvcTBdTouP
ARC-Seal: i=1; a=rsa-sha256; t=1521800389; cv=none;
        d=google.com; s=arc-20160816;
        b=oJAwkhw5zRdm/RYUoY4XXgQrt9dFa/1fox/xXbxwtRu6cpCh3+7ydmr1EUCKfbqahu
         Cerbf/a8w8LkBproQbxYscoECoSZvO6wd9A6MV1gW1aWLfeZTaA/QCzWzMReiIhwpMkg
         UOGnRf/7hBYPm6PKoLAoAW2+6aDqbbARIDUEwFEQTNzjiNyCpi0Spsf7c+VbNO5u8508
         uX7soC8I7akcTv3rJPY5XUZK9HCh2EMgkmo0AQTKcb2my+tMynM0JCop6rfYTNR2zRfz
         Apy1AR2pUCW8vIH01txo3mUZpFvrjUkAftGaqmvMZWl8RWgNzwI5N+qE7YqYZef1bEs1
         ahMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GMn5FUd8eKkfvWoEzoEw7fyFmJzxiaxrRKgzmjE5mTs=;
        b=zImCaed5JJKsWzTJOrbl+qtU+1h0cbifoHZbab1v5ovyfOH1QamRVdGIy+YRoFb3yz
         UxayFIfWwJTMDkMArrJq7JD9/PcicDZIp3+yoP0/tlEKik9G/3VySZGmRsICpTjCNlAP
         0fR7dxMKwGerat2zIO0EN4TBUVrgocG0Jk/SOGk86ju05Qn3aRZahc6sQ8NB82GRnBX3
         hydOUL2r0jecHSZK1ni4FuatIUY8wjGGY73fu/nbmfwuTtukKAzDkiHH/ikrTi7EilFN
         3x62pK7Q+yAfjlFUo9HUmER4pe6GRK4NZST6DolP9fUYfYJ46KS5AcNtSgcJRY82rQUL
         VcXg==
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
Subject: [PATCH 3.18 38/47] media: bt8xx: Fix err bt878_probe()
Date: Fri, 23 Mar 2018 10:55:29 +0100
Message-Id: <20180323094249.740798325@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595721938241360348?=
X-GMAIL-MSGID: =?utf-8?q?1595723365427163526?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -425,8 +425,7 @@ static int bt878_probe(struct pci_dev *d
 	       bt878_num);
 	if (bt878_num >= BT878_MAX) {
 		printk(KERN_ERR "bt878: Too many devices inserted\n");
-		result = -ENOMEM;
-		goto fail0;
+		return -ENOMEM;
 	}
 	if (pci_enable_device(dev))
 		return -EIO;
