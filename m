Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtoSF/sezcFqFtORJ4n4vTtwQTDdznrE3T5ta9lxnZOEOjCzBvd4TMYkKqju7C0mwbp7yFT
ARC-Seal: i=1; a=rsa-sha256; t=1520641345; cv=none;
        d=google.com; s=arc-20160816;
        b=Mo9VRSk0xS53jyGo6rZ2UZ5BkDdusiaI+yf1j3FYlG19i7p2cJ/4twL9027xh7HPrR
         Xfw43gj/DyUKlJIzXRZqyPTLFdokbL5sxQNJuy022+7tBWlUVu8/8wU8rWU5Fg2+lRHr
         hMW4r0SJkWHhJz8uiN6Fr+nVXQ8/4O0JelzkHa6i9bI5yji8iiOp0x4aMpro0UMSY/df
         ufe33j+CRBlqC00UJr/t/BoToHgMKfnLTgN3YfCQ0GBfjEG0OW6IYxwkSzZok2gTZT6G
         wAyt6enSVjOeCDUcbwuB1d98O45dzW5+UyT1SU0y2c2N2MTVT7eW39nd78SJR76lcn5o
         IgnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2XUXyGXYFlXujtH0RE/lWs5RHKsv1biPl/tYP0iScfo=;
        b=AwUweWeLCXzhDKB0tg3vWVMlIDjqtiw0NEKv0jOU/LD4XdX/UkR4LWCt5ylMLqL7GT
         ig19D5Te8iY/9JNLJOUsRrrtQwOrwWFaO6mfIskmOzCVsmLFIzopLSnRgfLIllPVskMu
         NGmqMlyMJeKIl8GMlNhoflxt/14vi6Ix5ZeEGa87Bz3iD6eoiYZXqdWOLHPpWgyHEEj9
         ipb3ggmcQc/o3iU1AfRTA+RrGC0vYPV7oOIb2GwMc6MfD+Xj9b5APDDj07GdYwpREj8o
         Ivc2SmZDMqhgkucnpQZKYOxC89DCDCkfrLauOIncW+OKIqsv5viE163pJUL3pqn37i9c
         MRBg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ursula Braun <ubraun@linux.vnet.ibm.com>,
	Julian Wiedmann <jwi@linux.vnet.ibm.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 49/65] s390/qeth: fix underestimated count of buffer elements
Date: Fri,  9 Mar 2018 16:18:49 -0800
Message-Id: <20180310001828.887685873@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594508019181671675?=
X-GMAIL-MSGID: =?utf-8?q?1594508019181671675?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ursula Braun <ubraun@linux.vnet.ibm.com>


[ Upstream commit 89271c65edd599207dd982007900506283c90ae3 ]

For a memory range/skb where the last byte falls onto a page boundary
(ie. 'end' is of the form xxx...xxx001), the PFN_UP() part of the
calculation currently doesn't round up to the next PFN due to an
off-by-one error.
Thus qeth believes that the skb occupies one page less than it
actually does, and may select a IO buffer that doesn't have enough spare
buffer elements to fit all of the skb's data.
HW detects this as a malformed buffer descriptor, and raises an
exception which then triggers device recovery.

Fixes: 2863c61334aa ("qeth: refactor calculation of SBALE count")
Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_core.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -849,7 +849,7 @@ struct qeth_trap_id {
  */
 static inline int qeth_get_elements_for_range(addr_t start, addr_t end)
 {
-	return PFN_UP(end - 1) - PFN_DOWN(start);
+	return PFN_UP(end) - PFN_DOWN(start);
 }
 
 static inline int qeth_get_micros(void)
