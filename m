Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuy+r8d0xSGGqV7Ku+ut3J6XE4/43bnaai69zMM6MvQMH7X/uLOA3K8SwAqVQH0PosMGj3X
ARC-Seal: i=1; a=rsa-sha256; t=1520451784; cv=none;
        d=google.com; s=arc-20160816;
        b=Vj0C6A6ADLuWZCzpz7biwTyRBPpJvDvH/SzE4P+BUGJukD0Qiygn6426vFtfiB26Hx
         Za9qz7PEbKID2CpJNpXFeJhMRqczrkAR8pT6E3b5VgjSQtJCLnHNB7e/gewjhSS+1q83
         5RNazUZ09tt1XwXOXH7nuvKGPc9EASgb68WjA8INKH7CudNx/IAj6+2rtzb2gb/iUSol
         lqLm7IvppG/oz8C4cJ8Gagcr4avGT+ieCgOtCg8F4XHbIRr3Uy43Sn5EQyJBIMq1wVOY
         YNNs2B6byzhTzC+XKkXbalViRKKmETXrKQW9OvggJCkVmEi1Yepo6b8EOH/ZlLC2wWlE
         RVeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xCpbHE7kAw8lioPoVAHkIrLJJtI4RIjhcXfMQP4YIMY=;
        b=IBRv4sSzKW7UVe2Wjhda9scLRgSJGSvZlxOGEQw/cvYPYY47HQhrHm+NvIQWMxHiOa
         3WYtQ2L2I5TtJQ/1ev4lppfDwqQ5x0n9e5lQs5Dtnh6Of++4xCicGjvgPTkr92FL9lyV
         /K6fz/dI4EwynxFKvNPgaLJMHoq/kizbviPnRdxyQq6Z2SVzFVladZirNS+E3Wem0Ego
         zLsJcVKMbBSm41aaY3OQL5DlIczPCnIEcV1jrkAVqb1Vq4eIyweKTRiGA767VcyfVMYR
         GMzzO1xswkpYPdl7qaFUvlb+5tYCp/6ofW5thP5vZKHOv9YTnkqfpNnlAmp7KKNwdzJW
         DvCA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Julian Wiedmann <jwi@linux.vnet.ibm.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 093/122] Revert "s390/qeth: fix using of ref counter for rxip addresses"
Date: Wed,  7 Mar 2018 11:38:25 -0800
Message-Id: <20180307191742.824868342@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309251068453401?=
X-GMAIL-MSGID: =?utf-8?q?1594309251068453401?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>


[ Upstream commit 4964c66fd49b2e2342da35358f2ff74614bcbaee ]

This reverts commit cb816192d986f7596009dedcf2201fe2e5bc2aa7.

The issue this attempted to fix never actually occurs.
l3_add_rxip() checks (via l3_ip_from_hash()) if the requested address
was previously added to the card. If so, it returns -EEXIST and doesn't
call l3_add_ip().
As a result, the "address exists" path in l3_add_ip() is never taken
for rxip addresses, and this patch had no effect.

Fixes: cb816192d986 ("s390/qeth: fix using of ref counter for rxip addresses")
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_l3_main.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -250,8 +250,7 @@ int qeth_l3_delete_ip(struct qeth_card *
 		return -ENOENT;
 
 	addr->ref_counter--;
-	if (addr->ref_counter > 0 && (addr->type == QETH_IP_TYPE_NORMAL ||
-				      addr->type == QETH_IP_TYPE_RXIP))
+	if (addr->type == QETH_IP_TYPE_NORMAL && addr->ref_counter > 0)
 		return rc;
 	if (addr->in_progress)
 		return -EINPROGRESS;
@@ -329,9 +328,8 @@ int qeth_l3_add_ip(struct qeth_card *car
 			kfree(addr);
 		}
 	} else {
-		if (addr->type == QETH_IP_TYPE_NORMAL ||
-		    addr->type == QETH_IP_TYPE_RXIP)
-			addr->ref_counter++;
+			if (addr->type == QETH_IP_TYPE_NORMAL)
+				addr->ref_counter++;
 	}
 
 	return rc;
