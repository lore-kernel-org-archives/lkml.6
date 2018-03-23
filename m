Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvdEplJDq9VhwCJ0qBfsPdBRTbx2UUFcYVwUfDf+9sO5UKct/uYx7xjPpz9LrOZ3rFrq3BN
ARC-Seal: i=1; a=rsa-sha256; t=1521800394; cv=none;
        d=google.com; s=arc-20160816;
        b=xbP1zUsRpf4IqGjACU8H/Qf1ZZ5W+FDD/pcHRfdeozYVtmRA0Qp+ji1tyxROV04zgc
         fz/U3kQtltsMel9Xv6CkTHF//hyEKFMJI0S0aXHDLlYppNYiJubaFbHxKS6hvChdYqIk
         X/if4DEmoCbCaLELnEbTGOswBMd8fv25JI9/ZRL8GkS9FJ/XS8wJ7RQZWfGvPkx3OXJ+
         kjMS8e9YPM++g6jc2OtH8snXs1kuwQfh71bvVjz1BM1frCJXXu16EF3ZWe6GqIX6rTjI
         6/BIuO1O25Z/UrYZqFceK5RWHIZt2IIXf3bHRs2mSyBhvCI6oC/oMQRCDjsBAvZzvPXw
         naiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EVM510W4nY9KHTZIBKgOX2d3Cw8OG3g5HAzVx/mWTqI=;
        b=u9irPg4sGmpvf3UtxqLZ4NwrZ4etrHOuC80DJIILFua7MaNme3lX6xhE/yuXMB050b
         4rm7larMjgBEYDepio5JkyAAgVv2/ecPZpJeRvtV6I91R/lC3mPE0oAta4cgUnkO8kgW
         IeqQZyISPCtYTLK5VxQ+z5atNAX4yNxDOg0or3L8NNrn9ywQZ2p6c//vO7A4hLCc8Kg8
         k1imDVBR4BEWAAUuCQIh5TlC+zIjXOpj3TXFV9ZLaaq0ororlVRmFKtuitZEQbGE5Fl0
         jE35XQ8p8QRpk2t3usELCOLM5p/dVe7nOf4u/2V8qp40oYXJAh4jfVf2JcdnXv2NWoJ2
         Ts5A==
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
Subject: [PATCH 3.18 39/47] media: [RESEND] media: dvb-frontends: Add delay to Si2168 restart
Date: Fri, 23 Mar 2018 10:55:30 +0100
Message-Id: <20180323094249.789901624@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595721946835267818?=
X-GMAIL-MSGID: =?utf-8?q?1595723370552066309?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -380,6 +382,7 @@ static int si2168_init(struct dvb_fronte
 		if (ret)
 			goto err;
 
+		udelay(100);
 		memcpy(cmd.args, "\x85", 1);
 		cmd.wlen = 1;
 		cmd.rlen = 1;
