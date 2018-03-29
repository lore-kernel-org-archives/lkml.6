Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48wo+XdV1w+1Il/tukbEB4VhYSRRkrxUddrv6SlntBdF7EcG/cn3uB6lmy31azWFg8vJuUi
ARC-Seal: i=1; a=rsa-sha256; t=1522346819; cv=none;
        d=google.com; s=arc-20160816;
        b=tsX8U1L5+QzfetKFcerNlhegVDb2Y8UYp5McsFn+qo0C27j9lQkeyZjk8MhU3RIPp6
         xf0uK3kBB4W58OZmbJpACDh46ovmmg4/wlYm6YpS7vaViU5dmeZM93F9OxilhgLfRCCW
         UxCcXMRnDwnhdjULPl/OIV4+5Hdbgd5spSWHyE0nInCOBVjH27ME0+P4ps7xNpkPeFmN
         JoW/8UADmcI5oTEPZ/w76BKGVdSNUQBeQzPyAADyl5k81Ze3S625C5OrzG++bfw5n55G
         9QaVazieIo3loY6zAmBoFZ+cISRG+LHfhE4xUfIIoIYGiiXwzynL3XBqN3OFwW9jISP0
         Ge0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ke26jk+YKOcS0petkgQKrKoIzlAx+a4W6NDIFhJyq7E=;
        b=dYzZH5fwJ2p1Ha+snttVLURG2ENr/7pI7GAmXTvICbnjZZd3xvJuf6O3Da075LCM8Q
         V5giPcEdW7cdphCBOllVUdCwcHCCy11gl0C/Ic7hij9VHDkouFL5nGJJCL4l9agFsf2a
         mF9hEpm/PGvyc06dDGGyp31kM7SpsHEm2P5n9hi2E/N18AKOeSoyeuqd27/SNKLjeLaQ
         xxl3c508yLloRTU64H+sLV+s5cXJxNspjA8IL3L/9htgYlC+bTcWDnW6fAQApkz4ooaW
         PdH/LOxZXHRNZlCbOoqjbgOCmLn1ESrKKFJQtRLBrCj4l1/WCYpa+5tTBiuL9kezzCFI
         rJAw==
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
Subject: [PATCH 4.9 25/28] s390/qeth: on channel error, reject further cmd requests
Date: Thu, 29 Mar 2018 20:00:44 +0200
Message-Id: <20180329175736.359377015@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175733.447823703@linuxfoundation.org>
References: <20180329175733.447823703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296072058867998?=
X-GMAIL-MSGID: =?utf-8?q?1596296338857627189?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1171,6 +1171,7 @@ static void qeth_irq(struct ccw_device *
 		}
 		rc = qeth_get_problem(cdev, irb);
 		if (rc) {
+			card->read_or_write_problem = 1;
 			qeth_clear_ipacmd_list(card);
 			qeth_schedule_recovery(card);
 			goto out;
