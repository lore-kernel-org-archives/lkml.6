Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuv3KMsj0UMBOU6FbwMnce7web5+njBJhCSa/KWmi3gbbjJ9ZD5gvorR1UOIqOcxVTO7D4k
ARC-Seal: i=1; a=rsa-sha256; t=1521800186; cv=none;
        d=google.com; s=arc-20160816;
        b=nerV8cePjVeRGP1HwuEWHnpSUmmWycA49nqWc1wSW2QYIoewHenH7mH1WR5k+JcruG
         ldkpn0+YRI4EYuQOTF4IIhv2WZMFGekMVi81Y0huaTFwdL2KNxEIOid3noDLdFRMx6S5
         etbLuilSr7stMQStNfzwjjtqqayQEF2PpqxBw4TakED6N+sD1Awspn/zaiL4GBR2QFzu
         p5OZx+KnyfGVh0GpCtGb0OKswUXjV3Bu1idYhaWG9HXLzYKMfx6Ee8xXLw60GsXQkScM
         246MNW9FCpmqKP79dyHUSKYsH0rE70kIPklDhG3GtDegMdUsBMO7mPO2sit5/3Xzgktn
         i8eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aztDldpL6JCgpNplZhzlecAi6iVWtJmMZ7gtSe47eJc=;
        b=rxYj4F/nl1B3S84xb51XV7oObKan3TaZQF5RQeQXttJBVnAY784TjUnMTVUAlh5psC
         BWizVxfFZDJIAilzqqMOk4jG1J59afkLOUBD1auHwkNG1WuySlT+Hv82hOULUQFy7Wo3
         6rrqbFSPscxHh6t8RIms/+OoywbfCa7YYYCO0LVKfspZNBlnFiK+RpWg/jhA+NDZEc9u
         SzmIq1VA4BGhOghGDN3Ih9Vgk+qP536mxPSbYzlrz0qWPUo0QZAKoOnhiCS6V6zsJw1V
         SZDeEzhzQbFvZKp42nKfvwyIS2jcem3R6Bkf6OJFW8yf9POoHCYSSb3oNSohTcYdjiF8
         AJfg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ron Economos <w6rz@comcast.net>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 79/97] media: [RESEND] media: dvb-frontends: Add delay to Si2168 restart
Date: Fri, 23 Mar 2018 10:55:06 +0100
Message-Id: <20180323094201.979111490@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595721946835267818?=
X-GMAIL-MSGID: =?utf-8?q?1595723152343246327?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ron Economos <w6rz@comcast.net>


[ Upstream commit 380a6c86457573aa42d27ae11e025eb25941a0b7 ]

On faster CPUs a delay is required after the resume command and the restart command. Without the delay, the restart command often returns -EREMOTEIO and the Si2168 does not restart.

Note that this patch fixes the same issue as https://patchwork.linuxtv.org/patch/44304/, but I believe my udelay() fix addresses the actual problem.

Signed-off-by: Ron Economos <w6rz@comcast.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/dvb-frontends/si2168.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/media/dvb-frontends/si2168.c
+++ b/drivers/media/dvb-frontends/si2168.c
@@ -14,6 +14,8 @@
  *    GNU General Public License for more details.
  */
 
+#include <linux/delay.h>
+
 #include "si2168_priv.h"
 
 static const struct dvb_frontend_ops si2168_ops;
@@ -420,6 +422,7 @@ static int si2168_init(struct dvb_fronte
 		if (ret)
 			goto err;
 
+		udelay(100);
 		memcpy(cmd.args, "\x85", 1);
 		cmd.wlen = 1;
 		cmd.rlen = 1;
