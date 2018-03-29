Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/+8xJ4mJZaI1yb74pzTjXAXzB12UWltbAySRGQLpXjeYs3991KgqsBEakcfi9UgKVar0mg
ARC-Seal: i=1; a=rsa-sha256; t=1522346899; cv=none;
        d=google.com; s=arc-20160816;
        b=vEb4eaep+QQCRewGM09oEAVuic/dV9zmTCL1u76W3Y6+/pNBeQ1sfkD2Q/Tgqrqbdf
         B9LQHg8JDBs9VewEMh1NdOFVEFIgincQ+GkoK7+adQ3czrMtOdNKO/y6d+aOBs+W/nwe
         HtmQoeUMvKjoQ1BBXfe6nf0dOH+p/UjSrFqtCGXSuKQl29Q6oGi/y+ihKWy2XDX6b8Xi
         oaV61bbyo+Q8U2KDoe3N433+YB88fEOmUaKYT3Ob4MHtCEIXt2JijcyICxWW2il6MpxZ
         xyqy4PNI0Yz5luBeCD47k3RtfLhkYz4GbOigEHeeg4a+6U5CiCcNKBu4jaintqOpa0FJ
         6sRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=luTAwdwU/L1HqhHJFfq0wLKUt0dZTCTybiQHS4bxGDE=;
        b=dg85aMprKka6zWskDTA65FqwL/UnlbDeiFM4xqIu/+bNHCtCGdZQldqq+g+zEXVxSz
         jIAwQ/ZiaFN8KYQez8B8/N1xyVtjgvEdajIT3LBe8deWmsXq+RyDFNM1GKbrLD1/OT7g
         SPHunBTGIr1zHjfxCx1j39ZBqdxyZzeTadv0DXUukg6ZCrVXoNQ5YK+Q6tguhq7a5lxl
         QI6L5UslkqMP81Vy9Y7kTi6WvGHzc4o4LKeB/TyDzz7OZeU7qPLCR8tU9/RedqjPozuz
         tXymEAQi/e9g3K9YTO1hH4Q2Idfb/Pd2uMBZFCOyWWSeyh+a0dOw3OHoNI77mToojL8F
         Hk3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Julian Wiedmann <jwi@linux.vnet.ibm.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 17/20] s390/qeth: on channel error, reject further cmd requests
Date: Thu, 29 Mar 2018 20:00:53 +0200
Message-Id: <20180329175742.761700707@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175741.886181131@linuxfoundation.org>
References: <20180329175741.886181131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296072058867998?=
X-GMAIL-MSGID: =?utf-8?q?1596296422936056053?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>


[ Upstream commit a6c3d93963e4b333c764fde69802c3ea9eaa9d5c ]

When the IRQ handler determines that one of the cmd IO channels has
failed and schedules recovery, block any further cmd requests from
being submitted. The request would inevitably stall, and prevent the
recovery from making progress until the request times out.

This sort of error was observed after Live Guest Relocation, where
the pending IO on the READ channel intentionally gets terminated to
kick-start recovery. Simultaneously the guest executed SIOCETHTOOL,
triggering qeth to issue a QUERY CARD INFO command. The command
then stalled in the inoperabel WRITE channel.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_core_main.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1166,6 +1166,7 @@ static void qeth_irq(struct ccw_device *
 		}
 		rc = qeth_get_problem(cdev, irb);
 		if (rc) {
+			card->read_or_write_problem = 1;
 			qeth_clear_ipacmd_list(card);
 			qeth_schedule_recovery(card);
 			goto out;
