Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvdvY2Y8aB4WdAZ1FH36ZhuJo0WwUs2liAQNgakBjDo5LgR1cAfyAHGxrVdz5Ty74qSvVif
ARC-Seal: i=1; a=rsa-sha256; t=1520451766; cv=none;
        d=google.com; s=arc-20160816;
        b=Tcv/DrtYfFzFRZf5wc1zSUn/TZeFPpCIIHHGpuIWJqk2PrJv7uI1SrQA+5bWAKtpL1
         8W0P4mK0DMrjnAmMGdVhTcKh+v4A+KzKs0WJFeF9iD1RXuszlcW2IjtMlHGu6ZFrAbwC
         sZWLzwBmhZzXulSk1IlgXzncsSN4eckVpGtldbIUeGFQS6ZsJkjHS6eo2U5uF6wqv10j
         mUrzpaSFdVsdkIw89QhhcwnPEs3j+FEOflJteDajzbsJQxMK1g/1mACrMPIQ2VwFRUbh
         t1K0ZjeRlKMSD+XkzgzotrZJpiubNbbIEfDUDp8OPdUXZ264dr1Lxef22gHuSRFDm55Z
         KOew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KIEXMspndCZT9vhkdurr5K9vrhrDa7odVFaRiSh8TVk=;
        b=hTmXqphSF//+pRAS+BdCEpnIHmmz2Z+ZJoFdpIJc4rF7xHYJ4afzOOiW65W/WhorHY
         64fvZ8D4h+AD+8swawMnf8Nw9FMJCbXZpZpZUZrM7gGTwddqdeZJIXrX9xJ/zb3HLVjC
         mYBNbewoALE2pGj0f72Xu3dSf7c/P8jIoAOthLg6D8p3OrFX34xF++UBQjlVngxGl17z
         EZz4N/b53mEeG0RblJVHsnqUUT6Yb8okND7y1/YRck6Zwf7FLFsuWJFfcz6uiuOB/8dd
         xCZBJ6gw9oRogPIabBLaNmBm92FXmtkP8HYADdYifv4a7tee8XuabnQpY97mhzy8drug
         MLLg==
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
Subject: [PATCH 4.15 088/122] s390/qeth: fix underestimated count of buffer elements
Date: Wed,  7 Mar 2018 11:38:20 -0800
Message-Id: <20180307191742.109099514@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309232041553292?=
X-GMAIL-MSGID: =?utf-8?q?1594309232041553292?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -836,7 +836,7 @@ struct qeth_trap_id {
  */
 static inline int qeth_get_elements_for_range(addr_t start, addr_t end)
 {
-	return PFN_UP(end - 1) - PFN_DOWN(start);
+	return PFN_UP(end) - PFN_DOWN(start);
 }
 
 static inline int qeth_get_micros(void)
