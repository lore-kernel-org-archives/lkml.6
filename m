Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+1rbz5flFiYV+MRLMfebuDJC7awr/zg8Ku0LkitroM3FUcCG5KmQV/zAt0uJcLYwTtDuwe
ARC-Seal: i=1; a=rsa-sha256; t=1522346565; cv=none;
        d=google.com; s=arc-20160816;
        b=G4PaIziq9srY6GvSXnGxZByp+CgdMQf01tMtkOPk8Q8TwlVEm9YlT4lZCqQhMQGltb
         f3PVglwTQY0oHz/PSSU5vQp+ys1Z5+8T9f8CUbIl2rDJxUJhB95siHo+0+htMwJKMNyN
         cOhosjxLHUJOZW4CX3wvzwHs78U/lrHmJeKbzAmtwI2RhQJqhSOcLStr/ehYyxmOJN9z
         x6GhGjf17OtKjCScD7DznFnZf8KzSMDLpH4OMMXC8Cz9ByFAIB6zIDn7tBkDXEmvDodZ
         zWxyn4yt6Nr7U7mPs+DA3Ea+ktIVKi++A9nPdK5VK/C2D/0tWC3DupEtpbO41kW5Ptlf
         yRgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=44XucoFIP0PfoXu2JJjK2wXhbzT2r7BXJjRX3O/ah9k=;
        b=wRIRK9ip4i/oor8/tEGeo23SdcyC7dz6NkNqv6OYvyOwxiz22ZRUOnnjHE46gpPiwy
         v8+HRCZ7y8zotXLpuz2IlJ99t7WnGhHbiU8tg1Rvilc8T5t28AT1Uq8+5QMqPWtyy6nj
         PLyxPlkiLdp3hO2048oo8SpimI0XoyQg8yEz0uSjgFBihEpYcVq9NAmfdzVaSIj1XWRx
         B3oyfeWASTv21BjqW2HAHaBiccQOta2fte3oV32gutvL3EOa6Y8JRVM6wsvLY9Mk9AcS
         MsCepxEfR4URa1agTxg4IUx696BYDTfjNkG8Pi79L5l0ThQ0z05PyD7M20ACX+qS+6PR
         t85A==
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
Subject: [PATCH 4.15 29/47] s390/qeth: on channel error, reject further cmd requests
Date: Thu, 29 Mar 2018 20:00:10 +0200
Message-Id: <20180329175731.565401652@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296072058867998?=
X-GMAIL-MSGID: =?utf-8?q?1596296072058867998?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1175,6 +1175,7 @@ static void qeth_irq(struct ccw_device *
 		}
 		rc = qeth_get_problem(cdev, irb);
 		if (rc) {
+			card->read_or_write_problem = 1;
 			qeth_clear_ipacmd_list(card);
 			qeth_schedule_recovery(card);
 			goto out;
