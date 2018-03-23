Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsademnAhSAWgDeDwpAshWjLV5STPLeSrgSaC91DMz8i4c/hcTI6kHhUIOn+UMU5F60n5HI
ARC-Seal: i=1; a=rsa-sha256; t=1521800192; cv=none;
        d=google.com; s=arc-20160816;
        b=ZJy/kGN+sCl5alNCgvVtfoDxMaU5nlUE2rEGWRcPePrvH+8C0nuOUB9dI2BVrQo6vu
         5QhXg87CtZEqy5CIfp4iIGNeLwvkuDwU0fXxn018o+DfWu6xEMPjFjYc3kpKEQhuNlTX
         +MS9O/CJMwdZMsu748FaRO7v3o7gQXAgruzhGQpDH2hSObeHp/eNdMafMItQWA2NFXYQ
         wcRSmBGXykn8Hjfa5YeeFfMx9G2b4LrgPDoF2itXAU2ywoZqgqjPLr6NqbpgzKgIxHoM
         wvnfXFVirQDA7VXpScDR1mNbYwzCgodLugU+hqjbm1mMJsQPFwIdWx9R02HFT2I02fqI
         GbCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ejGYLbkaR4FJk4Piy32I4pGbPohNdyyD53xXAFvAf8U=;
        b=ATePZjQyxidPKhTnbgu4vBO9z/jALJneK2XoMf+jRuHJEeW9mxYuqbBdU7XrQeweOH
         j7bAauTXyYWk+MiOxFh/iJSV8rxuSqZuPC9B/f6rKJsBf5PpC1Ghz0IPDPAPHf3Y9IfQ
         mjlJCsqkJOeqiIN0I8yExg+4BB/qoc9wbXdZn2InG4XxPWusWjZmrS//HvFvKjbxyHfI
         0gCOWEIFosYX+Z7VEM06KgfdNNESI52UsSS5/HR/FCBYiCcxooDKBe0RAp7P/jPB7K/t
         5KdSW0I8250rew6IBXYcC8JOnHVDut5z5ZsB6P3DKj6Yxn6G9XxjbCZCNXcJVnD1IUVj
         8vDw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shawn Nematbakhsh <shawnn@chromium.org>,
	Brian Norris <briannorris@chromium.org>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	Benson Leung <bleung@chromium.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 81/97] platform/chrome: Use proper protocol transfer function
Date: Fri, 23 Mar 2018 10:55:08 +0100
Message-Id: <20180323094202.082457097@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595721924296657461?=
X-GMAIL-MSGID: =?utf-8?q?1595723158662797117?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shawn Nematbakhsh <shawnn@chromium.org>


[ Upstream commit d48b8c58c57f6edbe2965f0a5f62c5cf9593ca96 ]

pkt_xfer should be used for protocol v3, and cmd_xfer otherwise. We had
one instance of these functions correct, but not the second, fall-back
case. We use the fall-back only when the first command returns an
IN_PROGRESS status, which is only used on some EC firmwares where we
don't want to constantly poll the bus, but instead back off and
sleep/retry for a little while.

Fixes: 2c7589af3c4d ("mfd: cros_ec: add proto v3 skeleton")
Signed-off-by: Shawn Nematbakhsh <shawnn@chromium.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/chrome/cros_ec_proto.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -59,12 +59,14 @@ static int send_command(struct cros_ec_d
 			struct cros_ec_command *msg)
 {
 	int ret;
+	int (*xfer_fxn)(struct cros_ec_device *ec, struct cros_ec_command *msg);
 
 	if (ec_dev->proto_version > 2)
-		ret = ec_dev->pkt_xfer(ec_dev, msg);
+		xfer_fxn = ec_dev->pkt_xfer;
 	else
-		ret = ec_dev->cmd_xfer(ec_dev, msg);
+		xfer_fxn = ec_dev->cmd_xfer;
 
+	ret = (*xfer_fxn)(ec_dev, msg);
 	if (msg->result == EC_RES_IN_PROGRESS) {
 		int i;
 		struct cros_ec_command *status_msg;
@@ -87,7 +89,7 @@ static int send_command(struct cros_ec_d
 		for (i = 0; i < EC_COMMAND_RETRIES; i++) {
 			usleep_range(10000, 11000);
 
-			ret = ec_dev->cmd_xfer(ec_dev, status_msg);
+			ret = (*xfer_fxn)(ec_dev, status_msg);
 			if (ret < 0)
 				break;
 
