Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoaO7olscW3a4yEX1ot/XxXEioYME+n7/njvYuMLTNj7WGT1UGeX8uYIEJu1ijqpSzD7jo+
ARC-Seal: i=1; a=rsa-sha256; t=1527156147; cv=none;
        d=google.com; s=arc-20160816;
        b=YAVPAaw7iBO9MIb2LC0TRwJC5MtaU2ETNFDjA9yD4jUBGRQjsZKnqhsacWvlJMiAs2
         e7PNvVUpACjCzDK1CjvtX8ZFzuSSsfyvmAf1ynjY0TRV+m9036mb0WfN0dd67pwXpquy
         NZE65TR/wfySt99zZ+XA3ljZ8Pmdv6VK6WLGbyh3LpjO5IsMCQZ5JVjemwJi+1dt2z7j
         qz7ndn6P8GV0SuK+SkNm31fkAUuXCxIZWiSlBpRHmsUUH212yuUUOtmSw1DYpEzq2rej
         DS5ObDxc7Ln2r9b2IagPB8J2h8sFG7uFepo9zlFBQzUu70a+MqCbPEnJe57fKwjfTr9o
         xSDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=TvzYsSS4xMB9x75+pBuS5Cs6o/abky/dv7bBSe4xJ6c=;
        b=jx+MM+rFfUz74D9uzOcmvl2+uGTrMGX12yAaqy6vUefFfOaMY0t78ofP4WiE0TBPDl
         auy91EWs+mnP7FFhX67eZ9Hjz1yju1Y34gjoZxXTL9q2XJB0ZdgGBIuc9LidZquXmQQk
         th3OHxbd7cuRMOAsU5PsjXJyUqGFvWQELjil4lzzMFJkU70vHuu/94+IYtXEIyf1ME1X
         ZaC4Anrkq/bnIKMDMpeBowvovBHxKIJbCP5QVWPj+BGYgyHyd7tUDD8ZCLzqoVw+R6Yv
         7vDM/bS9Sm6ZhyoM4on2TXmtyNYMt49roCvn0dvGv9F0ztTVbX73MXsL12qyjWCWL91K
         1s1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=GUXqoB6n;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=GUXqoB6n;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Brad Love <brad@nextdimension.cc>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 080/161] media: lgdt3306a: Fix module count mismatch on usb unplug
Date: Thu, 24 May 2018 11:38:25 +0200
Message-Id: <20180524093028.135291434@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338901910602447?=
X-GMAIL-MSGID: =?utf-8?q?1601339284590574520?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brad Love <brad@nextdimension.cc>

[ Upstream commit 835d66173a38538c072a7c393d02360dcfac8582 ]

When used as an i2c device there is a module usage count mismatch on
removal, preventing the driver from being used thereafter. dvb_attach
increments the usage count so it is properly balanced on removal.

On disconnect of Hauppauge SoloHD/DualHD before:

lsmod | grep lgdt3306a
lgdt3306a              28672  -1
i2c_mux                16384  1 lgdt3306a

On disconnect of Hauppauge SoloHD/DualHD after:

lsmod | grep lgdt3306a
lgdt3306a              28672  0
i2c_mux                16384  1 lgdt3306a

Signed-off-by: Brad Love <brad@nextdimension.cc>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/dvb-frontends/lgdt3306a.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/dvb-frontends/lgdt3306a.c
+++ b/drivers/media/dvb-frontends/lgdt3306a.c
@@ -2169,7 +2169,7 @@ static int lgdt3306a_probe(struct i2c_cl
 			sizeof(struct lgdt3306a_config));
 
 	config->i2c_addr = client->addr;
-	fe = lgdt3306a_attach(config, client->adapter);
+	fe = dvb_attach(lgdt3306a_attach, config, client->adapter);
 	if (fe == NULL) {
 		ret = -ENODEV;
 		goto err_fe;
